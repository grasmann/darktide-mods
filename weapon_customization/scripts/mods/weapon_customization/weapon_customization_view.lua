local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local inventory_weapon_cosmetics_view_definitions = mod:original_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions")
local DropdownPassTemplates = mod:original_require("scripts/ui/pass_templates/dropdown_pass_templates")
local ItemUtils = mod:original_require("scripts/utilities/items")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
local WwiseGameSyncSettings = mod:original_require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local WorldRenderUtils = mod:original_require("scripts/utilities/world_render")

local ViewElementWeaponInfoDefinitions = mod:original_require("scripts/ui/view_elements/view_element_weapon_info/view_element_weapon_info_definitions")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")

-- local ViewElementWeaponPresets = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/view_elements/view_element_weapon_presets")

local WeaponCustomizationLocalization = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_localization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local vector2 = Vector2
	local vector3 = Vector3
	local vector3_box = Vector3Box
	local vector3_unbox = vector3_box.unbox
	local vector3_zero = vector3.zero
	local vector3_lerp = vector3.lerp
	local Quaternion = Quaternion
	local quaternion_forward = Quaternion.forward
	local quaternion_matrix_4x4 = Quaternion.matrix4x4
	local quaternion_axis_angle = Quaternion.axis_angle
	local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
	local quaternion_box = QuaternionBox
	local quaternion_unbox = quaternion_box.unbox
	local quaternion_multiply = Quaternion.multiply
	local Matrix4x4 = Matrix4x4
	local matrix4x4_transform = Matrix4x4.transform
	local matrix4x4_translation = Matrix4x4.translation
	local Camera = Camera
    local camera_world_position = Camera.world_position
	local camera_world_to_screen = Camera.world_to_screen
	local camera_world_rotation = Camera.world_rotation
	local Unit = Unit
	local unit_get_data = Unit.get_data
	local unit_alive = Unit.alive
	local unit_set_local_position = Unit.set_local_position
	local unit_set_local_rotation = Unit.set_local_rotation
	local unit_set_local_scale = Unit.set_local_scale
	local unit_local_position = Unit.local_position
	local unit_local_rotation = Unit.local_rotation
	local unit_get_child_units = Unit.get_child_units
	local unit_num_meshes = Unit.num_meshes
	local unit_set_mesh_visibility = Unit.set_mesh_visibility
	local unit_set_unit_visibility = Unit.set_unit_visibility
	local unit_debug_name = Unit.debug_name
	local Mesh = Mesh
	local mesh_set_local_position = Mesh.set_local_position
	local mesh_set_local_rotation = Mesh.set_local_rotation
	local mesh_local_rotation = Mesh.local_rotation
	local unit_mesh = Unit.mesh
	local unit_world_pose = Unit.world_pose
	local unit_local_pose = Unit.local_pose
	local unit_set_local_pose = Unit.set_local_pose
	local unit_world_position = Unit.world_position
	local unit_world_rotation = Unit.world_rotation
	local Matrix4x4 = Matrix4x4
    local matrix4x4_multiply = Matrix4x4.multiply
	local level_units = Level.units
	local World = World
	local world_unlink_unit = World.unlink_unit
	local world_link_unit = World.link_unit
	local world_destroy_unit = World.destroy_unit
	local math = math
	local math_round_with_precision = math.round_with_precision
	local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
	local math_ease_out_elastic = math.ease_out_elastic
	local math_min = math.min
	local math_max = math.max
	local math_lerp = math.lerp
	local math_sin = math.sin
	local math_pi = math.pi
	local math_ceil = math.ceil
	local table = table
	local table_insert = table.insert
	local table_size = table.size
	local table_find = table.find
	local table_contains = table.contains
	local table_clone = table.clone
	local table_reverse = table.reverse
	local table_remove = table.remove
	local table_sort = table.sort
	local string = string
	local string_gsub = string.gsub
	local string_find = string.find
	local string_split = string.split
	local string_len = string.len
	local string_trim = string.trim
    local string_cap = string.cap
	local Fade = Fade
	local Color = Color
	local pairs = pairs
	local ipairs = ipairs
	local tostring = tostring
	local CLASS = CLASS
	local managers = Managers
	local utf8_upper = Utf8.upper
	local localize = Localize
	local callback = callback
	local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_extension = script_unit.extension
    local script_unit_remove_extension = script_unit.remove_extension
    local script_unit_add_extension = script_unit.add_extension
	local Localize = Localize
	local Application = Application
	-- local function string_trim(s)
	-- 	return (s:gsub("^%s*(.-)%s*$", "%1"))
	-- end
	-- local function string_cap(str)
	-- 	return (str:gsub("^%l", string.upper))
	-- end
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local grid_size = inventory_weapon_cosmetics_view_definitions.grid_settings.grid_size
local edge_padding = inventory_weapon_cosmetics_view_definitions.grid_settings.edge_padding
local grid_width = grid_size[1] + edge_padding
local tab_panel_width = grid_size[1] * .75
local button_width = tab_panel_width * 0.3
local edge = edge_padding * 0.5
local label_height = 30
local dropdown_height = 32
local DROPDOWN_BUTTON_MARGIN = 30
local REFERENCE = "weapon_customization"
local WEAPON_SKIN = "WEAPON_SKIN"
local SKIP = "++"
local LOCALIZATION_NOT_FOUND = "<mod_attachment_remove>"
local LANGUAGE_ID = Application.user_setting("language_id")
local MK = mod:localize("mod_attachment_mk")
local KASR = mod:localize("mod_attachment_kasr")

mod.bar_breakdown_widgets = {}
mod.bar_breakdown_widgets_by_name = {}
mod.added_cosmetics_scenegraphs = {}
mod.original_weapon_settings = {}
mod.changed_weapon_settings = {}
mod.move_duration_out = .5
mod.move_duration_in = 1
mod.reset_wait_time = 5
mod.weapon_changed = nil
mod.sound_duration = .5
mod.weapon_part_animation_entries = {}
mod.weapon_part_animation_time = .75
mod.cosmetics_view = nil
mod.mesh_positions = {}
mod.dropdown_positions = {}
mod.spawned_attachments = {}
mod.attachment_preview_count = 0
mod.spawned_attachments_last_position = {}
mod.spawned_attachments_target_position = {}
mod.spawned_attachments_timer = {}
mod.attachment_index_updated = {}
mod.attachment_index = {}
mod.preview_attachment_name = {}
mod.preview_attachment_slot = nil
mod.load_previews = {}
-- mod.spawned_attachments_overwrite_position = {}

for _, attachment_slot in pairs(mod.attachment_slots) do
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_text_pivot"
	mod.added_cosmetics_scenegraphs[#mod.added_cosmetics_scenegraphs+1] = attachment_slot.."_pivot"
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐ ##############################################################################################
-- ##### └─┐│ ││ ││││ ││ ##############################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘ ##############################################################################################

--#region Old
	-- mod.get_attachment_weapon_name = function(self, item, attachment_slot, attachment_name)
	-- 	if mod:get("mod_option_misc_attachment_names") and WeaponCustomizationLocalization.mod_attachment_remove[LANGUAGE_ID] then
	-- 		self.found_names = self.found_names or {}
	-- 		local name = nil
	-- 		if attachment_slot ~= "trinket_hook" and attachment_slot ~= "emblem_left" and attachment_slot ~= "emblem_right" and attachment_slot ~= "flashlight" and attachment_name ~= "no_stock"
	-- 				and attachment_name ~= "no_sight" and attachment_name ~= "scope_01" and attachment_name ~= "scope_02" and attachment_name ~= "scope_03" then
	-- 			self:setup_item_definitions()
	-- 			local item_name = self:item_name_from_content_string(item.name)
	-- 			local attachment_data = self.attachment_models[item_name][attachment_name]
	-- 			if attachment_data and attachment_data.model ~= "" then
	-- 				local item_definitions = self:persistent_table(REFERENCE).item_definitions
	-- 				-- Search only weapons
	-- 				for _, entry in pairs(item_definitions) do
	-- 					if entry.attachments and entry.item_type ~= WEAPON_SKIN and entry.display_name ~= "" and entry.display_name ~= "n/a" then
	-- 						local data = self:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
	-- 						if data then
	-- 							name = Localize(entry.display_name)
	-- 							-- mod:warning(name)
	-- 							if string_find(name, "unlocalized") then
	-- 								name = nil
	-- 							else
	-- 								if string_find(entry.display_name, "_desc") and entry.description then
	-- 									name = Localize(entry.description)
	-- 								end
	-- 							end
	-- 							if name and string_find(name, SKIP) then
	-- 								name = nil
	-- 							elseif name then
	-- 								break
	-- 							end
	-- 						end
	-- 					end
	-- 				end
	-- 				if not name then
	-- 					-- Search only skins
	-- 					for _, entry in pairs(item_definitions) do
	-- 						if entry.attachments and entry.item_type == WEAPON_SKIN and entry.display_name ~= "" and entry.display_name ~= "n/a" then
	-- 							local data = self:_recursive_find_attachment_item_string(entry.attachments, attachment_data.model)
	-- 							if data then
	-- 								name = Localize(entry.display_name)
	-- 								-- mod:warning(name)
	-- 								if string_find(name, "unlocalized") then
	-- 									name = nil
	-- 								else
	-- 									if string_find(entry.display_name, "_desc") and entry.description then
	-- 										name = Localize(entry.description)
	-- 									end
	-- 								end
	-- 								if name and string_find(name, SKIP) then
	-- 									name = nil
	-- 								elseif name then
	-- 									break
	-- 								end
	-- 							end
	-- 						end
	-- 					end
	-- 				end
	-- 			end
	-- 			local company_name = mod:localize("mod_attachment_names_company")
	-- 			if not name and not string_find(attachment_name, "default") then
	-- 				name = company_name
	-- 			end
	-- 			if name then
	-- 				local replace = string_split(mod:localize("mod_attachment_remove"), "|")
	-- 				if replace and #replace > 0 then
	-- 					for _, rep in pairs(replace) do
	-- 						name = string.gsub(name, rep, "")
	-- 					end
	-- 				end
	-- 				name = string_trim(name)
	-- 				name = string_cap(name)
	-- 				local additions = {MK.."I", MK.."II", MK.."III", MK.."IV", MK.."V", MK.."VI", MK.."VII", MK.."VIII"}
	-- 				local add_name = name
	-- 				if add_name == company_name or add_name == KASR then
	-- 					add_name = add_name.." "..additions[1]
	-- 				end
	-- 				local add_index = 1
	-- 				while table_contains(self.found_names, add_name) do
	-- 					add_name = name.." "..additions[add_index]
	-- 					add_index = add_index + 1
	-- 					if add_index > 7 then
	-- 						break
	-- 					end
	-- 				end
	-- 				name = add_name
	-- 				self.found_names[#self.found_names+1] = name
	-- 			end
	-- 		end
	-- 		return name
	-- 	end
	-- end

	-- mod.get_equipment_sound_effect = function(self, item, attachment_slot, attachment_name, type, load)

	-- 	if self.attachment_sounds[self.cosmetics_view._item_name] then
	-- 		local attachment_sounds = self.attachment_sounds[self.cosmetics_view._item_name]
	-- 		local sounds = attachment_sounds[attachment_slot] and attachment_sounds[attachment_slot][type]
	-- 		if sounds then return sounds end
	-- 	end

	-- 	-- local sound = "wwise/events/weapon/play_bolter_reload_hand"
	-- 	-- return {sound}
	-- 	local load = load or false
	-- 	local item_name = self.cosmetics_view._item_name
	-- 	-- if item.item_type == "WEAPON_RANGED" then
	-- 		if attachment_slot == "magazine" or attachment_slot == "magazine2" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2, SoundEventAliases.sfx_inspect.events.ogryn_heavystubber_p1_m1} end
	-- 			if type == "detach" then return {SoundEventAliases.sfx_magazine_eject.events[item_name] or SoundEventAliases.sfx_magazine_eject.events.default} end
	-- 			return {SoundEventAliases.sfx_magazine_insert.events[item_name] or SoundEventAliases.sfx_magazine_insert.default}

	-- 		elseif attachment_slot == "receiver" or attachment_slot == "body" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_weapon_up.events[item_name] or SoundEventAliases.sfx_weapon_up.default,
	-- 				SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
	-- 			return {SoundEventAliases.sfx_equip.events[item_name] or SoundEventAliases.sfx_equip.default}

	-- 		elseif attachment_slot == "bayonet" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_equip.events.ogryn_combatblade_p1_m2} end
	-- 			if type == "detach" then return {SoundEventAliases.sfx_equip.events.combatsword_p2_m3, SoundEventAliases.sfx_reload_lever_pull.events[item_name] or SoundEventAliases.sfx_reload_lever_pull.default}
	-- 			else return {SoundEventAliases.sfx_equip.events.combatsword_p2_m3, SoundEventAliases.sfx_reload_lever_release.events[item_name] or SoundEventAliases.sfx_reload_lever_release.default} end

	-- 		elseif attachment_slot == "muzzle" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
	-- 			return {SoundEventAliases.sfx_inspect_special_01.events.ogryn_rippergun_p1_m1}

	-- 		elseif attachment_slot == "flashlight" or attachment_slot == "rail" or attachment_slot == "trinket_hook" or attachment_slot == "head" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
	-- 			return {SoundEventAliases.sfx_equip.events.autogun_p3_m3, "wwise/events/player/play_foley_gear_flashlight_on"}

	-- 		elseif attachment_slot == "grip" or attachment_slot == "handle" or attachment_slot == "underbarrel" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
	-- 			return {SoundEventAliases.sfx_grab_weapon.events.bolter_p1_m1}

	-- 		elseif attachment_slot == "sight" or attachment_slot == "sight_2" or attachment_slot == "emblem_right" or attachment_slot == "emblem_left" or attachment_slot == "pommel" then
	-- 			if load then
	-- 				if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
	-- 				if type == "detach" then return {SoundEventAliases.sfx_grab_weapon.events.lasgun_p3_m1, SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1}
	-- 				else return {SoundEventAliases.sfx_equip_02.events.lasgun_p2_m1, SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1} end
	-- 			end
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.autogun_p2_m2} end
	-- 			if table_contains(self.reflex_sights, attachment_name) then
	-- 				if type == "detach" then return {SoundEventAliases.sfx_grab_weapon.events.lasgun_p3_m1}
	-- 				else return {SoundEventAliases.sfx_equip_02.events.lasgun_p2_m1} end
	-- 			end
	-- 			return {SoundEventAliases.sfx_vent_rattle.events.plasmagun_p1_m1}
	-- 		elseif attachment_slot == "stock" or attachment_slot == "stock_2" or attachment_slot == "stock_3" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
	-- 			return {SoundEventAliases.sfx_equip_02.events.bolter_p1_m1}

	-- 		elseif attachment_slot == "barrel" then
	-- 			if type == "select" then return {SoundEventAliases.sfx_inspect.events.ogryn_thumper_p1_m1} end
	-- 			return {SoundEventAliases.sfx_equip_02.events.autogun_p1_m1}

	-- 		else
	-- 			if type == "detach" then
	-- 				return {SoundEventAliases.sfx_weapon_down.events[item_name] or SoundEventAliases.sfx_weapon_down.default}
	-- 			else
	-- 				return {SoundEventAliases.sfx_weapon_up.events[item_name] or SoundEventAliases.sfx_weapon_up.default}
	-- 			end
	-- 		end
	-- 	-- end
	-- end



	-- mod.load_attachment_sounds = function(self, item)
	-- 	local attachments = self:get_item_attachment_slots(item)
	-- 	for _, attachment_slot in pairs(attachments) do
	-- 		local attachment_name = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item)
	-- 		local detach_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "detach", true)
	-- 		if detach_sounds then
	-- 			for _, detach_sound in pairs(detach_sounds) do
	-- 				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] then
	-- 					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[detach_sound] = true
	-- 					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[detach_sound] = managers.package:load(detach_sound, REFERENCE)
	-- 				end
	-- 			end
	-- 		end
	-- 		local attach_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "attach", true)
	-- 		if attach_sounds then
	-- 			for _, attach_sound in pairs(attach_sounds) do
	-- 				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] then
	-- 					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[attach_sound] = true
	-- 					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[attach_sound] = managers.package:load(attach_sound, REFERENCE)
	-- 				end
	-- 			end
	-- 		end
	-- 		local select_sounds = self:get_equipment_sound_effect(item, attachment_slot, attachment_name, "select", true)
	-- 		if select_sounds then
	-- 			for _, select_sound in pairs(select_sounds) do
	-- 				if not self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] then
	-- 					self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[select_sound] = true
	-- 					self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[select_sound] = managers.package:load(select_sound, REFERENCE)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	-- mod.release_attachment_sounds = function(self)
	-- 	local unloaded_packages = {}
	-- 	for sound, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds) do
	-- 		unloaded_packages[#unloaded_packages+1] = sound
	-- 		self:persistent_table(REFERENCE).used_packages.view_weapon_sounds[sound] = nil
	-- 		managers.package:release(package_id)
	-- 	end
	-- 	for _, package in pairs(unloaded_packages) do
	-- 		self:persistent_table(REFERENCE).loaded_packages.view_weapon_sounds[package] = nil
	-- 	end
	-- end
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################



-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌ ##################################################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├─┤│││││││├─┤ │ ││ ││││ ##################################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘ ##################################################################

mod.detach_attachment = function(self, item, attachment_slot, attachment, new_attachment, no_children, speed, hide_ui, attachment_type, callback)
	local item_name = self.cosmetics_view._item_name
	local attachment_type = attachment_type or "detach"
	self:do_weapon_part_animation(item, attachment_slot, attachment_type, new_attachment, no_children, speed, hide_ui, callback)
	local attachment_data = self.attachment_models[item_name][new_attachment]
	if attachment then
		attachment_data = self.attachment_models[item_name][attachment] or attachment_data
	end
	local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
	-- if not self:vector3_equal(movement, vector3_zero()) and attachment_type ~= "attach" then
	-- 	self:play_attachment_sound(item, attachment_slot, attachment, attachment_type)
	-- end
end

mod.weapon_part_animation_exists = function(self, attachment_slot)
	for _, weapon_part_animation in pairs(self.weapon_part_animation_entries) do
		if weapon_part_animation.slot == attachment_slot then
			return weapon_part_animation
		end
	end
end

mod.remove_weapon_part_animation = function(self, attachment_slot)
	for index, weapon_part_animation in pairs(self.weapon_part_animation_entries) do
		if weapon_part_animation.slot == attachment_slot then
			table_remove(self.weapon_part_animation_entries, index)
			break
		end
	end
end

local _children_sort_function = function(entry_1, entry_2)
	local distance_1 = entry_1.children or (entry_1.slot == "rail" and 1) or 0
	local distance_2 = entry_2.children or (entry_1.slot == "rail" and 1) or 0

	return distance_1 < distance_2
end

mod.do_weapon_part_animation = function(self, item, attachment_slot, attachment_type, new_attachment, no_children, speed, hide_ui, callback)
	local hide_ui = hide_ui == nil and true or hide_ui
	local existing_animation = self:weapon_part_animation_exists(attachment_slot)
	if not existing_animation then
		local modified_attachment_slot = self:_recursive_find_attachment(item.attachments, attachment_slot)
		-- Main animation
		local detach_only = attachment_type == "detach_only"
		local attach_only = attachment_type == "attach"
		-- attachment_type = attachment_type == "detach_only" and "detach" or attachment_type
		local real_type = attachment_type == "detach_only" and "detach" or attachment_type
		self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
			slot = attachment_slot,
			type = real_type,
			new = new_attachment,
			old = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item),
			children = modified_attachment_slot and modified_attachment_slot.children and #modified_attachment_slot.children or 0,
			speed = speed,
			detach_only = detach_only,
			attach_only = attach_only,
			hide = detach_only,
			callback = callback,
		}
		if hide_ui == true and mod:get("mod_option_camera_hide_ui") then
			self.cosmetics_view._visibility_toggled_on =  true
			self.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
		end
		-- Get auto equipy
		-- local auto_equips = self:get_auto_equips(item, attachment_slot, new_attachment)
		-- Get modified attachment slot
		local children = {}

		-- Trigger move
		local item_name = self.cosmetics_view._item_name
		local attachment_data = self.attachment_models[item_name][new_attachment]
		local trigger_move = attachment_data and attachment_data.trigger_move
		attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
		trigger_move = attachment_data and attachment_data.trigger_move or trigger_move
		if trigger_move then
			for _, trigger_attachment_slot in pairs(trigger_move) do
				children[#children+1] = {slot = trigger_attachment_slot}
			end
		end

		if modified_attachment_slot and (modified_attachment_slot.children or #children > 0) and not no_children then
			-- Find attached children
			if modified_attachment_slot and modified_attachment_slot.children then
				self:_recursive_get_attachments(modified_attachment_slot.children, children)
			end
			-- Has children?
			if children and #children > 0 then
				-- Iterate children
				for i, child in pairs(children) do
					if not self:weapon_part_animation_exists(child.slot) then
						local new_child_attachment = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item)
						-- local old_child_attachment = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item)
						
						self:do_weapon_part_animation(item, child.slot, attachment_type, new_child_attachment, no_children, speed, hide_ui) --, callback)
					-- 	local modified_child_attachment_slot = self:_recursive_find_attachment(item.attachments, child.slot)
					-- 	mod:echo("trigger: "..tostring(child.slot))
					-- 	self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
					-- 		slot = child.slot,
					-- 		type = attachment_type,
					-- 		new = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot),
					-- 		old = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item),
					-- 		children = modified_child_attachment_slot and modified_child_attachment_slot.children and #modified_child_attachment_slot.children or 0,
					-- 		speed = speed,
					-- 		detach_only = detach_only,
					-- 		hide = false,
					-- 	}
					end
				end
			end
		end
	elseif existing_animation and existing_animation.new == existing_animation.old and new_attachment ~= existing_animation.new then
		existing_animation.new = new_attachment
	end
	-- Attachment order
	table_sort(self.weapon_part_animation_entries, _children_sort_function)
	-- if #self.weapon_part_animation_entries > 0 then
	-- 	for i, entry in pairs(self.weapon_part_animation_entries) do
	-- 		local modified_attachment_slot = self:_recursive_find_attachment(item.attachments, entry.slot)
	-- 		if (modified_attachment_slot.children and #modified_attachment_slot.children > 0) or entry.slot == "rail" then
	-- 			table_remove(self.weapon_part_animation_entries, i)
	-- 			table_insert(self.weapon_part_animation_entries, 1, entry)
	-- 		end
	-- 	end
	-- end
end

mod.draw_equipment_lines = function(self, dt, t)
	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	if self.cosmetics_view and slot_infos and not self.dropdown_open then
		local gear_id = self.cosmetics_view._gear_id
		local slot_info_id = self.cosmetics_view._slot_info_id
		local item = self.cosmetics_view._selected_item
		local gui = self.cosmetics_view._ui_forward_renderer.gui
		local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
		local attachments = item.attachments
		if attachments and #self.weapon_part_animation_entries == 0 and slot_infos[slot_info_id] then
			local found_attachment_slots = self:get_item_attachment_slots(item)
			if #found_attachment_slots > 0 then

				for _, attachment_slot in pairs(found_attachment_slots) do
					local unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
					if unit and unit_alive(unit) then
						local box = Unit.box(unit, false)
						local center_position = matrix4x4_translation(box)
						local world_to_screen, distance = camera_world_to_screen(camera, center_position)
						local saved_origin = self.dropdown_positions[attachment_slot]
						if saved_origin and saved_origin[3] and saved_origin[3] == true then
							local origin = vector2(saved_origin[1], saved_origin[2])
							local color = Color(255, 49, 62, 45)
							ScriptGui.hud_line(gui, origin, world_to_screen, 20, 4, Color(255, 106, 121, 100))
							ScriptGui.hud_line(gui, origin, world_to_screen, 20, 2, Color(255, 49, 62, 45))
							break
						end
					end
				end

				-- local any_active = false
				-- for _, data in pairs(self.dropdown_positions) do
				-- 	if data[3] == true then
				-- 		any_active = true
				-- 		break
				-- 	end
				-- end
				-- for _, attachment_slot in pairs(found_attachment_slots) do
				-- 	local unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]
				-- 	if unit and unit_alive(unit) then
				-- 		local saved_origin = self.dropdown_positions[attachment_slot]
				-- 		local unit_position = unit_world_position(unit, 1)
				-- 		local camera_position = camera_world_position(self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera)
				-- 		local distance = vector3.distance(unit_position, camera_position)
				-- 		if (saved_origin and saved_origin[3] and saved_origin[3] == true) then
				-- 			if self.cosmetics_view._fade_system then
				-- 				Fade.set_min_fade(self.cosmetics_view._fade_system, unit, 0)
				-- 			end
				-- 		elseif any_active then
				-- 			if self.cosmetics_view._fade_system then
				-- 				Fade.set_min_fade(self.cosmetics_view._fade_system, unit, distance * .1)
				-- 			end
				-- 		else
				-- 			if self.cosmetics_view._fade_system then
				-- 				Fade.set_min_fade(self.cosmetics_view._fade_system, unit, 0)
				-- 			end
				-- 		end
				-- 	end
				-- end

			end
		end
	end
