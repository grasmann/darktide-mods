local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")
local WeaponCustomizationLocalization = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_localization")
local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Unit = Unit
	local math = math
	local type = type
	local pairs = pairs
	local table = table
	local vector3 = Vector3
	local string = string
	local localize = Localize
	local Localize = Localize
	local managers = Managers
	local math_abs = math.abs
	local callback = callback
	local tostring = tostring
	local unit_alive = Unit.alive
	local table_clone = table.clone
	local string_cap = string.cap
	local table_insert = table.insert
	local string_gsub = string.gsub
	local string_find = string.find
	local string_trim = string.trim
	local Application = Application
	local unit_get_data = Unit.get_data
	local string_split = string.split
	local table_contains = table.contains
	local unit_has_node = Unit.has_node
	local unit_debug_name = Unit.debug_name
	local unit_num_meshes = Unit.num_meshes
	local unit_get_child_units = Unit.get_child_units
	local unit_set_local_scale = Unit.set_local_scale
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local SKIP = "++"
local WEAPON_SKIN = "WEAPON_SKIN"
local LOCALIZATION_NOT_FOUND = "<mod_attachment_remove>"
local LANGUAGE_ID = Application.user_setting("language_id")
local MK = mod:localize("mod_attachment_mk")
local KASR = mod:localize("mod_attachment_kasr")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Get vanilla default attachment of specified item and slot
mod.get_actual_default_attachment = function(self, item, attachment_slot)
	-- Check item
	if item then
		-- Setup master items backup
		self:setup_item_definitions()
		-- Get original item
		local original_item = self:persistent_table(REFERENCE).item_definitions[item.name]
		local item_name = self:item_name_from_content_string(original_item.name)
		-- Check item
		if original_item and original_item.attachments then
			-- Find attachment
			local attachment = self:_recursive_find_attachment(original_item.attachments, attachment_slot)
			if attachment then
				if attachment.attachment_name then return attachment.attachment_name end
				-- Check attachment data
				if item_name and self.attachment_models[item_name] and self.default_attachment_models[item_name] then
					-- Iterate attachments
					local filter = {"laser_pointer"}
					local default = nil
					for _, attachment_name in pairs(mod.default_attachment_models[item_name]) do
						if not table_contains(filter, attachment_name) then
							local attachment_data = self.attachment_models[item_name][attachment_name]

							if not string_find(attachment_name, "default") and attachment_data
									and attachment_data.model == attachment.item and attachment_data.model ~= "" then
								default = attachment_name
								break
							elseif string_find(attachment_name, "default") and attachment_data 
									and attachment_data.model == attachment.item and attachment_data.model ~= "" then
								default = attachment_name
							end
						end
					end
					return default
				end
			end
		end
	end
end

