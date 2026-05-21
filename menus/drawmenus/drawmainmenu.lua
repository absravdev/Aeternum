local DrawStatsMainMenu = {}
DrawStatsMainMenu.__index = DrawStatsMainMenu
local font2 = love.graphics.newFont("fonts/alien.ttf", 20)
local font = love.graphics.newFont("fonts/alien.ttf", 25)
-- Mueve la declaración de 'timer' aquí
local timer = 0
local a = true
local b = true
local c = true
local d = true
local e = true
local f = true
local g = true
local h = true
local i = true
local j = true
local k = true
local l = true
local m = true
local n = true
local o = true
function DrawStatsMainMenu.new()
    local self = setmetatable({}, DrawStatsMainMenu)
    return self
end
function DrawStatsMainMenu:draw(dt)
    if Data.lvl == 1 and Data.lvl1.completed and a then
        Data.player.money = Data.player.money + Data.lvl1.points
        a = false
    elseif Data.lvl == 2 and Data.lvl2.completed and b then
        Data.player.money = Data.player.money + Data.lvl2.points
        b = false
    elseif Data.lvl == 3 and Data.lvl3.completed and c then
        Data.player.money = Data.player.money + Data.lvl3.points
        c = false
    elseif Data.lvl == 4 and Data.lvl4.completed and d then
        Data.player.money = Data.player.money + Data.lvl4.points
        d = false
    elseif Data.lvl == 5 and Data.lvl5.completed and e then
        Data.player.money = Data.player.money + Data.lvl5.points
        e = false
    elseif Data.lvl == 6 and Data.lvl6.completed and f then
        Data.player.money = Data.player.money + Data.lvl6.points
        f = false
    elseif Data.lvl == 7 and Data.lvl7.completed and g then
        Data.player.money = Data.player.money + Data.lvl7.points
        g = false
    elseif Data.lvl == 8 and Data.lvl8.completed and h then
        Data.player.money = Data.player.money + Data.lvl8.points
        h = false
    elseif Data.lvl == 9 and Data.lvl9.completed and i then
        Data.player.money = Data.player.money + Data.lvl9.points
        i = false
    elseif Data.lvl == 10 and Data.lvl10.completed and j then
        Data.player.money = Data.player.money + Data.lvl10.points
        j = false
    elseif Data.lvl == 11 and Data.lvl11.completed and k then
        Data.player.money = Data.player.money + Data.lvl11.points
        k = false
    elseif Data.lvl == 12 and Data.lvl12.completed and l then
        Data.player.money = Data.player.money + Data.lvl12.points
        l = false
    elseif Data.lvl == 13 and Data.lvl13.completed and m then
        Data.player.money = Data.player.money + Data.lvl13.points
        m = false
    elseif Data.lvl == 14 and Data.lvl14.completed and n then
        Data.player.money = Data.player.money + Data.lvl14.points
        n = false
    elseif Data.lvl == 15 and Data.lvl15.completed and o then
        Data.player.money = Data.player.money + Data.lvl15.points
        o = false
    end
    local levelsCompleted = 0
    for i = 1, 15 do
        local level = Data["lvl" .. i]
        if level and level.completed then
            levelsCompleted = levelsCompleted + 1
        end
    end
    love.graphics.setFont(font2)
    love.graphics.print("LIFEPOINTS: " .. Data.player.lifepoints , 20, 20)
    love.graphics.print("DARK MATTER: " .. Data.player.money , 20, 40)
    love.graphics.print("LEVELS COMPLETED: " .. levelsCompleted .. "/15", 20, 60)
        if Data.levelbloq then
            love.graphics.print("LEVEL BLOQ", 200, 200)
        end
    love.graphics.setFont(font)
end
return DrawStatsMainMenu
