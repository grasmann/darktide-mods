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
		ru = "История таблицы результатов",
	},
	loc_scoreboard_save = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить таблицу результатов",
	},
	loc_scoreboard_scan = {
		en = "Scan Directory for files",
		de = "Ordner nach Dateien durchsuchen",
		ru = "Просканировать папку на наличие файлов",
	},
	loc_scoreboard_delete = {
		en = "Delete Scoreboard",
		de = "Scoreboard löschen",
		ru = "Удалить таблицу результатов",
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
		ru = "Scoreboard",
	},
	mod_description = {
		en = "Adds a scoreboard with various individual stats at the end of missions.",
		de = "Zeigt nach Missionsende ein Scoreboard mit individuellen Statistiken.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
		ru = "Добавляет таблицу результатов с различной индивидуальной статистикой в конце миссий.",
	},
	-- Buttons
	mod_history_view_title = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
		ru = "История таблицы результатов",
	},
	mod_save_scoreboard_to_history = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить таблицу результатов",
	},
	-- Options
	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
		ru = "Открыть таблицу результатов",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
		ru = "Сохранить историю таблицы результатов",
	},
	save_all_scoreboards = {
		en = "Save all Scoreboards",
		de = "Alle Scoreboards speichern",
		ru = "Сохранить все таблицы результатов",
	},
	scoreboard_history_cached = {
		en = "Scoreboard History Cached",
		de = "Scoreboard History Zwischengespeichert",
		ru = "История таблицы результатов сохранена.",
	},
	zero_values = {
		en = "Zero Values",
		de = "Nullwerte",
		ru = "Нулевые значения",
	},
	zero_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Обычные",
	},
	zero_values_hide = {
		en = "Hidden",
		de = "Versteckt",
		ru = "Скрытые",
	},
	zero_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Тёмные",
	},
	worst_values = {
		en = "Worst Values",
		de = "Schlechteste Werte",
		ru = "Худшие значения",
	},
	worst_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Обычные",
	},
	worst_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Тёмные",
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
		["zh-cn"] = "锻造材料",
		ru = "Материалы кузницы",
	},
	message_forge_material_description = {
		en = "Shows message when a player picks up plasteel or diamantine",
		de = "Zeigt eine Nachricht wenn ein Spieler Plasteel oder Diamantine einsammelt",
		["zh-cn"] = "玩家拾取塑钢或金刚铁时显示消息",
		ru = "Показывает сообщение, когда игрок поднимает пласталь или диамантин",
	},
	plugin_forge_material = {
		en = "Forge Materials",
		de = "Schmiedematerial",
		ru = "Материалы кузницы",
	},
	-- Operated
	plugin_machinery_gadget_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Включение машин/гаджетов",
	},
	-- Buttons etc
	message_default = {
		en = "Buttons Operated",
		de = "Schalter betätigt",
		["zh-cn"] = "操作按钮",
		ru = "Нажатие кнопок",
	},
	message_default_description = {
		en = "Shows message when a player operates a normal button",
		de = "Zeigt eine Nachricht wenn ein Spieler einen Schalter betätigt",
		["zh-cn"] = "玩家操作普通按钮时显示消息",
		ru = "Показывает сообщение, когда игрок нажимает обычную кнопку",
	},
	-- Data decoded
	message_decoded = {
		en = "Data decoded",
		de = "Daten dekodiert",
		["zh-cn"] = "解码数据",
		ru = "Расшифровка данных",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
		ru = "Показывает сообщение, когда игрок декодирует данные на терминале",
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
		ru = "Включено",
	},
	plugin_ammo_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Простой",
	},
	plugin_ammo_off = {
		en = "Off",
		de = "Aus",
		ru = "Выключено",
	},
	-- Carrying
	plugin_carrying = {
		en = "Carrying Supplies",
		de = "Resourcen getragen",
		ru = "Переноска припасов",
	},
	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Эффективность сплочённости",
	},
	-- Revive / Rescue
	plugin_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Возрождено/\nСпасено оперативников",
	},
	-- Damage taken / Health station
	plugin_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Получено урона/\nИспользовано медстанций",
	},
	message_health_station = {
		en = "Health Station",
		de = "Heilstation",
		["zh-cn"] = "医疗站",
		ru = "Медстанция",
	},
	message_health_station_description = {
		en = "Shows message when a player uses a health station",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Heilstation benutzt",
		["zh-cn"] = "玩家使用医疗站时显示消息",
		ru = "Показывает сообщение, когда игрок использует Медстанцию",
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
		ru = "Включено",
	},
	plugin_damage_dealt_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Простой",
	},
	plugin_damage_dealt_off = {
		en = "Off",
		de = "Aus",
		ru = "Выключено",
	},
	-- Lesser enemies
	plugin_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Убийство меньших врагов",
	},
	-- Boss damage
	plugin_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Нанесено урона боссу",
	},
	-- Enemies staggered
	plugin_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Выведено врагов из равновесия",
	},
	-- Attacks blocked
	plugin_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Заблокировано атак",
	},
	-- Special hits
	plugin_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Удары по слабым местам/\nКритические",
	},
	-- Melee / Ranged Threats
	plugin_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Убийство Элиты в Ближнем/\nДальнем бою",
	},
	-- Special Threats
	plugin_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Убийство Специалистов",
	},
	-- Boss Threats
	plugin_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Убийство боссов",
	},
	-- Disabler
	plugin_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убийство Обездвиживающих врагов",
	},
	-- Ammo
	message_ammo = {
		en = "Ammo",
		de = "Munition",
		["zh-cn"] = "弹药",
		ru = "Патроны",
	},
	message_ammo_description = {
		en = "Shows message when a player picks up ammo",
		de = "Zeigt eine Nachricht wenn ein Spieler Munition einsammelt",
		["zh-cn"] = "玩家拾取弹药时显示消息",
		ru = "Показывает сообщение, когда игрок подбирает Патроны",
	},
	-- Deploy
	plugin_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		ru = "Размещение Медпаков/\nЯщиков с патронами",
	},
	-- Deploy medipack
	message_health_placed = {
		en = "Medipack deployed",
		de = "Medipack platziert",
		["zh-cn"] = "部署医疗箱",
		ru = "Размещение Медпаков",
	},
	message_health_placed_description = {
		en = "Shows message when a player deployes medipack",
		de = "Zeigt eine Nachicht wenn ein Spieler ein Medipack platziert",
		["zh-cn"] = "玩家部署医疗箱时显示消息",
		ru = "Показывает сообщение, когда игрок разворачивает Медпак",
	},
	-- Deploy ammocache
	message_ammo_placed = {
		en = "Ammocache deployed",
		de = "Munitionskiste",
		["zh-cn"] = "部署弹药罐",
		ru = "Размещение Ящиков с патронами",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		["zh-cn"] = "玩家部署弹药罐时显示消息",
		ru = "Показывает сообщение, когда игрок разворачивает Ящик с патронами",
	},
	-- Pick up ammocache / medipack
	ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		["zh-cn"] = "拾取医疗箱 / 弹药罐",
		ru = "Подбор Медпаков/\nЯщиков с патронами",
	},
	ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		["zh-cn"] = "玩家拾取医疗箱或弹药罐时显示消息",
		ru = "Показывает сообщение, когда игрок подбирает Медпак или Ящик с патронами",
	},
	-- Pick up scripture / grimoire
	scripture_grimoire_pickup = {
		en = "Scripture / Grimoire picked up",
		de = "Scripture / Grimoire eingesammelt",
		["zh-cn"] = "拾取圣经 / 魔法书",
		ru = "Подбор Писаний/\nГримуаров",
	},
	scripture_grimoire_pickup_description = {
		en = "Shows message when a player picks up scripture or grimoire",
		de = "Zeigt eine Nachricht wenn ein Spieler Scriptures oder Grimoires einsammelt",
		["zh-cn"] = "玩家拾取圣经或魔法书时显示消息",
		ru = "Показывает сообщение, когда игрок подбирает Писания или Гримуары",
	},