end

-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ###################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘  ├┤ │ │││││   │ ││ ││││└─┐ ###################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ###################################

--#region Old
	-- mod.resolve_auto_equips = function(self, item)
	-- 	local item_name = self:item_name_from_content_string(item.name)
	-- 	local gear_id = self:get_gear_id(item)
	-- 	for _, attachment_slot in pairs(self.attachment_slots) do
	-- 		-- if table_contains(self.just_changed, attachment_slot) then
	-- 			local attachment = item and self:get_gear_setting(gear_id, attachment_slot, item)
	-- 			if attachment then
	-- 				if self.attachment_models[item_name] and self.attachment_models[item_name][attachment] then
	-- 					local attachment_data = self.attachment_models[item_name][attachment]
	-- 					if attachment_data then
	-- 						local automatic_equip = attachment_data.automatic_equip
	-- 						local fixes = self:_apply_anchor_fixes(item, attachment_slot)
	-- 						automatic_equip = fixes and fixes.automatic_equip or automatic_equip
	-- 						if automatic_equip then
	-- 							for auto_type, auto_attachment in pairs(automatic_equip) do
	-- 								-- if not table_contains(self.just_changed, auto_type) then
	-- 									-- local sets = string_split(auto_attachment, ",")
	-- 									-- for _, set in pairs(sets) do
	-- 										local parameters = string_split(auto_attachment, "|")
	-- 										if #parameters == 2 then
	-- 											local negative = string_find(parameters[1], "!")
	-- 											parameters[1] = string_gsub(parameters[1], "!", "")
	-- 											-- local attachments = item.attachments or item.__master_item and item.__master_item.attachments
	-- 											-- if attachments then
	-- 												-- local attachment_data = self:_recursive_find_attachment(attachments, auto_type)
	-- 												local attachment_name = self:get_gear_setting(gear_id, auto_type, item)
	-- 												if attachment_name then
	-- 													-- mod:echo(tostring(auto_type).." = "..tostring(attachment_name))
	-- 													if negative and attachment_name ~= parameters[1] then
	-- 														self:set_gear_setting(gear_id, auto_type, parameters[2])
	-- 													elseif attachment_name == parameters[1] then
	-- 														self:set_gear_setting(gear_id, auto_type, parameters[2])
	-- 													end
	-- 												else mod:print("Attachment data for slot "..tostring(auto_type).." is nil") end
	-- 											-- else mod:print("Attachments are nil") end
	-- 										else
	-- 											self:set_gear_setting(gear_id, auto_type, parameters[1])
	-- 										end
	-- 								-- 	end
	-- 								-- end
	-- 							end
	-- 						else mod:print("Automatic equip for "..tostring(attachment).." in slot "..tostring(attachment_slot).." is nil", true) end
	-- 					else mod:print("Attachment data for "..tostring(attachment).." in slot "..tostring(attachment_slot).." is nil") end
	-- 				else mod:print("Models for "..tostring(attachment).." in slot "..tostring(attachment_slot).." not found") end
	-- 			end
	-- 		-- end
	-- 	end
	-- end
--#endregion

mod.start_weapon_move = function(self, position, no_reset)
	-- local view = self.cosmetics_view
	-- local ui_weapon_spawner = view and view._weapon_preview._ui_weapon_spawner
	-- local weapon_spawn_data = ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
	-- if weapon_spawn_data then
	-- 	mod:execute_extension(weapon_spawn_data.item_unit_3p, "weapon_animation_system", "move", position)
	-- end

	if position then
		self.move_position = position
		self.do_move = true
		self.no_reset = no_reset
	elseif self.link_unit_position then
		self.move_position = vector3_box(vector3_zero())
		self.do_move = true
	end
end

mod.play_zoom_sound = function(self, t, sound)
	if not self.sound_end or t >= self.sound_end then
		self.sound_end = t + self.sound_duration
		self.cosmetics_view:_play_sound(sound)
	end
end

--#region Old
	-- mod.resolve_no_support = function(self, item)
	-- 	-- Enable all dropdowns
	-- 	for _, attachment_slot in pairs(self.attachment_slots) do
	-- 		local widget = self.cosmetics_view._widgets_by_name[attachment_slot.."_custom"]
	-- 		if widget then
	-- 			widget.content.entry.disabled = false
	-- 			if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
	-- 				local options_by_id = widget.content.options_by_id
	-- 				for option_index, option in pairs(widget.content.options) do
	-- 					option.disabled = false
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- 	-- Disable no supported
	-- 	for _, attachment_slot in pairs(self.attachment_slots) do
	-- 		-- local item = self.cosmetics_view._selected_item
	-- 		local attachment = item and self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item)
	-- 		if attachment and self.attachment_models[self.cosmetics_view._item_name] and self.attachment_models[self.cosmetics_view._item_name][attachment] then
	-- 			local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment]
	-- 			local no_support = attachment_data.no_support
	--             attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
	-- 			no_support = attachment_data.no_support or no_support
	-- 			if no_support then
	-- 				for _, no_support_entry in pairs(no_support) do
	-- 					local widget = self.cosmetics_view._widgets_by_name[no_support_entry.."_custom"]
	-- 					if widget then
	-- 						widget.content.entry.disabled = true
	-- 					else
	-- 						for _, widget in pairs(self.cosmetics_view._custom_widgets) do
	-- 							if widget.content.entry and widget.content.entry.widget_type == "dropdown" then
	-- 								local options = widget.content.options
	-- 								for option_index, option in pairs(widget.content.options) do
	-- 									if option.id == no_support_entry then
	-- 										option.disabled = true
	-- 									end
	-- 								end
	-- 							end
	-- 						end
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end

	-- mod.resolve_special_changes = function(self, item, attachment)
	-- 	local item_name = self:item_name_from_content_string(item.name)
	-- 	local gear_id = self:get_gear_id(item)
	-- 	local attachment_data = self.attachment_models[item_name][attachment]
	-- 	if attachment_data and attachment_data.special_resolve then
	-- 		local special_changes = attachment_data.special_resolve(gear_id, item, attachment)
	-- 		if special_changes then
	-- 			for special_slot, special_attachment in pairs(special_changes) do

	-- 				if self.cosmetics_view then
	-- 					if not self.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
	-- 						if not self:get_gear_setting(gear_id, special_slot) then
	-- 							self.original_weapon_settings[special_slot] = "default"
	-- 						else
	-- 							self.original_weapon_settings[special_slot] = self:get_gear_setting(gear_id, special_slot)
	-- 						end
	-- 					end

	-- 					self:remove_weapon_part_animation(special_slot)
	-- 				end

	-- 				if string_find(special_attachment, "|") then
	-- 					local possibilities = string_split(special_attachment, "|")
	-- 					local rnd = math.random(#possibilities)
	-- 					special_attachment = possibilities[rnd]
	-- 				end

	-- 				-- mod:echo("special resolve: "..tostring(special_slot).." = "..tostring(special_attachment))
	-- 				-- self:set_gear_setting(gear_id, special_slot, special_attachment)
	-- 				if self.cosmetics_view then
	-- 					self:do_weapon_part_animation(item, special_slot, "attach", special_attachment)
	-- 				else
	-- 					self:set_gear_setting(gear_id, special_slot, special_attachment)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
--#endregion

mod.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
	if self.cosmetics_view._gear_id then
		if attachment_slot and attachment then
			if not self.original_weapon_settings[attachment_slot] and not table_contains(self.automatic_slots, attachment_slot) then
				if not self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot) then
					self.original_weapon_settings[attachment_slot] = "default"
				else
					self.original_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
				end
			end

			self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, attachment)

			-- self:get_attachment_weapon_name(item, attachment_slot, attachment)

			self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
			self:resolve_auto_equips(self.cosmetics_view._presentation_item)
			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment]
			-- if attachment_data and attachment_data.special_resolve then
			-- 	local special_changes = attachment_data.special_resolve(self.cosmetics_view._gear_id, self.cosmetics_view._presentation_item, attachment)
			-- 	if special_changes then
			-- 		for special_slot, special_attachment in pairs(special_changes) do

			-- 			if not self.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
			-- 				if not self:get_gear_setting(self.cosmetics_view._gear_id, special_slot) then
			-- 					self.original_weapon_settings[special_slot] = "default"
			-- 				else
			-- 					self.original_weapon_settings[special_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, special_slot)
			-- 				end
			-- 			end

			-- 			self:set_gear_setting(self.cosmetics_view._gear_id, special_slot, special_attachment)
			-- 		end
			-- 	end
			-- end
		end

		if not no_update then
			self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
			self:resolve_auto_equips(self.cosmetics_view._presentation_item)

			-- mod:add_to_packages(self.cosmetics_view._selected_item)
			-- mod:remove_from_packages(self.cosmetics_view._selected_item)

			self.cosmetics_view._presentation_item = MasterItems.create_preview_item_instance(self.cosmetics_view._selected_item)

			-- if self.cosmetics_view._previewed_element then
			-- 	self.cosmetics_view:_preview_element(self.cosmetics_view._previewed_element)
			-- else
			self.cosmetics_view:_preview_item(self.cosmetics_view._presentation_item)
			-- end

			self:resolve_no_support(self.cosmetics_view._presentation_item)

			self.cosmetics_view._slot_info_id = self:get_slot_info_id(self.cosmetics_view._presentation_item)

			self:get_changed_weapon_settings()
		end
	end
end

-- Change light positions
mod.set_light_positions = function(self, ui_weapon_spawner)
	if self.preview_lights then
		for _, unit_data in pairs(self.preview_lights) do
			-- Get default position
			local default_position = vector3_unbox(unit_data.position)
			-- Get difference to link unit position
			local link_difference = vector3_unbox(ui_weapon_spawner._link_unit_base_position) - vector3_unbox(ui_weapon_spawner._link_unit_position)
			-- Position with offset
			local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
			unit_set_local_position(unit_data.unit, 1, light_position)
		end
	end
end

mod.unit_hide_meshes = function(self, unit, hide)
	if unit and unit_alive(unit) then
		local num_meshes = unit_num_meshes(unit)
		-- if hide then mod:echo("hide unit: "..tostring(unit)) end
		-- if not hide then mod:echo("show unit: "..tostring(unit)) end
		if num_meshes and num_meshes > 0 then
			for i = 1, num_meshes do
				unit_set_mesh_visibility(unit, i, not hide)
			end
		end
	end
end

