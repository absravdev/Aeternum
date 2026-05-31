local states = {}
-----------
Data:setCurrentStage("startgamemenu")
local AudioManager = require("audio/audiomanager")
local soundManager = AudioManager.new()
local menus = require("menus/mainmenus/menus")
local font = love.graphics.newFont("fonts/alien.ttf", 25)
-----------
local menuplanetsbackground = love.graphics.newImage("sprites/fons.png")
local menuplanet1background = love.graphics.newImage("sprites/planet1menu.png")
local menuplanet2background = love.graphics.newImage("sprites/planet2menu.png")
local menuplanet3background = love.graphics.newImage("sprites/planet3menu.png")
local menuplanet4background = love.graphics.newImage("sprites/planet4menu.png")
local menuplanet5background = love.graphics.newImage("sprites/planet5menu.png")
local shieldmenu = love.graphics.newImage("sprites/shieldmenu.png")
local bombmenu = love.graphics.newImage("sprites/bombmenu.png")
local gunmenu = love.graphics.newImage("sprites/gunmenu.png")
local speedbulletmenu = love.graphics.newImage("sprites/speedbulletmenu.png")
local speedmovementmenu = love.graphics.newImage("sprites/speedmovementmenu.png")
local fireratemenu = love.graphics.newImage("sprites/fireratemenu.png")
local mainbackground  = love.graphics.newImage("sprites/mainbackground.png")
local backgroundlvl1 = love.graphics.newImage("sprites/backgroundlvl1.png")
local backgroundlvl2 = love.graphics.newImage("sprites/backgroundlvl2.png")
local backgroundlvl3 = love.graphics.newImage("sprites/backgroundlvl3.png")
local backgroundlvl4 = love.graphics.newImage("sprites/backgroundlvl4.png")
local backgroundlvl5 = love.graphics.newImage("sprites/backgroundlvl5.png")
local backgroundlvl6 = love.graphics.newImage("sprites/backgroundlvl6.png")
local backgroundlvl7 = love.graphics.newImage("sprites/backgroundlvl7.png")
local backgroundlvl8 = love.graphics.newImage("sprites/backgroundlvl8.png")
local backgroundlvl9 = love.graphics.newImage("sprites/backgroundlvl9.png")
local backgroundlvl10 = love.graphics.newImage("sprites/backgroundlvl10.png")
local backgroundlvl11 = love.graphics.newImage("sprites/backgroundlvl11.png")
local backgroundlvl12 = love.graphics.newImage("sprites/backgroundlvl12.png")
local backgroundlvl13 = love.graphics.newImage("sprites/backgroundlvl13.png")
local backgroundlvl14 = love.graphics.newImage("sprites/backgroundlvl14.png")
local backgroundlvl15 = love.graphics.newImage("sprites/backgroundlvl15.png")
local manual = love.graphics.newImage("sprites/manual.png")

