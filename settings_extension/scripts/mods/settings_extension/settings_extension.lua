local mod = get_mod("settings_extension")
local DMF = get_mod("DMF")
mod.create_test_options = true
mod.text = "Settings Extension"

local OptionsUtilities = Mods.original_require("scripts/utilities/ui/options")
local InputUtils = Mods.original_require("scripts/managers/input/input_utils")

-- ##########################################################
-- ###################### Variables #########################

mod.initialized = false
mod.test_value_1 = false
mod.test_value_2 = 50
mod.test_value_3 = 25
mod.test_value_4 = 1

-- ##########################################################
-- ##################### Localization #######################

-- Mods.Localization.addMany({
-- 	menu_category_mods = "Mods",
-- 	test_checkbox = "Test Checkbox",
-- 	test_checkbox_mo = "Test Checkbox Tooltip",
-- 	test_percent_slider = "Test Percent",
-- 	test_percent_slider_mo = "Test Percent Tooltip",
-- 	test_value_slider = "Test Value",
-- 	test_value_slider_mo = "Test Value Tooltip",
-- 	test_dropdown = "Test Dropdown",
-- 	test_dropdown_mo = "Test Dropdown Tooltip",
-- 	test_dropdown_val1 = "Value 1",
-- 	test_dropdown_val2 = "Value 2",
-- 	test_dropdown_val3 = "Value 3",
-- 	test_keybinding = "Test Keybinding",
-- 	test_keybinding2 = "Test Keybinding",
-- 	test_keybinding_mo = "Test Keybinding Tooltip",
-- })

-- ##########################################################
-- ################ Create Widget Templates #################

mod.extensions = {}
mod.extend = function (self, func)
	self.extensions[#self.extensions+1] = {
		func = func,
	}
end

-- Create value slider template
mod.value_slider = function (self, params)
	params.on_value_changed_function = params.change
	params.value_get_function = params.get
	local template = OptionsUtilities.create_value_slider_template(params)
	template.category = params.category
	template.after = params.after
	template.tooltip_text = params.tooltip_text
	template.indentation_level = params.indentation_level
	return template
end

-- Create percentage slider template
mod.percent_slider = function (self, params)
	params.on_value_changed_function = params.change
	params.value_get_function = params.get
	local template = OptionsUtilities.create_percent_slider_template(params)
	template.category = params.category
	template.after = params.after
	template.tooltip_text = params.tooltip_text
	template.indentation_level = params.indentation_level
	return template
end

-- Create checkbox template
mod.checkbox = function (self, params)
	local template = {
		tooltip_text = params.tooltip_text,
		default_value = params.default_value,
		category = params.category,
		display_name = params.display_name,
		after = params.after,
		on_activated = params.change,
		get_function = params.get,
		value_type = "boolean",
		indentation_level = params.indentation_level,
	}
	return template
end

-- Create dropdown template
mod.dropdown = function (self, params)
	local template = {
		tooltip_text = params.tooltip_text,
		display_name = params.display_name,
		default_value = params.default_value,
		category = params.category,
		widget_type = "dropdown",
		after = params.after,
		options = params.options,
		on_activated = params.change,
		get_function = params.get,
		indentation_level = params.indentation_level,
	}
	return template
end

-- Set keybinding
-- mod.set_keybind = function (self, key_name, func, old_key_name)
-- 	if Mods.keybind.is_keybind_set(old_key_name) then
-- 		Mods.keybind.unset_keybind(old_key_name)
-- 	end
-- 	Mods.keybind.set_keybind(mod_name, key_name, func)
-- end

-- Create keybind template
-- mod.keybindings = mod.keybindings or {}
-- mod.keybind = function (self, params)
-- 	local reserved_keys = {}
-- 	local cancel_keys = {
-- 		"keyboard_esc"
-- 	}
-- 	local devices = {
-- 		"keyboard",
-- 		"mouse",
-- 		"xbox_controller",
-- 		"ps4_controller"
-- 	}

-- 	-- local keys = Mods.UserSettings:get_user_setting("keybindings", params.display_name) or params.keys
-- 	-- self:set_keybind(keys, params.callback, keys)

