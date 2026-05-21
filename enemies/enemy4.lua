Enemy4 = {}
Enemy4.__index = Enemy4
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
function Enemy4.new(maxTime)
  local self = setmetatable({}, Enemy4)
  self.maxTime = maxTime
  self.timer = self.maxTime
  return self
end
function Enemy4:SpawnType1(zombies, speed)
   local zombie = {}
   zombie.x = 0
   zombie.y = 0
   zombie.speed = speed
   zombie.dead = false
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
function Enemy4:update(zombies, speed, dt)
  self.timer = self.timer - dt
  if self.timer <= 0 then 
        Enemy4:SpawnType1(zombies, speed)
        self.maxTime = 1 * self.maxTime
        self.timer = self.maxTime
  end 
  for i=#zombies,1,-1 do
    local z = zombies[i]
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
    if z.dead == true then
      soundManager:playSound(2)
      Data.player.deadgameenemies = Data.player.deadgameenemies + 1
      Data.player.deadtotalenemies = Data.player.deadtotalenemies +1
       table.remove(zombies, i)
    end
  end
end
function Enemy4:draw(zombies, sprite)
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
end
return Enemy4