mod.get_item_attachment_slots = function(self, item)
	local item_name = self:item_name_from_content_string(item.name)
	local attachment_slots = {}
    if item_name and self.attachment[item_name] then
        for attachment_slot, _ in pairs(self.attachment[item_name]) do
            attachment_slots[#attachment_slots+1] = attachment_slot
        end
    end
	return attachment_slots
end

mod.find_node_in_attachments = function(self, parent_unit, node_name, attachments)
    local num_attachments = #attachments
    -- Search node in attachments
	for ii = 1, num_attachments do
		local unit = attachments[ii]
		if unit_has_node(unit, node_name) then
            return true
		end
	end
    -- -- Search node in parent unit
	-- if unit_has_node(parent_unit, node_name) then
    --     return true
	-- end
end

mod.find_node_in_unit = function(self, unit, node_name)
	-- Search node in parent unit
	if unit_has_node(unit, node_name) then
		return true
	end
end

mod.load_attachment_packages = function(self, item, attachment_slot)
	self:setup_item_definitions()

	local attachments = self.attachment[self.cosmetics_view._item_name]
	local slot_attachments = attachments and attachments[attachment_slot] or {}
	local possible_attachments = {}
	for index, attachment_data in pairs(slot_attachments) do
		local model_data = self.attachment_models[self.cosmetics_view._item_name][attachment_data.id]
		local attachment_item = model_data and self:persistent_table(REFERENCE).item_definitions[model_data.model]
		if attachment_item and not string_find(attachment_data.id, "default") then
			local priority = false
			if index == self.attachment_preview_index then
				priority = true
			else
				local diff = index - self.attachment_preview_index
				if math_abs(diff) <= 2 then priority = true end
			end
			local target_index = #possible_attachments + 1
			if priority then target_index = 1 end
			table_insert(possible_attachments, target_index, {
				item = attachment_item,
				name = attachment_data.id,
				base_unit = attachment_item.base_unit,
				index = index,
			})
		end
	end
	
	self.attachment_preview_count = #possible_attachments

	for _, attachment_data in pairs(possible_attachments) do
		if attachment_data.item.resource_dependencies then
			for package_name, _ in pairs(attachment_data.item.resource_dependencies) do
				local package_key = attachment_slot.."_"..attachment_data.name
				local callback = callback(mod, "attachment_package_loaded", attachment_data.index, attachment_slot, attachment_data.name, attachment_data.base_unit)
				if not self:persistent_table(REFERENCE).loaded_packages.customization[package_key] then
					self:persistent_table(REFERENCE).used_packages.customization[package_key] = true
					self:persistent_table(REFERENCE).loaded_packages.customization[package_key] = managers.package:load(package_name, REFERENCE, callback)
				end
			end
		end

	end
end

mod.resolve_special_changes = function(self, item, attachment)
	local item_name = self:item_name_from_content_string(item.name)
	local gear_id = self:get_gear_id(item)
	local attachment_data = self.attachment_models[item_name][attachment]
	if attachment_data and attachment_data.special_resolve then
		local special_changes = attachment_data.special_resolve(gear_id, item, attachment)
		if special_changes then
			for special_slot, special_attachment in pairs(special_changes) do

				if self.cosmetics_view then
					if not self.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
						if not self:get_gear_setting(gear_id, special_slot) then
							self.original_weapon_settings[special_slot] = "default"
						else
							self.original_weapon_settings[special_slot] = self:get_gear_setting(gear_id, special_slot)
						end
					end
				end

				if string_find(special_attachment, "|") then
					local possibilities = string_split(special_attachment, "|")
					local rnd = math.random(#possibilities)
					special_attachment = possibilities[rnd]
				end

				self:set_gear_setting(gear_id, special_slot, special_attachment)
			end
		end
	end
end

mod.resolve_no_support = function(self, item)
	-- Enable all dropdowns
	for _, attachment_slot in pairs(self.attachment_slots) do
		local widget = self.cosmetics_view._widgets_by_name[attachment_slot.."_custom"]
		if widget then
			widget.content.entry.disabled = false
			if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local options_by_id = widget.content.options_by_id
				for option_index, option in pairs(widget.content.options) do
					option.disabled = false
				end
			end
		end
	end
	-- Disable no supported
	for _, attachment_slot in pairs(self.attachment_slots) do
		-- local item = self.cosmetics_view._selected_item
		local attachment = item and self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item)
		if attachment and self.attachment_models[self.cosmetics_view._item_name] and self.attachment_models[self.cosmetics_view._item_name][attachment] then
			local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment]
			local no_support = attachment_data.no_support
            attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
			no_support = attachment_data.no_support or no_support
			if no_support then
				for _, no_support_entry in pairs(no_support) do
					local widget = self.cosmetics_view._widgets_by_name[no_support_entry.."_custom"]
					if widget then
						widget.content.entry.disabled = true
					else
						for _, widget in pairs(self.cosmetics_view._custom_widgets) do
							if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
								local options = widget.content.options
								for option_index, option in pairs(widget.content.options) do
									if option.id == no_support_entry then
										option.disabled = true
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

mod.resolve_auto_equips = function(self, item)
	local item_name = self:item_name_from_content_string(item.name)
	local gear_id = self:get_gear_id(item)
	for _, attachment_slot in pairs(self.attachment_slots) do
		local attachment = item and self:get_gear_setting(gear_id, attachment_slot, item)
		if attachment then
			if self.attachment_models[item_name] and self.attachment_models[item_name][attachment] then
				local attachment_data = self.attachment_models[item_name][attachment]
				if attachment_data then
					local automatic_equip = attachment_data.automatic_equip
					local fixes = self:_apply_anchor_fixes(item, attachment_slot)
					automatic_equip = fixes and fixes.automatic_equip or automatic_equip
					if automatic_equip then
						for auto_type, auto_attachment in pairs(automatic_equip) do
							local parameters = string_split(auto_attachment, "|")
							if #parameters == 2 then
								local negative = string_find(parameters[1], "!")
								parameters[1] = string_gsub(parameters[1], "!", "")
								local attachment_name = self:get_gear_setting(gear_id, auto_type, item)
								if attachment_name then
									if negative and attachment_name ~= parameters[1] then
										self:set_gear_setting(gear_id, auto_type, parameters[2])
									elseif attachment_name == parameters[1] then
										self:set_gear_setting(gear_id, auto_type, parameters[2])
									end
								else mod:print("Attachment data for slot "..tostring(auto_type).." is nil") end
							else
								self:set_gear_setting(gear_id, auto_type, parameters[1])
							end
						end
					else mod:print("Automatic equip for "..tostring(attachment).." in slot "..tostring(attachment_slot).." is nil", true) end
				else mod:print("Attachment data for "..tostring(attachment).." in slot "..tostring(attachment_slot).." is nil") end
			else mod:print("Models for "..tostring(attachment).." in slot "..tostring(attachment_slot).." not found") end
		end
	end
