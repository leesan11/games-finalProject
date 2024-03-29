--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Room = Class{}

function Room:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    -- entities in the room
    self.entities = {}
    self:generateEntities()

    -- game objects in the room
    self.objects = {}
    self:generateObjects()

    -- heart consumption
    self.consumed = false

    -- doorways that lead to other dungeon rooms
    self.doorways = {}
    table.insert(self.doorways, Doorway('top', false, self))
    table.insert(self.doorways, Doorway('bottom', false, self))
    table.insert(self.doorways, Doorway('left', false, self))
    table.insert(self.doorways, Doorway('right', false, self))

    -- reference to player for collisions, etc.
    self.player = player

    -- used for centering the dungeon rendering
    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    -- used for drawing when this room is the next room, adjacent to the active
    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0
end

--[[
    Randomly creates an assortment of enemies for the player to fight.
]]
function Room:generateEntities()
        -- generate boss ##finalProject
    table.insert(self.entities, Entity {
        animations = ENTITY_DEFS['boss'].animations,
        walkSpeed = ENTITY_DEFS['boss'].walkSpeed or 20,
    
        -- ensure X and Y are within bounds of the map
        x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
            VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
        y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
            VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
            
        width = 16,
        height = 16,
        boss = true,
        health = 4
    })
    self.entities[1].stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self.entities[1], self.objects) end,
        ['idle'] = function() return EntityIdleState(self.entities[1]) end
    }
    
    self.entities[1]:changeState('walk')

    local types = {'skeleton', 'slime', 'bat', 'ghost', 'spider'}

    for i = 2, 10 do
        local type = types[math.random(#types)]

        table.insert(self.entities, Entity {
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

            -- ensure X and Y are within bounds of the map
            x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
            y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
            
            width = 16,
            height = 16,
            boss=false,
            health = 1
        })

        self.entities[i].stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(self.entities[i], self.objects) end,
            ['idle'] = function() return EntityIdleState(self.entities[i]) end
        }

        self.entities[i]:changeState('walk')
    end
end

--[[
    Randomly creates an assortment of obstacles for the player to navigate around.
]]
function Room:generateObjects()
    table.insert(self.objects, GameObject(
        GAME_OBJECT_DEFS['switch'],
        math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                    VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
        math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                    VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16)
    ))

    -- get a reference to the switch
    local switch = self.objects[1]

    -- define a function for the switch that will open all doors in the room
    switch.onCollide = function()
        if switch.state == 'unpressed' and self.player.key then
            switch.state = 'pressed'
            
            -- open every door in the room if we press the switch
            for k, doorway in pairs(self.doorways) do
                doorway.open = true
                self.player.key = false
            end

            gSounds['door']:play()
        end
    end
    -- ##Task 2
    for i = 1, 2 do
        table.insert(self.objects, GameObject(
        GAME_OBJECT_DEFS['pot'],
        math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                    VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
        math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                    VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16)
        ))
        end

end

