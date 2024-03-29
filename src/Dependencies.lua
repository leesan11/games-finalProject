--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_objects'
require 'src/Hitbox'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Doorway'
require 'src/world/Dungeon'
require 'src/world/Room'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
-- ##Task 2
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerSwingSwordState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerPickPotState'

require 'src/states/game/GameOverState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character-swing-sword'] = love.graphics.newImage('graphics/character_swing_sword.png'),
    -- ##Task2
    ['pot-pick'] = love.graphics.newImage('graphics/character_pot_lift.png'),
    ['pot-walk'] = love.graphics.newImage('graphics/character_pot_walk.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['switches'] = love.graphics.newImage('graphics/switches.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    -- ##Final Project
    ['boss'] = love.graphics.newImage('graphics/boss1.png'),
    ['boss2'] = love.graphics.newImage('graphics/boss2.png'),
    ['boss3'] = love.graphics.newImage('graphics/boss3.png'),
    ['boss4'] = love.graphics.newImage('graphics/boss4.png'),
    ['key'] = love.graphics.newImage('graphics/keys_and_locks.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['character-swing-sword'] = GenerateQuads(gTextures['character-swing-sword'], 32, 32),
    -- ##Task2
    ['pot-pick'] = GenerateQuads(gTextures['pot-pick'],16, 32),
    ['pot-walk'] = GenerateQuads(gTextures['pot-walk'],16, 32),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16),
    ['switches'] = GenerateQuads(gTextures['switches'], 16, 18),
    -- ##Final Project
    ['boss'] = GenerateQuads(gTextures['boss'], 24, 24),
    ['boss2'] = GenerateQuads(gTextures['boss2'], 24, 24),
    ['boss3'] = GenerateQuads(gTextures['boss3'], 24, 24),
    ['boss4'] = GenerateQuads(gTextures['boss4'], 24, 24),
    ['key'] = GenerateQuads(gTextures['key'], 16 , 16)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32)
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3','static'),
    ['sword'] = love.audio.newSource('sounds/sword.wav','static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav','static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav','static'),
    ['door'] = love.audio.newSource('sounds/door.wav','static'),
    ['key'] = love.audio.newSource('sounds/key.mp3','static')
}