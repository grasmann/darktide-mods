local mod = get_mod("graphics_options")
local settings_extension = get_mod("settings_extension")

local DefaultGameParameters = Mods.original_require("scripts/foundation/utilities/parameters/default_game_parameters")
local OptionsUtilities = Mods.original_require("scripts/utilities/ui/options")
local render_settings = {}
local render_settings_by_id = {}

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

-- ##########################################################
-- ################## Options ###############################
mod.text = "Graphics Options"
mod.options = {
	settings_extension:checkbox({
		id = "sun_shadows",
		after = "light_quality",
		tooltip_text = "gm_sun_shadow_mo",
		display_name = "gm_sun_shadow",
		category = "loc_settings_menu_category_render",
		require_apply = true,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			light_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "sun_shadows",
				display_name = "gm_sun_shadow",
				tooltip_text = "gm_sun_shadow_mo",
				require_apply = true,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					light_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "sun_shadows")
		end,
	}),
	settings_extension:dropdown({
		id = "sun_shadow_map_quality",
		after = "light_quality",
		tooltip_text = "gm_sun_shadow_map_mo",
		display_name = "gm_sun_shadow_map",
		category = "loc_settings_menu_category_render",
		default_value = "2048",
		require_apply = true,
		require_restart = false,
		save_location = "render_settings",
		apply_values_on_edited = {
			light_quality = "custom"
		},
		options = {
			{
				id = "256",
				display_name = "gm_sun_shadow_map_256",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						sun_shadow_map_size = {
							256,
							256
						},
						static_sun_shadow_map_size = {
							256,
							256
						},
					}
				}
			},
			{
				id = "512",
				display_name = "gm_sun_shadow_map_512",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						sun_shadow_map_size = {
							512,
							512
						},
						static_sun_shadow_map_size = {
							512,
							512
						},
					}
				}
			},
			{
				id = "1024",
				display_name = "gm_sun_shadow_map_1024",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						sun_shadow_map_size = {
							1024,
							1024
						},
						static_sun_shadow_map_size = {
							1024,
							1024
						},
					}
				}
			},
			{
				id = "2048",
				display_name = "gm_sun_shadow_map_2048",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						sun_shadow_map_size = {
							2048,
							2048
						},
						static_sun_shadow_map_size = {
							2048,
							2048
						},
					}
				}
			},
			{
				id = "4096",
				display_name = "gm_sun_shadow_map_4096",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						sun_shadow_map_size = {
							4096,
							4096
						},
						static_sun_shadow_map_size = {
							4096,
							4096
						},
					}
				}
			},
		},
		change = function (new_value, template)
			-- Mods.debug.object.draw(template, "template", 10)
			mod:verify_and_apply_changes({
				id = "sun_shadow_map_quality",
				display_name = "gm_sun_shadow_map",
				tooltip_text = "gm_sun_shadow_map_mo",
				require_apply = true,
				require_restart = false,
				default_value = "2048",
				save_location = "render_settings",
				apply_values_on_edited = {
					light_quality = "custom"
				},
				options = template.options,
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "sun_shadow_map_quality")
		end,
	}),
	settings_extension:checkbox({
		id = "local_lights_shadows_enabled",
		after = "light_quality",
		tooltip_text = "gm_local_lights_shadow_mo",
		display_name = "gm_local_lights_shadow",
		category = "loc_settings_menu_category_render",
		require_apply = false,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			light_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "local_lights_shadows_enabled",
				value_type = "boolean",
				display_name = "gm_local_lights_shadow",
				tooltip_text = "gm_local_lights_shadow_mo",
				require_apply = false,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					light_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "local_lights_shadows_enabled")
		end,
	}),
	settings_extension:dropdown({
		id = "local_light_shadow_map_quality",
		after = "light_quality",
		tooltip_text = "gm_local_light_shadow_map_mo",
		display_name = "gm_local_light_shadow_map",
		category = "loc_settings_menu_category_render",
		default_value = "2048",
		require_apply = true,
		require_restart = false,
		save_location = "render_settings",
		apply_values_on_edited = {
			light_quality = "custom"
		},
		options = {
			{
				id = "256",
				display_name = "gm_local_light_shadow_map_256",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						local_lights_shadow_atlas_size = {
							256,
							256
						},
					}
				}
			},
			{
				id = "512",
				display_name = "gm_local_light_shadow_map_512",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						local_lights_shadow_atlas_size = {
							512,
							512
						},
					}
				}
			},
			{
				id = "1024",
				display_name = "gm_local_light_shadow_map_1024",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						local_lights_shadow_atlas_size = {
							1024,
							1024
						},
					}
				}
			},
			{
				id = "2048",
				display_name = "gm_local_light_shadow_map_2048",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						local_lights_shadow_atlas_size = {
							2048,
							2048
						},
					}
				}
			},
			{
				id = "4096",
				display_name = "gm_local_light_shadow_map_4096",
				require_apply = true,
				require_restart = false,
				apply_values_on_edited = {
					light_quality = "custom"
				},
				values = {
					render_settings = {
						local_lights_shadow_atlas_size = {
							4096,
							4096
						},
					}
				}
			},
		},
		change = function (new_value, template)
			-- Mods.debug.object.draw(template, "template", 10)
			mod:verify_and_apply_changes({
				id = "local_light_shadow_map_quality",
				display_name = "gm_local_light_shadow_map",
				tooltip_text = "gm_local_light_shadow_map_mo",
				require_apply = true,
				require_restart = false,
				default_value = "2048",
				save_location = "render_settings",
				options = template.options,
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "local_light_shadow_map_quality")
		end,
	}),
	settings_extension:value_slider({
		id = "volumetric_reprojection_amount",
		after = "volumetric_fog_quality",
		display_name = "gm_fog_quality",
		tooltip_text = "gm_fog_quality_mo",
		category = "loc_settings_menu_category_render",
		min_value = 0,
		max_value = 1,
		default_value = 0.5,
		num_decimals = 2,
		step_size_value = 0.1,
		apply_on_drag = true,
		require_apply = true,
		require_restart = false,
		save_location = "render_settings",
		apply_values_on_edited = {
			volumetric_fog_quality = "custom"
		},
		change = function (value)
			value = ((value * 1.75) - 0.875) * -1
			mod:verify_and_apply_changes({
				id = "volumetric_reprojection_amount",
				value_type = "number",
				display_name = "gm_fog_quality",
				tooltip_text = "gm_fog_quality_mo",
				require_apply = true,
				require_restart = false,
				default_value = 0.5,
				save_location = "render_settings",
				apply_values_on_edited = {
					volumetric_fog_quality = "custom"
				},
			}, value)
		end,
		get = function ()
			local value = Application.user_setting("render_settings", "volumetric_reprojection_amount") or 0
			value = math.abs(((value / 1.75) - 0.5) * -1)
			return value
		end,
	}),
	settings_extension:checkbox({
		id = "volumetric_lighting_local_lights",
		after = "volumetric_fog_quality",
		tooltip_text = "gm_fog_local_light_mo",
		display_name = "gm_fog_local_light",
		category = "loc_settings_menu_category_render",
		require_apply = true,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			volumetric_fog_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "volumetric_lighting_local_lights",
				value_type = "boolean",
				display_name = "gm_fog_local_light",
				tooltip_text = "gm_fog_local_light_mo",
				require_apply = true,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					volumetric_fog_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "volumetric_lighting_local_lights")
		end,
	}),
	settings_extension:checkbox({
		id = "light_shafts_enabled",
		after = "volumetric_fog_quality",
		tooltip_text = "gm_fog_light_shafts_mo",
		display_name = "gm_fog_light_shafts",
		category = "loc_settings_menu_category_render",
		require_apply = true,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			volumetric_fog_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "light_shafts_enabled",
				value_type = "boolean",
				display_name = "gm_fog_light_shafts",
				tooltip_text = "gm_fog_light_shafts_mo",
				require_apply = true,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					volumetric_fog_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "light_shafts_enabled")
		end,
	}),
	settings_extension:checkbox({
		id = "volumetric_extrapolation_high_quality",
		after = "volumetric_fog_quality",
		tooltip_text = "gm_fog_high_quality_mo",
		display_name = "gm_fog_high_quality",
		category = "loc_settings_menu_category_render",
		require_apply = true,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			volumetric_fog_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "volumetric_extrapolation_high_quality",
				value_type = "boolean",
				display_name = "gm_fog_high_quality",
				tooltip_text = "gm_fog_high_quality_mo",
				require_apply = true,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					volumetric_fog_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "volumetric_extrapolation_high_quality")
		end,
	}),
	settings_extension:checkbox({
		id = "volumetric_extrapolation_volumetric_shadows",
		after = "volumetric_fog_quality",
		tooltip_text = "gm_fog_volumetric_shadows_mo",
		display_name = "gm_fog_volumetric_shadows",
		category = "loc_settings_menu_category_render",
		require_apply = true,
		require_restart = false,
		default_value = true,
		save_location = "render_settings",
		apply_values_on_edited = {
			volumetric_fog_quality = "custom"
		},
		change = function (new_value)
			mod:verify_and_apply_changes({
				id = "volumetric_extrapolation_volumetric_shadows",
				value_type = "boolean",
				display_name = "gm_fog_volumetric_shadows",
				tooltip_text = "gm_fog_volumetric_shadows_mo",
				require_apply = true,
				require_restart = false,
				default_value = true,
				save_location = "render_settings",
				apply_values_on_edited = {
					volumetric_fog_quality = "custom"
				},
			}, new_value)
		end,
		get = function ()
			return Application.user_setting("render_settings", "volumetric_extrapolation_volumetric_shadows")
		end,
	}),
}

