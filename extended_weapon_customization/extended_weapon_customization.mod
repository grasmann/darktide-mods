return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`extended_weapon_customization` encountered an error loading the Darktide Mod Framework.")

		new_mod("extended_weapon_customization", {
			mod_script       = "extended_weapon_customization/scripts/mods/extended_weapon_customization/extended_weapon_customization",
			mod_data         = "extended_weapon_customization/scripts/mods/extended_weapon_customization/extended_weapon_customization_data",
			mod_localization = "extended_weapon_customization/scripts/mods/extended_weapon_customization/extended_weapon_customization_localization",
		})
	end,
	packages = {},
}
