return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visible_equipment_example_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("visible_equipment_example_plugin", {
			mod_script       = "visible_equipment_example_plugin/scripts/mods/visible_equipment_example_plugin/visible_equipment_example_plugin",
			mod_data         = "visible_equipment_example_plugin/scripts/mods/visible_equipment_example_plugin/visible_equipment_example_plugin_data",
			mod_localization = "visible_equipment_example_plugin/scripts/mods/visible_equipment_example_plugin/visible_equipment_example_plugin_localization",
		})
	end,
	packages = {},
}
