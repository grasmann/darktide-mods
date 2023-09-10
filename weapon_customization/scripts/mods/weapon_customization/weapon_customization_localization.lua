local mod = get_mod("weapon_customization")

mod:add_global_localize_strings({
	loc_weapon_cosmetics_customization = {
		en = "Customization",
		de = "Anpassung",
		ru = "Настройка",
	},
})

return {
	mod_title = {
		en = "Extended Weapon Customization",
		de = "Erweiterte Waffenanpassung",
		ru = "Расширенная настройка оружия",
	},
	mod_description = {
		en = "Extends weapon customizations",
		de = "Erweitert Waffenanpassungen",
		ru = "Extended Weapon Customization – значительно расширяет возможности настройки внешнего вида оружия.",
	},
	mod_option_debug = {
		en = "Debug",
		de = "Debug",
		ru = "Отладка",
	},
	mod_option_weapon_build_animation = {
		en = "Weapon Animations",
		de = "Waffen Animationen",
	},
	mod_option_weapon_build_animation_speed = {
		en = "Speed",
		de = "Geschwindigkeit",
	},
	mod_option_weapon_build_animation_wobble = {
		en = "Wobble",
		de = "Wackeln",
	},
	mod_option_weapon_build_animation_speed_unit = {
		en = "Seconds",
		de = "Sekunden",
	},
	mod_option_flashlight_shadows = {
		en = "Flashlight Shadows",
		de = "Taschenlampenschatten",
		ru = "Тень от фонарика",
	},
	mod_option_flashlight_flicker = {
		en = "Flashlight Flicker",
		de = "Taschenlampenflimmern",
		ru = "Мерцание света фонарика",
	},
	mod_option_flashlight_flicker_start = {
		en = "Flicker on Activate",
		de = "Filmmern beim Einschalten",
		ru = "Мерцание при включении",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset All",
		de = "Alles Zurücksetzen",
		ru = "Сбросить всё",
	},
	loc_weapon_inventory_no_reset_button = {
		en = "No Changes",
		de = "Keine Änderungen",
		ru = "Без изменений",
	},
	loc_weapon_inventory_randomize_button = {
		en = "Randomize",
		de = "Zufällig",
		ru = "Случайно",
	},
	loc_weapon_inventory_demo_button = {
		en = "Demo",
		de = "Demo",
	},
	loc_weapon_cosmetics_customization_flashlight = {
		en = "Special",
		de = "Spezial",
		ru = "Специальный",
	},
	loc_weapon_cosmetics_customization_barrel = {
		en = "Barrel",
		de = "Lauf",
		ru = "Ствол",
	},
	loc_weapon_cosmetics_customization_underbarrel = {
		en = "Underbarrel",
		de = "Unterlauf",
		ru = "Подствольник",
	},
	loc_weapon_cosmetics_customization_muzzle = {
		en = "Muzzle",
		de = "Mündung",
		ru = "Дуло",
	},
	loc_weapon_cosmetics_customization_receiver = {
		en = "Receiver",
		de = "Gehäuse",
		ru = "Ствольная коробка",
	},
	loc_weapon_cosmetics_customization_magazine = {
		en = "Magazine",
		de = "Magazin",
		ru = "Магазин",
	},
	loc_weapon_cosmetics_customization_grip = {
		en = "Grip",
		de = "Griff",
		ru = "Рукоять",
	},
	loc_weapon_cosmetics_customization_bayonet = {
		en = "Bayonet",
		de = "Bajonett",
		ru = "Штык",
	},
	loc_weapon_cosmetics_customization_handle = {
		en = "Handle",
		de = "Handgriff",
		ru = "Черен",
	},
	loc_weapon_cosmetics_customization_stock = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
	},
	loc_weapon_cosmetics_customization_ventilation = {
		en = "Ventilation",
		de = "Ventilation",
		ru = "Охлаждение",
	},
	loc_weapon_cosmetics_customization_stock_2 = {
		en = "Stock",
		de = "Schaft",
		ru = "Ложа",
	},
	loc_weapon_cosmetics_customization_sight = {
		en = "Sight",
		de = "Visier",
		ru = "Прицел",
	},
	loc_weapon_cosmetics_customization_body = {
		en = "Body",
		de = "Aufbau",
		ru = "Рама",
	},
	loc_weapon_cosmetics_customization_rail = {
		en = "Rail",
		de = "Schiene",
		ru = "Рельса",
	},
	loc_weapon_cosmetics_customization_pommel = {
		en = "Pommel",
		de = "Knauf",
		ru = "Навершие",
	},
	loc_weapon_cosmetics_customization_hilt = {
		en = "Hilt",
		de = "Heft",
	},
	loc_weapon_cosmetics_customization_head = {
		en = "Head",
		de = "Kopf",
		ru = "Головка",
	},
	loc_weapon_cosmetics_customization_blade = {
		en = "Blade",
		de = "Klinge",
		ru = "Клинок",
	},
	loc_weapon_cosmetics_customization_teeth = {
		en = "Teeth",
		de = "Zähne",
	},
	loc_weapon_cosmetics_customization_chain = {
		en = "Chain",
		de = "Kette",
	},
	loc_weapon_cosmetics_customization_shaft = {
		en = "Shaft",
		de = "Schaft",
		ru = "Рукоять",
	},
	loc_weapon_cosmetics_customization_connector = {
		en = "Connector",
		de = "Verbindung",
	},
	loc_weapon_cosmetics_customization_left = {
		en = "Shield",
		de = "Schild",
		ru = "Щит",
	},
	loc_weapon_cosmetics_customization_emblem_right = {
		en = "Emblem Right",
		de = "Wappen Rechts",
		ru = "Эмблема правая",
	},
	loc_weapon_cosmetics_customization_emblem_left = {
		en = "Emblem Left",
		de = "Wappen Links",
		ru = "Эмблема левая",
	},
	loc_weapon_cosmetics_customization_shaft_lower = {
		en = "Lower Shaft",
		de = "Unterer Schaft",
		ru = "Нижняя часть рукояти",
	},
	loc_weapon_cosmetics_customization_shaft_upper = {
		en = "Upper Shaft",
		de = "Oberer Schaft",
		ru = "Верхняя часть рукояти",
	},
	loc_weapon_cosmetics_customization_trinket_hook = {
		en = "Trinket Hook",
		de = "Trinket Haken",
	},
}
