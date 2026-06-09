local Coop = require("network/coop")

local CoopLauncher = {}

local hudFont = love.graphics.newFont("fonts/alien.ttf", 18)

local showDebug = false

local state    = "closed"
local ipInput  = ""
local lanIP, targetIP = nil, ""

local uiButtons = {}

CoopLauncher.active      = false
CoopLauncher.remoteInput = { up=false, down=false, left=false, right=false, aim=0, shoot=false, gun=false, shield=false, bomb=false }
CoopLauncher.latestSnap  = nil
local myReady, otherReady = false, false
local clientLoadout = nil
local inLevel = false
local lastMoney = nil
local currentN = 1
local pendingN = 1
local fullReset

local hostName, clientName = nil, nil
local function rebuildCoopName()
   Data.coopName = (hostName or "?") .. " & " .. (clientName or "?")
end

local function detectLanIP()
    local ok, socket = pcall(require, "socket")
    if not ok then return nil end
    local lan
    local udp = socket.udp()
    if udp then
        pcall(function() udp:setpeername("8.8.8.8", 80) end)
        lan = udp:getsockname()
        udp:close()
        if lan == "0.0.0.0" then lan = nil end
    end
    return lan
end

local function myLoadout()
    return {
        shield = Data.shield.lvl, gun = Data.gun.lvl, bomb = Data.bomb.lvl,
        firerate = Data.firerate.lvl, speedmovement = Data.speedmovement.lvl,
        speedbullet = Data.speedbullet.lvl, playerlvl = Data.player.lvl,
    }
end

local function beginLevel(n)
    n = n or 1
    currentN = n
    local CoopEngine = require("planetlevels/coopengine")
    Data.lvl = n
    Data.currentlvl = n
    Data.player.deadgameenemies = 0
    local lvl = Data["lvl" .. n]
    if lvl then
        lvl.completed = false
        lvl.deadgameenemies = 0
        lvl.cometsintercepted = 0
        lvl.lifepointsgained = 0
    end
    CoopEngine.begin(n)
    Data.currentState = "game"
    inLevel = true
end

function CoopLauncher.getClientLoadout() return clientLoadout end
function CoopLauncher.isCoopActive() return CoopLauncher.active end
function CoopLauncher.isInLevel() return inLevel end
function CoopLauncher.canSubmit() return (not CoopLauncher.active) or (Coop.role == "host") end

function CoopLauncher.open()
    if CoopLauncher.active then
        state = "connected"
    else
        state = "menu"
    end
end

function CoopLauncher.disconnect()
    Coop.shutdown()
    CoopLauncher.active = false
    Data.coop = false
    inLevel = false
    myReady, otherReady = false, false
    hostName, clientName, Data.coopName = nil, nil, nil
    local CoopEngine = require("planetlevels/coopengine")
    pcall(CoopEngine.finish)
    fullReset()
    Data.currentLevel = nil
    state = "closed"
    Data.currentState = "mainmenu"
end

local function resetSpaceshipMenus()
    local ok, menus = pcall(require, "menus/mainmenus/menus")
    if not ok then return end
    local map = {
        mainspaceshipmenu = "menus/spaceshipmenus/mainspaceshipmenu",
        bombspaceshipmenu = "menus/spaceshipmenus/bombspaceshipmenu",
        laserspaceshipmenu = "menus/spaceshipmenus/laserspaceshipmenu",
        shieldspaceshipmenu = "menus/spaceshipmenus/shieldspaceshipmenu",
        speedbulletspaceshipmenu = "menus/spaceshipmenus/speedbulletspaceshipmenu",
        fireratespaceshipmenu = "menus/spaceshipmenus/fireratespaceshipmenu",
        speedmovementspaceshipmenu = "menus/spaceshipmenus/speedmovementspaceshipmenu",
    }
    for key, path in pairs(map) do
        local ok2, cls = pcall(require, path)
        if ok2 and cls and cls.new then menus[key] = cls.new() end
    end
end

local function resetUpgrade(up)
    if type(up) ~= "table" then return end
    up.lvl = 1
    if up.active ~= nil then up.active = false end
    for i = 1, 6 do
        local sub = up["lvl" .. i]
        if type(sub) == "table" and sub.current ~= nil then sub.current = (i == 1) end
    end
end

function fullReset()
    for i = 1, 15 do
        local lvl = Data["lvl" .. i]
        if lvl then
            lvl.completed = false
            lvl.deadgameenemies = 0
            lvl.cometsintercepted = 0
            lvl.lifepointsgained = 0
        end
    end
    Data.lvl = 1
    Data.levelbloq = false
    Data.player.money = 0
    Data.player.lifepoints = 200
    Data.player.deadgameenemies = 0
    Data.player.deadtotalenemies = 0
    Data.player.totalcomets = 0
    Data.player.cometsintercepted = 0
    Data.player.lifepointsgained = 0
    Data.player.lvl = 1
    Data.player.currentlvl = 0
    resetUpgrade(Data.shield)
    resetUpgrade(Data.gun)
    resetUpgrade(Data.bomb)
    resetUpgrade(Data.firerate)
    resetUpgrade(Data.speedbullet)
    resetUpgrade(Data.speedmovement)
    resetSpaceshipMenus()
