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
		fr = "Historique des scores",
		ru = "История таблицы результатов",
		["zh-cn"] = "记分板历史记录",
	},
	loc_scoreboard_save = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		fr = "Sauvegarder le tableau",
		ru = "Сохранить таблицу результатов",
		["zh-cn"] = "保存记分板",
	},
	loc_scoreboard_scan = {
		en = "Scan Directory for files",
		de = "Ordner nach Dateien durchsuchen",
		fr = "Scanner les fichiers du dossier",
		ru = "Поиск файлов",
		["zh-cn"] = "扫描目录中的文件",
	},
	loc_scoreboard_delete = {
		en = "Delete Scoreboard",
		de = "Scoreboard löschen",
		fr = "Supprimer le tableau",
		ru = "Удалить таблицу результатов",
		["zh-cn"] = "删除记分板",
	},
	-- Fix unlocalized vanilla training grounds name
	loc_sg_enter_sg = {
		en = "Training Grounds",
		de = "Training Grounds",
		fr = "Terrain d'Entrainement",
		ru = "Тренировочные площадки", -- ?
		["zh-cn"] = "训练场",
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
		fr = "Tableau des scores",
		ru = "таблицу", -- ?
		["zh-cn"] = "记分板",
	},
	mod_description = {
		en = "Adds a scoreboard with various individual stats at the end of missions.",
		de = "Zeigt nach Missionsende ein Scoreboard mit individuellen Statistiken.",
		fr = "Ajoute un tableau des scores avec diverses statistiques individuelles à la fin des missions.",
		ru = "Добавляет таблицу результатов с различной индивидуальной статистикой в конце миссий.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
	},
	-- Buttons
	mod_history_view_title = {
		en = "Scoreboard History",
		de = "Scoreboard Historie",
		fr = "Historique des tableaux des scores",
		ru = "История таблицы результатов",
		["zh-cn"] = "记分板历史记录",
	},
	mod_save_scoreboard_to_history = {
		en = "Save Scoreboard",
		de = "Scoreboard Speichern",
		fr = "Sauvegarder le tableau des scores",
		ru = "Сохранить таблицу результатов",
		["zh-cn"] = "保存记分板",
	},
	-- Options
	dev_mode = {
		en = "Developer Mode",
		de = "Entwicklermodus",
		fr = "Mode développeur", -- ?
		ru = "Режим разработчика", -- ?
		["zh-cn"] = "开发者模式",
	},
	scoreboard_panel_height = {
		en = "Maximum Scoreboard Height",
		de = "Maximale Scoreboardgröße",
		fr = "Taille maximale du tableau de bord", -- ?
		ru = "Максимальный размер таблицу", -- ?
		["zh-cn"] = "最大记分板高度",
	},
	tactical_overview = {
		en = "Tactical Overview [TAB]",
		de = "Taktische Übersicht [TAB]",
		fr = "Vue d'ensemble tactique [TAB]", -- ?
		ru = "Тактический обзор [TAB]", -- ?
		["zh-cn"] = "战术覆盖 [TAB]",
	},
	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
		fr = "Ouvrir le tableau des scores",
		ru = "Открыть таблицу результатов",
		["zh-cn"] = "打开记分板",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
		fr = "Ouvrir l'historique des tableaux des scores",
		ru = "Открыть историю таблицы результатов",
		["zh-cn"] = "打开记分板历史记录",
	},
	save_all_scoreboards = {
		en = "Save all Scoreboards",
		de = "Alle Scoreboards speichern",
		fr = "Sauvegarder tous les tableaux des scores",
		ru = "Сохранить все таблицы результатов",
		["zh-cn"] = "保存所有记分板",
	},
	scoreboard_history_cached = {
		en = "Scoreboard History Cached",
		de = "Scoreboard History Zwischengespeichert",
		fr = "Historique du tableau des scores mis en mémoire",
		ru = "История таблицы результатов кэширована",
		["zh-cn"] = "记分板历史记录已缓存",
	},
	zero_values = {
		en = "Zero Values",
		de = "Nullwerte",
		fr = "Valeurs nulles",
		ru = "Нулевые значения",
		["zh-cn"] = "零值",
	},
	zero_values_normal = {
		en = "Normal",
		de = "Normal",
		fr = "Normales",
		ru = "Нормальный",
		["zh-cn"] = "常规",
	},
	zero_values_hide = {
		en = "Hidden",
		de = "Versteckt",
		fr = "Cachées",
		ru = "Скрытый",
		["zh-cn"] = "隐藏",
	},
	zero_values_dark = {
		en = "Dark",
		de = "Dunkel",
		fr = "Sombres",
		ru = "Темный",
		["zh-cn"] = "深色",
	},
	worst_values = {
		en = "Worst Values",
		de = "Schlechteste Werte",
		fr = "Pires valeurs",
		ru = "Худшие значения",
		["zh-cn"] = "最差值",
	},
	worst_values_normal = {
		en = "Normal",
		de = "Normal",
		fr = "Normales",
		ru = "Нормальный",
		["zh-cn"] = "常规",
	},
	worst_values_dark = {
		en = "Dark",
		de = "Dunkel",
		fr = "Sombres",
		ru = "Темный",
		["zh-cn"] = "深色",
	},
	generate_scores = {
		en = "Generate Scores",
		de = "Punkte generieren",
		fr = "Générer les scores",
		ru = "Генератор очков и счета",
		["zh-cn"] = "生成分数",
	},
	generate_scores_on = {
		en = "On",
		de = "An",
		fr = "Activé",
		ru = "Отображать",
		["zh-cn"] = "开",
	},
	generate_scores_space = {
		en = "Empty Row",
		de = "Leere Zeile",
		fr = "Ligne vide",
		ru = "Пустое поле",
		["zh-cn"] = "空行",
	},
	generate_scores_off = {
		en = "Off",
		de = "Aus",
		fr = "Désactivé",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	-- Groups
	group_plugins = {
		en = "Plugins",
		de = "Plugins",
		fr = "Plugins",
		ru = "Плагины",
		["zh-cn"] = "插件",
	},
	group_messages = {
		en = "Messages",
		de = "Nachrichten",
		fr = "Messages",
		ru = "Сообщения",
		["zh-cn"] = "消息",
	},
	-- Forge material
	message_forge_material = {
		en = "Forge Material",
		de = "Schmiedematerial",
		fr = "Matériaux de forge",
		ru = "Ресурсы",
		["zh-cn"] = "锻造材料",
	},
	message_forge_material_text = {
		en = " picked up :subject:",
		de = " hat :subject: aufgesammelt",
		fr = " a rammassé :subject:",
		ru = " подбирает :subject:",
		["zh-cn"] = "拾取了:subject:",
	},
	message_forge_material_description = {
		en = "Shows message when a player picks up plasteel or diamantine",
		de = "Zeigt eine Nachricht wenn ein Spieler Plasteel oder Diamantine einsammelt",
		fr = "Affiche un message lorsqu'un joueur ramasse un Plastacier ou de la Diamantine",
		ru = "Показывает сообщения когда игрок подбирает ресурсы",
		["zh-cn"] = "玩家拾取塑钢或金刚铁时显示消息",
	},
	plugin_forge_material = {
		en = "Forge Materials",
		de = "Schmiedematerial",
		fr = "Matériaux de forge",
		ru = "Ресурсы",
		["zh-cn"] = "锻造材料",
	},
	row_forge_material = {
		en = "Metal / Diamantine collected",
		de = "Metall / Diamantin gesammelt",
		fr = "Plastacier / Diamantine collectés",
		ru = "Собрано Пластали/Диамантина",
		["zh-cn"] = "收集塑钢 / 金刚铁",
	},
	row_forge_material_metal = {
		en = "Metal",
		de = "Metall",
		fr = "Plastacier",
		ru = "Пластали",
		["zh-cn"] = "塑钢",
	},
	row_forge_material_platinum = {
		en = "Diamantine",
		de = "Diamantin",
		fr = "Diamantine",
		ru = "Диамантина",
		["zh-cn"] = "金刚铁",
	},
	-- Operated
	plugin_machinery_gadget_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		fr = "Machine / Gadget utilisés",
		ru = "Использовано Механизмов/Гаджетов",
		["zh-cn"] = "操作机器 / 装置",
	},
	row_operated = {
		en = "Machinery / Gadget operated",
		de = "Maschine / Gadget bedient",
		fr = "Machine / Gadget utilisés",
		ru = "Использовано Механизмов/Гаджетов",
		["zh-cn"] = "操作机器 / 装置",
	},
	row_machinery_operated = {
		en = "Machinery",
		de = "Maschine",
		fr = "Machine",
		ru = "Механизмов",
		["zh-cn"] = "机器",
	},
	row_gadget_operated = {
		en = "Gadget",
		de = "Gadget",
		fr = "Gadget",
		ru = "Гаджетов",
		["zh-cn"] = "装置",
	},
	-- Buttons etc
	message_default = {
		en = "Buttons Operated",
		de = "Schalter betätigt",
		fr = "Boutons utilisés",
		ru = "Нажатие кнопок",
		["zh-cn"] = "操作按钮",
	},
	message_default_text = {
		en = " operated :subject:",
		de = " hat :subject: betätigt",
		fr = " a actionné :subject:",
		ru = " управляет :subject:",
		["zh-cn"] = "操作了:subject:",
	},
	message_default_machinery = {
		en = "Machinery",
		de = "Maschinerie",
		fr = "Machine",
		ru = "Механизмом",
		["zh-cn"] = "机器",
	},
	message_default_description = {
		en = "Shows message when a player operates a normal button",
		de = "Zeigt eine Nachricht wenn ein Spieler einen Schalter betätigt",
		fr = "Affiche un message quand un joueur appuies sur un bouton normal",
		ru = "Показывает сообщение, когда игрок нажимает обычную кнопку",
		["zh-cn"] = "玩家操作普通按钮时显示消息",
	},
	-- Data decoded
	message_decoded = {
		en = "Data decoded",
		de = "Daten dekodiert",
		fr = "Données décodées",
		ru = "Расшифровка данных",
		["zh-cn"] = "解码数据",
	},
	message_decoded_text = {
		en = " operated :subject:",
		de = " hat :subject: betätig",
		fr = " a actionné :subject:",
		ru = " управляет :subject:",
		["zh-cn"] = "操作了:subject:",
	},
	message_decoded_skull = {
		en = "Servoskull",
		de = "Servoskull",
		fr = "Servo-crânes",
		ru = "Сервочерепом",
		["zh-cn"] = "伺服颅骨",
	},
	message_decoded_scanner = {
		en = "Scanner",
		de = "Scanner",
		fr = "Scan",
		ru = "Ауспекс",
		["zh-cn"] = "鸟卜仪",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		fr = "Affiche un message lorsqu'un joueur décode des données à un terminal",
		ru = "Показывает сообщение, когда игрок расшифровывает данные на терминале",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
	},
	-- Ammo
	plugin_ammo = {
		en = "Ammo",
		de = "Munition",
		fr = "Munitions",
		ru = "Патроны",
		["zh-cn"] = "弹药",
	},
	plugin_ammo_on = {
		en = "Bullet Amount",
		de = "Patronenanzahl",
		fr = "Montant de la puce", -- ?
		ru = "Количество пули", -- ?
		["zh-cn"] = "弹药数量",
	},
	plugin_ammo_simple = {
		en = "Ammo Packs",
		de = "Munitionspakete",
		fr = "Packs de munitions", -- ?
		ru = "Боеприпасы", -- ?
		["zh-cn"] = "弹药补给",
	},
	plugin_ammo_off = {
		en = "Off",
		de = "Aus",
		fr = "Désactivé",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	row_ammo_1 = {
		en = "Ammo Picked Up / Wasted",
		de = "Munition Genommen / Verschwendet",
		fr = "Munitions Rammassées / Gâchées",
		ru = "Патронов Взято / Лишние",
		["zh-cn"] = "拾取 / 浪费弹药",
	},
	row_ammo_2 = {
		en = "Ammo Picked Up",
		de = "Munition Genommen",
		fr = "Munitions rammassées",
		ru = "Патронов Взято",
		["zh-cn"] = "拾取弹药",
	},
	row_ammo_picked_up = {
		en = "Picked Up",
		de = "Genommen",
		fr = "Rammassées",
		ru = "Взято",
		["zh-cn"] = "拾取",
	},
	row_ammo_wasted = {
		en = "Wasted",
		de = "Verschwendet",
		fr = "Gâchées",
		ru = "Лишние",
		["zh-cn"] = "浪费",
	},
	-- Carrying
	plugin_carrying = {
		en = "Carrying Supplies",
		de = "Resourcen getragen",
		fr = "Ressources transportées",
		ru = "Переноска припасов",
		["zh-cn"] = "携带补给",
	},
	row_carrying = {
		en = "Carried Scripture / Grimoire / Other",
		de = "Carried Scripture / Grimoire / Sonst.",
		fr = "Texte sacré / Grimoire / Autre",
		ru = "Переносил: Писание/Гримуар/Другое",
		["zh-cn"] = "携带圣经 / 魔法书 / 其他",
	},
	row_carrying_scripture = {
		en = "Scripture",
		de = "Scripture",
		fr = "Texte sacré",
		ru = "Писание",
		["zh-cn"] = "圣经",
	},
	row_carrying_grimoire = {
		en = "Grimoire",
		de = "Grimoire",
		fr = "Grimoire",
		ru = "Гримуар",
		["zh-cn"] = "魔法书",
	},
	row_carrying_other = {
		en = "Other",
		de = "Sonst.",
		fr = "Autre",
		ru = "Другое",
		["zh-cn"] = "其他",
	},
	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		fr = "Efficacité de syntonie",
		ru = "Эффективность Сплочённости",
		["zh-cn"] = "连携效率",
	},
	row_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz",
		fr = "Efficacité de syntonie",
		ru = "Эффективность Сплочённости",
		["zh-cn"] = "连携效率",
	},
	-- Revive / Rescue
	message_revived_rescued = {
		en = "Revived / Rescued",
		de = "Wiederbelebt / Gerettet",
		-- fr = "Réanimés / Secourus", --> ?
		-- ru = "Возрождено/Спасено", --> ?
		["zh-cn"] = "复苏 / 营救",
	},
	message_rescued_text = {
		en = " rescued :subject:",
		de = " hat :subject: gerettet",
		-- fr = " a rammassé :subject:",
		-- ru = " подбирает :subject:",
		["zh-cn"] = "营救了:subject:",
	},
	message_revived_text = {
		en = " revived :subject:",
		de = " hat :subject: wiederbelebt",
		-- fr = " a rammassé :subject:",
		-- ru = " подбирает :subject:",
		["zh-cn"] = "复苏了:subject:",
	},
	message_revived_rescued_description = {
		en = "Shows message when a player revives / rescues another player",
		de = "Zeigt eine Nachricht wenn ein Spieler einen anderen Spieler wiederbelebt / rettet",
		-- fr = "Affiche un message lorsqu'un joueur ramasse un Plastacier ou de la Diamantine",
		-- ru = "Показывает сообщения когда игрок подбирает ресурсы",
		["zh-cn"] = "玩家复苏 / 营救另一名玩家时显示消息",
	},
	plugin_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		fr = "Opérateur Réanimés / Secourus",
		ru = "Оперативников Возрождено/Спасено",
		["zh-cn"] = "复苏 / 营救特工",
	},
	row_revived_rescued = {
		en = "Revived / Rescued Operatives",
		de = "Operator Wiederbelebt / Gerettet",
		fr = "Opérateurs Réanimés / Secourus",
		ru = "Оперативников Возрождено/Спасено",
		["zh-cn"] = "复苏 / 营救特工",
	},
	row_revived_operative = {
		en = "Revived",
		de = "Wiederbelebt",
		fr = "Réanimés",
		ru = "Возрождено",
		["zh-cn"] = "复苏",
	},
	row_rescued_operative = {
		en = "Rescued",
		de = "Gerettet",
		fr = "Secourus",
		ru = "Спасено",
		["zh-cn"] = "营救",
	},
	-- Damage taken / Health station
	plugin_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		fr = "Dégâts Subis / Stations de soin utilisées",
		ru = "Урона получено / Мед.Станций исп.",
		["zh-cn"] = "受到伤害 / 使用医疗站",
	},
	row_damage_taken_heal_station_used = {
		en = "Damage Taken / Health Station Used",
		de = "Genommener Schaden / Heilstation benutzt",
		fr = "Dégâts Subis / Stations de soin utilisées",
		ru = "Урона получено / Мед.Станций исп.",
		["zh-cn"] = "受到伤害 / 使用医疗站",
	},
	row_damage_taken = {
		en = "Damage Taken",
		de = "Genommener Schaden",
		fr = "Dommages subis",
		ru = "Урона получено",
		["zh-cn"] = "受到伤害",
	},
	row_heal_station_used = {
		en = "Health Station Used",
		de = "Heilstation benutzt",
		fr = "Stations de soin utilisées",
		ru = "Мед.Станций исп.",
		["zh-cn"] = "使用医疗站",
	},
	message_health_station = {
		en = "Health Station",
		de = "Heilstation",
		fr = "Station de soin",
		ru = "Мед.Станция",
		["zh-cn"] = "医疗站",
	},
	message_health_station_text = {
		en = " used :subject:",
		de = " hat :subject: benutzt",
		fr = " a utilisé :subject:",
		ru = " использует :subject:",
		["zh-cn"] = "使用了:subject:",
	},
	message_health_station_health_station = {
		en = "Health Station",
		de = "Heilstation",
		fr = "Station de soin",
		ru = "Мед.Станцию",
		["zh-cn"] = "医疗站",
	},
	message_health_station_description = {
		en = "Shows message when a player uses a health station",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Heilstation benutzt",
		fr = "Affiche un message lorsqu'un joueur utilise une station de soin",
		ru = "Показывает сообщение когда игрок использует мед.станцию",
		["zh-cn"] = "玩家使用医疗站时显示消息",
	},
	-- Damage dealt
	plugin_damage_dealt = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		fr = "Dégâts infligés",
		ru = "Урона нанесено",
		["zh-cn"] = "输出伤害",
	},
	plugin_damage_dealt_on = {
		en = "On",
		de = "An",
		fr = "Activé",
		ru = "Фактический+Избыточный",
		["zh-cn"] = "开",
	},
	plugin_damage_dealt_simple = {
		en = "Simple",
		de = "Einfach",
		fr = "Simple",
		ru = "Простой",
		["zh-cn"] = "简洁",
	},
	plugin_damage_dealt_off = {
		en = "Off",
		de = "Aus",
		fr = "Désactivé",
		ru = "Отключить",
		["zh-cn"] = "关",
	},
	row_damage_dealt_1 = {
		en = "Actual / Overkill Damage Dealt",
		de = "Verursachter / Overkill Schaden",
		fr = "Dégâts Réels / Overkill infligés",
		ru = "Урона нанесено Фактически/Избыточно",
		["zh-cn"] = "实际 / 溢出伤害",
	},
	row_damage_dealt_2 = {
		en = "Damage Dealt",
		de = "Verursachter Schaden",
		fr = "Dégâts infligés",
		ru = "Урона нанесено",
		["zh-cn"] = "输出伤害",
	},
	row_actual_damage_dealt_1 = {
		en = "Actual",
		de = "Verursachter",
		fr = "Réels",
		ru = "Фактически",
		["zh-cn"] = "实际",
	},
	row_actual_damage_dealt_2 = {
		en = "Damage",
		de = "Verursachter",
		fr = "Dégâts",
		ru = "Урона",
		["zh-cn"] = "伤害",
	},
	row_overkill_damage_dealt = {
		en = "Overkill",
		de = "Overkill",
		fr = "Overkill",
		ru = "Избыточно",
		["zh-cn"] = "溢出",
	},
	-- Lesser enemies
	plugin_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		fr = "Ennemis mineurs tués",
		ru = "Обычных врагов убито",
		["zh-cn"] = "普通敌人击杀",
	},
	row_lesser_enemies = {
		en = "Lesser Enemies Killed",
		de = "Schwache Gegner Getötet",
		fr = "Ennemis mineurs tués",
		ru = "Обычных врагов убито",
		["zh-cn"] = "普通敌人击杀",
	},
	-- Boss damage
	plugin_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		fr = "Dégâts infligés aux Boss",
		ru = "Урона нанесено Боссу",
		["zh-cn"] = "Boss 伤害",
	},
	row_boss_damage_dealt = {
		en = "Boss Damage Dealt",
		de = "Schaden an Bossen",
		fr = "Dégâts infligés aux Boss",
		ru = "Урона нанесено Боссу",
		["zh-cn"] = "Boss 伤害",
	},
	-- Enemies staggered
	plugin_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		fr = "Ennemis vacillés",
		ru = "Врагов ошеломлено",
		["zh-cn"] = "踉跄敌人",
	},
	row_enemies_staggerd = {
		en = "Enemies Staggered",
		de = "Gegner gestaggered",
		fr = "Ennemis vacillés",
		ru = "Врагов ошеломлено",
		["zh-cn"] = "踉跄敌人",
	},
	-- Attacks blocked
	plugin_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		fr = "Attaques bloquées",
		ru = "Атак заблокировано",
		["zh-cn"] = "格挡攻击",
	},
	row_attacks_blocked = {
		en = "Attacks blocked",
		de = "Attacken geblockt",
		fr = "Attaques bloquées",
		ru = "Атак заблокировано",
		["zh-cn"] = "格挡攻击",
	},
	-- Special hits
	plugin_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		fr = "Coups aux Points Faibles / Critiques",
		ru = "Попаданий: Слабое место/Криты",
		["zh-cn"] = "弱点 / 暴击命中",
	},
	row_special_hits = {
		en = "Weakspot / Critical Hits Dealt",
		de = "Schwachpunkt- / Kritische Treffer",
		fr = "Coups aux Points Faibles / Critiques",
		ru = "Попаданий: Слабое место/Криты",
		["zh-cn"] = "弱点 / 暴击命中",
	},
	row_weakspot_hits = {
		en = "Weakspot",
		de = "Schwachpunkt",
		fr = "Points Faibles",
		ru = "Слабое место",
		["zh-cn"] = "弱点",
	},
	row_critical_hits = {
		en = "Critical",
		de = "Kritische",
		fr = "Critiques",
		ru = "Криты",
		["zh-cn"] = "暴击",
	},
	-- Melee / Ranged Threats
	plugin_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		fr = "Élites de Mêlée / Distance tués",
		ru = "Убито элитных Милишников/Стрелков",
		["zh-cn"] = "近战 / 远程精英击杀",
	},
	row_melee_ranged_threats = {
		en = "Melee / Ranged Elites Killed",
		de = "Nah- / Fernkampf Elite getötet",
		fr = "Élites de Mêlée / Distance tués",
		ru = "Убито элитных Милишников/Стрелков",
		["zh-cn"] = "近战 / 远程精英击杀",
	},
	row_melee_threats = {
		en = "Melee",
		de = "Nah-",
		fr = "Mêlée",
		ru = "Милишников",
		["zh-cn"] = "近战",
	},
	row_ranged_threats = {
		en = "Ranged",
		de = "Fernkampf",
		fr = "Distance",
		ru = "Стрелков",
		["zh-cn"] = "远程",
	},
	-- Special Threats
	plugin_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		fr = "Spéciaux tués",
		ru = "Взрывун/Бомбардир/Огневик/Снайпер",
		["zh-cn"] = "专家击杀",
	},
	row_special_threats = {
		en = "Specials Killed",
		de = "Spezialeinheiten Getötet",
		fr = "Spéciaux tués",
		ru = "Взрывун/Бомбардир/Огневик/Снайпер",
		["zh-cn"] = "专家击杀",
	},
	-- Boss Threats
	plugin_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		fr = "Boss tués",
		ru = "Убито Боссов",
		["zh-cn"] = "Boss 击杀",
	},
	row_boss_threats = {
		en = "Bosses Killed",
		de = "Bosse Getötet",
		fr = "Boss tués",
		ru = "Убито Боссов",
		["zh-cn"] = "Boss 击杀",
	},
	-- Disabler
	plugin_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		fr = "Incapacitants tués",
		ru = "Убито Гончая/Мутант/Ловушечник",
		["zh-cn"] = "控制类击杀",
	},
	row_disabler_threats = {
		en = "Disablers Killed",
		de = "Ausschalter Getötet",
		fr = "Incapacitants tués",
		ru = "Убито Гончая/Мутант/Ловушечник",
		["zh-cn"] = "控制类击杀",
	},
	-- Ammo
	message_ammo = {
		en = "Ammo",
		de = "Munition",
		fr = "Munitions",
		ru = "Патроны",
		["zh-cn"] = "弹药",
	},
	message_ammo_text = {
		en = " picked up :count: :subject: wasted :count2:",
		de = " hat :count: :subject: aufgesammelt :count2: verschwendet",
		fr = " a rammassé :count: :subject: et gaspillé :count2:",
		ru = " подбирает :count: :subject: теряет :count2:",
		["zh-cn"] = "拾取了 :count: :subject: 浪费 :count2:",
	},
	message_ammo_crate_text = {
		en = " picked up :count: :subject:",
		de = " hat :count: :subject: aufgesammelt",
		fr = " a rammassé :count: :subject:",
		ru = " подбирает :count: :subject:",
		["zh-cn"] = "拾取了 :count: :subject:",
	},
	message_ammo_ammo = {
		en = "Ammo",
		de = "Munition",
		fr = "Munitions",
		ru = "патрона(ов)",
		["zh-cn"] = "弹药",
	},
	message_ammo_description = {
		en = "Shows message when a player picks up ammo",
		de = "Zeigt eine Nachricht wenn ein Spieler Munition einsammelt",
		fr = "Affiche un message lorsqu'un joueur rammasse des munitions",
		ru = "Показывает сообщение когда игрок подбирает патроны",
		["zh-cn"] = "玩家拾取弹药时显示消息",
	},
	-- Deploy
	plugin_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		fr = "Caisses de soin / munitions déployés",
		ru = "Размещено Аптечек/Боеприпасов",
		["zh-cn"] = "部署医疗包 / 弹药箱",
	},
	row_health_ammo_placed = {
		en = "Medipacks / Ammocaches deployed",
		de = "Medipack / Munition aufgestellt",
		fr = "Caisses de soin / munitions déployés",
		ru = "Размещено Аптечек/Боеприпасов",
		["zh-cn"] = "部署医疗包 / 弹药箱",
	},
	row_health_placed = {
		en = "Medipacks",
		de = "Medipack",
		fr = "Caisses de soin",
		ru = "Аптечек",
		["zh-cn"] = "医疗包",
	},
	row_ammo_placed = {
		en = "Ammocaches",
		de = "Munition",
		fr = "Caisses de munitions",
		ru = "Боеприпасов",
		["zh-cn"] = "弹药箱",
	},
	-- Deploy medipack
	message_health_placed = {
		en = "Medipack deployed",
		de = "Medipack platziert",
		fr = "Caisse de soin déployée",
		ru = "Аптечка размещена",
		["zh-cn"] = "部署医疗包",
	},
	message_health_placed_text = {
		en = " deployed :subject:",
		de = " hat :subject: platziert",
		fr = " a déployé :subject:",
		ru = " развёртывает :subject:",
		["zh-cn"] = "部署了:subject:",
	},
	message_health_placed_description = {
		en = "Shows message when a player deployes medipack",
		de = "Zeigt eine Nachicht wenn ein Spieler ein Medipack platziert",
		fr = "Affiche un message lorsqu'un joueur déploie une caisse de soin",
		ru = "Показывает сообщение когда игрок размещает аптечку",
		["zh-cn"] = "玩家部署医疗包时显示消息",
	},
	-- Deploy ammocache
	message_ammo_placed = {
		en = "Ammocache deployed",
		de = "Munitionskiste",
		fr = "Caisse de munitions déployée",
		ru = "Боеприпасы размещены",
		["zh-cn"] = "部署弹药箱",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		fr = "Affiche un message lorsqu'un joueur déploie une caisse de munitions",
		ru = "Показывает сообщение когда игрок размещает боеприпасы",
		["zh-cn"] = "玩家部署弹药箱时显示消息",
	},
	-- Pick up ammocache / medipack
	message_ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		fr = "Caisse de soin / munitions récupérées",
		ru = "Аптечка / Боеприпасы взяты",
		["zh-cn"] = "拾取医疗包 / 弹药箱",
	},
	message_ammo_health_pickup_text = {
		en = " picked up :subject:",
		de = " hat :subject: genommen",
		fr = " a rammassé :subject:",
		ru = " подбирает :subject:",
		["zh-cn"] = "拾取了:subject:",
	},
	message_ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		fr = "Affiche un message lorsqu'un joueur ramasse une caisse de soin ou une caisse de munitions",
		ru = "Показывает сообщение когда игрок подбирает аптечку или боеприпасы",
		["zh-cn"] = "玩家拾取医疗包或弹药箱时显示消息",
	},
	-- Pick up scripture / grimoire
	scripture_grimoire_pickup = {
		en = "Scripture / Grimoire picked up",
		de = "Scripture / Grimoire eingesammelt",
		fr = "Texte sacré / Grimoire récupéré",
		ru = "Писание / Гримуар взят",
		["zh-cn"] = "拾取圣经 / 魔法书",
	},
	scripture_grimoire_pickup_description = {
		en = "Shows message when a player picks up scripture or grimoire",
		de = "Zeigt eine Nachricht wenn ein Spieler Scriptures oder Grimoires einsammelt",
		fr = "Affiche un message lorsqu'un joueur ramasse un texte sacré ou un grimoire",
		ru = "Показывает сообщение когда игрок подбирает писание или гримуар",
		["zh-cn"] = "玩家拾取圣经或魔法书时显示消息",
	},
	row_team_score = {
		en = "Team Score",
		de = "Team Punkte",
		fr = "Score d'équipe",
		ru = "Командные очки",
		["zh-cn"] = "团队分数",
	},
	row_defense_score = {
		en = "Defense Score",
		de = "Abwehr Punkte",
		fr = "Score de défense",
		ru = "Очки за оборону",
		["zh-cn"] = "防御分数",
	},
	row_offense_score = {
		en = "Offense Score",
		de = "Angriff Punkte",
		fr = "Score d'attaque",
		ru = "Очки за нападение",
		["zh-cn"] = "进攻分数",
	},
	row_score = {
		en = "Total Score",
		de = "Gesamt Punkte",
		fr = "Score total",
		ru = "Общий счет",
		["zh-cn"] = "总分数",
	},
	row_ammo_clip_crate_picked_up = {
		en = "Ammo Small / Large / Crate Picked Up",
		de = "Munition Klein / Groß / Cache Picked Up",
		fr = "Munitions petites / grandes / caisses ramassées", -- ?
		ru = "Боеприпасы маленькие / большие / ящики подобраны", -- ?
		["zh-cn"] = "拾取小弹药罐 / 大弹药包 / 弹药箱",
	},
	row_ammo_small_picked_up = {
		en = "Small",
		de = "Klein",
		fr = "petites", -- ?
		ru = "маленькие", -- ?
		["zh-cn"] = "小弹药罐",
	},
	row_ammo_large_picked_up = {
		en = "Large",
		de = "Groß",
		fr = "grandes", -- ?
		ru = "большие", -- ?
		["zh-cn"] = "大弹药包",
	},
	row_ammo_crate_picked_up = {
		en = "Crate",
		de = "Cache",
		fr = "caisses", -- ?
		ru = "ящики", -- ?
		["zh-cn"] = "弹药箱",
	},
	history_won = {
		en = "WON",
		["zh-cn"] = "成功",
	},
	history_lost = {
		en = "LOST",
		["zh-cn"] = "失败",
	},
}
