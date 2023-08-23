local mod = get_mod("weapon_customization")

-- ##### ┬┌┐┌┬  ┬┌─┐┌┐┌┌┬┐┌─┐┬─┐┬ ┬ ###################################################################################
-- ##### ││││└┐┌┘├┤ │││ │ │ │├┬┘└┬┘ ###################################################################################
-- ##### ┴┘└┘ └┘ └─┘┘└┘ ┴ └─┘┴└─ ┴  ###################################################################################

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)
    func(self, dt, t, input_service, ...)
    if mod.weapon_changed then
        self:_spawn_profile(self._presentation_profile)
        mod.weapon_changed = nil
    end
end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###########################################################
-- ##### │ │ ├┤ │││  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤   ├─┘├─┤ │ │  ├─┤ ###########################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###########################################################

mod._recursive_set_attachment = function(attachments, attachment_type, model)
    for attachment_name, attachment_data in pairs(attachments) do
        if attachment_name == attachment_type then
            attachment_data.item = model
        else
            if attachment_data.children then
                mod._recursive_set_attachment(attachment_data.children, attachment_type, model)
            end
        end
    end
end

mod._recursive_find_attachment = function(attachments, attachment_type)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
                val = true
            else
                if attachment_data.children then
                    val = mod._recursive_find_attachment(attachment_data.children, attachment_type)
                end
            end
            if val then break end
        end
    end
    return val
end

