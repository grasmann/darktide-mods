return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`ewc_example_plugin_2` encountered an error loading the Darktide Mod Framework.")

		new_mod("ewc_example_plugin_2", {
			mod_script       = "ewc_example_plugin_2/scripts/mods/ewc_example_plugin_2/ewc_example_plugin_2",
			mod_data         = "ewc_example_plugin_2/scripts/mods/ewc_example_plugin_2/ewc_example_plugin_2_data",
			mod_localization = "ewc_example_plugin_2/scripts/mods/ewc_example_plugin_2/ewc_example_plugin_2_localization",
		})
	end,
	packages = {},
}
