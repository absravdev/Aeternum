Powers = {}
Powers.__index = Powers
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local bombiconsprite = love.graphics.newImage("sprites/icon/bomb.png")
local shieldiconsprite = love.graphics.newImage("sprites/icon/shield.png")
local guniconsprite = love.graphics.newImage("sprites/icon/gun.png")
function Powers.new(shieldlvl, gunlvl, bomblvl, firerate)
   local self = setmetatable({}, Powers)
   if shieldlvl == 1 then
   self.shieldCooldownMax = Data.shield.lvl1.CooldownMax
   self.shieldCooldown = Data.shield.lvl1.Cooldown
   self.shieldTimerMax = Data.shield.lvl1.TimerMax
   self.shieldTimer = self.shieldTimerMax
   elseif shieldlvl == 2 then
   self.shieldCooldownMax = Data.shield.lvl2.CooldownMax
   self.shieldCooldown = Data.shield.lvl2.Cooldown
   self.shieldTimerMax = Data.shield.lvl2.TimerMax
   self.shieldTimer = self.shieldTimerMax
   elseif shieldlvl == 3 then
   self.shieldCooldownMax = Data.shield.lvl3.CooldownMax
   self.shieldCooldown = Data.shield.lvl3.Cooldown
   self.shieldTimerMax = Data.shield.lvl3.TimerMax
   self.shieldTimer = self.shieldTimerMax
   elseif shieldlvl == 4 then
   self.shieldCooldownMax = Data.shield.lvl4.CooldownMax
   self.shieldCooldown = Data.shield.lvl4.Cooldown
   self.shieldTimerMax = Data.shield.lvl4.TimerMax
   self.shieldTimer = self.shieldTimerMax
   end
   if gunlvl == 1 then
   self.gunCooldownMax = Data.gun.lvl1.CooldownMax
   self.gunCooldown = Data.gun.lvl1.Cooldown
   self.gunTimerMax = Data.gun.lvl1.TimerMax
   self.shootGunTimerMax = Data.gun.lvl1.shootTimerMax 
   self.gunTimer = self.gunTimerMax
   elseif gunlvl == 2 then
   self.gunCooldownMax = Data.gun.lvl2.CooldownMax
   self.gunCooldown = Data.gun.lvl2.Cooldown
   self.gunTimerMax = Data.gun.lvl2.TimerMax
   self.shootGunTimerMax = Data.gun.lvl2.shootTimerMax 
   self.gunTimer = self.gunTimerMax
   elseif gunlvl == 3 then
   self.gunCooldownMax =  Data.gun.lvl3.CooldownMax
   self.gunCooldown = Data.gun.lvl3.Cooldown
   self.gunTimerMax = Data.gun.lvl3.TimerMax
   self.shootGunTimerMax = Data.gun.lvl3.shootTimerMax 
   self.gunTimer = self.gunTimerMax
   elseif gunlvl == 4 then
   self.gunCooldownMax =  Data.gun.lvl4.CooldownMax
   self.gunCooldown = Data.gun.lvl4.Cooldown
   self.gunTimerMax = Data.gun.lvl4.TimerMax
   self.shootGunTimerMax = Data.gun.lvl4.shootTimerMax 
   self.gunTimer = self.gunTimerMax
   end
   if bomblvl == 1 then
   self.bombCooldownMax = Data.bomb.lvl1.CooldownMax
   self.bombCooldown = Data.bomb.lvl1.Cooldown
   self.bombTimerMax = Data.bomb.lvl1.TimerMax
   self.bombTimer = self.bombTimerMax
   elseif bomblvl == 2 then
   self.bombCooldownMax = Data.bomb.lvl2.CooldownMax
   self.bombCooldown = Data.bomb.lvl2.Cooldown
   self.bombTimerMax = Data.bomb.lvl2.TimerMax
   self.bombTimer = self.bombTimerMax
   elseif bomblvl == 3 then
   self.bombCooldownMax = Data.bomb.lvl3.CooldownMax
   self.bombCooldown = Data.bomb.lvl3.Cooldown
   self.bombTimerMax = Data.bomb.lvl3.TimerMax
   self.bombTimer = self.bombTimerMax
   elseif bomblvl == 4 then
   self.bombCooldownMax = Data.bomb.lvl4.CooldownMax
   self.bombCooldown = Data.bomb.lvl4.Cooldown
   self.bombTimerMax = Data.bomb.lvl4.TimerMax
   self.bombTimer = self.bombTimerMax
   end
   if firerate == 1 then
      self.shootTimerMax = Data.firerate.lvl1.shootTimerMax
      self.shootTimer = self.shootTimerMax
   elseif firerate == 2 then
      self.shootTimerMax = Data.firerate.lvl2.shootTimerMax
      self.shootTimer = self.shootTimerMax
   elseif firerate == 3 then
      self.shootTimerMax = Data.firerate.lvl3.shootTimerMax
      self.shootTimer = self.shootTimerMax
   elseif firerate == 4 then
      self.shootTimerMax = Data.firerate.lvl4.shootTimerMax
      self.shootTimer = self.shootTimerMax
   end
   self.canShoot = true
   return self
