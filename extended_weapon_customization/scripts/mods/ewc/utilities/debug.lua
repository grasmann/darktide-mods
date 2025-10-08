local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.debug_sight_clear = function(self)
    pt.debug_sight = {0, 0, 0, 0, 0, 0}
end

mod.debug_sight_set = function(self, px, py, pz, rx, ry, rz)
    if not pt.debug_sight then
        self:debug_sight_clear()
    end
    pt.debug_sight = {pt.debug_sight[1] + px, pt.debug_sight[2] + py, pt.debug_sight[3] + pz, pt.debug_sight[4] + rx, pt.debug_sight[5] + ry, pt.debug_sight[6] + rz}
    mod:echo(string_format("px: %f, py: %f, pz: %f, rx: %f, ry: %f, rz: %f", pt.debug_sight[1], pt.debug_sight[2], pt.debug_sight[3], pt.debug_sight[4], pt.debug_sight[5], pt.debug_sight[6]))
end

local rotation_step = .1
local position_step = .01

mod.rotate_x = function() mod:debug_sight_set(0, 0, 0, rotation_step, 0, 0) end
mod.rotate_x_2 = function() mod:debug_sight_set(0, 0, 0, -rotation_step, 0, 0) end

mod.rotate_y = function() mod:debug_sight_set(0, 0, 0, 0, rotation_step, 0) end
mod.rotate_y_2 = function() mod:debug_sight_set(0, 0, 0, 0, -rotation_step, 0) end

mod.rotate_z = function() mod:debug_sight_set(0, 0, 0, 0, 0, rotation_step) end
mod.rotate_z_2 = function() mod:debug_sight_set(0, 0, 0, 0, 0, -rotation_step) end

mod.move_x = function() mod:debug_sight_set(position_step, 0, 0, 0, 0, 0) end
mod.move_x_2 = function() mod:debug_sight_set(-position_step, 0, 0, 0, 0, 0) end

mod.move_y = function() mod:debug_sight_set(0, position_step, 0, 0, 0, 0) end
mod.move_y_2 = function() mod:debug_sight_set(0, -position_step, 0, 0, 0, 0) end

mod.move_z = function() mod:debug_sight_set(0, 0, position_step, 0, 0, 0) end
mod.move_z_2 = function() mod:debug_sight_set(0, 0, -position_step, 0, 0, 0) end