-- 	local template = {
-- 		widget_type = "keybind",
-- 		service_type = "Ingame",
-- 		display_name = params.display_name,
-- 		group_name = params.category,
-- 		category = params.category,
-- 		keys = keys,
-- 		after = params.after,
-- 		devices = devices,
-- 		sort_order = params.sort_order,
-- 		cancel_keys = cancel_keys,
-- 		reserved_keys = reserved_keys,
-- 		indentation_level = params.indentation_level,
-- 		on_activated = function (new_value, old_value)
-- 			for i = 1, #cancel_keys do
-- 				local cancel_key = cancel_keys[i]
-- 				if cancel_key == new_value.main then
-- 					return true
-- 				end
-- 			end

-- 			for i = 1, #reserved_keys do
-- 				local reserved_key = reserved_keys[i]
-- 				if reserved_key == new_value.main then
-- 					return false
-- 				end
-- 			end

-- 			local local_name = InputUtils.local_key_name(new_value.main, "keyboard")
-- 			local old_value = Mods.UserSettings:get_user_setting("keybindings", params.display_name) or new_value.main
-- 			local old_local_name = InputUtils.local_key_name(old_value, "keyboard")
-- 			Mods.Options:set_keybind(local_name, params.callback, old_local_name)

-- 			Mods.UserSettings:set_user_setting("keybindings", params.display_name, local_name)
-- 			Mods.UserSettings:save_user_settings()

-- 			return true
-- 		end,
-- 		get_function = function ()
-- 			local local_name = Mods.UserSettings:get_user_setting("keybindings", params.display_name)
-- 			local global_name = InputUtils.local_to_global_name(local_name, "keyboard")
-- 			return {
-- 				main = global_name,
-- 				disablers = {},
-- 				enablers = {},
-- 			}
-- 		end,
-- 	}

-- 	local global_name = InputUtils.local_to_global_name(keys, "keyboard")
-- 	template.on_activated({
-- 		main = global_name,
-- 		disablers = {},
-- 		enablers = {},
-- 	})

-- 	if Mods.UserSettings:get_user_setting("keybindings", params.display_name) ~= nil then
-- 		Mods.UserSettings:set_user_setting("keybindings", params.display_name, keys)
-- 		Mods.UserSettings:save_user_settings()
-- 	end

-- 	return template
-- end

-- ##########################################################
-- ##################### Functions ##########################

-- Remove modded category menu
mod.remove_modded_category = function (self, OptionsView)
	local categories = OptionsView._options_templates.categories
	for i = #categories, 1, -1 do
		if categories[i].custom then
			table.remove(categories, i)
		end
	end
end

-- Create modded category menu
mod.create_category = function (self, OptionsView)
	local categories = OptionsView._options_templates.categories
	categories[#categories+1] = {
		can_be_reset = true,
		display_name = "menu_category_mods",
		icon = "content/ui/materials/icons/system/settings/category_gameplay",
		custom = true,
	}
end

-- Remove modded settings
mod.remove_modded_settings = function (self, OptionsView)
	local settings = OptionsView._options_templates.settings
	for i = #settings, 1, -1 do
		if settings[i].custom then
			table.remove(settings, i)
		end
	end
end

mod.after_index = function(self, OptionsView, after)
	local settings = OptionsView._options_templates.settings
	for index, setting in pairs(settings) do
		if setting.id == after then
			return index + 1
		end
	end
	return #settings + 1
end

