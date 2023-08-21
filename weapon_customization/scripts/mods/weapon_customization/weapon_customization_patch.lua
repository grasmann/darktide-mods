local mod = get_mod("weapon_customization")

local UISettings = mod:original_require("scripts/settings/ui/ui_settings")
local PlayerUnitVisualLoadout = mod:original_require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
local ItemMaterialOverrides = mod:original_require("scripts/settings/equipment/item_material_overrides/item_material_overrides")
local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")

-- mod.weapon_icons = {}

-- mod:hook(CLASS.WeaponIconUI, "load_weapon_icon", function(func, self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
--     reference_id = func(self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
--     local gear_id = item.gear_id or item.name
--     -- mod.weapon_icons[reference_id] = mod.weapon_icons[reference_id] or {}
--     -- mod.weapon_icons[gear_id][#mod.weapon_icons[gear_id]+1] = reference_id
--     mod.weapon_icons[reference_id] = gear_id
--     return reference_id
-- end)

-- mod:hook(CLASS.WeaponIconUI, "unload_weapon_icon", function(func, self, reference_id, ...)
--     mod.weapon_icons[reference_id] = nil
--     func(self, reference_id, ...)
-- end)

mod.get_gear_id = function(self, item, original)
    return not original and item.__gear_id or item.__original_gear_id or item.gear_id, item.__original_gear_id or item.gear_id
end

-- mod.reload_weapon_icons = function(self)
--     if Managers.ui._back_buffer_render_handlers then
--         -- local item = InventoryWeaponCosmeticsView._previewed_element.real_item
--         Managers.ui._back_buffer_render_handlers.weapons:update_all()
--         -- Managers.ui:view_instance("inventory_weapon_details_view")._weapon_actions_extended._weapon_icon_renderer:update_all()
        
--     end
--     -- local inventory_weapons_view = Managers.ui:view_instance("inventory_weapons_view")
--     -- if inventory_weapons_view and inventory_weapons_view._weapon_actions then
--     --     inventory_weapons_view._weapon_actions._weapon_icon_renderer:update_all()
--     -- end
-- end

-- mod.delete_weapon_icons = function(self, delete_gear_id)
--     if Managers.ui._back_buffer_render_handlers then
--         for reference_id, gear_id in pairs(mod.weapon_icons) do
--             if gear_id == delete_gear_id then
--                 -- local item = InventoryWeaponCosmeticsView._previewed_element.real_item
--                 mod:echo("delete:"..tostring(reference_id))
--                 Managers.ui._back_buffer_render_handlers.weapons:unload_weapon_icon(reference_id)
--             end
--         end
--     end
-- end

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
    -- Delete previous weapons attachments
    if self._weapon_spawn_data then
        local gear_id, original_gear_id = mod:get_gear_id(self._weapon_spawn_data.item)
        mod:destroy_attachments(gear_id, "VisualLoadoutCustomization")
        -- mod:destroy_attachments(gear_id, "InventoryBackgroundView")
        -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    end
    -- Original function
    func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
end)

mod:hook(CLASS.UIWeaponSpawner, "_despawn_weapon", function(func, self, ...)
    -- Delete attachments
	if self._weapon_spawn_data then
        local gear_id, original_gear_id = mod:get_gear_id(self._weapon_spawn_data.item)
        mod:destroy_attachments(gear_id, "VisualLoadoutCustomization")
        -- mod:destroy_attachments(gear_id, "InventoryBackgroundView")
        -- mod:hide_attachments(original_gear_id, "InventoryBackgroundView", false)
    end
    -- Original function
	return func(self, ...)
end)

-- mod:hook(CLASS.UIWeaponSpawner, "destroy", function(func, self, ...)
--     func(self, ...)
--     -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
-- end)

-- mod:hook(CLASS.UIWeaponSpawner, "cb_on_item_package_loaded", function(func, self, slot_id, item, on_spawn_cb, ...)
--     -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
--     func(self, slot_id, item, on_spawn_cb, ...)
--     -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
-- end)

mod:hook(CLASS.InventoryBackgroundView, "update", function(func, self, dt, t, input_service, ...)
    func(self, dt, t, input_service, ...)
    -- local active = Managers.ui:view_active("inventory_weapons_view") or Managers.ui:is_view_closing("inventory_weapons_view")
    -- if not active then
    --     mod:hide_attachments(nil, true)
    --     local slot_id = self._preview_wield_slot_id
    --     local preview_profile_equipped_items = self._preview_profile_equipped_items
    --     local presentation_inventory = preview_profile_equipped_items
    --     local item = presentation_inventory[slot_id]
    --     local gear_id = item.__is_preview_item and item.__original_gear_id or item.__gear_id
    --     mod:hide_attachments(gear_id, false)
    --     mod:hide_parts()
    -- end
    if mod.weapon_changed then
        -- self:_update_presentation_wield_item()
        -- local profile = self._preview_player:profile()
        self:_spawn_profile(self._presentation_profile)
        mod.weapon_changed = nil
    end
end)

-- mod.debug_ = function(self)
--     -- local gui = Debug:debug_gui()
--     local level_world = Managers.world:world("level_world")
--     local screen_width = RESOLUTION_LOOKUP.width
--     if not self.gui then
--         self.gui = World.create_screen_gui(level_world, "immediate")
--     end
--     local x = 100
--     local y = 100
--     local layer = 9999
--     for gear_id, gear_attachment in pairs(mod.weapon_attachments) do
--         for reference, reference_attachment in pairs(gear_attachment) do
--             for index, attachment in pairs(reference_attachment) do
--                 -- if Unit.alive(attachment.attachment_unit) then
--                 --     Unit.set_unit_visibility(attachment.attachment_unit, not hide)
--                 --     local t = hide and "hide" or "show"
--                 --     -- mod:echo(t..":"..reference)
--                 --     -- for i = 1, Unit.num_meshes(attachment.attachment_unit), 1 do
--                 --     -- 	Unit.set_mesh_visibility(attachment.attachment_unit, i, not hide)
--                 --     -- end
--                 -- end
--                 if attachment and Unit.alive(attachment.attachment_unit) then
--                     ScriptGui.text(self.gui, tostring(gear_id), DevParameters.debug_text_font, 20, Vector3(x, y, layer), Color.white(), Color.black())
--                     ScriptGui.text(self.gui, reference, DevParameters.debug_text_font, 20, Vector3(x + 400, y, layer), Color.white(), Color.black())
--                     ScriptGui.text(self.gui, attachment.attachment_name, DevParameters.debug_text_font, 20, Vector3(x + 800, y, layer), Color.white(), Color.black())
--                 else

--                 end
--                 y = y + 30
--             end
--         end
--     end
--     -- ScriptGui.text(self.gui, tostring(screen_width), DevParameters.debug_text_font, 20, Vector3(x, y, 100), Color.white(), Color.black())
-- end
-- local level_world = Managers.world:world("level_world")
-- World.destroy_gui(level_world, mod.gui)

-- mod:hook(CLASS.WorldManager, "destroy_world", function(func, self, world_or_name, ...)
--     if mod.gui then
--         local world = world_or_name
--         if type(world) == "string" then
--             world = self._worlds[world] or self._disabled_worlds[world]
--         end
--         World.destroy_gui(world, mod.gui)
--     end
--     func(self, world_or_name, ...)
-- end)

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
    if self._loaded_packages then
        local mission = self._mission
        local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, mission)

        for package_name, _ in pairs(dependencies) do
            if self._loaded_packages[package_name] then
                local loaded_packages = self._loaded_packages[package_name]
                if not table.contains(mod.packages, package_name) then
                    local load_id = table.remove(loaded_packages, #loaded_packages)

                    Managers.package:release(load_id)
                end
                if table.is_empty(loaded_packages) then
                    self._loaded_packages[package_name] = nil
                end
            end
        end
    end
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
	for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]

			self:_unload_item_packages(item)
		end
	end

	-- if next(self._loaded_packages) then
	-- 	table.dump(self._loaded_packages)
	-- 	ferror("MispredictPackageHandler loaded packages and has not correctly unloaded them")
	-- end

	self._pending_unloads = nil
	self._loaded_packages = nil
end)

