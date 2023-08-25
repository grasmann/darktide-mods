local mod = get_mod("weapon_customization")

local MasterItems = mod:original_require("scripts/backend/master_items")

mod.add_custom_attachments = {
    flashlight = "flashlights",
    stock = "stocks",
    stock_2 = "stocks",
}

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

mod._recursive_set_attachment = function(self, attachments, attachment_type, model)
    for attachment_name, attachment_data in pairs(attachments) do
        if attachment_name == attachment_type then
            attachment_data.item = model
        else
            if attachment_data.children then
                self:_recursive_set_attachment(attachment_data.children, attachment_type, model)
            end
        end
    end
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

local attachment_data_test = false
mod._recursive_find_attachment_item_name = function(self, attachments, item_name)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            local this_item_name = nil
            if type(attachment_data.item) == "string" then
                this_item_name = self:item_name_from_content_string(attachment_data.item)
            elseif type(attachment_data.item) == "table" and attachment_data.item.__master_item then
                this_item_name = attachment_data.item.__master_item
            elseif mod._debug and type(attachment_data.item) == "table" and not attachment_data_test then
                mod:dtf(attachment_data.item, "attachment_data.item", 5)
                mod:echo("attachment_data_test")
                attachment_data_test = true
            end
            if this_item_name == item_name then
                val = attachment_data
            else
                if attachment_data.children then
                    val = self:_recursive_find_attachment_item_name(attachment_data.children, item_name)
                end
            end
            if val then break end
        end
    end
    return val
end

mod._add_custom_attachments = function(self, gear_id, attachments)
    for attachment_slot, attachment_table in pairs(self.add_custom_attachments) do
        local special = self:get_gear_setting(gear_id, attachment_slot)
        local attachment = table.contains(self[attachment_table], special)
        if attachment then
            if not self:_recursive_find_attachment(attachments, attachment_slot) then
                attachments[attachment_slot] = {
                    children = {},
                    item = "",
                }
            end
        end
    end
end

mod._recursive_attachment_slot_from_index = function(self, attachments, search_index, found_index)
    local val = nil
    found_index = found_index or 1
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if found_index == search_index then
                val = {
                    name = attachment_name,
                    data = attachment_data,
                }
            else
                if attachment_data.children then
                    val = mod:_recursive_attachment_slot_from_index(attachment_data.children, search_index, found_index)
                end
            end
            if val then break end
            found_index = found_index + 1
        end
    end
    return val
end

mod._overwrite_attachments = function(self, item_data, attachments)
    local gear_id = mod:get_gear_id(item_data)
    local item_name = mod:item_name_from_content_string(item_data.name)
    for _, attachment_slot in pairs(mod.attachment_slots) do
        local attachment = mod:get_gear_setting(gear_id, attachment_slot)
        
        -- Customize
        if attachment and mod.attachment_models[item_name][attachment] then
            local model = mod.attachment_models[item_name][attachment].model
            local attachment_type = mod.attachment_models[item_name][attachment].type
            mod:_recursive_set_attachment(attachments, attachment_type, model)
        else
            -- Default overwrite
            if mod.default_overwrite[item_name] and mod.default_overwrite[item_name][attachment_slot] then
                mod:_recursive_set_attachment(attachments, attachment_slot, mod.default_overwrite[item_name][attachment_slot])
            else
                -- Default
                local MasterItemsCached = MasterItems.get_cached()
                local master_item = MasterItemsCached[item_data.name]
                local attachment = mod:_recursive_find_attachment(master_item.attachments, attachment_slot)
                if attachment then
                    mod:_recursive_set_attachment(attachments, attachment_slot, attachment.item)
                end
            end
        end
    end
end

