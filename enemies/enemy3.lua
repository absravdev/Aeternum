Enemy3 = {}
Enemy3.__index = Enemy3
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local Enemy3Bullets = require("bullets/enemy3bullets") 
function Enemy3.new(maxTime)
  local self = setmetatable({}, Enemy3)
  self.maxTime = maxTime
  self.timer = self.maxTime
  return self
end
function Enemy3:SpawnType1(zombies, speed, fireRate)
   local zombie = {}
   zombie.x = 0
   zombie.y = 0
   zombie.speed = speed
   zombie.dead = false
   zombie.fireRate = fireRate
   zombie.fireTimer = zombie.fireRate
   local side = math.random(1, 4)
   if side == 1 then
     zombie.x = -30
     zombie.y = math.random(0, love.graphics.getHeight())
   elseif side == 2 then
     zombie.x = love.graphics.getWidth() + 30
     zombie.y = math.random(0, love.graphics.getHeight())
   elseif side == 3 then
     zombie.x = math.random(0, love.graphics.getWidth())
     zombie.y = -30
   elseif side == 4 then
      zombie.x = math.random(0, love.graphics.getWidth())
      zombie.y = love.graphics.getHeight() + 30
   end 
   table.insert(zombies, zombie)
end
function Enemy3:fireBullet(zombie, player, bulletSpeed)
  local angle = math.atan2(player.y - zombie.y, player.x - zombie.x)
  local bullet = Enemy3Bullets:new(zombie.x, zombie.y, angle, bulletSpeed)
  table.insert(Enemy3Bullets, bullet) -- Añade la bala a la lista global de balas
end
function Enemy3:update(zombies, player, playerBullets, speed, fireRate, bulletSpeed, dt)
  self.timer = self.timer - dt
  if self.timer <= 0 then 
        Enemy3:SpawnType1(zombies, speed, fireRate)
        self.maxTime = 1 * self.maxTime
        self.timer = self.maxTime
  end 
  for i=#zombies,1,-1 do
    local z = zombies[i]
    if Collisions:distanceBetween(player.x, player.y, z.x, z.y) > 400 then
      if Data.lvl == 1 then
        z.x = z.x + math.cos(Planet1level1:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet1level1:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 2 then
        z.x = z.x + math.cos(Planet1level2:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet1level2:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 3 then
        z.x = z.x + math.cos(Planet1level3:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet1level3:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 4 then
        z.x = z.x + math.cos(Planet2level1:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet2level1:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 5 then
        z.x = z.x + math.cos(Planet2level2:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet2level2:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 6 then
        z.x = z.x + math.cos(Planet2level3:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet2level3:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 7 then
        z.x = z.x + math.cos(Planet3level1:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet3level1:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 8 then
        z.x = z.x + math.cos(Planet3level2:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet3level2:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 9 then
        z.x = z.x + math.cos(Planet3level3:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet3level3:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 10 then
        z.x = z.x + math.cos(Planet4level1:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet4level1:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 11 then
        z.x = z.x + math.cos(Planet4level2:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet4level2:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 12 then
        z.x = z.x + math.cos(Planet4level3:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet4level3:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 13 then
        z.x = z.x + math.cos(Planet5level1:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet5level1:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 14 then
        z.x = z.x + math.cos(Planet5level2:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet5level2:zombiePlayerAngle(z)) * z.speed * dt
      elseif Data.lvl == 15 then
        z.x = z.x + math.cos(Planet5level3:zombiePlayerAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(Planet5level3:zombiePlayerAngle(z)) * z.speed * dt
      end
    end
    if z.dead == true then
      soundManager:playSound(2)
      Data.player.deadgameenemies = Data.player.deadgameenemies + 1
      Data.player.deadtotalenemies = Data.player.deadtotalenemies +1
      table.remove(zombies, i)
    else
       z.fireTimer = z.fireTimer - dt
       if z.fireTimer <= 0 then
           Enemy3:fireBullet(z, player, bulletSpeed)
           z.fireTimer = z.fireRate
       end
    end
  end
  for i=#Enemy3Bullets,1,-1 do
    local b = Enemy3Bullets[i]
    b:update(player, dt)
    for j,pb in ipairs(playerBullets) do
        if Collisions:distanceBetween(b.x, b.y, pb.x, pb.y) < (b.radio + pb.radio) or Data.bomb.active and Collisions:distanceBetween(b.x, b.y, player.x, player.y) < 150 then
            if not Data.shield.active then
              table.remove(Enemy3Bullets, i)
              pb.dead = true
            elseif Data.shield.active and Data.bomb.active and Collisions:distanceBetween(b.x, b.y, player.x, player.y) < 150 then
              table.remove(Enemy3Bullets, i)
            end
        end
    end
    if Collisions:distanceBetween(b.x, b.y, player.x, player.y) < (b.radio + player.radio) or Data.bomb.active and Collisions:distanceBetween(b.x, b.y, player.x, player.y) < 150 then
        if not Data.shield.active then
          table.remove(Enemy3Bullets, i)
          Data.player.lifepoints = Data.player.lifepoints - 1
        elseif Data.shield.active and Data.bomb.active and Collisions:distanceBetween(b.x, b.y, player.x, player.y) < 150 then
          table.remove(Enemy3Bullets, i)
        end
    end
  end
end
function Enemy3:draw(zombies, sprite)
  for i,z in ipairs(zombies) do
    if Data.lvl == 1 then
      love.graphics.draw(sprite, z.x, z.y, Planet1level1:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 2 then
      love.graphics.draw(sprite, z.x, z.y, Planet1level2:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 3 then
      love.graphics.draw(sprite, z.x, z.y, Planet1level3:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 4 then
      love.graphics.draw(sprite, z.x, z.y, Planet2level1:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 5 then
      love.graphics.draw(sprite, z.x, z.y, Planet2level2:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 6 then
      love.graphics.draw(sprite, z.x, z.y, Planet2level3:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 7 then
      love.graphics.draw(sprite, z.x, z.y, Planet3level1:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 8 then
      love.graphics.draw(sprite, z.x, z.y, Planet3level2:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 9 then
      love.graphics.draw(sprite, z.x, z.y, Planet3level3:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 10 then
      love.graphics.draw(sprite, z.x, z.y, Planet4level1:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 11 then
      love.graphics.draw(sprite, z.x, z.y, Planet4level2:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 12 then
      love.graphics.draw(sprite, z.x, z.y, Planet4level3:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 13 then
      love.graphics.draw(sprite, z.x, z.y, Planet5level1:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 14 then
      love.graphics.draw(sprite, z.x, z.y, Planet5level2:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    elseif Data.lvl == 15 then
      love.graphics.draw(sprite, z.x, z.y, Planet5level3:zombiePlayerAngle(z), nil, nil, sprite:getWidth()/2, sprite:getHeight()/2)
    end
  end
  for _,b in ipairs(Enemy3Bullets) do
      b:draw()
  end
end
return Enemy3