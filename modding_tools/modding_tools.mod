return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`modding_tools` encountered an error loading the Darktide Mod Framework.")

		new_mod("modding_tools", {
			mod_script       = "modding_tools/scripts/mods/modding_tools/modding_tools",
			mod_data         = "modding_tools/scripts/mods/modding_tools/modding_tools_data",
			mod_localization = "modding_tools/scripts/mods/modding_tools/modding_tools_localization",
		})
	end,
	packages = {},
}
