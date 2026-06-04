return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`servo_friend_plugin_hat_cables` encountered an error loading the Darktide Mod Framework.")

		new_mod("servo_friend_plugin_hat_cables", {
			mod_script       = "servo_friend_plugin_hat_cables/scripts/mods/servo_friend_plugin_hat_cables/servo_friend_plugin_hat_cables",
			mod_data         = "servo_friend_plugin_hat_cables/scripts/mods/servo_friend_plugin_hat_cables/servo_friend_plugin_hat_cables_data",
			mod_localization = "servo_friend_plugin_hat_cables/scripts/mods/servo_friend_plugin_hat_cables/servo_friend_plugin_hat_cables_localization",
		})
	end,
	packages = {},
}
