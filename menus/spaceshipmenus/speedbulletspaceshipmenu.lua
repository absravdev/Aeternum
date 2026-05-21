local SpeedBulletSpaceshipMenu = {}
SpeedBulletSpaceshipMenu.__index = SpeedBulletSpaceshipMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
function SpeedBulletSpaceshipMenu.new()
    local self = setmetatable({}, SpeedBulletSpaceshipMenu)
    -- Inicializa los sprites aquí
    local lvl2SpriteLocked = love.graphics.newImage("sprites/buttons/buttons.png")
    local lvl3SpriteLocked  = love.graphics.newImage("sprites/buttons/buttons.png")
    local lvl4SpriteLocked  = love.graphics.newImage("sprites/buttons/buttons.png")
    local spriteBack = love.graphics.newImage("sprites/buttons/buttons.png")

    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "up.lvl2", sprite = lvl2SpriteLocked},
        {x = 100, y = 200, w = 200, h = 50, text = "up.lvl3", sprite = lvl3SpriteLocked},
        {x = 100, y = 300, w = 200, h = 50, text = "up.lvl4", sprite = lvl4SpriteLocked},
        {x = 100, y = 450, w = 200, h = 50, text = "back", sprite = spriteBack},
    }

    return self
end
function SpeedBulletSpaceshipMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) -80, (v.y + v.h / 2)-7)
    end
end
function SpeedBulletSpaceshipMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            local a = false
            local x1, x2, x3, x4
            x1 = Data.player.money
            x2 = Data.speedbullet.lvl2.current
            x3 = Data.speedbullet.lvl3.current
            x4 = Data.speedbullet.lvl4.current
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="back" then
                    soundManager:playSound(1)
                    Data.currentState = "mainspaceshipmenu"
                elseif v.text=="up.lvl2" then
                    if x1 >= Data.powerscost.speedbullet.lvl1 and x2 == false then
                        soundManager:playSound(1)
                        Data.speedbullet.lvl2.current = true
                        Data.speedbullet.lvl = 2
                        Data.player.money = Data.player.money - Data.powerscost.speedbullet.lvl1
                        a = true
                    end 
                elseif v.text=="up.lvl3" then
                    if x1 >= Data.powerscost.speedbullet.lvl2 and x3 == false and Data.speedbullet.lvl2.current then
                        soundManager:playSound(1)
                        Data.speedbullet.lvl3.current = true
                        Data.speedbullet.lvl = 3
                        Data.player.money = Data.player.money - Data.powerscost.speedbullet.lvl2
                        a = true
                    end 
                elseif v.text=="up.lvl4" then
                    if x1 >= Data.powerscost.speedbullet.lvl3 and x4 == false and Data.speedbullet.lvl3.current then
                        soundManager:playSound(1)
                        Data.speedbullet.lvl4.current = true
                        Data.speedbullet.lvl = 4
                        Data.player.money = Data.player.money - Data.powerscost.speedbullet.lvl3
                        a = true
                    end 
                end
            end
            if a then
                table.remove(self.buttons, i)
            end
        end
    end
end
return SpeedBulletSpaceshipMenu