mod.test = false
local test_list = {"ogryn_club_p2_m2", "ogryn_club_p2_m3"}
mod:hook_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization", function(instance)
	if not instance._spawn_item then instance._spawn_item = instance.spawn_item end
	instance.spawn_item = function(item_data, attach_settings, parent_unit, optional_extract_attachment_units_bind_poses, optional_mission_template, ...)
        -- mod:hide_attachments(nil, nil, true)
        -- local gear_id = mod:get_gear_id(item_data) --item_data.__is_preview_item and item_data.__original_gear_id or item_data.__gear_id
        local level_world = Managers.world:world("level_world")
        local world_name = Managers.world:world_name(attach_settings.world)
        -- local reference = "VisualLoadoutCustomization"
        
        -- mod:destroy_attachments(gear_id, world, "VisualLoadoutCustomization")
        -- mod:destroy_attachments(gear_id, world, "Player")

		local item_unit, attachment_units, bind_pose, attachment_units_bind_poses = instance._spawn_item(item_data, attach_settings, parent_unit, optional_extract_attachment_units_bind_poses, optional_mission_template, ...)
        
		if mod:attachments_possible(item_data) then
            
            -- mod:echo("#############################")
            local local_player_unit = Managers.player:local_player(1).player_unit
            local first_person_unit = nil
            -- local reference = "VisualLoadoutCustomization"--..tostring(attach_settings.is_first_person)..tostring(attach_settings.skip_link_children)..tostring(attach_settings.spawn_with_extensions)--..tostring(parent_unit)
            local first_person_extension = ScriptUnit.extension(local_player_unit, "first_person_system")
			if first_person_extension then
                first_person_unit = first_person_extension:first_person_unit()
            end
            if first_person_unit and parent_unit == first_person_unit then
                -- mod:echo("1p:"..tostring(attach_settings.is_first_person).." skip:"..tostring(attach_settings.skip_link_children).." p:"..tostring(parent_unit).." e:"..tostring(attach_settings.spawn_with_extensions))
                -- reference = "Player"
                mod:load_weapon_customization(item_data, item_unit, true, attach_settings.world, "Player", false)
                -- mod:echo("Player")
            elseif world_name == "ui_inventory" then
                -- mod:echo("omg")
                mod:load_weapon_customization(item_data, item_unit, true, attach_settings.world, "InventoryBackgroundView", false)
                -- mod:echo("InventoryBackgroundView")
            else
                -- if not mod.test then
                --     mod:dtf(instance, "instance", 2)
                --     mod.test = true
                -- end
                -- mod:echo(reference)
                mod:load_weapon_customization(item_data, item_unit, true, attach_settings.world, "VisualLoadoutCustomization", true)
                -- mod:echo("VisualLoadoutCustomization")
                -- mod:echo(tostring(instance))
                -- mod:echo(item_data.__gear_id)
            end
            -- mod:echo("world: "..Managers.world:world_name(attach_settings.world))
            -- mod:echo("skip_link_children:"..tostring(attach_settings.skip_link_children))
            -- mod:echo("parent:"..tostring(parent_unit))
            -- mod:echo("spawn_with_extensions:"..tostring(attach_settings.spawn_with_extensions))

            
            -- if attach_settings.is_first_person then reference = "Player" end

			-- mod:load_weapon_customization(item_data, item_unit, true, attach_settings.world, reference, true)
		end
        -- mod:hide_attachments(nil, false)
        -- mod:hide_parts()
		return item_unit, attachment_units, bind_pose, attachment_units_bind_poses
	end

    instance._recursive_set_attachment = function(attachments, attachment_type, model)
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
                attachment_data.item = model
            else
                if attachment_data.children then
                    instance._recursive_set_attachment(attachment_data.children, attachment_type, model)
                end
            end
        end
    end

    if not instance._spawn_item_attachments then instance._spawn_item_attachments = instance.spawn_item_attachments end
    instance.spawn_item_attachments = function(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)

        local attachments = item_data.attachments
        if item_unit and attachments then
            local gear_id, original_gear_id = mod:get_gear_id(item_data)
            original_gear_id = original_gear_id or gear_id
            if original_gear_id then
                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get(tostring(original_gear_id).."_"..attachment_slot)
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    if attachment and attachment ~= "default" and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type
                        -- if attachments[attachment_type] then
                        --     attachments[attachment_type].item = model
                        -- elseif attachments.receiver and attachments.receiver.children[attachment_type] then
                        --     attachments.receiver.children[attachment_type].item = model
                        -- elseif attachments.body and attachments.body.children[attachment_type] then
                        --     attachments.body.children[attachment_type].item = model
                        -- elseif attachments.grip and attachments.grip.children[attachment_type] then
                        --     attachments.grip.children[attachment_type].item = model
                        -- elseif attachments.body and attachments.body.children.barrel and attachments.body and attachments.body.children.barrel.children and attachments.body.children.barrel.children[attachment_type] then
                        --     attachments.body.children.barrel.children[attachment_type].item = model
                        -- else
                        --     mod:echo("NOT FOUND :"..attachment_type)
                        -- end

                        instance._recursive_set_attachment(attachments, attachment_type, model)

                        -- if model then
                        --     self:spawn_attachment(item, weapon_unit, model, attachment_type, third_person, world, reference, allow_several)
                        -- end
                    end
                end
            end
        end

        local attachments = item_data.attachments
        if item_unit and attachments and item_data.__master_item then
            -- mod:echo(item_data.__master_item.weapon_template)
            if item_data.__master_item and table.contains(test_list, item_data.__master_item.weapon_template) then
                -- if attachments.receiver then
                    -- if not mod.test then
                    --     mod:dtf(attachments, "attachments", 10)
                    --     test = true
                    -- end
                    -- attachments.receiver.children.barrel.item = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_03"
                    -- attachments.receiver.children.magazine.item = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_03"
                    -- attachments.receiver.children.grip.item = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_02"
                    -- attachments.receiver.item = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_01"
                -- end
            end
            -- local attachment_names = table.keys(attachments)
            -- for i = 1, #attachment_names do
            --     local name = attachment_names[i]
            --     if table.contains(mod.attachment_slots, name) then
            --         mod:echo(name)
            --         local data = attachments[name]
            --         -- mod:dtf(data, "data "..tostring(item_data.__gear_id).." "..name, 3)
                    
            --     end
            -- end
        end

        return instance._spawn_item_attachments(item_data, override_lookup, attach_settings, item_unit, optional_extract_attachment_units_bind_poses, optional_mission_template)
    end

    if not instance._generate_attachment_overrides_lookup then instance._generate_attachment_overrides_lookup = instance.generate_attachment_overrides_lookup end
    instance.generate_attachment_overrides_lookup = function(item_data, override_item_data)
        if override_item_data then
            local attachments = override_item_data.attachments
            local gear_id, original_gear_id = mod:get_gear_id(item_data)
            original_gear_id = original_gear_id or gear_id
            if original_gear_id then
                for _, attachment_slot in pairs(mod.attachment_slots) do
                    local attachment = mod:get(tostring(original_gear_id).."_"..attachment_slot)
                    local item_name = mod:item_name_from_content_string(item_data.name)
                    if attachment and attachment ~= "default" and mod.attachment_models[item_name][attachment] then
                        local model = mod.attachment_models[item_name][attachment].model
                        local attachment_type = mod.attachment_models[item_name][attachment].type
                        -- if attachments[attachment_type] then
                        --     attachments[attachment_type].item = model
                        -- elseif attachments.receiver.children[attachment_type] then
                        --     attachments.receiver.children[attachment_type].item = model
                        -- elseif attachments.body and attachments.body.children[attachment_type] then
                        --     attachments.body.children[attachment_type].item = model
                        -- elseif attachments.grip and attachments.grip.children[attachment_type] then
                        --     attachments.grip.children[attachment_type].item = model
                        -- elseif attachments.body and attachments.body.children.barrel and attachments.body and attachments.body.children.barrel.children and attachments.body.children.barrel.children[attachment_type] then
                        --     attachments.body.children.barrel.children[attachment_type].item = model
                        -- else
                        --     mod:echo("NOT FOUND :"..attachment_type)
                        -- end

                        instance._recursive_set_attachment(attachments, attachment_type, model)

                        -- if model then
                        --     self:spawn_attachment(item, weapon_unit, model, attachment_type, third_person, world, reference, allow_several)
                        -- end
                    end
                end
            end
        end

        return instance._generate_attachment_overrides_lookup(item_data, override_item_data)
    end

    if not instance._apply_material_overrides then instance._apply_material_overrides = instance.apply_material_overrides end
    instance.apply_material_overrides = function(item_data, item_unit, parent_unit, attach_settings)
        instance._apply_material_overrides(item_data, item_unit, parent_unit, attach_settings)
        if item_data.__master_item and table.contains(test_list, item_data.__master_item.weapon_template) then
            local material_overrides = item_data.material_overrides
            local apply_to_parent = item_data.material_override_apply_to_parent

            if item_unit and material_overrides and table.size(material_overrides) > 0 then
                mod:dtf(material_overrides, "material_overrides_"..item_data.__master_item.weapon_template, 5)
            end
        end
    end

    -- if not instance._apply_material_override then instance._apply_material_override = instance.apply_material_override end
    -- instance.apply_material_override = function(unit, parent_unit, apply_to_parent, material_override, in_editor)
    --     if material_override and material_override ~= "" then
    --         material_override_data = ItemMaterialOverrides[material_override]

    --         if material_override_data then
    --             -- if not mod.test and weap then
    --             mod:dtf(material_override_data, "material_override_data_"..material_override_data.name, 5)
    --             --     mod.test = true
    --             -- end
    --         end
    --     end
    --     instance._apply_material_override(unit, parent_unit, apply_to_parent, material_override, in_editor)
    -- end
