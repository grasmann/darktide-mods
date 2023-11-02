return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`weapon_customization_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("weapon_customization_plugin", {
			mod_script       = "weapon_customization_plugin/scripts/mods/weapon_customization_plugin/weapon_customization_plugin",
			mod_data         = "weapon_customization_plugin/scripts/mods/weapon_customization_plugin/weapon_customization_plugin_data",
			mod_localization = "weapon_customization_plugin/scripts/mods/weapon_customization_plugin/weapon_customization_plugin_localization",
		})
	end,
	packages = {},
}
