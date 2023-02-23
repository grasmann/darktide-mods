return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`settings_extension` encountered an error loading the Darktide Mod Framework.")

		new_mod("settings_extension", {
			mod_script       = "settings_extension/scripts/mods/settings_extension/settings_extension",
			mod_data         = "settings_extension/scripts/mods/settings_extension/settings_extension_data",
			mod_localization = "settings_extension/scripts/mods/settings_extension/settings_extension_localization",
		})
	end,
	packages = {},
}
