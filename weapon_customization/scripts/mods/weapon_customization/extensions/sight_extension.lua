local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local Crouch = mod:original_require("scripts/extension_systems/character_state_machine/character_states/utilities/crouch")
local Recoil = mod:original_require("scripts/utilities/recoil")
local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table = table
    local table_contains = table.contains
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3 = Vector3
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local Quaternion = Quaternion
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local Matrix4x4 = Matrix4x4
    local matrix4x4_transform = Matrix4x4.transform
    local Camera = Camera
    local camera_world_position = Camera.world_position
    local camera_vertical_fov = Camera.vertical_fov
    local camera_custom_vertical_fov = Camera.custom_vertical_fov
    local camera_set_custom_vertical_fov = Camera.set_custom_vertical_fov
    local camera_set_vertical_fov = Camera.set_vertical_fov
    local Unit = Unit
    local unit_get_data = Unit.get_data
    local unit_alive = Unit.alive
    local unit_world_position = Unit.world_position
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local World = World
    local world_update_unit_and_children = World.update_unit_and_children
    local world_create_particles = World.create_particles
    local world_destroy_particles = World.destroy_particles
    local math = math
    local math_lerp = math.lerp
    local math_easeInCubic = math.easeInCubic
    local math_rad = math.rad
    local math_clamp = math.clamp
    local math_clamp01 = math.clamp01
    local pairs = pairs
    local CLASS = CLASS
    local class = class
    local managers = Managers
    local type = type
    local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local EFFECT_OPTION = "mod_option_scopes_particle"