end)

mod:hook_require("scripts/settings/equipment/item_material_overrides/item_material_overrides", function(instance)
    -- if not mod.test then
    --     mod:dtf(instance, "instance", 5)
    --     mod.test = true
    -- end
end)

-- mod:hook(CLASS.InventoryBackgroundView, "on_enter", function(func, self, ...)
--     -- mod:hide_attachments(nil, false)
--     func(self, ...)

--     -- mod:hide_attachments(nil, true)
--     local slot_id = self._preview_wield_slot_id
--     local preview_profile_equipped_items = self._preview_profile_equipped_items
--     local presentation_inventory = preview_profile_equipped_items
--     if presentation_inventory then
--         local item = presentation_inventory[slot_id]
--         local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
--         -- mod:hide_attachments(gear_id, "InventoryBackgroundView", false)
--         -- mod:hide_parts() 
--     end
--     -- self:_equip_local_changes()
-- end)

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
    func(self, ...)
    -- mod:echo("loooooool")
    mod:destroy_attachments(nil, "InventoryBackgroundView")
    mod:destroy_attachments(nil, "VisualLoadoutCustomization")
    -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    -- mod:hide_parts()
end)

mod:hook(CLASS.InventoryBackgroundView, "_equip_slot_item", function(func, self, slot_name, item, force_update, ...)
	local presentation_loadout = self._preview_profile_equipped_items
	local previous_item = presentation_loadout[slot_name]
    mod:destroy_attachments(previous_item.gear_id, "InventoryBackgroundView")
    -- mod:destroy_attachments(nil, nil, "InventoryBackgroundView")
    -- mod:echo(slot_name)
	func(self, slot_name, item, force_update, ...)
    -- local world = self._world_spawner:world()
    -- mod:destroy_attachments(previous_item.gear_id, nil, "VisualLoadoutCustomization")
    -- mod:destroy_attachments(previous_item.gear_id, world, "Player")
    -- mod:hide_parts()
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "update", function(func, self, unit, dt, t, ...)
    if not Managers.ui:has_active_view() then
        local inventory_component = self._inventory_component
        local wielded_slot = inventory_component.wielded_slot
        local item = self._weapons[wielded_slot].item
        local weapon_unit = self._weapons[wielded_slot].weapon_unit
        local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
        -- mod:hide_attachments(gear_id, false)
        -- mod:hide_parts()
        mod:destroy_attachments(nil, "VisualLoadoutCustomization")
    end
    -- mod:debug_()
    func(self, unit, dt, t, ...)
end)
mod:hook(CLASS.PlayerUnitWeaponExtension, "on_slot_wielded", function(func, self, slot_name, t, skip_wield_action, ...)
    local local_player_unit = Managers.player:local_player(1).player_unit
    if self._unit == local_player_unit then
        local inventory_component = self._inventory_component
        local wielded_slot = inventory_component.wielded_slot
        local item = self._weapons[wielded_slot].item
        local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
        mod:hide_attachments(gear_id, "Player", false)
        mod:destroy_attachments(nil, "InventoryBackgroundView")
        -- mod:destroy_attachments(nil, "VisualLoadoutCustomization")
    end
    func(self, slot_name, t, skip_wield_action, ...)
    if self._unit == local_player_unit then
        -- item = self._weapons[slot_name].item
        local inventory_component = self._inventory_component
        local wielded_slot = inventory_component.wielded_slot
        local item = self._weapons[wielded_slot].item
        local gear_id = mod:get_gear_id(item)--item.__is_preview_item and item.__original_gear_id or item.__gear_id
        -- mod:hide_attachments(gear_id, false)
        -- mod:hide_parts()
    end
end)

