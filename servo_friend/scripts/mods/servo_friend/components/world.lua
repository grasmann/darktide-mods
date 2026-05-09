local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local world = World
local world_physics_world = world.physics_world

-- ##### ┬ ┬┌─┐┬─┐┬  ┌┬┐ ##############################################################################################
-- ##### ││││ │├┬┘│   ││ ##############################################################################################
-- ##### └┴┘└─┘┴└─┴─┘─┴┘ ##############################################################################################

mod.world = function(self)
    local world_manager = self.world_manager or Managers and Managers.world

    if not world_manager then
        return nil
    end

    return world_manager:world("level_world")
end

mod.wwise_world = function(self)
    local current_world = self:world()
    local world_manager = self.world_manager or Managers and Managers.world

    if not current_world or not world_manager then
        return nil
    end

    return world_manager:wwise_world(current_world)
end

mod.physics_world = function(self)
    local current_world = self:world()

    if not current_world then
        return nil
    end

    return world_physics_world(current_world)
end
