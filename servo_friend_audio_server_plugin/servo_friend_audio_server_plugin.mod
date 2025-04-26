return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`servo_friend_audio_server_plugin` encountered an error loading the Darktide Mod Framework.")

		new_mod("servo_friend_audio_server_plugin", {
			mod_script       = "servo_friend_audio_server_plugin/scripts/mods/servo_friend_audio_server_plugin/servo_friend_audio_server_plugin",
			mod_data         = "servo_friend_audio_server_plugin/scripts/mods/servo_friend_audio_server_plugin/servo_friend_audio_server_plugin_data",
			mod_localization = "servo_friend_audio_server_plugin/scripts/mods/servo_friend_audio_server_plugin/servo_friend_audio_server_plugin_localization",
		})
	end,
	packages = {},
	load_after = {
		"Audio",
		"DarktideLocalServer",
		"servo_friend",
	},
}