mod:hook(CLASS.ActionBase, "trigger_anim_event", function(func, self, anim_event, anim_event_3p, action_time_offset, ...)
    func(self, anim_event, anim_event_3p, action_time_offset, ...)
    mod:echo(anim_event)
    mod:echo(anim_event_3p)
end)

mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_unequipped", function(func, self, slot_name, from_server_correction_occurred, ...)
    -- local local_player_unit = Managers.player:local_player(1).player_unit
    -- if self._unit == local_player_unit then
    --     local item = self._weapons[slot_name].item
    --     local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
    --     -- mod:destroy_attachments(gear_id, "InventoryBackgroundView")
    --     -- mod:destroy_attachments(nil, "VisualLoadoutCustomization")
    --     -- mod:destroy_attachments(nil, "InventoryBackgroundView")
    --     mod:destroy_attachments(nil, "Player")
    -- end
    mod:destroy_attachments(nil, "Player")
	func(self, slot_name, from_server_correction_occurred, ...)
    -- if self._unit == local_player_unit then
    --     local item = self._weapons[slot_name].item
    --     local gear_id = item.__is_preview_item and item.__original_gear_id or item.__gear_id
    --     mod:destroy_attachments(gear_id, self._world, "VisualLoadoutCustomization")
    --     mod:destroy_attachments(gear_id, self._world, "InventoryBackgroundView")
    --     mod:destroy_attachments(gear_id, self._world, "Player")
    -- end
    -- mod:destroy_attachments(nil, "VisualLoadoutCustomization")
    -- mod:destroy_attachments(nil, "InventoryBackgroundView")