states["startgamemenu"] = {
    load = function()
        soundManager:playSong(1)
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.setFont(font)
        menus.startgamemenu:draw()
    end
}
states["mainmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.mainmenu:draw()
    end
}
states["namemenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.setFont(font)
        menus.namemenu:draw()
    end
}
states["leaderboardmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.leaderboardmenu:draw()
    end
}
--OptionsMenus
states["mainoptionsmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(manual, 400, 100, 0)
        menus.mainoptionsmenu:draw()
    end
}
states["soundoptionsmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.soundoptionsmenu:draw()
    end
}
--PlanetMenus
states["mainplanetmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        
        love.graphics.draw(menuplanetsbackground, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.mainplanetmenu:draw()
    end
}
states["planet1planetmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(menuplanet1background, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.planet1planetmenu:draw()
    end
}
states["planet2planetmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(menuplanet2background, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.planet2planetmenu:draw()
    end
}
states["planet3planetmenu"] = {
    load = function()
    Data:resetData()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(menuplanet3background, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.planet3planetmenu:draw()
    end
}
states["planet4planetmenu"] = {
    load = function()
    Data:resetData()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(menuplanet4background, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.planet4planetmenu:draw()
    end
}
states["planet5planetmenu"] = {
    load = function()
    Data:resetData()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(menuplanet5background, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.planet5planetmenu:draw()
    end
}
states["mainspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.drawspaceshipmenu:draw()
        menus.mainspaceshipmenu:draw()
    end
}
states["laserspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(gunmenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.laserspaceshipmenu:draw()
    end
}
states["bombspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(bombmenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.bombspaceshipmenu:draw()
    end
}
states["shieldspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(shieldmenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.shieldspaceshipmenu:draw()
    end
}
states["speedbulletspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(speedbulletmenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.speedbulletspaceshipmenu:draw()
    end
}
states["speedmovementspaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(speedmovementmenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.speedmovementspaceshipmenu:draw()
    end
}
states["fireratespaceshipmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        love.graphics.draw(fireratemenu, 400, 100, 0)
        menus.drawspaceshipmenu:draw()
        menus.fireratespaceshipmenu:draw()
    end
}
states["gameovermenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function(dt)
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.drawstatsmainmenu:draw(dt)
        menus.gameovermenu:draw()
    end
}
states["winmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.drawgamewinmenu:draw()
    end
}
states["levelcompletedmenu"] = {
    load = function()
    end,
    update = function(dt)
    end,
    draw = function()
        love.graphics.draw(mainbackground, 0, 0, 0)
        menus.levelcompletedmenu:draw()
        menus.drawstatsmainmenu:draw()
    end
}
--Game
states["game"] = {
    planet1 = {
        level1 = {
            load = function()
            end,
            update = function(dt)
                menus.planet1level1:new()
                menus.planet1level1:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl1, 0, 0, 0)
                menus.planet1level1:draw()
                menus.drawstatsgamemenu:draw()
            end
        },

        level2 = {
            load = function()
            end,
            update = function(dt)
                menus.planet1level2:new()
                menus.planet1level2:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl2, 0, 0, 0)
                menus.planet1level2:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level3 = {
            load = function()
            end,
            update = function(dt)
                menus.planet1level3:new()
                menus.planet1level3:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl3, 0, 0, 0)
                menus.planet1level3:draw()
                menus.drawstatsgamemenu:draw()
            end
        }
    },
    planet2 = {
        level1 = {
            load = function()
            end,
            update = function(dt)
                menus.planet2level1:new()
                menus.planet2level1:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl4, 0, 0, 0)
                menus.planet2level1:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level2 = {
            load = function()
            end,

            update = function(dt)
                menus.planet2level2:new()
                menus.planet2level2:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl5, 0, 0, 0)
                menus.planet2level2:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level3 = {
            load = function()
            end,
            update = function(dt)
                menus.planet2level3:new()
                menus.planet2level3:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl6, 0, 0, 0)
                menus.planet2level3:draw()
                menus.drawstatsgamemenu:draw()
            end
        }
    },
    planet3 = {
        level1 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet3level1:new()
                menus.planet3level1:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl7, 0, 0, 0)
                menus.planet3level1:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level2 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet3level2:new()
                menus.planet3level2:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl8, 0, 0, 0)
                menus.planet3level2:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level3 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet3level3:new()
                menus.planet3level3:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl9, 0, 0, 0)
                menus.planet3level3:draw()
                menus.drawstatsgamemenu:draw()
            end
        }
    },
    planet4 = {
        level1 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet4level1:new()
                menus.planet4level1:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl10, 0, 0, 0)
                menus.planet4level1:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level2 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet4level2:new()
                menus.planet4level2:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl11, 0, 0, 0)
                menus.planet4level2:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level3 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet4level3:new()
                menus.planet4level3:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl12, 0, 0, 0)
                menus.planet4level3:draw()
                menus.drawstatsgamemenu:draw()
            end
        }
    },
    planet5 = {
        level1 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet5level1:new()
                menus.planet5level1:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl13, 0, 0, 0)
                menus.planet5level1:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level2 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet5level2:new()
                menus.planet5level2:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl14, 0, 0, 0)
                menus.planet5level2:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
        level3 = {
            load = function()
            Data:resetData()
            end,
            update = function(dt)
                menus.planet5level3:new()
                menus.planet5level3:update(dt)
            end,
            draw = function()
                love.graphics.draw(backgroundlvl15, 0, 0, 0)
                menus.planet5level3:draw()
                menus.drawstatsgamemenu:draw()
            end
        },
    }
}
return states, menus