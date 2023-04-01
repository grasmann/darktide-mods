return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Scoreboard` encountered an error loading the Darktide Mod Framework.")

		new_mod("scoreboard", {
			mod_script       = "scoreboard/scripts/mods/scoreboard/scoreboard",
			mod_data         = "scoreboard/scripts/mods/scoreboard/scoreboard_data",
			mod_localization = "scoreboard/scripts/mods/scoreboard/scoreboard_localization",
		})
	end,
	packages = {},
}
