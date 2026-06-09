Planet1level1 = {}
Planet1level1.__index = Planet1level1
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
math.randomseed(os.time())
local sprites = {}
sprites.enemy1 = love.graphics.newImage('sprites/enemy/planet1enemy1.png')
sprites.enemy2 = love.graphics.newImage('sprites/enemy/planet1enemy2.png')
sprites.enemy3 = love.graphics.newImage('sprites/enemy/planet1enemy3.png')
sprites.enemy4 = love.graphics.newImage('sprites/enemy/planet1enemy4.png')
sprites.enemy5 = love.graphics.newImage('sprites/enemy/planet1enemy5.png')
sprites.enemy6 = love.graphics.newImage('sprites/enemy/planet1enemy6.png')
local player
local gameEnemy1 = Enemy1.new(Data.lvl1.enemy1.maxTime)
local enemy1 = {}
local enemy2 = {}
local enemy3 = {}
local enemy4 = {}
local enemy5 = {}
local enemy6 = {}
local star = {}
local meteorite = {}
local playerbullets = {}
local enemy2bullets = {}
local enemy3bullets = {}
local enemy5bullets = {}
local enemy6bullets = {}
local powers
local a = true
local b = true
function Planet1level1.new()
   local self = setmetatable({}, Planet1level1)
   Data.currentlvl = 1
   return self
end
function Planet1level1:update(dt)
   if Data.player.lifepoints <= 0 then
      Data.currentState = "gameovermenu"
   end
   if Data.player.deadgameenemies >= Data.lvl1.maxKills then
      Data.lvl1.completed = true
   end
   if Data.lvl1.completed == true then
      Data.currentState = "levelcompletedmenu"
   end
   if a == true then
      powers = Powers.new(Data.shield.lvl, Data.gun.lvl, Data.bomb.lvl, Data.firerate.lvl)
      a = false
   end
   if b == true then
      player = Player.new(Data.speedmovement.lvl)
      b = false
   end
   player:update(dt)
   gameEnemy1:update(enemy1, Data.lvl1.enemy1.speed, dt)
   Star:update(star, 400, dt)
   Meteorite:update(meteorite, dt)
   powers:update(dt)
   powers:Fire(player, playerbullets)
   PlayerBullets:update(playerbullets, dt)
   Collisions:CheckAllCollisions(player, playerbullets, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, enemy2bullets, enemy3bullets, enemy5bullets, enemy6bullets, star, meteorite, dt)
   if player.invulnerable then
      player.invulnerableTimer = player.invulnerableTimer - dt
      if player.invulnerableTimer <= 0 then
         player.invulnerable = false
      end
   end
end
function Planet1level1:draw()
   PlayerBullets:draw(playerbullets)
   player:draw()
   powers:draw(player, sprites)
   gameEnemy1:draw(enemy1, sprites.enemy1)
   Star:draw(star)
   Meteorite:draw(meteorite)
end
function Planet1level1:playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end
function Planet1level1:zombiePlayerAngle(enemy)
   return math.atan2(player.y - enemy.y, player.x - enemy.x)
end
return Planet1level1