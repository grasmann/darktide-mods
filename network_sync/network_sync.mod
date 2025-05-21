return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`network_sync` encountered an error loading the Darktide Mod Framework.")

		new_mod("network_sync", {
			mod_script       = "network_sync/scripts/mods/network_sync/network_sync",
			mod_data         = "network_sync/scripts/mods/network_sync/network_sync_data",
			mod_localization = "network_sync/scripts/mods/network_sync/network_sync_localization",
		})
	end,
	packages = {},
}
