--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    -- ###################Task 1 hearts##############
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        broken = false,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 5
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    -- ##Task2
    ['pot'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        projectile = true,
        broken = false,
        picked = false,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 6
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['key'] = {
        type = 'key',
        texture = 'key',
        frame = 1,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 1
            },
            ['pressed'] = {
                frame = 1
            }
        }
    }
}