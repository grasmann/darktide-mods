return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`extended_weapon_customization_base_additions` encountered an error loading the Darktide Mod Framework.")

		new_mod("extended_weapon_customization_base_additions", {
			mod_script       = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/ewc_ba",
			mod_data         = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/ewc_ba_data",
			mod_localization = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/ewc_ba_localization",
		})
	end,
	packages = {},
}
