return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`animation_events` encountered an error loading the Darktide Mod Framework.")

		new_mod("animation_events", {
			mod_script       = "animation_events/scripts/mods/animation_events/animation_events",
			mod_data         = "animation_events/scripts/mods/animation_events/animation_events_data",
			mod_localization = "animation_events/scripts/mods/animation_events/animation_events_localization",
		})
	end,
	packages = {},
}
