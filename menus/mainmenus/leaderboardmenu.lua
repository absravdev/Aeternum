local LeaderboardMenu = {}
LeaderboardMenu.__index = LeaderboardMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local Leaderboard = require("network/leaderboard")
local sprite = love.graphics.newImage("sprites/buttons/buttons.png")
local font2 = love.graphics.newFont("fonts/alien.ttf", 60)
local font  = love.graphics.newFont("fonts/alien.ttf", 25)

function LeaderboardMenu.new()
    local self = setmetatable({}, LeaderboardMenu)
    self.buttons = {
        { x = 100, y = 100, w = 200, h = 50, text = "back", sprite = sprite },
    }
    return self
end

function LeaderboardMenu:draw()
    love.graphics.setFont(font2)
    love.graphics.print("GLOBAL RECORDS", 400, 30)
    love.graphics.setFont(font)

    for _, v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2,
                                     v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) - 40, (v.y + v.h / 2) - 7)
    end

    if Leaderboard.status == "loading" then
        love.graphics.print("Loading...", 400, 200)
        return
    elseif Leaderboard.status == "error" then
        love.graphics.print("No se pudo conectar al servidor", 400, 200)
        return
    end
    
    love.graphics.print("#",       400, 170)
    love.graphics.print("NAME",    450, 170)
    love.graphics.print("LIFE",    780, 170)
    love.graphics.print("ALIENS", 940, 170)
    love.graphics.print("COMETS", 1110, 170)

    local y = 220
    for i, e in ipairs(Leaderboard.general or {}) do
        love.graphics.print(i,                           400, y)
        love.graphics.print(tostring(e.name),            450, y)
        love.graphics.print(tostring(e.lifepoints or 0), 780, y)
        love.graphics.print(tostring(e.aliens or 0),    940, y)
        love.graphics.print(tostring(e.comets or 0),    1110, y)
        y = y + 40
    end
end

function LeaderboardMenu:mousepressed(x, y, b, s)
    if b == 1 then
        for _, v in ipairs(self.buttons) do
            if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h then
                if v.text == "back" then
                    soundManager:playSound(1)
                    Data.currentState = "mainmenu"
                end
            end
        end
    end
end

return LeaderboardMenu