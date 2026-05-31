return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`visual_loadout_customization_community_patch` encountered an error loading the Darktide Mod Framework.")

		new_mod("visual_loadout_customization_community_patch", {
			mod_script       = "visual_loadout_customization_community_patch/scripts/mods/vlccp/vlccp",
			mod_data         = "visual_loadout_customization_community_patch/scripts/mods/vlccp/vlccp_data",
			mod_localization = "visual_loadout_customization_community_patch/scripts/mods/vlccp/vlccp_localization",
		})
	end,
	packages = {},
	load_after = {
		"master_item_community_patch",
	},
	require = {
		"master_item_community_patch",
	},
}