end)

-- mod:hook(CLASS.PlayerUnitWeaponExtension, "on_wieldable_slot_equipped", function(func, self, item, slot_name, weapon_unit, fx_sources, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
--     -- local local_player_unit = Managers.player:local_player(1).player_unit
--     -- if self._unit == local_player_unit then
--     --     local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
--     --     mod:destroy_attachments(nil, "VisualLoadoutCustomization")
--     --     mod:destroy_attachments(nil, "InventoryBackgroundView")
--     --     -- mod:hide_attachments(nil, true)
--     --     -- mod:redo_weapon_attachments(gear_id, self._world)
--     -- end
--     func(self, item, slot_name, weapon_unit, fx_sources, t, optional_existing_unit_3p, from_server_correction_occurred, ...)
--     -- if self._unit == local_player_unit then
--     --     local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
--     --     -- mod:hide_attachments(gear_id, false)
--     --     -- mod:hide_parts()
--     -- end
--     -- mod:destroy_attachments(nil, "VisualLoadoutCustomization")
--     -- mod:destroy_attachments(nil, "InventoryBackgroundView")
-- end)

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "destroy", function(func, self, ...)
	mod.visual_loadout_extension = nil
	mod.initialized = false
	return func(self, ...)
end)

mod:hook(CLASS.ViewElementWeaponStats, "present_item", function(func, self, item, is_equipped, on_present_callback, ...)
    -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- mod.previewed_weapon_flashlight = gear_id and mod:get(gear_id) == true
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, is_equipped, on_present_callback, ...)
	mod.previewed_weapon_flashlight = nil
