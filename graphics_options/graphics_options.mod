return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`graphics_options` encountered an error loading the Darktide Mod Framework.")

		new_mod("graphics_options", {
			mod_script       = "graphics_options/scripts/mods/graphics_options/graphics_options",
			mod_data         = "graphics_options/scripts/mods/graphics_options/graphics_options_data",
			mod_localization = "graphics_options/scripts/mods/graphics_options/graphics_options_localization",
		})
	end,
	packages = {},
}
