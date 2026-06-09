Collisions = {}
Collisions.__index = Collisions
local AudioManager = require("audio/audiomanager")
local Data = require("others/data")
local soundManager = AudioManager.new()
function Collisions:EnemyPlayer(zombies1, zombies2, zombies3, zombies4, zombies5, zombies6, player, dt)
    local bombradius
    if Data.bomb.lvl == 1 then
        bombradius = Data.bomb.lvl1.radius
    elseif Data.bomb.lvl == 2 then
        bombradius = Data.bomb.lvl2.radius
    elseif Data.bomb.lvl == 3 then
        bombradius = Data.bomb.lvl3.radius
    elseif Data.bomb.lvl == 4 then
        bombradius = Data.bomb.lvl4.radius
    end
    for _, zombies in ipairs({zombies1, zombies2, zombies3, zombies4, zombies5, zombies6}) do
        for i,z in ipairs(zombies) do
            if player.bombActive and self:distanceBetween(z.x, z.y, player.x, player.y) < bombradius then
                z.dead = true
            end
            if self:distanceBetween(z.x, z.y, player.x, player.y) < 30 then
                if not player.invulnerable then
                    if player.shieldActive then
                        z.dead = true
                    else
                        Data.player.lifepoints = Data.player.lifepoints - 1
                        soundManager:playSound(6)
                        Data.player.injured = true
                        z.dead = true
                        player.invulnerable = true
                        player.invulnerableTimer = 0.5
                    end
                end
            end
        end
    end
end
function Collisions:PlayerBulletEnemy(playerbullets, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6)
    for i,b in ipairs(playerbullets) do
        for j,e in ipairs(enemy1) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
        for j,e in ipairs(enemy2) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
        for j,e in ipairs(enemy3) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
        for j,e in ipairs(enemy4) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
        for j,e in ipairs(enemy5) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
        for j,e in ipairs(enemy6) do
           if self:distanceBetween(b.x, b.y, e.x, e.y) < 20 then
              b.dead = true
              e.dead = true
           end
        end
     end