end
function Powers:update(dt)
   if self.shieldCooldown > 0 then
      self.shieldCooldown = self.shieldCooldown - dt
   end
   if self.shieldTimer > 0 then
      self.shieldTimer = self.shieldTimer - dt
   end
   if self.shieldTimer <= 0 then
      Data.shield.active = false
   end
   if not self.canShoot then
      self.shootTimer = self.shootTimer - dt
      if self.shootTimer <= 0 then
         self.canShoot = true
      end
   end
   if self.gunCooldown > 0 then
      self.gunCooldown = self.gunCooldown - dt
   end
   if self.gunTimer > 0 then
      self.gunTimer = self.gunTimer - dt
   end
   if self.gunTimer <= 0 then
      Data.gun.active = false
   end
   if self.bombCooldown > 0 then
      self.bombCooldown = self.bombCooldown - dt
   end
   if self.bombTimer > 0 then
      self.bombTimer = self.bombTimer - dt
   end
   if self.bombTimer <= 0 then
      Data.bomb.active = false
   end
end
function Powers:Fire(player, bullets)
   if love.mouse.isDown(1) and self.canShoot and self.mouseReleased then
      PlayerBullets:spawnBullet(player, bullets)
      soundManager:playSound(4)
      self.canShoot = false
      self.shootTimer = self.shootTimerMax
      self.mouseReleased = false
   end
   if not love.mouse.isDown(1) then
      self.mouseReleased = true
   end
   if love.keyboard.isDown('e') and not Data.shield.active and self.shieldCooldown <= 0 then
      Data.shield.active = true
      self.shieldTimer = self.shieldTimerMax
      self.shieldCooldown = self.shieldCooldownMax
   end
   if love.mouse.isDown(2) and not Data.gun.active and self.gunCooldown <= 0 then
      PlayerBullets:spawnBullet(player, bullets)
      Data.gun.active = true
      self.gunTimer = self.gunTimerMax
      self.gunCooldown = self.gunCooldownMax
    end
    if Data.gun.active and self.canShoot then
      PlayerBullets:spawnBullet(player, bullets)
      self.canShoot = false
      self.shootTimer = self.shootGunTimerMax
    end
   if love.keyboard.isDown('space') and not Data.bomb.active and self.bombCooldown <= 0 then
      Data.bomb.active = true
      self.bombTimer = self.bombTimerMax
      self.bombCooldown = self.bombCooldownMax
   end
end
function Powers:draw()
   if Data.currentState =="game" then
      if self.bombCooldown > 0 then
      love.graphics.setColor(0.2, 0.2, 0.2)
      love.graphics.rectangle("line", 30, 80, 50, 50)
      love.graphics.draw(bombiconsprite, 30, 80)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(string.format("%.1f", self.bombCooldown), 50, 80)
      else
      love.graphics.rectangle("line", 30, 80, 50, 50)
      love.graphics.draw(bombiconsprite, 30, 80)
      love.graphics.print("SPACE", 50, 80)
      end
      if self.shieldCooldown > 0 then
         love.graphics.setColor(0.2, 0.2, 0.2)
      love.graphics.rectangle("line", 30, 140, 50, 50)
      love.graphics.draw(shieldiconsprite, 30, 140)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(string.format("%.1f", self.shieldCooldown), 50, 140)
      else
      love.graphics.rectangle("line", 30, 140, 50, 50)
      love.graphics.draw(shieldiconsprite, 30, 140)
      love.graphics.print("E", 70, 140)
      end
      if self.gunCooldown > 0 then
         love.graphics.setColor(0.2, 0.2, 0.2)
      love.graphics.rectangle("line", 30, 200, 50, 50)
      love.graphics.draw(guniconsprite, 30, 200)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(string.format("%.1f", self.gunCooldown), 50, 200)
      else
      love.graphics.rectangle("line", 30, 200, 50, 50)
      love.graphics.draw(guniconsprite, 30, 200)
      love.graphics.print("RIGHT CL.", 50, 200)
      end
end
end

return Powers