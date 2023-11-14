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
    local unit_local_position = Unit.local_position
    local unit_set_local_position = Unit.set_local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local World = World
    local world_update_unit_and_children = World.update_unit_and_children
    local world_create_particles = World.create_particles
    local world_destroy_particles = World.destroy_particles
    local math = math
    local math_lerp = math.lerp
    local math_easeInCubic = math.easeInCubic
    local math_rad = math.rad
    local math_clamp = math.clamp
    local pairs = pairs
    local CLASS = CLASS
    local managers = Managers
    local type = type
    local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_extension = script_unit.extension
    -- local Fade = Fade
    -- local fade_update = Fade.update
    -- local fade_unregister_unit = Fade.unregister_unit
    -- local fade_register_unit = Fade.register_unit
    -- local fade_destroy = Fade.destroy
    -- local fade_set_min_fade = Fade.set_min_fade
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local EFFECT_OPTION = "mod_option_scopes_particle"
local EFFECT = "content/fx/particles/screenspace/screen_ogryn_dash"
local SOUND_OPTION = "mod_option_scopes_particle"
local SOUND = "wwise/events/weapon/play_lasgun_p3_mag_button"
local SIGHT_A = "#ID[7abb5fc7a4e06dcb]"
local SIGHT_B = "#ID[21bfd951c3d1b9fe]"
local LENS_A = "#ID[827a5604cb4ec7ff]"
local LENS_B = "#ID[c54f4d16d170cfdb]"
-- local min_lense_fade = 0
-- local max_lense_fade = 2

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SightsExtension = class("SightsExtension")

SightsExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.world = extension_init_context.world
    self.player = extension_init_data.player
    self.is_local_unit = extension_init_data.is_local_unit
    self.player_unit = self.player.player_unit
    self.viewport_name = self.player.viewport_name
    self.is_starting_aim = nil
    self.is_aiming = nil
    self.aim_timer = nil
    self.position_offset = nil
    self.rotation_offset = nil
    self.default_vertical_fov = nil
    self.vertical_fov = nil
    -- self.lense_fade = min_lense_fade
    self.default_custom_vertical_fov = nil
    self.custom_vertical_fov = nil
    -- self.fade_system = Fade.init()
    self.fx_extension = script_unit.extension(self.player_unit, "fx_system")
    self:on_weapon_equipped()
end

SightsExtension.delete = function(self)
    self:on_weapon_unequipped()
    -- fade_destroy(self.fade_system)
end

SightsExtension.on_weapon_equipped = function(self)
    self.ranged_weapon = nil
    self.weapon_extension = script_unit_extension(self.player_unit, "weapon_system")
    if self.weapon_extension then self:get_weapon_values() end
end

SightsExtension.on_weapon_unequipped = function(self)
    self.ranged_weapon = nil
    -- if self.lens_units then
    --     if self.lens_units[1] and unit_alive(self.lens_units[1]) then
    --         Fade.unregister_unit(self.fade_system, self.lens_units[1])
    --     end
    --     if self.lens_units[2] and unit_alive(self.lens_units[2]) then
    --         Fade.unregister_unit(self.fade_system, self.lens_units[2])
    --     end
    -- end
end

SightsExtension.check_scope = function(self)
    local item_name = self.sight and mod:item_name_from_content_string(self.sight.item)
    return table_contains(mod.reflex_sights, item_name)
end

SightsExtension.check_sight = function(self)
    local item_name = self.sight and mod:item_name_from_content_string(self.sight.item)
    return table_contains(mod.sights, item_name)
end

SightsExtension.check_sniper = function(self)
    local sight = mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight")
    local item_name = sight and mod:item_name_from_content_string(sight.item)
    local alt_fire = self.ranged_weapon.weapon_template and self.ranged_weapon.weapon_template.alternate_fire_settings
    local braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    return table_contains(mod.scopes, item_name) and not braced
end