local EFFECT = "content/fx/particles/screenspace/screen_ogryn_dash"
local SOUND_OPTION = "mod_option_scopes_sound"
local SOUND = "wwise/events/weapon/play_lasgun_p3_mag_button"
local SIGHT_A = "#ID[7abb5fc7a4e06dcb]"
local SIGHT_B = "#ID[21bfd951c3d1b9fe]"
local LENS_A = "#ID[827a5604cb4ec7ff]"
local LENS_B = "#ID[c54f4d16d170cfdb]"

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SightExtension = class("SightExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

SightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    SightExtension.super.init(self, extension_init_context, unit, extension_init_data)

    -- self.world = extension_init_context.world
    -- self.player = extension_init_data.player
    -- self.is_local_unit = extension_init_data.is_local_unit
    self.ranged_weapon = extension_init_data.ranged_weapon
    -- self.player_unit = self.player.player_unit
    self.is_starting_aim = nil
    self._is_aiming = nil
    self.aim_timer = nil
    self.position_offset = nil
    self.rotation_offset = nil
    self.default_vertical_fov = nil
    self.vertical_fov = nil
    self.default_custom_vertical_fov = nil
    self.custom_vertical_fov = nil
    self.offset = nil
    self.sights = {}
    self.lenses = {}
    -- self.fx_extension = script_unit.extension(self.player_unit, "fx_system")
    -- self.first_person_extension = script_unit.extension(self.player_unit, "first_person_system")
	-- self.first_person_unit = self.first_person_extension:first_person_unit()
    -- self.unit_data_extension = script_unit_extension(self.player_unit, "unit_data_system")
    -- self.movement_state_component = self.unit_data_extension:read_component("movement_state")
    self:set_weapon_values()
    self.sniper_recoil_template = nil
    self.sniper_sway_template = nil

    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    managers.event:register(self, "weapon_customization_update_zoom", "update_zoom")

    self:on_settings_changed()
    
    self.initialized = true
end

SightExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_settings_changed")
    self.initialized = false
    self.offset = vector3_zero()
    SightExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SightExtension.is_braced = function(self)
    local template = self.ranged_weapon.weapon_template
    local alt_fire = template and template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return braced
end

SightExtension.is_hiding_crosshair = function(self)
    -- local first_person = self:get_first_person()
    -- local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    local laser = self.deactivate_crosshair_laser and mod:execute_extension(self.player_unit, "laser_pointer_system", "is_active")
    local sniper_or_scope = self:is_sniper() or self:is_scope()
    local aiming = self.deactivate_crosshair_aiming and self._is_aiming and sniper_or_scope
    -- mod:echot("deactivate_crosshair_aiming: "..tostring(self.deactivate_crosshair_aiming))
    -- mod:echot("laser: "..tostring(laser).." ".."sniper_or_scope: "..tostring(sniper_or_scope).." ".."aiming: "..tostring(aiming))
    return laser or aiming
end

SightExtension.is_aiming = function(self)
    return self._is_aiming
end

SightExtension.is_scope = function(self)
    return table_contains(mod.reflex_sights, self.sight_name)
end

SightExtension.is_sight = function(self)
    return table_contains(mod.sights, self.sight_name)
end

SightExtension.is_sniper = function(self)
    -- local sight_name = self.sights[1] and mod:item_name_from_content_string(self.sights[1].item)
    -- local alt_fire = self.ranged_weapon.weapon_template and self.ranged_weapon.weapon_template.alternate_fire_settings
    -- local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return table_contains(mod.scopes, self.sight_name) and not self:is_braced()
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

SightExtension.set_spectated = function(self, spectated)
    self.spectated = spectated
end

SightExtension.set_aiming = function(self, aiming, t)
    if aiming and not self._is_aiming then
        self:on_aim_start(t)
    elseif not aiming and self._is_aiming then
        self:on_aim_stop(t)
    end
end

SightExtension.set_lens_scales = function(self)
    local lens_2 = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens_2")
    local lens = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens")
    self.lens_scales = {
        lens_2 and lens_2.scale or vector3_box(vector3_zero()),
        lens and lens.scale or vector3_box(vector3_zero()),
    }
end

SightExtension.set_weapon_values = function(self)
    self.is_starting_aim = nil
    self._is_aiming = nil
    self.aim_timer = nil
    self.position_offset = nil
    self.rotation_offset = nil
    self.default_vertical_fov = nil
    self.vertical_fov = nil
    self.default_custom_vertical_fov = nil
    self.custom_vertical_fov = nil
    self.sights = {
        mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight"),
        mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2"),
    }
    self.lenses = {
        mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "scope_lens_01"),
        mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "scope_lens_02"),
    }
    self:set_lens_units()
    -- self.sight_unit = mod:get_attachment_slot_in_attachments(self.ranged_weapon)
    self.sight = self.sights[2] or self.sights[1] --self:get_sight()
    self.sight_name = self.sights[1] and mod:item_name_from_content_string(self.sights[1].item)
    self.offset = nil
    if self:is_scope() or self:is_sniper() then
        self:set_sight_offset()
    elseif self:is_sight() then
        self:set_sight_offset("no_scope_offset")
    end
    self.sniper_zoom = nil
    if self:is_sniper() then
        self.sniper_zoom = mod.sniper_zoom_levels[self.sight_name] or 7
        self:set_sniper_scope_unit()
    end
    self:set_lens_scales()
    self.start_time = self.ranged_weapon.weapon_template.actions.action_zoom
        and self.ranged_weapon.weapon_template.actions.action_zoom.total_time
        or self.ranged_weapon.weapon_template.actions.action_wield.total_time
    self.reset_time = self.ranged_weapon.weapon_template.actions.action_unzoom 
        and self.ranged_weapon.weapon_template.actions.action_unzoom.total_time
        or self.ranged_weapon.weapon_template.actions.action_wield.total_time
end

SightExtension.set_sight_offset = function(self, offset_type)
    local offset_type = offset_type or "scope_offset"
    local anchor = mod.anchors[self.ranged_weapon.weapon_template.name]
    local sight_offset = anchor and anchor[offset_type]
    self.offset = mod:_apply_anchor_fixes(self.ranged_weapon.item, offset_type) or sight_offset or vector3_zero()
