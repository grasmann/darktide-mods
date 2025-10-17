local mod = get_mod("visible_equipment")

mod:add_global_localize_strings({
	attachment_slot_scabbard = {
		en = "Scabbard",
		["zh-cn"] = "刀鞘",
	},
	loc_visible_equipment = {
		en = "Visible Equipment",
		de = "Sichtbare Ausrüstung",
		["zh-cn"] = "可见装备",
	},
})

return {
	mod_title = {
		en = "Visible Equipment",
		de = "Sichtbare Ausrüstung",
		["zh-cn"] = "可见装备",
	},
	mod_description = {
		en = "Shows unwielded equipment on the character.",
		de = "Zeigt nicht genutzte Ausrüstung am Charakter.",
		["zh-cn"] = "在游戏角色身上显示未装备的近战、远程武器",
	},
	mod_option_sounds_self = {
		en = "Sounds from own character",
		de = "Sounds vom eigenen Charakter",
		["zh-cn"] = "自身音效",
	},
	mod_option_sounds_self_tooltip = {
		en = "Config sounds triggered by own character.",
		de = "Konfiguriere Sounds, die vom eigenen Charakter ausgelöst werden.",
		["zh-cn"] = "配置由自身触发的各种装备音效",
	},
	mod_option_sounds_self_on = {
		en = "On",
		de = "An",
		["zh-cn"] = "开启",
	},
	mod_option_sounds_self_third_person = {
		en = "Third Person",
		de = "Dritte Person",
		["zh-cn"] = "第三人称",
	},
	mod_option_sounds_self_first_person = {
		en = "First Person",
		de = "Erste Person",
		["zh-cn"] = "第一人称",
	},
	mod_option_sounds_self_off = {
		en = "Off",
		de = "Aus",
		["zh-cn"] = "关闭",
	},
	mod_option_sounds_others = {
		en = "Sounds from other characters",
		de = "Sounds von anderen Charakteren",
		["zh-cn"] = "其他玩家音效",
	},
	mod_option_sounds_others_tooltip = {
		en = "Toggle sounds triggered by other characters.",
		de = "Aktiviere Sounds, die von anderen Charakteren ausgelost werden.",
		["zh-cn"] = "配置由其他玩家触发的各种装备音效",
	},
	mod_option_sounds_others_on = {
		en = "On",
		de = "An",
		["zh-cn"] = "开启",
	},
	mod_option_sounds_others_off = {
		en = "Off",
		de = "Aus",
		["zh-cn"] = "关闭",
	},
	mod_option_animations = {
		en = "Animations",
		de = "Animationen",
		["zh-cn"] = "动画效果",
	},
	mod_option_animations_tooltip = {
		en = "Toggle animations.",
		de = "Aktiviere Animationen.",
		["zh-cn"] = "切换动画效果",
	},
	mod_option_random_placements = {
		en = "Random Placements",
		de = "Zufallige Platzierungen",
		["zh-cn"] = "随机位置",
	},
	mod_option_random_placements_tooltip = {
		en = "Random equipment placements for other players.",
		de = "Zufallige Ausrüstungsplatzierungen für andere Spieler.",
		["zh-cn"] = "为其他玩家随机生成装备位置",
	},
	mod_option_left_hand_visibility = {
		en = "Shield Visibility",
		de = "Schild Sichtbarkeit",
		["zh-cn"] = "盾牌可见性",
	},
	mod_option_left_hand_visibility_tooltip = {
		en = "Toggle shield visibility.\n\nDefault:\nBoth shields are visible on the character.\n\nOnly carry on:\nOnly one shield is visible on characters back.\n\nOnly one:\nOnly one shield is visible on the character.",
		de = "Aktiviere Schild Sichtbarkeit.\n\nStandard:\nBeide Schilder sind am Charakter sichtbar.\n\nNur eins tragen:\nNur ein Schild ist auf dem Rücken sichtbar.\n\nNur eins:\nNur ein Schild ist am Charakter sichtbar.",
		["zh-cn"] = "切换盾牌可见性\n\n默认：\n两个盾牌都在角色身上可见\n\n只携带一个：\n只有一个盾牌在角色背部可见\n\n只显示一个：\n只有一个盾牌在角色身上可见",
	},
	mod_option_left_hand_visibility_default = {
		en = "Default",
		de = "Standard",
		["zh-cn"] = "默认",
	},
	mod_option_left_hand_visibility_one_on_back = {
		en = "Only carry one",
		de = "Nur eins tragen",
		["zh-cn"] = "只携带一个",
	},
	mod_option_left_hand_visibility_one_visible = {
		en = "Only one",
		de = "Nur eins",
		["zh-cn"] = "只显示一个",
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

	slot_primary_placement = {
		en = "Primary Placement",
		de = "Primäre Platzierung",
		["zh-cn"] = "主武器位置",
	},
	slot_secondary_placement = {
		en = "Secondary Placement",
		de = "Sekundäre Platzierung",
		["zh-cn"] = "副武器位置",
	},
	placement_leg_left = {
		en = "Left Leg",
		de = "Linkes Bein",
		["zh-cn"] = "左腿",
	},
	placement_leg_right = {
		en = "Right Leg",
		de = "Rechtes Bein",
		["zh-cn"] = "右腿",
	},
	placement_hip_front = {
		en = "Hips Front",
		de = "Hüfte Vorne",
		["zh-cn"] = "腰部前方",
	},
	placement_hip_right = {
		en = "Hips Right",
		de = "Hüfte Rechts",
		["zh-cn"] = "腰部右侧",
	},
	placement_hip_left = {
		en = "Hips Left",
		de = "Hüfte Links",
		["zh-cn"] = "腰部左侧",
	},
	placement_hip_back = {
		en = "Hips Back",
		de = "Hüfte Hinten",
		["zh-cn"] = "腰部后方",
	},
	placement_default = {
		en = "Default",
		de = "Standard",
		["zh-cn"] = "默认位置",
	},
	placement_back = {
		en = "Back",
		de = "Rücken",
		["zh-cn"] = "背部",
	},
	placement_backpack = {
		en = "Backpack",
		de = "Rucksack",
		["zh-cn"] = "背包位置",
	},
}