end

function CoopLauncher.requestStart(planet, zone)
    local n = (planet - 1) * 3 + zone
    pendingN = n
    myReady = true
    Coop.send({ t = "ready", loadout = myLoadout(), lvl = n }, true)
end

function CoopLauncher.endLevel(targetState)
    local n = currentN
    local lvl = Data["lvl" .. n] or {}
    Coop.send({
        t = "levelend",
        state = targetState,
        lvl = n,
        completed = lvl.completed,
        stats = {
            de  = lvl.deadgameenemies,
            ci  = lvl.cometsintercepted,
            lg  = lvl.lifepointsgained,
            pde = Data.player.deadgameenemies,
            tc  = Data.player.totalcomets,
            hp  = Data.player.lifepoints,
        },
    }, true)
    CoopLauncher.gotoMenuState(targetState)
end

function CoopLauncher.gotoMenuState(targetState)
    inLevel = false
    myReady = false
    otherReady = false
    local CoopEngine = require("planetlevels/coopengine")
    CoopEngine.finish()
    Data.currentState = targetState or "mainplanetmenu"
end

Coop.onConnect = function()
    CoopLauncher.active = true
    state = "closed"
    myReady, otherReady = false, false
    inLevel = false
    fullReset()
    lastMoney = Data.player.money
    Data.coop = true
    if Coop.role == "host" then
        hostName   = Data.player.name
        clientName = nil
        Coop.send({ t = "moneyset", value = Data.player.money }, true)
    else
        clientName = Data.player.name
        hostName   = nil
    end
    rebuildCoopName()
    Coop.send({ t = "name", name = Data.player.name }, true)
    Data.currentState = "mainplanetmenu"
end

Coop.onDisconnect = function()
    CoopLauncher.active = false
    inLevel = false
    myReady, otherReady = false, false
    Data.coop = false
    hostName, clientName, Data.coopName = nil, nil, nil
    local CoopEngine = require("planetlevels/coopengine")
    pcall(CoopEngine.finish)
    fullReset()
    Data.currentLevel = nil
    Data.currentState = "mainmenu"
end

Coop.onMessage = function(msg)
    if msg.t == "input" then
        CoopLauncher.remoteInput = msg.i
    elseif msg.t == "snap" then
        CoopLauncher.latestSnap = msg.s
    elseif msg.t == "name" then
        if Coop.role == "host" then clientName = msg.name else hostName = msg.name end
        rebuildCoopName()
    elseif msg.t == "ready" then
        otherReady = true
        clientLoadout = msg.loadout
        if Coop.role ~= "host" then pendingN = msg.lvl or pendingN end
    elseif msg.t == "start" then
        beginLevel(msg.lvl)
    elseif msg.t == "levelend" then
        if msg.completed then
            local lvl = Data["lvl" .. (msg.lvl or currentN)]
            if lvl then lvl.completed = true end
        end
        if msg.stats then
            local lvl = Data["lvl" .. (msg.lvl or currentN)]
            if lvl then
                lvl.deadgameenemies   = msg.stats.de
                lvl.cometsintercepted = msg.stats.ci
                lvl.lifepointsgained  = msg.stats.lg
            end
            Data.player.deadgameenemies = msg.stats.pde
            Data.player.totalcomets     = msg.stats.tc
            if msg.stats.hp then Data.player.lifepoints = msg.stats.hp end
        end
        CoopLauncher.gotoMenuState(msg.state)
    elseif msg.t == "moneyset" then
        Data.player.money = msg.value
        lastMoney = msg.value
    elseif msg.t == "spend" then
        Data.player.money = Data.player.money - msg.cost
        lastMoney = Data.player.money
    end
end

function CoopLauncher.update()
    Coop.update()
    if Coop.role == "host" and CoopLauncher.active and not inLevel and myReady and otherReady then
        Coop.send({ t = "start", lvl = pendingN }, true)
        beginLevel(pendingN)
    end
    if CoopLauncher.active and lastMoney ~= nil then
        local mnow = Data.player.money
        if mnow < lastMoney then
            Coop.send({ t = "spend", cost = lastMoney - mnow }, true)
        end
        lastMoney = mnow
    end
end

function CoopLauncher.keypressed(key)
    if key == "f3" then showDebug = not showDebug; return true end
    if state == "closed" then
        return false
    end
    if state == "menu" then
        if key == "h" then lanIP = detectLanIP(); Coop.startHost(); state = "hosting"
        elseif key == "j" then state = "typing_ip"; ipInput = ""
        elseif key == "escape" then state = "closed" end
        return true
    elseif state == "connected" then
        if key == "d" then CoopLauncher.disconnect()
        elseif key == "escape" then state = "closed" end
        return true
    elseif state == "typing_ip" then
        if key == "backspace" then ipInput = ipInput:sub(1, -2)
        elseif key == "return" or key == "kpenter" then targetIP = ipInput; Coop.startClient(ipInput); state = "connecting"
        elseif key == "escape" then state = "closed" end
        return true
    elseif state == "hosting" or state == "connecting" then
        if key == "escape" then Coop.shutdown(); state = "closed" end
        return true
    end
    return false