SightsExtension.get_weapon_values = function(self)
    self.is_starting_aim = nil
    self.is_aiming = nil
    self.aim_timer = nil
    self.position_offset = nil
    self.rotation_offset = nil
    self.default_vertical_fov = nil
    self.vertical_fov = nil
    self.default_custom_vertical_fov = nil
    self.custom_vertical_fov = nil
    self.ranged_weapon = self.weapon_extension._weapons["slot_secondary"]
    self.sight = self:get_sight()
    self.offset = nil
    if self:check_scope() then
        self.offset = self:get_sight_offset()
    elseif self:check_sight() then
        self.offset = self:get_sight_offset("no_scope_offset")
    end
    self.sniper_zoom = nil
    if self:check_sniper() then
        self.sniper_zoom = self:get_sniper_zoom()
    end
    self.lens_units = nil
    self.lens_units = self:get_lens_units()
    self.lens_scales = nil
    self.lens_scales = self:get_lens_scales()
    self.start_time = self.ranged_weapon.weapon_template.actions.action_zoom
        and self.ranged_weapon.weapon_template.actions.action_zoom.total_time
        or self.ranged_weapon.weapon_template.actions.action_wield.total_time
    self.reset_time = self.ranged_weapon.weapon_template.actions.action_unzoom 
        and self.ranged_weapon.weapon_template.actions.action_unzoom.total_time
        or self.ranged_weapon.weapon_template.actions.action_wield.total_time
end

SightsExtension.get_sight = function(self)
    local sight = mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2")
    if not sight then sight = mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight") end
    return sight
end

SightsExtension.set_default_fov = function(self, default_vertical_fov, default_custom_vertical_fov)
    if not self.default_vertical_fov then self.default_vertical_fov = default_vertical_fov end
    if not self.default_custom_vertical_fov then self.default_custom_vertical_fov = default_custom_vertical_fov end
end

SightsExtension.update = function(self, unit, dt, t)
    if self.ranged_weapon then
        if self.is_starting_aim then
            if self.aim_timer and t <= self.aim_timer then
                local time_in_action = math_clamp(self.start_time - (self.aim_timer - t), 0, 1)
                local progress = math_clamp(time_in_action / self.start_time, 0, 1)
                local anim_progress = math_easeInCubic(progress)
                if self.sniper_zoom and self.default_vertical_fov and self.default_custom_vertical_fov then
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = math_clamp(math_lerp(self.default_custom_vertical_fov, apply_fov, anim_progress), apply_fov, self.default_custom_vertical_fov)
                    self.vertical_fov = math_clamp(math_lerp(self.default_vertical_fov, apply_fov, anim_progress), apply_fov, self.default_vertical_fov)
                    -- self.lense_fade = math_clamp(math_lerp(min_lense_fade, max_lense_fade, anim_progress), min_lense_fade, max_lense_fade)
                end
                if self.offset then
                    if self.offset.position then
                        local position = vector3_unbox(self.offset.position) * anim_progress
                        self.position_offset = vector3_box(position)
                    end
                    if self.offset.rotation then
                        local rotation = vector3_unbox(self.offset.rotation) * anim_progress
                        self.rotation_offset = vector3_box(rotation)
                    end
                end
            elseif self.aim_timer and t > self.aim_timer then
                self.is_starting_aim = nil
                if self.sniper_zoom then
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = apply_fov
                    self.vertical_fov = apply_fov
                end
                if self.offset then
                    if self.offset.position then self.position_offset = self.offset.position end
                    if self.offset.rotation then self.rotation_offset = self.offset.rotation end
                end
                self.is_aiming = true
                self.aim_timer = nil
            end
        else
            if self.aim_timer and t <= self.aim_timer then
                local time_in_action = math_clamp(self.reset_time - (self.aim_timer - t), 0, 1)
                local progress = math_clamp(time_in_action / self.reset_time, 0, 1)
                local anim_progress = math_easeInCubic(progress)
                if self.sniper_zoom and self.default_vertical_fov and self.default_custom_vertical_fov then
                    local apply_fov = math_rad(self.sniper_zoom)
                    self.custom_vertical_fov = math_clamp(math_lerp(apply_fov, self.default_custom_vertical_fov, anim_progress), apply_fov, self.default_custom_vertical_fov)
                    self.vertical_fov = math_clamp(math_lerp(apply_fov, self.default_vertical_fov, anim_progress), apply_fov, self.default_vertical_fov)
                    -- self.lense_fade = math_clamp(math_lerp(max_lense_fade, min_lense_fade, anim_progress), min_lense_fade, max_lense_fade)
                end
                if self.offset then
                    if self.offset.position then
                        local position = vector3_unbox(self.offset.position) * anim_progress
                        self.position_offset = vector3_box(position)
                    end
                    if self.offset.rotation then
                        local rotation = vector3_unbox(self.offset.rotation) * anim_progress
                        self.rotation_offset = vector3_box(rotation)
                    end
                end
            elseif self.aim_timer and t > self.aim_timer then
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

