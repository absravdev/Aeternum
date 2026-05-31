local MainMenu = {}
MainMenu.__index = MainMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
function MainMenu.new()
    local self = setmetatable({}, MainMenu)
    local button = love.graphics.newImage("sprites/buttons/buttons.png")
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "planets", sprite = button},
        {x = 100, y = 200, w = 200, h = 50, text = "spaceship", sprite = button},
        {x = 100, y = 300, w = 200, h = 50, text = "options", sprite = button},
        {x = 100, y = 400, w = 200, h = 50, text = "records", sprite = button},
    }
    return self
end
function MainMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) - 80, (v.y + v.h / 2)-7)
    end
end
function MainMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="planets" then
                    soundManager:playSound(1)
                    Data.currentState = "mainplanetmenu"
                elseif v.text=="spaceship" then
                    soundManager:playSound(1)
                    Data.currentState = "mainspaceshipmenu"
                elseif v.text=="options" then
                    soundManager:playSound(1)
                    Data.currentState = "mainoptionsmenu"
                elseif v.text=="records" then
                    soundManager:playSound(1)
                    local Leaderboard = require("network/leaderboard")
                    Leaderboard.view = "general"
                    Leaderboard.fetchGeneral(10)
                    Data.currentState = "leaderboardmenu"
                end
            end
        end
    end
end
return MainMenu