end

function CoopLauncher.textinput(t)
    if state == "typing_ip" and t:match("[%d%.:]") then ipInput = ipInput .. t; return true end
    return false
end

function CoopLauncher.mousepressed(x, y, button)
    if state == "closed" or button ~= 1 then return false end
    for _, b in ipairs(uiButtons) do
        if x > b.x and x < b.x + b.w and y > b.y and y < b.y + b.h then
            b.action()
            return true
        end
    end
    return true
end

local function addButton(label, x, y, action)
    local w, h = 360, 34
    uiButtons[#uiButtons + 1] = { label = label, x = x, y = y, w = w, h = h, action = action }
    love.graphics.rectangle("line", x, y, w, h)
    love.graphics.print(label, x + 8, y + 6)
end

function CoopLauncher.draw()
    uiButtons = {}
    if state ~= "closed" then
        local W, H = love.graphics.getWidth(), love.graphics.getHeight()
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", 0, 0, W, H)
        love.graphics.setColor(1, 1, 1, 1)
        if state == "menu" then
            love.graphics.print("ONLINE / COOPERATIVE", 60, 60)
            addButton("[H]  Host a game", 60, 110, function()
                lanIP = detectLanIP(); Coop.startHost(); state = "hosting"
            end)
            addButton("[J]  Join a host", 60, 150, function()
                state = "typing_ip"; ipInput = ""
            end)
            addButton("[Esc] Close", 60, 200, function() state = "closed" end)
        elseif state == "connected" then
            love.graphics.print("ONLINE MODE - connected (" .. (Data.coopName or "") .. ")", 60, 60)
            addButton("[D]  Disconnect (back to SOLO)", 60, 110, function() CoopLauncher.disconnect() end)
            addButton("[Esc] Close", 60, 160, function() state = "closed" end)
        elseif state == "hosting" then
            love.graphics.print("HOSTING - waiting for the other player...", 60, 60)
            if lanIP then
                love.graphics.print("Your local IP (share it with your friend on the same WiFi):", 60, 110)
                love.graphics.print(lanIP, 60, 135)
            else
                love.graphics.print("Could not detect your local IP. Check it with 'ipconfig' (IPv4).", 60, 110)
            end
            love.graphics.print("(Same PC: 127.0.0.1)", 60, 175)
            addButton("[Esc] Cancel", 60, 215, function() Coop.shutdown(); state = "closed" end)
        elseif state == "typing_ip" then
            love.graphics.print("Host IP (same WiFi, e.g. 192.168.x.x):", 60, 60)
            love.graphics.print(ipInput .. "_", 60, 95)
            addButton("Enter = connect", 60, 140, function()
                targetIP = ipInput; Coop.startClient(ipInput); state = "connecting"
            end)
            addButton("[Esc] Cancel", 60, 185, function() state = "closed" end)
        elseif state == "connecting" then
            love.graphics.print("Connecting to " .. targetIP .. " ...", 60, 60)
            addButton("[Esc] Cancel", 60, 100, function() Coop.shutdown(); state = "closed" end)
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    if CoopLauncher.active and not inLevel then
        love.graphics.setColor(1, 1, 1, 1)
        if myReady then
            local partner = (Coop.role == "host") and clientName or hostName
            local txt = "waiting for " .. (partner or "...")
            local prevFont = love.graphics.getFont()
            love.graphics.setFont(hudFont)
            love.graphics.setColor(1, 1, 1, 1)
            local w = hudFont:getWidth(txt)
            love.graphics.print(txt, love.graphics.getWidth() - w - 20, 40)
            love.graphics.setFont(prevFont)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end

    if CoopLauncher.active then
        local partner = (Coop.role == "host") and clientName or hostName
        local txt = "online with " .. (partner or "...")
        local prevFont = love.graphics.getFont()
        love.graphics.setFont(hudFont)
        love.graphics.setColor(0.45, 1, 0.65, 1)
        local w = hudFont:getWidth(txt)
        love.graphics.print(txt, love.graphics.getWidth() - w - 20, 18)
        love.graphics.setFont(prevFont)
        love.graphics.setColor(1, 1, 1, 1)
    end

    if showDebug then
        local prevFont = love.graphics.getFont()
        love.graphics.setFont(hudFont)
        local fps = love.timer.getFPS()
        local frameMs = 0
        if love.timer.getAverageDelta then
            frameMs = love.timer.getAverageDelta() * 1000
        elseif fps > 0 then
            frameMs = 1000 / fps
        end
        local txt = string.format("FPS: %d  |  %.1f ms/frame", fps, frameMs)
        if CoopLauncher.active then
            local ping = Coop.ping()
            if ping then txt = txt .. string.format("  |  ping: %d ms", ping) end
        end
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.print(txt, 20, love.graphics.getHeight() - 50)
        love.graphics.setFont(prevFont)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return CoopLauncher