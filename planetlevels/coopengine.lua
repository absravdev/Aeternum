local Player = require("others/player")
local PlayerBullets = require("bullets/playerbullets")
local Enemy1 = require("enemies/enemy1")
local Enemy2 = require("enemies/enemy2")
local Enemy3 = require("enemies/enemy3")
local Enemy4 = require("enemies/enemy4")
local Enemy5 = require("enemies/enemy5")
local Enemy6 = require("enemies/enemy6")
local Star = require("spatialobjects/star")
local Meteorite = require("spatialobjects/meteorite")
local Collisions = require("others/collisions")
local Powers = require("others/powers")
local Data = require("others/data")
local Coop = require("network/coop")

local E2B = require("bullets/enemy2bullets")
local E3B = require("bullets/enemy3bullets")
local E5B = require("bullets/enemy5bullets")
local E6B = require("bullets/enemy6bullets")
local enemyBulletArr = { [2] = E2B, [3] = E3B, [5] = E5B, [6] = E6B }

local EnemyClass = { Enemy1, Enemy2, Enemy3, Enemy4, Enemy5, Enemy6 }
local shooter    = { [2] = true, [3] = true, [5] = true, [6] = true }

local Engine = {}

local backgrounds = {}
for i = 1, 15 do backgrounds[i] = love.graphics.newImage("sprites/backgroundlvl" .. i .. ".png") end

local enemySprites = {}
local enemyBulletSprite = {}
for p = 1, 5 do
    enemySprites[p] = {}
    for k = 1, 6 do
        enemySprites[p][k] = love.graphics.newImage("sprites/enemy/planet" .. p .. "enemy" .. k .. ".png")
    end
    enemyBulletSprite[p] = love.graphics.newImage("sprites/planet" .. p .. "enemybullet.png")
end

local n, planet, zone, lvlData
local players = {}
local powers1, powers2
local ctrl = {}
local enemies = {}
local active = {}
local star, meteorite, playerbullets = {}, {}, {}
local netEnemyBullets = {}
local sendTimer = 0
local savedGlobal, globalName

local function clearArray(a) for i = #a, 1, -1 do a[i] = nil end end
local function emptyIfNil(a) return a or {} end

local function readLocalInput(p)
    local mx, my = love.mouse.getPosition()
    return {
        up = love.keyboard.isDown("w"), down = love.keyboard.isDown("s"),
        left = love.keyboard.isDown("a"), right = love.keyboard.isDown("d"),
        aim = math.atan2(p.y - my, p.x - mx) + math.pi,
        shoot = love.mouse.isDown(1), gun = love.mouse.isDown(2),
        shield = love.keyboard.isDown("e"), bomb = love.keyboard.isDown("space"),
    }
end

local function readTestInput(p)
    local aim = p.aim or 0
    return {
        up = love.keyboard.isDown("up"), down = love.keyboard.isDown("down"),
        left = love.keyboard.isDown("left"), right = love.keyboard.isDown("right"),
        aim = aim, shoot = true, gun = false, shield = false, bomb = false,
    }
end

local function plyState(p) return { x = p.x, y = p.y, a = p.aim, s = p.shieldActive, g = p.gunActive, b = p.bombActive } end

