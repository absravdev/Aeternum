local DrawStatsGameMenu = {}
DrawStatsGameMenu.__index = DrawStatsGameMenu
local font2 = love.graphics.newFont("fonts/alien.ttf", 20)
local font = love.graphics.newFont("fonts/alien.ttf", 25)
function DrawStatsGameMenu.new()
    local self = setmetatable({}, DrawStatsGameMenu)
    return self
end
function DrawStatsGameMenu:draw()
        local maxKills  = 0
        local levelsCompleted = 0
        for i = 1, 15 do
            local level = Data["lvl" .. i]
            if level and level.completed then
                levelsCompleted = levelsCompleted + 1
            end
        end
        Data.player.levelsCompleted = levelsCompleted
        if Data.lvl == 1 then
            maxKills  = Data.lvl1.maxKills
        elseif Data.lvl == 2 then
            maxKills  = Data.lvl2.maxKills
        elseif Data.lvl == 3 then
            maxKills  = Data.lvl3.maxKills
        elseif Data.lvl == 4 then
            maxKills  = Data.lvl4.maxKills
        elseif Data.lvl == 5 then
            maxKills  = Data.lvl5.maxKills
        elseif Data.lvl == 6 then
            maxKills  = Data.lvl6.maxKills
        elseif Data.lvl == 7 then
            maxKills  = Data.lvl7.maxKills
        elseif Data.lvl == 8 then
            maxKills  = Data.lvl8.maxKills
        elseif Data.lvl == 9 then
            maxKills  = Data.lvl9.maxKills
        elseif Data.lvl == 10 then
            maxKills  = Data.lvl10.maxKills
        elseif Data.lvl == 11 then
            maxKills  = Data.lvl11.maxKills
        elseif Data.lvl == 12 then
            maxKills  = Data.lvl12.maxKills
        elseif Data.lvl == 13 then
            maxKills  = Data.lvl13.maxKills
        elseif Data.lvl == 14 then
            maxKills  = Data.lvl14.maxKills
        elseif Data.lvl == 15 then
            maxKills  = Data.lvl15.maxKills
        end
        love.graphics.setFont(font2)
        love.graphics.print("LIFEPOINTS: " .. Data.player.lifepoints , 20, 20)
        love.graphics.print("GAMEKILLS: " .. Data.player.deadgameenemies .. " / " .. maxKills, 20, 40)
        love.graphics.setFont(font)
end
return DrawStatsGameMenu