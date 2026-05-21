Player = {}
Player.__index = Player
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local playerlvl1 = love.graphics.newImage('sprites/player/player1.png')
local playerlvl2 = love.graphics.newImage('sprites/player/player2.png')
local playerlvl3 = love.graphics.newImage('sprites/player/player3.png')
local playerlvl4 = love.graphics.newImage('sprites/player/player4.png')
local sprites = {}
sprites.shieldlvl1sprite = love.graphics.newImage("sprites/powers/shieldlvl1.png")
sprites.shieldlvl2sprite = love.graphics.newImage("sprites/powers/shieldlvl2.png")
sprites.shieldlvl3sprite = love.graphics.newImage("sprites/powers/shieldlvl3.png")
sprites.shieldlvl4sprite = love.graphics.newImage("sprites/powers/shieldlvl4.png")
sprites.bombsprite = love.graphics.newImage("sprites/powers/spritebomb.png")
sprites.gunlvl1sprite = love.graphics.newImage("sprites/powers/shieldlvl1.png")
sprites.gunlvl2sprite = love.graphics.newImage("sprites/powers/shieldlvl1.png")
sprites.gunlvl3sprite = love.graphics.newImage("sprites/powers/shieldlvl1.png")
local radius
local scaleX = 1.3
local scaleY = 1.3
function Player.new(speed)
    Data.player.lvl = math.min(Data.shield.lvl, Data.bomb.lvl, Data.gun.lvl)
    if Data.player.lvl == 1 then
    sprites.playerlvl0 = playerlvl1
    elseif Data.player.lvl == 2 then
    sprites.playerlvl0 = playerlvl2
    elseif Data.player.lvl == 3 then
    sprites.playerlvl0 = playerlvl3
    elseif Data.player.lvl == 4 then
    sprites.playerlvl0 = playerlvl4
    end
   if Data.bomb.lvl == 1 then
      radius = Data.bomb.lvl1.radius
  elseif Data.bomb.lvl == 2 then
      radius = Data.bomb.lvl2.radius
  elseif Data.bomb.lvl == 3 then
      radius = Data.bomb.lvl3.radius
  elseif Data.bomb.lvl == 4 then
      radius = Data.bomb.lvl4.radius
  end
   if Data.speedmovement.lvl == 1 then
      speed = Data.speedmovement.lvl1.value
   elseif Data.speedmovement.lvl == 2 then
      speed = Data.speedmovement.lvl2.value
   elseif Data.speedmovement.lvl == 3 then
      speed = Data.speedmovement.lvl3.value
   elseif Data.speedmovement.lvl == 4 then
      speed = Data.speedmovement.lvl4.value
   end
  local self = setmetatable({}, Player)
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.speed = speed
  self.radio = 25
  return self
end
function Player:update(dt)
    if love.keyboard.isDown("d") and self.x < love.graphics.getWidth() then
      self.x = self.x + self.speed * dt
    end 
    if love.keyboard.isDown("a") and self.x > 5 then
        self.x = self.x - self.speed * dt
    end 
    if love.keyboard.isDown("w") and self.y > 5 then
        self.y = self.y - self.speed * dt
    end 
    if love.keyboard.isDown("s") and self.y < love.graphics.getHeight() then
        self.y = self.y + self.speed * dt
    end
    if Data.shield.active then
        soundManager:playSound(3)
    end
    if Data.bomb.active then
        soundManager:playSound(5)
    end
    if Data.gun.active then
        soundManager:playSound(4)
    end
end
function Player:draw()
if Data.lvl == 1 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet1level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
   elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet1level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet1level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet1level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  end 
  if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  end 
  if Data.gun.active and Data.gun.lvl == 1 then
        love.graphics.setColor(255, 100, 100)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
        love.graphics.setColor(1, 1, 1, 1)
  elseif Data.gun.active and Data.gun.lvl == 2 then
        love.graphics.setColor(150, 0, 0)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
        love.graphics.setColor(1, 1, 1, 1)
  elseif Data.gun.active and Data.gun.lvl == 3 then
        love.graphics.setColor(200, 0, 0)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
        love.graphics.setColor(1, 1, 1, 1)
  elseif Data.gun.active and Data.gun.lvl == 4 then
        love.graphics.setColor(255, 0, 0)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
        love.graphics.setColor(1, 1, 1, 1)
  else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
  end

elseif Data.lvl == 2 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet1level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet1level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet1level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet1level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 3 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet1level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet1level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet1level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet1level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet1level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 4 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet2level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet2level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet2level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet2level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 5 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet2level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet2level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet2level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet2level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 6 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet2level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet2level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet2level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet2level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet2level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 7 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet3level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet3level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet3level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet3level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 8 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet3level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet3level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet3level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet3level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 9 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet3level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet3level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet3level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet3level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet3level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 10 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet4level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet4level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet4level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet4level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 11 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet4level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet4level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet4level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet4level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 12 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet4level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet4level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet4level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet4level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet4level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 13 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet5level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet5level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet5level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet5level1:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level1:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
elseif Data.lvl == 14 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet5level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet5level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet5level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet5level2:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level2:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end

elseif Data.lvl == 15 then
   if Data.shield.active and Data.shield.lvl == 1 then
        love.graphics.draw(sprites.shieldlvl1sprite, self.x, self.y, Planet5level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 2 then
        love.graphics.draw(sprites.shieldlvl2sprite, self.x, self.y, Planet5level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 3 then
        love.graphics.draw(sprites.shieldlvl3sprite, self.x, self.y, Planet5level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.shield.active and Data.shield.lvl == 4 then
        love.graphics.draw(sprites.shieldlvl4sprite, self.x, self.y, Planet5level3:playerMouseAngle(), scaleX, scaleY, sprites.playerlvl0:getWidth()/2 + 10, sprites.playerlvl0:getHeight()/2 + 5)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.bomb.active and Data.bomb.lvl == 1 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 2 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 3 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    elseif Data.bomb.active and Data.bomb.lvl == 4 then
        love.graphics.circle("fill", self.x, self.y, radius)
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    else
        love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end 
    if Data.gun.active and Data.gun.lvl == 1 then
      love.graphics.setColor(255, 100, 100)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 2 then
      love.graphics.setColor(150, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 3 then
      love.graphics.setColor(200, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    elseif Data.gun.active and Data.gun.lvl == 4 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(sprites.playerlvl0, self.x, self.y, Planet5level3:playerMouseAngle(), nil, nil, sprites.playerlvl0:getWidth()/2, sprites.playerlvl0:getHeight()/2)
    end
end    
end
return Player