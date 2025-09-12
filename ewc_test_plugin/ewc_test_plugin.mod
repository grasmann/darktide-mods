return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`ewc_test_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("ewc_test_plugin", {
			mod_script       = "ewc_test_plugin/scripts/mods/ewc_test_plugin/ewc_test_plugin",
			mod_data         = "ewc_test_plugin/scripts/mods/ewc_test_plugin/ewc_test_plugin_data",
			mod_localization = "ewc_test_plugin/scripts/mods/ewc_test_plugin/ewc_test_plugin_localization",
		})
	end,
	packages = {},
}