end

SightExtension.set_sniper_scope_unit = function(self)
    if self.ranged_weapon.attachment_units then
        self.sniper_scope_unit = self:is_sniper() and mod:get_attachment_slot_in_attachments(self.ranged_weapon.attachment_units, "sight")
    --     mod:echo("sniper_scope_unit: "..tostring(self.sniper_scope_unit))
    -- else
    --     mod:echo("loool")
    end
end

SightExtension.set_lens_units = function(self)
    local reflex = {}
    mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, SIGHT_A, reflex) 
    mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, SIGHT_B, reflex)
    if #reflex >= 1 then
        local lenses = {}
        mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, LENS_A, lenses)
        mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, LENS_B, lenses)
        if #lenses == 2 then
            local scope_sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight_2")
            self.default_reticle_position = scope_sight and scope_sight.position
            -- mod:echo("default_reticle_position: "..tostring(self.default_reticle_position))
            if unit_get_data(lenses[1], "lens") == 2 then
                self.lens_units = {lenses[1], lenses[2], reflex[1]}
            else
                self.lens_units = {lenses[2], lenses[1], reflex[1]}
            end
            unit_set_unit_visibility(reflex[1], false)
        end
    end
end

SightExtension.set_default_fov = function(self, default_vertical_fov, default_custom_vertical_fov)
    if not self.default_vertical_fov then self.default_vertical_fov = default_vertical_fov end
    if not self.default_custom_vertical_fov then self.default_custom_vertical_fov = default_custom_vertical_fov end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

SightExtension.on_aim_start = function(self, t)
    self.is_starting_aim = true
    self._is_aiming = true
    self.aim_timer = t + self.start_time
    if self.sniper_zoom and self.lens_units then
        if self.lens_units[1] and unit_alive(self.lens_units[1]) and self.fx_extension and self.sniper_sound then
            self.fx_extension:trigger_wwise_event(SOUND, false, self.lens_units[1], 1)
        end
    end
end

SightExtension.on_aim_stop = function(self, t)
    self.is_starting_aim = nil
    self._is_aiming = nil
    self.aim_timer = t + self.reset_time
    if self.particle_effect then
        world_destroy_particles(self.world, self.particle_effect)
        self.particle_effect = nil
    end
end

SightExtension.on_unaim_start = function(self, t)
    self.is_starting_aim = nil
    self._is_aiming = nil
    self.aim_timer = t + self.reset_time
end

SightExtension.on_settings_changed = function(self)
    self.reticle_size = mod:get("mod_option_scopes_reticle_size")
    self.sniper_sound = mod:get("mod_option_scopes_sound")
    self.sniper_effect = mod:get("mod_option_scopes_particle")
    self.deactivate_crosshair_laser = mod:get("mod_option_deactivate_crosshair_laser")
    self.deactivate_crosshair_aiming = mod:get("mod_option_deactivate_crosshair_aiming")
    self.scopes_recoil = mod:get("mod_option_scopes_recoil")
    self.scopes_sway = mod:get("mod_option_scopes_sway")
    self.sniper_recoil_template = nil
    self.sniper_sway_template = nil
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

