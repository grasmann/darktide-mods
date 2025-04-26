return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`cancel_loading` encountered an error loading the Darktide Mod Framework.")

		new_mod("cancel_loading", {
			mod_script       = "cancel_loading/scripts/mods/cancel_loading/cancel_loading",
			mod_data         = "cancel_loading/scripts/mods/cancel_loading/cancel_loading_data",
			mod_localization = "cancel_loading/scripts/mods/cancel_loading/cancel_loading_localization",
		})
	end,
	packages = {},
}
