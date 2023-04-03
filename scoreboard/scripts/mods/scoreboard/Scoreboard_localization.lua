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
		ru = "Scoreboard История",
	},
	loc_scoreboard_save = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить Scoreboard",
	},
	loc_scoreboard_scan = {
		en = "Scan Directory for files",
		de = "Ordner nach Dateien durchsuchen",
		ru = "Поиск файлов",
	},
	loc_scoreboard_delete = {
		en = "Delete Scoreboard",
		de = "Scoreboard löschen",
		ru = "Удалить Scoreboard",
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
		de = "Scoreboard",
		["zh-cn"] = "记分板",
	},
	mod_description = {
		en = "Adds a scoreboard with various individual stats at the end of missions.",
		de = "Zeigt nach Missionsende ein Scoreboard mit individuellen Statistiken.",
		ru = "Добавляет табло с различной индивидуальной статистикой в ​​конце миссий.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
	},
	-- Buttons
	mod_history_view_title = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
		ru = "Scoreboard История",
	},
	mod_save_scoreboard_to_history = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить Scoreboard",
	},
	-- Options
	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
		ru = "Открыть Scoreboard",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
		ru = "Открыть историю Scoreboard",
	},
	save_all_scoreboards = {
		en = "Save all Scoreboards",
		de = "Alle Scoreboards speichern",
		ru = "Сохранить все Scoreboards",
	},
	scoreboard_history_cached = {
		en = "Scoreboard History Cached",
		de = "Scoreboard History Zwischengespeichert",
		ru = "Кэшировать историю Scoreboard",
	},
	zero_values = {
		en = "Zero Values",
		de = "Nullwerte",
		ru = "Нулевые значения",
	},
	zero_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Нормальный",
	},
	zero_values_hide = {
		en = "Hidden",
		de = "Versteckt",
		ru = "Скрытый",
	},
	zero_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Темный",
	},
	worst_values = {
		en = "Worst Values",
		de = "Schlechteste Werte",
		ru = "Худшие значения",
	},
	worst_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Нормальный",
	},
	worst_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Темный",
	},
	-- Groups
	group_plugins = {
		en = "Plugins",
		de = "Plugins",
		ru = "Плагины",
	},
	group_messages = {
		en = "Messages",
		de = "Nachrichten",
		ru = "Сообщения",
	},
	-- Forge material
	message_forge_material = {
		en = "Forge Material",
		de = "Schmiedematerial",
		ru = "Ресурсы",
		["zh-cn"] = "锻造材料",
	},
	message_forge_material_text = {
		en = " picked up :subject:",
		de = " hat :subject: aufgesammelt",
		ru = " подбирает :subject:",
	},
	message_forge_material_description = {
		en = "Shows message when a player picks up plasteel or diamantine",
		de = "Zeigt eine Nachricht wenn ein Spieler Plasteel oder Diamantine einsammelt",
		ru = "Показывает сообщения когда игрок подбирает ресурсы",
		["zh-cn"] = "玩家拾取塑钢或金刚铁时显示消息",
	},
	plugin_forge_material = {
		en = "Forge Materials",
		de = "Schmiedematerial",
		ru = "Ресурсы",
	},
	row_forge_material = {
		en = "Metal / Diamantine collected",
		de = "Metall / Diamantin gesammelt",
		ru = "Пластиль / Диамантин",
	},
	row_forge_material_metal = {
		en = "Metal",
		de = "Metall",
		ru = "Пластиль",
	},
	row_forge_material_platinum = {
		en = "Diamantine",
		de = "Diamantin",
		ru = "Диамантин",
	},
	-- Operated
	plugin_machinery_gadget_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Механизмы / Ауспекс - Использовано",
	},
	row_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Механизмы / Ауспекс - Использовано",
	},
	row_machinery_operated = {
		en = "Machinery",
		de = "Maschine",
		ru = "Механизмы",
	},
	row_gadget_operated = {
		en = "Gadget",
		de = "Gadget",
		ru = "Ауспекс",
	},
	-- Buttons etc
	message_default = {
		en = "Buttons Operated",
		de = "Schalter betätigt",
		ru = "Нажатие кнопок",
		["zh-cn"] = "操作按钮",
	},
	message_default_text = {
		en = " operated :subject:",
		de = " hat :subject: betätigt",
		ru = " управляет :subject:",
	},
	message_default_machinery = {
		en = "Machinery",
		de = "Maschinerie",
		ru = "Механизмом",
	},
	message_default_description = {
		en = "Shows message when a player operates a normal button",
		de = "Zeigt eine Nachricht wenn ein Spieler einen Schalter betätigt",
		ru = "Показывает сообщение, когда игрок нажимает обычную кнопку",
		["zh-cn"] = "玩家操作普通按钮时显示消息",
	},
	-- Data decoded
	message_decoded = {
		en = "Data decoded",
		de = "Daten dekodiert",
		ru = "Декодирование данных",
		["zh-cn"] = "解码数据",
	},
	message_decoded_text = {
		en = " operated :subject:",
		de = " hat :subject: betätig",
		ru = " управляет :subject:",
	},
	message_decoded_skull = {
		en = "Servoskull",
		de = "Servoskull",
		ru = "Сервочерепом",
	},
	message_decoded_scanner = {
		en = "Scanner",
		de = "Scanner",
		ru = "Ауспекс",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		ru = "Показывает сообщение, когда игрок декодирует данные на терминале",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
	},
	-- Ammo
	plugin_ammo = {
		en = "Ammo",
		de = "Munition",
		ru = "Патроны",
	},
	plugin_ammo_on = {
		en = "On",
		de = "An",
		ru = "Включить",
	},
	plugin_ammo_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Обычный",
	},
	plugin_ammo_off = {
		en = "Off",
		de = "Aus",
		ru = "Отключить",
	},
	row_ammo_1 = {
		en = "Ammo Picked Up / Wasted",
		de = "Munition Genommen / Verschwendet",
		ru = "Патронов Взято / Лишние",
	},
	row_ammo_2 = {
		en = "Ammo Picked Up",
		de = "Munition Genommen",
		ru = "Патронов Взято",
	},
	row_ammo_picked_up = {
		en = "Picked Up",
		de = "Genommen",
		ru = "Взято",
	},
	row_ammo_wasted = {
		en = "Wasted",
		de = "Verschwendet",
		ru = "Лишние",
	},
	-- Carrying
	plugin_carrying = {
		en = "Carrying Supplies",
		de = "Resourcen getragen",
		ru = "Доставка припасов",
	},
	row_carrying = {
		en = "Carried Scripture / Grimoire / Other",
		de = "Carried Scripture / Grimoire / Sonst.",
		ru = "Доставлено: Писание / Гримуар / Другое",
	},
	row_carrying_scripture = {
		en = "Scripture",
		de = "Scripture",
		ru = "Писание",
	},
	row_carrying_grimoire = {
		en = "Grimoire",
		de = "Grimoire",
		ru = "Гримуар",
	},
	row_carrying_other = {
		en = "Other",
		de = "Sonst.",
		ru = "Другое",
	},
	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Согласованная Эффективность",
	},
	row_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Согласованная Эффективность",
	},
	-- Revive / Rescue
	plugin_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Оперативников Оживлено / Спасено",
	},
	row_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Оперативников Оживлено / Спасено",
	},
	row_revived_operative = {
		en = "Revived",
		de = "Wiederbelebt",
		ru = "Оживлено",
	},
	row_rescued_operative = {
		en = "Rescued",
		de = "Gerettet",
		ru = "Спасено",
	},
	-- Damage taken / Health station
	plugin_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Урона пол-но / Мед.Станций исп-но",
	},
	row_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Урона пол-но / Мед.Станций исп-но",
	},
	row_damage_taken = {
		en = "Damage Taken",
		de = "Genommener Schaden",
		ru = "Урона пол-но",
	},
	row_heal_station_used = {
		en = "Health Station Used",
		de = "Heilstation benutzt",
		ru = "Мед.Станций исп-но",
	},
	message_health_station = {
		en = "Health Station",
		de = "Heilstation",
		ru = "Мед.Станция",
		["zh-cn"] = "医疗站",
	},
	message_health_station_text = {
		en = " used :subject:",
		de = " hat :subject: benutzt",
		ru = " использует :subject:",
	},
	message_health_station_health_station = {
		en = "Health Station",
		de = "Heilstation",
		ru = "Мед.Станцию",
	},
	message_health_station_description = {
		en = "Shows message when a player uses a health station",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Heilstation benutzt",
		ru = "Показывает сообщение когда игрок использует мед.станцию",
		["zh-cn"] = "玩家使用医疗站时显示消息",
	},
	-- Damage dealt
	plugin_damage_dealt = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		ru = "Урона нанесено",
	},
	plugin_damage_dealt_on = {
		en = "On",
		de = "An",
		ru = "Включить",
	},
	plugin_damage_dealt_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Обычный",
	},
	plugin_damage_dealt_off = {
		en = "Off",
		de = "Aus",
		ru = "Отключить",
	},
	row_damage_dealt_1 = {
		en = "Actual / Overkill Damage Dealt",
		de = "Verursachter / Overkill Schaden",
		ru = "Фактический / Излишний На-ный Урон",
	},
	row_damage_dealt_2 = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		ru = "На-ный Урон",
	},
	row_actual_damage_dealt_1 = {
		en = "Actual",
		de = "Verursachter",
		ru = "Фактический",
	},
	row_actual_damage_dealt_2 = {
		en = "Damage",
		de = "Verursachter",
		ru = "Урон",
	},
	row_overkill_damage_dealt = {
		en = "Overkill",
		de = "Overkill",
		ru = "Излишний",
	},
	-- Lesser enemies
	plugin_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Обычных врагов убито",
	},
	row_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Обычных врагов убито",
	},
	-- Boss damage
	plugin_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Нанесено урона Боссу",
	},
	row_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Нанесено урона Боссу",
	},
	-- Enemies staggered
	plugin_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Врагов ошеломленно",
	},
	row_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Врагов ошеломленно",
	},
	-- Attacks blocked
	plugin_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Атак заблокировано",
	},
	row_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Атак заблокировано",
	},
	-- Special hits
	plugin_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Слабое место / Криты",
	},
	row_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Слабое место / Криты",
	},
	row_weakspot_hits = {
		en = "Weakspot",
		de = "Schwachpunkt",
		ru = "Слабое место",
	},
	row_critical_hits = {
		en = "Critical",
		de = "Kritische",
		ru = "Криты",
	},
	-- Melee / Ranged Threats
	plugin_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Милишников / Стрелков - Элитников Убито",
	},
	row_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Милишник / Стрелок - Эл. Убито",
	},
	row_melee_threats = {
		en = "Melee",
		de = "Nah-",
		ru = "Милишник",
	},
	row_ranged_threats = {
		en = "Ranged",
		de = "Fernkampf",
		ru = "Стрелок",
	},
	-- Special Threats
	plugin_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Камик-зе/Бомбардир/Огневик/Снайпер",
	},
	row_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Камик-зе/Бомбардир/Огневик/Снайпер",
	},
	-- Boss Threats
	plugin_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Боссов Убито",
	},
	row_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Боссов Убито",
	},
	-- Disabler
	plugin_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убито Гончая/Мутант/Ловушечник",
	},
	row_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убито Гончая/Мутант/Ловушечник",
	},
	-- Ammo
	message_ammo = {
		en = "Ammo",
		de = "Munition",
		ru = "Патроны",
		["zh-cn"] = "弹药",
	},
	message_ammo_text = {
		en = " picked up :count: :subject: wasted :count2:",
		de = " hat :count: :subject: aufgesammelt :count2: verschwendet",
		ru = " подбирает :count: :subject: теряет :count2:",
	},
	message_ammo_crate_text = {
		en = " picked up :count: :subject:",
		de = " hat :count: :subject: aufgesammelt",
		ru = " подбирает :count: :subject:",
	},
	message_ammo_ammo = {
		en = "Ammo",
		de = "Munition",
		ru = "патроны",
	},
	message_ammo_description = {
		en = "Shows message when a player picks up ammo",
		de = "Zeigt eine Nachricht wenn ein Spieler Munition einsammelt",
		ru = "Показывает сообщение когда игрок подбирает патроны",
		["zh-cn"] = "玩家拾取弹药时显示消息",
	},
	-- Deploy
	plugin_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		ru = "Аптечек / Боеприпасов размещено",
	},
	row_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		ru = "Аптечек / Боеприпасов размещено",
	},
	row_health_placed = {
		en = "Medipacks",
		de = "Medipack",
		ru = "Аптечек",
	},
	row_ammo_placed = {
		en = "Ammocaches",
		de = "Munition",
		ru = "Боеприпасов",
	},
	-- Deploy medipack
	message_health_placed = {
		en = "Medipack deployed",
		de = "Medipack platziert",
		ru = "Аптечка размещена",
		["zh-cn"] = "部署医疗箱",
	},
	message_health_placed_text = {
		en = " deployed :subject:",
		de = " hat :subject: platziert",
		ru = " развёртывает :subject:",
	},
	message_health_placed_description = {
		en = "Shows message when a player deployes medipack",
		de = "Zeigt eine Nachicht wenn ein Spieler ein Medipack platziert",
		ru = "Показывает сообщение когда игрок размещает аптечку",
		["zh-cn"] = "玩家部署医疗箱时显示消息",
	},
	-- Deploy ammocache
	message_ammo_placed = {
		en = "Ammocache deployed",
		de = "Munitionskiste",
		ru = "Боеприпасы размещены",
		["zh-cn"] = "部署弹药罐",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		ru = "Показывает сообщение когда игрок размещает боеприпасы",
		["zh-cn"] = "玩家部署弹药罐时显示消息",
	},
	-- Pick up ammocache / medipack
	ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		ru = "Аптечка / Боеприпасы взяты",
		["zh-cn"] = "拾取医疗箱 / 弹药罐",
	},
	ammo_health_pickup_text = {
		en = " picked up :subject:",
		de = " hat :subject: genommen",
		ru = " подбирает :subject:",
	},
	ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		ru = "Показывает сообщение когда игрок подбирает аптечку или боеприпасы",
		["zh-cn"] = "玩家拾取医疗箱或弹药罐时显示消息",
	},
	-- Pick up scripture / grimoire
	scripture_grimoire_pickup = {
		en = "Scripture / Grimoire picked up",
		de = "Scripture / Grimoire eingesammelt",
		ru = "Писание / Гримуар взят",
		["zh-cn"] = "拾取圣经 / 魔法书",
	},
	scripture_grimoire_pickup_description = {
		en = "Shows message when a player picks up scripture or grimoire",
		de = "Zeigt eine Nachricht wenn ein Spieler Scriptures oder Grimoires einsammelt",
		ru = "Показывает сообщение когда игрок подбирает писание или гримуар",
		["zh-cn"] = "玩家拾取圣经或魔法书时显示消息",
	},
	row_team_score = {
		en = "Team Score",
		de = "Team Punkte",
		ru = "Командные очки",
	},
	row_defense_score = {
		en = "Defense Score",
		de = "Verteidigung Punkte",
		ru = "Очки за оборону",
	},
	row_offense_score = {
		en = "Offense Score",
		de = "Verteidigung Punkte",
		ru = "Очки за нападение",
	},
	row_score = {
		en = "Total Score",
		de = "Gesamtpunktzahl",
		ru = "Общий счет",
	},
}
