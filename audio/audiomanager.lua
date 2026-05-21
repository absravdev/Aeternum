
local love = require("love")
local SoundManager = {}
SoundManager.__index = SoundManager

function SoundManager.new()
    local self = setmetatable({}, SoundManager)
    self.songs = {
        love.audio.newSource("audio/menumusic.mp3", "static"),
    }
    for i, song in ipairs(self.songs) do
        song:setLooping(true)
    end
    self.sounds = {
        love.audio.newSource("audio/buttonclick.mp3", "static"),
        love.audio.newSource("audio/enemydead.mp3", "static"),
        love.audio.newSource("audio/powershield.mp3", "static"),
        love.audio.newSource("audio/powergun.mp3", "static"),
        love.audio.newSource("audio/powerbomb.mp3", "static"),
        love.audio.newSource("audio/playerhit.mp3", "static")
    }
    for i, sound in ipairs(self.sounds) do
        sound:setVolume(0.03)
    end
    for i, song in ipairs(self.songs) do
        song:setVolume(0.03)
    end
    self.musicEnabled = true
    self.soundEnabled = true
    self.currentSong = nil
    return self
end
function SoundManager:playSong(index)
    if self.musicEnabled and self.songs[index] then
        for i, song in ipairs(self.songs) do
            if song:isPlaying() then
                print("Deteniendo la canción " .. i)
                song:stop()
            end
        end
        print("Reproduciendo la canción " .. index)
        love.audio.play(self.songs[index])
    end
end
function SoundManager:playSound(index)
    if self.soundEnabled and self.sounds[index] then
        love.audio.play(self.sounds[index])
    end
end
function SoundManager:toggleMusic()
    self.musicEnabled = not self.musicEnabled
end
function SoundManager:toggleSound()
    self.soundEnabled = not self.soundEnabled
end
return SoundManager
