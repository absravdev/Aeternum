local MainOptionsMenu = {}
MainOptionsMenu.__index = MainOptionsMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local sprite = love.graphics.newImage("sprites/buttons/buttons.png")
function MainOptionsMenu.new()
    local self = setmetatable({}, MainOptionsMenu)
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "Exit Game", sprite = sprite},
        {x = 100, y = 200, w = 200, h = 50, text = "Back", sprite = sprite},
    }
    return self
end
function MainOptionsMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text,(v.x+v.w/2)-80,(v.y+v.h/2-7))
    end
end
function MainOptionsMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="Back" then
                    soundManager:playSound(1)
                    Data.currentState = "mainmenu"
                elseif v.text=="Exit Game" then
                    soundManager:playSound(1)
                    love.event.quit()
                end
            end
        end
    end
end
return MainOptionsMenu