mod:hook(CLASS.UIWeaponSpawner, "start_presentation", function(func, self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

    local attachments = item.__master_item and item.__master_item.attachments
    if item and attachments then
        local gear_id = mod:get_gear_id(item)
        if gear_id then

            -- Add flashlight slot
            mod:_add_custom_attachments(gear_id, attachments)
            
            -- Overwrite attachments
            mod:_overwrite_attachments(item, attachments)
        end
    end

    func(self, item, position, rotation, scale, on_spawn_cb, force_highest_mip, ...)

end)

mod:hook_require("scripts/foundation/managers/package/utilities/item_package", function(instance)

    if not instance.__resolve_item_packages_recursive then instance.__resolve_item_packages_recursive = instance._resolve_item_packages_recursive end
    instance._resolve_item_packages_recursive = function(attachments, items_dictionary, result)
        if instance.processing_item then
            local gear_id = mod:get_gear_id(instance.processing_item)
            if gear_id then

                -- Add flashlight slot
                mod:_add_custom_attachments(gear_id, attachments)
                
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

-- ##### ┬  ┬┬┌─┐┬ ┬┌─┐┬    ┬  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ####################################################
-- ##### └┐┌┘│└─┐│ │├─┤│    │  │ │├─┤ │││ ││ │ │   ├─┘├─┤ │ │  ├─┤ ####################################################
-- #####  └┘ ┴└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘┴ ┴─┴┘└─┘└─┘ ┴   ┴  ┴ ┴ ┴ └─┘┴ ┴ ####################################################

mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)

    if not instance._spawn_item_attachments then instance._spawn_item_attachments = instance.spawn_item_attachments end
    instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        local attachments = item_data.attachments
        if item_unit and attachments then --and item_data.__master_item and item_data.__master_item.weapon_template then
            local gear_id = mod:get_gear_id(item_data)
            if gear_id then
                
                -- Add flashlight slot
                mod:_add_custom_attachments(gear_id, attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item_data, attachments)
            end
        end

        if mod._debug then
            mod:dabug_attachments(item_data, attachments, {"lasgun_p1_m1", "lasgun_p1_m2", "lasgun_p1_m3"})
        end

        local attachment_units, attachment_units_bind_poses = instance._spawn_item_attachments(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        local attachment_index = 1
        if attachment_units and item_data then
            for _, unit in pairs(attachment_units) do
                local unit_name = Unit.debug_name(unit)
                local item_name = mod:item_name_from_content_string(item_data.name)
                local anchor = nil

                if mod.attachment_units[unit_name] then
                    local attachment = mod.attachment_units[unit_name]
                    if attachment then
                        if mod.anchors[item_name] and mod.anchors[item_name][attachment] then
                            anchor = mod.anchors[item_name][attachment]
                        end

                    end
                end

                -- Fixes
                if not anchor and mod.anchors[item_name] and mod.anchors[item_name]["fixes"] then
                    local fixes = mod.anchors[item_name]["fixes"]
                    if fixes[tostring(attachment_index)] then
                    -- if attachment_index == mod.test_index then
                    --     local fix_entry = fixes["8"]
                        local fix_entries = fixes[tostring(attachment_index)]
                        for dependency, fix_entry in pairs(fix_entries) do
                            if mod.attachment_models[item_name] and mod.attachment_models[item_name][dependency] then
                                local model_string = mod.attachment_models[item_name][dependency].model
                                if model_string then
                                    -- local has_dependency = mod:_recursive_find_attachment_item_name(attachments, dependency)
                                    local has_dependency = mod:_recursive_find_attachment_item_string(attachments, model_string)
                                    if has_dependency then
                                        -- Iterate fixes
                                        for attachment_name, fix in pairs(fix_entry) do
                                            -- Check fix dependency
                                            if mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name] then
                                                -- Get item string for fix dependency
                                                local model_string_2 = mod.attachment_models[item_name][attachment_name].model
                                                if model_string_2 then
                                                    -- Search for dependency value
                                                    local other_attachment = mod:_recursive_find_attachment_item_string(attachments, model_string_2)
                                                    if other_attachment then
                                                        -- Set anchor to fix
                                                        anchor = fix
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                    end
                end

                if anchor then
                    World.unlink_unit(attach_settings.world, unit)
                    World.link_unit(attach_settings.world, unit, 1, item_unit, 1)

                    local position = Vector3Box.unbox(anchor.position)
                    local rotation_euler = Vector3Box.unbox(anchor.rotation)
                    local rotation = Quaternion.from_euler_angles_xyz(rotation_euler[1], rotation_euler[2], rotation_euler[3])
                    local scale = Vector3Box.unbox(anchor.scale)

                    Unit.set_local_position(unit, 1, position)
                    Unit.set_local_rotation(unit, 1, rotation)
                    Unit.set_local_scale(unit, 1, scale)
                end

                attachment_index = attachment_index + 1
            end
        end

        if mod._debug then
            local new_unit_names = {}
            local gear_id = mod:get_gear_id(item_data)
            if gear_id and attachment_units then
                if mod.last_attachment_units[gear_id] then
                    local last_units = mod.last_attachment_units[gear_id]
                    local new_units = mod.new_units[gear_id]
                    local debug_units = mod.debug_selected_unit

                    for _, unit in pairs(attachment_units) do
                        local unit_name = Unit.debug_name(unit)
                        if not table.contains(last_units, unit_name) then
                            new_unit_names[#new_unit_names+1] = unit_name
                            new_units[#new_units+1] = unit
                            last_units[#last_units+1] = unit_name
                        end
                    end

                    if #new_unit_names > 0 then
                        for _, unit_name in pairs(new_unit_names) do
                            -- mod:echo(unit_name)
                        end
                    end

                    if #new_unit_names == 1 then
                        debug_units[#debug_units+1] = new_units[#new_units]
                        if not mod.attachment_units[new_unit_names[1]] then
                            -- mod:dtf(new_unit_names, "new_unit", 3)
                        end
                    end

                else

                    local last_units = {}
                    for _, unit in pairs(attachment_units) do
                        local unit_name = Unit.debug_name(unit)
                        last_units[#last_units+1] = unit_name
                    end
                    mod.debug_item_name = mod:item_name_from_content_string(item_data.name)
                    mod.last_attachment_units[gear_id] = last_units
                    mod.new_units[gear_id] = {}
                    mod.debug_selected_unit = {}

                end
            end
        end

        return attachment_units, attachment_units_bind_poses
    end

    if not instance._generate_attachment_overrides_lookup then
        instance._generate_attachment_overrides_lookup = instance.generate_attachment_overrides_lookup
    end
    instance.generate_attachment_overrides_lookup = function(item_data, override_item_data)
        if override_item_data then
            local attachments = override_item_data.attachments
            local gear_id = mod:get_gear_id(item_data)
            if gear_id then

                -- Add flashlight slot
                mod:_add_custom_attachments(gear_id, attachments)
                
                -- Overwrite attachments
                mod:_overwrite_attachments(item_data, attachments)
            end
        end

        return instance._generate_attachment_overrides_lookup(item_data, override_item_data)
    end

end)

-- ##### ┬┌┬┐┌─┐┌┬┐  ┌─┐┬─┐┌─┐┬  ┬┬┌─┐┬ ┬┌─┐ ##########################################################################
-- ##### │ │ ├┤ │││  ├─┘├┬┘├┤ └┐┌┘│├┤ │││└─┐ ##########################################################################
-- ##### ┴ ┴ └─┘┴ ┴  ┴  ┴└─└─┘ └┘ ┴└─┘└┴┘└─┘ ##########################################################################

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


mod:hook_require("scripts/settings/equipment/flashlight_templates", function(instance)
    for name, template in pairs(instance) do
        template.light.first_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
        template.light.third_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
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
                mod:toggle_flashlight()
            end
            return self:get_default(action_name)
        end
	end
	return pressed
end)