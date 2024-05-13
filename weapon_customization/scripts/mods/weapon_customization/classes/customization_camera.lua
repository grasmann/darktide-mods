local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local table = table
    local class = class
    local pairs = pairs
    local vector3 = Vector3
    local tostring = tostring
    local managers = Managers
    local table_sort = table.sort
    local unit_alive = Unit.alive
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local table_remove = table.remove
    local vector3_unbox = vector3_box.unbox
    local math_easeInCubic = math.easeInCubic
    local math_ease_in_exp = math.ease_in_exp
    local unit_local_position = Unit.local_position
    local math_ease_out_elastic = math.ease_out_elastic
    local unit_set_local_position = Unit.set_local_position
    local math_round_with_precision = math.round_with_precision
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local MOVE_RESET_TIME = 1
    local MOVE_IN_DURATION = 1
    local MOVE_OUT_DURATION = .5
    local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┐ ┬ ┬┬┬  ┌┬┐  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌ ###################################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├┴┐│ │││   ││  ├─┤│││││││├─┤ │ ││ ││││ ###################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘└─┘┴┴─┘─┴┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘ ###################################################

local CustomizationCamera = class("CustomizationCamera")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

CustomizationCamera.init = function(self)
    mod:echot("CustomizationCamera.init")
    -- Data
    self.reset_duration = .5
	self.move_duration = 1
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Settings
    self:on_settings_changed()
end

CustomizationCamera.set = function(self, data, active)
    if data and data ~= false then
        mod:echot("CustomizationCamera.set")
        self.ui_weapon_spawner = data.ui_weapon_spawner
        self.weapon_spawn_data = data.ui_weapon_spawner._weapon_spawn_data
        self.link_unit = self.weapon_spawn_data.link_unit
        self.link_unit_default_position = vector3_box(unit_local_position(self.link_unit, 1))
        self.link_unit_position = self.link_unit_default_position
        self.world = data.world
        -- self.item = data.item
        -- self.gear_id = mod:get_gear_id(data.item)
        -- self.slot_info_id = mod:get_slot_info_id(data.item)
        -- self.item_name = mod:item_name_from_content_string(data.item.name)
    else
        mod:echot("CustomizationCamera.unset")
    end
    -- Init
    self.initialized = active or data
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

CustomizationCamera.on_settings_changed = function(self)
    self.camera_zoom = mod:get("mod_option_camera_zoom")
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

CustomizationCamera.play_zoom_sound = function(self, t, sound)
	if not self.sound_end or t >= self.sound_end then
		self.sound_end = t + self.sound_duration
		self.cosmetics_view:_play_sound(sound)
	end
end

-- WeaponBuildAnimation.animation_exists = function(self, attachment_slot)
--     for _, animation in pairs(self.animations) do
--         if animation.slot == attachment_slot then
--             return animation
--         end
--     end
-- end

CustomizationCamera.is_busy = function(self)
	-- return #self.animations > 0
end

-- WeaponBuildAnimation.is_attach_finished = function(self)
--     for _, entry in pairs(self.animations) do
--         if entry.type == "attach" and not entry.attach_done then
--             return false
--         end
--     end
--     return true
-- end

-- WeaponBuildAnimation.is_detach_finished = function(self)
--     for _, entry in pairs(self.animations) do
--         if entry.type == "detach" and not entry.detach_done then
--             return false
--         end
--     end
--     return true
-- end

-- WeaponBuildAnimation.is_all_finished = function(self)
--     for _, entry in pairs(self.animations) do
--         if not entry.finished then
--             return false
--         end
--     end
--     return true
-- end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

CustomizationCamera.set_light_positions = function(self)
    if mod.preview_lights then
        for _, unit_data in pairs(mod.preview_lights) do
            -- Get default position
            local default_position = vector3_unbox(unit_data.position)
            -- Get difference to link unit position
            local link_difference = vector3_unbox(self.link_unit_default_position) - vector3_unbox(self.link_unit_position)
            -- Position with offset
            local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
            unit_set_local_position(unit_data.unit, 1, light_position)
        end
    end
end

