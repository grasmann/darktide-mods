local mod = get_mod("settings_extension")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local OptionsUtilities = Mods.original_require("scripts/utilities/ui/options")
local InputUtils = Mods.original_require("scripts/managers/input/input_utils")
local render_settings = {}
local render_settings_by_id = {}

mod.initialized = false

-- Test options
mod.create_test_options = false
mod.initialized = false
mod.test_value_1 = false
mod.test_value_2 = 50
mod.test_value_3 = 25
mod.test_value_4 = 1
if mod.create_test_options then
	mod.settings_extension_add_options = {
		{
			type = "checkbox",
			tooltip_text = "test_checkbox_mo",
			display_name = "test_checkbox",
			default_value = true,
			change = function (new_value)
				mod.test_value_1 = new_value
			end,
			get = function ()
				return mod.test_value_1
			end,
		},
		{
			type = "percent_slider",
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
		},
		{
			type = "value_slider",
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
		},
		{
			type = "dropdown",
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
		},
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

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

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

-- -- Set keybinding
-- -- mod.set_keybind = function (self, key_name, func, old_key_name)
-- -- 	if Mods.keybind.is_keybind_set(old_key_name) then
-- -- 		Mods.keybind.unset_keybind(old_key_name)
-- -- 	end
-- -- 	Mods.keybind.set_keybind(mod_name, key_name, func)
-- -- end
-- mod.set_keybind = function(self, keybind_data)
-- 	DMF.add_mod_keybind(
-- 		self,
-- 		keybind_data.setting_id,
-- 		{
-- 			global          = keybind_data.keybind_global,
-- 			trigger         = keybind_data.keybind_trigger,
-- 			type            = keybind_data.keybind_type,
-- 			keys            = keybind_data.keys,
-- 			function_name   = keybind_data.function_name,
-- 			view_name       = keybind_data.view_name,
-- 		}
-- 	)
-- 	self:set(keybind_data.setting_id, keybind_data.keys, true)
-- end

-- -- Create keybind template
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

-- 	local keys = mod:get_user_setting("keybindings", params.display_name) or params.keys
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
-- 			local old_value = mod:get_user_setting("keybindings", params.display_name) or new_value.main
-- 			local old_local_name = InputUtils.local_key_name(old_value, "keyboard")
-- 			-- Mods.Options:set_keybind(local_name, params.callback, old_local_name)
-- 			mod:set_keybind({
-- 				keys = {local_name}
-- 			})

-- 			mod:set_user_setting("keybindings", params.display_name, local_name)
-- 			mod:save_user_settings()

-- 			return true
-- 		end,
-- 		get_function = function ()
-- 			local local_name = mod:get_user_setting("keybindings", params.display_name)
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

-- 	if mod:get_user_setting("keybindings", params.display_name) ~= nil then
-- 		mod:set_user_setting("keybindings", params.display_name, keys)
-- 		mod:save_user_settings()
-- 	end

-- 	return template
-- end

mod.verify_and_apply_changes = function (self, changed_setting, new_value, affected_settings, origin_id)
	local changes_list = {}
	local first_level = not affected_settings

	if first_level then
		changes_list[#changes_list + 1] = {
			id = changed_setting.id,
			value = new_value,
			save_location = changed_setting.save_location,
			require_apply = changed_setting.require_apply
		}
	end

	local settings_list = affected_settings or {}

	if not changed_setting.disabled or changed_setting.disabled and changed_setting.disabled_origin == origin_id then
		if changed_setting.disable_rules then
			for i = 1, #changed_setting.disable_rules do
				local disabled_rule = changed_setting.disable_rules[i]
				local disabled_setting = render_settings_by_id[disabled_rule.id]

				if disabled_setting and (not disabled_setting.validation_function or disabled_setting.validation_function and disabled_setting.validation_function()) then
					local previously_enabled = false

					if disabled_rule.validation_function(new_value) then
						disabled_setting.disabled_by = disabled_setting.disabled_by or {}

						if table.is_empty(disabled_setting.disabled_by) then
							previously_enabled = true
							disabled_setting.value_on_enabled = disabled_setting:get_function()
							disabled_setting.disabled_origin = changed_setting.id
						end

						disabled_setting.disabled_by[changed_setting.id] = disabled_rule.reason
						disabled_setting.disabled = true
					elseif not disabled_rule.validation_function(new_value) and disabled_setting.disabled_by and disabled_setting.disabled_by[changed_setting.id] then
						disabled_setting.disabled_by[changed_setting.id] = nil
						disabled_setting.disabled = not table.is_empty(disabled_setting.disabled_by)

						if disabled_setting.disabled == false then
							disabled_setting.disabled_origin = nil
						end
					end

					if previously_enabled or disabled_setting.disabled == false then
						local disabled_setting_value = nil

						if disabled_setting.disabled == true then
							disabled_setting_value = disabled_rule.disable_value
						else
							disabled_setting_value = disabled_setting.value_on_enabled
						end

						changes_list[#changes_list + 1] = {
							id = disabled_rule.id,
							value = disabled_setting_value,
							save_location = disabled_setting.save_location,
							require_apply = disabled_setting.require_apply
						}
					end
				end
			end
		end

		if changed_setting.options then
			for i = 1, #changed_setting.options do
				local option = changed_setting.options[i]

				if option.id == new_value then
					if option.values then
						for id, value in pairs(option.values) do
							if type(value) == "table" then
								for inner_id, inner_value in pairs(value) do
									if render_settings_by_id[inner_id] and (not render_settings_by_id[inner_id].validation_function or render_settings_by_id[inner_id].validation_function and render_settings_by_id[inner_id].validation_function()) then
										if not render_settings_by_id[inner_id].disabled then
											changes_list[#changes_list + 1] = {
												id = inner_id,
												value = inner_value,
												save_location = render_settings_by_id[inner_id].save_location,
												require_apply = render_settings_by_id[inner_id].require_apply
											}
										elseif render_settings_by_id[inner_id].disabled then
											render_settings_by_id[inner_id].value_on_enabled = inner_value
										end
									elseif not render_settings_by_id[inner_id] then
										changes_list[#changes_list + 1] = {
											id = inner_id,
											value = inner_value,
											save_location = id
										}
									end
								end
							elseif render_settings_by_id[id] and (not render_settings_by_id[id].validation_function or render_settings_by_id[id].validation_function and render_settings_by_id[id].validation_function()) then
								if not render_settings_by_id[id].disabled then
									changes_list[#changes_list + 1] = {
										id = id,
										value = value,
										save_location = render_settings_by_id[id].save_location,
										require_apply = render_settings_by_id[id].require_apply
									}
								elseif render_settings_by_id[id].disabled then
									render_settings_by_id[id].value_on_enabled = value
								end
							elseif not render_settings_by_id[id] then
								changes_list[#changes_list + 1] = {
									id = id,
									value = value
								}
							end
						end
					end

					if option.apply_values_on_edited then
						for id, value in pairs(option.apply_values_on_edited) do
							if render_settings_by_id[id] and (not render_settings_by_id[id].validation_function or render_settings_by_id[id].validation_function and render_settings_by_id[id].validation_function()) then
								if not render_settings_by_id[id].disabled then
									changes_list[#changes_list + 1] = {
										id = id,
										value = value,
										save_location = render_settings_by_id[id].save_location,
										require_apply = render_settings_by_id[id].require_apply
									}
								elseif render_settings_by_id[id] and render_settings_by_id[id].disabled then
									render_settings_by_id[id].value_on_enabled = value
								end
							end
						end
					end

					break
				end
			end
		end

		if changed_setting.apply_values_on_edited then
			for id, value in pairs(changed_setting.apply_values_on_edited) do
				if render_settings_by_id[id] and (not render_settings_by_id[id].validation_function or render_settings_by_id[id].validation_function and render_settings_by_id[id].validation_function()) then
					if not render_settings_by_id[id].disabled then
						changes_list[#changes_list + 1] = {
							id = id,
							value = value,
							save_location = render_settings_by_id[id].save_location,
							require_apply = render_settings_by_id[id].require_apply
						}
					elseif render_settings_by_id[id].disabled then
						render_settings_by_id[id].value_on_enabled = value
					end
				end
			end
		end

		for i = 1, #changes_list do
			local change = changes_list[i]
			settings_list[#settings_list + 1] = change

			if render_settings_by_id[change.id] then
				local should_verifiy = first_level and i > 1 or not first_level

				if should_verifiy then
					self:verify_and_apply_changes(render_settings_by_id[change.id], change.value, settings_list, changed_setting.id)
				end
			end
		end
	end

	if first_level then
		local filtered_changes = self:remove_repeated_entries(settings_list)
		local dirty = true
		local require_apply = nil

		for i = 1, #filtered_changes do
			local setting_changed = filtered_changes[i]

			if setting_changed.require_apply then
				require_apply = true
			end

			local id = setting_changed.id
			local new_value = setting_changed.value

			if render_settings_by_id[id] and render_settings_by_id[id].on_changed then
				local saved, needs_apply = render_settings_by_id[id].on_changed(new_value, render_settings_by_id[id])
				dirty = dirty or saved

				if not require_apply then
					require_apply = needs_apply
				end
			else
				local save_location = setting_changed.save_location
				local current_value = self:get_user_setting(save_location, id)

				if not self:is_same(current_value, new_value) then
					self:set_user_setting(save_location, id, new_value)

					dirty = true
					require_apply = require_apply or setting_changed.require_apply
				end
			end
		end

		if dirty then
			if require_apply then
				self:apply_user_settings()
			end

			self:save_user_settings()
		end
	end
end

mod.save_user_settings = function (self)
	local perf_counter = Application.query_performance_counter()

	Application.save_user_settings()

	local user_settings_save_duration = Application.time_since_query(perf_counter)

	self:print_func("Time to save settings: %.1fms", user_settings_save_duration)
end

mod.apply_user_settings = function (self)
	local perf_counter = Application.query_performance_counter()

	Application.apply_user_settings()
	Application.save_user_settings()

	local user_settings_apply_duration = Application.time_since_query(perf_counter)

	self:print_func("Time to apply settings: %.1fms", user_settings_apply_duration)

	-- Render static shadows
	Renderer.bake_static_shadows()

	local event_manager = rawget(_G, "Managers") and Managers.event

	if event_manager then
		event_manager:trigger("event_on_render_settings_applied")
	end
end

mod.is_same = function (self, current, new)
	if current == new then
		return true
	elseif type(current) == "table" and type(new) == "table" then
		for k, v in pairs(current) do
			if new[k] ~= v then
				return false
			end
		end

		for k, v in pairs(new) do
			if current[k] ~= v then
				return false
			end
		end

		return true
	else
		return false
	end
end

mod.print_func = function (self, format, ...)
	print(string.format("[RenderSettings] " .. format, ...))
end

mod.set_user_setting = function (self, location, key, value)
	local perf_counter = Application.query_performance_counter()

	if location then
		Application.set_user_setting(location, key, value)

		if location == "render_settings" and type(value) ~= "table" then
			Application.set_render_setting(key, tostring(value))
		end
	else
		Application.set_user_setting(key, value)
	end

	local settings_parse_duration = Application.time_since_query(perf_counter)

	self:print_func("Time to parse setting [%s] with new value (%s): %.1fms.", key, value, settings_parse_duration)
end

mod.get_user_setting = function (self, location, key)
	if location then
		return Application.user_setting(location, key)
	else
		return Application.user_setting(key)
	end
end

mod.remove_repeated_entries = function (self, changes_list, start_index)
	if not changes_list or #changes_list < 1 then
		return {}
	end

	local start_index = start_index or 1

	if start_index >= #changes_list then
		return changes_list
	else
		local occurences = {}
		local entry = changes_list[start_index]

		for i = start_index + 1, #changes_list do
			local stored_change = changes_list[i]

			if stored_change and stored_change.id == entry.id then
				occurences[#occurences + 1] = i
			end
		end

		local new_table = {}

		if #occurences > 0 then
			local count = #changes_list

			for i = 1, #occurences do
				local index = occurences[i]
				changes_list[index] = nil
			end

			for i = 1, count do
				if changes_list[i] then
					new_table[#new_table + 1] = changes_list[i]
				end
			end
		else
			new_table = changes_list
		end

		return self:remove_repeated_entries(new_table, start_index + 1)
	end
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

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
		if type(this_mod) == "table" and this_mod.settings_extension_add_options then

			local text = this_mod.text or name
            local text_id = "menu_group_mods_"..name
			self:add_global_localize_strings({
                [text_id] = {
                    en = text,
                },
            })

			-- local options_no_after = 0
			-- for _, option in pairs(this_mod.settings_extension_add_options) do
			-- 	if not option.after then
			-- 		options_no_after = options_no_after + 1
			-- 	end
			-- end

			-- if options_no_after > 0 then
			-- 	settings[#settings+1] = {
			-- 		widget_type = "group_header",
			-- 		group_name = "mods_settings",
			-- 		display_name = text_id,
			-- 		category = "menu_category_mods",
			-- 		custom = true,
			-- 	}
			-- end

			for _, setting in pairs(this_mod.settings_extension_add_options) do
				if setting.after then
					local this_setting = nil

					if setting.type == "checkbox" then
						this_setting = self:checkbox(setting)
					elseif setting.type == "dropdown" then
						this_setting = self:dropdown(setting)
					elseif setting.type == "value_slider" then
						this_setting = self:value_slider(setting)
					elseif setting.type == "percent_slider" then
						this_setting = self:percent_slider(setting)
					end

					this_setting.custom = true
					this_setting.category = this_setting.category or "menu_category_mods"
					this_setting.indentation_level = this_setting.after and 1 or 0
					if this_setting.after then
						local index = self:after_index(OptionsView, this_setting.after)
						table.insert(settings, index, this_setting)
					else
						settings[#settings+1] = this_setting
					end
				end
			end
			
		end
	end
end

mod.extend_settings = function (self, OptionsView)
	for name, this_mod in pairs(DMF.mods) do
		--and type(this_mod.settings_extension_extend_ui) == "function"
		if type(this_mod) == "table" and this_mod.settings_extension_extend_ui then
			this_mod:settings_extension_extend_ui(OptionsView)
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- Setup Mods options on enter
mod:hook(CLASS.OptionsView, "on_enter", function (func, self, ...)

	if not mod.initialized then

		self._options_templates = Mods.original_require("scripts/settings/options/options_templates")

		mod:remove_modded_settings(self)
		mod:create_settings(self)

		mod:extend_settings(self)

		mod.initialized = true
	end

	func(self, ...)
end)
