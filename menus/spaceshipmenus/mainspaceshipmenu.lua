local MainSpaceshipMenu = {}
MainSpaceshipMenu.__index = MainSpaceshipMenu
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
function MainSpaceshipMenu.new()
    local self = setmetatable({}, MainSpaceshipMenu)
    local laserSprite = love.graphics.newImage("sprites/buttons/buttons.png")
    local bombSprite  = love.graphics.newImage("sprites/buttons/buttons.png")
    local shieldSprite  = love.graphics.newImage("sprites/buttons/buttons.png")
    local speedSprite = love.graphics.newImage("sprites/buttons/buttons.png")
    local speedMovement = love.graphics.newImage("sprites/buttons/buttons.png")
    local firerateSprite = love.graphics.newImage("sprites/buttons/buttons.png")
    local backSprite = love.graphics.newImage("sprites/buttons/buttons.png")
    self.buttons = {
        {x = 100, y = 100, w = 200, h = 50, text = "laser", sprite = laserSprite},
        {x = 100, y = 200, w = 200, h = 50, text = "bomb", sprite = bombSprite},
        {x = 100, y = 300, w = 200, h = 50, text = "shield", sprite = shieldSprite},
        {x = 100, y = 400, w = 200, h = 50, text = "sp.bullet", sprite = speedSprite},
        {x = 100, y = 500, w = 200, h = 50, text = "sp.movement", sprite = speedMovement},
        {x = 100, y = 600, w = 200, h = 50, text = "fire rate", sprite = firerateSprite},
        {x = 100, y = 750, w = 200, h = 50, text = "back", sprite = backSprite},
    }
    return self
end
function MainSpaceshipMenu:draw()
    for i,v in ipairs(self.buttons) do
        love.graphics.draw(v.sprite, v.x + v.w / 2 - v.sprite:getWidth() / 2, v.y + v.h / 2 - v.sprite:getHeight() / 2)
        love.graphics.print(v.text, (v.x + v.w / 2) -80, (v.y + v.h / 2)-7)
    end
end
function MainSpaceshipMenu:mousepressed(x,y,b,s)
    if b==1 then
        for i,v in ipairs(self.buttons) do
            if x>v.x and x<v.x+v.w and y>v.y and y<v.y+v.h then
                print("Has hecho clic en el "..v.text)
                if v.text=="back" then
                    soundManager:playSound(1)
                    Data.currentState = "mainmenu"
                elseif v.text=="laser" then
                    soundManager:playSound(1)
                    Data.currentState = "laserspaceshipmenu"
                elseif v.text=="bomb" then
                    soundManager:playSound(1)
                    Data.currentState = "bombspaceshipmenu"
                elseif v.text=="shield" then
                    soundManager:playSound(1)
                    Data.currentState = "shieldspaceshipmenu"
                elseif v.text=="sp.bullet" then
                    soundManager:playSound(1)
                    Data.currentState = "speedbulletspaceshipmenu"
                elseif v.text=="sp.movement" then
                    soundManager:playSound(1)
                    Data.currentState = "speedmovementspaceshipmenu"
                elseif v.text=="fire rate" then
                    soundManager:playSound(1)
                    Data.currentState = "fireratespaceshipmenu"
                end
            end
        end
    end
end
return MainSpaceshipMenu