SightsExtension.update_position_and_rotation = function(self, fp_ext)
    if fp_ext:is_in_first_person_mode() then
        if self.position_offset then
            local first_person_unit = fp_ext._first_person_unit
            local position = unit_local_position(first_person_unit, 1)
            local rotation = unit_local_rotation(first_person_unit, 1)
            local mat = quaternion_matrix4x4(rotation)
            local rotated_pos = matrix4x4_transform(mat, vector3_unbox(self.position_offset))
            unit_set_local_position(first_person_unit, 1, position - rotated_pos)
            world_update_unit_and_children(fp_ext._world, first_person_unit)
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

SightsExtension.update_zoom = function(self, viewport_name)
    local viewport = ScriptWorld.viewport(self.world, viewport_name)
    local camera = ScriptViewport.camera(viewport)
    self:set_default_fov(camera_vertical_fov(camera), camera_custom_vertical_fov(camera))
    if self.custom_vertical_fov then camera_set_custom_vertical_fov(camera, self.custom_vertical_fov) end
    if self.vertical_fov then camera_set_vertical_fov(camera, self.vertical_fov) end
    -- local fade_position = camera_world_position(camera)
    -- fade_update(self.fade_system, fade_position)
end

SightsExtension.get_sniper_zoom = function(self, item)
    local sight = mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight")
    local item_name = sight and mod:item_name_from_content_string(sight.item)
    return mod.sniper_zoom_levels[item_name] or 7
end

SightsExtension.get_sight_offset = function(self, offset_type)
    local offset_type = offset_type or "scope_offset"
    local anchor = mod.anchors[self.ranged_weapon.weapon_template.name]
    local sight_offset = anchor and anchor[offset_type]
    sight_offset = mod:_apply_anchor_fixes(self.ranged_weapon.item, offset_type) or sight_offset
    return sight_offset
end

SightsExtension.get_lens_units = function(self)
    if mod:_recursive_find_attachment_name(self.ranged_weapon.item.attachments, "scope_lens_01")
            or mod:_recursive_find_attachment_name(self.ranged_weapon.item.attachments, "scope_lens_02") then
        local attachment_data = mod:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2")
        if attachment_data then
            local reflex = {}
            mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, SIGHT_A, reflex) 
            if #reflex == 0 then mod:_recursive_find_unit(self.ranged_weapon.weapon_unit, SIGHT_B, reflex) end
            if #reflex == 1 then
                local lenses = {}
                local sight = mod:_apply_anchor_fixes(self.ranged_weapon.item, "sight_2")
                mod:_recursive_find_unit(reflex[1], LENS_A, lenses)
                if #lenses == 0 then mod:_recursive_find_unit(reflex[1], LENS_B, lenses) end
                if #lenses == 2 then
                    -- fade_register_unit(self.fade_system, lenses[1], 0, 2, 1)
                    -- fade_register_unit(self.fade_system, lenses[2], 0, 2, 1)
                    if unit_get_data(lenses[1], "lens") == 2 then
                        return {lenses[1], lenses[2], reflex[1]}
                    else
                        return {lenses[2], lenses[1], reflex[1]}
                    end
                end
            end
        end
    end
end

SightsExtension.get_lens_scales = function(self)
    local lens_2 = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens_2")
    local lens = mod:_apply_anchor_fixes(self.ranged_weapon.item, "lens")
    return {
        lens_2 and lens_2.scale or vector3_box(vector3_zero()),
        lens and lens.scale or vector3_box(vector3_zero()),
    }
end

