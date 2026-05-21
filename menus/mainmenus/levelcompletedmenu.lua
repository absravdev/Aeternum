local LevelCompletedMenu = {}
LevelCompletedMenu.__index = LevelCompletedMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local alienskilled
local cometsintercepted
local pointscalculator
local sprite = love.graphics.newImage("sprites/buttons/buttons.png")
local font2 = love.graphics.newFont("fonts/alien.ttf", 120)
local font = love.graphics.newFont("fonts/alien.ttf", 25)
function LevelCompletedMenu.new()
    local self = setmetatable({}, LevelCompletedMenu)
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "OK", sprite = sprite},
    }
    return self
end
function LevelCompletedMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) , (v.y + v.h / 2))
    end
    if Data.lvl == 1 and Data.lvl1.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl1.deadgameenemies = alienskilled
        Data.lvl1.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl1.deadgameenemies+(Data.lvl1.cometsintercepted*3)+(Data.lvl1.lifepointsgained*2))*3)
        Data.lvl1.points = pointscalculator
    elseif Data.lvl == 2 and Data.lvl2.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl2.deadgameenemies = alienskilled
        Data.lvl2.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl2.deadgameenemies+(Data.lvl2.cometsintercepted*3)+(Data.lvl2.lifepointsgained*2))*3)
        Data.lvl2.points = pointscalculator 
    elseif Data.lvl == 3 and Data.lvl3.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl3.deadgameenemies = alienskilled
        Data.lvl3.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl3.deadgameenemies+(Data.lvl3.cometsintercepted*3)+(Data.lvl3.lifepointsgained*2))*3)
        Data.lvl3.points = pointscalculator
    elseif Data.lvl == 4 and Data.lvl4.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl4.deadgameenemies = alienskilled
        Data.lvl4.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl4.deadgameenemies+(Data.lvl4.cometsintercepted*3)+(Data.lvl4.lifepointsgained*2))*3)
        Data.lvl4.points = pointscalculator
        local a = true
    elseif Data.lvl == 5 and Data.lvl5.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl5.deadgameenemies = alienskilled
        Data.lvl5.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl5.deadgameenemies+(Data.lvl5.cometsintercepted*3)+(Data.lvl5.lifepointsgained*2))*3)
        Data.lvl5.points = pointscalculator
        local a = true
    elseif Data.lvl == 6 and Data.lvl6.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl6.deadgameenemies = alienskilled
        Data.lvl6.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl6.deadgameenemies+(Data.lvl6.cometsintercepted*3)+(Data.lvl6.lifepointsgained*2))*3)
        Data.lvl6.points = pointscalculator
    elseif Data.lvl == 7 and Data.lvl7.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl7.deadgameenemies = alienskilled
        Data.lvl7.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl7.deadgameenemies+(Data.lvl7.cometsintercepted*3)+(Data.lvl7.lifepointsgained*2))*3)
        Data.lvl7.points = pointscalculator
    elseif Data.lvl == 8 and Data.lvl8.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl8.deadgameenemies = alienskilled
        Data.lvl8.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl8.deadgameenemies+(Data.lvl8.cometsintercepted*3)+(Data.lvl8.lifepointsgained*2))*3)
        Data.lvl8.points = pointscalculator
    elseif Data.lvl == 9 and Data.lvl9.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl9.deadgameenemies = alienskilled
        Data.lvl9.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl9.deadgameenemies+(Data.lvl9.cometsintercepted*3)+(Data.lvl9.lifepointsgained*2))*3)
        Data.lvl9.points = pointscalculator
    elseif Data.lvl == 10 and Data.lvl10.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl10.deadgameenemies = alienskilled
        Data.lvl10.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl10.deadgameenemies+(Data.lvl10.cometsintercepted*3)+(Data.lvl10.lifepointsgained*2))*3)
        Data.lvl10.points = pointscalculator
    elseif Data.lvl == 11 and Data.lvl11.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl11.deadgameenemies = alienskilled
        Data.lvl11.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl11.deadgameenemies+(Data.lvl11.cometsintercepted*3)+(Data.lvl11.lifepointsgained*2))*3)
        Data.lvl11.points = pointscalculator
    elseif Data.lvl == 12 and Data.lvl12.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl12.deadgameenemies = alienskilled
        Data.lvl12.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl12.deadgameenemies+(Data.lvl12.cometsintercepted*3)+(Data.lvl12.lifepointsgained*2))*3)
        Data.lvl12.points = pointscalculator
    elseif Data.lvl == 13 and Data.lvl13.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl13.deadgameenemies = alienskilled
        Data.lvl13.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl13.deadgameenemies+(Data.lvl13.cometsintercepted*3)+(Data.lvl13.lifepointsgained*2))*3)
        Data.lvl13.points = pointscalculator
    elseif Data.lvl == 14 and Data.lvl14.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl14.deadgameenemies = alienskilled
        Data.lvl14.cometsintercepted = cometsintercepted
        pointscalculator = ((Data.lvl14.deadgameenemies+(Data.lvl14.cometsintercepted*3)+(Data.lvl14.lifepointsgained*2))*3)
        Data.lvl14.points = pointscalculator
    elseif Data.lvl == 15 and Data.lvl15.completed then
        alienskilled = Data.player.deadgameenemies
        cometsintercepted = Data.player.cometsintercepted
        Data.lvl15.deadgameenemies = alienskilled
        Data.lvl15.cometsintercepted = cometsintercepted
        pointscalculator = (Data.lvl15.deadgameenemies+(Data.lvl15.cometsintercepted*3)+(Data.lvl15.lifepointsgained*2)*3)
        Data.lvl15.points = pointscalculator
    end
    if Data.lvl == 1 and Data.lvl1.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl1.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl1.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl1.points, 600, 650)
    elseif Data.lvl == 2 and Data.lvl2.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl2.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl2.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl2.points, 600, 650)
    elseif Data.lvl == 3 and Data.lvl3.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl3.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl3.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl3.points, 600, 650)
    elseif Data.lvl == 4 and Data.lvl4.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl4.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl4.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl4.points, 600, 650)
    elseif Data.lvl == 5 and Data.lvl5.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl5.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl5.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl5.points, 600, 650)
    elseif Data.lvl == 6  and Data.lvl6.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl6.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl6.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl6.points, 600, 650)
    elseif Data.lvl == 7 and Data.lvl7.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl7.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl7.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL POINTS: " .. Data.lvl7.points, 600, 650)
    elseif Data.lvl == 8  and Data.lvl8.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl8.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl8.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl8.points, 600, 650)
    elseif Data.lvl == 9  and Data.lvl9.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl9.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl9.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl9.points, 600, 650)
    elseif Data.lvl == 10  and Data.lvl10.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl10.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl10.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl10.points, 600, 650)
    elseif Data.lvl == 11  and Data.lvl11.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl11.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl11.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl11.points, 600, 650)
    elseif Data.lvl == 12  and Data.lvl12.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl12.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl12.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl12.points, 600, 650)
    elseif Data.lvl == 13  and Data.lvl13.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl13.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl13.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl13.points, 600, 650)
    elseif Data.lvl == 14  and Data.lvl14.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl14.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl14.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl14.points, 600, 650)
    elseif Data.lvl == 15  and Data.lvl15.completed then
        love.graphics.setFont(font2)
        love.graphics.print("LEVEL " .. Data.lvl .. " COMPLETED", 170, 250)
        love.graphics.setFont(font)
        love.graphics.print("ALIENS KILLED: " .. Data.lvl15.deadgameenemies, 600, 500)
        love.graphics.print("COMETS INTERCEPTED: " .. Data.lvl15.cometsintercepted, 600, 550)
        love.graphics.print("TOTAL GAMEPOINTS WON: " .. Data.lvl15.points, 600, 650)
    end
end
function LevelCompletedMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="OK" then
                    soundManager:playSound(1)
                    Data.currentState = "mainplanetmenu"
                end
            end
        end
    end
end
return LevelCompletedMenu




