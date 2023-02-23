return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Scoreboard` encountered an error loading the Darktide Mod Framework.")

		new_mod("Scoreboard", {
			mod_script       = "Scoreboard/scripts/mods/Scoreboard/Scoreboard",
			mod_data         = "Scoreboard/scripts/mods/Scoreboard/Scoreboard_data",
			mod_localization = "Scoreboard/scripts/mods/Scoreboard/Scoreboard_localization",
		})
	end,
	packages = {},
}
