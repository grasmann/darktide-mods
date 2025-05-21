local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local world = World
local world_physics_world = world.physics_world

-- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
-- ##### ││││ │├┬┘│   ││ ##############################################################################################
-- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

-- Get world
mod.world = function(self)
    -- Return world
    return self.world_manager and self.world_manager:world("level_world")
end

-- Get wwise world
mod.wwise_world = function(self)
    -- Get world
    local world = self:world()
    -- Return wwise world
    return world and self.world_manager and self.world_manager:wwise_world(world)
end

-- Get physics world
mod.physics_world = function(self)
    -- Get world
    local world = self:world()
    -- Return physics world
    return world and world_physics_world(world)
end