settings_extension:extend(function(OptionsView)
	local settings = OptionsView._options_templates.settings
	for _, setting in pairs(settings) do
		-- Framerate cap
		if setting.id == "nv_reflex_framerate_cap" then
			local index = #setting.options + 1
			setting.options[index] = {
				require_restart = false,
				require_apply = true,
				display_name = "gm_framerate_cap_144",
				values = {
					render_settings = {
						nv_framerate_cap = 144,
					},
				},
				id = index - 1,
			}
		end
		-- Light quality
		if setting.id == "light_quality" then
			setting.options[1].values.render_settings.sun_shadow_map_quality = "2048"
			setting.options[1].values.render_settings.local_light_shadow_map_quality = "512"
			setting.options[2].values.render_settings.sun_shadow_map_quality = "2048"
			setting.options[2].values.render_settings.local_light_shadow_map_quality = "1024"
			setting.options[3].values.render_settings.sun_shadow_map_quality = "2048"
			setting.options[3].values.render_settings.local_light_shadow_map_quality = "2048"
			setting.options[4].values.render_settings.sun_shadow_map_quality = "2048"
			setting.options[4].values.render_settings.local_light_shadow_map_quality = "4096"
			setting.options[5] = {
				display_name = "loc_setting_graphics_quality_option_custom",
				id = "custom",
			}
		end
		-- Volumetric fog
		if setting.id == "volumetric_fog_quality" then
			setting.options[5] = {
				display_name = "loc_setting_graphics_quality_option_custom",
				id = "custom",
			}
		end
	end
	-- mdods(settings, "options_templates", 7)
end)
