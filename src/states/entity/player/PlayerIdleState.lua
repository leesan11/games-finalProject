--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    EntityIdleState.update(self, dt)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        if not self.entity.pot then
            self.entity.swung = true
            self.entity:changeState('swing-sword')
        end
    end
-- ##Task2
    if love.keyboard.wasPressed('m') then
        -- ###Task 3
        if not self.entity.pot then
            self.entity:changeState('pot-pick')
        elseif self.entity.pot then
            self.entity.throwPot = true
            self.entity.pot = false
        end
    end
end