CustomizationCamera.update = function(self, dt, t)
    if self.initialized then
        -- local link_unit = weapon_spawn_data.link_unit
        -- local position = vector3_unbox(self.from_position)
        -- self.rotation_angle = self.ui_weapon_spawner._rotation_angle

        -- Camera movement
        -- if mod.do_move and self.camera_zoom and not self.demo then
        --     if mod.move_position then
        --         local last_move_position = mod.last_move_position and vector3_unbox(mod.last_move_position) or vector3_zero()
        --         local move_position = vector3_unbox(mod.move_position)
        --         if not mod:vector3_equal(last_move_position, move_position) then
        --             self.to_position = vector3_box(vector3_unbox(self.link_unit_default_position) + move_position)
        --             mod.move_end = t + mod.move_duration_in
        --             mod.current_move_duration = mod.move_duration_in
        --             mod.last_move_position = mod.move_position
        --             -- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
        --         end
        --     elseif self.link_unit_default_position then
        --         local last_move_position = vector3_unbox(self.from_position)
        --         local move_position = vector3_unbox(self.link_unit_default_position)
        --         if not mod:vector3_equal(move_position, last_move_position) then
        --             self.to_position = self.link_unit_default_position
        --             mod.move_end = t + mod.move_duration_out
        --             mod.current_move_duration = mod.move_duration_out
        --             mod.last_move_position = vector3_zero()
        --             -- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
        --         end
        --     end
        --     mod.do_move = nil
        --     mod.do_reset = nil
        --     mod.reset_start = nil
        -- else
        --     if mod.move_end and t <= mod.move_end then
        --         local progress = (mod.move_end - t) / mod.current_move_duration
        --         local anim_progress = math_easeInCubic(1 - progress)
        --         local lerp_position = vector3_lerp(vector3_unbox(self.from_position), vector3_unbox(self.to_position), anim_progress)
        --         mod.link_unit_position = vector3_box(lerp_position)
        --         if self.link_unit and unit_alive(self.link_unit) then
        --             unit_set_local_position(self.link_unit, 1, lerp_position)
        --         end
        --         self.from_position = vector3_box(lerp_position)
        --     elseif mod.move_end and t > mod.move_end then
        --         mod.move_end = nil
        --         if self.link_unit and unit_alive(self.link_unit) then
        --             unit_set_local_position(self.link_unit, 1, vector3_unbox(self.to_position))
        --         end
        --         if self.link_unit and unit_alive(self.link_unit) then
        --             mod.link_unit_position = vector3_box(unit_local_position(self.link_unit, 1))
        --         end
        --         if mod.current_move_duration == mod.move_duration_in and not mod:vector3_equal(vector3_unbox(self.to_position), vector3_zero()) then
        --             mod.do_reset = true
        --         end
        --     end
        -- end
        if self.camera_zoom then self:update_movement(dt, t) end

        -- Camera rotation
        -- if mod.do_rotation then
        --     local new_rotation = mod.new_rotation
        --     if new_rotation then
        --         if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
        --             -- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
        --         end
        --         -- self._rotation_angle = mod._last_rotation_angle or 0
        --         self._default_rotation_angle = new_rotation
        --         mod._last_rotation_angle = self._default_rotation_angle
        --         mod.check_rotation = true
        --         mod.do_reset = nil
        --         mod.reset_start = nil
        --         mod.do_rotation = nil
        --     end
        -- elseif mod.check_rotation and not mod.dropdown_open then
        --     if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
        --         if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
        --             mod.do_reset = true
        --         end
        --         mod.check_rotation = nil
        --     end
        -- end

        -- Lights
        self:set_light_positions(self)
    end
end

CustomizationCamera.update_movement = function(self, dt, t)
    if self.do_move then
        local from_position = self.to_position and vector3_unbox(self.to_position) or vector3_zero()
        local to_position = vector3_unbox(self.do_move) or vector3_zero()
        mod:echot("CustomizationCamera move from "..tostring(from_position).." to "..tostring(to_position))
        if not mod:vector3_equal(from_position, to_position) then
            self.from_position = self.to_position or vector3_box(vector3_zero())
            self.to_position = vector3_box(vector3_unbox(self.link_unit_default_position) + to_position)
            self.duration = self.move_duration
            self.move_end = t + self.duration
        end
    elseif self.move_end then
        if t < self.move_end then
            local progress = (self.move_end - t) / self.duration
            local anim_progress = math_easeInCubic(1 - progress)
            local lerp_position = vector3_lerp(vector3_unbox(self.from_position), vector3_unbox(self.to_position), anim_progress)
            unit_set_local_position(self.link_unit, 1, lerp_position)
            self.link_unit_position = vector3_box(lerp_position)
            mod:echot("CustomizationCamera moving -  "..tostring(lerp_position))
        else
            self.move_end = nil
            self.link_unit_position = self.to_position
            unit_set_local_position(self.link_unit, 1, vector3_unbox(self.link_unit_position))
        end
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

CustomizationCamera.focus = function(self, attachment_slot)

end

CustomizationCamera.move = function(self, position, no_reset)
	-- local view = self.cosmetics_view
	-- local ui_weapon_spawner = view and view._weapon_preview._ui_weapon_spawner
	-- local weapon_spawn_data = ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
	-- if weapon_spawn_data then
	-- 	mod:execute_extension(weapon_spawn_data.item_unit_3p, "weapon_animation_system", "move", position)
	-- end
	if position then
		self.do_move = vector3_box(position)
		-- self.do_move = true
		-- self.no_reset = no_reset
	elseif self.link_unit_position then
		self.do_move = self.link_unit_default_position
		-- self.do_move = true
	end
    mod:echot("CustomizationCamera move to "..tostring(self.do_move))
end

return CustomizationCamera