end)

mod:hook(CLASS.ViewElementWeaponActions, "present_item", function(func, self, item, ...)
    -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- mod.previewed_weapon_flashlight = gear_id and mod:get(gear_id) == true
    -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
    -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
end)

mod:hook(CLASS.ViewElementWeaponInfo, "present_item", function(func, self, item, ...)
    -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- mod.previewed_weapon_flashlight = gear_id and mod:get(gear_id) == true
    -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
    -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
end)

mod:hook(CLASS.ViewElementWeaponPatterns, "present_item", function(func, self, item, ...)
    -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- mod.previewed_weapon_flashlight = gear_id and mod:get(gear_id) == true
    -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
    -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
end)

mod:hook(CLASS.ViewElementWeaponActionsExtended, "present_item", function(func, self, item, ...)
    -- local gear_id = mod:get_gear_id(item) --item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- mod.previewed_weapon_flashlight = gear_id and mod:get(gear_id) == true
    -- mod:hide_attachments(nil, "InventoryBackgroundView", true)
    mod.previewed_weapon_flashlight = mod:has_flashlight_attachment(item)
	func(self, item, ...)
	mod.previewed_weapon_flashlight = nil
    -- mod:hide_attachments(nil, "InventoryBackgroundView", false)
end)

-- mod:hook(CLASS.ActionBase, "trigger_anim_event", function(func, self, anim_event, anim_event_3p, action_time_offset, ...)
--     func(self, anim_event, anim_event_3p, action_time_offset, ...)
--     -- mod:echo("go")

--     -- local player_unit = Managers.player:local_player(1).player_unit

--     -- if self._player_unit == player_unit then
--     --     for _, gear_attachment in pairs(mod.weapon_attachments) do
-- 	-- 		for _, reference_attachment in pairs(gear_attachment) do
-- 	-- 			for index, attachment in pairs(reference_attachment) do
-- 	-- 				if Unit.alive(attachment.attachment_unit) and attachment.hide then

--     --                     local anim_ext = ScriptUnit.extension(attachment.attachment_unit, "animation_system")
--     --                     if anim_ext then
--     --                         local time_scale = self._weapon_action_component.time_scale
--     --                         -- local anim_ext = self._animation_extension
--     --                         action_time_offset = action_time_offset or 0

--     --                         anim_ext:anim_event_with_variable_floats_1p(anim_event, "attack_speed", time_scale, "action_time_offset", action_time_offset, ...)

--     --                         if anim_event_3p then
--     --                             anim_ext:anim_event_with_variable_floats(anim_event_3p, "attack_speed", time_scale, "action_time_offset", action_time_offset, ...)
--     --                         end
--     --                     else
--     --                         mod:echo("lol")
--     --                     end

-- 	-- 					-- for i = 1, Unit.num_meshes(attachment.attachment_unit), 1 do
-- 	-- 					-- 	Unit.set_mesh_visibility(attachment.attachment_unit, i, not hide)
-- 	-- 					-- end
--     --                 else
--     --                     mod:echo("omg")
-- 	-- 				end
-- 	-- 			end
-- 	-- 		end
-- 	-- 	end
--     -- else
--     --     mod:echo("rofl")
--     -- end
-- end)    





