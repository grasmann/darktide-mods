local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	-- local MasterItems = mod:original_require("scripts/backend/master_items")
	local WeaponCustomizationLocalization = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_localization")
	local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
--#endregion

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
	local string_trim = string._trim
	local Application = Application
	local unit_get_data = Unit.get_data
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

--#region Data
	local REFERENCE = "weapon_customization"
	local SKIP = "++"
	local WEAPON_SKIN = "WEAPON_SKIN"
	local LANGUAGE_ID = Application.user_setting("language_id")
	local MK = mod:localize("mod_attachment_mk")
	local KASR = mod:localize("mod_attachment_kasr")
	local additions = {
		MK.."I",
		MK.."II",
		MK.."III",
		MK.."IV",
		MK.."V",
		MK.."VI",
		MK.."VII",
		MK.."VIII"
	}
	local skip_weapon_name_generation = {
		"trinket_hook",
		"flashlight",
		"emblem_left",
		"emblem_right",
		"no_stock",
		"no_sight",
		"scope_01",
		"scope_02",
		"scope_03",
	}
	local company_name = mod:localize("mod_attachment_names_company")
	local attachment_remove_string = mod:localize("mod_attachment_remove")
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.play_attachment_sound = function(self, item, attachment_slot, attachment_name, type)
	local cosmetics_view = self.cosmetics_view
	if cosmetics_view then --and cosmetics_view.weapon_unit and unit_alive(cosmetics_view.weapon_unit) then
		local item_name = cosmetics_view._item_name
		-- if attachment_name == "default" then attachment_name = self:get_actual_default_attachment(item, attachment_slot) end
		if attachment_name == "default" then attachment_name = mod.gear_settings:default_attachment(item, attachment_slot) end
		local sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, type)
		if sounds then
			-- local unit = self:get_attachment_slot_unit(attachment_slot)
			local slot_info_id = cosmetics_view._slot_info_id
			local slot_infos = slot_info_id and mod:persistent_table(REFERENCE).attachment_slot_infos
			local gear_info = slot_infos and slot_infos[slot_info_id]
			local player_unit = self.player_unit and unit_alive(self.player_unit) and self.player_unit
			local unit = player_unit or gear_info and gear_info.attachment_slot_to_unit[attachment_slot]
			-- local unit = player_unit and self:get_attachment_unit(cosmetics_view.weapon_unit, attachment_slot)
			if unit and unit_alive(unit) then
				local ui_manager = managers.ui
				for _, sound in pairs(sounds) do
					ui_manager:play_unit_sound(sound, unit, 1)
				end
			end
		else
			local mod_attachment = self.attachment
			if mod_attachment[item_name] and mod_attachment[item_name][attachment_slot] then
				for _, data in pairs(mod_attachment[item_name][attachment_slot]) do
					if data.id == attachment_name and data.sounds then
						for _, sound in pairs(data.sounds) do
							cosmetics_view:_play_sound(sound)
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
	local gear_settings = mod.gear_settings

	if WeaponCustomizationLocalization.mod_attachment_remove[LANGUAGE_ID] then
		self.found_names = self.found_names or {}
		local name = nil
		if attachment_slot ~= "trinket_hook" and attachment_slot ~= "emblem_left" and attachment_slot ~= "emblem_right" and attachment_slot ~= "flashlight" and attachment_name ~= "no_stock" and attachment_name ~= "no_sight" and attachment_name ~= "scope_01" and attachment_name ~= "scope_02" and attachment_name ~= "scope_03" then
		-- if not table_contains(skip_weapon_name_generation, attachment_slot) and not not table_contains(skip_weapon_name_generation, attachment_name) then
			self:setup_item_definitions()
			local item_name = self.gear_settings:short_name(item.name)
			local attachment_data = self.attachment_models[item_name][attachment_name]
			if attachment_data and attachment_data.model ~= "" and attachment_data.original_mod then
				local item_definitions = self:persistent_table(REFERENCE).item_definitions

				

				-- Search only weapons
				for _, entry in pairs(item_definitions) do
					
					if entry.attachments and entry.item_type ~= WEAPON_SKIN and entry.display_name ~= "" and entry.display_name ~= "n/a" then
						local attachment_models = gear_settings:_recursive_get_attachment_models(entry.attachments)
						-- local data = self.gear_settings:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
						-- if data then
						if table_contains(attachment_models, attachment_data.model) then
							name = Localize(entry.display_name)
							if mod:cached_find(name, "unlocalized") then
								name = nil
							else
								if mod:cached_find(entry.display_name, "_desc") and entry.description then
									name = Localize(entry.description)
								end
							end
							if name and mod:cached_find(name, SKIP) then
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
							local attachment_models = gear_settings:_recursive_get_attachment_models(entry.attachments)
							-- local data = self.gear_settings:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
							-- if data then
							if table_contains(attachment_models, attachment_data.model) then
								name = Localize(entry.display_name)
								if mod:cached_find(name, "unlocalized") then
									name = nil
								else
									if mod:cached_find(entry.display_name, "_desc") and entry.description then
										name = Localize(entry.description)
									end
								end
								if name and mod:cached_find(name, SKIP) then
									name = nil
								elseif name then
									break
								end
							end
						end
					end
				end
			end
			-- local company_name = mod:localize("mod_attachment_names_company")
			if not name and not mod:cached_find(attachment_name, "default") and attachment_data.original_mod then
				name = company_name
			end
			if name then
				-- local attachment_remove_string = mod:localize("mod_attachment_remove")
				local replace = self:cached_split(attachment_remove_string, "|")
				if replace and #replace > 0 then
					for _, rep in pairs(replace) do
						name = mod:cached_gsub(name, rep, "")
					end
				end
				name = mod:cached_trim(name)
				name = mod:cached_cap(name)
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