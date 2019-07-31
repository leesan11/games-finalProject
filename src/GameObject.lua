--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
    
    -- ###Task 3
    self.projectile = false
    self.broken = false
    self.picked = false
    -- default empty collision callback
    self.onCollide = function()
        
    end
end

function GameObject:update(objects,player,dt)
    -- ##Task 2
    if self.solid and player.pot and self.picked then
        self.x = player.x 
        self.y = player.y - player.height/1.5
    end
    -- ###Task 3
    if player.throwPot and self.solid and self.picked then
        if player.direction == 'left' then
            self.y = player.y
            if self.x >= player.x - TILE_SIZE*4 and self.x >=MAP_RENDER_OFFSET_X + TILE_SIZE then
                self.x = self.x - 5
            else
                player.throwPot = false
                self.broken = true
                self.picked = false
            end
        elseif player.direction == 'right' then
            self.y = player.y
            if self.x <= player.x + TILE_SIZE*4 and self.x <= VIRTUAL_WIDTH - TILE_SIZE * 2 - 16 then
                self.x = self.x + 5
            else
                player.throwPot = false
                self.broken = true
                self.picked = false
            end
        end    
    end

    if self.broken then
        self.broken = false
        for k, object in pairs(objects) do
            if object == self then
                table.remove(objects,k)
            end
        end
    end
    
-- ###Task 3 unsure why 3 if statements make game glitchy, separated into two
    -- if player.throwPot and self.solid then
    --     player.pot = false
    --     if player.direction == 'up' then
    --         if self.y >= MAP_RENDER_OFFSET_Y + TILE_SIZE then
    --             self.y = self.y - 5
    --         else
    --             player.throwPot = false
    --         end
    --     elseif player.direction == 'down' then
    --         if self.y <= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16 then
    --             self.y = self.y + 5
    --         else
    --             player.throwPot = false
    --         end
    --     end
    -- end
        
    

end
-- ##Task 2
function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    
end