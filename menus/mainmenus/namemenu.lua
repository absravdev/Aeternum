local NameMenu = {}
NameMenu.__index = NameMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local sprite = love.graphics.newImage("sprites/buttons/buttons.png")
local font2 = love.graphics.newFont("fonts/alien.ttf", 60)
local font  = love.graphics.newFont("fonts/alien.ttf", 25)

function NameMenu.new()
    local self = setmetatable({}, NameMenu)
    self.input  = ""
    self.maxLen = 16
    self.buttons = {
        { x = 150, y = 400, w = 200, h = 50, text = "OK", sprite = sprite },
    }
    return self
end

function NameMenu:draw()
    love.graphics.setFont(font2)
    love.graphics.print("ENTER YOUR NAME", 150, 150)
    love.graphics.setFont(font)

    love.graphics.rectangle("line", 150, 280, 500, 50)
    love.graphics.print(self.input .. "_", 165, 293)

    for _, v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2,
                                     v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) - 20, (v.y + v.h / 2) - 7)
    end
end

function NameMenu:textinput(t)
    if #self.input < self.maxLen then
        self.input = self.input .. t
    end
end

function NameMenu:keypressed(key)
    if key == "backspace" then
        self.input = self.input:sub(1, -2)
    elseif key == "return" then
        self:confirm()
    end
end

function NameMenu:confirm()
    local name = self.input:gsub("^%s+", ""):gsub("%s+$", "")
    if name == "" then return end
    Data.player.name = name
    love.filesystem.write("playername.txt", name)
    soundManager:playSong(1)
    Data.currentState = "startgamemenu"
end

function NameMenu:mousepressed(x, y, b, s)
    if b == 1 then
        for _, v in ipairs(self.buttons) do
            if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h then
                if v.text == "OK" then self:confirm() end
            end
        end
    end
end

return NameMenu