SightExtension.update = function(self, unit, dt, t)
    if self.initialized then
        -- local rotation = self.lens_units[3] and unit_local_rotation(self.lens_units[3], 1)

        if self.lens_units and self.lens_units[3] and self.default_reticle_position
                and not self.is_starting_aim and not self._is_aiming then
            local default_offset = vector3_unbox(self.default_reticle_position)
            unit_set_local_position(self.lens_units[3], 1, default_offset)
        end

        if self.is_starting_aim then
            if self.aim_timer and t <= self.aim_timer then
                local time_in_action = math_clamp01(self.start_time - (self.aim_timer - t))
                local progress = time_in_action / self.start_time
                local anim_progress = math.ease_sine(progress)
                if self.sniper_zoom and self.default_vertical_fov and self.default_custom_vertical_fov then
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = math_lerp(self.default_custom_vertical_fov, apply_fov, anim_progress)
                    self.vertical_fov = math_lerp(self.default_vertical_fov, apply_fov, anim_progress)
                end
                if self.offset then
                    if self.offset.position then
                        local position = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.position), anim_progress)
                        self.position_offset = vector3_box(position)
                        if self.lens_units and self.lens_units[3] and self.default_reticle_position then
                            local default_offset = vector3_unbox(self.default_reticle_position)
                            local rotation = unit_local_rotation(self.lens_units[3], 1)
                            local forward = Quaternion.forward(rotation)
                            local max = forward * 1
                            local current_reticle_offset = max - (forward * self.reticle_size)
                            local reticle_offset = vector3_lerp(default_offset, default_offset + current_reticle_offset, anim_progress)
                            unit_set_local_position(self.lens_units[3], 1, reticle_offset)
                            unit_set_unit_visibility(self.lens_units[3], true)
                        end
                    end
                    if self.offset.rotation then
                        local rotation = vector3_lerp(vector3_zero(), vector3_unbox(self.offset.rotation), anim_progress)
                        self.rotation_offset = vector3_box(rotation)
                    end
                end
            elseif self.aim_timer and t > self.aim_timer then
                self.is_starting_aim = nil
                if self.sniper_zoom then
                    if self.lens_units and self.lens_units[3] and self.default_reticle_position then
                        local default_offset = vector3_unbox(self.default_reticle_position)
                        local rotation = unit_local_rotation(self.lens_units[3], 1)
                        local forward = Quaternion.forward(rotation)
                        local max = forward * 1
                        local current_reticle_offset = max - (forward * self.reticle_size)
                        -- local scope_rotation = unit_local_rotation(self.lens_units[3], 2)
                        -- local mat = quaternion_matrix4x4(scope_rotation)
                        -- local rotated_pos = matrix4x4_transform(mat, current_reticle_offset)
                        unit_set_local_position(self.lens_units[3], 1, default_offset + current_reticle_offset)
                    end
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = apply_fov
                    self.vertical_fov = apply_fov
                end
                if self.offset then
                    if self.offset.position then self.position_offset = self.offset.position end
                    if self.offset.rotation then self.rotation_offset = self.offset.rotation end
                end
                self.aim_timer = nil
            end
        else
            if self.aim_timer and t <= self.aim_timer then
                local time_in_action = math_clamp01(self.reset_time - (self.aim_timer - t))
                local progress = time_in_action / self.reset_time
                local anim_progress = math.ease_sine(progress)
                if self.sniper_zoom and self.default_vertical_fov and self.default_custom_vertical_fov then
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = math_lerp(apply_fov, self.default_custom_vertical_fov, anim_progress)
                    self.vertical_fov = math_lerp(apply_fov, self.default_vertical_fov, anim_progress)
                end
                if self.offset then
                    if self.offset.position then
                        local position = vector3_lerp(vector3_unbox(self.offset.position), vector3_zero(), anim_progress)
                        self.position_offset = vector3_box(position)
                        if self.lens_units and self.lens_units[3] and self.default_reticle_position then
                            local default_offset = vector3_unbox(self.default_reticle_position)
                            local rotation = unit_local_rotation(self.lens_units[3], 1)
                            local forward = Quaternion.forward(rotation)
                            local max = forward * 1
                            local current_reticle_offset = max - (forward * self.reticle_size)
                            -- local scope_rotation = unit_local_rotation(self.lens_units[3], 2)
                            -- local mat = quaternion_matrix4x4(scope_rotation)
                            -- local rotated_pos = matrix4x4_transform(mat, current_reticle_offset)
                            local reticle_offset = vector3_lerp(default_offset + current_reticle_offset, default_offset, anim_progress)
                            unit_set_local_position(self.lens_units[3], 1, reticle_offset)
                        end
                    end
                    if self.offset.rotation then
                        local rotation = vector3_lerp(vector3_unbox(self.offset.rotation), vector3_zero(), anim_progress)
                        self.rotation_offset = vector3_box(rotation)
                    end
                end
            elseif self.aim_timer and t > self.aim_timer then
                if self.lens_units and self.lens_units[3] and self.default_reticle_position then
                    local default_offset = vector3_unbox(self.default_reticle_position)
                    unit_set_unit_visibility(self.lens_units[3], false)
                    unit_set_local_position(self.lens_units[3], 1, default_offset)
                end
                self.custom_vertical_fov = nil
                self.vertical_fov = nil
                self.position_offset = nil
                self.rotation_offset = nil
                self.aim_timer = nil
            end
        end

        self:update_scope_lenses()
    end
