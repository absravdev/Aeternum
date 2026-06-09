-- bullets/playerbullets.lua
-- Cambio: bullet.direction = player.aim (antes era el if Data.lvl==1..15 con
-- PlanetXlevelY:playerMouseAngle(), que leía el raton). Asi cada jugador dispara
-- en SU direccion. Retrocompatible: en single player, player.aim ya es el angulo
-- al raton (lo fija Player:update por el fallback).

PlayerBullets = {}
PlayerBullets.__index = PlayerBullets
local sprites = {}
local speedbullet
sprites.background = love.graphics.newImage('sprites/planets/background.png')
sprites.bullet = love.graphics.newImage('sprites/bullet/playerbullet.png')
sprites.player = love.graphics.newImage('sprites/player/player1.png')

function PlayerBullets:spawnBullet(player, bullets)
   if Data.speedbullet.lvl == 1 then
      speedbullet = Data.speedbullet.lvl1.value
   elseif Data.speedbullet.lvl == 2 then
      speedbullet = Data.speedbullet.lvl2.value
   elseif Data.speedbullet.lvl == 3 then
      speedbullet = Data.speedbullet.lvl3.value
   elseif Data.speedbullet.lvl == 4 then
      speedbullet = Data.speedbullet.lvl4.value
   end
   local bullet = {}
   bullet.x = player.x
   bullet.y = player.y
   bullet.speed = speedbullet
   bullet.dead = false
   bullet.direction = player.aim          -- antes: 15 ramas con playerMouseAngle()
   bullet.radio = 10
   table.insert(bullets, bullet)
end

function PlayerBullets:update(bullets, dt)
    for i,b in ipairs(bullets) do
        b.x = b.x + (math.cos(b.direction) * b.speed * dt)
        b.y = b.y + (math.sin(b.direction) * b.speed * dt)
     end
     for i=#bullets, 1, -1 do
        local b = bullets[i]
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
             table.remove(bullets, i)
        end
     end
     for i=#bullets,1,-1 do
        local b = bullets[i]
        if b.dead == true then
           table.remove(bullets, i)
        end
     end
end

function PlayerBullets:draw(bullets)
    for i,b in ipairs(bullets) do
        love.graphics.draw(sprites.bullet, b.x, b.y, b.direction, 0.5, nil, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)
    end
end

return PlayerBullets