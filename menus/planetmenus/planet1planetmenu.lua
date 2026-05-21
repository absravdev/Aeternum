local Planet1PlanetMenu = {}
Planet1PlanetMenu.__index = Planet1PlanetMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local button = love.graphics.newImage("sprites/buttons/buttons.png")
function Planet1PlanetMenu.new()
    local self = setmetatable({}, Planet1PlanetMenu)
    self.buttons = {
        {x = 1148, y = 348, r = 31, text = "zone 1"},
        {x = 1270, y = 456, r = 78, text = "zone 2"},
        {x = 900, y = 520, r = 270, text = "zone 3"},
        {x = 100, y = 100, w = 200, h = 50, text = "back", sprite = button},
    }
    return self
end
function Planet1PlanetMenu:draw()
    for i,v in ipairs(self.buttons) do
        if v.sprite then
            love.graphics.draw(v.sprite, v.x, v.y)
            love.graphics.print(v.text, v.x + v.w/2, v.y + v.h/2)
        else
            love.graphics.print(v.text, (v.x + v.r/2)- 100, (v.y + v.r/2)-50)
        end
    end
end
function Planet1PlanetMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if v.r then
                if (x-v.x)^2 + (y-v.y)^2 < v.r^2 then
                    if v.text=="zone 1" then
                        soundManager:playSound(1)
                        Data.levelbloq = false
                        Data.lvl = 1
                        Data.player.deadgameenemies = 0
                        Data.player.cometsintercepted = 0
                        Data.player.lifepointsgained = 0
                        Data.currentState = "game"
                        Data.currentLevel = s[Data.currentState].planet1.level1
                    elseif v.text=="zone 2" then
                        if Data.lvl1.completed then
                        soundManager:playSound(1)
                            Data.levelbloq = false
                            Data.lvl = 2
                            Data.player.deadgameenemies = 0
                            Data.player.cometsintercepted = 0
                            Data.player.lifepointsgained = 0
                            Data.currentState = "game"
                            Data.currentLevel = s[Data.currentState].planet1.level2
                        else
                            Data.levelbloq = true
                        end
                    elseif v.text=="zone 3" then
                        if Data.lvl1.completed and Data.lvl2.completed  then
                        soundManager:playSound(1)
                            Data.levelbloq = false
                            Data.lvl = 3
                            Data.player.deadgameenemies = 0
                            Data.player.cometsintercepted = 0
                            Data.player.lifepointsgained = 0
                            Data.currentState = "game"
                            Data.currentLevel = s[Data.currentState].planet1.level3
                        else
                            Data.levelbloq = true
                        end
                    end
                end
            elseif v.w and v.h then
                if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h then
                    Data.currentState = "mainplanetmenu"
                    Data.levelbloq = false
                end
            end
        end
    end
end
return Planet1PlanetMenu