end

mod.load_attachment_sounds = function(self, item)
	local attachments = self:get_item_attachment_slots(item)
	for _, attachment_slot in pairs(attachments) do
		local attachment_name = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item)
		local detach_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "detach", true)
		if detach_sounds then
			for _, detach_sound in pairs(detach_sounds) do
				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] then
					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[detach_sound] = true
					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] = managers.package:load(detach_sound, REFERENCE)
				end
			end
		end
		local attach_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "attach", true)
		if attach_sounds then
			for _, attach_sound in pairs(attach_sounds) do
				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] then
					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[attach_sound] = true
					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] = managers.package:load(attach_sound, REFERENCE)
				end
			end
		end
		local select_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "select", true)
		if select_sounds then
			for _, select_sound in pairs(select_sounds) do
				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] then
					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[select_sound] = true
					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] = managers.package:load(select_sound, REFERENCE)
				end
			end
		end
	end
end

mod.release_attachment_sounds = function(self)
	local unloaded_packages = {}
	for sound, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds) do
		unloaded_packages[#unloaded_packages+1] = sound
		self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[sound] = nil
		managers.package:release(package_id)
	end
	for _, package in pairs(unloaded_packages) do
		self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[package] = nil
	end
end

mod.get_attachment_slot_in_attachments = function(self, attachments, attachment_slot)
	if attachments then
		for _, unit in pairs(attachments) do
			if unit and unit_alive(unit) and unit_get_data(unit, "attachment_slot") == attachment_slot then
				return unit
			end
		end
	end
end

mod.play_attachment_sound = function(self, item, attachment_slot, attachment_name, type)
	if self.cosmetics_view then --and self.cosmetics_view.weapon_unit and unit_alive(self.cosmetics_view.weapon_unit) then
		local item_name = self.cosmetics_view._item_name
		if attachment_name == "default" then attachment_name = self:get_actual_default_attachment(item, attachment_slot) end
		local sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, type)
		if sounds then
			-- local unit = self:get_attachment_slot_unit(attachment_slot)
			local slot_info_id = self.cosmetics_view._slot_info_id
			local slot_infos = slot_info_id and mod:persistent_table(REFERENCE).attachment_slot_infos
			local gear_info = slot_infos and slot_infos[slot_info_id]
			local player_unit = self.player_unit and unit_alive(self.player_unit) and self.player_unit
			local unit = player_unit or gear_info and gear_info.attachment_slot_to_unit[attachment_slot]
			-- local unit = player_unit and self:get_attachment_unit(self.cosmetics_view.weapon_unit, attachment_slot)
			if unit and unit_alive(unit) then
				for _, sound in pairs(sounds) do
					managers.ui:play_unit_sound(sound, unit, 1)
				end
			end
		else
			if self.attachment[item_name] and self.attachment[item_name][attachment_slot] then
				for _, data in pairs(self.attachment[item_name][attachment_slot]) do
					if data.id == attachment_name and data.sounds then
						for _, sound in pairs(data.sounds) do
							self.cosmetics_view:_play_sound(sound)
						end
					end
				end
			end
		end
	end
end

