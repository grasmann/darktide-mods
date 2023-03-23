local mod = get_mod("graphics_options")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local graphics_options_settings = mod:io_dofile("graphics_options/scripts/mods/graphics_options/graphics_options_settings")

--#####  ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗ ######################################################
--##### ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ######################################################
--##### ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗ ######################################################
--##### ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║ ######################################################
--##### ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║ ######################################################
--#####  ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ######################################################

mod.settings_extension_add_options = {
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "dropdown",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "dropdown",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "value_slider",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
	{
		type = "checkbox",
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
			local settings_extension = get_mod("settings_extension")
			settings_extension:verify_and_apply_changes({
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
	},
}

--##### ███████╗██╗  ██╗████████╗███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗███████╗ #############################
--##### ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║██╔════╝ #############################
--##### █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║███████╗ #############################
--##### ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║╚════██║ #############################
--##### ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║███████║ #############################
--##### ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ #############################

mod.settings_extension_extend_ui = function(self, OptionsView)
	local settings = OptionsView._options_templates.settings
	for _, setting in pairs(settings) do
		-- Framerate cap
		if setting.id == "nv_reflex_framerate_cap" then
			setting.options = {}
			for _, cap in pairs(graphics_options_settings.frame_caps) do
				local display_name = cap == 0 and "loc_setting_nv_reflex_framerate_cap_unlimited" or "gm_framerate_cap_"..cap
				if cap > 0 then mod:add_global_localize_strings({[display_name] = {en = cap}}) end
				setting.options[#setting.options + 1] = {
					require_restart = false,
					require_apply = true,
					display_name = display_name,
					values = {
						render_settings = {
							nv_framerate_cap = cap,
						},
					},
					id = #setting.options,
				}
			end
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
end
