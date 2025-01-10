return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`master_item_community_patch` encountered an error loading the Darktide Mod Framework.")

		new_mod("master_item_community_patch", {
			mod_script       = "master_item_community_patch/scripts/mods/master_item_community_patch/master_item_community_patch",
			mod_data         = "master_item_community_patch/scripts/mods/master_item_community_patch/master_item_community_patch_data",
			mod_localization = "master_item_community_patch/scripts/mods/master_item_community_patch/master_item_community_patch_localization",
		})
	end,
	packages = {},
}