end
function Collisions:BulletBullet(playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets)
    for i,b1 in ipairs(playerbullets) do
        for j,b2 in ipairs(enemy2bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) > (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy3bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy5bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy6bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
    end
    for i,b1 in ipairs(enemy2bullets) do
        for j,b2 in ipairs(enemy3bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy5bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy6bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
    end
    for i,b1 in ipairs(enemy3bullets) do
        for j,b2 in ipairs(enemy5bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
        for j,b2 in ipairs(enemy6bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
    end
    for i,b1 in ipairs(enemy5bullets) do
        for j,b2 in ipairs(enemy6bullets) do
            if self:distanceBetween(b1.x, b1.y, b2.x, b2.y) < (b1.radio + b2.radio) then
                b1.dead = true
                b2.dead = true
            end
        end
    end
end
function Collisions:EnemyBulletPlayer(player, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets)
    for i,b in ipairs(enemy2bullets) do
        if self:distanceBetween(player.x, player.y, b.x, b.y) < (player.radio + b.radio) then
            b.dead = true
            Data.player.lifepoints = Data.player.lifepoints - 1
            soundManager:playSound(6)
        end
    end
    for i,b in ipairs(enemy3bullets) do
        if self:distanceBetween(player.x, player.y, b.x, b.y) < (player.radio + b.radio) then
            b.dead = true
            Data.player.lifepoints = Data.player.lifepoints - 1
            soundManager:playSound(6)
        end
    end
    for i,b in ipairs(enemy5bullets) do
        if self:distanceBetween(player.x, player.y, b.x, b.y) < (player.radio + b.radio) then
            b.dead = true
            Data.player.lifepoints = Data.player.lifepoints - 1
            soundManager:playSound(6)
        end
    end
    for i,b in ipairs(enemy6bullets) do
        if self:distanceBetween(player.x, player.y, b.x, b.y) < (player.radio + b.radio) then
            b.dead = true
            Data.player.lifepoints = Data.player.lifepoints - 1
            soundManager:playSound(6)
            Data.player.injured = true
        end
    end
end

function Collisions:StarPlayer(stars, player)
    for i,s in ipairs(stars) do
        if not s.dead and self:distanceBetween(s.x, s.y, player.x, player.y) < 30 then
            s.dead = true
            if Data.currentlvl == 1 then
                Data.lvl1.cometsintercepted = Data.lvl1.cometsintercepted + 1
            elseif Data.currentlvl == 2 then
                Data.lvl2.cometsintercepted = Data.lvl2.cometsintercepted + 1
            elseif Data.currentlvl == 3 then
                Data.lvl3.cometsintercepted = Data.lvl3.cometsintercepted + 1
            elseif Data.currentlvl == 4 then
                Data.lvl4.cometsintercepted = Data.lvl4.cometsintercepted + 1
            elseif Data.currentlvl == 5 then
                Data.lvl5.cometsintercepted = Data.lvl5.cometsintercepted + 1
            elseif Data.currentlvl == 6 then
                Data.lvl6.cometsintercepted = Data.lvl6.cometsintercepted + 1
            elseif Data.currentlvl == 7 then
                Data.lvl7.cometsintercepted = Data.lvl7.cometsintercepted + 1
            elseif Data.currentlvl == 8 then
                Data.lvl8.cometsintercepted = Data.lvl8.cometsintercepted + 1
            elseif Data.currentlvl == 9 then
                Data.lvl9.cometsintercepted = Data.lvl9.cometsintercepted + 1
            elseif Data.currentlvl == 10 then
                Data.lvl10.cometsintercepted = Data.lvl10.cometsintercepted + 1
            elseif Data.currentlvl == 11 then
                Data.lvl11.cometsintercepted = Data.lvl11.cometsintercepted + 1
            elseif Data.currentlvl == 12 then
                Data.lvl12.cometsintercepted = Data.lvl12.cometsintercepted + 1
            elseif Data.currentlvl == 13 then
                Data.lvl13.cometsintercepted = Data.lvl13.cometsintercepted + 1
            elseif Data.currentlvl == 14 then
                Data.lvl14.cometsintercepted = Data.lvl14.cometsintercepted + 1
            elseif Data.currentlvl == 15 then
                Data.lvl15.cometsintercepted = Data.lvl15.cometsintercepted + 1
            end
            Data.player.totalcomets = Data.player.totalcomets + 1
        end
    end
end
-- Movimiento de estrellas + colision con enemigos/balas (UNA vez por frame).
function Collisions:StarMovement(stars, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, dt)
    for i,s in ipairs(stars) do
        s.x = s.x + math.cos(s.direction) * s.speed * dt
        s.y = s.y + math.sin(s.direction) * s.speed * dt
        for _, enemyGroup in ipairs({enemy1, enemy2, enemy3, enemy4, enemy5, enemy6}) do
            for j,e in ipairs(enemyGroup) do
                if self:distanceBetween(s.x, s.y, e.x, e.y) < 30 then
                    e.dead = true
                end
            end
        end
        for _, bulletGroup in ipairs({playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets}) do
            for k,b in ipairs(bulletGroup) do
                if self:distanceBetween(s.x, s.y, b.x, b.y) < 20 then
                    b.dead = true
                end
            end
        end
    end
end
function Collisions:MeteoriteCollisions(meteorites, player, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, dt)
    player.lifeGainTimer = player.lifeGainTimer or 0
    player.lifeGainTimer = player.lifeGainTimer - dt
    player.lifeLossTimer = player.lifeLossTimer or 0
    player.lifeLossTimer = player.lifeLossTimer - dt
    for i,m in ipairs(meteorites) do
        if m.drawTimer <= 0 and self:distanceBetween(m.x, m.y, player.x, player.y) < m.radius then
            if player.lifeLossTimer <= 0 then
                if not player.shieldActive then
                Data.player.lifepoints = Data.player.lifepoints - 50
                soundManager:playSound(4)
                end
                player.lifeLossTimer = 3.6
            end
        end
        for _, enemyGroup in ipairs({enemy1, enemy2, enemy3, enemy4, enemy5, enemy6}) do
            for j,e in ipairs(enemyGroup) do
                if m.drawTimer <= 0 and self:distanceBetween(m.x, m.y, e.x, e.y) < m.radius then
                    e.dead = true
                end
            end
        end
        for _, bulletGroup in ipairs({playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets}) do
            for k,b in ipairs(bulletGroup) do
                if m.drawTimer <= 0 and self:distanceBetween(m.x, m.y, b.x, b.y) < m.radius then
                    if bulletGroup ~= playerbullets then
                        b.dead = true
                    end
                end
            end
        end
    end
end
function Collisions:CheckAllCollisions(player, playerbullets, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, stars, meteorite, dt)
    self:EnemyPlayer(enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, player, dt)
    self:PlayerBulletEnemy(playerbullets, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6)
    self:BulletBullet(playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets)
    self:EnemyBulletPlayer(player, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets)
    self:StarMovement(stars, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, dt)
    self:StarPlayer(stars, player)
    self:MeteoriteCollisions(meteorite, player, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, playerbullets, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, dt)
end
function Collisions:distanceBetween(x1, y1, x2, y2)
return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end
return Collisions