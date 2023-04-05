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
		["zh-cn"] = "记分板历史记录",
	},
	loc_scoreboard_save = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить таблицу результатов",
		["zh-cn"] = "保存记分板",
	},
	loc_scoreboard_scan = {
		en = "Scan Directory for files",
		de = "Ordner nach Dateien durchsuchen",
		ru = "Поиск файлов",
		["zh-cn"] = "扫描目录中的文件",
	},
	loc_scoreboard_delete = {
		en = "Delete Scoreboard",
		de = "Scoreboard löschen",
		ru = "Удалить таблицу результатов",
		["zh-cn"] = "删除记分板",
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
		ru = "Добавляет таблицу результатов с различной индивидуальной статистикой в конце миссий.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
	},
	-- Buttons
	mod_history_view_title = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
		ru = "История таблицы результатов",
		["zh-cn"] = "记分板历史记录",
	},
	mod_save_scoreboard_to_history = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		ru = "Сохранить таблицу результатов",
		["zh-cn"] = "保存记分板",
	},
	-- Options
	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
		ru = "Открыть таблицу результатов",
		["zh-cn"] = "打开记分板",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
		ru = "Открыть историю таблицы результатов",
		["zh-cn"] = "打开记分板历史记录",
	},
	save_all_scoreboards = {
		en = "Save all Scoreboards",
		de = "Alle Scoreboards speichern",
		ru = "Сохранить все таблицы результатов",
		["zh-cn"] = "保存所有记分板",
	},
	scoreboard_history_cached = {
		en = "Scoreboard History Cached",
		de = "Scoreboard History Zwischengespeichert",
		ru = "История таблицы результатов кэширована",
		["zh-cn"] = "记分板历史记录已缓存",
	},
	zero_values = {
		en = "Zero Values",
		de = "Nullwerte",
		ru = "Нулевые значения",
		["zh-cn"] = "零值",
	},
	zero_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Нормальный",
		["zh-cn"] = "常规",
	},
	zero_values_hide = {
		en = "Hidden",
		de = "Versteckt",
		ru = "Скрытый",
		["zh-cn"] = "隐藏",
	},
	zero_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Темный",
		["zh-cn"] = "深色",
	},
	worst_values = {
		en = "Worst Values",
		de = "Schlechteste Werte",
		ru = "Худшие значения",
		["zh-cn"] = "最差值",
	},
	worst_values_normal = {
		en = "Normal",
		de = "Normal",
		ru = "Нормальный",
		["zh-cn"] = "常规",
	},
	worst_values_dark = {
		en = "Dark",
		de = "Dunkel",
		ru = "Темный",
		["zh-cn"] = "深色",
	},
	generate_scores = {
		en = "Generate Scores",
		de = "Punkte generieren",
		ru = "Генератор очков и счета",
		["zh-cn"] = "生成分数",
	},
	generate_scores_on = {
		en = "On",
		de = "An",
		ru = "Отображать",
		["zh-cn"] = "开",
	},
	generate_scores_space = {
		en = "Empty Row",
		de = "Leere Zeile",
		ru = "Пустое поле",
		["zh-cn"] = "空行",
	},
	generate_scores_off = {
		en = "Off",
		de = "Aus",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	-- Groups
	group_plugins = {
		en = "Plugins",
		de = "Plugins",
		ru = "Плагины",
		["zh-cn"] = "插件",
	},
	group_messages = {
		en = "Messages",
		de = "Nachrichten",
		ru = "Сообщения",
		["zh-cn"] = "消息",
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
		["zh-cn"] = " 拾取了:subject:",
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
		["zh-cn"] = "锻造材料",
	},
	row_forge_material = {
		en = "Metal / Diamantine collected",
		de = "Metall / Diamantin gesammelt",
		ru = "Собрано Пластали/Диамантина",
		["zh-cn"] = "收集塑钢 / 金刚铁",
	},
	row_forge_material_metal = {
		en = "Metal",
		de = "Metall",
		ru = "Пластали",
		["zh-cn"] = "塑钢",
	},
	row_forge_material_platinum = {
		en = "Diamantine",
		de = "Diamantin",
		ru = "Диамантина",
		["zh-cn"] = "金刚铁",
	},
	-- Operated
	plugin_machinery_gadget_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Использовано Механизмов/Гаджетов",
		["zh-cn"] = "操作机器 / 装置",
	},
	row_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		ru = "Использовано Механизмов/Гаджетов",
		["zh-cn"] = "操作机器 / 装置",
	},
	row_machinery_operated = {
		en = "Machinery",
		de = "Maschine",
		ru = "Механизмов",
		["zh-cn"] = "机器",
	},
	row_gadget_operated = {
		en = "Gadget",
		de = "Gadget",
		ru = "Гаджетов",
		["zh-cn"] = "装置",
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
		["zh-cn"] = " 操作了:subject:",
	},
	message_default_machinery = {
		en = "Machinery",
		de = "Maschinerie",
		ru = "Механизмом",
		["zh-cn"] = "机器",
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
		ru = "Расшифровка данных",
		["zh-cn"] = "解码数据",
	},
	message_decoded_text = {
		en = " operated :subject:",
		de = " hat :subject: betätig",
		ru = " управляет :subject:",
		["zh-cn"] = " 操作了:subject:",
	},
	message_decoded_skull = {
		en = "Servoskull",
		de = "Servoskull",
		ru = "Сервочерепом",
		["zh-cn"] = "伺服颅骨",
	},
	message_decoded_scanner = {
		en = "Scanner",
		de = "Scanner",
		ru = "Ауспекс",
		["zh-cn"] = "鸟卜仪",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		ru = "Показывает сообщение, когда игрок расшифровывает данные на терминале",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
	},
	-- Ammo
	plugin_ammo = {
		en = "Ammo",
		de = "Munition",
		ru = "Патроны",
		["zh-cn"] = "弹药",
	},
	plugin_ammo_on = {
		en = "On",
		de = "An",
		ru = "Взято+Лишние",
		["zh-cn"] = "开",
	},
	plugin_ammo_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Простой",
		["zh-cn"] = "简洁",
	},
	plugin_ammo_off = {
		en = "Off",
		de = "Aus",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	row_ammo_1 = {
		en = "Ammo Picked Up / Wasted",
		de = "Munition Genommen / Verschwendet",
		ru = "Патронов Взято / Лишние",
		["zh-cn"] = "拾取 / 浪费弹药",
	},
	row_ammo_2 = {
		en = "Ammo Picked Up",
		de = "Munition Genommen",
		ru = "Патронов Взято",
		["zh-cn"] = "拾取弹药",
	},
	row_ammo_picked_up = {
		en = "Picked Up",
		de = "Genommen",
		ru = "Взято",
		["zh-cn"] = "拾取",
	},
	row_ammo_wasted = {
		en = "Wasted",
		de = "Verschwendet",
		ru = "Лишние",
		["zh-cn"] = "浪费",
	},
	-- Carrying
	plugin_carrying = {
		en = "Carrying Supplies",
		de = "Resourcen getragen",
		ru = "Переноска припасов",
		["zh-cn"] = "携带补给",
	},
	row_carrying = {
		en = "Carried Scripture / Grimoire / Other",
		de = "Carried Scripture / Grimoire / Sonst.",
		ru = "Переносил: Писание/Гримуар/Другое",
		["zh-cn"] = "携带圣经 / 魔法书 / 其他",
	},
	row_carrying_scripture = {
		en = "Scripture",
		de = "Scripture",
		ru = "Писание",
		["zh-cn"] = "圣经",
	},
	row_carrying_grimoire = {
		en = "Grimoire",
		de = "Grimoire",
		ru = "Гримуар",
		["zh-cn"] = "魔法书",
	},
	row_carrying_other = {
		en = "Other",
		de = "Sonst.",
		ru = "Другое",
		["zh-cn"] = "其他",
	},
	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Эффективность Сплочённости",
		["zh-cn"] = "连携效率",
	},
	row_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		ru = "Эффективность Сплочённости",
		["zh-cn"] = "连携效率",
	},
	-- Revive / Rescue
	plugin_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Оперативников Возрождено/Спасено",
		["zh-cn"] = "复活 / 救助特工",
	},
	row_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		ru = "Оперативников Возрождено/Спасено",
		["zh-cn"] = "复活 / 救助特工",
	},
	row_revived_operative = {
		en = "Revived",
		de = "Wiederbelebt",
		ru = "Возрождено",
		["zh-cn"] = "复活",
	},
	row_rescued_operative = {
		en = "Rescued",
		de = "Gerettet",
		ru = "Спасено",
		["zh-cn"] = "救助",
	},
	-- Damage taken / Health station
	plugin_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Урона получено / Мед.Станций исп.",
		["zh-cn"] = "受到伤害 / 使用医疗站",
	},
	row_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		ru = "Урона получено / Мед.Станций исп.",
		["zh-cn"] = "受到伤害 / 使用医疗站",
	},
	row_damage_taken = {
		en = "Damage Taken",
		de = "Genommener Schaden",
		ru = "Урона получено",
		["zh-cn"] = "受到伤害",
	},
	row_heal_station_used = {
		en = "Health Station Used",
		de = "Heilstation benutzt",
		ru = "Мед.Станций исп.",
		["zh-cn"] = "使用医疗站",
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
		["zh-cn"] = " 使用了:subject:",
	},
	message_health_station_health_station = {
		en = "Health Station",
		de = "Heilstation",
		ru = "Мед.Станцию",
		["zh-cn"] = "医疗站",
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
		["zh-cn"] = "输出伤害",
	},
	plugin_damage_dealt_on = {
		en = "On",
		de = "An",
		ru = "Фактический+Избыточный",
		["zh-cn"] = "开",
	},
	plugin_damage_dealt_simple = {
		en = "Simple",
		de = "Einfach",
		ru = "Простой",
		["zh-cn"] = "简洁",
	},
	plugin_damage_dealt_off = {
		en = "Off",
		de = "Aus",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	row_damage_dealt_1 = {
		en = "Actual / Overkill Damage Dealt",
		de = "Verursachter / Overkill Schaden",
		ru = "Урона нанесено Фактически/Избыточно",
		["zh-cn"] = "实际 / 溢出伤害",
	},
	row_damage_dealt_2 = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		ru = "Урона нанесено",
		["zh-cn"] = "输出伤害",
	},
	row_actual_damage_dealt_1 = {
		en = "Actual",
		de = "Verursachter",
		ru = "Фактически",
		["zh-cn"] = "实际",
	},
	row_actual_damage_dealt_2 = {
		en = "Damage",
		de = "Verursachter",
		ru = "Урона",
		["zh-cn"] = "伤害",
	},
	row_overkill_damage_dealt = {
		en = "Overkill",
		de = "Overkill",
		ru = "Избыточно",
		["zh-cn"] = "溢出",
	},
	-- Lesser enemies
	plugin_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Обычных врагов убито",
		["zh-cn"] = "普通敌人击杀",
	},
	row_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		ru = "Обычных врагов убито",
		["zh-cn"] = "普通敌人击杀",
	},
	-- Boss damage
	plugin_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Урона нанесено Боссу",
		["zh-cn"] = "Boss 伤害",
	},
	row_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		ru = "Урона нанесено Боссу",
		["zh-cn"] = "Boss 伤害",
	},
	-- Enemies staggered
	plugin_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Врагов ошеломлено",
		["zh-cn"] = "踉跄敌人",
	},
	row_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		ru = "Врагов ошеломлено",
		["zh-cn"] = "踉跄敌人",
	},
	-- Attacks blocked
	plugin_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Атак заблокировано",
		["zh-cn"] = "格挡攻击",
	},
	row_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		ru = "Атак заблокировано",
		["zh-cn"] = "格挡攻击",
	},
	-- Special hits
	plugin_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Попаданий: Слабое место/Криты",
		["zh-cn"] = "弱点 / 暴击命中",
	},
	row_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		ru = "Попаданий: Слабое место/Криты",
		["zh-cn"] = "弱点 / 暴击命中",
	},
	row_weakspot_hits = {
		en = "Weakspot",
		de = "Schwachpunkt",
		ru = "Слабое место",
		["zh-cn"] = "弱点",
	},
	row_critical_hits = {
		en = "Critical",
		de = "Kritische",
		ru = "Криты",
		["zh-cn"] = "暴击",
	},
	-- Melee / Ranged Threats
	plugin_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Убито элитных Милишников/Стрелков",
		["zh-cn"] = "近战 / 远程精英击杀",
	},
	row_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		ru = "Убито элитных Милишников/Стрелков",
		["zh-cn"] = "近战 / 远程精英击杀",
	},
	row_melee_threats = {
		en = "Melee",
		de = "Nah-",
		ru = "Милишников",
		["zh-cn"] = "近战",
	},
	row_ranged_threats = {
		en = "Ranged",
		de = "Fernkampf",
		ru = "Стрелков",
		["zh-cn"] = "远程",
	},
	-- Special Threats
	plugin_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Взрывун/Бомбардир/Огневик/Снайпер",
		["zh-cn"] = "专家击杀",
	},
	row_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		ru = "Взрывун/Бомбардир/Огневик/Снайпер",
		["zh-cn"] = "专家击杀",
	},
	-- Boss Threats
	plugin_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Убито Боссов",
		["zh-cn"] = "Boss 击杀",
	},
	row_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		ru = "Убито Боссов",
		["zh-cn"] = "Boss 击杀",
	},
	-- Disabler
	plugin_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убито Гончая/Мутант/Ловушечник",
		["zh-cn"] = "控制类击杀",
	},
	row_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		ru = "Убито Гончая/Мутант/Ловушечник",
		["zh-cn"] = "控制类击杀",
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
		["zh-cn"] = " 拾取了 :count: :subject: 浪费 :count2:",
	},
	message_ammo_crate_text = {
		en = " picked up :count: :subject:",
		de = " hat :count: :subject: aufgesammelt",
		ru = " подбирает :count: :subject:",
		["zh-cn"] = " 拾取了 :count: :subject:",
	},
	message_ammo_ammo = {
		en = "Ammo",
		de = "Munition",
		ru = "патрона(ов)",
		["zh-cn"] = "弹药",
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
		ru = "Размещено Аптечек/Боеприпасов",
		["zh-cn"] = "部署医疗箱 / 弹药箱",
	},
	row_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		ru = "Размещено Аптечек/Боеприпасов",
		["zh-cn"] = "部署医疗箱 / 弹药箱",
	},
	row_health_placed = {
		en = "Medipacks",
		de = "Medipack",
		ru = "Аптечек",
		["zh-cn"] = "医疗箱",
	},
	row_ammo_placed = {
		en = "Ammocaches",
		de = "Munition",
		ru = "Боеприпасов",
		["zh-cn"] = "弹药箱",
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
		["zh-cn"] = " 部署了:subject:",
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
		["zh-cn"] = "部署弹药箱",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		ru = "Показывает сообщение когда игрок размещает боеприпасы",
		["zh-cn"] = "玩家部署弹药箱时显示消息",
	},
	-- Pick up ammocache / medipack
	ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		ru = "Аптечка / Боеприпасы взяты",
		["zh-cn"] = "拾取医疗箱 / 弹药箱",
	},
	ammo_health_pickup_text = {
		en = " picked up :subject:",
		de = " hat :subject: genommen",
		ru = " подбирает :subject:",
		["zh-cn"] = " 拾取了:subject:",
	},
	ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		ru = "Показывает сообщение когда игрок подбирает аптечку или боеприпасы",
		["zh-cn"] = "玩家拾取医疗箱或弹药箱时显示消息",
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
		["zh-cn"] = "团队分数",
	},
	row_defense_score = {
		en = "Defense Score",
		de = "Verteidigung Punkte",
		ru = "Очки за оборону",
		["zh-cn"] = "防御分数",
	},
	row_offense_score = {
		en = "Offense Score",
		de = "Verteidigung Punkte",
		ru = "Очки за нападение",
		["zh-cn"] = "进攻分数",
	},
	row_score = {
		en = "Total Score",
		de = "Gesamtpunktzahl",
		ru = "Общий счет",
		["zh-cn"] = "总分数",
	},
}
