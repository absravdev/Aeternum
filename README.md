# Aeternum

> My first complete game, built in Love2D / Lua. A top-down shooter with 15 levels across 5 planets, an upgrade system and a shop. I'm uploading it exactly as I left it when I finished it, with no later refactoring, an honest snapshot of where I was as a developer back then.

<p align="center">
  <a href="https://youtu.be/rTFi5HzEdAk?si=Oq6bFmgcYhf6JiBt">
    <img src="docs/screenshot1.png" alt="Aeternum gameplay video, click to watch on YouTube" width="50%" />
  </a>
</p>

<p align="center">
  <img src="docs/screenshot2.png" width="32%" alt="Aeternum screenshot 2" />
  <img src="docs/screenshot3.png" width="32%" alt="Aeternum screenshot 3" />
  <img src="docs/screenshot4.png" width="32%" alt="Aeternum screenshot 4" />
  <img src="docs/screenshot5.png" width="32%" alt="Aeternum screenshot 5" />
  <img src="docs/screenshot6.png" width="32%" alt="Aeternum screenshot 6" />
</p>

## About this repository

Aeternum is the first serious project I ever finished as a developer. I built it over 2-3 weeks, finishing it in November 2023, with significant help from AI in many places, and with no prior programming experience. It has bugs, design choices I wouldn't make today, and patterns I'd factor out in a heartbeat. **It's uploaded exactly as it was**, untouched after the fact, because this repo isn't meant to showcase "clean code." It's meant to show two things:

- that I was able to ship a complete, playable game with menus, progression, balancing and audio,
- and that today I can look at that code with a critical eye and point to exactly what's wrong with it.