mod.update_attachment_previews = function(self, dt, t)
	local selected_index = self.attachment_preview_index or 1
	if self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
		for _, unit in pairs(self.spawned_attachments) do
			
			local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
			if unit and unit_alive(unit) then
				-- if index + 1 == self.attachment_preview_index then
				-- 	unit_set_local_scale(unit, 1, vector3(1.3, 1.3, 1.3))
				-- else
				-- 	unit_set_local_scale(unit, 1, vector3(1, 1, 1))
				-- end
				unit_set_local_rotation(unit, 1, unit_world_rotation(link_unit, 1))

				-- local last_slot = mod.attachment_slot_positions[7] or self.spawned_attachments_last_position[unit]

				if self.attachment_index_updated[unit] ~= self.attachment_preview_index then
					-- local max = self.attachment_preview_count / 2
					-- local selected = selected_index / max
					-- local fraction = index / max
					-- local x = (max * fraction - max * (selected - .4)) * .4
					-- local z = math.abs(index - selected_index) * .1
					
					-- local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
					-- local rotation = camera_world_rotation(camera)
					-- local camera_forward = quaternion_forward(rotation)
					-- local distance = vector3_zero()
					-- local down = vector3.down() * .2
					-- if index + 1 == self.attachment_preview_index then
					-- 	distance = camera_forward * 3
					-- 	down = vector3.down() * .15
					-- else
					-- 	distance = camera_forward * 6
					-- end
					-- local camera_position = camera_world_position(camera)
					-- local target_position = camera_position + distance + down + vector3(x, 0, 0)
					local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
					local target_position = self.attachment_slot_positions[6]
					local index = self.attachment_index[unit]
					local attachment_name = self.preview_attachment_name[unit]
					if index == self.attachment_preview_index then
						local item = mod.cosmetics_view._selected_item
						local attachment_slot = self.preview_attachment_slot
						self:play_attachment_sound(item, attachment_slot, attachment_name, "select")
						self:preview_flashlight(true, world, unit, attachment_name)
						local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
						local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
						local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
						-- self.attachment_slot_positions[3] = attachment_unit and unit_world_position(attachment_unit, 1) or self.attachment_slot_positions[3]
						target_position = self.attachment_slot_positions[3]
						self.spawned_attachments_last_position[unit] = attachment_unit and unit_world_position(attachment_unit, 1)
						unit_set_unit_visibility(unit, true, true)

						-- local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
						local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
						attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
						local scale = attachment_data and attachment_data.scale and vector3_unbox(attachment_data.scale) or vector3_zero()
						unit_set_local_scale(unit, 1, scale)
						
						-- local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
						-- local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
						-- local attachment_unit = mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
						-- -- local attachment_name = unit_get_data(flashlight, "attachment_name")
						-- -- mod:preview_flashlight(true, self._world, flashlight, attachment_name)
						-- if attachment_unit then
						-- 	self.spawned_attachments_overwrite_position[unit] = mod.attachment_slot_positions[7]
						-- end
						-- mod:play_attachment_sound(mod.cosmetics_view._selected_item, self.preview_attachment_slot, entry.new, "attach")
						
						-- target_position = self.attachment_slot_positions[3]
						-- unit_set_unit_visibility(unit, true, true)
					elseif index ~= self.attachment_preview_index then
						self.spawned_attachments_last_position[unit] = self.spawned_attachments_last_position[unit] 
							or self.attachment_slot_positions[3]
						local diff = index - self.attachment_preview_index
						if math.abs(diff) <= 2 then
							target_position = self.attachment_slot_positions[3 + diff]
							unit_set_unit_visibility(unit, true, true)
						else
							unit_set_unit_visibility(unit, false, true)
						end
						self:preview_flashlight(false, world, unit, attachment_name, true)

					end

					local tm, half_size = Unit.box(unit)
					local radius = math.max(half_size.x, half_size.y)
					local scale = .08 / math_max(radius, half_size.z * 2)
					unit_set_local_scale(unit, 1, vector3(scale, scale, scale))					

					self.spawned_attachments_last_position[unit] = self.spawned_attachments_target_position[unit] or self.attachment_slot_positions[6]
					self.spawned_attachments_target_position[unit] = target_position
					-- mod:echo("target: "..tostring(vector3_unbox(target_position)))

					self.attachment_index_updated[unit] = self.attachment_preview_index
					self.spawned_attachments_timer[unit] = t + 1

				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] > t then
					local target_position = self.spawned_attachments_target_position[unit]
					local last_position = self.spawned_attachments_last_position[unit]
					local progress = (self.spawned_attachments_timer[unit] - t) / 1
					local anim_progress = math.easeOutCubic(1 - progress)
					local lerp_position = vector3_lerp(vector3_unbox(last_position), vector3_unbox(target_position), anim_progress)
					unit_set_local_position(unit, 1, lerp_position)

				elseif self.spawned_attachments_timer[unit] and self.spawned_attachments_timer[unit] <= t then
					self.spawned_attachments_timer[unit] = nil
					local target_position = self.spawned_attachments_target_position[unit]
					unit_set_local_position(unit, 1, vector3_unbox(target_position))
					-- self.spawned_attachments_overwrite_position[unit] = nil
					-- mod.attachment_slot_positions[7] = nil

				end
			end
		end
	end
end

mod.spawn_attachment_preview = function(self, index, attachment_slot, attachment_name, base_unit)
	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
	local pose = Unit.world_pose(link_unit, 1)
	local unit = base_unit and World.spawn_unit_ex(world, base_unit, nil, pose)
	local callback = function()
	end
	Unit.force_stream_meshes(unit, callback, true)
	-- local attachment_data = mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
	local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
	local scale = attachment_data and attachment_data.scale or vector3(1, 1, 1)
	attachment_data = self:_apply_anchor_fixes(self.cosmetics_view._selected_item, attachment_slot) or attachment_data
	scale = attachment_data and attachment_data.scale or scale
	unit_set_local_scale(unit, 1, scale)
	-- mod:preview_flashlight(true, false, world, unit, attachment_name)
	self.preview_attachment_name[unit] = attachment_name
	self.attachment_index[unit] = index
	self.spawned_attachments[#self.spawned_attachments+1] = unit
	return unit
end

mod.try_spawning_previews = function(self)
	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data then
		for i = #self.load_previews, 1, -1 do
			local preview = self.load_previews[i]
			self:spawn_attachment_preview(preview.index, preview.attachment_slot, preview.attachment_name, preview.base_unit)
			self.load_previews[i] = nil
		end
	end
end

mod.attachment_package_loaded = function(self, index, attachment_slot, attachment_name, base_unit)
	-- local attachment_unit = self:spawn_attachment_preview(index, attachment_slot, attachment_name, base_unit)
	self.load_previews[#self.load_previews+1] = {
		index = index,
		attachment_slot = attachment_slot,
		attachment_name = attachment_name,
		base_unit = base_unit,
	}
end

mod.release_attachment_packages = function(self)
	self:destroy_attachment_previews()
	self:persistent_table(REFERENCE).used_packages.customization = {}
	for package_key, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages.customization) do
		managers.package:release(package_id)
	end
	self:persistent_table(REFERENCE).loaded_packages.customization = {}
end

mod.destroy_attachment_previews = function(self)
	local world = self.cosmetics_view._weapon_preview._ui_weapon_spawner._world
	for _, unit in pairs(self.spawned_attachments) do
		if unit and unit_alive(unit) then
			world_unlink_unit(world, unit)
			-- world_destroy_unit(world, unit)
		end
	end
	for _, unit in pairs(self.spawned_attachments) do
		if unit and unit_alive(unit) then
			-- world_unlink_unit(world, unit)
			world_destroy_unit(world, unit)
		end
	end
	self.spawned_attachments = {}
end

--#region Old
	-- mod.load_attachment_packages = function(self, item, attachment_slot)
	-- 	self:setup_item_definitions()

	-- 	local attachments = self.attachment[self.cosmetics_view._item_name]
	-- 	local slot_attachments = attachments and attachments[attachment_slot] or {}
	-- 	local possible_attachments = {}
	-- 	for index, attachment_data in pairs(slot_attachments) do
	-- 		local model_data = self.attachment_models[self.cosmetics_view._item_name][attachment_data.id]
	-- 		local attachment_item = model_data and self:persistent_table(REFERENCE).item_definitions[model_data.model]
	-- 		if attachment_item and not string_find(attachment_data.id, "default") then
	-- 			local priority = false
	-- 			if index == self.attachment_preview_index then
	-- 				priority = true
	-- 			else
	-- 				local diff = index - self.attachment_preview_index
	-- 				if math.abs(diff) <= 2 then priority = true end
	-- 			end
	-- 			local target_index = #possible_attachments + 1
	-- 			if priority then target_index = 1 end
	-- 			table_insert(possible_attachments, target_index, {
	-- 				item = attachment_item,
	-- 				name = attachment_data.id,
	-- 				base_unit = attachment_item.base_unit,
	-- 				index = index,
	-- 			})
	-- 			-- possible_attachments[#possible_attachments+1] = {
	-- 			-- 	item = attachment_item,
	-- 			-- 	name = attachment_data.id,
	-- 			-- 	base_unit = attachment_item.base_unit,
	-- 			-- 	index = index,
	-- 			-- }
	-- 		end
	-- 	end
		
	-- 	self.attachment_preview_count = #possible_attachments

	-- 	for _, attachment_data in pairs(possible_attachments) do
	-- 		if attachment_data.item.resource_dependencies then
	-- 			for package_name, _ in pairs(attachment_data.item.resource_dependencies) do
	-- 				-- mod:echo(tostring(package_name))
	-- 				local package_key = attachment_slot.."_"..attachment_data.name
	-- 				local callback = callback(mod, "attachment_package_loaded", attachment_data.index, attachment_slot, attachment_data.name, attachment_data.base_unit)
	-- 				if not self:persistent_table(REFERENCE).loaded_packages.customization[package_key] then
	-- 					self:persistent_table(REFERENCE).used_packages.customization[package_key] = true
	-- 					self:persistent_table(REFERENCE).loaded_packages.customization[package_key] = managers.package:load(package_name, REFERENCE, callback, true)
	-- 				end
	-- 			end
	-- 		end

	-- 	end
	-- end
--#endregion

mod.setup_attachment_slot_positions = function(self)
	local camera = self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera
	local rotation = camera_world_rotation(camera)
	local camera_forward = quaternion_forward(rotation)
	local camera_position = camera_world_position(camera)
	local x = .05
	local link_unit = self.cosmetics_view._weapon_preview._ui_weapon_spawner._weapon_spawn_data.link_unit
	self.attachment_slot_positions = {
		vector3_box(camera_position + camera_forward * 5 + vector3(x - .6, 0, 0)),
		vector3_box(camera_position + camera_forward * 4 + vector3(x - .3, -.1, -.1)),
		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
		vector3_box(camera_position + camera_forward * 3 + vector3(x + .175, -.15, .025)),
		vector3_box(camera_position + camera_forward * 3.5 + vector3(x + .3, 0, .2)),
		-- vector3_box(unit_world_position(link_unit, 1) + vector3(0, 0, 3)),
		vector3_box(camera_position + camera_forward * 2 + vector3(x, 0, -.05)),
	}
end

mod.create_attachment_array = function(self, item, attachment_slot)
	self.preview_attachment_slot = attachment_slot
	if self.cosmetics_view and self.cosmetics_view._weapon_preview._ui_weapon_spawner._camera then
		local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
		if ui_weapon_spawner._weapon_spawn_data then
			local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
			local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
			if attachment_unit then
				local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
				local attachment_data = attachment_name and mod.attachment_models[self.cosmetics_view._item_name][attachment_name]
				local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
				-- mod:echo("set position")
				self:setup_attachment_slot_positions()
				self:load_attachment_packages(item, attachment_slot)
				self:unit_hide_meshes(attachment_unit, true)
			else
				self:setup_attachment_slot_positions()
				self:load_attachment_packages(item, attachment_slot)
			end
		end
	end
end

-- ##### ┬ ┬┬  ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌─┐┌─┐┬ ┬┌┐┌┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################
-- ##### │ ││  │││├┤ ├─┤├─┘│ ││││  └─┐├─┘├─┤││││││├┤ ├┬┘  ├─┤│ ││ │├┴┐└─┐ #############################################
-- ##### └─┘┴  └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘┴  ┴ ┴└┴┘┘└┘└─┘┴└─  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)
	func(self, reference_name, world, camera, unit_spawner, ...)
	if reference_name ~= "WeaponIconUI" then
		self._rotation_angle = mod._rotation_angle or 0
		self._default_rotation_angle = mod._last_rotation_angle or 0
	end

end)

--#region Old
	-- mod.get_animation_wait_slots = function(self, item, attachment_slot, animation_wait_attach_slots, animation_wait_detach_slots)
	-- 	local gear_id = mod:get_gear_id(item)
	-- 	local item_name = mod:item_name_from_content_string(item.name)
	-- 	local attachment = mod:get_gear_setting(gear_id, entry.slot, mod.cosmetics_view._selected_item)
	-- 	local animation_wait_attach_slots = animation_wait_attach_slots or {}
	-- 	local animation_wait_detach_slots = animation_wait_detach_slots or {}
	-- 	-- local attachment_data = attachment and mod.attachment_models[item_name][attachment]
	-- 	-- local animation_wait_attach = attachment_data and attachment_data.animation_wait_attach
	-- 	-- local animation_wait_detach = attachment_data and attachment_data.animation_wait_detach

	-- 	local anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment]
	-- 	if anchor then
	-- 		if anchor.animation_wait_attach then
	-- 			animation_wait_attach_slots = table.merge(animation_wait_attach_slots, anchor.animation_wait_attach)
	-- 		end
	-- 		if anchor.animation_wait_detach then
	-- 			animation_wait_detach_slots = table.merge(animation_wait_detach_slots, anchor.animation_wait_detach)
	-- 		end
	-- 	end

	-- 	local unit = gear_info.attachment_slot_to_unit[entry.slot]
	-- 	anchor = unit and mod:_apply_anchor_fixes(mod.cosmetics_view._presentation_item, unit) or anchor
	-- 	if anchor then
	-- 		if anchor.animation_wait_attach then
	-- 			animation_wait_attach_slots = table.merge(animation_wait_attach_slots, anchor.animation_wait_attach)
	-- 		end
	-- 		if anchor.animation_wait_detach then
	-- 			animation_wait_detach_slots = table.merge(animation_wait_detach_slots, anchor.animation_wait_detach)
	-- 		end
	-- 	end
	-- 	if not mod.test8234594385 then
	-- 		mod:dtf(animation_wait_attach_slots, "animation_wait_attach_slots", 10)
	-- 		mod:dtf(animation_wait_detach_slots, "animation_wait_detach_slots", 10)
	-- 		mod.test8234594385 = true
	-- 	end

	-- 	return {
	-- 		animation_wait_attach_slots = animation_wait_attach_slots,
	-- 		animation_wait_detach_slots = animation_wait_detach_slots,
	-- 	}
	-- end
--#endregion

mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

	local weapon_spawn_data = self._weapon_spawn_data
	if weapon_spawn_data then
		if not weapon_spawn_data.visible then
			-- mod.weapon_spawning = nil
			-- weapon_spawn_data.streaming_complete = true
			self:cb_on_unit_3p_streaming_complete(weapon_spawn_data.item_unit_3p)
		end
	end

	-- local current_rotation = self._rotation_angle

	func(self, dt, t, input_service, ...)

	-- self._rotation_angle = current_rotation

	if self._reference_name ~= "WeaponIconUI" and mod.cosmetics_view then

		-- if weapon_spawn_data then
		-- 	if not script_unit_has_extension(weapon_spawn_data.item_unit_3p, "weapon_animation_system") then
		-- 		self.weapon_animation_extension = script_unit_add_extension({
		-- 			world = self._world,
		-- 		}, weapon_spawn_data.item_unit_3p, "WeaponAnimationExtension", "weapon_animation_system", {
		-- 			ui_weapon_spawner = self,
		-- 			is_local_unit = true,
		-- 			player_unit = weapon_spawn_data.item_unit_3p,
		-- 		})
		-- 	else
		-- 		mod:execute_extension(weapon_spawn_data.item_unit_3p, "weapon_animation_system", "update", dt, t)
		-- 	end
		-- end

		if mod:get("mod_option_carousel") then
			mod:try_spawning_previews()
			mod:update_attachment_previews(dt, t)
		end

		mod._rotation_angle = self._rotation_angle

		local weapon_spawn_data = self._weapon_spawn_data
		if weapon_spawn_data and self._link_unit_position then
			local item_name = mod.cosmetics_view._item_name
			local link_unit = weapon_spawn_data.link_unit
			local position = vector3_unbox(self._link_unit_position)
			local animation_speed = mod:get("mod_option_weapon_build_animation_speed")
			local animation_time = mod.weapon_part_animation_time
			local item_unit_3p = weapon_spawn_data.item_unit_3p

			-- Camera movement
			if mod.do_move and mod:get("mod_option_camera_zoom") and not self.demo then
				if mod.move_position then
					local last_move_position = mod.last_move_position and vector3_unbox(mod.last_move_position) or vector3_zero()
					local move_position = vector3_unbox(mod.move_position)
					if not mod:vector3_equal(last_move_position, move_position) then
						mod.new_position = vector3_box(vector3_unbox(self._link_unit_base_position) + move_position)
						mod.move_end = t + mod.move_duration_in
						mod.current_move_duration = mod.move_duration_in
						mod.last_move_position = mod.move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					end
				elseif self._link_unit_base_position then
					local last_move_position = vector3_unbox(self._link_unit_position)
					local move_position = vector3_unbox(self._link_unit_base_position)
					if not mod:vector3_equal(move_position, last_move_position) then
						mod.new_position = self._link_unit_base_position
						mod.move_end = t + mod.move_duration_out
						mod.current_move_duration = mod.move_duration_out
						mod.last_move_position = vector3_zero()
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
					end
				end
				mod.do_move = nil
				mod.do_reset = nil
				mod.reset_start = nil
			else
				if mod.move_end and t <= mod.move_end then
					local progress = (mod.move_end - t) / mod.current_move_duration
					local anim_progress = math_easeInCubic(1 - progress)
					local lerp_position = vector3_lerp(position, vector3_unbox(mod.new_position), anim_progress)
					mod.link_unit_position = vector3_box(lerp_position)
					if link_unit and unit_alive(link_unit) then
						unit_set_local_position(link_unit, 1, lerp_position)
					end
					self._link_unit_position = vector3_box(lerp_position)
				elseif mod.move_end and t > mod.move_end then
					mod.move_end = nil
					if link_unit and unit_alive(link_unit) then
						unit_set_local_position(link_unit, 1, vector3_unbox(mod.new_position))
					end
					if link_unit and unit_alive(link_unit) then
						mod.link_unit_position = vector3_box(unit_local_position(link_unit, 1))
					end
					if mod.current_move_duration == mod.move_duration_in and not mod:vector3_equal(vector3_unbox(mod.new_position), vector3_zero()) then
						mod.do_reset = true
					end
				end
			end

			-- Lights
			mod:set_light_positions(self)
			
			-- Camera rotation
			if mod.do_rotation then
				local new_rotation = mod.new_rotation
				if new_rotation then
					if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
						-- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					end
					-- self._rotation_angle = mod._last_rotation_angle or 0
					self._default_rotation_angle = new_rotation
					mod._last_rotation_angle = self._default_rotation_angle
					mod.check_rotation = true
					mod.do_reset = nil
					mod.reset_start = nil
					mod.do_rotation = nil
				end
			elseif mod.check_rotation and not mod.dropdown_open then
				if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
					if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
						mod.do_reset = true
					end
					mod.check_rotation = nil
				end
			end

			-- Reset
			if mod.do_reset and not mod.dropdown_open and not self.demo then
				mod.reset_start = t + mod.reset_wait_time
				mod.do_reset = nil
			elseif mod.reset_start and t >= mod.reset_start and not mod.dropdown_open and not self.demo then
				if mod.move_position then
					mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
				end
				mod.move_position = nil
				mod.do_move = true
				mod.reset_start = nil
				self._default_rotation_angle = 0
				mod._last_rotation_angle = 0
			elseif mod.reset_start and mod.dropdown_open and not self.demo then
				mod.reset_start = mod.reset_start + dt
			end

			local gear_id = mod.cosmetics_view._gear_id
			local slot_info_id = mod.cosmetics_view._slot_info_id
			local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
			local gear_info = slot_infos[slot_info_id]

			-- Weapon part animations
			local index = 1
			local entries = mod.weapon_part_animation_entries
			if entries and #entries > 0 then
				local all_attach_done = true
				local all_detach_done = true
				local all_finished = true
				for _, entry in pairs(entries) do
					if entry.type == "attach" and not entry.attach_done then
						all_attach_done = false
					end
					if entry.type == "detach" and not entry.detach_done then
						all_detach_done = false
					end
					if not entry.finished then
						all_finished = false
					end
				end
				-- local animation_wait_detach_slots = {}
				-- local animation_wait_attach_slots = {}
				-- for _, entry in pairs(entries) do
				-- 	local attachment = mod:get_gear_setting(gear_id, entry.slot, mod.cosmetics_view._selected_item)
				-- 	-- local attachment_data = attachment and mod.attachment_models[item_name][attachment]
				-- 	-- local animation_wait_attach = attachment_data and attachment_data.animation_wait_attach
				-- 	-- local animation_wait_detach = attachment_data and attachment_data.animation_wait_detach

				-- 	local anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment]
				-- 	if anchor then
				-- 		if anchor.animation_wait_attach then
				-- 			animation_wait_attach_slots = table.merge(animation_wait_attach_slots, anchor.animation_wait_attach)
				-- 		end
				-- 		if anchor.animation_wait_detach then
				-- 			animation_wait_detach_slots = table.merge(animation_wait_detach_slots, anchor.animation_wait_detach)
				-- 		end
				-- 	end
				-- 	local unit = gear_info.attachment_slot_to_unit[entry.slot]
				-- 	anchor = unit and mod:_apply_anchor_fixes(mod.cosmetics_view._presentation_item, unit) or anchor
				-- 	if anchor then
				-- 		if anchor.animation_wait_attach then
				-- 			animation_wait_attach_slots = table.merge(animation_wait_attach_slots, anchor.animation_wait_attach)
				-- 		end
				-- 		if anchor.animation_wait_detach then
				-- 			animation_wait_detach_slots = table.merge(animation_wait_detach_slots, anchor.animation_wait_detach)
				-- 		end
				-- 	end
					-- if not mod.test8234594385 then
					-- 	mod:dtf(animation_wait_attach_slots, "animation_wait_attach_slots", 10)
					-- 	mod:dtf(animation_wait_detach_slots, "animation_wait_detach_slots", 10)
					-- 	mod.test8234594385 = true
					-- end
				-- end

				for _, entry in pairs(entries) do

					
					local attachment = mod:get_gear_setting(gear_id, entry.slot, mod.cosmetics_view._presentation_item)
					-- if entry.new and type(entry.new) == "string" then
					-- entry.new = entry.new or entry.old
					-- attachment = entry.new and entry.new == "default" and mod:get_actual_default_attachment(mod.cosmetics_view._selected_item, entry.slot) or attachment
					-- end
					local attachment_data = attachment and mod.attachment_models[item_name][attachment]
					local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
					local animation_wait_attach = attachment_data and attachment_data.animation_wait_attach
					local animation_wait_detach = attachment_data and attachment_data.animation_wait_detach
					local parent = attachment_data and attachment_data.parent and attachment_data.parent
					local root_movement = attachment_data and attachment_data.move_root
					local root_unit = gear_info.attachment_slot_to_unit["root"]
					local root_default = gear_info.unit_default_position[root_unit]
					local root_default_position = root_default and vector3_unbox(root_default) or vector3_zero()
					-- local unit = gear_info.attachment_slot_to_unit[entry.slot]
					local unit = mod:get_attachment_slot_in_attachments(weapon_spawn_data.attachment_units_3p, entry.slot)
					local unit_good = unit and unit_alive(unit)
					local environment_extension = nil
					local wobble = mod:get("mod_option_weapon_build_animation_wobble")

					local anchor = mod.anchors[item_name] and mod.anchors[item_name][attachment]
					anchor = mod:_apply_anchor_fixes(mod.cosmetics_view._presentation_item, unit) or anchor

					-- if unit_good and Unit.has_data(unit, "anchor") then
					-- 	anchor = Unit.get_data(unit, "anchor") or anchor
					-- end

					animation_wait_attach = anchor and anchor.animation_wait_attach or animation_wait_attach
					animation_wait_detach = anchor and anchor.animation_wait_detach or animation_wait_detach
					local default_position0 = unit and vector3_unbox(gear_info.unit_default_position[unit])
					local default_position1 = unit_good and unit_local_position(unit, 1)
					local default_position = anchor and anchor.position and vector3_unbox(anchor.position) or default_position0 or default_position1 or vector3_zero()

					local mesh_move = gear_info and gear_info.unit_mesh_move[unit]
					if not mesh_move then
						movement = default_position + movement
					end

					if entry.type == "attach" and unit_good then
						mod:unit_set_local_position_mesh(slot_info_id, unit, movement)
					end

					local process = true
					if animation_wait_attach and entry.type == "attach" then
						if not entry.attach_done then
							for _, wait_for_slot in pairs(animation_wait_attach) do
								local weapon_part_animation = mod:weapon_part_animation_exists(wait_for_slot)
								local wait_slot_unit = gear_info.attachment_slot_to_unit[wait_for_slot]
								if wait_slot_unit and weapon_part_animation and not weapon_part_animation.attach_done then
									process = false
									if entry.end_time then entry.end_time = entry.end_time + dt end
									break
								end
							end
						end
					elseif animation_wait_detach and entry.type == "detach" then
						if not entry.detach_done then
							for _, wait_for_slot in pairs(animation_wait_detach) do
								local weapon_part_animation = mod:weapon_part_animation_exists(wait_for_slot)
								local wait_slot_unit = gear_info.attachment_slot_to_unit[wait_for_slot]
								if wait_slot_unit and weapon_part_animation and not weapon_part_animation.detach_done then
									process = false
									if entry.end_time then entry.end_time = entry.end_time + dt end
									break
								end
							end
						end
					end

					if process then
						if not mod.weapon_spawning then
							local this_animation_speed = entry.speed or animation_speed or .1
							-- local this_time_modifier = 1 + (index / #entries)

							-- No timer yet - start new state
							if not entry.end_time then
								if attachment then
									local attachment = entry.old == "default" and mod:get_actual_default_attachment(mod.cosmetics_view._presentation_item, entry.slot) or entry.old
									local attachment_data = mod.attachment_models[mod.cosmetics_view._item_name][attachment]
									local no_animation = attachment_data and attachment_data.no_animation
									entry.no_detach_animation = no_animation

									-- if (entry.type == "detach" or entry.type == "wobble") then
									-- 	entry.end_time = t + animation_time / this_animation_speed
									-- else
									-- 	entry.end_time = t + animation_time / this_animation_speed
									-- end
									entry.end_time = t + (animation_time / this_animation_speed)
								else
									entry.end_time = t
								end
							end

							-- if entry.type ~= "wobble" and unit_good then
							-- 	mod:preview_flashlight(false, self._world, unit, attachment, true)
							-- else
							-- 	mod:preview_flashlight(true, self._world, unit, attachment, true)
							-- end

							-- Run animation
							if entry.end_time and entry.end_time >= t then

								-- When detaching
								if entry.type == "detach" then
									-- Play sound
									if not entry.detach_started then
										mod:play_attachment_sound(mod.cosmetics_view._presentation_item, entry.slot, entry.new, "detach")
										entry.detach_started = true
									end
									if entry.no_detach_animation or not unit_good then
										-- Not processed
										entry.end_time = t
										if entry.detach_only and not wobble then entry.finished = true end
									elseif not entry.no_detach_animation then
										mod:preview_flashlight(false, self._world, unit, attachment, true)
										local progress = (entry.end_time - t) / (animation_time / this_animation_speed)
										local anim_progress = math.ease_in_exp(1 - progress)
										local lerp_position = vector3_lerp(default_position, movement, anim_progress)
										mod:unit_set_local_position_mesh(slot_info_id, unit, lerp_position)
									end

								-- When attaching
								elseif entry.type == "attach" then
									if not entry.attach_only_load and entry.attach_only then
										-- mod:load_new_attachment(weapon_spawn_data.item)
										entry.attach_only_load = true
									elseif entry.no_attach_animation or not unit_good then
										-- Not processed
										entry.attach_done = true
										entry.end_time = t
										if not wobble then entry.finished = true end
									else
										mod:preview_flashlight(false, self._world, unit, attachment, true)
										local progress = (entry.end_time - t) / (animation_time / this_animation_speed)
										local anim_progress = math.ease_in_exp(1 - progress)
										local lerp_position = vector3_lerp(movement, default_position, anim_progress)
										mod:unit_set_local_position_mesh(slot_info_id, unit, lerp_position)
									end

								-- When wobble
								elseif entry.type == "wobble" then
									if not unit_good then
										-- Not processed
										entry.finished = true
										entry.end_time = t
									else
										local progress = (entry.end_time - t) / (animation_time / this_animation_speed)
										local anim_progress = math_ease_out_elastic(1 - progress)
										local lerp_position = vector3_lerp(movement, default_position, anim_progress)
										lerp_position = lerp_position - default_position
										lerp_position = lerp_position * 0.1
										lerp_position = lerp_position + default_position
										mod:unit_set_local_position_mesh(slot_info_id, unit, lerp_position)
									end

								-- When wobble alt
								elseif entry.type == "wobble_detach" then
									if not unit_good then
										entry.finished = true
										entry.end_time = t
									else
										local progress = (entry.end_time - t) / (animation_time / this_animation_speed)
										local anim_progress = math_ease_out_elastic(1 - progress)
										local lerp_position = vector3_lerp(default_position, movement, anim_progress)
										lerp_position = lerp_position - movement
										lerp_position = lerp_position * 0.1
										lerp_position = lerp_position + movement
										mod:unit_set_local_position_mesh(slot_info_id, unit, lerp_position)
									end

								end

							-- Change animation state
							elseif entry.end_time and entry.end_time < t then
								-- When detaching
								if entry.type == "detach" then
									if unit_good then
										mod:unit_set_local_position_mesh(slot_info_id, unit, movement)
									end

									-- if not entry.detach_done then
									-- 	mod:play_attachment_sound(mod.cosmetics_view._selected_item, entry.slot, entry.new, "detach")
									entry.detach_done = true
									-- end

									local attachment = entry.new == "default" and mod:get_actual_default_attachment(mod.cosmetics_view._presentation_item, entry.slot) or entry.new
									local attachment_data = mod.attachment_models[mod.cosmetics_view._item_name][attachment]
									local no_animation = attachment_data and attachment_data.no_animation

									if entry.detach_only then
										-- mod:echo("detach only")
										-- mod:unit_hide_meshes(unit, true)
										if wobble then
											entry.end_time = t + (animation_time / this_animation_speed)
											entry.type = "wobble_detach"
										else entry.finished = true end

									elseif all_detach_done and not no_animation then
										entry.end_time = t + (animation_time / this_animation_speed)
										entry.type = "attach"

									elseif all_detach_done then
										if wobble then
											entry.end_time = t + (animation_time / this_animation_speed)
											entry.type = "wobble"
										else entry.finished = true end
									end

								-- When attaching
								elseif entry.type == "attach" then
									if unit_good then
										mod:unit_set_local_position_mesh(slot_info_id, unit, default_position)
									end

									if not entry.attach_done then
										if unit_good then
											mod:preview_flashlight(true, self._world, unit, attachment, true)
										end
										mod:play_attachment_sound(mod.cosmetics_view._presentation_item, entry.slot, entry.new, "attach")
										entry.attach_done = true
									end

									if wobble then
										entry.end_time = t + (animation_time / this_animation_speed)
										entry.type = "wobble"
									else entry.finished = true end

								-- When wobble
								elseif entry.type == "wobble" then
									entry.finished = true

									if unit_good then
										mod:unit_set_local_position_mesh(slot_info_id, unit, default_position)
									end

								-- When wobble alt
								elseif entry.type == "wobble_detach" then
									entry.finished = true

									if unit_good then
										mod:unit_set_local_position_mesh(slot_info_id, unit, movement)
									end

								end
							end
						else
							if mod.weapon_spawning then
								if unit_good then
									mod:unit_set_local_position_mesh(slot_info_id, unit, movement)
								end
								if entry.end_time then entry.end_time = entry.end_time + dt end
							end
						end
					end
					index = index + 1
				end

				-- local count = #entries
				for i, entry in pairs(entries) do
					if entry.detach_done then
						if entry.callback then entry.callback() end
					end
					if entry.type == "attach" and not entry.attach_load then
						mod:load_new_attachment(mod.cosmetics_view._presentation_item, entry.slot, entry.new, true)
						entry.attach_load = true
					end
					-- if not entry.update_done and entry.finished then
					-- 	mod:load_new_attachment(weapon_spawn_data.item, entry.slot, entry.new, true)
					-- 	entry.update_done = true
					-- 	if entry.callback then entry.callback() end
					-- end
				end

				-- -- Detach done?
				-- local detach_done = 0
				-- for i, entry in pairs(entries) do
				-- 	if entry.update_done then
				-- 		detach_done = detach_done + 1
				-- 	end
				-- end

				-- if all_detach_done and mod.weapon_part_animation_update then
				-- 	if entries and #entries > 0 and entries[1] and entries[1].new and string_find(entries[1].new, "default") then
				-- 		mod:start_weapon_move()
				-- 		-- mod.new_rotation = 0
				-- 		-- mod.do_rotation = true
				-- 	end
				-- 	mod:load_new_attachment(weapon_spawn_data.item)
				-- 	mod.weapon_part_animation_update = nil
				-- end
				-- if all_detach_done then
				-- 	mod.cosmetics_view._visibility_toggled_on = false
				-- 	mod.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
				-- end

				if all_detach_done and mod.weapon_part_animation_update then
					-- if entries and #entries > 0 and entries[1] and entries[1].new and string_find(entries[1].new, "default") then
					-- 	mod:start_weapon_move()
					-- 	-- mod.new_rotation = 0
					-- 	-- mod.do_rotation = true
					-- end
					mod:load_new_attachment(weapon_spawn_data.item)
					mod.weapon_part_animation_update = nil
				end

				-- -- Remove finished weapon part animations
				-- if not mod.weapon_part_animation_update and #entries > 0 then
				-- 	for i, entry in pairs(entries) do
				-- 		if entry.finished and entry.update_done then
				-- 			table_remove(mod.weapon_part_animation_entries, i)
				-- 		end
				-- 	end
				-- 	if #entries == 0 then
				-- 		mod.cosmetics_view._visibility_toggled_on = false
				-- 		mod.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
				-- 	end
				-- end

				if all_finished then
					mod.weapon_part_animation_entries = {}
					mod.cosmetics_view._visibility_toggled_on = false
					mod.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
				end

				mod:update_equip_button()
				mod:update_reset_button()
				mod:update_randomize_button()
			end
		end

		-- if mod.cosmetics_view and mod.cosmetics_view._fade_system and self._camera then
		-- 	local fade_position = camera_world_position(self._camera)
		-- 	Fade.update(mod.cosmetics_view._fade_system, fade_position or vector3_zero())
		-- end
	end

end)

