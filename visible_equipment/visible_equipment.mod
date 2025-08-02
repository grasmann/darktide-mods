return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visible_equipment` encountered an error loading the Darktide Mod Framework.")

		new_mod("visible_equipment", {
			mod_script       = "visible_equipment/scripts/mods/visible_equipment/visible_equipment",
			mod_data         = "visible_equipment/scripts/mods/visible_equipment/visible_equipment_data",
			mod_localization = "visible_equipment/scripts/mods/visible_equipment/visible_equipment_localization",
		})
	end,
	packages = {},
}