-- Create modded settings
mod.create_settings = function (self, OptionsView)
	local settings = OptionsView._options_templates.settings

	for name, this_mod in pairs(DMF.mods) do
		-- Custom settings
		if type(this_mod) == "table" and this_mod.options then

			local text = this_mod.text or name
            local text_id = "menu_group_mods_"..name
			self:add_global_localize_strings({
                [text_id] = {
                    en = text,
                },
            })

			local options_no_after = 0
			for _, option in pairs(this_mod.options) do
				if not option.after then
					options_no_after = options_no_after + 1
				end
			end

			if options_no_after > 0 then
				settings[#settings+1] = {
					widget_type = "group_header",
					group_name = "mods_settings",
					display_name = text_id,
					category = "menu_category_mods",
					custom = true,
				}
			end

			for _, setting in pairs(this_mod.options) do
				setting.custom = true
				setting.category = setting.category or "menu_category_mods"
				setting.indentation_level = setting.after and 1 or 0
				if setting.after then
					local index = self:after_index(OptionsView, setting.after)
					table.insert(settings, index, setting)
				else
					settings[#settings+1] = setting
				end
			end
			
		end
	end
end

mod.extend_settings = function (self, OptionsView)
	for _, extend in pairs(self.extensions) do
		extend.func(OptionsView)
	end
end

-- ##########################################################
-- ###################### Hooks #############################

-- Test options
if mod.create_test_options then
	mod.options = {
		mod:checkbox({
			tooltip_text = "test_checkbox_mo",
			display_name = "test_checkbox",
			default_value = true,
			change = function (new_value)
				mod.test_value_1 = new_value
			end,
			get = function ()
				return mod.test_value_1
			end,
		}),
		mod:percent_slider({
			tooltip_text = "test_percent_slider_mo",
			display_name = "test_percent_slider",
			normalized_step_size = 0.011111111111111112,
			widget_type = "percent_slider",
			default_value = 100,
			apply_on_drag = true,
			change = function (new_value)
				mod.test_value_2 = new_value
			end,
			get = function ()
				return mod.test_value_2
			end,
		}),
		mod:value_slider({
			tooltip_text = "test_value_slider_mo",
			display_name = "test_value_slider",
			min_value = 12,
			max_value = 72,
			default_value = 25,
			num_decimals = 0,
			step_size_value = 1,
			apply_on_drag = true,
			change = function (new_value)
				mod.test_value_3 = new_value
			end,
			get = function ()
				return mod.test_value_3
			end,
		}),
		mod:dropdown({
			tooltip_text = "test_dropdown_mo",
			display_name = "test_dropdown",
			default_value = 1,
			options = {
				{
					id = 0,
					display_name = "test_dropdown_val1",
				},
				{
					id = 1,
					display_name = "test_dropdown_val2",
				},
				{
					id = 2,
					display_name = "test_dropdown_val3",
				},
			},
			change = function (new_value)
				mod.test_value_4 = new_value
			end,
			get = function ()
				return mod.test_value_4
			end,
		}),
		-- mod:keybind({
		-- 	tooltip_text = "test_keybinding_mo",
		-- 	display_name = "test_keybinding",
		-- 	keys = "p",
		-- 	callback = function ()
		-- 	end
		-- }),
		-- mod:keybind({
		-- 	tooltip_text = "test_keybinding_mo",
		-- 	display_name = "test_keybinding2",
		-- 	keys = "o",
		-- 	callback = function ()
		-- 	end
		-- }),
	}
end

mod.initialized = false
-- Setup Mods options on enter
-- local options_view_file = "scripts/ui/views/options_view/options_view"
mod:hook(CLASS.OptionsView, "on_enter", function (func, self, ...)

	if not mod.initialized then

		self._options_templates = Mods.original_require("scripts/settings/options/options_templates")

		mod:remove_modded_category(self)
		mod:create_category(self)
		mod:remove_modded_settings(self)
		mod:create_settings(self)

		mod:extend_settings(self)

		mod.initialized = true
	end

	func(self, ...)
end)

-- mod.localize_hook = function (func, self, key, ...)
-- 	-- Check our cache if it has the key
--     local text = mod:localize(key)
--     -- mod:echo("text = '"..text.."'")
-- 	if text ~= "<"..key..">" then
-- 		-- Return string and skip original function
-- 		return text
-- 	end
-- 	-- Return original function
-- 	return func(self, key, ...)
-- end

-- local localization_manager_file = "scripts/managers/localization/localization_manager"
-- mod:hook(CLASS.LocalizationManager, "Localize", mod.localize_hook)
-- mod:hook(CLASS.LocalizationManager, "localize", mod.localize_hook)
