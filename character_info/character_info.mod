return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`character_info` encountered an error loading the Darktide Mod Framework.")

		new_mod("character_info", {
			mod_script       = "character_info/scripts/mods/character_info/character_info",
			mod_data         = "character_info/scripts/mods/character_info/character_info_data",
			mod_localization = "character_info/scripts/mods/character_info/character_info_localization",
		})
	end,
	packages = {},
}