mod.get_equipment_sound_effect = function(self, item, attachment_slot, attachment_name, type, load)

	if self.attachment_sounds[self.cosmetics_view._item_name] then
		local attachment_sounds = self.attachment_sounds[self.cosmetics_view._item_name]
		local sounds = attachment_sounds[attachment_slot] and attachment_sounds[attachment_slot][type]
		if sounds then return sounds end
	end

	-- local sound = "wwise/events/weapon/play_bolter_reload_hand"
	-- return {sound}
	local load = load or false
	local item_name = self.cosmetics_view._item_name
	-- if item.item_type == "WEAPON_RANGED" then
		if attachment_slot == "magazine" or attachment_slot == "magazine2" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2, SoundEventAliases.sfx_inspect.events.ogryn_heavystubber_p1_m1} end
			if type == "detach" then return {SoundEventAliases.sfx_magazine_eject.events[item_name] or SoundEventAliases.sfx_magazine_eject.events.default} end
			return {SoundEventAliases.sfx_magazine_insert.events[item_name] or SoundEventAliases.sfx_magazine_insert.default}

		elseif attachment_slot == "receiver" or attachment_slot == "body" then
			if type == "select" then return {SoundEventAliases.sfx_weapon_up.events[item_name] or SoundEventAliases.sfx_weapon_up.default,
				SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
			return {SoundEventAliases.sfx_equip.events[item_name] or SoundEventAliases.sfx_equip.default}

		elseif attachment_slot == "bayonet" or attachment_slot == "blade" then
			if type == "select" then return {SoundEventAliases.sfx_equip.events.ogryn_combatblade_p1_m2} end
			if type == "detach" then return {SoundEventAliases.sfx_equip.events.combatsword_p2_m3, SoundEventAliases.sfx_reload_lever_pull.events[item_name] or SoundEventAliases.sfx_reload_lever_pull.default}
			else return {SoundEventAliases.sfx_equip.events.combatsword_p2_m3, SoundEventAliases.sfx_reload_lever_release.events[item_name] or SoundEventAliases.sfx_reload_lever_release.default} end

		elseif attachment_slot == "muzzle" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
			return {SoundEventAliases.sfx_inspect_special_01.events.ogryn_rippergun_p1_m1}

		elseif attachment_slot == "flashlight" or attachment_slot == "rail" or attachment_slot == "trinket_hook" or attachment_slot == "head" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
			return {SoundEventAliases.sfx_equip.events.autogun_p3_m3, "wwise/events/player/play_foley_gear_flashlight_on"}

		elseif attachment_slot == "grip" or attachment_slot == "handle" or attachment_slot == "underbarrel" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
			return {SoundEventAliases.sfx_grab_weapon.events.bolter_p1_m1}

		elseif attachment_slot == "sight" or attachment_slot == "sight_2" or attachment_slot == "emblem_right" or attachment_slot == "emblem_left" or attachment_slot == "pommel" then
			if load then
				if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
				if type == "detach" then return {SoundEventAliases.sfx_grab_weapon.events.lasgun_p3_m1, SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1}
				else return {SoundEventAliases.sfx_equip_02.events.lasgun_p2_m1, SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1} end
			end
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
			if table_contains(self.reflex_sights, attachment_name) then
				if type == "detach" then return {SoundEventAliases.sfx_grab_weapon.events.lasgun_p3_m1}
				else return {SoundEventAliases.sfx_equip_02.events.lasgun_p2_m1} end
			end
			return {SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1}
		elseif attachment_slot == "stock" or attachment_slot == "stock_2" or attachment_slot == "stock_3" or attachment_slot == "hilt" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
			return {SoundEventAliases.sfx_equip_02.events.bolter_p1_m1}

		elseif attachment_slot == "barrel" then
			if type == "select" then return {SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
			return {SoundEventAliases.sfx_equip_02.events.autogun_p1_m1}

		else
			if type == "detach" then
				return {SoundEventAliases.sfx_weapon_down.events[item_name] or SoundEventAliases.sfx_weapon_down.default}
			else
				return {SoundEventAliases.sfx_weapon_up.events[item_name] or SoundEventAliases.sfx_weapon_up.default}
			end
		end
	-- end
end

mod.get_attachment_weapon_name = function(self, item, attachment_slot, attachment_name)
	if mod:get("mod_option_misc_attachment_names") and WeaponCustomizationLocalization.mod_attachment_remove[LANGUAGE_ID] then
		self.found_names = self.found_names or {}
		local name = nil
		if attachment_slot ~= "trinket_hook" and attachment_slot ~= "emblem_left" and attachment_slot ~= "emblem_right" and attachment_slot ~= "flashlight" and attachment_name ~= "no_stock"
				and attachment_name ~= "no_sight" and attachment_name ~= "scope_01" and attachment_name ~= "scope_02" and attachment_name ~= "scope_03" then
			self:setup_item_definitions()
			local item_name = self:item_name_from_content_string(item.name)
			local attachment_data = self.attachment_models[item_name][attachment_name]
			if attachment_data and attachment_data.model ~= "" then
				local item_definitions = self:persistent_table(REFERENCE).item_definitions
				-- Search only weapons
				for _, entry in pairs(item_definitions) do
					if entry.attachments and entry.item_type ~= WEAPON_SKIN and entry.display_name ~= "" and entry.display_name ~= "n/a" then
						local data = self:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
						if data then
							name = Localize(entry.display_name)
							-- mod:warning(name)
							if string_find(name, "unlocalized") then
								name = nil
							else
								if string_find(entry.display_name, "_desc") and entry.description then
									name = Localize(entry.description)
								end
							end
							if name and string_find(name, SKIP) then
								name = nil
							elseif name then
								break
							end
						end
					end
				end
				if not name then
					-- Search only skins
					for _, entry in pairs(item_definitions) do
						if entry.attachments and entry.item_type == WEAPON_SKIN and entry.display_name ~= "" and entry.display_name ~= "n/a" then
							local data = self:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
							if data then
								name = Localize(entry.display_name)
								-- mod:warning(name)
								if string_find(name, "unlocalized") then
									name = nil
								else
									if string_find(entry.display_name, "_desc") and entry.description then
										name = Localize(entry.description)
									end
								end
								if name and string_find(name, SKIP) then
									name = nil
								elseif name then
									break
								end
							end
						end
					end
				end
			end
			local company_name = mod:localize("mod_attachment_names_company")
			if not name and not string_find(attachment_name, "default") then
				name = company_name
			end
			if name then
				local replace = string_split(mod:localize("mod_attachment_remove"), "|")
				if replace and #replace > 0 then
					for _, rep in pairs(replace) do
						name = string.gsub(name, rep, "")
					end
				end
				name = string_trim(name)
				name = string_cap(name)
				local additions = {MK.."I", MK.."II", MK.."III", MK.."IV", MK.."V", MK.."VI", MK.."VII", MK.."VIII"}
				local add_name = name
				if add_name == company_name or add_name == KASR then
					add_name = add_name.." "..additions[1]
				end
				local add_index = 1
				while table_contains(self.found_names, add_name) do
					add_name = name.." "..additions[add_index]
					add_index = add_index + 1
					if add_index > 7 then
						break
					end
				end
				name = add_name
				self.found_names[#self.found_names+1] = name
			end
		end
		return name
	end
end










mod.execute_hide_meshes = function(self, item, attachment_units)
	-- local gear_id = self:get_gear_id(item)
	-- local slot_info_id = self:get_slot_info_id(item)
	-- local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	local item_name = self:item_name_from_content_string(item.name)
	for _, unit in pairs(attachment_units) do
		-- if slot_infos[slot_info_id] then
			-- local attachment_name = slot_infos[slot_info_id].unit_to_attachment_name[unit]
			local attachment_name = unit_get_data(unit, "attachment_name")
			local attachment_data = attachment_name and mod.attachment_models[item_name] and mod.attachment_models[item_name][attachment_name]
			-- Hide meshes
			local hide_mesh = attachment_data and attachment_data.hide_mesh
			-- Get fixes
			local fixes = mod:_apply_anchor_fixes(item, unit)
			hide_mesh = fixes and fixes.hide_mesh or hide_mesh
			-- Check hide mesh
			if hide_mesh then
				-- Iterate hide mesh entries
				for _, hide_entry in pairs(hide_mesh) do
					-- Check more than one paramet                 er
					if #hide_entry > 1 then
						-- Get attachment name - parameter 1
						local attachment_slot = hide_entry[1]
						-- Get attachment unit
						-- local hide_unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
						-- local hide_unit = self:get_attachment_unit(item, attachment_slot)
						local hide_unit = self:get_attachment_slot_in_attachments(attachment_units, attachment_slot)
						-- Check unit
						if hide_unit and unit_alive(hide_unit) then
							-- Hide nodes
							for i = 2, #hide_entry do
								local mesh_index = hide_entry[i]
								if unit_num_meshes(hide_unit) >= mesh_index then
									unit_set_mesh_visibility(hide_unit, mesh_index, false)
								end
							end
						end
					end
				end
			end
		-- end
	end
end










mod._recursive_find_unit_by_slot = function(self, weapon_unit, attachment_slot, output, output2)
    local unit = nil
    local output = output or {}
    -- Get unit children
	local children = unit_get_child_units(weapon_unit)
	if children then
        -- Iterate children
		for _, child in pairs(children) do
            if output2 then
                output2[#output2+1] = unit_get_data(child, "attachment_slot")
            end
			if unit_get_data(child, "attachment_slot") == attachment_slot then
                output[#output+1] = child
			else
                self:_recursive_find_unit_by_slot(child, attachment_slot, output, output2)
			end
		end
	end
end

mod._recursive_find_unit = function(self, weapon_unit, unit_name, output, output2)
    local unit = nil
    local output = output or {}
    -- Get unit children
	local children = unit_get_child_units(weapon_unit)
	if children then
        -- Iterate children
		for _, child in pairs(children) do
            if output2 then
                output2[#output2+1] = unit_debug_name(child)
            end
			if unit_debug_name(child) == unit_name then
                output[#output+1] = child
			else
                self:_recursive_find_unit(child, unit_name, output, output2)
			end
		end
	end
end

mod._recursive_set_attachment = function(self, attachments, attachment_name, attachment_type, model, auto)
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
end

mod._recursive_remove_attachment = function(self, attachments, attachment_type)
    local val = nil
    if attachments then
        for attachment_name, attachment_data in pairs(attachments) do
            if attachment_name == attachment_type then
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

mod._recursive_find_attachment_name = function(self, attachments, attachment_name)
    local val = nil
    if attachments then
        for attachment_slot, attachment_data in pairs(attachments) do
            if attachment_data.attachment_name == attachment_name then
                val = attachment_data
            else
                if attachment_data.children then
                    val = self:_recursive_find_attachment_name(attachment_data.children, attachment_name)
                end
            end
            if val then break end
        end
    end
    return val
end

mod._overwrite_attachments = function(self, item_data, attachments)
    local gear_id = self:get_gear_id(item_data)
    local item_name = self:item_name_from_content_string(item_data.name)
    local automatic_equip_entries = {}
    for _, attachment_slot in pairs(self.attachment_slots) do
        -- Don't handle trinkets
        if self:not_trinket(attachment_slot) and self.attachment_models[item_name] then
            local attachment = self:get_gear_setting(gear_id, attachment_slot)
            
            -- Customize
            if attachment and self.attachment_models[item_name][attachment] then
                -- Get attachment data
                local attachment_data = self.attachment_models[item_name][attachment]
                -- Get attachment type
                local attachment_type = mod.attachment_models[item_name][attachment].type
                -- Set attachment
                self:_recursive_set_attachment(attachments, attachment, attachment_type, attachment_data.model)
                -- Auto equips
                local automatic_equip = attachment_data.automatic_equip
                -- Get fixes
                local fixes = self:_apply_anchor_fixes(item_data, attachment_slot)
                -- Auto equips
                automatic_equip = fixes and fixes.automatic_equip or automatic_equip
                -- Handle automatic equips
                if automatic_equip then
                    for auto_type, auto_attachment_string in pairs(automatic_equip) do
                        automatic_equip_entries[#automatic_equip_entries+1] = {
                            auto_attachment_string = auto_attachment_string,
                            type = auto_type,
                        }
                    end
                end
            else
                -- -- Default overwrite
                -- if self.default_overwrite[item_name] and self.default_overwrite[item_name][attachment_slot] then
                --     self:_recursive_set_attachment(attachments, attachment, attachment_slot, self.default_overwrite[item_name][attachment_slot])
                -- else
                -- Default
                -- Get original master items
                local MasterItemsCached = MasterItems.get_cached()
                -- Get master item
                local master_item = MasterItemsCached[item_data.name]
                -- if not mod.test then
                --     mod:dtf(master_item, "master_item", 5)
                --     mod.test = true
                -- end
                -- Get attachment data
                local attachment_data = self:_recursive_find_attachment(master_item.attachments, attachment_slot)
                -- Get attachment
                local item = item_data.__master_item or item_data
                local attachment = self:get_gear_setting(gear_id, attachment_slot, item_data)
                -- -- Get fixes
                -- attachment_data = self:_apply_anchor_fixes(item_data, attachment_slot) or attachment_data
                -- Set attachment
                if attachment_data then
                    -- mod:echot("set "..tostring(attachment_slot).." to "..tostring(attachment))
                    self:_recursive_set_attachment(attachments, attachment, attachment_slot, attachment_data.item)
                end
                -- end
            end
        else -- Handle trinket
            -- -- Get master item instance
            -- local master_instance = item_data.__gear and item_data.__gear.masterDataInstance
            -- -- Get master attachments
            -- local master_attachments = master_instance and master_instance.overrides and master_instance.overrides.attachments
            -- if master_attachments then
            --     -- Get attachment data
            --     local attachment_data = self:_recursive_find_attachment(master_attachments, attachment_slot)
            --     -- -- Get fixes
            --     -- attachment_data = self:_apply_anchor_fixes(item_data, attachment_slot) or attachment_data
            --     if attachment_data and attachment_data.item then
            --         local trinket_name = nil
            --         -- Trinket string or table
            --         if type(attachment_data.item) == "string" then
            --             trinket_name = self:item_name_from_content_string(attachment_data.item)
            --         else
            --             trinket_name = self:item_name_from_content_string(attachment_data.item.__master_item.name)
            --         end
            --         -- Set attachment
            --         self:_recursive_set_attachment(attachments, trinket_name, attachment_slot, attachment_data.item)
            --     end
            -- end
        end
    end
    
    -- Handle automatic equips
    for _, auto_attachment_entry in pairs(automatic_equip_entries) do
        -- local sets = string_split(auto_attachment_entry.auto_attachment_string, ",")
		-- for _, set in pairs(sets) do
        -- if not string_find(auto_attachment_entry.auto_attachment_string, ",") then
            local parameters = string_split(auto_attachment_entry.auto_attachment_string, "|")
            local auto_attachment = nil
            if #parameters == 2 then
                local negative = string_find(parameters[1], "!")
                parameters[1] = string_gsub(parameters[1], "!", "")
                local attachment_data = self:_recursive_find_attachment(attachments, auto_attachment_entry.type)
                if attachment_data then
                    if negative and attachment_data.attachment_name ~= parameters[1] then
                        auto_attachment = parameters[2]
                    elseif attachment_data.attachment_name == parameters[1] then
                        auto_attachment = parameters[2]
                    end
                end
            else
                auto_attachment = parameters[1]
            end
            if auto_attachment and self.attachment_models[item_name][auto_attachment] then
                -- Get model
                local auto_model = self.attachment_models[item_name][auto_attachment].model
                -- Set attachment
                self:_recursive_set_attachment(attachments, auto_attachment, auto_attachment_entry.type, auto_model, true)
            end
        -- end
    end

end








local attachment_setting_overwrite = {
	slot_trinket_1 = "slot_trinket_1",
	slot_trinket_2 = "slot_trinket_2",
	help_sight = "bolter_sight_01",
}

mod._add_custom_attachments = function(self, item, attachments)
	local gear_id = self:get_gear_id(item)
	if gear_id and attachments then
		-- Get item name
		local item_name = self:item_name_from_content_string(item.name)
		-- -- Save original attachments
		-- if item.__master_item and not item.__master_item.original_attachments then
		-- 	item.__master_item.original_attachments = table_clone(attachments)
		-- elseif not item.original_attachments then
		-- 	item.original_attachments = table_clone(attachments)
		-- end
		-- Iterate custom attachment slots
		for attachment_slot, attachment_table in pairs(self.add_custom_attachments) do
			-- Get weapon setting for attachment slot
			local attachment_setting = self:get_gear_setting(gear_id, attachment_slot, item)
			local attachment = self:_recursive_find_attachment(attachments, attachment_slot)
			-- Overwrite specific attachment settings
			if table_contains(attachment_setting_overwrite, attachment_slot) then
				attachment_setting = attachment_setting_overwrite[attachment_slot]
			end
			-- if attachment_slot == "slot_trinket_1" then attachment_setting = "slot_trinket_1" end
			-- if attachment_slot == "slot_trinket_2" then attachment_setting = "slot_trinket_2" end
			-- if attachment_slot == "help_sight" then attachment_setting = "bolter_sight_01" end
			-- if table_contains(self[attachment_table], attachment_setting) then
				-- Get attachment data
				local attachment_data = self.attachment_models[item_name] and self.attachment_models[item_name][attachment_setting]
				if attachment_data and attachment_data.parent then
					-- Set attachment parent
					local parent = attachments
					local has_original_parent, original_parent = self:_recursive_find_attachment_parent(attachments, attachment_slot)
					if has_original_parent and attachment_data.parent ~= original_parent then
						self:_recursive_remove_attachment(attachments, attachment_slot)
					end
					local parent_slot = self:_recursive_find_attachment(attachments, attachment_data.parent)
					parent = parent_slot and parent_slot.children or parent
					-- Children
					local original_children = {}
					if attachment and attachment.children then
						original_children = table_clone(attachment.children)
					end
					-- Value
					local original_value = nil
					if attachment and attachment.item and attachment.item ~= "" then
						original_value = attachment and attachment.item
					end
					-- Attach custom slot
					parent[attachment_slot] = {
						children = original_children,
						item = original_value or attachment_data.model,
						attachment_type = attachment_slot,
            			attachment_name = attachment_setting,
					}
				end
			-- end
		end
	end
end

mod._apply_anchor_fixes = function(self, item, unit_or_name)
	-- if item and self:is_composite_item(item.name) then
	-- 	if item.anchors[unit_or_name] then
	-- 		mod:echo(tostring(item.anchors[unit_or_name]))
	-- 		return item.anchors[unit_or_name]
	-- 	end
	-- end
	if item and item.attachments then
		local gear_id = self:get_gear_id(item)
		local slot_infos = self:persistent_table(REFERENCE).attachment_slot_infos
		local slot_info_id = self:get_slot_info_id(item)
		local item_name = self:item_name_from_content_string(item.name)

		-- -- Default
		-- if type(unit_or_name) == "string" and string_find(unit_or_name, "default") then
		-- 	mod:echo("default: "..tostring(unit_or_name))
		-- 	local attachment_data = self.attachment_models[item_name][unit_or_name]
		-- 	local attachment_slot = attachment_data and attachment_data.type
		-- 	unit_or_name = attachment_slot and self:get_gear_setting(gear_id, attachment_slot, item) or unit_or_name
		-- 	mod:echo("attachment: "..tostring(unit_or_name))
		-- end

		local attachments = item.attachments
		if gear_id then
			-- Fixes
			if self.anchors[item_name] and self.anchors[item_name].fixes then
				local fixes = self.anchors[item_name].fixes
				for _, fix_data in pairs(fixes) do
					-- Dependencies
					local has_dependencies = false
					local no_dependencies = false
					if fix_data.dependencies then
						for _, dependency_entry in pairs(fix_data.dependencies) do
							-- local sets = string_split(dependency_entry, ",")
							-- for _, set in pairs(sets) do
							-- if not string_find(dependency_entry, ",") then
								local dependency_possibilities = string_split(dependency_entry, "|")
								local has_dependency_possibility = false

								for _, dependency_possibility in pairs(dependency_possibilities) do
									local negative = string_find(dependency_possibility, "!")
									dependency_possibility = string_gsub(dependency_possibility, "!", "")
									if self.attachment_models[item_name] and self.attachment_models[item_name][dependency_possibility] then
										-- local model_string = self.attachment_models[item_name][dependency].model
										if negative then
											has_dependency_possibility = not self:_recursive_find_attachment_name(attachments, dependency_possibility)
										else
											has_dependency_possibility = self:_recursive_find_attachment_name(attachments, dependency_possibility)
										end
										if has_dependency_possibility then break end
									elseif table_contains(self.attachment_slots, dependency_possibility) then
										if negative then
											has_dependency_possibility = not self:_recursive_find_attachment(attachments, dependency_possibility)
										else
											has_dependency_possibility = self:_recursive_find_attachment(attachments, dependency_possibility)
										end
										if has_dependency_possibility then break end
									end
								end

								has_dependencies = has_dependency_possibility
								if not has_dependencies then break end
							-- end
						end
					else
						no_dependencies = true
					end
					if has_dependencies or no_dependencies then
						for fix_attachment, fix in pairs(fix_data) do
							-- Attachment
							if slot_infos and slot_infos[slot_info_id] then
								local attachment_slot_info = slot_infos[slot_info_id]
								if self.attachment_models[item_name] and self.attachment_models[item_name][fix_attachment] then
									-- local model_string = self.attachment_models[item_name][fix_attachment].model
									local has_fix_attachment = self:_recursive_find_attachment_name(attachments, fix_attachment)
									local fix_attachment_slot = self.attachment_models[item_name][fix_attachment].type
									if has_fix_attachment and fix_attachment_slot and unit_or_name == attachment_slot_info.attachment_slot_to_unit[fix_attachment_slot] then
										return fix
									end
								end
								-- Slot
								if unit_or_name == attachment_slot_info.attachment_slot_to_unit[fix_attachment] then
									return fix
								end
							end
							-- Scope offset etc
							if unit_or_name == fix_attachment then
								return fix
							end
						end
					end
				end
			end
		else self:print("slot_info is nil") end
	end
end









mod.hide_bullets = function(self, attachment_units)
    if attachment_units and #attachment_units > 0 then
        local hide_units = {"bullet_01", "bullet_02", "bullet_03", "bullet_04", "bullet_05",
            "casing_01", "casing_02", "casing_03", "casing_04", "casing_05",
            "speedloader"}
        -- Iterate attachments
        for _, unit in pairs(attachment_units) do
            -- Check hide unit
            if table.contains(hide_units, Unit.get_data(unit, "attachment_slot")) then
                -- Hide
                unit_set_unit_visibility(unit, false, false)
                unit_set_local_scale(unit, 1, vector3(0, 0, 0))
            end
        end
    end
end
