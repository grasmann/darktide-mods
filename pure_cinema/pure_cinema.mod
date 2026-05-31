return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`pure_cinema` encountered an error loading the Darktide Mod Framework.")

		new_mod("pure_cinema", {
			mod_script       = "pure_cinema/scripts/mods/pure_cinema/pure_cinema",
			mod_data         = "pure_cinema/scripts/mods/pure_cinema/pure_cinema_data",
			mod_localization = "pure_cinema/scripts/mods/pure_cinema/pure_cinema_localization",
		})
	end,
	packages = {},
}
