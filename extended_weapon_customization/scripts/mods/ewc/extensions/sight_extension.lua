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
    local class = class
    local CLASS = CLASS
    local world = World
    local pairs = pairs
    local Camera = Camera
    local string = string
    local vector3 = Vector3
    local math_rad = math.rad
    local managers = Managers
    local tostring = tostring
    local viewport = Viewport
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
    local camera_vertical_fov = Camera.vertical_fov
    local unit_set_local_scale = unit.set_local_scale
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local camera_set_vertical_fov = Camera.set_vertical_fov
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
    local script_unit_add_extension = script_unit.add_extension
    local camera_custom_vertical_fov = Camera.custom_vertical_fov
    local script_unit_remove_extension = script_unit.remove_extension
    local unit_set_scalar_for_materials = unit.set_scalar_for_materials
    local camera_set_custom_vertical_fov = Camera.set_custom_vertical_fov
    local world_update_unit_and_children = world.update_unit_and_children
    local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"
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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.unit = unit
    self.world = extension_init_context.world

    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.weapon_action_component = self.unit_data_extension:read_component("weapon_action")
    self.first_person_unit = self.first_person_extension:first_person_unit()

    self.lens_transparency = 0
    self.fov = 0
    self.custom_fov = 0
    self.scale = 1
    self.offset = empty_offset
    self.current_offset = {
        position = vector3_box(vector3_zero()),
        rotation = vector3_box(vector3_zero()),
    }

    self:fetch_sight_offset()

    managers.event:register(self, "ewc_reloaded", "on_mod_reload")

end

SightExtension.fetch_sight_offset = function(self, item)

    self.default_vertical_fov = nil
    self.default_custom_vertical_fov = nil

    self.lense_1_unit = nil
    self.lense_2_unit = nil
    self.sight_unit = nil

    local pt = mod:pt()
    pt.debug_sight = {0, 0, 0, 0, 0, 0}

    self.weapon = item or self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    if self.weapon and self.weapon.attachments then
        self.sight_name = mod:fetch_attachment(self.weapon.attachments, "sight")
        self.sight_fix = nil

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

SightExtension.delete = function(self)
    
    managers.event:unregister(self, "ewc_reloaded")

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

SightExtension.is_wielded = function(self)
    return self.wielded_slot == SLOT_SECONDARY
end

mod:hook(CLASS.CameraManager, "post_update", function(func, self, dt, t, viewport_name, ...)
    -- Original function
    func(self, dt, t, viewport_name, ...)
    -- Get unit
    local camera_nodes = self._camera_nodes[viewport_name]
    local current_node = self:_current_node(camera_nodes)
    local root_unit = current_node:root_unit()
    if root_unit and unit_alive(root_unit) then
        local viewport = ScriptWorld.viewport(self._world, viewport_name)
        local camera_data = self._viewport_camera_data[viewport] or self._viewport_camera_data[viewport.get_data(viewport, "overridden_viewport")]
        -- Sights
        -- mod:execute_extension(root_unit, "sight_system", "update_zoom", viewport_name)
        local sight_extension = script_unit_extension(root_unit, "sight_system")
        if sight_extension and camera_data then
            sight_extension:update_zoom(viewport_name, camera_data.vertical_fov, camera_data.custom_vertical_fov)
        end
    end
end)

SightExtension.update_zoom = function(self, viewport_name, default_vertical_fov, default_custom_vertical_fov)
    self.default_vertical_fov = default_vertical_fov
    self.default_custom_vertical_fov = default_custom_vertical_fov

	if self.first_person_extension:is_in_first_person_mode() and self.offset.fov and self.offset.custom_fov then
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

    local custom_fov = self.offset.custom_fov and math_rad(self.offset.custom_fov)
    local fov = self.offset.fov and math_rad(self.offset.fov)
    local min_scale = self.offset.aim_scale or 1

    local is_aiming = self.alternate_fire_component and self.alternate_fire_component.is_active
    local weapon_action = self.weapon_action_component and self.weapon_action_component.current_action_name
    local is_charging = weapon_action and table_contains(AIM_ACTIONS, weapon_action)

    if self:is_wielded() and self.first_person_extension:is_in_first_person_mode() and (is_aiming or is_charging) then
        local offset_position = self.offset.position and vector3_unbox(self.offset.position) or vector3_zero()

        local pt = mod:pt()
        local debug_position_offset = vector3(pt.debug_sight[1], pt.debug_sight[2], pt.debug_sight[3])
        offset_position = offset_position + debug_position_offset

        current_position = vector3_lerp(current_position, offset_position, dt * 10)

        local offset_rotation = self.offset.rotation and vector3_unbox(self.offset.rotation) or vector3_zero()

        -- local pt = mod:pt()
        local debug_rotation_offset = vector3(pt.debug_sight[4], pt.debug_sight[5], pt.debug_sight[6])
        offset_rotation = offset_rotation + debug_rotation_offset

        current_rotation = vector3_lerp(current_rotation, offset_rotation, dt * 10)

        self.lens_transparency = math_lerp(self.lens_transparency, 1, dt * 20)
        self.scale = math_lerp(self.scale, min_scale, dt * 20)

        if custom_fov and fov and self.default_vertical_fov and self.default_custom_vertical_fov then
            self.custom_fov = math_lerp(self.custom_fov, custom_fov, dt * 20)
            self.fov = math_lerp(self.fov, fov, dt * 20)
        end

    else
        current_position = vector3_lerp(current_position, vector3_zero(), dt * 10)

        current_rotation = vector3_lerp(current_rotation, vector3_zero(), dt * 10)

        self.lens_transparency = math_lerp(self.lens_transparency, .25, dt * 20)
        self.scale = math_lerp(self.scale, 1, dt * 20)

        if custom_fov and fov and self.default_vertical_fov and self.default_custom_vertical_fov then
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

end
