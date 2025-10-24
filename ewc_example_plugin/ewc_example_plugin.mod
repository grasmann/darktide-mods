return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`ewc_example_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("ewc_example_plugin", {
			mod_script       = "ewc_example_plugin/scripts/mods/ewc_example_plugin/ewc_example_plugin",
			mod_data         = "ewc_example_plugin/scripts/mods/ewc_example_plugin/ewc_example_plugin_data",
			mod_localization = "ewc_example_plugin/scripts/mods/ewc_example_plugin/ewc_example_plugin_localization",
		})
	end,
	packages = {},
}