-- ##### ████████╗ █████╗ ████╗   ██╗     ███████╗ ####################################################################
-- #####    ██╔══╝██╔══██╗██╔██╗  ██║     ██╔════╝ ####################################################################
-- #####    ██║   ███████║███████╗██║     ███████╗ ####################################################################
-- #####    ██║   ██╔══██║██╔══██║██║     ██╔════╝ ####################################################################
-- #####    ██║   ██║  ██║██████╔╝███████╗███████╗ ####################################################################
-- #####    ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝ ####################################################################

	-- Metal / Diamantine collected
	row_forge_material = {
		en = "Metal / Diamantine collected",
		de = "Metall / Diamantin gesammelt",
		ru = "Собрано Пластали/Диамантина",
	},
	row_forge_material_metal = {
		en = "Metal",
		de = "Metall",
		ru = "Пластали",
	},
	row_forge_material_platinum = {
		en = "Diamantine",
		de = "Diamantin",
		ru = "Диамантина",
	},
	-- Carried Scripture / Grimoire / Other
	row_carrying = {
		en = "Carried Scripture / Grimoire / Other",
		de = "Carried Scripture / Grimoire / Sonst.",
		ru = "Переносил Писание/Гримуар/Другое",
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
	-- Machinery / Gadget operated
	row_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Включено Машин/Гаджетов",
	},
	row_machinery_operated = {
		en = "Machinery",
		de = "Maschine",
		ru = "Машин",
	},
	row_gadget_operated = {
		en = "Gadget",
		de = "Gadget",
		ru = "Гаджетов",
	},
	-- Ammo Picked Up / Wasted
	row_ammo_1 = {
		en = "Ammo Picked Up / Wasted",
		de = "Munition Genommen / Verschwendet",
		ru = "Боеприпасов Взято/Протранжирено",
	},
	row_ammo_2 = {
		en = "Ammo Picked Up",
		de = "Munition Genommen",
		ru = "Боеприпасов Взято",
	},
	row_ammo_picked_up = {
		en = "Picked Up",
		de = "Genommen",
		ru = "Взято",
	},
	row_ammo_wasted = {
		en = "Wasted",
		de = "Verschwendet",
		ru = "Протранжирено",
	},
	-- Medipacks / Ammocaches deployed
	row_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		ru = "Размещ. Медпаков/Ящиков с патронами",
	},
	row_health_placed = {
		en = "Medipacks",
		de = "Medipack",
		ru = "Медпаков",
	},
	row_ammo_placed = {
		en = "Ammocaches",
		de = "Munition",
		ru = "Ящиков с патронами",
	},
	-- Revived / Rescued Operatives
	row_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Оперативников Возрождено/Спасено",
	},
	row_revived_operative = {
		en = "Revived",
		de = "Wiederbelebt",
		ru = "Возрождено",
	},
	row_rescued_operative = {
		en = "Rescued",
		de = "Gerettet",
		ru = "Спасено",
	},
	-- Team Score
	row_team_score = {
		en = "Team Score",
		de = "Team Punkte",
		ru = "Счёт - Командный",
	},
	-- Damage Taken / Health Station Used
	row_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Урона получено/Использ. медстанций",
	},
	row_damage_taken = {
		en = "Damage Taken",
		de = "Genommener Schaden",
		ru = "Урона получено",
	},
	row_heal_station_used = {
		en = "Health Station Used",
		de = "Heilstation benutzt",
		ru = "Использ. медстанций",
	},
	-- Enemies Staggered
	row_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Врагов выведено из равновесия",
	},
	-- Attacks blocked
	row_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Атак заблокировано",
	},
	-- Coherency Efficiency
	row_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Эффективность сплочённости",
	},
	-- Defense Score
	row_defense_score = {
		en = "Defense Score",
		de = "Verteidigung Punkte",
		ru = "Счёт - Защита",
	},
	-- Actual / Overkill Damage Dealt
	row_damage_dealt_1 = {
		en = "Actual / Overkill Damage Dealt",
		de = "Verursachter / Overkill Schaden",
		ru = "Урона нанесено Фактически/Избыточно",
	},
	row_damage_dealt_2 = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		ru = "Урона нанесено",
	},
	row_actual_damage_dealt_1 = {
		en = "Actual",
		de = "Verursachter",
		ru = "Фактически",
	},
	row_actual_damage_dealt_2 = {
		en = "Damage",
		de = "Verursachter",
		ru = "Урона",
	},
	row_overkill_damage_dealt = {
		en = "Overkill",
		de = "Overkill",
		ru = "Избыточно",
	},
	-- Boss Damage Dealt
	row_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Урона нанесено Боссу",
	},
	-- Weakspot / Critical Hits Dealt
	row_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Ударов По слабым местам/Критических",
	},
	row_weakspot_hits = {
		en = "Weakspot",
		de = "Schwachpunkt",
		ru = "По слабым местам",
	},
	row_critical_hits = {
		en = "Critical",
		de = "Kritische",
		ru = "Критических",
	},
	-- Lesser Enemies Killed
	row_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Убито меньших врагов",
	},
	-- Melee / Ranged Elites Killed
	row_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Убито Элиты в Ближнем/Дальнем бою",
	},
	row_melee_threats = {
		en = "Melee",
		de = "Nah-",
		ru = "Ближнем",
	},
	row_ranged_threats = {
		en = "Ranged",
		de = "Fernkampf",
		ru = "Дальнем бою",
	},
	-- Disablers Killed
	row_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убито Обездвиживающих врагов",
	},
	-- Specials Killed
	row_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Убито Специалистов",
	},
	-- Bosses Killed
	row_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Убито Боссов",
	},
	-- Offense Score
	row_offense_score = {
		en = "Offense Score",
		de = "Verteidigung Punkte",
		ru = "Счёт - Нападение",
	},
	-- Total Score
	row_score = {
		en = "Total Score",
		de = "Gesamtpunktzahl",
		ru = "Счёт - Общий",
	},
}
