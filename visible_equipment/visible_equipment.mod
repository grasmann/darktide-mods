return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visible_equipment` encountered an error loading the Darktide Mod Framework.")

		new_mod("visible_equipment", {
			mod_script       = "visible_equipment/scripts/mods/ve/ve",
			mod_data         = "visible_equipment/scripts/mods/ve/ve_data",
			mod_localization = "visible_equipment/scripts/mods/ve/ve_localization",
		})
	end,
	load_before = {
        "GoToMastery",
    },
	require = {
		"master_item_community_patch",
	},
	load_after = {
		"master_item_community_patch",
		"extended_weapon_customization",
		"extended_weapon_customization_base_additions",
	},
	packages = {},
}
