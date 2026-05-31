local MainMenu = require("menus/mainmenus/mainmenu")
local StartGameMenu = require("menus/mainmenus/startgamemenu")
--OptionsMenus
local MainOptionsMenu = require("menus/optionsmenus/mainoptionsmenu")
--PlanetsMenu
local MainPlanetMenu = require("menus/planetmenus/mainplanetmenu")
local Planet1PlanetMenu = require("menus/planetmenus/planet1planetmenu")
local Planet2PlanetMenu = require("menus/planetmenus/planet2planetmenu")
local Planet3PlanetMenu = require("menus/planetmenus/planet3planetmenu")
local Planet4PlanetMenu = require("menus/planetmenus/planet4planetmenu")
local Planet5PlanetMenu = require("menus/planetmenus/planet5planetmenu")
--SpaceshipMenus
local MainSpaceshipMenu = require("menus/spaceshipmenus/mainspaceshipmenu")
local BombSpaceshipMenu = require("menus/spaceshipmenus/bombspaceshipmenu")
local LaserSpaceshipMenu = require("menus/spaceshipmenus/laserspaceshipmenu")
local ShieldSpaceshipMenu = require("menus/spaceshipmenus/shieldspaceshipmenu")
local SpeedBulletSpaceshipMenu = require("menus/spaceshipmenus/speedbulletspaceshipmenu")
local SpeedMovementSpaceshipMenu = require("menus/spaceshipmenus/speedmovementspaceshipmenu")
local FirerateSpaceshipMenu = require("menus/spaceshipmenus/fireratespaceshipmenu")
local GameOverMenu = require("menus/mainmenus/gameovermenu")
local LevelCompletedMenu = require("menus/mainmenus/levelcompletedmenu")
local DrawStatsGameMenu = require("menus/drawmenus/drawstatsgamemenu")
local DrawSpaceShipMenu = require("menus/drawmenus/drawspaceshipmenu")
local DrawStatsMainMenu = require("menus/drawmenus/drawmainmenu")
local DrawGameWinMenu = require("menus/drawmenus/drawgamewinmenu")
--Records globales
local NameMenu = require("menus/mainmenus/namemenu")
local LeaderboardMenu = require("menus/mainmenus/leaderboardmenu")
--Enemy 
local Planet1level1 = require("planetlevels/planet1/planet1level1")
local Planet1level2 = require("planetlevels/planet1/planet1level2")
local Planet1level3 = require("planetlevels/planet1/planet1level3")
local Planet2level1 = require("planetlevels/planet2/planet2level1")
local Planet2level2 = require("planetlevels/planet2/planet2level2")
local Planet2level3 = require("planetlevels/planet2/planet2level3")
local Planet3level1 = require("planetlevels/planet3/planet3level1")
local Planet3level2 = require("planetlevels/planet3/planet3level2")
local Planet3level3 = require("planetlevels/planet3/planet3level3")
local Planet4level1 = require("planetlevels/planet4/planet4level1")
local Planet4level2 = require("planetlevels/planet4/planet4level2")
local Planet4level3 = require("planetlevels/planet4/planet4level3")
local Planet5level1 = require("planetlevels/planet5/planet5level1")
local Planet5level2 = require("planetlevels/planet5/planet5level2")
local Planet5level3 = require("planetlevels/planet5/planet5level3")
-----------
local mainmenu = MainMenu.new()
local startgamemenu = StartGameMenu.new()
--OptionsMenus
local mainoptionsmenu = MainOptionsMenu.new()
--PlanetsMenu
local mainplanetmenu = MainPlanetMenu.new()
local planet1planetmenu = Planet1PlanetMenu.new()
local planet2planetmenu = Planet2PlanetMenu.new()
local planet3planetmenu = Planet3PlanetMenu.new()
local planet4planetmenu = Planet4PlanetMenu.new()
local planet5planetmenu = Planet5PlanetMenu.new()
--SpaceshipMenus
local mainspaceshipmenu = MainSpaceshipMenu.new()
local bombspaceshipmenu = BombSpaceshipMenu.new()
local laserspaceshipmenu = LaserSpaceshipMenu.new()
local shieldspaceshipmenu = ShieldSpaceshipMenu.new()
local speedbulletspaceshipmenu = SpeedBulletSpaceshipMenu.new()
local fireratespaceshipmenu = FirerateSpaceshipMenu.new()
local speedmovementspaceshipmenu = SpeedMovementSpaceshipMenu.new()
-----------
local gameovermenu = GameOverMenu.new()
local levelcompletedmenu = LevelCompletedMenu.new()
local drawstatsgamemenu = DrawStatsGameMenu.new()
local drawspaceshipmenu = DrawSpaceShipMenu.new()
local drawstatsmainmenu = DrawStatsMainMenu.new()
local drawgamewinmenu = DrawGameWinMenu.new()
-----------
local namemenu = NameMenu.new()
local leaderboardmenu = LeaderboardMenu.new()
-----------
local planet1level1 = Planet1level1.new()
local planet1level2 = Planet1level2.new()

local planet1level3 = Planet1level3.new()
local planet2level1 = Planet2level1.new()
local planet2level2 = Planet2level2.new()
local planet2level3 = Planet2level3.new()
local planet3level1 = Planet3level1.new()
local planet3level2 = Planet3level2.new()
local planet3level3 = Planet3level3.new()
local planet4level1 = Planet4level1.new()
local planet4level2 = Planet4level2.new()
local planet4level3 = Planet4level3.new()
local planet5level1 = Planet5level1.new()
local planet5level2 = Planet5level2.new()
local planet5level3 = Planet5level3.new()
-----------
local menus = {
    mainmenu = mainmenu,
    startgamemenu = startgamemenu,
    --OptionsMenus
    mainoptionsmenu = mainoptionsmenu,
    --PlanetsMenu
    mainplanetmenu = mainplanetmenu,
    planet1planetmenu = planet1planetmenu,
    planet2planetmenu = planet2planetmenu,
    planet3planetmenu = planet3planetmenu,
    planet4planetmenu = planet4planetmenu,
    planet5planetmenu = planet5planetmenu,
    --SpaceshipMenus
    mainspaceshipmenu = mainspaceshipmenu,
    bombspaceshipmenu = bombspaceshipmenu,
    laserspaceshipmenu = laserspaceshipmenu,
    shieldspaceshipmenu = shieldspaceshipmenu,
    speedbulletspaceshipmenu = speedbulletspaceshipmenu,
    speedmovementspaceshipmenu = speedmovementspaceshipmenu,
    --Enemy
    fireratespaceshipmenu = fireratespaceshipmenu,
    gameovermenu = gameovermenu,
    levelcompletedmenu = levelcompletedmenu,
    drawstatsgamemenu = drawstatsgamemenu,
    drawspaceshipmenu = drawspaceshipmenu,
    drawstatsmainmenu = drawstatsmainmenu,
    drawgamewinmenu = drawgamewinmenu,
    --Records globales
    namemenu = namemenu,
    leaderboardmenu = leaderboardmenu,
    planet1level1 = planet1level1,
    planet1level2 = planet1level2,
    planet1level3 =  planet1level3,
    planet2level1 = planet2level1,
    planet2level2 = planet2level2,
    planet2level3 = planet2level3,
    planet3level1 = planet3level1,
    planet3level2 = planet3level2,
    planet3level3 = planet3level3,
    planet4level1 = planet4level1,
    planet4level2 = planet4level2,
    planet4level3 = planet4level3,
    planet5level1 = planet5level1,
    planet5level2 = planet5level2,
    planet5level3 = planet5level3,
}

return menus