return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`scoreboard_example_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("scoreboard_example_plugin", {
			mod_script       = "scoreboard_example_plugin/scripts/mods/scoreboard_example_plugin/scoreboard_example_plugin",
			mod_data         = "scoreboard_example_plugin/scripts/mods/scoreboard_example_plugin/scoreboard_example_plugin_data",
			mod_localization = "scoreboard_example_plugin/scripts/mods/scoreboard_example_plugin/scoreboard_example_plugin_localization",
		})
	end,
	packages = {},
}
