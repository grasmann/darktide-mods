local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local table = table
    local class = class
    local pairs = pairs
    local Camera = Camera
    local string = string
    local vector3 = Vector3
    local math_rad = math.rad
    local managers = Managers
    local tostring = tostring
    local math_lerp = math.lerp
    local unit_node = unit.node
    local quaternion = Quaternion
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local string_split = string.split
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local unit_get_data = unit.get_data
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local shading_environment = ShadingEnvironment
    local unit_set_local_scale = unit.set_local_scale
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local camera_set_vertical_fov = Camera.set_vertical_fov
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
    local shading_environment_apply = shading_environment.apply
    local shading_environment_scalar = shading_environment.scalar
    local unit_set_scalar_for_materials = unit.set_scalar_for_materials
    local shading_environment_set_scalar = shading_environment.set_scalar
    local camera_set_custom_vertical_fov = Camera.set_custom_vertical_fov
    local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local SLOT_POCKETABLE = "slot_pocketable"
local SLOT_POCKETABLE_SMALL = "slot_pocketable_small"
local SLOT_GRENADE_ABILITY = "slot_grenade_ability"
local DOF_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY, SLOT_POCKETABLE, SLOT_POCKETABLE_SMALL, SLOT_GRENADE_ABILITY}
local empty_offset = {
    position = vector3_box(vector3_zero()),
    rotation = vector3_box(vector3_zero()),
}
local AIM_ACTIONS = {
    "action_charge",
    "action_overload_charge",
}

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SightExtension = class("SightExtension")

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

SightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.unit = unit
    self.world = extension_init_context.world

    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.weapon_action_component = self.unit_data_extension:read_component("weapon_action")
    self.first_person_unit = self.first_person_extension:first_person_unit()

    self.wielded_slot = extension_init_data.wielded_slot

    self.dof_strength = .5
    self.dof_target = 10
    self.dof_aim_target = 5
    self.dof_near_scale = 0

    self.lens_transparency = 0
    self.fov = 0
    self.custom_fov = 0
    self.scale = 1
    self.offset = empty_offset
    self.current_offset = {
        position = vector3_box(vector3_zero()),
        rotation = vector3_box(vector3_zero()),
    }

    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")
    managers.event:register(self, "ewc_cutscene", "on_cutscene")

    self:on_settings_changed()

end

SightExtension.delete = function(self)
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")
    managers.event:unregister(self, "ewc_cutscene")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

SightExtension.on_settings_changed = function(self)
    self.dof_strength = mod:get("mod_weapon_dof_strength")
end

SightExtension.on_cutscene = function(self, cutscene_playing)
    if not cutscene_playing then
        -- Execute "on_wield"
        self:on_wield(self.wielded_slot)
    end
end

SightExtension.on_mod_reload = function(self)
    self:fetch_sight_offset()
end

SightExtension.on_equip_weapon = function(self, item)
    self:fetch_sight_offset(item)
end

SightExtension.on_wield = function(self, slot_name)
    self.wielded_slot = slot_name
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SightExtension.is_wielded = function(self)
    return self.wielded_slot == SLOT_SECONDARY
end

SightExtension.is_in_first_person_mode = function(self)
    return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
end

SightExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

SightExtension.has_offset_fov = function(self)
    return self.offset.fov and self.offset.custom_fov
end

SightExtension.has_default_fov = function(self)
    return self.default_vertical_fov and self.default_custom_vertical_fov
end

SightExtension.weapon_action = function(self)
    return self.weapon_action_component and self.weapon_action_component.current_action_name
end

SightExtension.is_charging = function(self, optional_weapon_action)
    local weapon_action = optional_weapon_action or self:weapon_action()
    return table_contains(AIM_ACTIONS, weapon_action)
end

SightExtension.update_zoom = function(self, viewport_name, default_vertical_fov, default_custom_vertical_fov)
    self.default_vertical_fov = default_vertical_fov
    self.default_custom_vertical_fov = default_custom_vertical_fov

	if self:is_in_first_person_mode() and self:has_offset_fov() then
		local viewport = ScriptWorld.viewport(self.world, viewport_name)
		local camera = viewport and ScriptViewport.camera(viewport)
		if camera then
			if self.custom_fov then camera_set_custom_vertical_fov(camera, self.custom_fov) end
			if self.fov then camera_set_vertical_fov(camera, self.fov) end
            ScriptCamera.force_update(self.world, camera)
		end
	end
end

