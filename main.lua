Data = require("others/data")
local states = require("menus/mainmenus/states")
local menus = require("menus/mainmenus/menus")
function love.load()
    love.window.setFullscreen(true)
    if states[Data.currentState] and states[Data.currentState].load then
        states[Data.currentState].load()
    elseif Data.currentLevel and Data.currentLevel.load then
        Data.currentLevel.load()
    end
end
function love.update(dt)
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
end
function love.mousepressed(x, y, button)
    if Data.currentState and menus[Data.currentState] then
        menus[Data.currentState]:mousepressed(x, y, button, states)
    end
end
function love.keypressed(key)
    if key == 'f' then
        local fullscreen = not love.window.getFullscreen()
        love.window.setFullscreen(fullscreen)
    end
end