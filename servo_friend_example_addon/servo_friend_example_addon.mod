return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`servo_friend_example_addon` encountered an error loading the Darktide Mod Framework.")

		new_mod("servo_friend_example_addon", {
			mod_script       = "servo_friend_example_addon/scripts/mods/servo_friend_example_addon/servo_friend_example_addon",
			mod_data         = "servo_friend_example_addon/scripts/mods/servo_friend_example_addon/servo_friend_example_addon_data",
			mod_localization = "servo_friend_example_addon/scripts/mods/servo_friend_example_addon/servo_friend_example_addon_localization",
		})
	end,
	packages = {},
	load_after = {
		"servo_friend",
	},
}
