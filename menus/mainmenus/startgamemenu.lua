local StartGameMenu = {}
StartGameMenu.__index = StartGameMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local font2 = love.graphics.newFont("fonts/alien.ttf", 120)
local font = love.graphics.newFont("fonts/alien.ttf", 25)
function StartGameMenu.new()
    local self = setmetatable({}, StartGameMenu)
    local startGame = love.graphics.newImage("sprites/buttons/buttons.png")
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "start game", sprite = startGame},
    }
    return self
end
function StartGameMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) - 80 , (v.y + v.h / 2)- 7)
    end
    love.graphics.print("Press 'f'", 200, 300)
    love.graphics.setFont(font2)
    love.graphics.print("AETERNUM", 150, 600)
    love.graphics.setFont(font)
end
function StartGameMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="start game" then
                    soundManager:playSound(1)
                    Data.currentState = "mainmenu"
                end
            end
        end
    end
end
return StartGameMenu