SightsExtension.update_scope_lenses = function(self)
    local scales = {vector3_zero(), vector3_zero()}
    if not self.is_aiming and self.lens_scales then
        scales = {
            self.lens_scales[1] and vector3_unbox(self.lens_scales[1]) or vector3_zero(),
            self.lens_scales[2] and vector3_unbox(self.lens_scales[2]) or vector3_zero(),
        }
    end
    if self.sniper_zoom and self.lens_units then
        if self.lens_units[1] and unit_alive(self.lens_units[1]) then
            unit_set_local_scale(self.lens_units[1], 1, scales[1])
            -- fade_set_min_fade(self.fade_system, self.lens_units[1], self.lense_fade)
        end
        if self.lens_units[2] and unit_alive(self.lens_units[2]) then
            unit_set_local_scale(self.lens_units[2], 1, scales[2])
            -- fade_set_min_fade(self.fade_system, self.lens_units[2], self.lense_fade)
        end
    elseif self.sniper_zoom and not self.lens_units then
        self.lens_units = self:get_lens_units()
    end
end

SightsExtension.on_ranged_wield = function(self)
end

SightsExtension.play_sound = function(self)

end

SightsExtension.on_aim_start = function(self, t)
    self.is_starting_aim = true
    self.aim_timer = t + self.start_time
    if self.sniper_zoom and self.lens_units then
        if mod:get(EFFECT_OPTION) then
            self.particle_effect = world_create_particles(self.world, EFFECT, vector3(0, 0, 1))
        end
        if self.lens_units[1] and unit_alive(self.lens_units[1]) and self.fx_extension and mod:get(SOUND_OPTION) then
            self.fx_extension:trigger_wwise_event(SOUND, false, self.lens_units[1], 1)
        end
    end
end

SightsExtension.on_aim_running = function(self, time_in_action, total_time)
end

SightsExtension.on_aim_finish = function(self)
end

SightsExtension.on_aim_stop = function(self, t)
    self.is_starting_aim = nil
    self.is_aiming = false
    self.aim_timer = t + self.reset_time
    if self.particle_effect then
        world_destroy_particles(self.world, self.particle_effect)
        self.particle_effect = nil
    end
end

SightsExtension.on_unaim_start = function(self, t)
    self.is_aiming = false
    self.aim_timer = t + self.reset_time
end

SightsExtension.on_unaim_running = function(self)
end

SightsExtension.on_unaim_finish = function(self)
end

-- ##### ┬─┐┌─┐┌─┐┌─┐┬┬    ┌─┐┌┐┌┌┬┐  ┌─┐┬ ┬┌─┐┬ ┬ ####################################################################
-- ##### ├┬┘├┤ │  │ │││    ├─┤│││ ││  └─┐│││├─┤└┬┘ ####################################################################
-- ##### ┴└─└─┘└─┘└─┘┴┴─┘  ┴ ┴┘└┘─┴┘  └─┘└┴┘┴ ┴ ┴  ####################################################################

mod:hook_require("scripts/utilities/sway", function(instance)
    if not instance._movement_state_settings then instance._movement_state_settings = instance.movement_state_settings end
    instance.movement_state_settings = function(sway_template, movement_state_component, ...)
        local unit = mod.movement_state_component_to_unit[movement_state_component]
        if unit and script_unit_has_extension(unit, "sights_system") then
            local sights_extension = script_unit_extension(unit, "sights_system")
            if not sights_extension.custom_vertical_fov then
                return instance._movement_state_settings(sway_template, movement_state_component, ...)
            end
        end
    end
end)

mod:hook_require("scripts/utilities/recoil", function(instance)
    if not instance._recoil_movement_state_settings then instance._recoil_movement_state_settings = instance.recoil_movement_state_settings end
    instance.recoil_movement_state_settings = function(recoil_template, movement_state_component, ...)
        local unit = mod.movement_state_component_to_unit[movement_state_component]
        if unit and script_unit_has_extension(unit, "sights_system") then
            local sights_extension = script_unit_extension(unit, "sights_system")
            if not sights_extension.custom_vertical_fov then
                return instance._recoil_movement_state_settings(recoil_template, movement_state_component, ...)
            end
        end
    end
end)

return SightsExtension
