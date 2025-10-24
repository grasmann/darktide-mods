local mod = get_mod("ewc_example_plugin_2")

mod:add_global_localize_strings({

	loc_example_scope_01 = {
		en = "The Scope",
	},

})

return {

	mod_title = {
		en = "EWCxample2",
	},
	mod_description = {
		en = "Example plugin 2 for extended weapon customization.",
	},

	group_misc = {
		en = "Misc",
	},
	mod_option_scope_randomization = {
		en = "Randomize Scopes",
	},
	mod_option_scope_randomization_tooltip = {
		en = "Allows randomized weapons to have scopes.",
	},

}