end

-- mod:hook(CLASS.ActionWeaponBase, "init", function(func, self, action_context, action_params, action_settings, ...)
--     func(self, action_context, action_params, action_settings, ...)
-- end)

SightExtension.update_position_and_rotation = function(self)
    if self:get_first_person() then
        if self.position_offset and self.first_person_unit and unit_alive(self.first_person_unit) then
            local position = unit_local_position(self.first_person_unit, 1)
            local rotation = unit_local_rotation(self.first_person_unit, 1)
            local mat = quaternion_matrix4x4(rotation)
            local rotated_pos = matrix4x4_transform(mat, vector3_unbox(self.position_offset))
            unit_set_local_position(self.first_person_unit, 1, position - rotated_pos)
            world_update_unit_and_children(self.world, self.first_person_unit)
        end

        if self.rotation_offset then
            local weapon_unit = self.ranged_weapon.weapon_unit
            if weapon_unit and unit_alive(weapon_unit) then
                local rot = vector3_unbox(self.rotation_offset)
                local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                unit_set_local_rotation(weapon_unit, 1, rotation)
            end
        end
    end
end

SightExtension.update_scope_lenses = function(self)
    local scales = {vector3_zero(), vector3_zero()}
    if not self._is_aiming and self.aim_timer == nil and self.lens_scales then
        scales = {
            self.lens_scales[1] and vector3_unbox(self.lens_scales[1]) or vector3_zero(),
            self.lens_scales[2] and vector3_unbox(self.lens_scales[2]) or vector3_zero(),
        }
    end
    if self.sniper_zoom and self.lens_units then
        if self.lens_units[1] and unit_alive(self.lens_units[1]) then
            unit_set_local_scale(self.lens_units[1], 1, scales[1])
        end
        if self.lens_units[2] and unit_alive(self.lens_units[2]) then
            unit_set_local_scale(self.lens_units[2], 1, scales[2])
        end
    elseif self.sniper_zoom and not self.lens_units then
        self:set_lens_units()
    end
    if self.sniper_effect and self:get_first_person() and self._is_aiming and self.sniper_zoom then
        if not self.particle_effect then
            self.particle_effect = world_create_particles(self.world, EFFECT, vector3(0, 0, 1))
        end
    elseif self.particle_effect then
        world_destroy_particles(self.world, self.particle_effect)
        self.particle_effect = nil
    end
end

SightExtension.update_zoom = function(self, viewport_name)
    if self.initialized and self:get_first_person() then
        -- local viewport = ScriptWorld.viewport(self.world, self.player.viewport_name)
        -- local camera = viewport and ScriptViewport.camera(viewport)
        local camera_manager = managers.state.camera
        local camera = camera_manager:camera(viewport_name)
        if camera then
            -- mod:echot("camera")
            self:set_default_fov(camera_vertical_fov(camera), camera_custom_vertical_fov(camera))
            if self.custom_vertical_fov then camera_set_custom_vertical_fov(camera, self.custom_vertical_fov) end
            if self.vertical_fov then camera_set_vertical_fov(camera, self.vertical_fov) end
        else
            -- mod:echot("!camera")
        end
    end