mod:hook(CLASS.UIWeaponSpawner, "_update_input_rotation", function(func, self, dt, ...)
	local weapon_spawn_data = self._weapon_spawn_data
	if not weapon_spawn_data then
		return
	end
	if not self._is_rotating and self._rotation_angle ~= self._default_rotation_angle and mod.dropdown_open then
		local rotation_angle = math_lerp(self._rotation_angle, self._default_rotation_angle, dt)
		self:_set_rotation(rotation_angle)
	end
end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	if self._reference_name == "WeaponIconUI" then
		force_highest_mip = false
	else
		force_highest_mip = true
	end
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)
	local weapon_spawn_data = self._weapon_spawn_data

	if weapon_spawn_data and mod.cosmetics_view and self._reference_name ~= "WeaponIconUI" then
		local item_name = mod.cosmetics_view._item_name
		local link_unit = weapon_spawn_data.link_unit

		mod.weapon_spawning = true

		unit_set_unit_visibility(weapon_spawn_data.item_unit_3p, true, true)

		mod:hide_bullets(weapon_spawn_data.attachment_units_3p)

		local flashlight = mod:get_attachment_slot_in_attachments(weapon_spawn_data.attachment_units_3p, "flashlight")
		local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
		if flashlight then
			mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
		end


		local t = managers.time:time("main")
		local start_seed = self._auto_spin_random_seed
		if not start_seed then
			return 0, 0
		end
		local progress_speed = 0.3
		local progress_range = 0.3
		local progress = math_sin((start_seed + t) * progress_speed) * progress_range
		local auto_tilt_angle = -(progress * 0.5)
		local auto_turn_angle = -(progress * math_pi * 0.25)

		local start_angle = self._rotation_angle or 0
		local rotation = quaternion_axis_angle(vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + start_angle))
		if link_unit then

			local initial_rotation = weapon_spawn_data.rotation and quaternion_unbox(weapon_spawn_data.rotation)

			if initial_rotation then
				rotation = quaternion_multiply(rotation, initial_rotation)
			end

			unit_set_local_rotation(link_unit, 1, rotation)

			if not self._link_unit_base_position_backup then
				self._link_unit_base_position_backup = vector3_box(unit_local_position(link_unit, 1))
			end

			if self._last_item_name and self._last_item_name ~= item_name then
				mod.do_reset = nil
				mod.reset_start = nil
				mod.move_end = nil
				mod.do_move = nil
				mod.last_move_position = nil
				mod.move_position = nil
			end
			
			if mod.attachment_models[item_name] and mod.attachment_models[item_name].customization_default_position then
				local position = vector3_unbox(mod.attachment_models[item_name].customization_default_position)
				unit_set_local_position(link_unit, 1, unit_local_position(link_unit, 1) + position)
			else
				unit_set_local_position(link_unit, 1, vector3_unbox(self._link_unit_base_position_backup))
			end

			if not self._link_unit_base_position then
				self._link_unit_base_position = vector3_box(unit_local_position(link_unit, 1))
			end

			if mod.link_unit_position then
				local position = vector3_unbox(mod.link_unit_position)
				unit_set_local_position(link_unit, 1, position)
			end

			self._link_unit_position = vector3_box(unit_local_position(link_unit, 1))
			self._last_item_name = item_name

			mod:set_light_positions(self)
		end

		Unit.set_vector3_for_materials(weapon_spawn_data.item_unit_3p, "stimmed_color", vector3(1, 0, 0), true)

		local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
		slot_infos[mod.cosmetics_view._slot_info_id].unit_default_position = slot_infos[mod.cosmetics_view._slot_info_id].unit_default_position or {}
		slot_infos[mod.cosmetics_view._slot_info_id].unit_default_position["root"] = vector3_box(unit_local_position(weapon_spawn_data.item_unit_3p, 1))
	end
end)

--#region Old
	-- mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, ...)
	-- 	func(self, item_unit_3p, ...)
	-- 	-- mod.preview_flashlight_state = false
	-- 	local weapon_spawn_data = self._weapon_spawn_data
	-- 	if weapon_spawn_data and mod.cosmetics_view and self._reference_name ~= "WeaponIconUI" then
	-- 		mod.weapon_spawning = nil
	-- 		weapon_spawn_data.streaming_complete = true
			



	-- 		-- mod:map_out_unit(item_unit_3p)
	-- 		-- if not mod:weapon_part_animation_exists("flashlight") then
	-- 		-- 	local attachment_units_3p = weapon_spawn_data.attachment_units_3p
	-- 		-- 	local slot_info_id = mod.cosmetics_view._slot_info_id
	-- 		-- 	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	-- 		-- 	local gear_info = slot_infos[slot_info_id]
	-- 		-- 	for i = #attachment_units_3p, 1, -1 do
	-- 		-- 		local unit = attachment_units_3p[i]
	-- 		-- 		if unit and unit_alive(unit) then
	-- 		-- 			local attachment_name = gear_info.unit_to_attachment_name[unit]
	-- 		-- 			-- mod:preview_flashlight(true, false, self._world, unit, attachment_name)
	-- 		-- 		end
	-- 		-- 	end
	-- 		-- end
			
	-- 	end
	-- end)
--#endregion

mod:hook(CLASS.UIWeaponSpawner, "_despawn_current_weapon", function(func, self, ...)
	-- if mod.preview_laser then
	-- 	World.destroy_particles(self._world, mod.preview_laser)
	-- 	mod.preview_laser = nil
	-- end
	func(self, ...)
end)

mod.ui_weapon_spawner_cb_on_unit_3p_streaming_complete = function(self, ui_weapon_spawner)

end

mod.ui_weapon_spawner_despawn_weapon = function(self, ui_weapon_spawner)
	local weapon_spawn_data = ui_weapon_spawner._weapon_spawn_data
	if weapon_spawn_data then
		local item_unit_3p = weapon_spawn_data.item_unit_3p
		local attachment_units_3p = weapon_spawn_data.attachment_units_3p
		for i = #attachment_units_3p, 1, -1 do
			local unit = attachment_units_3p[i]
			if unit and unit_alive(unit) then
				-- if mod.cosmetics_view and mod.cosmetics_view._fade_system then
				-- 	Fade.unregister_unit(mod.cosmetics_view._fade_system, unit)
				-- end
				world_unlink_unit(ui_weapon_spawner._world, unit)
			end
		end
		if item_unit_3p and unit_alive(item_unit_3p) then
			world_unlink_unit(ui_weapon_spawner._world, item_unit_3p)
		end
	end
end

-- ##### ┌─┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐┌─┐ #######################################################################################
-- ##### └─┐├┤  │  │ │││││ ┬└─┐ #######################################################################################
-- ##### └─┘└─┘ ┴  ┴ ┴┘└┘└─┘└─┘ #######################################################################################

mod.get_changed_weapon_settings = function(self)
	if self.cosmetics_view._gear_id then
		self.changed_weapon_settings = {}
		local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
		for _, attachment_slot in pairs(attachment_slots) do
			if not table_contains(self.automatic_slots, attachment_slot) then
				self.changed_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
			end
		end
	end
end

-- ##### ┬ ┬┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ##############################################################################
-- ##### │ ││  ├┤ │ │││││   │ ││ ││││└─┐ ##############################################################################
-- ##### └─┘┴  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ##############################################################################

mod.check_unsaved_changes = function(self, no_animation)
	if table_size(self.original_weapon_settings) > 0 then
		if self.cosmetics_view._gear_id then
			if no_animation then
				for attachment_slot, value in pairs(self.original_weapon_settings) do
					self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, value)
				end
			else
				local attachment_slots = self:get_item_attachment_slots(self.cosmetics_view._selected_item)
				local original_weapon_settings = table_clone(self.original_weapon_settings)
				local attachment_names = {}
				table_reverse(original_weapon_settings)
				for attachment_slot, value in pairs(original_weapon_settings) do
					attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
				end

				-- self.weapon_part_animation_entries = {}
				self.weapon_part_animation_update = true
				for attachment_slot, value in pairs(original_weapon_settings) do
					self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value)
				end

				-- for attachment_slot, value in pairs(original_weapon_settings) do
				-- 	if mod.add_custom_attachments[attachment_slot] then
				-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
				-- 	end
				-- end
				-- for attachment_slot, value in pairs(original_weapon_settings) do
				-- 	if not mod.add_custom_attachments[attachment_slot] then
				-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
				-- 	end
				-- end
			end
			self.original_weapon_settings = {}
		end
		self:update_equip_button()
	end
end

mod.cb_on_demo_pressed = function(self)
	self.demo = not self.demo
	self.demo_time = 1
	self.demo_timer = 0
	self.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
	self:start_weapon_move(vector3_box(vector3(-.15, -1, 0)))
end

mod.cb_on_randomize_pressed = function(self, skip_animation)
	local random_attachments = self:randomize_weapon(self.cosmetics_view._selected_item)
	local skip_animation = skip_animation or not self:get("mod_option_weapon_build_animation")

	if self.cosmetics_view._gear_id and random_attachments then
		-- mod:dtf(random_attachments, "random_attachments", 2)
		local attachment_names = {}
		-- table_reverse(random_attachments)
		for attachment_slot, value in pairs(random_attachments) do
			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
		end
		local index = 1
		-- self.weapon_part_animation_entries = {}
		for attachment_slot, value in pairs(random_attachments) do
			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment_names[attachment_slot]]
			-- local no_animation = attachment_data and attachment_data.no_animation
			if not skip_animation then
				self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], value, nil, nil, true)
				self.weapon_part_animation_update = true
			else
				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, value, index < table_size(random_attachments))
			end
			index = index + 1
		end
		-- for attachment_slot, value in pairs(random_attachments) do
		-- 	self:resolve_special_changes(self.cosmetics_view._presentation_item, value)
		-- end
		-- -- Auto equip
		-- for attachment_slot, value in pairs(random_attachments) do
		-- 	if not mod.add_custom_attachments[attachment_slot] then
		-- 		mod:resolve_auto_equips(self.cosmetics_view._presentation_item, value)
		-- 	end
		-- end
		-- for attachment_slot, value in pairs(random_attachments) do
		-- 	if mod.add_custom_attachments[attachment_slot] then
		-- 		mod:resolve_auto_equips(self.cosmetics_view._presentation_item, value)
		-- 	end
		-- end
		-- -- Special
		-- for attachment_slot, value in pairs(random_attachments) do
		-- 	if mod.add_custom_attachments[attachment_slot] then
		-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
		-- 	end
		-- end
		-- for attachment_slot, value in pairs(random_attachments) do
		-- 	if not mod.add_custom_attachments[attachment_slot] then
		-- 		mod:resolve_special_changes(self.cosmetics_view._presentation_item, value)
		-- 	end
		-- end
		
		-- if not skip_animation then self.weapon_part_animation_update = true end
	end
end

-- mod.purge_weapon_settings = function(self, gear_id)
-- 	for _, attachment_slot in pairs(self.attachment_slots) do
-- 		self:set_gear_setting(gear_id, attachment_slot, nil)
-- 	end
-- end

mod.cb_on_reset_pressed = function(self, skip_animation)
	if self.cosmetics_view._gear_id and table_size(self.changed_weapon_settings) > 0 then
		local skip_animation = skip_animation or not self:get("mod_option_weapon_build_animation")

		local changed_weapon_settings = table_clone(self.changed_weapon_settings)
		local attachment_names = {}
		-- table_reverse(changed_weapon_settings)
		for attachment_slot, value in pairs(changed_weapon_settings) do
		-- for _, attachment_slot in pairs(self.attachment_slots) do
			attachment_names[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
		end
		local index = 1
		-- self.weapon_part_animation_entries = {}
		for attachment_slot, value in pairs(changed_weapon_settings) do
			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment_names[attachment_slot]]
			-- local no_animation = attachment_data and attachment_data.no_animation
			if not skip_animation then
				self:detach_attachment(self.cosmetics_view._selected_item, attachment_slot, attachment_names[attachment_slot], "default")
			else
				self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, "default", index < #self.attachment_slots)
			end
			index = index + 1
		end
		-- Auto equip
		for attachment_slot, value in pairs(changed_weapon_settings) do
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
			end
		end
		for attachment_slot, value in pairs(changed_weapon_settings) do
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_auto_equips(self.cosmetics_view._presentation_item, "default")
			end
		end
		-- Special
		for attachment_slot, value in pairs(changed_weapon_settings) do
			if mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
			end
		end
		for attachment_slot, value in pairs(changed_weapon_settings) do
			if not mod.add_custom_attachments[attachment_slot] then
				mod:resolve_special_changes(self.cosmetics_view._presentation_item, "default")
			end
		end
		self.weapon_part_animation_update = true
		-- if not skip_animation then mod.weapon_part_animation_update = true end

		self.reset_weapon = true
		self:start_weapon_move()
		self.new_rotation = 0
		self.do_rotation = true
	end
end

mod.update_randomize_button = function(self)
	local button = self.cosmetics_view._widgets_by_name.randomize_button
	local button_content = button.content
	local disabled = #self.weapon_part_animation_entries > 0
	button_content.hotspot.disabled = disabled
end

mod.update_equip_button = function(self)
	if self.cosmetics_view._selected_tab_index == 3 then
		local button = self.cosmetics_view._widgets_by_name.equip_button
		local button_content = button.content
		local disabled = table_size(self.original_weapon_settings) == 0 or #self.weapon_part_animation_entries > 0
		button_content.hotspot.disabled = disabled
		button_content.text = utf8_upper(disabled and localize("loc_weapon_inventory_equipped_button") or localize("loc_weapon_inventory_equip_button"))
	end
end

mod.update_reset_button = function(self)
	local button = self.cosmetics_view._widgets_by_name.reset_button
	local button_content = button.content
	local disabled = table_size(self.changed_weapon_settings) == 0 or #self.weapon_part_animation_entries > 0
	button_content.hotspot.disabled = disabled
	button_content.text = utf8_upper(disabled and self:localize("loc_weapon_inventory_no_reset_button") or self:localize("loc_weapon_inventory_reset_button"))
end

