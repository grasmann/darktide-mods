return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visual_loadout_customization_community_patch` encountered an error loading the Darktide Mod Framework.")

		new_mod("visual_loadout_customization_community_patch", {
			mod_script       = "visual_loadout_customization_community_patch/scripts/mods/visual_loadout_customization_community_patch/visual_loadout_customization_community_patch",
			mod_data         = "visual_loadout_customization_community_patch/scripts/mods/visual_loadout_customization_community_patch/visual_loadout_customization_community_patch_data",
			mod_localization = "visual_loadout_customization_community_patch/scripts/mods/visual_loadout_customization_community_patch/visual_loadout_customization_community_patch_localization",
		})
	end,
	packages = {},
}