end

mod:hook(CLASS.HudElementCrosshair, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
    local parent = self._parent
    if parent then
        local player_extensions = parent:player_extensions()
        if player_extensions and player_extensions.unit and self._widget then
            local is_hiding_crosshair = mod:execute_extension(player_extensions.unit, "sight_system", "is_hiding_crosshair")
            
            self._widget.visible = not is_hiding_crosshair
        end
    end
    func(self, dt, t, input_service, ui_renderer, render_settings, ...)
end)

-- ##### ┬─┐┌─┐┌─┐┌─┐┬┬    ┌─┐┌┐┌┌┬┐  ┌─┐┬ ┬┌─┐┬ ┬ ####################################################################
-- ##### ├┬┘├┤ │  │ │││    ├─┤│││ ││  └─┐│││├─┤└┬┘ ####################################################################
-- ##### ┴└─└─┘└─┘└─┘┴┴─┘  ┴ ┴┘└┘─┴┘  └─┘└┴┘┴ ┴ ┴  ####################################################################

-- SightExtension.get_first_person = function(self)
--     local fp_ext = self.first_person_extension
--     local common = self.initialized and (self.is_local_unit or self.spectated)
--     local no_cutscene = not self.cut_scene
--     local first_person = fp_ext and fp_ext:is_in_first_person_mode()
--     return common and no_cutscene and first_person
-- end

SightExtension.get_sniper_sway_template = function(self, sway_template)
    if not self.sniper_sway_template and sway_template and self:is_sniper() then
        self.sniper_sway_template = table.clone(sway_template)
        for state, data in pairs(self.sniper_sway_template) do
            if data.max_sway then
                for angle_name, value in pairs(data.max_sway) do
                    local sway_state = self.sniper_sway_template[state]
                    local max_sway = sway_state.max_sway[angle_name]
                    self.sniper_sway_template[state].max_sway[angle_name] = value * self.scopes_sway
                end
            end
            if data.continuous_sway then
                for angle_name, value in pairs(data.continuous_sway) do
                    local sway_state = self.sniper_sway_template[state]
                    local continuous_sway = sway_state.continuous_sway[angle_name]
                    self.sniper_sway_template[state].continuous_sway[angle_name] = value * self.scopes_sway
                end
            end
        end
        return self.sniper_sway_template
    elseif self.sniper_sway_template and not self:is_sniper() then
        self.sniper_sway_template = nil
    elseif self.sniper_sway_template and self:is_sniper() and self._is_aiming then
        return self.sniper_sway_template
    end
    return sway_template
end

SightExtension.get_sniper_recoil_template = function(self, recoil_template)
    if not self.sniper_recoil_template and recoil_template and self:is_sniper() then
        self.sniper_recoil_template = table.clone(recoil_template)
        for state, data in pairs(self.sniper_recoil_template) do
            if data.offset_range then
                for offset_data_i, offset_data in pairs(data.offset_range) do
                    if offset_data.pitch then
                        for value_i, value in pairs(offset_data.pitch) do
                            local recoil_state = self.sniper_recoil_template[state]
                            local offset_range = recoil_state.offset_range[offset_data_i]
                            local pitch_value = offset_range.pitch[value_i]
                            self.sniper_recoil_template[state].offset_range[offset_data_i].pitch[value_i] = value * self.scopes_recoil
                        end
                    end
                end
            end
        end
        return self.sniper_recoil_template
    elseif self.sniper_recoil_template and not self:is_sniper() then
        self.sniper_recoil_template = nil
    elseif self.sniper_recoil_template and self:is_sniper() and self._is_aiming then
        return self.sniper_recoil_template
    end
    return recoil_template
end

return SightExtension
