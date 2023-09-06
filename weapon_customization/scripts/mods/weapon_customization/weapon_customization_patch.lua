local mod = get_mod("weapon_customization")

local MasterItems = mod:original_require("scripts/backend/master_items")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

local table_contains = table.contains
local table_clone_instance = table.clone_instance
local table_clone = table.clone
local vector3_box = Vector3Box
local vector3_unbox = vector3_box.unbox
local camera_local_position = Camera.local_position
local string_find = string.find

mod.weapon_templates = {}
mod.special_types = {
	"special_bullet",
	"melee",
    "knife",
}

mod.add_custom_attachments = {
    flashlight = "flashlights",
    bayonet = "bayonets",
    stock = "stocks",
    stock_2 = "stocks",
    rail = "rails",
    emblem_left = "emblems_left",
    emblem_right = "emblems_right",
}

mod.get_item_attachment_slots = function(self, item)
	local item_name = mod:item_name_from_content_string(item.name)
	local attachment_slots = {}
    if item_name and mod.attachment[item_name] then
        for attachment_slot, _ in pairs(mod.attachment[item_name]) do
            attachment_slots[#attachment_slots+1] = attachment_slot
        end
    end
	return attachment_slots
end

mod.randomize_weapon = function(self, item)
    local random_attachments = {}
    local item_name = mod:item_name_from_content_string(item.name)
    local attachment_slots = mod:get_item_attachment_slots(item)
    for _, attachment_slot in pairs(attachment_slots) do
        local attachments = {}
        if mod.attachment[item_name][attachment_slot] then
            for _, data in pairs(mod.attachment[item_name][attachment_slot]) do
                if not string_find(data.id, "default") then
                    attachments[#attachments+1] = data.id
                end
            end
            local random_attachment = math.random_array_entry(attachments)
            random_attachments[attachment_slot] = random_attachment
        end
    end
    return random_attachments
end

mod.setup_item_definitions = function(self)
    if mod:persistent_table("weapon_customization").item_definitions == nil then
        mod:persistent_table("weapon_customization").item_definitions = table_clone_instance(MasterItems.get_cached())
    end
    if mod:persistent_table("weapon_customization").bulwark_item_definitions == nil then
        mod:persistent_table("weapon_customization").bulwark_item_definitions = table_clone_instance(MasterItems.get_cached())
        mod:persistent_table("weapon_customization").bulwark_item_definitions["content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01"] = mod:persistent_table("weapon_customization").bulwark_item_definitions["content/items/weapons/player/melee/ogryn_slabshield_p1_m1"]
        mod:persistent_table("weapon_customization").bulwark_item_definitions["content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01"].base_unit = "content/weapons/enemy/shields/bulwark_shield_01/bulwark_shield_01"
    end
end

-- ##### ┬┌┐┌┬  ┬┌─┐┌┐┌┌┬┐┌─┐┬─┐┬ ┬ ###################################################################################
-- ##### ││││└┐┌┘├┤ │││ │ │ │├┬┘└┬┘ ###################################################################################
-- ##### ┴┘└┘ └┘ └─┘┘└┘ ┴ └─┘┴└─ ┴  ###################################################################################

-- mod:hook(CLASS.InventoryWeaponsView, "event_replace_list_item", function(func, self, item, ...)
-- 	self:replace_item_instance(item)
-- 	if self._previewed_item and item then
-- 		self._previewed_item = item
-- 	end
-- end)

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)
    local pass_input, pass_draw = func(self, dt, t, input_service, ...)
    if mod.weapon_changed then

        self:_spawn_profile(self._presentation_profile)
        -- self._preview_profile_equipped_items[mod.changed_weapon.__gear.slots[1]] = mod.changed_weapon
        -- self:_update_presentation_wield_item()
        -- self:_update_equipped_items()
        -- self:_equip_slot_item(slot_name, item, force_update)

        -- mod:redo_weapon_attachments(mod.equip_weapon)

		Managers.ui:item_icon_updated(mod.changed_weapon)
		Managers.event:trigger("event_item_icon_updated", mod.changed_weapon)
		Managers.event:trigger("event_replace_list_item", mod.changed_weapon)

        mod.weapon_changed = nil
    end
    return pass_input, pass_draw
end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###########################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┘├─┤ │ │  ├─┤ ###########################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###########################################################

mod._recursive_set_attachment = function(self, attachments, attachment_name, attachment_type, model, auto)
    -- if not table_contains(mod.automatic_slots, attachment_type) or auto then
        for attachment_slot, attachment_data in pairs(attachments) do
            if attachment_slot == attachment_type then
                attachment_data.item = model
                attachment_data.attachment_type = attachment_type
                attachment_data.attachment_name = attachment_name
            else
                if attachment_data.children then
                    self:_recursive_set_attachment(attachment_data.children, attachment_name, attachment_type, model, auto)
                end
            end
        end
    -- end
end

mod._recursive_remove_attachment = function(self, attachments, attachment_type)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
                -- attachment_data = nil
                attachments[attachment_name] = nil
                val = true
            else
                if attachment_data.children then
                    val = self:_recursive_remove_attachment(attachment_data.children, attachment_type)
                end
            end
            if val then break end
        end
    end
    return val
end

mod._recursive_find_attachment = function(self, attachments, attachment_type)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
                val = attachment_data
            else
                if attachment_data.children then
                    val = self:_recursive_find_attachment(attachment_data.children, attachment_type)
                end
            end
            if val then break end
        end
    end
    return val
end

mod._recursive_find_attachment_parent = function(self, attachments, attachment_type)
    local val = nil
    local parent = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
                val = true
            else
                if attachment_data.children then
                    val, parent = self:_recursive_find_attachment_parent(attachment_data.children, attachment_type)
                    if val and not parent then parent = attachment_name end
                end
            end
            if val then break end
        end
    end
    return val, parent
end

mod._recursive_get_attachments = function(self, attachments, out_found_attachments, all)
    out_found_attachments = out_found_attachments or {}
    for attachment_slot, attachment_data in pairs(attachments) do
        if type(attachment_data.item) == "string" and (attachment_data.item ~= "" or all) then
            out_found_attachments[#out_found_attachments+1] = {
                slot = attachment_slot,
                item = attachment_data.item,
            }
        end
        if attachment_data.children then
            self:_recursive_get_attachments(attachment_data.children, out_found_attachments)
        end
    end
end

mod._recursive_find_attachment_item_string = function(self, attachments, item_string)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_data.item == item_string then
                val = attachment_data
            else
                if attachment_data.children then
                    val = self:_recursive_find_attachment_item_string(attachment_data.children, item_string)
                end
            end
            if val then break end
        end
    end
    return val
end

mod._overwrite_attachments = function(self, item_data, attachments)
    local gear_id = mod:get_gear_id(item_data)
    local item_name = mod:item_name_from_content_string(item_data.name)
    for _, attachment_slot in pairs(mod.attachment_slots) do
        local attachment = mod:get_gear_setting(gear_id, attachment_slot, item_data)
        
        -- Customize
        if attachment and mod.attachment_models[item_name][attachment] then
            local model = mod.attachment_models[item_name][attachment].model
            local attachment_type = mod.attachment_models[item_name][attachment].type
            mod:_recursive_set_attachment(attachments, attachment, attachment_type, model)
            -- Automatic
            local automatic_equip = mod.attachment_models[item_name][attachment].automatic_equip
            if automatic_equip then
                for auto_type, auto_attachment in pairs(automatic_equip) do
                    local auto_model = mod.attachment_models[item_name][auto_attachment].model
                    mod:_recursive_set_attachment(attachments, attachment, auto_type, auto_model, true)
                end
            end
        else
            -- Default overwrite
            if mod.default_overwrite[item_name] and mod.default_overwrite[item_name][attachment_slot] then
                mod:_recursive_set_attachment(attachments, attachment, attachment_slot, mod.default_overwrite[item_name][attachment_slot])
            else
                -- Default
                local MasterItemsCached = MasterItems.get_cached()
                local master_item = MasterItemsCached[item_data.name]
                local attachment = mod:_recursive_find_attachment(master_item.attachments, attachment_slot)
                if attachment then
                    mod:_recursive_set_attachment(attachments, attachment, attachment_slot, attachment.item)
                end
            end
        end
    end
end





mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    if not instance.__resolve_item_packages_recursive then instance.__resolve_item_packages_recursive = instance._resolve_item_packages_recursive end
    instance._resolve_item_packages_recursive = function(attachments, items_dictionary, result)
        if instance.processing_item then
            local gear_id = mod:get_gear_id(instance.processing_item)
            if gear_id then
                mod:setup_item_definitions()
                -- Bulwark
                if mod:get_gear_setting(gear_id, "left", instance.processing_item) == "bulwark_shield_01" then
                    items_dictionary = mod:persistent_table("weapon_customization").bulwark_item_definitions
                end

                -- Add flashlight slot
                mod:_add_custom_attachments(instance.processing_item, attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(instance.processing_item, attachments)
            end

            instance.processing_item = nil
        end

        instance.__resolve_item_packages_recursive(attachments, items_dictionary, result)
    end

    if not instance._compile_item_instance_dependencies then instance._compile_item_instance_dependencies = instance.compile_item_instance_dependencies end
    instance.compile_item_instance_dependencies = function(item, items_dictionary, out_result, optional_mission_template)

        if item and item.__master_item then
            instance.processing_item = item
        end

        return instance._compile_item_instance_dependencies(item, items_dictionary, out_result, optional_mission_template)
    end

end)

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐  ┌─┐┬┌┬┐┬┌┐┌┌─┐ ##############################################################################
-- ##### └─┐│  │ │├─┘├┤   ├─┤│││││││││ ┬ ##############################################################################
-- ##### └─┘└─┘└─┘┴  └─┘  ┴ ┴┴┴ ┴┴┘└┘└─┘ ##############################################################################

mod:hook(CLASS.ActionAim, "start", function(func, self, action_settings, t, ...)
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:_recursive_find_attachment(self._weapon.item.__master_item.attachments, "sight")
        if sight and sight.item and sight.item ~= "" then
            local item_name = mod:item_name_from_content_string(sight.item)
            self._has_scope = table_contains(mod.reflex_sights, item_name)
            self._has_sight = table_contains(mod.sights, item_name)
            local anchor = mod.anchors[self._weapon_template.name]
            self._scope_offset = anchor and anchor["scope_offset"] or vector3_box(0, 0, 0)
            self._sight_offset = anchor and anchor["no_scope_offset"] or vector3_box(0, 0, 0)
            self.finish = function (self, reason, data, t, time_in_action)
                if self._is_local_unit and self._has_scope then
                    mod.camera_position = self._scope_offset
                elseif self._is_local_unit and self._has_sight then
                    mod.camera_position = self._sight_offset
                end
            end
        end
    end
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionAim, "running_action_state", function(func, self, t, time_in_action, ...)
    func(self, t, time_in_action, ...)
    if self._is_local_unit and self._has_scope then
        local progress = time_in_action / self._action_settings.total_time
        local position = vector3_unbox(self._scope_offset) * progress
        mod.camera_position = vector3_box(position)
    elseif self._is_local_unit and self._has_sight then
        local progress = time_in_action / self._action_settings.total_time
        local position = vector3_unbox(self._sight_offset) * progress
        mod.camera_position = vector3_box(position)
    end
end)

mod:hook(CLASS.ActionUnaim, "start", function(func, self, action_settings, t, ...)
    if self._is_local_unit and self._weapon and self._weapon.item and self._weapon.item.__master_item then
        local sight = mod:_recursive_find_attachment(self._weapon.item.__master_item.attachments, "sight")
        if sight and sight.item and sight.item ~= "" then
            local item_name = mod:item_name_from_content_string(sight.item)
            self._has_scope = table_contains(mod.reflex_sights, item_name)
            self._has_sight = table_contains(mod.sights, item_name)
            local anchor = mod.anchors[self._weapon_template.name]
            self._scope_offset = anchor and anchor["scope_offset"] or vector3_box(0, 0, 0)
            self._sight_offset = anchor and anchor["no_scope_offset"] or vector3_box(0, 0, 0)
            self.running_action_state = function(self, t, time_in_action, ...)
                if self._is_local_unit and self._has_scope then
                    local progress = time_in_action / self._action_settings.total_time
                    local position = vector3_unbox(self._scope_offset) * (1 - progress)
                    mod.camera_position = vector3_box(position)
                elseif self._is_local_unit and self._has_sight then
                    local progress = time_in_action / self._action_settings.total_time
                    local position = vector3_unbox(self._sight_offset) * (1 - progress)
                    mod.camera_position = vector3_box(position)
                end
            end
        end
    end
    func(self, action_settings, t, ...)
end)

mod:hook(CLASS.ActionUnaim, "finish", function(func, self, reason, data, t, time_in_action, ...)
    func(self, reason, data, t, time_in_action, ...)
    if self._is_local_unit and self._has_scope then
        mod.camera_position = nil
    elseif self._is_local_unit and self._has_sight then
        mod.camera_position = nil
    end
end)

mod:hook(CLASS.CameraManager, "_update_camera_properties", function(func, self, camera, shadow_cull_camera, current_node, camera_data, viewport_name, ...)
    func(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name, ...)
    if viewport_name == "player1" and mod.camera_position then
        local mat = Quaternion.matrix4x4(Camera.local_rotation(camera))
        local rotated_pos = Matrix4x4.transform(mat, vector3_unbox(mod.camera_position))
        local position = camera_local_position(camera) + rotated_pos
        ScriptCamera.set_local_position(camera, position)
    end
end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬┌─┐ ##########################################################################
-- ##### │ │ ├┤ │││  ├─┘├┬┘├┤ └┐┌┘│├┤ │││└─┐ ##########################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘└─┘ ##########################################################################

mod:hook(CLASS.UIWeaponSpawner, "start_presentation", function(func, self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

    local attachments = item.__master_item and item.__master_item.attachments
    if item and attachments then
        local gear_id = mod:get_gear_id(item)
        if gear_id then
            mod:setup_item_definitions()
             -- Bulwark
            if mod:get_gear_setting(gear_id, "left", item) == "bulwark_shield_01" then
                self._item_definitions = mod:persistent_table("weapon_customization").bulwark_item_definitions
            end

            -- Add flashlight slot
            mod:_add_custom_attachments(item, attachments)
            
            -- Overwrite attachments
            mod:_overwrite_attachments(item, attachments)
        end
    end

    func(self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

end)

mod:hook(CLASS.ViewElementWeaponStats, "present_item", function(func, self, item, is_equipped, on_present_callback, ...)
    mod.previewed_weapon_flashlight = mod:_has_flashlight_attachment(item)
	func(self, item, is_equipped, on_present_callback, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponActions, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:_has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponInfo, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:_has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponPatterns, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:_has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponActionsExtended, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:_has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐┌─┐ ##############################################################
-- ##### │││├┤ ├─┤├─┘│ ││││   │ ├┤ │││├─┘│  ├─┤ │ ├┤ └─┐ ##############################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘   ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘└─┘ ##############################################################



mod.template_add_torch = function(self, orig_weapon_template)
	if orig_weapon_template then
		local weapon_template = orig_weapon_template
		if not self.weapon_templates[orig_weapon_template.name] then
			self.weapon_templates[orig_weapon_template.name] = table_clone(orig_weapon_template)
			weapon_template = self.weapon_templates[orig_weapon_template.name]
			if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
				weapon_template.displayed_weapon_stats_table.damage[3] = nil
			end
			if weapon_template.displayed_attacks and weapon_template.displayed_attacks.special then
				if table_contains(self.special_types, weapon_template.displayed_attacks.special.type) then
					weapon_template.displayed_attacks.special = {
						desc = "loc_stats_special_action_flashlight_desc",
						display_name = "loc_weapon_special_flashlight",
						type = "flashlight"
					}
				end
			end
		else
			weapon_template = self.weapon_templates[orig_weapon_template.name]
		end
		if weapon_template and self.previewed_weapon_flashlight then
			return weapon_template
		end
	end
	return orig_weapon_template
end

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)
	if not instance._weapon_template then instance._weapon_template = instance.weapon_template end
	instance.weapon_template = function(template_name)
		local weapon_template = instance._weapon_template(template_name)
		return mod:template_add_torch(weapon_template)
	end
end)


mod:hook_require("scripts/settings/equipment/flashlight_templates", function(instance)
    for name, template in pairs(instance) do
        template.light.first_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
        template.light.third_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
    end
end)

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

local table_contains = table_contains

mod.special_actions = {
    "weapon_extra_pressed",
}

mod:hook(CLASS.InputService, "get", function(func, self, action_name, ...)
	local pressed = func(self, action_name, ...)
    if mod.initialized then
        if table_contains(mod.special_actions, action_name) and mod:has_flashlight_attachment() then
            if pressed then
                mod:toggle_flashlight()
            end
            return self:get_default(action_name)
        end
        if action_name == "weapon_extra_hold" and mod:has_flashlight_attachment() then
            return self:get_default(action_name)
        end
	end
	return pressed
end)