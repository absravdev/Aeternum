local DrawGameWinMenu = {}
DrawGameWinMenu.__index = DrawGameWinMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local sprite = love.graphics.newImage("sprites/buttons/buttons.png")
local font2 = love.graphics.newFont("fonts/alien.ttf", 120)
local font = love.graphics.newFont("fonts/alien.ttf", 25)
function DrawGameWinMenu.new()
    local self = setmetatable({}, DrawGameWinMenu)
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "EXIT", sprite = sprite}
    }
    return self
end
function DrawGameWinMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) , (v.y + v.h / 2))
    end
    love.graphics.setFont(font2)
    love.graphics.print("GAME COMPLETED", 200, 250)
    love.graphics.setFont(font)
    love.graphics.print("LEFTOVER LIFE POINTS: " .. Data.player.lifepoints .. "/200", 600, 500)
end
function DrawGameWinMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="EXIT" then
                    soundManager:playSound(1)
                    love.event.quit()
                end
            end
        end
    end
end
return DrawGameWinMenu