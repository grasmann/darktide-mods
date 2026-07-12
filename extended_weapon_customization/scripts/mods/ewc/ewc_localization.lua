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
		de = "Extended Weapon Customization",
		["zh-cn"] = "扩展武器自定义",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset",
		de = "Zurücksetzen",
		["zh-cn"] = "重置",
	},
	loc_weapon_inventory_random_button = {
		en = "Random",
		de = "Zufällig",
		["zh-cn"] = "随机",
	},
	loc_weapon_inventory_alternate_fire_toggle = {
		en = "Alternate Fire",
		de = "Alternatives Feuer",
		["zh-cn"] = "次要开火模式",
	},
	loc_weapon_inventory_crosshair_toggle = {
		en = "Crosshair",
		de = "Zielkreuz",
		["zh-cn"] = "准星",
	},
	loc_weapon_inventory_damage_type_toggle = {
		en = "Damage Type",
		de = "Schadenstyp",
		["zh-cn"] = "伤害类型",
	},

	loc_weapon_inventory_color_text = {
		en = "Color",
		de = "Farbe",
		["zh-cn"] = "颜色",
	},
	loc_weapon_inventory_pattern_text = {
		en = "Pattern",
		de = "Muster",
		["zh-cn"] = "图案",
	},
	loc_weapon_inventory_wear_text = {
		en = "Wear",
		de = "Abnutzung",
		["zh-cn"] = "磨损",
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

	loc_weapon_inventory_plugin_warning = {
		en = "No plugins detected",
		de = "Keine Plugins gefunden",
		["zh-cn"] = "未检测到扩展插件",
	},
	loc_weapon_inventory_plugin_warning_text = {
		en = "Extended Weapon Customization has detected no plugins.\nThe main mod only provides functionality and access to default weapon attachments.",
		de = "Extended Weapon Customization hat keine Plugins erkannt.\nDie Hauptmod bietet nur Zugriff auf Standardwaffenteile.",
		["zh-cn"] = "未检测到任何配套插件。\n本体模组仅提供基础功能与原版自带配件。",
	},

	loc_weapon_inventory_tip_1_button = {
		en = "Okay",
		de = "Okay",
		["zh-cn"] = "确定",
	},

	attachment_slot_pommel = {
		en = "Pommel",
		de = "Knauf",
		["zh-cn"] = "配重尾锤",
	},
	attachment_slot_grip = {
		en = "Grip",
		de = "Griff",
		["zh-cn"] = "握把",
	},
	attachment_slot_head = {
		en = "Head",
		de = "Kopf",
		["zh-cn"] = "头部",
	},
	attachment_slot_barrel = {
		en = "Barrel",
		de = "Lauf",
		["zh-cn"] = "枪管",
	},
	attachment_slot_muzzle = {
		en = "Muzzle",
		de = "Mündung",
		["zh-cn"] = "枪口",
	},
	attachment_slot_magazine = {
		en = "Magazine",
		de = "Magazin",
		["zh-cn"] = "弹匣",
	},
	attachment_slot_receiver = {
		en = "Receiver",
		de = "Verschlussgehäuse",
		["zh-cn"] = "机匣",
	},
	attachment_slot_flashlight = {
		en = "Flashlight",
		de = "Lampe",
		["zh-cn"] = "手电筒",
	},
	attachment_slot_sight = {
		en = "Sight",
		de = "Visier",
		["zh-cn"] = "瞄具",
	},
	attachment_slot_addon = {
		en = "Addon",
		de = "Zusatz",
		["zh-cn"] = "附加组件",
	},
	attachment_slot_stock = {
		en = "Stock",
		de = "Kolben",
		["zh-cn"] = "枪托",
	},
	attachment_slot_trinket_hook = {
		en = "Trinket Hook",
		de = "Anhänger Haken",
		["zh-cn"] = "饰品挂钩",
	},
	attachment_slot_underbarrel = {
		en = "Underbarrel",
		de = "Unterer Lauf",
		["zh-cn"] = "下挂",
	},
	attachment_slot_shaft = {
		en = "Shaft",
		de = "Schaft",
		["zh-cn"] = "杆身",
	},
	attachment_slot_blade = {
		en = "Blade",
		de = "Klinge",
		["zh-cn"] = "刀刃",
	},
	attachment_slot_teeth = {
		en = "Chain",
		de = "Kette",
		["zh-cn"] = "链齿",
	},
	attachment_slot_chain = {
		en = "Chain",
		de = "Kette",
		["zh-cn"] = "链条",
	},
	attachment_slot_body = {
		en = "Body",
		de = "Gehäuse",
		["zh-cn"] = "主体",
	},
	attachment_slot_shaft_upper = {
		en = "Upper Shaft",
		de = "Oberer Schaft",
		["zh-cn"] = "上杆身",
	},
	attachment_slot_shaft_lower = {
		en = "Lower Shaft",
		de = "Unterer Schaft",
		["zh-cn"] = "下杆身",
	},
	attachment_slot_hilt = {
		en = "Hilt",
		de = "Heft",
		["zh-cn"] = "剑柄",
	},
	attachment_slot_emblem_left = {
		en = "Left Emblem",
		de = "Linkes Wappen",
		["zh-cn"] = "左徽章",
	},
	attachment_slot_emblem_right = {
		en = "Right Emblem",
		de = "Rechtes Wappen",
		["zh-cn"] = "右徽章",
	},
	attachment_slot_connector = {
		en = "Connector",
		de = "Konnektor",
		["zh-cn"] = "连接器",
	},
	attachment_slot_right = {
		en = "Right",
		de = "Rechts",
		["zh-cn"] = "右侧",
	},
	attachment_slot_left = {
		en = "Left",
		de = "Links",
		["zh-cn"] = "左侧",
	},
	attachment_slot_shield = {
		en = "Shield",
		de = "Schild",
		["zh-cn"] = "盾牌",
	},
	attachment_slot_handle = {
		en = "Handle",
		de = "Heltegriff",
		["zh-cn"] = "手柄",
	},
	attachment_slot_bayonet = {
		en = "Bayonet",
		de = "Bajonett",
		["zh-cn"] = "刺刀",
	},
	attachment_slot_rail = {
		en = "Rail",
		de = "Schiene",
		["zh-cn"] = "导轨",
	}
})

