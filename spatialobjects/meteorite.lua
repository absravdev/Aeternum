Meteorite = {}
Meteorite.__index = Meteorite
local maxTime = math.random() * 20 + 10
local timer = maxTime
local meteoritesprite = love.graphics.newImage("sprites/blackhole.png")
function Meteorite:SpawnType1(meteorites)
    local meteorite = {}
    meteorite.dead = false
    meteorite.x = math.random() * love.graphics.getWidth()
    meteorite.y = math.random() * love.graphics.getHeight()
    meteorite.radius = math.random() * 300 + 100
    meteorite.lifeTimer = 3.5
    meteorite.drawTimer = 1.5
    
    table.insert(meteorites, meteorite)
end
function Meteorite:update(meteorites, dt)
    timer = timer - dt
    if timer <= 0 then 
        Meteorite:SpawnType1(meteorites)
        maxTime = math.random() * 10 + 5
        timer = maxTime
    end 
    for i=#meteorites,1,-1 do
      local m = meteorites[i]
      m.lifeTimer = m.lifeTimer - dt
      if m.lifeTimer <= 0 then
         m.dead = true
      end
      m.drawTimer = m.drawTimer - dt
      if m.dead == true then
         table.remove(meteorites, i)
      end
    end
  end
function Meteorite:draw(meteorites)
  for i,m in ipairs(meteorites) do
    if m.drawTimer >= 0 then
    love.graphics.setColor(128/255, 128/255, 128/255, 0.5)
    love.graphics.circle('fill', m.x, m.y, m.radius)
    love.graphics.setColor(1, 1, 1, 1)
    end
  if m.drawTimer <= 0 then
      love.graphics.setColor(1, 1, 1, 1)
      local scale = m.radius * 2 / meteoritesprite:getWidth()
      love.graphics.draw(meteoritesprite, m.x, m.y, 0, scale, scale, meteoritesprite:getWidth() / 2, meteoritesprite:getHeight() / 2)
    end
  end
end
return Meteorite


