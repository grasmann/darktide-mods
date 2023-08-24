local mod = get_mod("weapon_customization")

local MasterItems = mod:original_require("scripts/backend/master_items")
local ExtensionManager = mod:original_require("scripts/foundation/managers/extension/extension_manager")
local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
local VOSourcesCache = mod:original_require("scripts/extension_systems/dialogue/vo_sources_cache")
local NetworkEventDelegate = mod:original_require("scripts/managers/multiplayer/network_event_delegate")

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
                val = attachment_data
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
    if item and attachments then
        local gear_id = mod:get_gear_id(item)
        if gear_id then

            -- Add flashlight slot
            local slot = item.__gear and item.__gear.slots and item.__gear.slots[1]
            if slot == "slot_secondary" then
                local special = mod:get_gear_setting(gear_id, "flashlight")
                local flashlight = table.contains(mod.flashlights, special)
                if flashlight then
                    if not mod._recursive_find_attachment(attachments, "flashlight") then
                        attachments.flashlight = {
                            children = {},
                            item = "",
                        }
                    end
                end
            end

            for _, attachment_slot in pairs(mod.attachment_slots) do
                local attachment = mod:get_gear_setting(gear_id, attachment_slot)
                local item_name = mod:item_name_from_content_string(item.name)
                if attachment and mod.attachment_models[item_name][attachment] then
                    local model = mod.attachment_models[item_name][attachment].model
                    local attachment_type = mod.attachment_models[item_name][attachment].type
                    mod._recursive_set_attachment(attachments, attachment_type, model)
                else
                    local MasterItemsCached = MasterItems.get_cached()
                    local master_item = MasterItemsCached[item.name]
                    local attachment = mod._recursive_find_attachment(master_item.attachments, attachment_slot)
                    if attachment then
                        mod._recursive_set_attachment(attachments, attachment_slot, attachment.item)
                    end
                end
            end
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
                local slot = instance.processing_item.__gear and instance.processing_item.__gear.slots and instance.processing_item.__gear.slots[1]
                if slot == "slot_secondary" then
                    local special = mod:get_gear_setting(gear_id, "flashlight")
                    local flashlight = table.contains(mod.flashlights, special)
                    if flashlight then
                        if not mod._recursive_find_attachment(attachments, "flashlight") then
                            attachments.flashlight = {
                                children = {},
                                item = "",
                            }
                        end
                    end
                end

                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get_gear_setting(gear_id, attachment_slot)
                    local item_name = mod:item_name_from_content_string(instance.processing_item.name)
                    if attachment and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type
                        mod._recursive_set_attachment(attachments, attachment_type, model)
                    else
                        local MasterItemsCached = MasterItems.get_cached()
                        local master_item = MasterItemsCached[instance.processing_item.name]
                        local attachment = mod._recursive_find_attachment(master_item.attachments, attachment_slot)
                        if attachment then
                            mod._recursive_set_attachment(attachments, attachment_slot, attachment.item)
                        end
                    end
                end
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
                local slot = item_data.__gear and item_data.__gear.slots and item_data.__gear.slots[1]
                if slot == "slot_secondary" then
                    local special = mod:get_gear_setting(gear_id, "flashlight")
                    local flashlight = table.contains(mod.flashlights, special)
                    if flashlight then
                        if not mod._recursive_find_attachment(attachments, "flashlight") then
                            attachments.flashlight = {
                                children = {},
                                item = "",
                            }
                        end
                    end
                end

                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get_gear_setting(gear_id, attachment_slot)
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    if attachment and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type
                        mod._recursive_set_attachment(attachments, attachment_type, model)
                    else
                        local MasterItemsCached = MasterItems.get_cached()
                        local master_item = MasterItemsCached[item_data.name]
                        local attachment = mod._recursive_find_attachment(master_item.attachments, attachment_slot)
                        if attachment then
                            mod._recursive_set_attachment(attachments, attachment_slot, attachment.item)
                        end
                    end
                end
            end
        end

        -- mod:dabug_attachments(item_data, attachments, "ogryn_heavystubber_p1_m2")

        local attachment_units, attachment_units_bind_poses = instance._spawn_item_attachments(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        if attachment_units and item_data then
            local no_attach = {}
            for _, unit in pairs(attachment_units) do
                local unit_name = Unit.debug_name(unit)
                if mod.attachment_units[unit_name] then

                    World.unlink_unit(attach_settings.world, unit)
                    World.link_unit(attach_settings.world, unit, 1, item_unit, 1)

                    -- if CLASSES["OutlineSystem"] then
                    --     if not mod.extension_manager then
                    --         local world = attach_settings.world
                    --         local physics_world = World.physics_world(world)
                    --         local wwise_world = Managers.world:wwise_world(world)
                    --         local level_name = ScriptWorld.name(world) --self._level_name
                    --         local is_server = nil
                    --         local unit_templates = require("scripts/extension_systems/unit_templates")
                    --         local circumstance_name = "default"
                    --         local use_time_slice = false
                    --         local system_config = {
                    --             {
                    --                 "component_system",
                    --                 "ComponentSystem",
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 true,
                    --                 false,
                    --                 {
                    --                     "ComponentExtension"
                    --                 }
                    --             },
                    --             {
                    --                 "dialogue_system",
                    --                 "DialogueSystem",
                    --                 false,
                    --                 false,
                    --                 true,
                    --                 true,
                    --                 false
                    --             },
                    --             {
                    --                 "dialogue_context_system",
                    --                 "DialogueContextSystem",
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 true,
                    --                 false
                    --             },
                    --             {
                    --                 "cutscene_character_system",
                    --                 "CutsceneCharacterSystem",
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 {
                    --                     "CutsceneCharacterExtension"
                    --                 }
                    --             },
                    --             {
                    --                 "cinematic_scene_system",
                    --                 "CinematicSceneSystem",
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 true,
                    --                 false,
                    --                 {
                    --                     "CinematicSceneExtension"
                    --                 }
                    --             },
                    --             {
                    --                 "light_controller_system",
                    --                 "LightControllerSystem",
                    --                 false,
                    --                 false,
                    --                 false,
                    --                 true,
                    --                 false,
                    --                 {
                    --                     "LightControllerExtension"
                    --                 }
                    --             }
                    --         }
                    --         local vo_sources_cache = VOSourcesCache:new()
                    --         local system_init_data = {
                    --             dialogue_context_system = {},
                    --             dialogue_system = {
                    --                 is_rule_db_enabled = false,
                    --                 vo_sources_cache = vo_sources_cache
                    --             },
                    --             cinematic_scene_system = {
                    --                 mission = {}
                    --             },
                    --             light_controller_system = {
                    --                 mission = {}
                    --             }
                    --         }
                    --         local unit_categories = {
                    --             "flow_spawned",
                    --             "level_spawned",
                    --             "cinematic"
                    --         }
                    --         mod.extension_manager = ExtensionManager:new(world, physics_world, wwise_world, nil, nil, level_name, circumstance_name, is_server, unit_templates, system_config, system_init_data, unit_categories, nil, nil, nil, {}, use_time_slice)
                    --         mod.event_delegate = NetworkEventDelegate:new()
                    --         mod.extension_system_creation_context = {
                    --             is_server = is_server,
                    --             world = world,
                    --             wwise_world = wwise_world,
                    --             physics_world = physics_world,
                    --             extension_manager = mod.extension_manager,
                    --             has_navmesh = false,
                    --             network_event_delegate = mod.event_delegate,
                    --         }
                    --     end
                    --     local extension = ScriptUnit.add_extension(mod.extension_system_creation_context, unit, "OutlineSystem", "test_outline", {})
                    --     local ext = extension:on_add_extension(attach_settings.world, unit, "PropOutlineExtension", {})
                    --     extension:add_outline(unit, "special_target")
                    --     extension:_show_outline(unit, ext)
                    -- end

                    -- local has_outline_system = Managers.state.extension:has_system("outline_system")
                    -- if has_outline_system then
                    --     local outline_system = Managers.state.extension:system("outline_system")
                    --     outline_system:add_outline(unit, "special_target")
                    -- end

                    local attachment = mod.attachment_units[unit_name]
                    if attachment then
                        local item_name = mod:item_name_from_content_string(item_data.name)
                        if mod.anchors[item_name] and mod.anchors[item_name][attachment] then
                            local anchor = mod.anchors[item_name][attachment]

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

    if not instance._generate_attachment_overrides_lookup then
        instance._generate_attachment_overrides_lookup = instance.generate_attachment_overrides_lookup
    end
    instance.generate_attachment_overrides_lookup = function(item_data, override_item_data)
        if override_item_data then
            local attachments = override_item_data.attachments
            local gear_id = mod:get_gear_id(item_data)
            if gear_id then

                -- Add flashlight slot
                local slot = item_data.__gear and item_data.__gear.slots and item_data.__gear.slots[1]
                if slot == "slot_secondary" then
                    local special = mod:get_gear_setting(gear_id, "flashlight")
                    local flashlight = table.contains(mod.flashlights, special)
                    if flashlight then
                        if not mod._recursive_find_attachment(attachments, "flashlight") then
                            attachments.flashlight = {
                                children = {},
                                item = "",
                            }
                        end
                    end
                end

                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    local attachment = mod:get_gear_setting(gear_id, attachment_slot)
                    if attachment and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type
                        mod._recursive_set_attachment(attachments, attachment_type, model)
                    else
                        local MasterItemsCached = MasterItems.get_cached()
                        local master_item = MasterItemsCached[item_data.name]
                        local attachment = mod._recursive_find_attachment(master_item.attachments, attachment_slot)
                        if attachment then
                            mod._recursive_set_attachment(attachments, attachment_slot, attachment.item)
                        end
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