return {
	mod_title = {
		en = "Extended Weapon Customization",
		de = "Extended Weapon Customization",
		["zh-cn"] = "扩展武器自定义",
	},
	mod_description = {
		en = "Provides extended weapon configuration and options.",
		de = "Bietet erweiterte Waffen-Konfiguration und mehr Optionen.",
		["zh-cn"] = "扩展武器自定义功能，添加更多武器配件和定制选项",
	},
	mod_customize_button = {
		en = "Customize",
		de = "Konfigurieren",
		["zh-cn"] = "自定义",
	},

	customization_menu_finished_tutorial = {
		en = "Hide Customization Menu Tutorial",
		de = "Verstecke Konfigurationsmenü-Tutorial",
		["zh-cn"] = "隐藏自定义菜单教程",
	},
	customization_menu_finished_tutorial_tooltip = {
		en = "Switch this off to see the tutorial in the weapon customization menu.",
		de = "Schalte dies aus, um das Tutorial im Waffen-Konfigurationsmenu zu sehen.",
		["zh-cn"] = "关闭此选项以在武器自定义菜单中查看教程",
	},

	mod_tips_01 = {
		en = "Welcome to the {#color(226, 199, 126)}extended weapon customization menu{#reset()}.\n\nIn this menu you will customize all your weapons.\n\nThis little tutorial will explain the {#color(226, 199, 126)}controls{#reset()} and what they are for.",
		de = "Willkommen im {#color(226, 199, 126)}Extended Weapon Customization Menü{#reset()}.\n\nIn diesem Menü wirst du all deine Waffen kofigurieren.\n\nDiese kleine Tutorial wird die {#color(226, 199, 126)}Steuerung{#reset()} erklären.",
		["zh-cn"] = "欢迎使用 {#color(226, 199, 126)}扩展武器自定义菜单{#reset()}。\n\n在此菜单中，您可以自定义所有武器。\n\n本教程将解释 {#color(226, 199, 126)}控制方式{#reset()} 及其用途。",
	},
	mod_tips_title_01 = {
		en = "Welcome",
		de = "Willkommen",
		["zh-cn"] = "欢迎",
	},
	mod_tips_02 = {
		en = "The {#color(226, 199, 126)}attachment slot menu{#reset()} provides a list of attachment slots that apply to the customized weapon.\n\n{#color(226, 199, 126)}Click{#reset()} on an entry to open the corresponding {#color(226, 199, 126)}attachment selection grid{#reset()}.\n\nYou can click one right now!",
		de = "Das {#color(226, 199, 126)}Waffenteil-Typ Menü{#reset()} bietet eine Liste von Waffenteil-Typen die auf die aktuelle Waffe zutreffen.\n\n{#color(226, 199, 126)}Klicke{#reset()} auf einen Eintrag um die entsprechende {#color(226, 199, 126)}Waffenteil-Liste{#reset()} anzuzeigen.\n\nDu kannst jetzt auf eins klicken!",
		["zh-cn"] = "{#color(226, 199, 126)}配件槽位菜单{#reset()} 列出了适用于当前武器的配件槽位。\n\n{#color(226, 199, 126)}点击{#reset()} 条目可打开相应的 {#color(226, 199, 126)}配件选择网格{#reset()}。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_02 = {
		en = "Attachment Slot Menu",
		de = "Waffenteil-Typ Menü",
		["zh-cn"] = "配件槽位菜单",
	},
	mod_tips_03 = {
		en = "The {#color(226, 199, 126)}attachment selection grid{#reset()} provides a list of attachments that can be applied to the selected attachment slot.\n\n{#color(226, 199, 126)}Click{#reset()} on an entry to {#color(226, 199, 126)}preview{#reset()} the attachment on the customized weapon or {#color(226, 199, 126)}right click{#reset()} an entry to immediately {#color(226, 199, 126)}equip{#reset()} it.\n\nYou can click one right now!",
		de = "Die {#color(226, 199, 126)}Waffenteil-Liste{#reset()} bietet eine Auswahl aller Waffenteile des ausgewählten Typs.\n\n{#color(226, 199, 126)}Klicke{#reset()} auf einen Eintrag um eine {#color(226, 199, 126)}Vorschau{#reset()} des Waffenteils an der aktuellen Waffe zu sehen oder {#color(226, 199, 126)}Rechtsklicke{#reset()} einen Eintrag um das Waffenteil direkt {#color(226, 199, 126)}auszurüsten{#reset()}.\n\nDu kannst jetzt auf eins klicken!",
		["zh-cn"] = "{#color(226, 199, 126)}配件选择面板{#reset()} 列出了可应用于所选配件槽位的配件。\n\n{#color(226, 199, 126)}点击{#reset()} 条目可 {#color(226, 199, 126)}预览{#reset()} 配件在武器上的效果，或 {#color(226, 199, 126)}右键点击{#reset()} 条目立即 {#color(226, 199, 126)}装备{#reset()} 该配件。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_03 = {
		en = "Attachment Selection Grid",
		de = "Waffenteil-Liste",
		["zh-cn"] = "配件选择面板",
	},
	mod_tips_04 = {
		en = "The {#color(226, 199, 126)}feature toggle buttons{#reset()} are used to toggle features that attachments define.\nAttachments can define various {#color(226, 199, 126)}overwrites{#reset()} for crosshair, alternate fire mode or damage types and such.\n{#color(226, 199, 126)}Click{#reset()} on the button to {#color(226, 199, 126)}toggle{#reset()} the feature on and off.\nIf the text is red it is disabled.\n\nYou can click one right now!",
		de = "Die {#color(226, 199, 126)}Funktions-Schalter{#reset()} erlauben es Funktionen der ausgerüsteten Waffenteile steuern.\nWaffenteile können verschiedene Funktionen {#color(226, 199, 126)}überschreiben{#reset()}, wie etwa das Zielkreuz, Alternatives Feuer oder Schadenstyp usw.\n{#color(226, 199, 126)}Klicke{#reset()} den entsprechenden Schalter um Funktionen {#color(226, 199, 126)}an- oder auszuschalten{#reset()}.\nEin roter Text bedeutet die Funktion ist deaktiviert.\n\nDu kannst jetzt auf eins klicken!",
		["zh-cn"] = "{#color(226, 199, 126)}功能切换按钮{#reset()} 用于切换配件定义的功能。\n配件可以定义各种 {#color(226, 199, 126)}覆盖设置{#reset()}，如准星、次要开火模式或伤害类型等。\n{#color(226, 199, 126)}点击{#reset()} 按钮可 {#color(226, 199, 126)}切换{#reset()} 功能的开启和关闭。\n如果文本为红色，则表示该功能已禁用。\n\n您现在就可以点击一个试试！",
	},
	mod_tips_title_04 = {
		en = "Feature Toggle Buttons",
		de = "Funktions-Schalter",
		["zh-cn"] = "功能切换按钮",
	},
	mod_tips_05 = {
		en = "Material Overrides",
		de = "Material Überschreiben",
		["zh-cn"] = "材质外观自定义",
	},
	mod_tips_title_05 = {
		en = "{#color(226, 199, 126)}Material Overrides{#reset()} can change the color, patterns and wear of attachments.\n\nSelected material overrides apply to the attachment they are chosen for and all sub-attachments.",
		de = "{#color(226, 199, 126)}Material Überschreiben{#reset()} ändert Farbe, Muster und Abnutzung von Waffenteilen.\n\nAusgewählte Überschreibungen betreffen das Waffenteil für das sie gewählt werden und alle untergeordnete Waffenteile.",
		["zh-cn"] = "{#color(226, 199, 126)}材质外观自定义{#reset()} 可以改变配件的颜色、图案和磨损程度。\n\n所选材质覆盖将应用于其选择的配件及其所有子配件。",
	},
	mod_tips_06 = {
		en = "{#color(226, 199, 126)}Equip{#reset()} to apply the currently selected attachment.\n\n{#color(226, 199, 126)}Reset{#reset()} to remove all customized attachments and return the weapon to its default state.\n\n{#color(226, 199, 126)}Random{#reset()} to randomize the attachments on the weapon.\n\nYou can click {#color(226, 199, 126)}Random{#reset()} right now!",
		de = "{#color(226, 199, 126)}Ausrüsten{#reset()} um das ausgewählte Waffenteil auszurüsten.\n\n{#color(226, 199, 126)}Zurücksetzen{#reset()} um alle benutzerdefinierte Waffenteile zu entfernen und die Waffe in den Originalzustand zurückzuversetzen.\n\n{#color(226, 199, 126)}Zufällig{#reset()} um die Waffenteile der Waffe zufällig zu generieren.\n\nDu kannst jetzt auf {#color(226, 199, 126)}Zufällig{#reset()} klicken!",
		["zh-cn"] = "{#color(226, 199, 126)}装备{#reset()} 以应用当前选中的配件。\n\n{#color(226, 199, 126)}重置{#reset()} 以移除所有自定义配件并将武器恢复至默认状态。\n\n{#color(226, 199, 126)}随机{#reset()} 以随机化武器上的配件。\n\n您现在就可以点击 {#color(226, 199, 126)}随机{#reset()} 试试！",
	},
	mod_tips_title_06 = {
		en = "Control Buttons",
		de = "Steuerung",
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
		de = "Zufallgenerierung",
		["zh-cn"] = "随机化",
	},
	mod_option_randomize_players = {
		en = "Randomize Players",
		de = "Zufallgenerierung für Spielerwaffen",
		["zh-cn"] = "玩家装备随机化",
	},
	mod_option_randomize_players_tooltip = {
		en = "Randomize weapons of other players.",
		de = "Generiert zufällige Waffenteile für die Waffen anderer Spieler.",
		["zh-cn"] = "其他玩家的武器配件随机化",
	},
	mod_option_randomize_store = {
		en = "Randomize Store",
		de = "Zufallgenerierung für Händler",
		["zh-cn"] = "商店装备随机化",
	},
	mod_option_randomize_store_tooltip = {
		en = "Randomize weapons in the store.",
		de = "Generiert zufällige Waffenteile für die Waffen bei Händlern.",
		["zh-cn"] = "商店中的武器配件随机化",
	},
	mod_option_randomize_reward = {
		en = "Randomize Reward",
		de = "Zufallgenerierung für Belohnungen",
		["zh-cn"] = "帝皇之礼随机化",
	},
	mod_option_randomize_reward_tooltip = {
		en = "Randomize weapons that are mission rewards.",
		de = "Generiert zufällige Waffenteile für die Waffenbelohnungen nach Missionen.",
		["zh-cn"] = "任务获得的奖励武器，配件随机化",
	},

	group_overrides = {
		en = "Allow Overrides",
		de = "Funktionen Erlauben",
		["zh-cn"] = "允许覆盖",
	},
	mod_allow_crosshair_type_override = {
		en = "Crosshair",
		de = "Zielkreuz",
		["zh-cn"] = "准星",
	},
	mod_allow_crosshair_type_override_tooltip = {
		en = "Allow attachments to override the crosshair of a weapon.",
		de = "Erlaubt dass Waffenteile das Zielkreuz einer Waffe überschreiben können.",
		["zh-cn"] = "允许配件覆盖武器的准星设置",
	},
	mod_allow_alternate_fire_override = {
		en = "Alternate Fire",
		de = "Alternatives Feuer",
		["zh-cn"] = "次要开火模式",
	},
	mod_allow_alternate_fire_override_tooltip = {
		en = "Allow attachments to override the alternate fire animations of a weapon.",
		de = "Erlaubt dass Waffenteile das alternative Feuer einer Waffe überschreiben können.",
		["zh-cn"] = "允许配件覆盖武器的次要开火模式动画",
	},

	group_misc = {
		en = "Misc",
		de = "Verschiedenes",
		["zh-cn"] = "杂项",
	},
	mod_option_sway = {
		en = "Sway",
		de = "Schwanken",
		["zh-cn"] = "晃动效果",
	},
	mod_option_sway_tooltip = {
		en = "Weapon sways when you rotate your character.",
		de = "Waffen schwanken beim drehen des Charakters.",
		["zh-cn"] = "角色旋转时武器会晃动",
	},
	mod_option_crouch = {
		en = "Crouch",
		de = "Ducken",
		["zh-cn"] = "下蹲姿势",
	},
	mod_option_crouch_tooltip = {
		en = "Weapon changes pose when you crouch.",
		de = "Waffenpose verändert sich beim Ducken.",
		["zh-cn"] = "下蹲时持有武器的姿势会发生改变",
	},
	mod_option_crouch_melee = {
		en = "Crouch with melee weapon",
		de = "Ducken mit Nahkampfwaffe",
		["zh-cn"] = "下蹲近战",
	},
	mod_option_crouch_melee_tooltip = {
		en = "Weapon changes pose when you crouch and attack.",
		de = "Waffenpose verändert sich beim Ducken und Angreifen.",
		["zh-cn"] = "下蹲并攻击时持有武器的姿势会改变",
	},
	mod_weapon_dof_strength = {
		en = "Weapon DOF Strength",
		de = "Waffenunschärfe Stärke",
		["zh-cn"] = "武器景深强度",
	},
	mod_weapon_dof_strength_tooltip = {
		en = "DOF strength on the weapon.",
		de = "Stärke des Unschärfe-Effekts auf der Waffe.",
		["zh-cn"] = "武器上的景深效果强度",
	},
	mod_option_shield_transparency = {
		en = "Shield Transparency",
		de = "Schild-Transparenz",
		["zh-cn"] = "盾牌透明度",
	},
	mod_option_shield_transparency_tooltip = {
		en = "Transparency of shields when aiming / blocking.",
		de = "Transparenz von Schilden beim Zielen / Blocken.",
		["zh-cn"] = "瞄准/格挡时盾牌的透明度",
	},
	mod_lense_completely_transparent = {
		en = "Lense Transparent",
		de = "Linsen-Transparenz",
		["zh-cn"] = "瞄镜镜片完全透明",
	},
	mod_lense_completely_transparent_tooltip = {
		en = "Makes scope lenses completely transparent when aiming.",
		de = "Mach die Linsen von Zielfernrohren beim Zielen komplett transparent.",
		["zh-cn"] = "瞄准时使瞄准镜镜片完全透明",
	},

	group_flashlight = {
		en = "Flashlight",
		de = "Lampe",
		["zh-cn"] = "战术手电设置",
	},
	mod_option_flashlight_shadows = {
		en = "Cast Shadows",
		de = "Schatten",
		["zh-cn"] = "手电投射阴影",
	},
	mod_option_flashlight_shadows_tooltip = {
		en = "Flashlight casts shadows.",
		de = "Lampen werfen Schatten",
		["zh-cn"] = "手电筒会投射阴影",
	},
	mod_toggle_flashlight_interact_aim = {
		en = "Toggle on Aiming Interact",
		de = "Umschalten bei Zielen durch Interagieren",
		["zh-cn"] = "瞄准时交互切换",
	},
	mod_toggle_flashlight_interact_aim_tooltip = {
		en = "Toggle flashlight by pressing the interact button when aiming.",
		de = "Die Lampe umschalten durch drücken der Interaktion-Taste beim Zielen.",
		["zh-cn"] = "瞄准时按下交互键切换手电筒",
	},
	mod_toggle_flashlight_interact_double = {
		en = "Toggle on Double Interact",
		de = "Umschalten bei Doppel-Interagieren",
		["zh-cn"] = "双击交互切换",
	},
	mod_toggle_flashlight_interact_double_tooltip = {
		en = "Toggle flashlight by pressing the interact button two times in quick succession when not aiming.",
		de = "Die Lampe umschalten durch doppeltes schnelles drücken der Interaktion-Taste ohne Zielen.",
		["zh-cn"] = "非瞄准状态下快速连续按两次交互键切换手电筒",
	},
	mod_flashlight_input_reminder = {
		en = "Flashlight Input Reminder",
		de = "Lampe Eingabeerinnerung",
		["zh-cn"] = "手电筒输入提醒",
	},
	mod_flashlight_input_reminder_tooltip = {
		en = "Flashlight input reminder when using a modded flashlight.",
		de = "Lampe Eingabeerinnerung wenn eine benutzerdefinierte Lampe benutzt wird.",
		["zh-cn"] = "使用改装手电筒时显示输入提醒",
	},
	mod_flashlight_input_reminder_text = {
		en = " Modded flashlight.\nInteract toggles the flashlight while aiming or double press. Toggle this reminder in options.",
		de = " Benutzerdefinierte Lampe.\nInteraktion-Taste beim Zielen oder doppelt schnell Interaktion-Taste drücken. Diese Erinnerung kann in den Optionen ausgeschaltet werden.",
		["zh-cn"] = " 改装手电筒\n瞄准时按交互键或双击交互键切换手电筒。可在选项中关闭此提醒",
	},
}
