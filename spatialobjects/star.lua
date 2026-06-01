Star = {}
Star.__index = Star
local sprites = {}
sprites.zombie = love.graphics.newImage('sprites/star.png')
local maxTime = 0.2
local timer = maxTime
function Star:SpawnType1(stars, speed)
    local star = {}
    star.x = 0
    star.y = 0
    star.speed = speed
    star.dead = false
    local side = math.random(1, 4)
    if side == 1 then
     star.x = -30
     star.y = math.random(0, love.graphics.getHeight())
    elseif side == 2 then
     star.x = love.graphics.getWidth() + 30
     star.y = math.random(0, love.graphics.getHeight())
    elseif side == 3 then
     star.x = math.random(0, love.graphics.getWidth())
     star.y = -30
    elseif side == 4 then
     star.x = math.random(0, love.graphics.getWidth())
     star.y = love.graphics.getHeight() + 30
    end 
    star.direction = math.random() * 2 * math.pi
    table.insert(stars, star)
end
function Star:update(stars, speed, dt)
    timer = timer - dt
    if timer <= 0 then 
          Star:SpawnType1(stars, speed)
          maxTime = math.random() * 0.1 + 0.6
          timer = maxTime
    end 
    for i=#stars,1,-1 do
      local z = stars[i]
      if z.dead == true then
         table.remove(stars, i)
      end
    end
end
function Star:draw(stars)
   for i,z in ipairs(stars) do
     love.graphics.draw(sprites.zombie, z.x, z.y, z.direction, nil, nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
   end
end
return Star