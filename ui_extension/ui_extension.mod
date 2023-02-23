return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`ui_extension` encountered an error loading the Darktide Mod Framework.")

		new_mod("ui_extension", {
			mod_script       = "ui_extension/scripts/mods/ui_extension/ui_extension",
			mod_data         = "ui_extension/scripts/mods/ui_extension/ui_extension_data",
			mod_localization = "ui_extension/scripts/mods/ui_extension/ui_extension_localization",
		})
	end,
	packages = {},
}
