Player = {}
Player.__index = Player
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()

local playerlvl1 = love.graphics.newImage('sprites/player/player1.png')
local playerlvl2 = love.graphics.newImage('sprites/player/player2.png')
local playerlvl3 = love.graphics.newImage('sprites/player/player3.png')
local playerlvl4 = love.graphics.newImage('sprites/player/player4.png')

local sprites = {}
sprites.shieldlvl1sprite = love.graphics.newImage("sprites/powers/shieldlvl1.png")
sprites.shieldlvl2sprite = love.graphics.newImage("sprites/powers/shieldlvl2.png")
sprites.shieldlvl3sprite = love.graphics.newImage("sprites/powers/shieldlvl3.png")
sprites.shieldlvl4sprite = love.graphics.newImage("sprites/powers/shieldlvl4.png")
sprites.bombsprite = love.graphics.newImage("sprites/powers/spritebomb.png")

local scaleX = 1.3
local scaleY = 1.3

function Player.new(speed)
    Data.player.lvl = math.min(Data.shield.lvl, Data.bomb.lvl, Data.gun.lvl)
    if Data.player.lvl == 1 then
        sprites.playerlvl0 = playerlvl1
    elseif Data.player.lvl == 2 then
        sprites.playerlvl0 = playerlvl2
    elseif Data.player.lvl == 3 then
        sprites.playerlvl0 = playerlvl3
    elseif Data.player.lvl == 4 then
        sprites.playerlvl0 = playerlvl4
    end

    local radius
    if Data.bomb.lvl == 1 then radius = Data.bomb.lvl1.radius
    elseif Data.bomb.lvl == 2 then radius = Data.bomb.lvl2.radius
    elseif Data.bomb.lvl == 3 then radius = Data.bomb.lvl3.radius
    elseif Data.bomb.lvl == 4 then radius = Data.bomb.lvl4.radius end

    if Data.speedmovement.lvl == 1 then speed = Data.speedmovement.lvl1.value
    elseif Data.speedmovement.lvl == 2 then speed = Data.speedmovement.lvl2.value
    elseif Data.speedmovement.lvl == 3 then speed = Data.speedmovement.lvl3.value
    elseif Data.speedmovement.lvl == 4 then speed = Data.speedmovement.lvl4.value end

    local self = setmetatable({}, Player)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.speed = speed
    self.radio = 25
    self.bombRadius = radius        -- antes era una local de módulo; ahora va por jugador
    self.aim = 0                    -- NUEVO: ángulo de apuntado
    self.invulnerable = false
    self.shieldActive = false       -- NUEVO: estado de poderes POR JUGADOR
    self.gunActive = false
    self.bombActive = false
    return self
end

-- Si no se pasa input, se construye desde teclado/ratón (comportamiento de antes).
local function defaultInput(self)
    local mx, my = love.mouse.getPosition()
    return {
        up    = love.keyboard.isDown("w"),
        down  = love.keyboard.isDown("s"),
        left  = love.keyboard.isDown("a"),
        right = love.keyboard.isDown("d"),
        aim   = math.atan2(self.y - my, self.x - mx) + math.pi,
    }
end

function Player:update(dt, input)
    input = input or defaultInput(self)

    if input.right and self.x < love.graphics.getWidth() then
        self.x = self.x + self.speed * dt
    end
    if input.left and self.x > 5 then
        self.x = self.x - self.speed * dt
    end
    if input.up and self.y > 5 then
        self.y = self.y - self.speed * dt
    end
    if input.down and self.y < love.graphics.getHeight() then
        self.y = self.y + self.speed * dt
    end
    if input.aim then self.aim = input.aim end

    -- Suenan según los poderes DE ESTE jugador (ya no globales).
    if self.shieldActive then soundManager:playSound(3) end
    if self.bombActive then soundManager:playSound(5) end
    if self.gunActive then soundManager:playSound(4) end
end

function Player:draw()
    local angle = self.aim
    local cx = sprites.playerlvl0:getWidth() / 2
    local cy = sprites.playerlvl0:getHeight() / 2

    -- ESCUDO (detrás de la nave)
    if self.shieldActive then
        local shieldSprite = sprites.shieldlvl1sprite
        if Data.shield.lvl == 2 then shieldSprite = sprites.shieldlvl2sprite
        elseif Data.shield.lvl == 3 then shieldSprite = sprites.shieldlvl3sprite
        elseif Data.shield.lvl == 4 then shieldSprite = sprites.shieldlvl4sprite end
        love.graphics.draw(shieldSprite, self.x, self.y, angle, scaleX, scaleY, cx + 10, cy + 5)
    end

    -- BOMBA (círculo)
    if self.bombActive then
        love.graphics.circle("fill", self.x, self.y, self.bombRadius)
    end

    -- NAVE (con tinte si el arma está activa; valores idénticos al original)
    if self.gunActive then
        if Data.gun.lvl == 1 then love.graphics.setColor(255, 100, 100)
        elseif Data.gun.lvl == 2 then love.graphics.setColor(150, 0, 0)
        elseif Data.gun.lvl == 3 then love.graphics.setColor(200, 0, 0)
        elseif Data.gun.lvl == 4 then love.graphics.setColor(255, 0, 0) end
    end
    love.graphics.draw(sprites.playerlvl0, self.x, self.y, angle, nil, nil, cx, cy)
    love.graphics.setColor(1, 1, 1, 1)
end

return Player