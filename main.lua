Data = require("others/data")
local states = require("menus/mainmenus/states")
local menus = require("menus/mainmenus/menus")
local Leaderboard = require("network/leaderboard")
local CoopLauncher = require("network/cooplauncher")
function love.load()
    love.window.setFullscreen(true)
    love.keyboard.setTextInput(true)
    Leaderboard.init()
    if love.filesystem.getInfo("playername.txt") then
        Data.player.name = love.filesystem.read("playername.txt")
    end
    if not Data.player.name or Data.player.name == "" then
        Data.currentState = "namemenu"
    end
    if states[Data.currentState] and states[Data.currentState].load then
        states[Data.currentState].load()
    elseif Data.currentLevel and Data.currentLevel.load then
        Data.currentLevel.load()
    end
end
function love.update(dt)
    CoopLauncher.update()
    Leaderboard.update()
    if states[Data.currentState] and states[Data.currentState].update then
        states[Data.currentState].update(dt)
    elseif Data.currentLevel and Data.currentLevel.update then
        Data.currentLevel.update(dt)
    end
end
function love.draw()
    if states[Data.currentState] and states[Data.currentState].draw then
        states[Data.currentState].draw()
    elseif Data.currentLevel and Data.currentLevel.draw then
        Data.currentLevel.draw()
    end
    CoopLauncher.draw()
end
function love.mousepressed(x, y, button)
    if CoopLauncher.mousepressed(x, y, button) then return end
    if Data.currentState and menus[Data.currentState] then
        menus[Data.currentState]:mousepressed(x, y, button, states)
    end
end
function love.textinput(t)
    if CoopLauncher.textinput(t) then return end
    if Data.currentState and menus[Data.currentState] and menus[Data.currentState].textinput then
        menus[Data.currentState]:textinput(t)
    end
end

function love.keypressed(key)
    if CoopLauncher.keypressed(key) then return end
    if key == 'f' then
        local fullscreen = not love.window.getFullscreen()
        love.window.setFullscreen(fullscreen)
    end
    if Data.currentState and menus[Data.currentState] and menus[Data.currentState].keypressed then
        menus[Data.currentState]:keypressed(key)
    end
end