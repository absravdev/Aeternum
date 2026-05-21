local MainPlanetMenu = {}
MainPlanetMenu.__index = MainPlanetMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local button = love.graphics.newImage("sprites/buttons/buttons.png")
function MainPlanetMenu.new()
    local self = setmetatable({}, MainPlanetMenu)
    self.buttons = {
        {x = 850, y = 100, r = 67, text = "Frozen Domain"},
        {x = 640, y = 125, r = 90, text = "Scorched Moon"},
        {x = 386, y = 215, r = 115, text = "Dried Earth"},
        {x = 476, y = 485, r = 160, text = "Golden Hell"},
        {x = 870, y = 665, r = 220, text = "The Crimson Star"},
        {x = 1320, y = 530, r = 240, text = "back"},
    }
    return self
end
function MainPlanetMenu:draw()
    for i,v in ipairs(self.buttons) do
            love.graphics.print(v.text, (v.x + v.r/2)-150, (v.y + v.r/2)-50)
    end
end
function MainPlanetMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if v.r then
                if (x-v.x)^2 + (y-v.y)^2 < v.r^2 then
                    if v.text=="Frozen Domain" then
                        soundManager:playSound(1)
                        Data.currentState = "planet1planetmenu"
                    elseif v.text=="Scorched Moon" then
                        soundManager:playSound(1)
                        Data.currentState = "planet2planetmenu"
                    elseif v.text=="Dried Earth" then
                        soundManager:playSound(1)
                        Data.currentState = "planet3planetmenu"
                    elseif v.text=="Golden Hell" then
                        soundManager:playSound(1)
                        Data.currentState = "planet4planetmenu"
                    elseif v.text=="The Crimson Star" then
                        soundManager:playSound(1)
                        Data.currentState = "planet5planetmenu"
                    elseif v.text=="back" then
                        soundManager:playSound(1)
                        Data.currentState = "mainmenu"
                    end
                end
            end
        end
    end
end
return MainPlanetMenu
