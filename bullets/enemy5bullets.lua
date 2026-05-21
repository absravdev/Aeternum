Enemy5Bullets = {}
Enemy5Bullets.__index = Enemy5Bullets
Enemy5Bullets.bullet = love.graphics.newImage('sprites/bullet/bullet.png')
local sprite1 = love.graphics.newImage('sprites/planet1enemybullet.png')
local sprite2 = love.graphics.newImage('sprites/planet2enemybullet.png')
local sprite3 = love.graphics.newImage('sprites/planet3enemybullet.png')
local sprite4 = love.graphics.newImage('sprites/planet4enemybullet.png')
local sprite5 = love.graphics.newImage('sprites/planet5enemybullet.png')
function Enemy5Bullets:new(x, y, angle, bulletSpeed)
    local bullet = {}
    setmetatable(bullet, Enemy5Bullets)
    bullet.x = x
    bullet.y = y
    bullet.speed = bulletSpeed
    bullet.dead = false
    bullet.angle = angle
    bullet.radio = 10
    if Data.lvl >= 1 and Data.lvl <= 3 then
        bullet.sprite = sprite1
   elseif Data.lvl >= 4 and Data.lvl <= 6 then
        bullet.sprite = sprite2
   elseif Data.lvl >= 7 and Data.lvl <= 9 then
        bullet.sprite = sprite3
   elseif Data.lvl >= 10 and Data.lvl <= 12 then
        bullet.sprite = sprite4
   elseif Data.lvl >= 13 and Data.lvl <= 15 then
        bullet.sprite = sprite5
   end
    return bullet
end
function Enemy5Bullets:update(bullets, dt)
    self.x = self.x + math.cos(self.angle) * self.speed * dt
    self.y = self.y + math.sin(self.angle) * self.speed * dt
    for i=#bullets,1,-1 do
        local b = bullets[i]
        if b.dead == true then
            table.remove(bullets, i)
        end
    end
end
function Enemy5Bullets:draw()
    local bulletScale = 0.8
    love.graphics.draw(self.sprite, self.x, self.y, self.angle, bulletScale, bulletScale)
end
return Enemy5Bullets