InventoryWeaponsView.cb_on_switch_torch_pressed = function(self, widget)
	-- local item = self._previewed_item
    -- local gear_id = item.__is_preview_item and item.__original_gear_id or item.__gear_id
	-- if item then
	-- 	local state = gear_id and mod:get(gear_id) == true
	-- 	mod:set(gear_id, not state)
	-- 	self:_play_sound(UISoundEvents.apparel_equip_frame)
	-- 	local world = self._world_spawner:world()
	-- 	mod:redo_weapon_attachments(gear_id, world)
	-- 	self:_stop_previewing()
	-- 	self:_preview_item(item)
	-- end
end

mod:hook_require("scripts/ui/views/inventory_weapons_view/inventory_weapons_view_definitions", function(instance)
	local found = false
	for index, input in pairs(instance.legend_inputs) do
		if input.display_name == "loc_weapon_inventory_switch_torch_button" then
			found = true
		end
	end
	if not found then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			input_action = "hotkey_item_discard_pressed",
			display_name = "loc_weapon_inventory_switch_torch_button",
			alignment = "right_alignment",
			on_pressed_callback = "cb_on_switch_torch_pressed",
			visibility_function = function (parent)
				local is_previewing_item = parent:is_previewing_item()
				if is_previewing_item then
					local previewed_item = parent:previewed_item()
					if previewed_item then
						local item_type = previewed_item.item_type
						local ITEM_TYPES = UISettings.ITEM_TYPES
						if item_type == ITEM_TYPES.WEAPON_RANGED then
							local weapon_template = mod:weapon_template_from_item(previewed_item)
							if weapon_template.displayed_attacks and weapon_template.displayed_attacks.special then
								if table.contains(mod.special_types, weapon_template.displayed_attacks.special.type) then
									return true
								end
							end
						end
					end
				end
				return false
			end
		}
	end
