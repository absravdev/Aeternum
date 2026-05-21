Planet1level2 = {}
Planet1level2.__index = Planet1level2
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
local gameEnemy1 = Enemy1.new(Data.lvl2.enemy1.maxTime)
local gameEnemy2 = Enemy2.new(Data.lvl2.enemy2.maxTime)
--local gameEnemy3 = Enemy3.new(Data.lvl2.enemy3.maxTime)
--local gameEnemy4 = Enemy4.new(Data.lvl2.enemy4.maxTime)
--local gameEnemy5 = Enemy5.new(Data.lvl2.enemy5.maxTime)
--local gameEnemy6 = Enemy6.new(Data.lvl2.enemy6.maxTime)
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
function Planet1level2.new()
   local self = setmetatable({}, Planet1level2)
   return self
end
function Planet1level2:update(dt)
   if Data.player.lifepoints <= 0 then
      Data.currentState = "gameovermenu"
   end 
   if Data.player.deadgameenemies >= Data.lvl2.maxKills then
      Data.lvl2.completed = true
   end
   if Data.lvl2.completed == true then
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
   gameEnemy1:update(enemy1, Data.lvl2.enemy1.speed, dt)
   gameEnemy2:update(enemy2, player, playerbullets, Data.lvl2.enemy2.speed, Data.lvl2.enemy2.fireRate, Data.lvl2.enemy2.bulletSpeed, dt)
   --gameEnemy3:update(enemy3, player, playerbullets, Data.lvl2.enemy3.speed, Data.lvl2.enemy3.fireRate, Data.lvl2.enemy3.bulletSpeed, dt)
   --gameEnemy4:update(enemy4, Data.lvl2.enemy4.speed, dt)
   --gameEnemy5:update(enemy5, player, playerbullets, Data.lvl2.enemy5.speed, Data.lvl2.enemy5.fireRate, Data.lvl2.enemy5.bulletSpeed, dt)
   --gameEnemy6:update(enemy6, player, playerbullets, Data.lvl2.enemy6.speed, Data.lvl2.enemy6.fireRate, Data.lvl2.enemy6.bulletSpeed, dt)
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
function Planet1level2:draw()
   PlayerBullets:draw(playerbullets)
   player:draw()
   powers:draw(player, sprites)
   gameEnemy1:draw(enemy1, sprites.enemy1)
   gameEnemy2:draw(enemy2, sprites.enemy2)
   --gameEnemy3:draw(enemy3, sprites.enemy3)
   --gameEnemy4:draw(enemy4, sprites.enemy4)
   --gameEnemy5:draw(enemy5, sprites.enemy5)
   --gameEnemy6:draw(enemy6, sprites.enemy6)
   Star:draw(star)
   Meteorite:draw(meteorite)
end
function Planet1level2:playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end
function Planet1level2:zombiePlayerAngle(enemy)
   return math.atan2(player.y - enemy.y, player.x - enemy.x)
end
return Planet1level2