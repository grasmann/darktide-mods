return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`servo_friend_tag_cannon` encountered an error loading the Darktide Mod Framework.")

		new_mod("servo_friend_tag_cannon", {
			mod_script       = "servo_friend_tag_cannon/scripts/mods/servo_friend_tag_cannon/servo_friend_tag_cannon",
			mod_data         = "servo_friend_tag_cannon/scripts/mods/servo_friend_tag_cannon/servo_friend_tag_cannon_data",
			mod_localization = "servo_friend_tag_cannon/scripts/mods/servo_friend_tag_cannon/servo_friend_tag_cannon_localization",
		})
	end,
	packages = {},
	load_after = {
		"servo_friend",
	},
}