That second part is documented below, in [Known bugs and technical debt](#known-bugs-and-technical-debt) and [What I'd do differently today](#what-id-do-differently-today).

A note on credit: **the code is mine, the art and audio are not**, I used free-to-use assets from other creators. See [Credits](#credits) for details.

## The game

You pilot a ship defending its position against waves of enemies across different planets. Each planet has 3 levels with a different mix of enemy types. With the money earned from kills, you can upgrade your ship in the shop: more health, faster bullets, better fire rate, shields, an area-of-effect bomb, and a temporary "gun" mode.

**Features:**

- 5 planets × 3 levels = **15 stages**
- **6 enemy types** (melee chasers, ranged shooters with homing bullets, etc.)
- **6 independent upgrades** with 4 tiers each: shield, bomb, gun, fire rate, bullet speed, movement speed
- **Power-ups with cooldowns** that you activate mid-fight
- Spatial objects that affect the battlefield (stars, black holes with a telegraph warning before they appear)
- Music and sound effects with toggles
- Complete menu system: planets, shop, options, game over, level cleared

## How to run it

You'll need [LÖVE 11.x](https://love2d.org/) installed.

```bash
love .
```

Or by dragging the folder onto the Love2D executable.

## Controls

| Action | Key |
|---|---|
| Move | `W` `A` `S` `D` |
| Aim | Mouse |
| Shoot | Left click |
| Gun mode (temporary) | Right click |
| Shield | `E` |
| Bomb | `Space` |
| Toggle fullscreen | `F` |

## Glitches and exploits

These are gameplay-level oddities, different from the code-level issues in [Known bugs and technical debt](#known-bugs-and-technical-debt) below. I'm keeping them collapsed so they don't spoil the game for anyone who wants to play it cold.

<details>
<summary><strong>⚠️ Spoiler warning, don't open if you'd rather discover the game on your own.</strong></summary>

<br>

Things I noticed while playing that affect the experience. I'm splitting them into **glitches** (exploitable design/balance issues) and **bugs** (unintended technical behaviour).

**Glitches, exploits and balance issues**

- **Blackmatter (money) farming via enemy stacking.** The money you earn per level is tied to the number of enemies killed, and the level only ends once you exceed the kill target. That means you can deliberately let enemies pile up and then mass-kill them all at once, earning far more blackmatter than the level was designed to pay out. Stack it with picking up comets (which also reward you) and the income scales even further.
- **Max-level shield is essentially immortality.** At tier 4, the shield combines a long active duration with a very short cooldown between uses. The result: it's up nearly as often as it's down, and you can tank pretty much anything. Definitely a balance miss.

**Bugs, unintended behaviour**

- **Projectiles bleed across levels.** When loading into a new level, you can sometimes find leftover enemy bullets from the previous level still on screen. They weren't destroyed during the transition. (This is the player-visible side of the `Data:resetData()` issue listed in the dev section below.)
- **Off-screen enemy shots.** Because of how the enemy spawner positions hostiles, they can fire at you from outside your visible area, you can take a hit from something you can't even see yet.

If you spot another bug or glitch I haven't listed, **please open an issue**, I'd genuinely love to hear about it.

</details>

## Project structure

```
Aeternum/
├── main.lua                # Main dispatcher
├── conf.lua                # Love2D config
├── bullets/                # Player and per-enemy-type bullets
├── enemies/                # Logic for the 6 enemy types
├── menus/
│   ├── mainmenus/          # Start, main, game over, level cleared, states
│   ├── planetmenus/        # Planet selector and per-planet level selector
│   ├── spaceshipmenus/     # Upgrade shop
│   ├── optionsmenus/       # Options
│   └── drawmenus/          # HUDs and stats
├── audio/                  # AudioManager and audio files
├── others/                 # Global Data, player, collisions, powers
├── planetlevels/           # One file per level (planet1level1, planet1level2, ...)
└── spatialobjects/         # Stars and meteorites
```

## Known bugs and technical debt

I've reviewed this with hindsight. I'm listing them not to make excuses, but to make the point that **I can identify them now**, which is the actual skill that matters.

### Real bugs

- **`Data:resetData()` is empty.** It's called from `states.lua` when entering several planets, but the function body was never implemented. That's why state between runs doesn't fully clean up (HP, player position, counters).
- **Inverted comparison in a bullet-vs-bullet collision check.** In `collisions.lua`, the first check between player bullets and `enemy2` bullets uses `>` instead of `<`. Result: your bullets die when they're *far* from enemy2 bullets, not when they collide with them.
- **The "gun" power-up sprites are copy-pasted from the shield.** All three variants (`gunlvl1/2/3sprite`) point to `shieldlvl1.png`.
- **Dirty level state between runs.** Each level caches its `player`, enemy arrays, etc. in module-local variables. Since Lua caches `require`d modules, those locals live forever. The correct fix was the `resetData()` that was left unimplemented.
- **`Data.windowWidth/Height` captured before fullscreen kicks in.** Evaluated when `data.lua` loads, before `main.lua` switches to fullscreen. Ends up holding the initial size from `conf.lua` (1450×750) instead of the actual monitor resolution.
- **`Enemy1` has a `self.maxTime = 1 * self.maxTime`** which does nothing. It was probably meant to ramp up difficulty gradually.

### Technical debt / decisions I'd make differently now

- **Massive per-level duplication.** In `playerbullets.lua`, `player.lua` and every enemy file, there's an `if Data.lvl == 1 then ... elseif Data.lvl == 2 then ...` chain repeated up to 15 times. The only thing changing between branches is which `PlanetXlevelY` object gets queried for the angle. A `levels[Data.lvl]` table would collapse ~5 files into a fraction of their current size.
- **`Player:draw()` repeats the same block 15 times** (one per level), and inside each block it repeats the 4 shield/bomb/gun tiers doing almost the same thing. It's a giant pyramid of ifs where one parameterized block would do.
- **`AudioManager.new()` is called from ~25 modules**, loading the same audio files once per module. It should be a singleton.
- **`math.randomseed(os.time())` repeated in every level file.** It only needs to be called once at startup.
- **`menus.planetXlevelY:new()` is called inside `update`, every frame.** It doesn't break anything (the real state lives in module-local variables), but it's misleading: it looks like initialization and isn't.
- **Globals and locals mixed inconsistently.** Some modules (`Player`, `Data`, `Collisions`) are globals; others (`MainMenu`, `LevelCompletedMenu`) are locals. Works because of how Lua resolves globals, but it's fragile.
- **No save system.** All progress is lost on quit. `love.filesystem.write` plus a serializer would fix this in a handful of lines.
- **`Powers:draw()` only renders HUD for shield, bomb and gun.** The other three upgrades (fire rate, bullet speed, movement speed) get no in-game feedback at all.
- **Confusing naming.** `Data.lvl` is the stage number (1-15) while `Data.player.lvl` is the player's tier (1-4). `setCurrentStage` assigns to `currentState`. Things I sorted out in the very next project.
- **`conf.lua` still has `t.title = "LovePong"`**, a leftover from when this project started as a Pong clone.

## What I'd do differently today

If I were rewriting Aeternum from scratch today, the key changes would be:

1. **A level table indexed by number** (`levels[1] = require("planetlevels/planet1level1")`, etc.) instead of 15-way if-else chains scattered across 5 files.
2. **Compose player and enemies from behaviors** instead of hardcoding every combination. An `enemy.behaviors = {chase, shoot}` configurable per level is far more maintainable than having `enemy1.lua`..`enemy6.lua`.
3. **A singleton AudioManager**, instantiated once and exported, instead of a `.new()` per module.
4. **Save/load system** with `love.filesystem` from day one.
5. **A single, clear `GameState`** instead of the `currentState`/`currentLevel` pair with fallback in the dispatcher.
6. **Some tests**, even basic ones, over the pure logic (collisions, score calculation, cooldown handling).

None of this is going to be applied to this repo. It is what it is, and that's the point of keeping it public.

## Stack

- **Language:** Lua 5.1 (the version Love2D ships with)
- **Framework:** [LÖVE 11.x](https://love2d.org/)

## Credits

The code is mine. The art and audio aren't.

**Visual assets**, the sprites and visual art are by these three excellent creators on itch.io, whose work I highly recommend checking out:

- **[JemJemJemJem](https://jemjemjemjem.itch.io/)**
- **[itslancer](https://itslancer.itch.io/)**
- **[saokay28](https://saokay28.itch.io/)**

**Audio**, sound effects and music are free-to-use assets gathered from the web. Specific sources weren't tracked at the time; if you recognise any of them, please open an issue and I'll credit them properly.

If you recognise a specific asset that should be credited differently, please open an issue and I'll fix it.

## License

To be decided. In the meantime, treat it as public-viewable but not commercially reusable without asking first.

---

*If you made it this far: thanks for taking a look. If you find a bug or glitch, want to comment on the code, or just tell me how you'd have done it, open an issue. I'd genuinely love to hear about it.*