SightExtension.update = function(self, dt, t)

    local current_position = vector3_unbox(self.current_offset.position) or vector3_zero()
    local current_rotation = vector3_unbox(self.current_offset.rotation) or vector3_zero()

    local offset = self.offset or empty_offset
    local custom_fov = offset.custom_fov and math_rad(offset.custom_fov)
    local fov = offset.fov and math_rad(offset.fov)
    local min_scale = offset.aim_scale or 1

    if self:is_wielded() and self:is_in_first_person_mode() and (self:is_aiming() or self:is_charging()) then
        local offset_position = offset.position and vector3_unbox(offset.position) or vector3_zero()

        local debug_position_offset = vector3(pt.debug_sight[1], pt.debug_sight[2], pt.debug_sight[3])
        offset_position = offset_position + debug_position_offset

        current_position = vector3_lerp(current_position, offset_position, dt * 10)

        local offset_rotation = offset.rotation and vector3_unbox(offset.rotation) or vector3_zero()

        local debug_rotation_offset = vector3(pt.debug_sight[4], pt.debug_sight[5], pt.debug_sight[6])
        offset_rotation = offset_rotation + debug_rotation_offset

        current_rotation = vector3_lerp(current_rotation, offset_rotation, dt * 10)

        self.lens_transparency = math_lerp(self.lens_transparency, 1, dt * 20)
        self.scale = math_lerp(self.scale, min_scale, dt * 20)

        if custom_fov and fov and self:has_default_fov() then
            self.custom_fov = math_lerp(self.custom_fov, custom_fov, dt * 20)
            self.fov = math_lerp(self.fov, fov, dt * 20)
        end

    else
        current_position = vector3_lerp(current_position, vector3_zero(), dt * 10)

        current_rotation = vector3_lerp(current_rotation, vector3_zero(), dt * 10)

        self.lens_transparency = math_lerp(self.lens_transparency, .25, dt * 20)
        self.scale = math_lerp(self.scale, 1, dt * 20)

        if custom_fov and fov and self:has_default_fov() then
            self.custom_fov = math_lerp(self.custom_fov, self.default_custom_vertical_fov, dt * 20)
            self.fov = math_lerp(self.fov, self.default_vertical_fov, dt * 20)
        end

    end

    if self.lense_1_unit and unit_alive(self.lense_1_unit) then
        unit_set_scalar_for_materials(self.lense_1_unit, "inv_jitter_alpha", self.lens_transparency, true)
    end
    
    if self.lense_2_unit and unit_alive(self.lense_2_unit) then
        unit_set_scalar_for_materials(self.lense_2_unit, "inv_jitter_alpha", self.lens_transparency - .1, true)
    end

    if self.sight_unit and unit_alive(self.sight_unit) then
        unit_set_local_scale(self.sight_unit, 1, vector3(1, self.scale, 1))
    end

    self.current_offset.position:store(current_position)
    self.current_offset.rotation:store(current_rotation)

    local first_person_unit = self.first_person_extension:first_person_unit()

    if first_person_unit and unit_alive(first_person_unit) then

        local node = unit_node(first_person_unit, "ap_aim")

        unit_set_local_position(first_person_unit, node, current_position)
        unit_set_local_rotation(first_person_unit, node, quaternion_from_vector(current_rotation))

    end

    -- Dof
    if table_contains(DOF_SLOTS, self.wielded_slot) then
        local target_dof = self:is_aiming() and self.dof_aim_target or self.dof_target
        self.dof_near_scale = math_lerp(self.dof_near_scale, target_dof, dt * 10) * (0 + self.dof_strength / 2)
    else
        self.dof_near_scale = math_lerp(self.dof_near_scale, 0, dt * 10)
    end

end

SightExtension.apply_weapon_dof = function(self, shading_env)

    -- Check if depth of field is on
    if shading_environment_scalar(shading_env, "dof_enabled") then

        -- Set depth of field
        shading_environment_set_scalar(shading_env, "dof_focal_distance", .5)
        shading_environment_set_scalar(shading_env, "dof_focal_region", 75)
        shading_environment_set_scalar(shading_env, "dof_focal_region_start", -1)
        shading_environment_set_scalar(shading_env, "dof_focal_region_end", 76)
        shading_environment_set_scalar(shading_env, "dof_focal_near_scale", self.dof_near_scale)
        shading_environment_set_scalar(shading_env, "dof_focal_far_scale", 1)

		shading_environment_apply(shading_env)

	end

end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

SightExtension.fetch_sight_offset = function(self, item)

    self.offset = nil
    self.sight_name = nil
    self.sight_fix = nil

    self.default_vertical_fov = nil
    self.default_custom_vertical_fov = nil

    self.lense_1_unit = nil
    self.lense_2_unit = nil
    self.sight_unit = nil

    pt.debug_sight = {0, 0, 0, 0, 0, 0}

    self.weapon = item or self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    
    if self.weapon and self.weapon.attachments then
        self.sight_name = mod:fetch_attachment(self.weapon.attachments, "sight_2") or mod:fetch_attachment(self.weapon.attachments, "sight")

        local sight_offset_fixes = mod:collect_fixes(self.weapon, "sight_offset")
        if sight_offset_fixes then
            for fix, attachment_slot in pairs(sight_offset_fixes) do
                self.sight_fix = fix
            end
        end

        if self.sight_fix then
            self.offset = self.sight_fix.offset
        else
            self.offset = empty_offset
        end

        local unit_1p, unit_3p, attachments_by_unit_1p, attachments_by_unit_3p = self.visual_loadout_extension:unit_and_attachments_from_slot(SLOT_SECONDARY)
        local attachments_1p = attachments_by_unit_1p and attachments_by_unit_1p[unit_1p]
        if attachments_1p then
            for i = 1, #attachments_1p do
                local attachment_unit = attachments_1p[i]
                if attachment_unit and unit_alive(attachment_unit) then
                    local attachment_slot_string = unit_get_data(attachment_unit, "attachment_slot")
                    local attachment_slot_parts = string_split(attachment_slot_string, ".")
                    local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]

                    if attachment_slot == "lense_1" then
                        self.lense_1_unit = attachment_unit
                        unit_set_shader_pass_flag_for_meshes(self.lense_1_unit, "one_bit_alpha", true, true)
                        mod:print("lense 1 unit: "..tostring(self.lense_1_unit))
                    elseif attachment_slot == "lense_2" then
                        self.lense_2_unit = attachment_unit
                        unit_set_shader_pass_flag_for_meshes(self.lense_2_unit, "one_bit_alpha", true, true)
                        mod:print("lense 2 unit: "..tostring(self.lense_2_unit))
                    elseif attachment_slot == "sight" then
                        self.sight_unit = attachment_unit
                        mod:print("sight unit: "..tostring(self.sight_unit))
                    end
                end
            end
        end
    end

end
