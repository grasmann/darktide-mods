local mod = get_mod("scoreboard")

-- #####  ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗      ###########################################################
-- ##### ██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║      ###########################################################
-- ##### ██║  ███╗██║     ██║   ██║██████╔╝███████║██║      ###########################################################
-- ##### ██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║      ###########################################################
-- ##### ╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗ ###########################################################
-- #####  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###########################################################

mod:add_global_localize_strings({
	loc_scoreboard_history_view_display_name = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
	},
	loc_scoreboard_save = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
	},
	loc_scoreboard_scan = {
		en = "Scan Directory for files",
		de = "Ordner nach Dateien durchsuchen",
	},
	loc_scoreboard_delete = {
		en = "Delete Scoreboard",
		de = "Scoreboard löschen",
	},
})

-- ##### ██╗      ██████╗  ██████╗ █████╗ ██╗      ####################################################################
-- ##### ██║     ██╔═══██╗██╔════╝██╔══██╗██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ███████║██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ██╔══██║██║      ####################################################################
-- ##### ███████╗╚██████╔╝╚██████╗██║  ██║███████╗ ####################################################################
-- ##### ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝ ####################################################################

return {
	-- Mod Info
	mod_title = {
		en = "Scoreboard",
		["zh-cn"] = "记分板",
	},
	mod_description = {
		en = "Adds a scoreboard with various individual stats at the end of missions.",
		de = "Zeigt nach Missionsende ein Scoreboard mit individuellen Statistiken.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
	},
	-- Buttons
	mod_history_view_title = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
	},
	mod_save_scoreboard_to_history = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
	},
	-- Options
	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
	},
	save_all_scoreboards = {
		en = "Save all Scoreboards",
		de = "Alle Scoreboards speichern",
	},
	scoreboard_history_cached = {
		en = "Scoreboard History Cached",
		de = "Scoreboard History Zwischengespeichert",
	},
	zero_values = {
		en = "Zero Values",
		de = "Nullwerte",
	},
	zero_values_normal = {
		en = "Normal",
		de = "Normal",
	},
	zero_values_hide = {
		en = "Hidden",
		de = "Versteckt",
	},
	zero_values_dark = {
		en = "Dark",
		de = "Dunkel",
	},
	worst_values = {
		en = "Worst Values",
		de = "Schlechteste Werte",
	},
	worst_values_normal = {
		en = "Normal",
		de = "Normal",
	},
	worst_values_dark = {
		en = "Dark",
		de = "Dunkel",
	},
	-- Groups
	group_plugins = {
		en = "Plugins",
		de = "Plugins",
	},
	group_messages = {
		en = "Messages",
		de = "Nachrichten",
	},
	-- Forge material
	message_forge_material = {
		en = "Forge Material",
		de = "Schmiedematerial",
		["zh-cn"] = "锻造材料",
	},
	message_forge_material_description = {
		en = "Shows message when a player picks up plasteel or diamantine",
		de = "Zeigt eine Nachricht wenn ein Spieler Plasteel oder Diamantine einsammelt",
		["zh-cn"] = "玩家拾取塑钢或金刚铁时显示消息",
	},
	plugin_forge_material = {
		en = "Forge Materials",
		de = "Schmiedematerial",
	},
	row_forge_material = {
		en = "Metal / Diamantine collected",
		de = "Metall / Diamantin gesammelt",
	},
	row_forge_material_metal = {
		en = "Metal",
		de = "Metall",
	},
	row_forge_material_platinum = {
		en = "Diamantine",
		de = "Diamantin",
	},
	-- Operated
	plugin_machinery_gadget_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
	},
	row_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
	},
	row_machinery_operated = {
		en = "Machinery",
		de = "Maschine",
	},
	row_gadget_operated = {
		en = "Gadget",
		de = "Gadget",
	},
	-- Buttons etc
	message_default = {
		en = "Buttons Operated",
		de = "Schalter betätigt",
		["zh-cn"] = "操作按钮",
	},
	message_default_description = {
		en = "Shows message when a player operates a normal button",
		de = "Zeigt eine Nachricht wenn ein Spieler einen Schalter betätigt",
		["zh-cn"] = "玩家操作普通按钮时显示消息",
	},
	-- Data decoded
	message_decoded = {
		en = "Data decoded",
		de = "Daten dekodiert",
		["zh-cn"] = "解码数据",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
	},
	-- Ammo
	plugin_ammo = {
		en = "Ammo",
		de = "Munition",
	},
	plugin_ammo_on = {
		en = "On",
		de = "An",
	},
	plugin_ammo_simple = {
		en = "Simple",
		de = "Einfach",
	},
	plugin_ammo_off = {
		en = "Off",
		de = "Aus",
	},
	row_ammo_1 = {
		en = "Ammo Picked Up / Wasted",
		de = "Munition Genommen / Verschwendet",
	},
	row_ammo_2 = {
		en = "Ammo Picked Up",
		de = "Munition Genommen",
	},
	row_ammo_picked_up = {
		en = "Picked Up",
		de = "Genommen",
	},
	row_ammo_wasted = {
		en = "Wasted",
		de = "Verschwendet",
	},
	-- Carrying
	plugin_carrying = {
		en = "Carrying Supplies",
		de = "Resourcen getragen",
	},
	row_carrying = {
		en = "Carried Scripture / Grimoire / Other",
		de = "Carried Scripture / Grimoire / Sonst.",
	},
	row_carrying_scripture = {
		en = "Scripture",
		de = "Scripture",
	},
	row_carrying_grimoire = {
		en = "Grimoire",
		de = "Grimoire",
	},
	row_carrying_other = {
		en = "Other",
		de = "Sonst.",
	},
	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
	},
	row_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
	},
	-- Revive / Rescue
	plugin_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
	},
	row_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
	},
	row_revived_operative = {
		en = "Revived",
		de = "Wiederbelebt",
	},
	row_rescued_operative = {
		en = "Rescued",
		de = "Gerettet",
	},
	-- Damage taken / Health station
	plugin_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
	},
	row_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
	},
	row_damage_taken = {
		en = "Damage Taken",
		de = "Genommener Schaden",
	},
	row_heal_station_used = {
		en = "Health Station Used",
		de = "Heilstation benutzt",
	},
	message_health_station = {
		en = "Health Station",
		de = "Heilstation",
		["zh-cn"] = "医疗站",
	},
	message_health_station_description = {
		en = "Shows message when a player uses a health station",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Heilstation benutzt",
		["zh-cn"] = "玩家使用医疗站时显示消息",
	},
	-- Damage dealt
	plugin_damage_dealt = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
	},
	plugin_damage_dealt_on = {
		en = "On",
		de = "An",
	},
	plugin_damage_dealt_simple = {
		en = "Simple",
		de = "Einfach",
	},
	plugin_damage_dealt_off = {
		en = "Off",
		de = "Aus",
	},
	row_damage_dealt_1 = {
		en = "Actual / Overkill Damage Dealt",
		de = "Verursachter / Overkill Schaden",
	},
	row_damage_dealt_2 = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
	},
	row_actual_damage_dealt_1 = {
		en = "Actual",
		de = "Verursachter",
	},
	row_actual_damage_dealt_2 = {
		en = "Damage",
		de = "Verursachter",
	},
	row_overkill_damage_dealt = {
		en = "Overkill",
		de = "Overkill",
	},
	-- Lesser enemies
	plugin_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
	},
	row_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
	},
	-- Boss damage
	plugin_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
	},
	row_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
	},
	-- Enemies staggered
	plugin_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
	},
	row_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
	},
	-- Attacks blocked
	plugin_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
	},
	row_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
	},
	-- Special hits
	plugin_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
	},
	row_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
	},
	row_weakspot_hits = {
		en = "Weakspot",
		de = "Schwachpunkt",
	},
	row_critical_hits = {
		en = "Critical",
		de = "Kritische",
	},
	-- Melee / Ranged Threats
	plugin_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
	},
	row_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
	},
	row_melee_threats = {
		en = "Melee",
		de = "Nah-",
	},
	row_ranged_threats = {
		en = "Ranged",
		de = "Fernkampf",
	},
	-- Special Threats
	plugin_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
	},
	row_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
	},
	-- Boss Threats
	plugin_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
	},
	row_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
	},
	-- Disabler
	plugin_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
	},
	row_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
	},
	-- Ammo
	message_ammo = {
		en = "Ammo",
		de = "Munition",
		["zh-cn"] = "弹药",
	},
	message_ammo_description = {
		en = "Shows message when a player picks up ammo",
		de = "Zeigt eine Nachricht wenn ein Spieler Munition einsammelt",
		["zh-cn"] = "玩家拾取弹药时显示消息",
	},
	-- Deploy
	plugin_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
	},
	row_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
	},
	row_health_placed = {
		en = "Medipacks",
		de = "Medipack",
	},
	row_ammo_placed = {
		en = "Ammocaches",
		de = "Munition",
	},
	-- Deploy medipack
	message_health_placed = {
		en = "Medipack deployed",
		de = "Medipack platziert",
		["zh-cn"] = "部署医疗箱",
	},
	message_health_placed_description = {
		en = "Shows message when a player deployes medipack",
		de = "Zeigt eine Nachicht wenn ein Spieler ein Medipack platziert",
		["zh-cn"] = "玩家部署医疗箱时显示消息",
	},
	-- Deploy ammocache
	message_ammo_placed = {
		en = "Ammocache deployed",
		de = "Munitionskiste",
		["zh-cn"] = "部署弹药罐",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		["zh-cn"] = "玩家部署弹药罐时显示消息",
	},
	-- Pick up ammocache / medipack
	ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		["zh-cn"] = "拾取医疗箱 / 弹药罐",
	},
	ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		["zh-cn"] = "玩家拾取医疗箱或弹药罐时显示消息",
	},
	-- Pick up scripture / grimoire
	scripture_grimoire_pickup = {
		en = "Scripture / Grimoire picked up",
		de = "Scripture / Grimoire eingesammelt",
		["zh-cn"] = "拾取圣经 / 魔法书",
	},
	scripture_grimoire_pickup_description = {
		en = "Shows message when a player picks up scripture or grimoire",
		de = "Zeigt eine Nachricht wenn ein Spieler Scriptures oder Grimoires einsammelt",
		["zh-cn"] = "玩家拾取圣经或魔法书时显示消息",
	},
	row_team_score = {
		en = "Team Score",
		de = "Team Punkte",
	},
	row_defense_score = {
		en = "Defense Score",
		de = "Verteidigung Punkte",
	},
	row_offense_score = {
		en = "Offense Score",
		de = "Verteidigung Punkte",
	},
	row_score = {
		en = "Total Score",
		de = "Gesamtpunktzahl",
	},
}