--[[
    Generates the walls and floors of the room, randomizing the various varieties
    of said tiles for visual variety.
]]
function Room:generateWallsAndFloors()
    for y = 1, self.height do
        table.insert(self.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY

            if x == 1 and y == 1 then
                id = TILE_TOP_LEFT_CORNER
            elseif x == 1 and y == self.height then
                id = TILE_BOTTOM_LEFT_CORNER
            elseif x == self.width and y == 1 then
                id = TILE_TOP_RIGHT_CORNER
            elseif x == self.width and y == self.height then
                id = TILE_BOTTOM_RIGHT_CORNER
            
            -- random left-hand walls, right walls, top, bottom, and floors
            elseif x == 1 then
                id = TILE_LEFT_WALLS[math.random(#TILE_LEFT_WALLS)]
            elseif x == self.width then
                id = TILE_RIGHT_WALLS[math.random(#TILE_RIGHT_WALLS)]
            elseif y == 1 then
                id = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]
            elseif y == self.height then
                id = TILE_BOTTOM_WALLS[math.random(#TILE_BOTTOM_WALLS)]
            else
                id = TILE_FLOORS[math.random(#TILE_FLOORS)]
            end
            
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function Room:update(dt)
    -- don't update anything if we are sliding to another room (we have offsets)
    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)
    -- ###Task 3
    for k, object in pairs(self.objects) do
        if self.player.throwPot and object.solid and object.picked then
            self.player.pot = false
            if self.player.direction == 'up' then
                if object.y >= MAP_RENDER_OFFSET_Y + TILE_SIZE + self.player.y - TILE_SIZE*4 and object.y >= MAP_RENDER_OFFSET_Y + TILE_SIZE then
                    object.y = object.y - 5
                else
                    self.player.throwPot = false
                    object.broken = true
                    object.picked = false
                end
            elseif self.player.direction == 'down' then
                if object.y <= self.player.y - self.player.height + TILE_SIZE*4 and object.y <= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16 then
                    object.y = object.y + 5
                else
                    self.player.throwPot = false
                    object.broken = true
                    object.picked = false
                end
            end
        end
    end

    -- ###Task3
  
    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        -- change health bar if hit
        if entity == self.entities[1] then
            if entity.health == 3 then
                entity.currentAnimation.texture = 'boss2'
            elseif entity.health == 2 then
                entity.currentAnimation.texture = 'boss3'
            elseif entity.health == 1 then
                entity.currentAnimation.texture = 'boss4'
            end 
        end

        -- remove entity from the table if health is <= 0
        if entity.health <= 0 then
            entity.dead = true
            --#Task 1 spawn heart at entity.x and entity.y 
            if not entity.spawnedHeart and not (entity == self.entities[1]) and math.random(2) == 1 then
                table.insert(self.objects, GameObject(
                    GAME_OBJECT_DEFS['heart'],entity.x,entity.y))
                local heart = self.objects[#self.objects]
                gSounds['hit-player']:play()
                heart.onCollide = function()
                    self.player:damage(-2)
                    for k, object in pairs(self.objects) do
                        if object == heart then
                        table.remove(self.objects, k)
                        end
                    end
                end
                entity.spawnedHeart = true
            else
                entity.spawnedHeart = true
            end
            -- #
            -- final project
            if entity == self.entities[1] and entity.spawnedKey == false then
                table.insert(self.objects, GameObject(
                    GAME_OBJECT_DEFS['key'],entity.x,entity.y))
                local key = self.objects[#self.objects]
                key.onCollide = function()
                    self.player.key = true
                    for k, object in pairs(self.objects) do
                        if object == key then
                            gSounds['key']:play()
                            table.remove(self.objects, k)
                        end
                    end
                end
                entity.spawnedKey = true
            end

        elseif not entity.dead then
            entity:processAI({room = self}, dt)
            entity:update(dt)
        end

        -- collision between the player and entities in the room
        if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
            gSounds['hit-player']:play()
            self.player:damage(1)
            self.player:goInvulnerable(1.5)

            if self.player.health == 0 then
                gStateMachine:change('game-over')
            end
        end
        -- ###Task 3 
        for k, object in pairs(self.objects) do
            if object.solid and object:collides(entity) and not entity.dead and self.player.throwPot and object.picked then
                entity.health = entity.health - 1
                object.broken = true
                object.picked = false
                self.player.throwPot = false
                gSounds['hit-player']:play()
            end
        end
        -- ###
    end

    for k, object in pairs(self.objects) do
        
        object:update(self.objects,self.player,dt)
        -- trigger collision callback on object
        if self.player:collides(object) then
            
            object:onCollide()
        end
        
    end
end

function Room:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX + self.adjacentOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY + self.adjacentOffsetY)
        end
    end

    -- render doorways; stencils are placed where the arches are after so the player can
    -- move through them convincingly
    for k, doorway in pairs(self.doorways) do
        doorway:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for k, object in pairs(self.objects) do
        object:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for k, entity in pairs(self.entities) do
        if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    -- stencil out the door arches so it looks like the player is going through
    love.graphics.stencil(function()
        -- left
        love.graphics.rectangle('fill', -TILE_SIZE - 6, MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
            TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- right
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - 6,
            MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE, TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- top
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            -TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
        
        --bottom
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            VIRTUAL_HEIGHT - TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)
    
    if self.player then
        self.player:render()
    end

    love.graphics.setStencilTest()
end