mod.update_dropdown = function(self, widget, input_service, dt, t)
	local content = widget.content
	local entry = content.entry
	local value = entry.get_function and entry:get_function() or content.internal_value or "<not selected>"
	local selected_option = content.options[content.selected_index]

	if content.close_setting then
		content.close_setting = nil

		self:release_attachment_packages()
		
		local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
		if content.reset and ui_weapon_spawner._weapon_spawn_data then
			content.reset = nil
			mod.dropdown_positions[entry.attachment_slot][3] = false
			local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
			local unit = self:get_attachment_slot_in_attachments(attachment_units_3p, entry.attachment_slot)
			if unit then self:unit_hide_meshes(unit, false) end
			if attachment_units_3p then self:execute_hide_meshes(self.cosmetics_view._presentation_item, attachment_units_3p) end
			-- self.weapon_part_animation_entries = {}
			self.weapon_part_animation_update = true
			self:detach_attachment(self.cosmetics_view._presentation_item, entry.attachment_slot, nil, selected_option.value, nil, nil, nil, "attach")
			self:start_weapon_move()
		end

		content.exclusive_focus = false
		local hotspot = content.hotspot or content.button_hotspot

		if hotspot then
			hotspot.is_selected = false
		end
		self.dropdown_open = false
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = ""

		return
	end

	self.dropdown_positions[entry.attachment_slot] = self.dropdown_positions[entry.attachment_slot] or {}
	self.dropdown_positions[entry.attachment_slot][3] = (not self.dropdown_open and content.hotspot.is_hover) or content.hotspot.is_selected

	if (content.hotspot.is_hover or content.hotspot.is_selected) and not self.dropdown_open and self.weapon_part_animation_entries and #self.weapon_part_animation_entries == 0 then
		mod.dropdown_positions[entry.attachment_slot][3] = true
		local weapon_attachments = self.attachment_models[self.cosmetics_view._item_name]
		local attachment_data = weapon_attachments[value]
		local new_angle = attachment_data and attachment_data.angle or 0
		self.do_rotation = true
		self.new_rotation = new_angle
		self.attachment_preview_index = content.selected_index
	-- else
	-- 	mod.dropdown_positions[entry.attachment_slot][3] = false
	end

	local is_disabled = entry.disabled or false
	content.disabled = is_disabled or #self.weapon_part_animation_entries > 0
	local size = {
		400,
		dropdown_height
	}
	local using_gamepad = not managers.ui:using_cursor_navigation()
	local offset = widget.offset
	local style = widget.style
	local options = content.options
	local options_by_id = content.options_by_id
	local num_visible_options = content.num_visible_options
	local num_options = #options
	local focused = content.exclusive_focus and not is_disabled

	if focused then
		offset[3] = 90
	else
		offset[3] = 0
	end

	local selected_index = content.selected_index
	local new_value, real_value = nil, nil
	local hotspot = content.hotspot
	local hotspot_style = style.hotspot

	if selected_index and focused then
		if using_gamepad and hotspot.on_pressed then
			new_value = options[selected_index].id
			real_value = options[selected_index].value
		end

		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_in_sound
	else
		hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_out_sound
	end

	

	local localization_manager = managers.localization
	local preview_option = options_by_id[value]
	local preview_option_id = preview_option and preview_option.id
	local preview_value = preview_option and preview_option.display_name or "loc_settings_option_unavailable"
	local ignore_localization = preview_option and preview_option.ignore_localization
	content.value_text = ignore_localization and preview_value or localization_manager:localize(preview_value)
	local always_keep_order = true
	local grow_downwards = content.grow_downwards
	local new_selection_index = nil

	if not selected_index or not focused then
		for i = 1, #options do
			local option = options[i]

			if option.id == preview_option_id then
				selected_index = i

				break
			end
		end

		selected_index = selected_index or 1
	end

	if selected_index and focused then
		if input_service:get("navigate_up_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_max(selected_index - 1, 1)
			else
				new_selection_index = math_min(selected_index + 1, num_options)
			end
		elseif input_service:get("navigate_down_continuous") then
			if grow_downwards or not grow_downwards and always_keep_order then
				new_selection_index = math_min(selected_index + 1, num_options)
			else
				new_selection_index = math_max(selected_index - 1, 1)
			end
		end
	end

	if new_selection_index or not content.selected_index then
		if new_selection_index then
			selected_index = new_selection_index
		end

		if num_visible_options < num_options then
			local step_size = 1 / num_options
			local new_scroll_percentage = math_min(selected_index - 1, num_options) * step_size
			content.scroll_percentage = new_scroll_percentage
			content.scroll_add = nil
		end

		content.selected_index = selected_index
	end

	local scroll_percentage = content.scroll_percentage

	if scroll_percentage then
		local step_size = 1 / (num_options - (num_visible_options - 1))
		content.start_index = math_max(1, math_ceil(scroll_percentage / step_size))
	end

	local option_hovered = false
	local option_index = 1
	local start_index = content.start_index or 1
	local end_index = math_min(start_index + num_visible_options - 1, num_options)
	local using_scrollbar = num_visible_options < num_options

	for i = start_index, end_index do
		local actual_i = i

		if not grow_downwards and always_keep_order then
			actual_i = end_index - i + start_index
		end

		local option_text_id = "option_text_" .. option_index
		local option_hotspot_id = "option_hotspot_" .. option_index
		local outline_style_id = "outline_" .. option_index
		local option_hotspot = content[option_hotspot_id]
		option_hovered = option_hovered or option_hotspot.is_hover
		option_hotspot.is_selected = actual_i == selected_index
		local option = options[actual_i]

		if option_hotspot.is_hover then
			
			-- entry.original_value = entry.original_value or value
			entry.preview_attachment = entry.preview_attachment or option.value
			if entry.preview_attachment ~= option.value then
				local weapon_attachments = self.attachment_models[self.cosmetics_view._item_name]
				-- local attachment_name = self:attachment_
				local attachment_data = weapon_attachments[option.value]
				local new_angle = attachment_data and attachment_data.angle or 0
				self.do_rotation = true
				self.new_rotation = new_angle + 1 * (actual_i / #options) - .5

				-- self.weapon_part_animation_entries = {}
				mod.dropdown_positions[entry.attachment_slot][3] = true
				mod.attachment_preview_index = actual_i
				if attachment_data and attachment_data.move then self:start_weapon_move(attachment_data.move) end
				entry.preview_attachment = option.value

				self:set_attachment_info(option.display_name, attachment_data.data)
			end
		end

		if option_hotspot.on_pressed and not option.disabled then
			if self.weapon_part_animation_entries and #self.weapon_part_animation_entries == 0 then
				option_hotspot.on_pressed = nil
				new_value = option.id
				real_value = option.value
				content.selected_index = actual_i
				self.dropdown_closing = true
				content.option_disabled = false
				mod.dropdown_positions[entry.attachment_slot][3] = false
			end
		elseif option_hotspot.on_pressed and option.disabled then
			content.option_disabled = true
		end

		local option_display_name = option.display_name
		local option_ignore_localization = option.ignore_localization
		content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
		local options_y = size[2] * option_index
		style[option_hotspot_id].offset[2] = grow_downwards and options_y or -options_y
		style[option_hotspot_id].on_pressed_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_hotspot_id].on_pressed_fold_in_sound = not option.disabled and "wwise/events/ui/play_ui_click"
		style[option_text_id].offset[2] = grow_downwards and options_y or -options_y
		local entry_length = using_scrollbar and size[1] - style.scrollbar_hotspot.size[1] or size[1]
		style[outline_style_id].size[1] = not option.disabled and entry_length or 0
		style[outline_style_id].visible = not option.disabled
		style[option_text_id].size[1] = not option.disabled and size[1] or 0
		style["text"].size[1] = size[1]
		-- style["text"].horizontal_alignment = "left"
		-- style["text"].text_horizontal_alignment = "right"
		-- style["text"].size[1] = size[1] * 1.2
		style["text"].offset[1] = size[1] * .025
		style["text"].offset[3] = 20
		option_index = option_index + 1
	end

	local value_changed = new_value ~= nil

	if value_changed and new_value ~= value then
		local on_activated = entry.on_activated

		self.reset_start = nil
		self.do_reset = nil

		on_activated(new_value, entry)
	-- elseif self.dropdown_positions[entry.attachment_slot][3] and not value_changed and #self.weapon_part_animation_entries == 0 then
	-- 	local attachment_data = self.attachment_models[self.cosmetics_view._item_name][value]
	-- 	if attachment_data then
	-- 		local rotation = attachment_data.angle or 0
	-- 		if self._last_rotation_angle ~= rotation then
	-- 			-- mod.do_rotation = true
	-- 			-- mod.new_rotation = rotation
	-- 			self.cosmetics_view._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation
	-- 		end
	-- 		self.reset_start = t + .1
	-- 	end
	end

	local scrollbar_hotspot = content.scrollbar_hotspot
	local scrollbar_hovered = scrollbar_hotspot.is_hover

	if (input_service:get("left_pressed") or input_service:get("confirm_pressed") or input_service:get("back")) and content.exclusive_focus and not content.wait_next_frame then
		if self.weapon_part_animation_entries and #self.weapon_part_animation_entries == 0 then
			content.wait_next_frame = true
			content.reset = true

			return
		end
	end

	if content.wait_next_frame and not content.option_disabled then
		content.wait_next_frame = nil
		content.close_setting = true
		self.dropdown_open = false
		self.dropdown_closing = false

		return
	elseif content.wait_next_frame and content.option_disabled then
		content.option_disabled = nil
		content.wait_next_frame = nil

		return
	end
end

mod.update_custom_widgets = function(self, input_service, dt, t)
    if self.cosmetics_view and self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
            if widget.content and widget.content.entry and widget.content.entry.widget_type == "dropdown" then
				local pivot_name = widget.name.."_pivot"
				pivot_name = string_gsub(pivot_name, "_custom", "")
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[pivot_name]
				local any_active = false
				for _, data in pairs(mod.dropdown_positions) do
					if data[3] == true then
						any_active = true
						break
					end
				end
				local entry = self.dropdown_positions[widget.content.entry.attachment_slot]
				local text = self.cosmetics_view._widgets_by_name[widget.content.entry.attachment_slot.."_custom_text"]
				local active = entry and entry[3]
				if active or not any_active or not entry then
					widget.alpha_multiplier = math_lerp(widget.alpha_multiplier, 1, dt * 2)
					text.alpha_multiplier = widget.alpha_multiplier
				else
					widget.alpha_multiplier = math_lerp(widget.alpha_multiplier, .25, dt * 2)
					text.alpha_multiplier = widget.alpha_multiplier
				end
				if scenegraph_entry and scenegraph_entry.position then
					if scenegraph_entry.position[2] > grid_size[2] / 2 then
						widget.content.grow_downwards = false
					else
						widget.content.grow_downwards = true
					end
				end
                self:update_dropdown(widget, input_service, dt, t)
            end
        end
    end
end

mod.hide_custom_widgets = function(self, hide)
    if self.cosmetics_view and self.cosmetics_view._custom_widgets then
        for _, widget in pairs(self.cosmetics_view._custom_widgets) do
			if not widget.not_applicable then
            	widget.visible = not hide
			else
				widget.visible = false
			end
        end
		if self.cosmetics_view._custom_widgets_overlapping > 0 then
			self.cosmetics_view._widgets_by_name.panel_extension.visible = not hide
		else
			self.cosmetics_view._widgets_by_name.panel_extension.visible = false
		end
		self.cosmetics_view._widgets_by_name.reset_button.visible = not hide
		self.cosmetics_view._widgets_by_name.randomize_button.visible = not hide
		self.cosmetics_view._widgets_by_name.demo_button.visible = false --not hide
    end
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ #######################################################################
-- ##### └┐┌┘│├┤ │││  ├┤ │ │││││   │ ││ ││││└─┐ #######################################################################
-- #####  └┘ ┴└─┘└┴┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ #######################################################################

mod.validate_item_model = function(self, model)
	self:setup_item_definitions()
	if model ~= "" then
		local definition = mod:persistent_table(REFERENCE).item_definitions[model]
		if definition then
			if definition.workflow_state ~= "RELEASABLE" then
				return false
			end
			if table_find(definition.feature_flags, "FEATURE_unreleased_premium_cosmetics") then
				return false
			end
			-- if table_find(definition.feature_flags, "FEATURE_premium_store") and 
			-- 		not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
			-- if not table_find(definition.feature_flags, "FEATURE_item_retained") then
			-- 	return false
			-- end
		end
	end
	return true
end

mod.generate_dropdown_option = function(self, id, display_name, sounds)
    return {
        id = id,
        display_name = display_name,
        ignore_localization = true,
        value = id,
		sounds = sounds,
		disabled = false,
    }
end

mod.add_custom_widget = function(self, widget)
	widget.custom = true
	self.cosmetics_view._custom_widgets[#self.cosmetics_view._custom_widgets+1] = widget
end

mod.generate_custom_widgets = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Iterate scenegraphs additions
		for _, added_scenegraph in pairs(self.added_cosmetics_scenegraphs) do
			-- Differentiate text and dropdown
			if string_find(added_scenegraph, "text_pivot") then
				-- Generate label
				local attachment_slot = string_gsub(added_scenegraph, "_text_pivot", "")
				self:add_custom_widget(self:generate_label(added_scenegraph, attachment_slot, item))
			else
				-- Generate dropdown
				local attachment_slot = string_gsub(added_scenegraph, "_pivot", "")
				self:add_custom_widget(self:generate_dropdown(added_scenegraph, attachment_slot, item))
			end
		end
	end
end

mod.resolve_not_applicable_attachments = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		local move = 0
		-- Iterate attachment slots
		for index, slot in pairs(self.attachment_slots) do
			-- Check that weapon has attachment slot and more than 2 options
			-- 1st option is default
			if self.attachment[item_name] and (not self.attachment[item_name][slot] or #self.attachment[item_name][slot] <= 2)
					and not table_contains(mod.attachment_slots_show_always, slot) then
				-- Set not applicable in widgets to hide them
				self.cosmetics_view._widgets_by_name[slot.."_custom"].not_applicable = true
				self.cosmetics_view._widgets_by_name[slot.."_custom_text"].not_applicable = true
				-- Add to list of not applicable widgets
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_pivot"
				self.cosmetics_view._not_applicable[#self.cosmetics_view._not_applicable+1] = slot.."_text_pivot"
			end
		end
		-- Move widgets according to their applicable status
		for _, scenegraph_name in pairs(self.added_cosmetics_scenegraphs) do
			if table_contains(self.cosmetics_view._not_applicable, scenegraph_name) then
				-- Differentiate text and dropdown
				if string_find(scenegraph_name, "text_pivot") then
					move = move + label_height
				else
					move = move + dropdown_height
				end
			end
			-- Change scenegraph position
			local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
			if scenegraph_entry then
				scenegraph_entry.local_position[2] = scenegraph_entry.local_position[2] - move
			end
		end
	end
end

mod.resolve_overlapping_widgets = function(self)
	local move = 0
	local overlapping = {}
	-- Iterate scenegraph entries
	for _, scenegraph_entry in pairs(self.added_cosmetics_scenegraphs) do
		-- Make sure attachment slot is applicable
		if not table_contains(self.cosmetics_view._not_applicable, scenegraph_entry) then
			-- Differentiate text and dropdown
			if string_find(scenegraph_entry, "text_pivot") then
				move = move + label_height
			else
				move = move + dropdown_height
			end
			-- Check if widget is overlapping
			if self.cosmetics_view._ui_scenegraph[scenegraph_entry].local_position[2] > grid_size[2] then
				-- Count overlapping attachment slots
				if not string_find(scenegraph_entry, "text_pivot") then
					self.cosmetics_view._custom_widgets_overlapping = self.cosmetics_view._custom_widgets_overlapping + 1
				end
				-- Add overlapping widget to list
				overlapping[#overlapping+1] = scenegraph_entry
			end
		end
	end
	-- Change extension panels size
	local extension_panel_pivot = self.cosmetics_view._ui_scenegraph.panel_extension_pivot
	extension_panel_pivot.size[2] = (85 * self.cosmetics_view._custom_widgets_overlapping) + (edge * 2)
	-- extension_panel_pivot.local_position[1] = grid_size[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	-- extension_panel_pivot.local_position[2] = grid_size[2] - 85 * (self.cosmetics_view._custom_widgets_overlapping + 1)
	-- Change overlapping widgets positions
	local y = -85
	for _, scenegraph_name in pairs(overlapping) do
		local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
		-- position = {-90 -(grid_width / 2), 0, z}
		-- local screen_width = RESOLUTION_LOOKUP.width
		-- local screen_height = RESOLUTION_LOOKUP.height
		local corner_top_right = self.cosmetics_view._ui_scenegraph.corner_top_right.world_position
		local grid_pos = self.cosmetics_view._ui_scenegraph.item_grid_pivot.world_position
		local extension_pos = self.cosmetics_view._ui_scenegraph.panel_extension_pivot.world_position
		if string_find(scenegraph_name, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		scenegraph_entry.position[1] = extension_pos[1] - grid_pos[1] + 35 -- grid_width / 2 - edge --extension_pos[1] - 
		scenegraph_entry.local_position[2] = extension_pos[2] + y
		scenegraph_entry.local_position[3] = 100
		
	end
end

mod.get_dropdown_positions = function(self)
	if self.cosmetics_view then
		for _, scenegraph_name in pairs(self.added_cosmetics_scenegraphs) do
			if not string_find(scenegraph_name, "text_pivot") then
				local screen_width = RESOLUTION_LOOKUP.width
				local attachment_slot = string_gsub(scenegraph_name, "_pivot", "")
				local scenegraph_entry = self.cosmetics_view._ui_scenegraph[scenegraph_name]
				local entry = self.dropdown_positions[attachment_slot] or {}
				if scenegraph_entry.position[1] > screen_width / 2 then
					entry[1] = scenegraph_entry.world_position[1]
				else
					entry[1] = scenegraph_entry.world_position[1] + grid_size[1]
				end
				entry[2] = scenegraph_entry.position[2] + dropdown_height
				entry[3] = entry[3] or false
				self.dropdown_positions[attachment_slot] = entry
			end
		end
	end
end

mod.init_custom_weapon_zoom = function(self)
	local item = self.cosmetics_view._selected_item
	if item then
		-- Get item name
		-- local item_name = self:item_name_from_content_string(item.name)
		local item_name = self.cosmetics_view._item_name
		-- Check for weapon in data
		if self.attachment_models[item_name] then
			-- Check for custom weapon zoom
			if self.attachment_models[item_name].customization_min_zoom then
				local min_zoom = self.attachment_models[item_name].customization_min_zoom
				self.cosmetics_view._min_zoom = min_zoom
			else
				self.cosmetics_view._min_zoom = -2
			end
			-- Set zoom
			self.cosmetics_view._weapon_zoom_target = self.cosmetics_view._min_zoom
			self.cosmetics_view._weapon_zoom_fraction = self.cosmetics_view._min_zoom
			self.cosmetics_view:_set_weapon_zoom(self.cosmetics_view._min_zoom)
		end
	end
end

mod.reset_stuff = function(self)
	self.demo = nil
	self.move_position = nil
	self.new_position = nil
	self.last_move_position = nil
	self.link_unit_position = nil
	self.do_move = nil
	self.move_end = nil
	self.do_reset = nil
	self.reset_start = nil
	self._last_rotation_angle = 0
	self.mesh_positions = {}
	self.weapon_part_animation_update = nil
	self.weapon_part_animation_entries = {}
	self.preview_flashlight_state = false
end

mod.generate_label = function(self, scenegraph, attachment_slot, item)

	-- local weapon_name = self:item_name_from_content_string(item.name)
	local item_name = self.cosmetics_view._item_name
	local style = table_clone(UIFontSettings.grid_title)
	style.offset = {0, 0, 1}
	local text = "loc_weapon_cosmetics_customization_"..attachment_slot

	if self.text_overwrite[item_name] then
		text = self.text_overwrite[item_name][text] or text
	end

    local definition = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = self:localize(text),
            style = style,
        }
    }, scenegraph, nil)

	local widget_name = attachment_slot.."_custom_text"
	local widget = self.cosmetics_view:_create_widget(widget_name, definition)

	self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

	return widget
end

mod.set_attachment_text = function(self, text, subtext)
	if text then
		-- self._widgets_by_name
	end
end

mod.generate_dropdown = function(self, scenegraph, attachment_slot, item)

	local item_name = self.cosmetics_view._item_name
    local options = {}
    if self.attachment[item_name] and self.attachment[item_name][attachment_slot] then
		self.found_names = nil
        for _, data in pairs(self.attachment[item_name][attachment_slot]) do
			local model = self.attachment_models[item_name][data.id] and self.attachment_models[item_name][data.id].model
			if model and self:validate_item_model(model) then
				local attachment_name = self:get_attachment_weapon_name(item, attachment_slot, data.id) or data.name
            	options[#options+1] = self:generate_dropdown_option(data.id, attachment_name, data.sounds)
			end
        end
    end

    local max_visible_options = 10
    local num_options = #options
    local num_visible_options = math_min(num_options, max_visible_options)

    local size = {grid_size[1], dropdown_height}
    local template = DropdownPassTemplates.settings_dropdown(size[1], size[2], size[1], num_visible_options, true)
	for _, pass in pairs(template) do
		if pass.content_id and string_find(pass.content_id, "option_hotspot") then
			-- local s = string_gsub(pass.content_id, "option_hotspot_", "")
			-- local id = tonumber(s)
			-- pass.content.on_hover_sound = UISoundEvents.default_mouse_hover
			-- pass.change_function = function(content, style)
			-- 	if content.was_hover ~= content.is_hover then
			-- 		mod:unhover_attachment(id)
			-- 	end
			-- 	content.was_hover = content.is_hover
			-- end
			pass.visibility_function = function(content)
				return content.parent.anim_exclusive_focus_progress > 0 and not content.disabled
			end
		end
	end
	template[7].pass_type = "texture"
	template[7].value = "content/ui/materials/backgrounds/terminal_basic"
	template[7].style.horizontal_alignment = "center"

    local definition = UIWidget.create_definition(template, scenegraph, nil, size)
    local widget_name = attachment_slot.."_custom"
    local widget = self.cosmetics_view:_create_widget(widget_name, definition)
	widget.alpha_multiplier = 1
    self.cosmetics_view._widgets_by_name[widget_name] = widget
    self.cosmetics_view._widgets[#self.cosmetics_view._widgets+1] = widget

    local content = widget.content
    content.entry = {
		attachment_slot = attachment_slot,
		attachment_name = "-",
        options = options,
        widget_type = "dropdown",
        on_activated = function(new_value, entry)
			if self.weapon_part_animation_entries and #self.weapon_part_animation_entries == 0 then
				local attachment = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, self.cosmetics_view._selected_item)
				local attachment_data = self.attachment_models[item_name][attachment]
				local no_animation = attachment_data and attachment_data.no_animation

				if self:get("mod_option_weapon_build_animation") and not no_animation then
					-- self.weapon_part_animation_entries = {}
					self.weapon_part_animation_update = true
					self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, attachment, new_value, nil, nil, nil, "attach")
				else
					self:load_new_attachment(self.cosmetics_view._selected_item, attachment_slot, new_value)
					self:play_attachment_sound(self.cosmetics_view._selected_item, attachment_slot, new_value, "attach")
				end

				self.reset_weapon = nil

				local weapon_attachments = self.attachment_models[item_name]
				local attachment_data = weapon_attachments[new_value]
				local new_angle = attachment_data.angle or 0

				-- if string_find(new_value, "default") then
				-- 	self.new_rotation = 0
				-- 	self.do_rotation = true
				-- else
				-- 	self.do_rotation = true
				-- 	self.new_rotation = new_angle
				-- end

				-- if attachment_data.move then
				-- 	self:start_weapon_move(attachment_data.move)
				-- else
				-- 	self:start_weapon_move()
				-- end
				self:start_weapon_move()
			end
        end,
        get_function = function()
            return self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
        end,
    }
    local options_by_id = {}
    for index, option in pairs(options) do
        options_by_id[option.id] = option
    end
    content.options_by_id = options_by_id
	content.options = options
    content.num_visible_options = num_visible_options

    content.hotspot.pressed_callback = function ()
		if not self.dropdown_open and not content.disabled then
			if self.weapon_part_animation_entries and #self.weapon_part_animation_entries == 0 then
				if mod:get("mod_option_carousel") then
					local ui_weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
					local attachment_units_3p = ui_weapon_spawner._weapon_spawn_data.attachment_units_3p
					local attachment_unit = attachment_units_3p and mod:get_attachment_slot_in_attachments(attachment_units_3p, attachment_slot)
					local attachment_name = attachment_unit and unit_get_data(attachment_unit, "attachment_name")
					local callback = callback(mod, "create_attachment_array", self.cosmetics_view._selected_item, attachment_slot)
					self.weapon_part_animation_entries = {}
					-- self.weapon_part_animation_update = true
					self:detach_attachment(self.cosmetics_view._presentation_item, attachment_slot, nil, attachment_name, nil, nil, nil, "detach_only", callback)
				end
				local selected_widget = nil
				local selected = true
				content.exclusive_focus = selected
				local hotspot = content.hotspot or content.button_hotspot
				if hotspot then
					hotspot.is_selected = selected
				end
				self.dropdown_open = true
			end
		end
    end

    content.area_length = size[2] * num_visible_options
    local scroll_length = math_max(size[2] * num_options - content.area_length, 0)
    content.scroll_length = scroll_length
    local spacing = 0
    local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
    content.scroll_amount = scroll_amount

    return widget
end

mod.update_attachment_info = function(self)
	local visible = self.cosmetics_view._widgets_by_name.attachment_display_name.content.text ~= ""
	self.cosmetics_view._widgets_by_name.attachment_info_box.visible = false
	self.cosmetics_view._widgets_by_name.attachment_display_name.visible = visible
	if self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_1 then
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_1.visible = visible
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_2.visible = visible
		self.cosmetics_view.bar_breakdown_widgets_by_name.attachment_bar_3.visible = visible
	end
end

mod.set_attachment_info = function(self, display_name, attribute_data)
	if display_name ~= "Default" and attribute_data then
		local tiers = {
			"content/ui/materials/icons/perks/perk_level_01",
			"content/ui/materials/icons/perks/perk_level_02",
			"content/ui/materials/icons/perks/perk_level_03",
			"content/ui/materials/icons/perks/perk_level_04",
			"content/ui/materials/icons/perks/perk_level_05",
		}
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = display_name
		-- for i, data in pairs(attribute_data) do
		local index = 1
		for _, column in pairs(attribute_data) do
			for name, tier in pairs(column) do
				local widgets_by_name = self.cosmetics_view.bar_breakdown_widgets_by_name
				local widget = widgets_by_name["attachment_bar_"..tostring(index)]
				if widget then
					widget.content.text = mod:localize(name)
					widget.content.value_id_1 = tiers[tier]
				end
				index = index + 1
			end
		end
	else
		self.cosmetics_view._widgets_by_name.attachment_display_name.content.text = ""
	end
end

-- ##### ┬  ┬┬┌─┐┬ ┬  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #################################################################################
-- ##### └┐┌┘│├┤ │││  ├─┤│ ││ │├┴┐└─┐ #################################################################################
-- #####  └┘ ┴└─┘└┴┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #################################################################################

mod:hook(CLASS.InventoryWeaponCosmeticsView, "init", function(func, self, settings, context, ...)

	-- Fetch instance
	mod.cosmetics_view = self
	-- Settings
	settings.wwise_states = {
		options = WwiseGameSyncSettings.state_groups.options.none
	}
	-- Original function
	func(self, settings, context, ...)
	-- Custom attributes
	self._custom_widgets = {}
	self._not_applicable = {}
	self._custom_widgets_overlapping = 0
	self._item_name = mod:item_name_from_content_string(self._selected_item.name)
	self._gear_id = mod:get_gear_id(self._presentation_item)
	self._slot_info_id = mod:get_slot_info_id(self._presentation_item)
	-- self._fade_system = Fade.init()
	-- Presets
	-- self._weapon_presets = self:_add_element(ViewElementWeaponPresets, "weapon_presets", 90, nil, "weapon_presets_pivot", {gear_id = self._gear_id})

	self.draw = function(self, dt, t, input_service, layer)
		local render_scale = self._render_scale
		local render_settings = self._render_settings
		local ui_renderer = self._ui_renderer
		local ui_default_renderer = self._ui_default_renderer
		local ui_forward_renderer = self._ui_forward_renderer
		render_settings.start_layer = layer
		render_settings.scale = render_scale
		render_settings.inverse_scale = render_scale and 1 / render_scale
		local ui_scenegraph = self._ui_scenegraph
	
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)
		UIWidget.draw(self._background_widget, ui_renderer)
		UIRenderer.end_pass(ui_renderer)
		UIRenderer.begin_pass(ui_forward_renderer, ui_scenegraph, input_service, dt, render_settings)
		self:_draw_widgets(dt, t, input_service, ui_forward_renderer, render_settings)
		UIRenderer.end_pass(ui_forward_renderer)
		self:_draw_elements(dt, t, ui_forward_renderer, render_settings, input_service)
		self:_draw_render_target()
	end
	-- Overwrite draw elements function
	-- Make view legend inputs visible when UI gets hidden
	self._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
		local old_alpha_multiplier = render_settings.alpha_multiplier
		local alpha_multiplier = self._alpha_multiplier or 1
		local elements_array = self._elements_array
		for i = 1, #elements_array do
			local element = elements_array[i]
			if element then
				local element_name = element.__class_name
				if element_name ~= "ViewElementInventoryWeaponPreview" or element_name ~= "ViewElementInputLegend" then
					ui_renderer = self._ui_default_renderer or ui_renderer
				end
				render_settings.alpha_multiplier = element_name ~= "ViewElementInputLegend" and alpha_multiplier or 1
				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
		render_settings.alpha_multiplier = old_alpha_multiplier
	end

	self._cb_on_ui_visibility_toggled = function (self, id)
		self._visibility_toggled_on = not self._visibility_toggled_on
		local display_name = self._visibility_toggled_on and "loc_menu_toggle_ui_visibility_off" or "loc_menu_toggle_ui_visibility_on"
		self._input_legend_element:set_display_name(id, display_name)
	end

	-- self.set_can_exit = function(self, value, apply_next_frame)
	-- 	if not apply_next_frame then
	-- 		self._can_close = value
	-- 	else
	-- 		self._next_frame_can_close = value
	-- 		self._can_close_frame_counter = 1
	-- 	end
	-- end
	
	self.can_exit = function (self)
		return self._can_close and mod.weapon_part_animation_entries and #mod.weapon_part_animation_entries == 0
	end

end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_enter", function(func, self, ...)
    func(self, ...)

	mod:remove_extension(mod.player_unit, "visible_equipment_system")

	-- Fetch instance
	mod.cosmetics_view = self
	mod.changed_weapon = nil
	self.bar_breakdown_widgets = {}
	self.bar_breakdown_widgets_by_name = {}

    mod:generate_custom_widgets()
	mod:resolve_not_applicable_attachments()
	mod:resolve_overlapping_widgets()
	-- mod:get_dropdown_positions()
	mod:init_custom_weapon_zoom()

	mod.original_weapon_settings = {}
	mod:get_changed_weapon_settings()
	mod:update_reset_button()

    mod:hide_custom_widgets(true)
	mod:resolve_no_support(self._selected_item)
	mod:load_attachment_sounds(self._selected_item)
	-- mod:resolve_auto_equips(self._selected_item)
	mod:create_bar_breakdown_widgets()

	-- mod:dtf(self, "InventoryWeaponCosmeticsView", 20)
	-- local world_name = self._unique_id .. "_ui_forward_world"
	-- local viewport_name = self._unique_id .. "_ui_forward_world_viewport"
	-- WorldRenderUtils.enable_world_fullscreen_blur(world_name, viewport_name, .1)
	-- WorldRenderUtils.disable_world_fullscreen_blur(world_name, viewport_name)

	self._item_grid._widgets_by_name.grid_background.visible = false
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "update", function(func, self, dt, t, input_service, ...)

	if self._selected_tab_index == 3 then
		self._previewed_element = nil
	end

    local pass_input, pass_draw = func(self, dt, t, input_service, ...)

	if mod.cosmetics_view then
		mod:update_custom_widgets(input_service, dt, t)
		mod:update_attachment_info()
		mod:update_equip_button()
		mod:update_reset_button()
	end

	if mod.cosmetics_view and mod.demo then
		local rotation_angle = (mod._last_rotation_angle or 0) + dt
		self._weapon_preview._ui_weapon_spawner._rotation_angle = rotation_angle
		self._weapon_preview._ui_weapon_spawner._default_rotation_angle = rotation_angle
		mod._last_rotation_angle = self._weapon_preview._ui_weapon_spawner._default_rotation_angle
		if mod.demo_timer < t then
			mod:cb_on_randomize_pressed(true)
			mod.demo_timer = t + mod.demo_time
		end
	end

	return pass_input, pass_draw
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_handle_input", function(func, self, input_service, dt, t, ...)
	local zoom_target = self._weapon_zoom_target

	func(self, input_service, dt, t, ...)

	if mod.dropdown_open then
		self._weapon_zoom_target = zoom_target
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_register_button_callbacks", function(func, self, ...)
	func(self, ...)
	local widgets_by_name = self._widgets_by_name
	local reset_button = widgets_by_name.reset_button
	reset_button.content.hotspot.pressed_callback = callback(mod, "cb_on_reset_pressed")
	local randomize_button = widgets_by_name.randomize_button
	randomize_button.content.hotspot.pressed_callback = callback(mod, "cb_on_randomize_pressed")
	local demo_button = widgets_by_name.demo_button
	demo_button.content.hotspot.pressed_callback = callback(mod, "cb_on_demo_pressed")
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_set_weapon_zoom", function(func, self, fraction, ...)
	if not mod.dropdown_open then
		func(self, fraction, ...)
	end
end)

--#region Old
	-- mod.draw_bar_breakdown_widgets = function(self, dt, t, input_service, render_settings)
	-- 	local ui_scenegraph = self._ui_scenegraph
	-- 	local ui_renderer = self._ui_grid_renderer

	-- 	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)

	-- 	local bar_breakdown_widgets = self._bar_breakdown_widgets

	-- 	for _, widget in ipairs(bar_breakdown_widgets) do
	-- 		UIWidget.draw(widget, ui_renderer)
	-- 	end

	-- 	UIRenderer.end_pass(ui_renderer)
	-- end
--#endregion

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
	local always_visible_widget_names = self._always_visible_widget_names
	local alpha_multiplier = self._render_settings and self._render_settings.alpha_multiplier or 1
	local anim_alpha_speed = 3

	if self._visibility_toggled_on then
		alpha_multiplier = math_min(alpha_multiplier + dt * anim_alpha_speed, 1)
	else
		alpha_multiplier = math_max(alpha_multiplier - dt * anim_alpha_speed, 0)
	end

	local always_visible_widget_names = self._always_visible_widget_names
	self._alpha_multiplier = alpha_multiplier
	local widgets = self._widgets
	local num_widgets = #widgets

	UIRenderer.begin_pass(ui_renderer, self._ui_scenegraph, input_service, dt, self._render_settings)

	for i = 1, num_widgets do
		local widget = widgets[i]
		local widget_name = widget.name
		self._render_settings.alpha_multiplier = always_visible_widget_names[widget_name] and 1 or alpha_multiplier

		UIWidget.draw(widget, ui_renderer)
	end

	mod:get_dropdown_positions()
	mod:draw_equipment_lines(dt, t)

	local bar_breakdown_widgets = self.bar_breakdown_widgets

	if bar_breakdown_widgets then
		for _, widget in ipairs(bar_breakdown_widgets) do
			UIWidget.draw(widget, ui_renderer)
		end
	end

	UIRenderer.end_pass(ui_renderer)
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "on_exit", function(func, self, ...)

	mod:reset_stuff()
	
	local weapon_spawner = self._weapon_preview._ui_weapon_spawner
	local default_position = weapon_spawner._link_unit_base_position
	weapon_spawner._link_unit_position = default_position
	weapon_spawner._rotation_angle = 0
	weapon_spawner._default_rotation_angle = 0

	if weapon_spawner._weapon_spawn_data then
		local link_unit = weapon_spawner._weapon_spawn_data.link_unit
		unit_set_local_position(link_unit, 1, vector3_unbox(default_position))
	end

	mod:check_unsaved_changes(true)
	mod:release_attachment_sounds()

	func(self, ...)

	mod.cosmetics_view = nil
	mod.reset_weapon = nil
	-- Fade.destroy(self._fade_system)
end)

mod.attachment_package_snapshot = function(self, item, test_data)
    local packages = test_data or {}
    if not test_data then
        local attachments = item.__master_item.attachments
        ItemPackage._resolve_item_packages_recursive(attachments, MasterItems.get_cached(), packages)
    end
    if self.old_package_snapshot then
        self.new_package_snapshot = packages
        return self:attachment_package_resolve()
    else
        self.old_package_snapshot = packages
    end
end

mod.attachment_package_resolve = function(self)
    if self.old_package_snapshot and self.new_package_snapshot then
        local old_packages = {}
        for name, _ in pairs(self.old_package_snapshot) do
            if not self.new_package_snapshot[name] then
                old_packages[#old_packages+1] = name
            end
        end
        local new_packages = {}
        for name, _ in pairs(self.new_package_snapshot) do
            if not self.old_package_snapshot[name] then
                new_packages[#new_packages+1] = name
            end
        end
        self.old_package_snapshot = nil
        self.new_package_snapshot = nil
        return old_packages, new_packages
    end
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_on_equip_pressed", function(func, self, ...)
	if self._selected_tab_index == 3 then
		mod.original_weapon_settings = {}
		mod.just_changed = {}
		mod:update_equip_button()

		mod:attachment_package_snapshot(self._selected_item)

		local old_packages, new_packages = mod:attachment_package_snapshot(self._presentation_item)
		if new_packages and #new_packages > 0 then
			local weapon_spawner = self._weapon_preview._ui_weapon_spawner
			local reference_name = weapon_spawner._reference_name .. "_weapon_item_loader_" .. tostring(weapon_spawner._weapon_loader_index)
			for _, new_package in pairs(new_packages) do
				managers.package:load(new_package, reference_name, nil, true)
			end
		end

		local package_synchronizer_client = managers.package_synchronization:synchronizer_client()
		if package_synchronizer_client then
			package_synchronizer_client:reevaluate_all_profiles_packages()
		end

		mod:redo_weapon_attachments(self._presentation_item)
		-- local new_item = self._presentation_item.__master_item or self._presentation_item
		-- new_item.item_type = self._selected_item.item_type
		-- new_item.gear_id = self._selected_item.gear_id
		-- new_item.name = self._selected_item.name

		-- mod:get_dropdown_positions()
		-- mod:get_changed_weapon_settings()
		mod:load_new_attachment()
		if mod.reset_weapon then
			for _, attachment_slot in pairs(mod.attachment_slots) do
				mod:set_gear_setting(self._gear_id, attachment_slot, nil)
			end
			mod.reset_weapon = nil
		end

		mod.reset_start = managers.time:time("main")

		mod.changed_weapon = self._selected_item
		mod.weapon_changed = true

		managers.ui:item_icon_updated(self._selected_item)
		managers.event:trigger("event_item_icon_updated", self._selected_item)
		managers.event:trigger("event_replace_list_item", self._selected_item)

	else
		if self._presentation_item.__master_item.original_attachments then
			self._presentation_item.__master_item.attachments = table_clone(self._selected_item.__master_item.attachments)
			self._selected_item.__master_item.attachments = table_clone(self._presentation_item.__master_item.original_attachments)
			-- mod:dtf(self._presentation_item.__master_item.original_attachments, "original_attachments", 10)
			-- self._presentation_item.__master_item.original_attachments = nil
		end
		-- if self._presentation_item.__master_item.original_attachments then
		-- 	self._presentation_item.__master_item.original_attachments = nil
		-- end
		func(self, ...)
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_forward_gui", function(func, self, ...)
	local ui_manager = Managers.ui
	local timer_name = "ui"
	local world_layer = 200
	local world_name = self._unique_id .. "_ui_forward_world"
	local view_name = self.view_name
	self._world = ui_manager:create_world(world_name, world_layer, timer_name, view_name)
	local viewport_name = self._unique_id .. "_ui_forward_world_viewport"
	local viewport_type = "default_with_alpha"
	local viewport_layer = 10
	self._viewport = ui_manager:create_viewport(self._world, viewport_name, viewport_type, viewport_layer)
	self._viewport_name = viewport_name
	local renderer_name = self._unique_id .. "_forward_renderer"
	self._ui_forward_renderer = ui_manager:create_renderer(renderer_name, self._world)
	local gui = self._ui_forward_renderer.gui
	local gui_retained = self._ui_forward_renderer.gui_retained
	local resource_renderer_name = self._unique_id
	local material_name = "content/ui/materials/render_target_masks/ui_render_target_straight_blur"
	self._ui_resource_renderer = ui_manager:create_renderer(resource_renderer_name, self._world, true, gui, gui_retained, material_name)
end)

local trinket_slot_order = {
	"slot_trinket_1",
	"slot_trinket_2"
}

local function find_link_attachment_item_slot_path(target_table, slot_id, item, link_item, optional_path)
	local unused_trinket_name = "content/items/weapons/player/trinkets/unused_trinket"
	local path = optional_path or nil

	for k, t in pairs(target_table) do
		if type(t) == "table" then
			if k == slot_id then
				if not t.item or t.item ~= unused_trinket_name then
					path = path and path .. "." .. k or k

					if link_item then
						t.item = item
					end

					return path, t.item
				else
					return nil
				end
			else
				local previous_path = path
				path = path and path .. "." .. k or k
				local alternative_path, path_item = find_link_attachment_item_slot_path(t, slot_id, item, link_item, path)

				if alternative_path then
					return alternative_path, path_item
				else
					path = previous_path
				end
			end
		end
	end
end

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_setup_menu_tabs", function(func, self, content, ...)
	local item_name = self._item_name
	if item_name and mod.attachment[item_name] then
		content[3] = {
			display_name = "loc_weapon_cosmetics_customization",
			slot_name = "slot_weapon_skin",
			item_type = "WEAPON_SKIN",
			icon = "content/ui/materials/icons/system/settings/category_gameplay",
			filter_on_weapon_template = true,
			apply_on_preview = function(real_item, presentation_item)
				-- local weapon_skin = self._equipped_weapon_skin
				-- if self._presentation_item.__master_item then
				-- 	self._presentation_item.__master_item.slot_weapon_skin = nil
				-- end
				-- self._presentation_item.slot_weapon_skin = weapon_skin
				-- self._selected_weapon_skin = weapon_skin
				-- self._selected_weapon_skin_name = weapon_skin and weapon_skin.gear.masterDataInstance.id

				-- local trinket = self._equipped_weapon_trinket
				-- self._selected_weapon_trinket_name = trinket and trinket.gear.masterDataInstance.id
				-- self._selected_weapon_trinket = trinket

				-- content[1].apply_on_preview(self._equipped_weapon_skin, presentation_item)
				-- content[2].apply_on_preview(self._equipped_weapon_trinket, presentation_item)
				self:_preview_item(presentation_item)
			end
		}
	end
	func(self, content, ...)
	if item_name and mod.attachment[item_name] then
		self._tab_menu_element._widgets_by_name.entry_0.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_1.content.size[1] = button_width
		self._tab_menu_element._widgets_by_name.entry_2.content.size[1] = button_width
	end
end)

mod:hook(CLASS.InventoryWeaponCosmeticsView, "cb_switch_tab", function(func, self, index, ...)
	if not mod.dropdown_open then
		if index == 3 then
			self:present_grid_layout({})
			self._item_grid._widgets_by_name.grid_empty.visible = false
			mod:hide_custom_widgets(false)
			mod.original_weapon_settings = {}
			mod:get_changed_weapon_settings()
			mod:update_equip_button()
			mod:update_reset_button()
		else
			local t = managers.time:time("main")
			mod.reset_start = t
			mod:check_unsaved_changes(true)
			mod:hide_custom_widgets(true)
		end
		func(self, index, ...)
	end
end)

--#region Old
	-- mod:hook(CLASS.InventoryWeaponCosmeticsView, "_select_starting_item_by_slot_name", function(func, self, slot_name, optional_start_index, ...)
	-- 	if self._selected_tab_index < 3 then
	-- 		func(self, slot_name, optional_start_index, ...)
	-- 	end
	-- end)
--#endregion

mod:hook(CLASS.InventoryWeaponCosmeticsView, "_preview_element", function(func, self, element, ...)
	if not element then return end
	func(self, element, ...)
end)


mod.create_bar_breakdown_widgets = function(self)
	self:destroy_bar_breakdown_widgets()

	table.clear(self.cosmetics_view.bar_breakdown_widgets)
	table.clear(self.cosmetics_view.bar_breakdown_widgets_by_name)

	local bar_breakdown_widgets = self.cosmetics_view.bar_breakdown_widgets
	local bar_breakdown_widgets_by_name = self.cosmetics_view.bar_breakdown_widgets_by_name
	local bar_breakdown_widgets_definitions = ViewElementWeaponInfoDefinitions.bar_breakdown_widgets_definitions
	-- local definition = table_clone(bar_breakdown_widgets_definitions.bar_breakdown_slate)
	-- definition.scenegraph_id = "attachment_bar_breakdown_slate"
	-- local widget = UIWidget.init("attachment_bar_breakdown_slate", bar_breakdown_widgets_definitions.bar_breakdown_slate)
	-- widget.scenegraph_id = "attachment_bar_breakdown_slate"
	-- local content = widget.content
	-- local style = widget.style
	-- content.header = "test header" --Localize(bar_data.display_name)
	-- bar_breakdown_widgets[#bar_breakdown_widgets + 1] = widget
	-- bar_breakdown_widgets_by_name.attachment_bar_breakdown_slate = widget
	-- local description_offset = 0
	-- local entry_size = 40
	-- local stripped_bar_data = self:_strip_redundant_stats(bar_data)
	local num_entries = 3 --#stripped_bar_data
	-- local old_desc = content.description
	-- local new_desc = "test" --Localize(bar_data.description or bar_data.display_name .. "_desc")
	-- local ui_renderer = self._ui_grid_renderer
	-- local text_style = style.description
	-- local text_font_data = UIFonts.data_by_type(text_style.font_type)
	-- local text_font = text_font_data.path
	-- local text_size = text_style.size
	-- local text_options = UIFonts.get_font_options_by_style(text_style)
	-- local _, old_text_height = UIRenderer.text_size(ui_renderer, old_desc, text_style.font_type, text_style.font_size, text_size, text_options)
	-- local _, new_text_height = UIRenderer.text_size(ui_renderer, new_desc, text_style.font_type, text_style.font_size, text_size, text_options)
	-- description_offset = math.max(new_text_height - old_text_height, 0) + 20
	-- content.description = new_desc

	-- if bar_data.name ~= "base_rating" then
		for i = 1, num_entries do
			-- local bar_entry = stripped_bar_data[i]
			local definition = table_clone(bar_breakdown_widgets_definitions.entry)
			-- definition.scenegraph_id = "attachment_sub_display_name_"..tostring(i)
			local widget = UIWidget.init("attachment_bar_"..tostring(i), bar_breakdown_widgets_definitions.entry)
			widget.scenegraph_id = "attachment_sub_display_name_"..tostring(i)
			local content = widget.content
			-- local stat_text = self:_get_stats_text(bar_entry)
			content.text = "test stat" --stat_text
			bar_breakdown_widgets[#bar_breakdown_widgets + 1] = widget
			bar_breakdown_widgets_by_name["attachment_bar_"..tostring(i)] = widget
			-- widget.offset[2] = (num_entries - i) * -entry_size
			-- mod:dtf(widget, "widget_"..tostring(i), 5)
		end
	-- end

	-- local grid_length = grid_width --self:grid_length()
	-- local offset = 65
	-- local base_size = 50
	-- local size = base_size + num_entries * entry_size + description_offset
	-- self.cosmetics_view._ui_scenegraph.attachment_bar_breakdown_slate.size[2] = size
	-- self.cosmetics_view._ui_scenegraph.attachment_bar_breakdown_slate.world_position[2] = grid_length - size + offset
	-- self.cosmetics_view._ui_scenegraph.entry.world_position[2] = grid_length - base_size + offset - description_offset
	self.cosmetics_view.bar_breakdown_name = "test name" --stripped_bar_data.name
end

mod.destroy_bar_breakdown_widgets = function(self)
	table.clear(self.cosmetics_view.bar_breakdown_widgets)
	table.clear(self.cosmetics_view.bar_breakdown_widgets_by_name)

	self.cosmetics_view.bar_breakdown_name = nil
end

mod:hook_require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_definitions", function(instance)

	local top = 115
	local z = 100

	local y = 20 - edge
	for _, scenegraph_id in pairs(mod.added_cosmetics_scenegraphs) do
		if string_find(scenegraph_id, "text_pivot") then
			y = y + label_height
		else
			y = y + dropdown_height
		end
		instance.scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "top",
			parent = "item_grid_pivot",
			horizontal_alignment = "left",
			size = {grid_size[1], label_height},
			position = {edge, y, z}
		}
	end

	instance.scenegraph_definition.item_grid_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "left",
		size = {0, 0},
		position = {160, 15, 0},
	}

	-- instance.scenegraph_definition.item_grid_pivot.parent = "corner_top_left"
	-- instance.scenegraph_definition.item_grid_pivot.offset = {0, 0, 300}
	-- instance.scenegraph_definition.item_grid_pivot.position[2] = 50
	-- instance.scenegraph_definition.item_grid_pivot.position[1] = 0
	instance.scenegraph_definition.grid_tab_panel.position[1] = grid_width - (grid_width - tab_panel_width) - 20
	instance.scenegraph_definition.grid_tab_panel.position[2] = -48
	instance.scenegraph_definition.grid_tab_panel.size[1] = tab_panel_width
	instance.grid_settings.grid_size[2] = 970
	instance.grid_settings.mask_size[2] = 970

	instance.scenegraph_definition.panel_extension_pivot = {
		vertical_alignment = "top",
		parent = "corner_top_right",
		horizontal_alignment = "left",
		size = {grid_width + edge, 340 + edge * 2},
		-- position = {grid_width - 10, grid_size[2] - 425, z}
		-- position = {-(grid_width - 10), -(340 + edge * 2), z}
		position = {-90 -(grid_width / 2), 0, z}
	}
	local info_box_size = {1250, 200}
	local equip_button_size = {374, 76}
	-- instance.scenegraph_definition.info_box.position[1] = -220
	instance.scenegraph_definition.info_box.vertical_alignment = "top"
	instance.scenegraph_definition.info_box.horizontal_alignment = "left"
	instance.scenegraph_definition.info_box.position = {grid_width + 160, -100, 3}
	instance.scenegraph_definition.info_box.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.display_name.text_horizontal_alignment = "right"
	instance.scenegraph_definition.display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.display_name.size[1] = 1920 - (grid_width + 160)
	-- instance.scenegraph_definition.sub_display_name.text_horizontal_alignment = "right"
	instance.scenegraph_definition.sub_display_name.horizontal_alignment = "left"
	instance.scenegraph_definition.sub_display_name.size[1] = 1920 - (grid_width + 160)
	
	instance.scenegraph_definition.attachment_info_box = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "right",
		size = {500, 100},
		position = {-50, -300, 3}
	}
	instance.scenegraph_definition.attachment_display_name = {
		vertical_alignment = "top",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {500, 50},
		position = {30, 20, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_1 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {10, 0, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_2 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {160, 0, 3}
	}
	instance.scenegraph_definition.attachment_sub_display_name_3 = {
		vertical_alignment = "bottom",
		parent = "attachment_info_box",
		horizontal_alignment = "left",
		size = {150, 50},
		position = {310, 0, 3}
	}
	-- instance.scenegraph_definition.attachment_sub_display_name_4 = {
	-- 	vertical_alignment = "bottom",
	-- 	parent = "attachment_info_box",
	-- 	horizontal_alignment = "left",
	-- 	size = {150, 50},
	-- 	position = {150, 0, 3}
	-- }


	-- local display_name_style = table.clone(UIFontSettings.header_2)
	-- display_name_style.text_horizontal_alignment = "left"
	-- display_name_style.text_vertical_alignment = "bottom"
	-- local title_text_style = table.clone(UIFontSettings.header_2)
	-- title_text_style.text_horizontal_alignment = "center"
	-- title_text_style.text_vertical_alignment = "bottom"
	local sub_display_name_style = table.clone(UIFontSettings.header_3)
	sub_display_name_style.text_horizontal_alignment = "left"
	sub_display_name_style.text_vertical_alignment = "top"
	-- sub_display_name_style.text_color = Color.ui_grey_light(255, true)
	-- local description_text_style = table.clone(UIFontSettings.body_small)
	-- description_text_style.text_horizontal_alignment = "left"
	-- description_text_style.text_vertical_alignment = "top"

	instance.widget_definitions.button_pivot_background.style.background.visible = false

	instance.widget_definitions.attachment_info_box = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "attachment_info_box")

	instance.widget_definitions.attachment_display_name = UIWidget.create_definition({
		{
			value = "",
			value_id = "text",
			pass_type = "text",
			style = sub_display_name_style
		}
	}, "attachment_display_name")

	instance.scenegraph_definition.equip_button = {
		vertical_alignment = "bottom",
		parent = "corner_bottom_right",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, 0, 1},
		offset = {-100, -70, 1}
	}

	local equip_button_size = {374, 76}
	instance.scenegraph_definition.reset_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	instance.widget_definitions.reset_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "reset_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.reset_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_reset_button"))
	
	instance.scenegraph_definition.randomize_button = {
		vertical_alignment = "bottom",
		parent = "reset_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {-equip_button_size[1] - 35, 0, 1}
	}
	instance.widget_definitions.randomize_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "randomize_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.randomize_button.content.original_text = utf8_upper(mod:localize("loc_weapon_inventory_randomize_button"))

	instance.scenegraph_definition.demo_button = {
		vertical_alignment = "bottom",
		parent = "equip_button",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {0, -equip_button_size[2], 1}
	}
	instance.widget_definitions.demo_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "demo_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_weapon_inventory_demo_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})

	instance.widget_definitions.panel_extension = UIWidget.create_definition({
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			style_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "left",
				offset = {0, 0, 0},
				size_addition = {0, -1},
				color = Color.terminal_grid_background(255, true),
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_medium",
			style_id = "input_progress_frame",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				scale_to_material = true,
				horizontal_alignment = "right",
				offset = {10, 10, 4},
				default_offset = {10, 0, 4},
				size = {0, 10},
				color = {255, 226, 199, 126},
				-- size_addition = {20, 20}
			}
		}
	}, "panel_extension_pivot")

	if #instance.legend_inputs == 1 then
		instance.legend_inputs[#instance.legend_inputs+1] = {
			on_pressed_callback = "_cb_on_ui_visibility_toggled",
			input_action = "hotkey_menu_special_2",
			display_name = "loc_menu_toggle_ui_visibility_off",
			alignment = "right_alignment"
		}
	end

	instance.scenegraph_definition.weapon_presets_pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "right",
		size = {0, 0},
		position = {-60, 94, 62}
	}

	-- instance.always_visible_widget_names.background = true

	-- instance.grid_settings.use_terminal_background = true
	-- instance.grid_settings.layer = 300

	-- mod:dtf(instance.widget_definitions, "instance.widget_definitions", 10)