local function buildSnapshot(p1, p2)
    local snap = { p1 = plyState(p1), p2 = plyState(p2),
                   hp = Data.player.lifepoints, dk = Data.player.deadgameenemies,
                   e = {}, eb = {}, pb = {} }

    for k = 1, 6 do
        if active[k] then
            local arr = {}
            for i, z in ipairs(enemies[k]) do arr[i] = { z.x, z.y } end
            snap.e[#snap.e + 1] = { k = k, z = arr }
        end
    end

    for i, b in ipairs(playerbullets) do snap.pb[i] = { b.x, b.y, b.direction } end

    for _, k in ipairs({ 2, 3, 5, 6 }) do
        if active[k] then
            local arr = enemyBulletArr[k]
            local out = {}
            for i, b in ipairs(arr) do out[i] = { b.x, b.y, b.angle } end
            snap.eb[#snap.eb + 1] = { k = k, b = out }
        end
    end
    snap.st = {}
    for i, s in ipairs(star) do snap.st[i] = { s.x, s.y, s.direction } end
    snap.mt = {}
    for i, m in ipairs(meteorite) do snap.mt[i] = { m.x, m.y, m.radius, m.drawTimer } end
    if powers2 then
        snap.pw = { b = powers2.bombCooldown, s = powers2.shieldCooldown, g = powers2.gunCooldown }
    end
    return snap
end

local function applyPlayer(p, s)
    p.x, p.y, p.aim = s.x, s.y, s.a
    p.shieldActive, p.gunActive, p.bombActive = s.s, s.g, s.b
end

local function applySnapshot(snap, p1, p2)
    applyPlayer(p1, snap.p1); applyPlayer(p2, snap.p2)
    for k = 1, 6 do enemies[k] = {} end
    if snap.e then
        for _, grp in ipairs(snap.e) do
            local arr = {}
            for i, z in ipairs(grp.z) do arr[i] = { x = z[1], y = z[2], dead = false } end
            enemies[grp.k] = arr
        end
    end
    playerbullets = {}
    if snap.pb then
        for i, b in ipairs(snap.pb) do playerbullets[i] = { x = b[1], y = b[2], direction = b[3], dead = false, radio = 10 } end
    end
    netEnemyBullets = {}
    if snap.eb then
        for _, grp in ipairs(snap.eb) do
            local arr = {}
            for i, b in ipairs(grp.b) do arr[i] = { x = b[1], y = b[2], angle = b[3] } end
            netEnemyBullets[grp.k] = arr
        end
    end
    star = {}
    if snap.st then
        for i, s in ipairs(snap.st) do star[i] = { x = s[1], y = s[2], direction = s[3], dead = false } end
    end
    meteorite = {}
    if snap.mt then
        for i, m in ipairs(snap.mt) do meteorite[i] = { x = m[1], y = m[2], radius = m[3], drawTimer = m[4], dead = false } end
    end
    if snap.pw and powers2 then
        powers2.bombCooldown   = snap.pw.b
        powers2.shieldCooldown = snap.pw.s
        powers2.gunCooldown    = snap.pw.g
    end
    Data.player.lifepoints = snap.hp
    Data.player.deadgameenemies = snap.dk
end

local function snapshotLoadout()
    return { Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl,
             Data.speedmovement.lvl, Data.speedbullet.lvl, Data.player.lvl }
end
local function applyLoadout(lo)
    Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl = lo.shield, lo.gun, lo.bomb
    Data.firerate.lvl, Data.speedmovement.lvl, Data.speedbullet.lvl = lo.firerate, lo.speedmovement, lo.speedbullet
    Data.player.lvl = lo.playerlvl or Data.player.lvl
end
local function restoreLoadout(srest)
    Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl, Data.speedmovement.lvl, Data.speedbullet.lvl, Data.player.lvl =
        srest[1], srest[2], srest[3], srest[4], srest[5], srest[6], srest[7]
end

local function initPlayers()
    local CoopLauncher = require("network/cooplauncher")
    powers1 = Powers.new(Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl)
    local p1 = Player.new(Data.speedmovement.lvl)
    local p2
    local lo = (Coop.role == "host") and CoopLauncher.getClientLoadout() or nil
    if lo then
        local srest = snapshotLoadout()
        applyLoadout(lo)
        powers2 = Powers.new(Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl)
        p2 = Player.new(Data.speedmovement.lvl)
        restoreLoadout(srest)
    else
        powers2 = Powers.new(Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl)
        p2 = Player.new(Data.speedmovement.lvl)
    end
    p1.x = love.graphics.getWidth() / 2 - 80
    p2.x = love.graphics.getWidth() / 2 + 80
    players = { p1, p2 }
end

function Engine.begin(levelNumber)
    n = levelNumber
    planet = math.ceil(n / 3)
    zone   = ((n - 1) % 3) + 1
    lvlData = Data["lvl" .. n]

    active = {}
    for k = 1, 6 do active[k] = (lvlData["enemy" .. k] ~= nil) end

    ctrl, enemies = {}, {}
    for k = 1, 6 do
        enemies[k] = {}
        if active[k] then
            ctrl[k] = EnemyClass[k].new(lvlData["enemy" .. k].maxTime)
        end
    end
    star, meteorite, playerbullets = {}, {}, {}
    netEnemyBullets = {}
    sendTimer = 0
    clearArray(E2B); clearArray(E3B); clearArray(E5B); clearArray(E6B)

    initPlayers()

    globalName  = "Planet" .. planet .. "level" .. zone
    savedGlobal = _G[globalName]
    _G[globalName] = Engine.angleProvider

    Data.currentLevel = Engine.coopLevel
end

function Engine.finish()
    if globalName then
        _G[globalName] = savedGlobal
        globalName, savedGlobal = nil, nil
    end
end

local function hostUpdate(dt, p1, p2)
    local CoopLauncher = require("network/cooplauncher")
    local in1 = readLocalInput(p1)
    local in2 = (Coop.role == "host") and CoopLauncher.remoteInput or readTestInput(p2)

    if Data.player.lifepoints <= 0 or Data.player.deadgameenemies >= lvlData.maxKills then
        local completed = Data.player.deadgameenemies >= lvlData.maxKills
        local panel
        if completed then
            lvlData.completed = true

            panel = (n >= 15) and "gameovermenu" or "levelcompletedmenu"
        else
            panel = "gameovermenu"
        end
        if Coop.role == "host" then
            CoopLauncher.endLevel(panel)
        else
            Engine.finish()
            Data.currentState = panel
        end
        return
    end

    p1:update(dt, in1); p2:update(dt, in2)

    if active[1] then ctrl[1]:update(enemies[1], lvlData.enemy1.speed, dt) end
    if active[2] then ctrl[2]:update(enemies[2], p1, playerbullets, lvlData.enemy2.speed, lvlData.enemy2.fireRate, lvlData.enemy2.bulletSpeed, dt) end
    if active[3] then ctrl[3]:update(enemies[3], p1, playerbullets, lvlData.enemy3.speed, lvlData.enemy3.fireRate, lvlData.enemy3.bulletSpeed, dt) end
    if active[4] then ctrl[4]:update(enemies[4], lvlData.enemy4.speed, dt) end
    if active[5] then ctrl[5]:update(enemies[5], p1, playerbullets, lvlData.enemy5.speed, lvlData.enemy5.fireRate, lvlData.enemy5.bulletSpeed, dt) end
    if active[6] then ctrl[6]:update(enemies[6], p1, playerbullets, lvlData.enemy6.speed, lvlData.enemy6.fireRate, lvlData.enemy6.bulletSpeed, dt) end

    Star:update(star, 400, dt)
    Meteorite:update(meteorite, dt)
    powers1:update(dt); powers1:Fire(p1, playerbullets, in1)
    powers2:update(dt); powers2:Fire(p2, playerbullets, in2)
    PlayerBullets:update(playerbullets, dt)

    local e1, e2, e3, e4, e5, e6 = emptyIfNil(enemies[1]), emptyIfNil(enemies[2]), emptyIfNil(enemies[3]), emptyIfNil(enemies[4]), emptyIfNil(enemies[5]), emptyIfNil(enemies[6])

    Collisions:CheckAllCollisions(p1, playerbullets, e1, e2, e3, e4, e5, e6, E2B, E3B, E5B, E6B, star, meteorite, dt)
    Collisions:EnemyPlayer(e1, e2, e3, e4, e5, e6, p2, dt)
    Collisions:EnemyBulletPlayer(p2, E2B, E3B, E5B, E6B)
    Collisions:MeteoriteCollisions(meteorite, p2, e1, e2, e3, e4, e5, e6, playerbullets, E2B, E3B, E5B, E6B, dt)
    Collisions:StarPlayer(star, p2)

    for _, p in ipairs(players) do
        if p.invulnerable then
            p.invulnerableTimer = p.invulnerableTimer - dt
            if p.invulnerableTimer <= 0 then p.invulnerable = false end
        end
    end

    if Coop.role == "host" then
        sendTimer = sendTimer - dt
        if sendTimer <= 0 then
            Coop.sendSnapshot(buildSnapshot(p1, p2))
            sendTimer = 1 / 30
        end
    end
end

Engine.coopLevel = {
    load = function() end,
    update = function(dt)
        local p1, p2 = players[1], players[2]
        if not (p1 and p2) then return end
        if Coop.role == "client" then
            local CoopLauncher = require("network/cooplauncher")
            Coop.sendInput(readLocalInput(p2))
            if CoopLauncher.latestSnap then applySnapshot(CoopLauncher.latestSnap, p1, p2) end
            return
        end
        hostUpdate(dt, p1, p2)
    end,
    draw = function()
        love.graphics.draw(backgrounds[n] or backgrounds[1], 0, 0, 0)
        if Coop.role == "client" then
            PlayerBullets:draw(playerbullets)
            for _, p in ipairs(players) do p:draw() end
            for k = 1, 6 do
                if active[k] and enemies[k] then
                    EnemyClass[k]:draw(enemies[k], enemySprites[planet][k])
                end
            end
            local spr = enemyBulletSprite[planet]
            for _, arr in pairs(netEnemyBullets) do
                for _, b in ipairs(arr) do
                    love.graphics.draw(spr, b.x, b.y, b.angle, 0.5, 0.5)
                end
            end
            Star:draw(star)
            Meteorite:draw(meteorite)
            if powers2 then powers2:draw() end
        else
            PlayerBullets:draw(playerbullets)
            for _, p in ipairs(players) do p:draw() end
            for k = 1, 6 do
                if active[k] and ctrl[k] then
                    ctrl[k]:draw(enemies[k], enemySprites[planet][k])
                end
            end
            if powers1 then powers1:draw() end
            Star:draw(star)
            Meteorite:draw(meteorite)
        end
        local menus = require("menus/mainmenus/menus")
        if menus.drawstatsgamemenu then menus.drawstatsgamemenu:draw() end
    end,
}

Engine.angleProvider = {}
function Engine.angleProvider:zombiePlayerAngle(enemy)
    if #players == 0 then return 0 end
    local target, bestd = players[1], nil
    for _, p in ipairs(players) do
        local d = (p.x - enemy.x) ^ 2 + (p.y - enemy.y) ^ 2
        if not bestd or d < bestd then bestd = d; target = p end
    end
    return math.atan2(target.y - enemy.y, target.x - enemy.x)
end
function Engine.angleProvider:playerMouseAngle()
    local p = players[1]
    if not p then return 0 end
    return math.atan2(p.y - love.mouse.getY(), p.x - love.mouse.getX()) + math.pi
end

return Engine