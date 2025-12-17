local mod = get_mod("extended_weapon_customization")

local managers = Managers

mod:hook_require("scripts/managers/localization/localization_manager", function(instance)

	instance.has_localization = function(self, key)
		local raw_str = self:_lookup(key)
		if not raw_str then
			return false
		end
		return true
	end

end)

HasLocalization = function(key)
	return managers.localization:has_localization(key)
end

mod:add_global_localize_strings({
	loc_ewc_extended_weapon_customization = {
		en = "Extended Weapon Customization",
		["zh-cn"] = "扩展武器自定义",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset",
		["zh-cn"] = "重置",
	},
	loc_weapon_inventory_random_button = {
		en = "Random",
		["zh-cn"] = "随机",
	},
	loc_weapon_inventory_alternate_fire_toggle = {
		en = "Alternate Fire",
		["zh-cn"] = "次要开火模式",
	},
	loc_weapon_inventory_crosshair_toggle = {
		en = "Crosshair",
		["zh-cn"] = "准星",
	},
	loc_weapon_inventory_damage_type_toggle = {
		en = "Damage Type",
		["zh-cn"] = "伤害类型",
	},

	loc_weapon_inventory_color_text = {
		en = "Color",
	},
	loc_weapon_inventory_pattern_text = {
		en = "Pattern",
	},
	loc_weapon_inventory_wear_text = {
		en = "Wear",
	},

	loc_weapon_inventory_color_button = {
		en = "X",
	},
	loc_weapon_inventory_pattern_button = {
		en = "X",
	},
	loc_weapon_inventory_wear_button = {
		en = "X",
	},

	loc_weapon_inventory_tip_1_button = {
		en = "Okay",
		["zh-cn"] = "确定",
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
	attachment_slot_addon = {
		en = "Addon",
	},
	attachment_slot_stock = {
		en = "Stock",
		["zh-cn"] = "枪托",
	},
	attachment_slot_trinket_hook = {
		en = "Trinket Hook",
		["zh-cn"] = "饰品挂钩",
	},
	attachment_slot_underbarrel = {
		en = "Underbarrel",
		["zh-cn"] = "下挂",
	},
	attachment_slot_shaft = {
		en = "Shaft",
		["zh-cn"] = "杆身",
	},
	attachment_slot_blade = {
		en = "Blade",
		["zh-cn"] = "刀刃",
	},
	attachment_slot_teeth = {
		en = "Chain",
		["zh-cn"] = "链齿",
	},
	attachment_slot_chain = {
		en = "Chain",
		["zh-cn"] = "链条",
	},
	attachment_slot_body = {
		en = "Body",
		["zh-cn"] = "主体",
	},
	attachment_slot_shaft_upper = {
		en = "Upper Shaft",
		["zh-cn"] = "上杆身",
	},
	attachment_slot_shaft_lower = {
		en = "Lower Shaft",
		["zh-cn"] = "下杆身",
	},
	attachment_slot_hilt = {
		en = "Hilt",
		["zh-cn"] = "剑柄",
	},
	attachment_slot_emblem_left = {
		en = "Left Emblem",
		["zh-cn"] = "左徽章",
	},
	attachment_slot_emblem_right = {
		en = "Right Emblem",
		["zh-cn"] = "右徽章",
	},
	attachment_slot_connector = {
		en = "Connector",
		["zh-cn"] = "连接器",
	},
	attachment_slot_right = {
		en = "Right",
	},
	attachment_slot_left = {
		en = "Left",
	},
	attachment_slot_shield = {
		en = "Shield",
		["zh-cn"] = "盾牌",
	},
	attachment_slot_handle = {
		en = "Handle",
		["zh-cn"] = "手柄",
	},
	attachment_slot_bayonet = {
		en = "Bayonet",
		["zh-cn"] = "刺刀",
	},
	attachment_slot_rail = {
		en = "Rail",
		["zh-cn"] = "导轨",
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

	customization_menu_finished_tutorial = {
		en = "Hide Customization Menu Tutorial",
		["zh-cn"] = "隐藏自定义菜单教程",
	},
	customization_menu_finished_tutorial_tooltip = {
		en = "Switch this off to see the tutorial in the weapon customization menu.",
		["zh-cn"] = "关闭此选项以在武器自定义菜单中查看教程",
	},

	mod_tips_01 = {
		en = "Welcome to the {#color(226, 199, 126)}extended weapon customization menu{#reset()}.\n\nIn this menu you will customize all your weapons.\n\nThis little tutorial will explain the {#color(226, 199, 126)}controls{#reset()} and what they are for.",
		["zh-cn"] = "欢迎使用 {#color(226, 199, 126)}扩展武器自定义菜单{#reset()}。\n\n在此菜单中，您可以自定义所有武器。\n\n本教程将解释 {#color(226, 199, 126)}控制方式{#reset()} 及其用途。",
	},
	mod_tips_title_01 = {
		en = "Welcome",
		["zh-cn"] = "欢迎",
	},
	mod_tips_02 = {
		en = "The {#color(226, 199, 126)}attachment slot menu{#reset()} provides a list of attachment slots that apply to the customized weapon.\n\n{#color(226, 199, 126)}Click{#reset()} on an entry to open the corresponding {#color(226, 199, 126)}attachment selection grid{#reset()}.\n\nYou can click one right now!",
		["zh-cn"] = "{#color(226, 199, 126)}配件槽位菜单{#reset()} 列出了适用于当前武器的配件槽位。\n\n{#color(226, 199, 126)}点击{#reset()} 条目可打开相应的 {#color(226, 199, 126)}配件选择网格{#reset()}。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_02 = {
		en = "Attachment Slot Menu",
		["zh-cn"] = "配件槽位菜单",
	},
	mod_tips_03 = {
		en = "The {#color(226, 199, 126)}attachment selection grid{#reset()} provides a list of attachments that can be applied to the selected attachment slot.\n\n{#color(226, 199, 126)}Click{#reset()} on an entry to {#color(226, 199, 126)}preview{#reset()} the attachment on the customized weapon or {#color(226, 199, 126)}right click{#reset()} an entry to immediately {#color(226, 199, 126)}equip{#reset()} it.\n\nYou can click one right now!",
		["zh-cn"] = "{#color(226, 199, 126)}配件选择网格{#reset()} 列出了可应用于所选配件槽位的配件。\n\n{#color(226, 199, 126)}点击{#reset()} 条目可 {#color(226, 199, 126)}预览{#reset()} 配件在武器上的效果，或 {#color(226, 199, 126)}右键点击{#reset()} 条目立即 {#color(226, 199, 126)}装备{#reset()} 该配件。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_03 = {
		en = "Attachment Selection Grid",
		["zh-cn"] = "配件选择网格",
	},
	mod_tips_04 = {
		en = "The {#color(226, 199, 126)}feature toggle buttons{#reset()} are used to toggle features that attachments define.\nAttachments can define various {#color(226, 199, 126)}overwrites{#reset()} for crosshair, alternate fire mode or damage types and such.\n{#color(226, 199, 126)}Click{#reset()} on the button to {#color(226, 199, 126)}toggle{#reset()} the feature on and off.\nIf the text is red it is disabled.\n\nYou can click one right now!",
		["zh-cn"] = "{#color(226, 199, 126)}功能切换按钮{#reset()} 用于切换配件定义的功能。\n配件可以定义各种 {#color(226, 199, 126)}覆盖设置{#reset()}，如准星、次要开火模式或伤害类型等。\n{#color(226, 199, 126)}点击{#reset()} 按钮可 {#color(226, 199, 126)}切换{#reset()} 功能的开启和关闭。\n如果文本为红色，则表示该功能已禁用。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_04 = {
		en = "Feature Toggle Buttons",
		["zh-cn"] = "功能切换按钮",
	},
	mod_tips_05 = {
		en = "Material Overrides",
	},
	mod_tips_title_05 = {
		en = "{#color(226, 199, 126)}Material Overrides{#reset()} can change the color, patterns and wear of attachments.\n\nSelected material overrides apply to the attachment they are chosen for and all sub-attachments.",
	},
	mod_tips_06 = {
		en = "{#color(226, 199, 126)}Equip{#reset()} to apply the currently selected attachment.\n\n{#color(226, 199, 126)}Reset{#reset()} to remove all customized attachments and return the weapon to its default state.\n\n{#color(226, 199, 126)}Random{#reset()} to randomize the attachments on the weapon.\n\nYou can click {#color(226, 199, 126)}Random{#reset()} right now!",
		["zh-cn"] = "{#color(226, 199, 126)}装备{#reset()} 以应用当前选中的配件。\n\n{#color(226, 199, 126)}重置{#reset()} 以移除所有自定义配件并将武器恢复至默认状态。\n\n{#color(226, 199, 126)}随机{#reset()} 以随机化武器上的配件。\n\n您现在就可以点击 {#color(226, 199, 126)}随机{#reset()} 试试！",
	},
	mod_tips_title_06 = {
		en = "Control Buttons",
		["zh-cn"] = "控制按钮",
	},

	group_debug = {
		en = "Debug",
		["zh-cn"] = "调试",
	},
	debug_mode = {
		en = "Debug Mode",
		["zh-cn"] = "调试模式",
	},
	debug_mode_tooltip = {
		en = "Debug Mode outputs some debug info.",
		["zh-cn"] = "调试模式会输出一些调试信息",
	},
	clear_chat = {
		en = "Clear Chat",
		["zh-cn"] = "清空聊天",
	},
	clear_chat_tooltip = {
		en = "Clears the chat.",
		["zh-cn"] = "清空聊天记录",
	},

	group_randomize = {
		en = "Randomize",
		["zh-cn"] = "随机化",
	},
	mod_option_randomize_players = {
		en = "Randomize Players",
		["zh-cn"] = "玩家装备随机化",
	},
	mod_option_randomize_players_tooltip = {
		en = "Randomize weapons of other players.",
		["zh-cn"] = "其他玩家的武器配件随机化",
	},
	mod_option_randomize_store = {
		en = "Randomize Store",
		["zh-cn"] = "商店装备随机化",
	},
	mod_option_randomize_store_tooltip = {
		en = "Randomize weapons in the store.",
		["zh-cn"] = "商店中的武器配件随机化",
	},
	mod_option_randomize_reward = {
		en = "Randomize Reward",
		["zh-cn"] = "帝皇之礼随机化",
	},
	mod_option_randomize_reward_tooltip = {
		en = "Randomize weapons that are mission rewards.",
		["zh-cn"] = "任务获得的奖励武器，配件随机化",
	},

	group_overrides = {
		en = "Allow Overrides",
		["zh-cn"] = "允许覆盖",
	},
	mod_allow_crosshair_type_override = {
		en = "Crosshair",
		["zh-cn"] = "准星",
	},
	mod_allow_crosshair_type_override_tooltip = {
		en = "Allow attachments to override the crosshair of a weapon.",
		["zh-cn"] = "允许配件覆盖武器的准星设置",
	},
	mod_allow_alternate_fire_override = {
		en = "Alternate Fire",
		["zh-cn"] = "次要开火模式",
	},
	mod_allow_alternate_fire_override_tooltip = {
		en = "Allow attachments to override the alternate fire animations of a weapon.",
		["zh-cn"] = "允许配件覆盖武器的次要开火模式动画",
	},

	group_misc = {
		en = "Misc",
		["zh-cn"] = "杂项",
	},
	mod_option_sway = {
		en = "Sway",
		["zh-cn"] = "晃动效果",
	},
	mod_option_sway_tooltip = {
		en = "Weapon sways when you rotate your character.",
		["zh-cn"] = "角色旋转时武器会晃动",
	},
	mod_option_crouch = {
		en = "Crouch",
		["zh-cn"] = "下蹲姿势",
	},
	mod_option_crouch_tooltip = {
		en = "Weapon changes pose when you crouch.",
		["zh-cn"] = "下蹲时持有武器的姿势会发生改变",
	},
	mod_option_crouch_melee = {
		en = "Crouch Melee",
		["zh-cn"] = "下蹲近战",
	},
	mod_option_crouch_melee_tooltip = {
		en = "Weapon changes pose when you crouch and attack.",
		["zh-cn"] = "下蹲并攻击时持有武器的姿势会改变",
	},
	mod_weapon_dof_strength = {
		en = "Weapon DOF Strength",
		["zh-cn"] = "武器景深强度",
	},
	mod_weapon_dof_strength_tooltip = {
		en = "DOF strength on the weapon.",
		["zh-cn"] = "武器上的景深效果强度",
	},
	mod_option_shield_transparency = {
		en = "Shield Transparency",
		["zh-cn"] = "盾牌透明度",
	},
	mod_option_shield_transparency_tooltip = {
		en = "Transparency of shields when aiming / blocking.",
		["zh-cn"] = "瞄准/格挡时盾牌的透明度",
	},
	mod_lense_completely_transparent = {
		en = "Lense Transparent",
		["zh-cn"] = "镜片透明",
	},
	mod_lense_completely_transparent_tooltip = {
		en = "Makes scope lenses completely transparent when aiming.",
		["zh-cn"] = "瞄准时使瞄准镜镜片完全透明",
	},

	group_flashlight = {
		en = "Flashlight",
		["zh-cn"] = "手电筒",
	},
	mod_option_flashlight_shadows = {
		en = "Cast Shadows",
		["zh-cn"] = "投射阴影",
	},
	mod_option_flashlight_shadows_tooltip = {
		en = "Flashlight casts shadows.",
		["zh-cn"] = "手电筒会投射阴影",
	},
	mod_toggle_flashlight_interact_aim = {
		en = "Toggle on Aiming Interact",
		["zh-cn"] = "瞄准时交互切换",
	},
	mod_toggle_flashlight_interact_aim_tooltip = {
		en = "Toggle flashlight by pressing the interact button when aiming.",
		["zh-cn"] = "瞄准时按下交互键切换手电筒",
	},
	mod_toggle_flashlight_interact_double = {
		en = "Toggle on Double Interact",
		["zh-cn"] = "双击交互切换",
	},
	mod_toggle_flashlight_interact_double_tooltip = {
		en = "Toggle flashlight by pressing the interact button two times in quick succession when not aiming.",
		["zh-cn"] = "非瞄准状态下快速连续按两次交互键切换手电筒",
	},
	mod_flashlight_input_reminder = {
		en = "Flashlight Input Reminder",
		["zh-cn"] = "手电筒输入提醒",
	},
	mod_flashlight_input_reminder_tooltip = {
		en = "Flashlight input reminder when using a modded flashlight.",
		["zh-cn"] = "使用改装手电筒时显示输入提醒",
	},
	mod_flashlight_input_reminder_text = {
		en = " Modded flashlight.\nInteract toggles the flashlight while aiming or double press. Toggle this reminder in options.",
		["zh-cn"] = " 改装手电筒\n瞄准时按交互键或双击交互键切换手电筒。可在选项中关闭此提醒",
	},
}