end)





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

mod.weapon_template_from_item = function (self, weapon_item)
	if not weapon_item then return nil end
	local weapon_template_name = weapon_item.weapon_template
	local weapon_progression_template_name = weapon_item.weapon_progression_template
	if weapon_progression_template_name then
		return WeaponTemplate._weapon_template(weapon_progression_template_name)
	end
	return WeaponTemplate._weapon_template(weapon_template_name)
end

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)
	if not instance._weapon_template then instance._weapon_template = instance.weapon_template end
	instance.weapon_template = function(template_name)
		local weapon_template = instance._weapon_template(template_name)
		return mod:template_add_torch(weapon_template)
	end
end)





mod:hook(CLASS.InputService, "get", function(func, self, action_name, ...)
	local pressed = func(self, action_name, ...)
	if Managers and Managers.player._game_state ~= nil then
		mod:init_context()
		if mod.initialized then
			local item = mod.visual_loadout_extension:item_from_slot(mod.inventory_component.wielded_slot)
			if item then
				local flashlight_attachments = mod:get_flashlight_attachments(item)
                if action_name == "weapon_extra_pressed" and flashlight_attachments then
                    if pressed then
                        mod:init_context()
                        mod:toggle_flashlight()
                    end
                    return self:get_default(action_name)
                end
			end
		end
	end
	return pressed
end)