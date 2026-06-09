local Planet5PlanetMenu = {}
Planet5PlanetMenu.__index = Planet5PlanetMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local CoopLauncher = require("network/cooplauncher")
local button = love.graphics.newImage("sprites/buttons/buttons.png")
function Planet5PlanetMenu.new()
    local self = setmetatable({}, Planet5PlanetMenu)
    self.buttons = {
        {x = 1148, y = 348, r = 31, text = "zone 1"},
        {x = 1270, y = 456, r = 78, text = "zone 2"},
        {x = 900, y = 520, r = 270, text = "zone 3"},
        {x = 100, y = 100, w = 200, h = 50, text = "back", sprite = button},
    }
    return self
end
function Planet5PlanetMenu:draw()
    for i,v in ipairs(self.buttons) do
        if v.sprite then
            love.graphics.draw(v.sprite, v.x, v.y)
            love.graphics.print(v.text, v.x + v.w/2, v.y + v.h/2)
        else
            love.graphics.print(v.text, (v.x + v.r/2)- 100, (v.y + v.r/2)-50)
        end
    end
end
local function launch(planet, zone, lvlNumber, soloLevel, s)
    -- no se puede rejugar un nivel ya superado: muestra "level completed" y no juega
    local already = Data["lvl" .. lvlNumber]
    if already and already.completed then
        Data.lvl = lvlNumber
        Data.currentlvl = lvlNumber
        Data.player.deadgameenemies = already.deadgameenemies or 0
        Data.levelbloq = false
        Data.currentState = "levelcompletedmenu"
        return
    end
    if CoopLauncher.isCoopActive() then
        CoopLauncher.requestStart(planet, zone)
    else
        Data.levelbloq = false
        Data.lvl = lvlNumber
        Data.player.deadgameenemies = 0
        Data.player.cometsintercepted = 0
        Data.player.lifepointsgained = 0
        Data.currentState = "game"
        Data.currentLevel = s["game"][soloLevel.planet][soloLevel.level]
    end
end
function Planet5PlanetMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if v.r then
                if (x-v.x)^2 + (y-v.y)^2 < v.r^2 then
                    if v.text=="zone 1" then
                        if Data.lvl1.completed and Data.lvl2.completed and Data.lvl3.completed and Data.lvl4.completed and Data.lvl5.completed and Data.lvl6.completed and Data.lvl7.completed and Data.lvl8.completed and Data.lvl9.completed and Data.lvl10.completed and Data.lvl11.completed and Data.lvl12.completed then
                            soundManager:playSound(1)
                            launch(5, 1, 13, {planet="planet5", level="level1"}, s)
                        else
                            Data.levelbloq = true
                        end
                    elseif v.text=="zone 2" then
                        if Data.lvl1.completed and Data.lvl2.completed and Data.lvl3.completed and Data.lvl4.completed and Data.lvl5.completed and Data.lvl6.completed and Data.lvl7.completed and Data.lvl8.completed and Data.lvl9.completed and Data.lvl10.completed and Data.lvl11.completed and Data.lvl12.completed and Data.lvl13.completed then
                            soundManager:playSound(1)
                            launch(5, 2, 14, {planet="planet5", level="level2"}, s)
                        else
                            Data.levelbloq = true
                        end
                    elseif v.text=="zone 3" then
                        if Data.lvl1.completed and Data.lvl2.completed and Data.lvl3.completed and Data.lvl4.completed and Data.lvl5.completed and Data.lvl6.completed and Data.lvl7.completed and Data.lvl8.completed and Data.lvl9.completed and Data.lvl10.completed and Data.lvl11.completed and Data.lvl12.completed and Data.lvl13.completed and Data.lvl14.completed then
                            soundManager:playSound(1)
                            launch(5, 3, 15, {planet="planet5", level="level3"}, s)
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
return Planet5PlanetMenu