end)

mod:hook_require("scripts/ui/view_elements/view_element_inventory_weapon_preview/view_element_inventory_weapon_preview_settings", function(instance)
	instance.shading_environment = "content/shading_environments/ui/ui_item_preview"
	-- instance.shading_environment = "content/shading_environments/ui_default"
	-- instance.shading_environment = "content/shading_environments/ui/portrait"
	-- instance.shading_environment = "content/shading_environments/ui/weapon_icons"
	-- instance.shading_environment = "content/shading_environments/ui/ui_popup_background"
	-- instance.shading_environment = "content/shading_environments/ui/inventory"
	-- instance.shading_environment = "content/shading_environments/ui/barber" -> crash
	-- instance.shading_environment = "content/shading_environments/ui/barber_character_appearance" -> crash
	-- instance.shading_environment = "content/shading_environments/ui/inventory"
	-- instance.weapon_spawn_depth = 3
end)

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod._recursive_get_child_units = function(self, unit, slot_info_id, out_units)
	local slot_info_id = slot_info_id or self.cosmetics_view._slot_info_id
	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	local attachment_slot_info = slot_infos[slot_info_id]
	if attachment_slot_info then
		local attachment_slot = attachment_slot_info.unit_to_attachment_slot[unit]
		local text = attachment_slot and attachment_slot or unit
		out_units[text] = {}
		local children = unit_get_child_units(unit)
		if children then
			for _, child in pairs(children) do
				self:_recursive_get_child_units(child, out_units[text])
			end
		end
	end
end

mod.map_out_unit = function(self, unit)
	local map = {}
	self:_recursive_get_child_units(unit, map)
	self:dtf(map, "map", 20)
end

mod.vector3_equal = function(self, v1, v2)
	return v1[1] == v2[1] and v1[2] == v2[2] and v1[3] == v2[3]
end
