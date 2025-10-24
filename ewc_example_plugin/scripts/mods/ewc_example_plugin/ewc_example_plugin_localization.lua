local mod = get_mod("ewc_example_plugin")

mod:add_global_localize_strings({
	
	loc_ewc_blue_flashlights = {
		en = "EWCxample: Blue Flashlights",
	},

	loc_blue_flashlight_01 = {
		en = "The Blue Flashlight",
	},

})

return {

	mod_title = {
		en = "EWCxample",
	},
	mod_description = {
		en = "Example plugin for extended weapon customization.",
	},

	group_misc = {
		en = "Misc",
	},
	mod_option_blue_flashlight_randomization = {
		en = "Randomize Blue Flashlights",
	},
	mod_option_blue_flashlight_randomization_tooltip = {
		en = "Allows randomized weapons to have blue flashlights.",
	},

}
