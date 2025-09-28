local mod = get_mod("extended_weapon_customization")

mod:add_global_localize_strings({
	loc_extended_weapon_customization = {
		en = "Extended Weapon Customization",
		["zh-cn"] = "扩展武器自定义",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset",
	},
	loc_weapon_inventory_random_button = {
		en = "Random",
	},

	attachment_slot_pommel = {
		en = "Pommel",
		["zh-cn"] = "配重球",
	},
	attachment_slot_grip = {
		en = "Grip",
		["zh-cn"] = "握把",
	},
	attachment_slot_head = {
		en = "Head",
		["zh-cn"] = "头部",
	},
	attachment_slot_barrel = {
		en = "Barrel",
		["zh-cn"] = "枪管",
	},
	attachment_slot_muzzle = {
		en = "Muzzle",
		["zh-cn"] = "枪口",
	},
	attachment_slot_magazine = {
		en = "Magazine",
		["zh-cn"] = "弹匣",
	},
	attachment_slot_receiver = {
		en = "Receiver",
		["zh-cn"] = "机匣",
	},
	attachment_slot_flashlight = {
		en = "Flashlight",
		["zh-cn"] = "手电筒",
	},
	attachment_slot_sight = {
		en = "Sight",
		["zh-cn"] = "瞄具",
	},
	attachment_slot_stock = {
		en = "Stock",
		["zh-cn"] = "枪托",
	},
	attachment_slot_trinket_hook = {
		en = "Trinket Hook",
	},
	attachment_slot_underbarrel = {
		en = "Underbarrel",
	},
	attachment_slot_shaft = {
		en = "Shaft",
	},
	attachment_slot_blade = {
		en = "Blade",
	},
	attachment_slot_teeth = {
		en = "Chain",
	},
	attachment_slot_chain = {
		en = "Chain",
	},
	attachment_slot_body = {
		en = "Body",
	},
	attachment_slot_shaft_upper = {
		en = "Upper Shaft",
	},
	attachment_slot_shaft_lower = {
		en = "Lower Shaft",
	},
	attachment_slot_hilt = {
		en = "Hilt",
	},
	attachment_slot_emblem_left = {
		en = "Left Emblem",
	},
	attachment_slot_emblem_right = {
		en = "Right Emblem",
	},
	attachment_slot_connector = {
		en = "Connector",
	},
	attachment_slot_left = {
		en = "Shield",
	},
	attachment_slot_handle = {
		en = "Handle",
	},
	attachment_slot_bayonet = {
		en = "Bayonet",
	},
	attachment_slot_rail = {
		en = "Rail",
	}
})

return {
	mod_title = {
		en = "Extended Weapon Customization",
		["zh-cn"] = "扩展武器自定义",
	},
	mod_description = {
		en = "Extended Weapon Customization Description",
		["zh-cn"] = "扩展武器自定义功能，添加更多武器配件和定制选项",
	},
	mod_customize_button = {
		en = "Customize",
		["zh-cn"] = "自定义",
	},

	group_debug = {
		en = "Debug",
	},
	debug_mode = {
		en = "Debug Mode",
	},
	debug_mode_tooltip = {
		en = "Debug Mode outputs some debug info.",
	},
	clear_chat = {
		en = "Clear Chat",
	},
	clear_chat_tooltip = {
		en = "Clears the chat.",
	},

	group_misc = {
		en = "Misc",
	},
	mod_option_sway = {
		en = "Sway",
	},
	mod_option_sway_tooltip = {
		en = "Weapon sways when you rotate your character.",
	},
	mod_option_crouch = {
		en = "Crouch",
	},
	mod_option_crouch_tooltip = {
		en = "Weapon changes pose when you crouch.",
	},

	group_flashlight = {
		en = "Flashlight",
	},
	mod_option_flashlight_shadows = {
		en = "Cast Shadows",
	},
	mod_option_flashlight_shadows_tooltip = {
		en = "Flashlight casts shadows.",
	},
	mod_toggle_flashlight_interact_aim = {
		en = "Toggle on Aiming Interact",
	},
	mod_toggle_flashlight_interact_aim_tooltip = {
		en = "Toggle flashlight by pressing the interact button when aiming.",
	},
	mod_toggle_flashlight_interact_double = {
		en = "Toggle on Double Interact",
	},
	mod_toggle_flashlight_interact_double_tooltip = {
		en = "Toggle flashlight by pressing the interact button two times in quick succession when not aiming.",
	},
	mod_flashlight_input_reminder = {
		en = "Flashlight Input Reminder",
	},
	mod_flashlight_input_reminder_tooltip = {
		en = "Flashlight input reminder when using a modded flashlight.",
	},
	mod_flashlight_input_reminder_text = {
		en = " Modded flashlight.\nInteract toggles the flashlight while aiming or double press. Toggle this reminder in options.",
	},
}
