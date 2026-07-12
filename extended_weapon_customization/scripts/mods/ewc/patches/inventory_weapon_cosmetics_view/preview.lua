-- File: extended_weapon_customization/scripts/mods/ewc/patches/inventory_weapon_cosmetics_view/preview.lua
local mod = get_mod("extended_weapon_customization"); if not mod then return end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local items = mod:original_require("scripts/utilities/items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local table = table
local pairs = pairs
local string = string
local localize = Localize
local string_sub = string.sub
local table_clear = table.clear
local string_upper = string.upper
local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local temp_detached = {}
local temp_validated = {}
local temp_force_default = {}
local temp_stale_attachment_slots = {}
local empty_attachment_path = "content/items/weapons/player/trinkets/unused_trinket"
local OVERRIDE_TYPE = table.enum("color", "pattern", "wear")

local function is_empty_attachment_path(attachment_path)
	return not attachment_path or attachment_path == "" or attachment_path == empty_attachment_path
end

local function attachment_data_for_replacement_path(attachment_entries, replacement_path)
	if not attachment_entries or is_empty_attachment_path(replacement_path) then
		return nil
	end

	for attachment_name, attachment_data in pairs(attachment_entries) do
		if attachment_data and attachment_data.replacement_path == replacement_path then
			return attachment_data
		end
	end

	return nil
end

local function attachment_path_is_available(attachment_entries, replacement_path)
	return is_empty_attachment_path(replacement_path) or
		attachment_data_for_replacement_path(attachment_entries, replacement_path) ~= nil
end

local function validation_default_attachment_path(attachment_entries)
	if not attachment_entries then
		return empty_attachment_path
	end

	for attachment_name, attachment_data in pairs(attachment_entries) do
		if attachment_data and attachment_data.validation_default and attachment_data.replacement_path then
			return attachment_data.replacement_path
		end
	end

	return empty_attachment_path
end

local function valid_or_default_attachment_path(attachment_entries, replacement_path)
	if attachment_path_is_available(attachment_entries, replacement_path) then
		return is_empty_attachment_path(replacement_path) and empty_attachment_path or replacement_path
	end

	return validation_default_attachment_path(attachment_entries)
end

local function clear_attachment_slot_from_attachment_tree(attachments, target_slot)
	if not attachments then
		return false
	end

	local cleared = false

	for attachment_slot, attachment_data in pairs(attachments) do
		if attachment_slot == target_slot and attachment_data then
			attachment_data.item = empty_attachment_path
			attachment_data.children = {}
			attachment_data.material_overrides = {}

			cleared = true
		end

		if attachment_data and attachment_data.children and
			clear_attachment_slot_from_attachment_tree(attachment_data.children, target_slot) then
			cleared = true
		end
	end

	return cleared
end

local function apply_attachment_path(self, presentation_item, attachment_slot, attachment_path)
	attachment_path = is_empty_attachment_path(attachment_path) and empty_attachment_path or attachment_path

	mod:modify_item(presentation_item, nil, {
		[attachment_slot] = attachment_path
	})

	if attachment_path == empty_attachment_path then
		clear_attachment_slot_from_attachment_tree(presentation_item.attachments, attachment_slot)
	end

	self["_selected_" .. attachment_slot .. "_name"] = attachment_path

	return attachment_path
end

local function detach_attachment_slot(self, presentation_item, attachment_slot)
	apply_attachment_path(self, presentation_item, attachment_slot, empty_attachment_path)

	temp_detached[attachment_slot] = true
end

local function reset_validation_attachment_slots(self, presentation_item, attachment_data, attachments)
	if not attachment_data or not attachment_data.validate_attachments then
		return
	end

	for _, attachment_slot in pairs(attachment_data.validate_attachments) do
		if attachments and attachments[attachment_slot] then
			apply_attachment_path(self, presentation_item, attachment_slot, empty_attachment_path)

			temp_detached[attachment_slot] = true
			temp_force_default[attachment_slot] = true
		end
	end
end

local function detach_stale_preview_attachment_slots(self, presentation_item, attachments, active_slot_name)
	if not presentation_item or not presentation_item.attachments then
		return
	end

	table_clear(temp_stale_attachment_slots)

	local attachment_slots = mod:fetch_attachment_slots(presentation_item.attachments)

	for attachment_slot, attachment_slot_data in pairs(attachment_slots) do
		if attachment_slot ~= active_slot_name and not attachments[attachment_slot] and
			(self["_selected_" .. attachment_slot .. "_name"] or self["_equipped_" .. attachment_slot .. "_name"]) then
			temp_stale_attachment_slots[attachment_slot] = true
		end
	end

	for attachment_slot, should_detach in pairs(temp_stale_attachment_slots) do
		if should_detach then
			apply_attachment_path(self, presentation_item, attachment_slot, empty_attachment_path)

			temp_detached[attachment_slot] = true
			temp_validated[attachment_slot] = true
		end
	end
end

local function sanitize_nested_attachment_slots(self, presentation_item, real_item, active_slot_name)
	if not real_item or not real_item.attachments then
		return
	end

	for attachment_slot, attachment_slot_data in pairs(real_item.attachments) do
		if attachment_slot ~= active_slot_name then
			local nested_attachment_path = mod:fetch_attachment(real_item.attachments, attachment_slot)

			if not is_empty_attachment_path(nested_attachment_path) then
				apply_attachment_path(self, presentation_item, attachment_slot, empty_attachment_path)

				temp_detached[attachment_slot] = true
				temp_validated[attachment_slot] = true
			end
		end
	end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Preview the selected attachment in the customization menu.
mod.inventory_weapon_cosmetics_view_preview_element = function(self, element)
	if not element then
		return false
	end

	local selected_tab_index = self._selected_tab_index
	local content = selected_tab_index and self._tabs_content and self._tabs_content[selected_tab_index]
	local presentation_item = self._presentation_item

	if not content or not presentation_item then
		return true
	end

	local apply_on_preview = content.apply_on_preview
	local slot_name = content.slot_name

	if not slot_name then
		return true
	end

	local item = element.item
	local real_item = element.real_item
	local attachments = mod.settings.attachments[presentation_item.weapon_template]

	if not attachments then
		return true
	end

	self._previewed_item = item
	self._previewed_element = element

	table_clear(temp_detached)
	table_clear(temp_validated)
	table_clear(temp_force_default)

	local attachment_display_name

	if real_item then
		local attachment_data = mod.settings.attachment_data_by_item_string[real_item.name]

		if attachment_data then
			self.attachment_selection_rotation_offset = attachment_data.attachment_selection_rotation_offset
		end

		detach_stale_preview_attachment_slots(self, presentation_item, attachments, slot_name)

		if attachment_data and attachment_data.detach_attachments then
			for _, attachment_slot_or_attachment_name in pairs(attachment_data.detach_attachments) do
				if attachments[attachment_slot_or_attachment_name] then
					detach_attachment_slot(self, presentation_item, attachment_slot_or_attachment_name)
				else
					for attachment_slot, attachment_entries in pairs(attachments) do
						if self["_selected_" .. attachment_slot .. "_name"] == attachment_slot_or_attachment_name or
							self["_equipped_" .. attachment_slot .. "_name"] == attachment_slot_or_attachment_name then
							detach_attachment_slot(self, presentation_item, attachment_slot)

							break
						end
					end
				end
			end
		end

		reset_validation_attachment_slots(self, presentation_item, attachment_data, attachments)
		sanitize_nested_attachment_slots(self, presentation_item, real_item, slot_name)

		for attachment_slot, attachment_entries in pairs(attachments) do
			local selected_or_saved = (slot_name == attachment_slot and self["_selected_" .. attachment_slot .. "_name"]) or
				self["_equipped_" .. attachment_slot .. "_name"]

			if selected_or_saved and not temp_detached[attachment_slot] then
				local replacement_path = valid_or_default_attachment_path(attachment_entries, selected_or_saved)

				apply_attachment_path(self, presentation_item, attachment_slot, replacement_path)

				temp_validated[attachment_slot] = true
			end
		end

		if attachment_data and attachment_data.validate_attachments then
			for _, attachment_slot in pairs(attachment_data.validate_attachments) do
				if attachments and attachments[attachment_slot] and
					(temp_force_default[attachment_slot] or not temp_validated[attachment_slot] or
						self["_selected_" .. attachment_slot .. "_name"] == empty_attachment_path) then
					local replacement_path

					if temp_force_default[attachment_slot] then
						replacement_path = validation_default_attachment_path(attachments[attachment_slot])
					else
						replacement_path = valid_or_default_attachment_path(attachments[attachment_slot],
							self["_equipped_" .. attachment_slot .. "_name"])
					end

					apply_attachment_path(self, presentation_item, attachment_slot, replacement_path)

					temp_validated[attachment_slot] = true
				end
			end
		end

		if real_item.display_name and real_item.display_name ~= "" and real_item.display_name ~= "n/a" then
			local test_localize = localize(real_item.display_name)

			if string_sub(test_localize, 1, 1) ~= "<" and string_sub(test_localize, -1) ~= ">" then
				attachment_display_name = test_localize
			end
		end
	else
		self["_selected_" .. slot_name .. "_name"] = empty_attachment_path
	end

	apply_attachment_path(self, presentation_item, slot_name, real_item and real_item.name or empty_attachment_path)

	if apply_on_preview then
		apply_on_preview(real_item, presentation_item)
	end

	detach_stale_preview_attachment_slots(self, presentation_item, attachments, slot_name)

	local gear_id = mod:gear_id(presentation_item, true)
	pt.items_originating_from_customization_menu[gear_id] = true

	self:_preview_item(presentation_item)

	local widgets_by_name = self._widgets_by_name

	if not attachment_display_name or attachment_display_name == "" then
		attachment_display_name = mod.settings.attachment_name_by_item_string[real_item and real_item.name] or "empty"
		attachment_display_name = mod:cached_gsub(attachment_display_name, "_", " ")
		attachment_display_name = mod:cached_gsub(attachment_display_name, "%f[%a].", string_upper)
	end

	if widgets_by_name and widgets_by_name.sub_display_name and widgets_by_name.display_name then
		widgets_by_name.sub_display_name.content.text = string_format("%s • %s",
			items.weapon_card_display_name(self._selected_item),
			items.weapon_card_sub_display_name(self._selected_item))
		widgets_by_name.display_name.content.text = attachment_display_name
	end

	return true
end

-- Apply customization-menu material override preview cleanup and preview rotation.
mod.inventory_weapon_cosmetics_view_preview_item = function(self)
	local slot_name = self:selected_slot_name()

	if slot_name and self.selected_color_override == "" then
		mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, { OVERRIDE_TYPE.color })
	end

	if slot_name and self.selected_pattern_override == "" then
		mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, { OVERRIDE_TYPE.pattern })
	end

	if slot_name and self.selected_wear_override == "" then
		mod:clear_gear_material_overrides(self._presentation_item, nil, slot_name, { OVERRIDE_TYPE.wear })
	end

	local weapon_preview = self._weapon_preview
	local ui_weapon_spawner = weapon_preview and weapon_preview._ui_weapon_spawner

	if ui_weapon_spawner then
		if self.current_default_rotation_angle then
			ui_weapon_spawner._default_rotation_angle = self.current_default_rotation_angle
			ui_weapon_spawner._rotation_angle = self.current_default_rotation_angle
		end

		self.current_default_rotation_angle = self.attachment_selection_rotation_offset or 0
	end
end
