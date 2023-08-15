return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`weapon_customization` encountered an error loading the Darktide Mod Framework.")

		new_mod("weapon_customization", {
			mod_script       = "weapon_customization/scripts/mods/weapon_customization/weapon_customization",
			mod_data         = "weapon_customization/scripts/mods/weapon_customization/weapon_customization_data",
			mod_localization = "weapon_customization/scripts/mods/weapon_customization/weapon_customization_localization",
		})
	end,
	packages = {},
}
