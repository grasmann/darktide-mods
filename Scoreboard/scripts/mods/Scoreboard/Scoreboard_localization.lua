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
		ru = "Просканировать папку",
	},
})

-- ##### ██╗      ██████╗  ██████╗ █████╗ ██╗      ####################################################################
-- ##### ██║     ██╔═══██╗██╔════╝██╔══██╗██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ███████║██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ██╔══██║██║      ####################################################################
-- ##### ███████╗╚██████╔╝╚██████╗██║  ██║███████╗ ####################################################################
-- ##### ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝ ####################################################################

return {
	mod_title = {
		en = "Scoreboard",
		["zh-cn"] = "记分板",
		ru = "Scoreboard",
	},
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
	mod_description = {
		en = "Adds a scoreboard with various individual stats at the end of missions.",
		de = "Zeigt nach Missionsende ein Scoreboard mit individuellen Statistiken.",
		["zh-cn"] = "任务结束时添加显示各种统计数据的记分板。",
		ru = "Добавляет таблицу результатов с различной индивидуальной статистикой в конце миссий.",
	},
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

	open_scoreboard = {
		en = "Open Scoreboard",
		de = "Scoreboard öffnen",
		ru = "Открыть таблицу результатов",
	},
	open_scoreboard_history = {
		en = "Open Scoreboard History",
		de = "Scoreboard Historie öffnen",
		ru = "Открыть историю таблицы результатов",
	},

	-- Cohereny
	plugin_coherency_efficiency = {
		en = "Coherency Efficiency",
		de = "Kohärenz Effizienz"
		ru = "Эффективность Сплочённости",
	},
	-- Ammo
	message_ammo = {
		en = "Ammo",
		de = "Munition",
		["zh-cn"] = "弹药",
		ru = "Боеприпасы",
	},
	message_ammo_description = {
		en = "Shows message when a player picks up ammo",
		de = "Zeigt eine Nachricht wenn ein Spieler Munition einsammelt",
		["zh-cn"] = "玩家拾取弹药时显示消息",
		ru = "Показывает сообщение, когда игрок подбирает боеприпасы",
	},
	-- Health station
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
		ru = "Показывает сообщение, когда игрок использует медстанцию",
	},
	-- Forge material
	message_forge_material = {
		en = "Forge Material",
		de = "Schmiedematerial",
		["zh-cn"] = "锻造材料",
		ru = "Материалы для кузницы",
	},
	message_forge_material_description = {
		en = "Shows message when a player picks up plasteel or diamantine",
		de = "Zeigt eine Nachricht wenn ein Spieler Plasteel oder Diamantine einsammelt",
		["zh-cn"] = "玩家拾取塑钢或金刚铁时显示消息",
		ru = "Показывает сообщение, когда игрок поднимает пласталь или диамантин",
	},
	-- Buttons etc
	message_default = {
		en = "Buttons Operated",
		de = "Schalter betätigt",
		["zh-cn"] = "操作按钮",
		ru = "Кнопок нажато",
	},
	message_default_description = {
		en = "Shows message when a player operates a normal button",
		de = "Zeigt eine Nachricht wenn ein Spieler einen Schalter betätigt",
		["zh-cn"] = "玩家操作普通按钮时显示消息",
		ru = "Показывает сообщение, когда игрок нажимает обычную кнопку",
	},
	-- Deploy medipack
	message_health_placed = {
		en = "Medipack deployed",
		de = "Medipack platziert",
		["zh-cn"] = "部署医疗箱",
		ru = "Медпак выложен",
	},
	message_health_placed_description = {
		en = "Shows message when a player deployes medipack",
		de = "Zeigt eine Nachicht wenn ein Spieler ein Medipack platziert",
		["zh-cn"] = "玩家部署医疗箱时显示消息",
		ru = "Показывает сообщение, когда игрок выложил медпак",
	},
	-- Deploy ammocache
	message_ammo_placed = {
		en = "Ammocache deployed",
		de = "Munitionskiste",
		["zh-cn"] = "部署弹药罐",
		ru = "Ящик боеприпасов выложен",
	},
	message_ammo_placed_description = {
		en = "Shows message when a player deployes ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler eine Munitionskiste platziert",
		["zh-cn"] = "玩家部署弹药罐时显示消息",
		ru = "Показывает сообщение, когда игрок выложил ящик с боеприпасами",
	},
	-- Data decoded
	message_decoded = {
		en = "Data decoded",
		de = "Daten dekodiert",
		["zh-cn"] = "解码数据",
		ru = "Данные расшифрованы",
	},
	message_decoded_description = {
		en = "Shows message when a player decodes data at a terminal",
		de = "Zeigt eine Nachricht wenn ein Spieler Daten dekodiert",
		["zh-cn"] = "玩家在终端机解码数据时显示消息",
		ru = "Показывает сообщение, когда игрок расшифровывает данные на терминале",
	},
	-- Pick up ammocache / medipack
	ammo_health_pickup = {
		en = "Medipack / Ammocache picked up",
		de = "Medipack / Munitionskiste",
		["zh-cn"] = "拾取医疗箱 / 弹药罐",
		ru = "Медпак/Ящик боеприпасов подобран",
	},
	ammo_health_pickup_description = {
		en = "Shows message when a player picks up medipack or ammocache",
		de = "Zeigt eine Nachricht wenn ein Spieler Medipack oder Munitionskiste einsammelt",
		["zh-cn"] = "玩家拾取医疗箱或弹药罐时显示消息",
		ru = "Показывает сообщение, когда игрок берет медпак или ящик с боеприпасами",
	},
	-- Pick up scripture / grimoire
	scripture_grimoire_pickup = {
		en = "Scripture / Grimoire picked up",
		de = "Scripture / Grimoire eingesammelt",
		["zh-cn"] = "拾取圣经 / 魔法书",
		ru = "Писание/Гримуар подобран",
	},
	scripture_grimoire_pickup_description = {
		en = "Shows message when a player picks up scripture or grimoire",
		de = "Zeigt eine Nachricht wenn ein Spieler Scriptures oder Grimoires einsammelt",
		["zh-cn"] = "玩家拾取圣经或魔法书时显示消息",
		ru = "Показывает сообщение, когда игрок берет писание или гримуар",
	},
}
