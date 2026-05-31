return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`unlock_ui_fps` encountered an error loading the Darktide Mod Framework.")

		new_mod("unlock_ui_fps", {
			mod_script       = "unlock_ui_fps/scripts/mods/unlock_ui_fps/unlock_ui_fps",
			mod_data         = "unlock_ui_fps/scripts/mods/unlock_ui_fps/unlock_ui_fps_data",
			mod_localization = "unlock_ui_fps/scripts/mods/unlock_ui_fps/unlock_ui_fps_localization",
		})
	end,
	packages = {},
}