mod:hook(CLASS.UIWeaponSpawner, "start_presentation", function(func, self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

    local attachments = item.__master_item and item.__master_item.attachments
    if item and attachments and item.__master_item and item.__master_item.weapon_template then
        local gear_id, original_gear_id = mod:get_gear_id(item)
        original_gear_id = original_gear_id or gear_id
        if original_gear_id then

            -- Add flashlight slot
            if item.__gear.slots[1] == "slot_secondary" then
                if not mod._recursive_find_attachment(attachments, "flashlight") then
                    attachments.flashlight = {
                        children = {},
                        item = "",
                    }
                end
            end

            for _, attachment_slot in pairs(mod.attachment_slots) do
                local attachment = mod:get_gear_setting(original_gear_id, attachment_slot)
                local item_name = mod:item_name_from_content_string(item.name)
                if attachment and mod.attachment_models[item_name][attachment] then
                    local model = mod.attachment_models[item_name][attachment].model
                    local attachment_type = mod.attachment_models[item_name][attachment].type

                    mod._recursive_set_attachment(attachments, attachment_type, model)
                end
            end
        end
    end

    func(self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    if not instance.__resolve_item_packages_recursive then instance.__resolve_item_packages_recursive = instance._resolve_item_packages_recursive end
    instance._resolve_item_packages_recursive = function(attachments, items_dictionary, result)
        local something_changed = false
        local item_name = nil
        if instance.processing_item then
            item_name = mod:item_name_from_content_string(instance.processing_item.name) 
            local gear_id, original_gear_id = mod:get_gear_id(instance.processing_item)
            original_gear_id = original_gear_id or gear_id

            -- Add flashlight slot
            if instance.processing_item.__gear.slots[1] == "slot_secondary" then
                if not mod._recursive_find_attachment(attachments, "flashlight") then
                    attachments.flashlight = {
                        children = {},
                        item = "",
                    }
                end
            end

            for _, attachment_slot in pairs(mod.attachment_slots) do
                local attachment = mod:get_gear_setting(original_gear_id, attachment_slot)
                -- local item_name = mod:item_name_from_content_string(instance.processing_item.name)
                if attachment and mod.attachment_models[item_name][attachment] then
                    local model = mod.attachment_models[item_name][attachment].model
                    local attachment_type = mod.attachment_models[item_name][attachment].type

                    mod._recursive_set_attachment(attachments, attachment_type, model)

                    something_changed = true
                end
            end

            instance.processing_item = nil
        end

        instance.__resolve_item_packages_recursive(attachments, items_dictionary, result)
    end

    if not instance._compile_item_instance_dependencies then instance._compile_item_instance_dependencies = instance.compile_item_instance_dependencies end
    instance.compile_item_instance_dependencies = function(item, items_dictionary, out_result, optional_mission_template)

        if item and item.__master_item and item.__master_item.weapon_template then
            instance.processing_item = item
        end

        return instance._compile_item_instance_dependencies(item, items_dictionary, out_result, optional_mission_template)
    end

end)

-- ##### ┬  ┬┬┌─┐┬ ┬┌─┐┬    ┬  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ####################################################
-- ##### └┐┌┘│└─┐│ │├─┤│    │  │ │├─┤ │││ ││ │ │   ├─┘├─┤ │ │  ├─┤ ####################################################
 -- ##### └┘ ┴└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘┴ ┴─┴┘└─┘└─┘ ┴   ┴  ┴ ┴ ┴ └─┘┴ ┴ ####################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    if not instance._spawn_item_attachments then instance._spawn_item_attachments = instance.spawn_item_attachments end
    instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        local attachments = item_data.attachments
        if item_unit and attachments and item_data.__master_item and item_data.__master_item.weapon_template then
            local gear_id, original_gear_id = mod:get_gear_id(item_data)
            original_gear_id = original_gear_id or gear_id
            if original_gear_id then

                -- Add flashlight slot
                if item_data.__gear.slots[1] == "slot_secondary" then
                    if not mod._recursive_find_attachment(attachments, "flashlight") then
                        attachments.flashlight = {
                            children = {},
                            item = "",
                        }
                    end
                end

                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get_gear_setting(original_gear_id, attachment_slot)
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    if attachment and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type

                        mod._recursive_set_attachment(attachments, attachment_type, model)
                    end
                end
            end
        end

        local attachment_units, attachment_units_bind_poses = instance._spawn_item_attachments(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        if attachment_units and item_data then
            local no_attach = {}
            for _, unit in pairs(attachment_units) do
                local unit_name = Unit.debug_name(unit)
                if mod.attachment_units[unit_name] then

                    World.unlink_unit(attach_settings.world, unit)
                    World.link_unit(attach_settings.world, unit, 1, item_unit, 1)

                    local attachment = mod.attachment_units[unit_name]
                    if attachment and item_data.__master_item and item_data.__master_item.weapon_template then
                        local template = item_data.__master_item.weapon_template
                        if mod.anchors[template] and mod.anchors[template][attachment] then
                            local anchor = mod.anchors[template][attachment]

                            local position = Vector3Box.unbox(anchor.position)
                            local rotation_euler = Vector3Box.unbox(anchor.rotation)
                            local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
                            local scale = Vector3Box.unbox(anchor.scale)

                            Unit.set_local_position(unit, 1, position)
		                    Unit.set_local_rotation(unit, 1, rotation)
                            Unit.set_local_scale(unit, 1, scale)
                        end
                    end
                end
            end
        end

        return attachment_units, attachment_units_bind_poses
    end

    if not instance._generate_attachment_overrides_lookup then instance._generate_attachment_overrides_lookup = instance.generate_attachment_overrides_lookup end
    instance.generate_attachment_overrides_lookup = function(item_data, override_item_data)
        if override_item_data then
            local attachments = override_item_data.attachments
            local gear_id, original_gear_id = mod:get_gear_id(item_data)
            original_gear_id = original_gear_id or gear_id
            if original_gear_id then
                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get_gear_setting(original_gear_id, attachment_slot)
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    if attachment and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type

                        mod._recursive_set_attachment(attachments, attachment_type, model)
                    end
                end
            end
        end

        return instance._generate_attachment_overrides_lookup(item_data, override_item_data)
    end

end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬┌─┐ ##########################################################################
-- ##### │ │ ├┤ │││  ├─┘├┬┘├┤ └┐┌┘│├┤ │││└─┐ ##########################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘└─┘ ##########################################################################

mod:hook(CLASS.ViewElementWeaponStats, "present_item", function(func, self, item, is_equipped, on_present_callback, ...)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, is_equipped, on_present_callback, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponActions, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponInfo, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponPatterns, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponActionsExtended, "present_item", function(func, self, item, ...)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
end)

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐┌─┐ ##############################################################
-- ##### │││├┤ ├─┤├─┘│ ││││   │ ├┤ │││├─┘│  ├─┤ │ ├┤ └─┐ ##############################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘   ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘└─┘ ##############################################################

mod.weapon_templates = {}
mod.special_types = {
	"special_bullet",
	"melee",
}

mod.template_add_torch = function(self, orig_weapon_template)
	if orig_weapon_template then
		local weapon_template = orig_weapon_template
		if not self.weapon_templates[orig_weapon_template.name] then
			self.weapon_templates[orig_weapon_template.name] = table.clone(orig_weapon_template)
			weapon_template = self.weapon_templates[orig_weapon_template.name]
			if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
				weapon_template.displayed_weapon_stats_table.damage[3] = nil
			end
			if weapon_template.displayed_attacks and weapon_template.displayed_attacks.special then
				if table.contains(self.special_types, weapon_template.displayed_attacks.special.type) then
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

-- ##### ┬┌┐┌┌─┐┬ ┬┌┬┐ ################################################################################################
-- ##### ││││├─┘│ │ │  ################################################################################################
-- ##### ┴┘└┘┴  └─┘ ┴  ################################################################################################

mod:hook(CLASS.InputService, "get", function(func, self, action_name, ...)
	local pressed = func(self, action_name, ...)
    if mod.initialized then
        if action_name == "weapon_extra_pressed" and mod:has_flashlight_attachment() then
            if pressed then
                -- mod:init_context()
                mod:toggle_flashlight()
            end
            return self:get_default(action_name)
        end
	end
	return pressed
end)