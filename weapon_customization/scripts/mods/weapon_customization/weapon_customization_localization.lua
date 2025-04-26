local mod = get_mod("weapon_customization")

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬    ┬  ┌─┐┌─┐┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #########################################################
-- ##### │ ┬│  │ │├┴┐├─┤│    │  │ ││  ├─┤│  │┌─┘├─┤ │ ││ ││││ #########################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #########################################################

mod:add_global_localize_strings({
	loc_weapon_cosmetics_customization = {
		en = "Customization",
		de = "Anpassung",
		ru = "Настройка",
		["zh-cn"] = "自定义",
	},
	loc_weapon_special_laser_pointer = {
		en = "Laser Pointer",
		de = "Laserpointer",
		ru = "Лазерный указатель",
		["zh-cn"] = "激光指示器",
	},
	loc_stats_special_action_laser_pointer_desc = {
		en = "Turn on or off the weapon mounted laser pointer.\nAlso functions as a torch. Useful in dark areas.",
		de = "Schalte den an der Waffe montierten Laserpointer ein oder aus.\nFunktioniert auch als Taschenlampe. Nützlich in dunklen Bereichen.",
		ru = "Включите или выключите установленный на оружии лазерный указатель.\nТакже работает как фонарик. Полезно в тёмных местах.",
		["zh-cn"] = "开启或关闭武器挂载激光指示器。\n同时也可作为手电筒。适合黑暗区域。",
	},
	loc_visible_equipment_customization = {
		en = "Visible Equipment",
		de = "Sichtbare Ausrüstung",
		ru = "Видимое снаряжение",
		["zh-cn"] = "装备可见",
	},
	loc_visible_equipment_option_1 = {
		en = "Character",
		de = "Charakter",
		ru = "Персонаж",
	},
	loc_visible_equipment_option_2 = {
		en = "Weapon",
		de = "Waffe",
		ru = "Оружие",
	},
	loc_visible_equipment_option_3 = {
		en = "Armour",
		de = "Rüstung",
		ru = "Броня",
	},
	loc_visible_equipment_option_4 = {
		en = "Backpack",
		de = "Rucksack",
		ru = "Рюкзак",
	},
	loc_visible_equipment_only_this = {
		en = "Only this weapon",
		de = "Nur diese Waffe",
		ru = "Только это оружие",
	},
	loc_visible_equipment_all = {
		en = "All",
		de = "Alle",
		ru = "Всё",
	},
	loc_visible_equipment_save_button_prompt = {
		en = "Save",
		de = "Speichern",
		ru = "Сохранить",
	},
	loc_visible_equipment_reset_button_prompt = {
		en = "Reset",
		de = "Zurücksetzen",
		ru = "Сбросить",
	},
	loc_use_modding_tool = {
		en = "Use Modding Tool",
		de = "Modding Tool Benutzen",
		ru = "Использовать ",
	},
	loc_empty = {
		en = "",
	}
})

-- ##### ┬  ┌─┐┌─┐┌─┐┬    ┬  ┌─┐┌─┐┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ ############################################################
-- ##### │  │ ││  ├─┤│    │  │ ││  ├─┤│  │┌─┘├─┤ │ ││ ││││ ############################################################
-- ##### ┴─┘└─┘└─┘┴ ┴┴─┘  ┴─┘└─┘└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ ############################################################

return {
	-- ##### ┌┬┐┌─┐┌┬┐ ################################################################################################
	-- ##### ││││ │ ││ ################################################################################################
	-- ##### ┴ ┴└─┘─┴┘ ################################################################################################
	mod_title = {
		en = "Extended Weapon Customization",
		de = "Erweiterte Waffenanpassung",
		ru = "Расширенная настройка оружия",
		["zh-cn"] = "武器自定义扩展",
	},
	mod_description = {
		en = "Extends weapon customizations",
		de = "Erweitert Waffenanpassungen",
		ru = "Extended Weapon Customization – значительно расширяет возможности настройки внешнего вида оружия и добавляет дополнительные обвесы: лазерную указку, фонарики, прицелы и другое.",
		["zh-cn"] = "武器自定义扩展",
	},
	-- ##### ┌┬┐┌─┐┌┐ ┬ ┬┌─┐ ##########################################################################################
	-- #####  ││├┤ ├┴┐│ ││ ┬ ##########################################################################################
	-- ##### ─┴┘└─┘└─┘└─┘└─┘ ##########################################################################################
	group_debug = {
		en = "Debug",
		de = "Debug",
		ru = "Отладка",
		["zh-cn"] = "调试",
	},
	mod_option_debug = {
		en = "Debug",
		de = "Debug",
		ru = "Включить отладку",
		["zh-cn"] = "调试",
	},
	-- demo_mode = {
	-- 	en = "Demo Mode",
	-- 	de = "Demo Modus",
	-- 	ru = "Демо-режим",
	-- 	["zh-cn"] = "演示模式",
	-- },
	-- ##### ┌┬┐┬┌─┐┌─┐ ###############################################################################################
	-- ##### ││││└─┐│   ###############################################################################################
	-- ##### ┴ ┴┴└─┘└─┘ ###############################################################################################
	group_misc = {
		en = "Miscellaneous",
		de = "Verschiedenes",
		ru = "Разное",
		["zh-cn"] = "杂项",
	},
	group_crouch_animation = {
		en = "Crouch Animation",
		de = "Ducken Animation",
		ru = "Анимация при приседании",
		["zh-cn"] = "蹲伏时动画",
	},
	mod_option_crouch_animation = {
		en = "Crouch Animation System",
		de = "Duck-Animations System",
	},
	mod_option_crouch_animation_tooltip = {
		en = "Toggle crouch animation system",
		de = "Duck-Animations System umschalten",
	},
	group_sling = {
		en = "Weapon Sling System",
		de = "Waffengurt System",
	},
	mod_option_sling = {
		en = "Weapon Sling System WIP",
		de = "Waffengurt System WIP",
	},
	mod_option_sling_tooltip = {
		en = "Toggle weapon sling system WIP",
		de = "Waffengurt System umschalten WIP",
	},
	group_weapon_sway = {
		en = "Sway Animation",
		de = "Schwank Animation",
	},
	mod_option_sway = {
		en = "Sway System",
		de = "Schwank-System",
	},
	mod_option_sway_tooltip = {
		en = "Toggle sway system",
		de = "Schwank-System umschalten",
	},
	mod_option_misc_sway = {
		en = "Sway Animation",
		de = "Schwank Animation",
		ru = "Анимации качания",
		["zh-cn"] = "摇晃动画",
	},
	mod_option_misc_sway_tooltip = {
		en = "Plays a weapon sway animation when turning",
		de = "Spielt eine Waffenschwank-Bewegungsanimation beim Drehen",
		ru = "Проигрываются анимации качания оружия при поворотах",
		["zh-cn"] = "转身时播放武器摇晃动画",
	},
	mod_option_misc_sway_aim = {
		en = "When Aiming",
		de = "Beim Zielen",
		ru = "При прицеливании",
	},
	mod_option_misc_sway_aim_tooltip = {
		en = "Plays a weapon sway animation when aiming",
		de = "Spielt eine Waffenschwank-Bewegungsanimation beim Zielen",
		ru = "Проигрывается анимация",
	},
	mod_option_keep_packages = {
		en = "Lock weapon packages",
		de = "Waffenpakete sperren",
	},
	mod_option_keep_packages_tooltip = {
		en = "Keep all weapon packages loaded",
		de = "Alle Waffenpakete geladen halten",
	},
	mod_option_keep_packages_off = {
		en = "Off",
		de = "Aus",
		ru = "Никому",
		["zh-cn"] = "关闭",
	},
	mod_option_keep_packages_hub = {
		en = "Hub Only",
		de = "Nur im Hub",
	},
	mod_option_keep_packages_always = {
		en = "Always",
		de = "Immer",
	},
	mod_option_misc_attachment_names = {
		en = "Attachment Names",
		de = "Waffenteilnamen",
		ru = "Названия обвесов",
		["zh-cn"] = "附件名称",
	},
	mod_option_misc_attachment_names_tooltip = {
		en = "Replace attachment names",
		de = "Ersetzt die Waffenteilnamen",
		ru = "Заменяет названия всех обвесов для оружия.",
		["zh-cn"] = "替换附件名称",
	},
	-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌┐┌┌─┐┌┬┐┌─┐┌─┐ ##########################################################
	-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   │││├─┤│││├┤ └─┐ ##########################################################
	-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   ┘└┘┴ ┴┴ ┴└─┘└─┘ ##########################################################
	mod_attachment_names_company = {
		en = "Flakmark",
		de = "Flakmark",
		ru = "Флакмарк",
		["zh-cn"] = "机密型号",
	},
	mod_attachment_flashlight_01 = {
		en = "Omnissiah's Glow",
		de = "Omnissiah's Glanz",
		ru = "Сияние Омниссии",
		["zh-cn"] = "欧姆尼塞亚的圣光",
	},
	mod_attachment_flashlight_02 = {
		en = "Lumen Imperialis",
		de = "Imperiales Licht",
		ru = "Люмен Империалис",
		["zh-cn"] = "帝国之流明",
	},
	mod_attachment_flashlight_03 = {
		en = "Deathwatch Radiant",
		de = "Todeswacht Strahl",
		ru = "Сияние Караула Смерти",
		["zh-cn"] = "死亡守望光辉",
	},
	mod_attachment_flashlight_04 = {
		en = "Chaosbane Luminary",
		de = "Chaosbann Leuchte",
		ru = "Светило Погибели Хаоса",
		["zh-cn"] = "混沌祸根发光灵体",
	},
	mod_attachment_flashlight_05 = {
		en = "Glowy Stick",
		de = "Leuchtender Stock",
	},
	mod_attachment_flashlight_06 = {
		en = "Big Shiny",
		de = "Großes Glänzendes",
	},
	mod_attachment_laser_pointer = {
		en = "Sanctified Targeter",
		de = "Geheiligter Zielerfasser",
		ru = "Освящённый целеуказатель",
		["zh-cn"] = "圣化指向仪",
	},
	mod_attachment_scope_01 = {
		en = "Martyr's Gaze",
		de = "Blick des Märtyrers",
		ru = "Взор мученика",
		["zh-cn"] = "殉道者的凝视",
	},
	mod_attachment_scope_02 = {
		en = "Exterminatus Lens",
		de = "Exterminatus Linse",
		ru = "Объектив Экстерминатуса",
		["zh-cn"] = "灭绝透镜",
	},
	mod_attachment_scope_03 = {
		en = "Ranger's Vigil",
		de = "Wächter des Rangers",
		ru = "Бдение рейнджера",
		["zh-cn"] = "游侠的守灵式",
	},
	mod_attachment_default = {
		en = "Default",
		de = "Standard",
		ru = "Стандартный",
		["zh-cn"] = "默认",
	},
	mod_attachment_no_stock = {
		en = "No Stock",
		de = "Kein Schaft",
		ru = "Без приклада",
		["zh-cn"] = "无枪托",
	},
	mod_attachment_mk = {
		en = "Mk ",
		de = "Mk ",
		ru = "Мод ",
		["zh-cn"] = "Mk.",
	},
	mod_attachment_kasr = {
		en = "Kasr",
		de = "Kasr",
		ru = "Каср",
		["zh-cn"] = "壁垒",
	},
	mod_attachment_remove = {
		en = "Sabre|Stubber|Twin.linked|Twin.Linked|Twin.Linked Heavy Stubber|Ripper Gun|Rumbler|Kickback|Ogryn Thumper|Grenadier Gauntlet|Cleaver|Power Maul|Battle Maul & Mk III Slab Shield|Battle Maul & Mk 3 Slab Shield|Bully Club|Shredder Autopistol|Helbore Lasgun|Laspistol|Infantry Autogun|Headhunter Autogun|Braced Autogun|Spearhead Boltgun|Boltgun|Infantry Lasgun| pattern lasgun|Heavy|Autogun|Recon Lasgun| Purgation Flamer|Flamer| pattern flamer|Combat Shotgun|Stub Revolver|Stubrevolver|Plasma Gun|Force Staff|Duelling Sword|Blaze Force Sword|Force Sword|Power Sword|Sword|Combat Axe|Tactical Axe|Assault Chainsword|Chainsword|Combat Blade|Model Powersword|Assault Chainaxe|Chainaxe|pattern|unknown manufacture|Sapper Shovel|Thunder Hammer|Crusher|Model Powermaul|Eviscerator|Camo|[()]|Latrine Shovel|Battle Maul & Slabshield|Pattern|Lasgun|Ogryn Powermaul & Slabshield|04",
		de = "-Rippergun|-Schwert|Doppelläufiges|-Maschinengewehr|-Tarnung|[():]|Rippergun|-Camo|-Rückschlag|-Prügel|Rückschlag|-Grenadierhandschuh|Grenadierhandschuh|-Hackmesser|Hackmesser|-Energiestreitkolben|.Kampf.Streitkolben|& Orox.Klotzschild Mk III|& Orox.Klotzschild Mk 3|-Schlägerkeule|-Kampfaxt|Kampfaxt| Taktische Axt|.Sturm.Kettenschwert|Sturm.Kettenschwert|.Kampfklinge|Kampfklinge|.Energieschwert|Energieschwert|Pionierspaten|.Sturm.Kettenaxt|.Helbore.Lasergewehr|Infanterie.Lasergewehr|.Kundschafter.Lasergewehr| Schwere Laserpistole|.Muster.Lasergewehr|.Infanterie.Sturmgewehr|.Stabilisation.Sturmgewehr|.Kopfjäger.Sturmgewehr|.Sturmgewehr|.Schredder.Maschinenpistole|Speerspitze.Boltpistole|Schwere Laserpistole|.Läuterungs.Flammenwerfer|Läuterungs.Flammenwerfer|.Einsatzschrotflinte|Einsatzschrotflinte|Infanterie|Sturmgewehr|Schredder.Maschinenpistole|.Speerspitze.Boltpistole|.Plasmagewehr|.Stub.Revolver|Stub.Revolver|.Purgatus.Psistab|Purgatus.Psistab|Leerenschlag.Psistab|.Trauma.Psistab|.Welle.Psistab|Leerenschlag.|.Psistab|.Glut.Psischwert|Glut.Psischwert|Psischwert|isches Duellschwert|.Donnerhammer|Donnerhammer|.Brecher|Brecher|Schwerer Ausweider|Schwerer|.Ausweider|.Schweres Schwert|.Läuterungsflammenwerfer",
		ru = "Спаренный тяжёлый стаббер|Дробовик-потрошитель|Гранатомёт|Дробовик|Отбойник огрина|Гренадерская перчатка|Тесак|Силовая булава|Боевая булава и Мод III|Боевая булава и Мод 3|Дубина задиры|Щит-плита|щит-плита|Автопистолет-крошитель|Автопистолет|-крошитель|Хельборовое лазружьё|Тяжёлый лазпистолет|Тяжелый лазпистолет|Пехотный автомат|Автомат-головострел|Усиленный автомат|Пронзающий болтер|Болтер|Лазвинтовка пехоты| образец лазгана|Тяжёлый|Автомат|-головострел|Лазвинтовка разведки|Лазган|Пехотный лазган| Огнемёт очищения|Огнемет чистки|Огнемёт| образец огнемёта|дробовик|Стаб-револьвер|Плазменная винтовка|Психосиловой|посох|чистки|пустотный|Силовой посох|Силовой|Травма|Молния|Пургатус|Пустотный|Дуэльный меч|Пламенный силовой меч|Силовой меч|Силовой меч|Меч|Тактический|Штурмовой пиломеч|Пиломеч|клинок|Мод Силовой меч|Штурмовой пилотопор|Пилотопор|образец|неизвестный производитель|Сапёрная лопата|Громовой|Крушитель|Мод Силовая булава|Потрошитель|Камуфляж|камуфляж|Стаб|-револьвер|быстрый|«Коготь дьявола»|пылающий|Пламенный психосиловой|оперативник|Штурмовой цепной|Тяжелый эвисцератор|меч|Дробитель|подлатанный подручными средствами|-потрошитель|Рубило|Отбойник|Боевая булава|и щит Верзилы мод. III|Палица задиры|Катачанский|Рамблер|Спаренный тяжелый пулемет|топор|цепной|Хелборский лазган|охотника за головами|Разведывательный лазган|Серийный автомат|Скорострельный|стаб|Тяжелый|дуэльный |Огненный психосиловой|очищения|тический психосиловой|Волновой психосиловой|Щит|\"|-плита|Пылающий|психосиловой|Травмы|Импульса|Пустоты|Хельборское|Адскобуровое|лазружьё|лазган|лазвинтовка|Плазмаган|плазмаган|Плазмомёт|Грозовой|молот|боевое снаряжение|Шоковая|булава|Саперная лопата|Малая саперная лопата|Малая саперная лопатка|Кавалерийская| святилища|Боевой|Ogryn| Хладнокровных|М35|Болт|-пистолет|благословенный| Красного|||||[()]|",
		["zh-cn"] = "等离子枪|步兵激光枪|样式激光枪|地狱钻激光枪|侦察激光枪|侦查激光枪|重型激光手枪|粉碎者自动手枪|步兵自动枪|支架式自动枪|稳固自动枪|猎头者自动枪|猎颅者自动枪|自动枪|神射手机关步枪|速发左轮枪|左轮机枪|左轮枪|先锋爆矢枪|矛头爆矢枪|涤罪火焰喷射器|创伤力场杖|虚空打击力场杖|激涌力场杖|电涌力场杖|净化力场杖|力场杖|开膛枪|开膛手霰弹枪|战斗霰弹枪|霰弹枪|低吼者|击退者|双联重型机枪|双联重机枪|掷弹兵臂铠|砍刀|恶霸棍棒|动力锤|作战大锤&板砖盾牌|作战大锤与板砖盾牌|作战大锤|与板砖大盾 Mk.III|与板砖大盾 Mk.3|板砖盾牌|粉碎者|能量锤|震慑锤|雷霆锤|战斧|战术斧|战斗利刃|公测铲|公厕铲|工兵铲|突击链锯剑|的链锯剑|链锯剑|重型链锯斧|突击链锯斧|动力巨剑|动力剑|能量巨剑|能量剑|战斗剑|决斗剑|炙焰力场巨剑|炙焰力场剑|的力场剑|力场剑|重型剑|重剑|重型开膛剑|剑|迷彩|[()]|（|）",
	},
	-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐ #######################################################################################
	-- ##### └─┐│  │ │├─┘├┤ └─┐ #######################################################################################
	-- ##### └─┘└─┘└─┘┴  └─┘└─┘ #######################################################################################
	group_scopes = {
		en = "Scopes",
		de = "Zielfernrohre",
		ru = "Прицелы",
		["zh-cn"] = "瞄准镜",
	},
	mod_option_scopes = {
		en = "Sight System",
	},
	mod_option_scopes_tooltip = {
		en = "Toggle sight system",
	},
	mod_option_scopes_sound = {
		en = "Sounds",
		de = "Geräusche",
		ru = "Звуки",
		["zh-cn"] = "声音",
	},
	mod_option_scopes_sound_tooltip = {
		en = "Plays a sound when activating scope aiming.",
		de = "Spielt ein Geräusch ab wenn das Zielfernrohr aktiviert wird.",
		ru = "Воспроизводится звук при активации прицеливания.",
		["zh-cn"] = "激活瞄准镜时播放声音。",
	},
	mod_option_scopes_particle = {
		en = "Effect",
		de = "Effekt",
		ru = "Эффект",
		["zh-cn"] = "效果",
	},
	mod_option_scopes_particle_tooltip = {
		en = "Adds a screen effect to scope aiming.",
		de = "Fügt einen Bildschirmeffekt zum Zielfernrohr-Zielen hinzu.",
		ru = "Добавляет экранный эффект при прицеливании.",
		["zh-cn"] = "添加瞄准镜屏幕效果。",
	},
	mod_option_scopes_hide_when_not_aiming = {
		en = "Hide reticle",
		de = "Zielpunkt verstecken",
	},
	mod_option_scopes_hide_when_not_aiming_tooltip = {
		en = "Hides the sight reticle when not aiming",
		de = "Versteckt den Zielfernrohr-Zielpunkt wenn nicht gezielt wird",
	},
	mod_option_scopes_recoil = {
		en = "Recoil",
		de = "Rüstoß",
		ru = "Отдача",
		["zh-cn"] = "后坐",
	},
	mod_option_scopes_recoil_tooltip = {
		en = "Recoil strength when aiming a scope.",
		de = "Rückstoßstärke beim Zielen mit einem Zielfernrohr.",
		ru = "Сила отдачи при прицеливании.",
		["zh-cn"] = "使用瞄准镜时的后坐强度。",
	},
	mod_option_scopes_sway = {
		en = "Sway",
		de = "Schwanken",
		ru = "Раскачивание",
		["zh-cn"] = "晃动",
	},
	mod_option_scopes_sway_tooltip = {
		en = "Sway strength when aiming a scope.",
		de = "Schwankstärke beim Anvisieren eines Zielfernrohrs.",
		ru = "Сила раскачивания при прицеливании.",
		["zh-cn"] = "使用瞄准镜时晃动强度。",
	},
	mod_option_scopes_reticle_size = {
		en = "Reticle Size",
		de = "Fadenkreuzgröße",
		ru = "Размер перекрестия",
		["zh-cn"] = "标线尺寸",
	},
	mod_option_scopes_reticle_size_tooltip = {
		en = "Set reticle size for scopes.",
		de = "Setze Fadenkreuzgröße für Zielfernrohre.",
		ru = "Установите размер перекрестия для прицелов.",
		["zh-cn"] = "设置瞄准镜标线尺寸。",
	},
	mod_option_scopes_lens_transparency = {
		en = "Lens Transparency",
		de = "Linsentransparenz",
		ru = "Прозрачность линзы",
	},
	mod_option_scopes_lens_transparency_tooltip = {
		en = "Set lens transparency for scopes.",
		de = "Setze Linsentransparenz für Zielfernrohre.",
		ru = "Устанавливает прозрачность линзы прицелов.",
	},
	mod_option_deactivate_crosshair_aiming = {
		en = "Deactivate Crosshair",
		de = "Zielkreuz Deaktivieren",
		ru = "Деактивировать перекрестие",
		["zh-cn"] = "禁用准星",
	},
	mod_option_deactivate_crosshair_aiming_tooltip = {
		en = "Crosshair is automatically hidden when a scope is aimed",
		de = "Zielkreuz wird automatisch versteckt wenn Zielfernrohr benutzt wird",
		ru = "Перекрестие автоматически скрывается при прицеливании.",
		["zh-cn"] = "使用瞄准镜时自动隐藏准星",
	},
	mod_option_deactivate_laser_aiming = {
		en = "Deactivate Laser Pointer",
		de = "Laserpointer Deaktivieren",
		ru = "Деактивировать лазерный указатель",
		["zh-cn"] = "禁用激光指示器",
	},
	mod_option_deactivate_laser_aiming_tooltip = {
		en = "Laser pointer is automatically hidden when a scope is aimed",
		de = "Laserpointer wird automatisch versteckt wenn Zielfernrohr benutzt wird",
		ru = "Лазерный указатель автоматически скрывается при прицеливании.",
		["zh-cn"] = "使用瞄准镜时自动隐藏激光指示器",
	},
	-- ##### ┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┬┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ ######################################################################
	-- ##### ├┬┘├─┤│││ │││ │││││┌─┘├─┤ │ ││ ││││ ######################################################################
	-- ##### ┴└─┴ ┴┘└┘─┴┘└─┘┴ ┴┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ ######################################################################
	group_randomization = {
		en = "Randomization",
		de = "Randomisierung",
		ru = "Случайные варианты оружия",
		["zh-cn"] = "随机化",
	},
	mod_option_randomization_only_base_mod = {
		en = "Base mod only",
		de = "Nur Basismod",
		ru = "Только основной мод",
	},
	mod_option_randomization_only_base_mod_tooltip = {
		en = "Randomization is limited to base mod weapon attachments",
		de = "Randomisierung ist beschränkt auf Basismod Waffenteile",
		ru = "Случайные варианты оружия ограничиваются базовыми обвесами.",
	},
	mod_option_randomization_store = {
		en = "Store",
		de = "Geschäft",
		ru = "Магазин",
		["zh-cn"] = "商店",
	},
	mod_option_randomization_store_tooltip = {
		en = "Randomize weapons in the store",
		de = "Randomisierung der Waffen im Geschäft",
		ru = "Создавать случайные варианты оружия в магазине.",
		["zh-cn"] = "随机化商店中的武器",
	},
	mod_option_randomization_players = {
		en = "Players",
		de = "Spieler",
		ru = "Игроки",
		["zh-cn"] = "玩家",
	},
	mod_option_randomization_players_tooltip = {
		en = "Randomize weapons of other players",
		de = "Randomisierung der Waffen der anderen Spieler",
		ru = "Создавать случайные варианты оружия у других игроков.",
		["zh-cn"] = "随机化其他玩家的武器",
	},
	mod_option_randomization_reward = {
		en = "Rewards",
		de = "Belohnungen",
		ru = "Награды",
		["zh-cn"] = "奖励",
	},
	mod_option_randomization_reward_tooltip = {
		en = "Randomize mission reward weapons",
		de = "Randomisierung der Missions-Belohnungs Waffen",
		ru = "Создавать случайные варианты оружия, полученного в награду за миссии.",
		["zh-cn"] = "随机化任务奖励武器",
	},
	mod_option_randomization_bayonet = {
		en = "Bayonet",
		de = "Bajonett",
		ru = "Штык",
		["zh-cn"] = "刺刀",
	},
	mod_option_randomization_bayonet_tooltip = {
		en = "Chance for weapons to have a bayonet",
		de = "Chance dass Waffen ein Bajonett haben",
		ru = "Шанс, что на оружии будет штык.",
		["zh-cn"] = "武器安装刺刀的概率",
	},
	mod_option_randomization_flashlight = {
		en = "Flashlight",
		de = "Taschenlampe",
		ru = "Фонарик",
		["zh-cn"] = "手电筒",
	},
	mod_option_randomization_flashlight_tooltip = {
		en = "Chance for weapons to have a flashlight",
		de = "Chance dass Waffen eine Taschenlampe haben",
		ru = "Шанс, что на оружии будет фогнарик.",
		["zh-cn"] = "武器安装手电筒的概率",
	},
	mod_option_randomization_laser_pointer = {
		en = "Laser Pointer",
		de = "Laserpointer",
		ru = "Лазерный указатель",
		["zh-cn"] = "激光指示器",
	},
	mod_option_randomization_laser_pointer_tooltip = {
		en = "Allow laser pointers for player randomization.",
		de = "Erlaube Laserpointer bei der Randomisierung der Spieler.",
		ru = "Разрешить случайную выдачу лазерных указателей другим игрокам.",
		["zh-cn"] = "随机化玩家时允许激光指示器。",
	},
	mod_option_randomization_stock = {
		en = "Stock",
		de = "Gewehrkolben",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	mod_option_randomization_stock_tooltip = {
		en = "Stock",
		de = "Gewehrkolben",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	-- ##### ┬  ┬┬┌─┐┬┌┐ ┬  ┌─┐  ┌─┐┌─┐ ┬ ┬┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐ ###########################################################
	-- ##### └┐┌┘│└─┐│├┴┐│  ├┤   ├┤ │─┼┐│ ││├─┘│││├┤ │││ │  ###########################################################
	-- #####  └┘ ┴└─┘┴└─┘┴─┘└─┘  └─┘└─┘└└─┘┴┴  ┴ ┴└─┘┘└┘ ┴  ###########################################################
	loc_visible_equipment_chest = {
		en = "Chest",
		de = "Brust",
		ru = "Грудь",
	},
	loc_visible_equipment_leg_left = {
		en = "Left Leg",
		de = "Linkes Bein",
		ru = "Левая нога",
	},
	loc_visible_equipment_leg_right = {
		en = "Right Leg",
		de = "Rechtes Bein",
		ru = "Правая нога",
	},
	loc_visible_equipment_hips_front = {
		en = "Hips Front",
		de = "Hüfte Vorne",
		ru = "Бедро спереди",
	},
	loc_visible_equipment_hips_right = {
		en = "Hips Right",
		de = "Hüfte Rechts",
		ru = "Бедро справа",
	},
	loc_visible_equipment_hips_left = {
		en = "Hips Left",
		de = "Hüfte Links",
		ru = "Бедро слева",
	},
	loc_visible_equipment_hips_back = {
		en = "Hips Back",
		de = "Hüfte Hinten",
		ru = "Бедро сзади",
	},
	loc_visible_equipment_back_left = {
		en = "Back Left",
		de = "Rücken Links",
		ru = "Спина слева",
	},
	loc_visible_equipment_back_right = {
		en = "Back Right",
		de = "Rücken Rechts",
		ru = "Спина справа",
	},
	loc_visible_equipment_backpack_left = {
		en = "Backpack Left",
		de = "Rucksack Links",
		ru = "Рюкзак слева",
	},
	loc_visible_equipment_backpack_right = {
		en = "Backpack Right",
		de = "Rucksack Rechts",
		ru = "Рюкзак справа",
	},
	group_visible_equipment = {
		en = "Visible Equipment",
		de = "Sichtbare Ausrüstung",
		ru = "Видимое снаряжение",
		["zh-cn"] = "装备可见",
	},
	mod_option_visible_equipment = {
		en = "Visible Equipment",
		de = "Sichtbare Ausrüstung",
		ru = "Показывать снаряжение",
		["zh-cn"] = "装备可见",
	},
	mod_option_visible_equipment_tooltip = {
		en = "Shows currently unwielded equipment on player characters",
		de = "Zeigt die nicht genutzte Ausrüstung der Spielercharaktere",
		ru = "Показывает неиспользуемое в данный момент снаряжение на персонажах игроков.",
		["zh-cn"] = "在玩家角色上显示当前未手持的装备",
	},
	mod_option_visible_equipment_sounds = {
		en = "Weapon Sounds",
		de = "Waffen Geräusche",
		ru = "Звуки оружия слышны",
		["zh-cn"] = "武器声音",
	},
	mod_option_visible_equipment_sounds_tooltip = {
		en = "Plays sound effects for weapons when walking",
		de = "Spielt beim Gehen Soundeffekte für Waffen ab",
		ru = "Воспроизводятся звуковые эффекты оружия при ходьбе.",
		["zh-cn"] = "行走时播放武器音效",
	},
	mod_option_visible_equipment_sounds_all = {
		en = "Self and Teammates",
		de = "Selbst und Gruppenmitglieder",
		ru = "Себе и команде",
		["zh-cn"] = "自己和队友",
	},
	mod_option_visible_equipment_sounds_others = {
		en = "Teammates",
		de = "Gruppenmitglieder",
		ru = "Команде",
		["zh-cn"] = "队友",
	},
	mod_option_visible_equipment_sounds_off = {
		en = "Off",
		de = "Aus",
		ru = "Никому",
		["zh-cn"] = "关闭",
	},
	mod_option_visible_equipment_own_sounds_fp = {
		en = "Sounds in First Person",
		de = "Geräusche in First Person",
		ru = "Звуки от первого лица",
		["zh-cn"] = "第一人称声音",
	},
	mod_option_visible_equipment_own_sounds_fp_tooltip = {
		en = "Hear the sounds of your own equipment in first person",
		de = "Höre die Geräusche deiner eigenen Ausrüstung in first person",
		ru = "Вы будете слышать звуки собственного снаряжения от первого лица.",
		["zh-cn"] = "在第一人称下能听到自己装备的声音",
	},
	mod_option_visible_equipment_disable_in_hub = {
		en = "Disable in hub",
		de = "Im Hub deaktivieren",
		ru = "Отключить в Хабе",
	},
	mod_option_visible_equipment_disable_in_hub_tooltip = {
		en = "Disable visible equipment in hub only",
		de = "Sichtbare Ausrüstung nur im Hub deaktivieren",
		ru = "Отключает Видимое снаряжение в Хабе.",
	},
	
	-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┐ ┬ ┬┬┬  ┌┬┐  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ############################################
	-- ##### │││├┤ ├─┤├─┘│ ││││  ├┴┐│ │││   ││  ├─┤│││││││├─┤ │ ││ ││││└─┐ ############################################
	-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘└─┘┴┴─┘─┴┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘└─┘ ############################################
	group_weapon_animation = {
		en = "Weapon Animations",
		de = "Waffen Animationen",
		ru = "Анимации оружия",
		["zh-cn"] = "武器动画",
	},
	mod_option_camera_hide_ui = {
		en = "Hide UI",
		de = "Menu Ausblenden",
		ru = "Скрыть меню",
		["zh-cn"] = "隐藏界面",
	},
	mod_option_camera_hide_ui_tooltip = {
		en = "Hide UI",
		de = "Menu Ausblenden",
		ru = "Скрыть меню",
		["zh-cn"] = "隐藏界面",
	},
	mod_option_carousel = {
		en = "Carousel",
		de = "Karussell",
		ru = "Карусель",
		["zh-cn"] = "轮盘展示",
	},
	mod_option_carousel_tooltip = {
		en = "Carousel",
		de = "Karussell",
		ru = "Карусель",
		["zh-cn"] = "轮盘展示",
	},
	mod_option_weapon_build_animation = {
		en = "Play Animations",
		de = "Animationen Abspielen",
		ru = "Воспроизведение анимаций",
		["zh-cn"] = "播放动画",
	},
	mod_option_weapon_build_animation_tooltip = {
		en = "Plays building animations when changing weapon components",
		de = "Spielt Bauanimationen ab wenn Waffenkomponente verändert werden",
		ru = "Воспроизводит анимацию сборки при смене компонентов оружия.",
		["zh-cn"] = "更换武器配件时播放组装动画",
	},
	mod_option_weapon_build_animation_speed = {
		en = "Speed",
		de = "Geschwindigkeit",
		ru = "Скорость",
		["zh-cn"] = "速度",
	},
	mod_option_weapon_build_animation_speed_tooltip = {
		en = "Set the speed of the building animations",
		de = "Lege die Geschwindigkeit der Bauanimationen fest",
		ru = "Установите скорость анимации сборки.",
		["zh-cn"] = "设置组装动画速度",
	},
	mod_option_weapon_build_animation_wobble = {
		en = "Wobble",
		de = "Wackeln",
		ru = "Покачивание",
		["zh-cn"] = "抖动",
	},
	mod_option_weapon_build_animation_wobble_tooltip = {
		en = "Plays an unnecessary wobble animation at the end of the build animation",
		de = "Spielt nach der Bauanimation eine unnötige Wackelanimation ab",
		ru = "Воспроизводит ненужную анимацию качания в конце анимации сборки.",
		["zh-cn"] = "在组装动画结束时播放一段额外的抖动动画",
	},
	mod_option_weapon_build_animation_speed_unit = {
		en = "Seconds",
		de = "Sekunden",
		ru = "Секунды",
		["zh-cn"] = "秒",
	},
	mod_option_camera_zoom = {
		en = "Camera Zoom",
		de = "Kamera Zoom",
		ru = "Приближение камеры",
		["zh-cn"] = "镜头缩放",
	},
	mod_option_camera_zoom_tooltip = {
		en = "Plays a camera zoom animation during build animation",
		de = "Spielt während der Bauanimation eine Kamera-Zoomanimation ab",
		ru = "Воспроизводит анимацию масштабирования камеры во время анимации сборки.",
		["zh-cn"] = "在播放组装动画时缩放镜头",
	},
	-- ##### ┌─┐┬  ┌─┐┌─┐┬ ┬┬  ┬┌─┐┬ ┬┌┬┐ #############################################################################
	-- ##### ├┤ │  ├─┤└─┐├─┤│  ││ ┬├─┤ │  #############################################################################
	-- ##### └  ┴─┘┴ ┴└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴  #############################################################################
	group_flashlight = {
		en = "Flashlight",
		de = "Taschenlampe",
		ru = "Фонарик",
		["zh-cn"] = "手电筒",
	},
	loc_flashlight_light_cone = {
		en = "Light Cone",
		de = "Lichtkegel",
		ru = "Световой конус",
		["zh-cn"] = "光锥",
	},
	loc_flashlight_intensity = {
		en = "Intensity",
		de = "Helligkeit",
		ru = "Интенсивность",
		["zh-cn"] = "亮度",
	},
	loc_flashlight_battery = {
		en = "Battery Life",
		de = "Batteriekraft",
		ru = "Время работы батареи",
		["zh-cn"] = "电池电量",
	},
	mod_option_flashlight = {
		en = "Flashlight System",
	},
	mod_option_flashlight_tooltip = {
		en = "Toggle flashlight system",
	},
	mod_option_flashlight_shadows = {
		en = "Flashlight Shadows",
		de = "Taschenlampenschatten",
		ru = "Тень от фонарика",
		["zh-cn"] = "手电筒阴影",
	},
	mod_option_flashlight_shadows_tooltip = {
		en = "Sets dynamic shadows for flashlights\nAffects vanilla flashlights too",
		de = "Legt dynamische Sachatten für Taschenlampen fest\nBetrifft auch vanilla Taschenlampen",
		ru = "Включает динамические тени для фонариков.\nВлияет также и на стандартные игровые фонарики.",
		["zh-cn"] = "设置手电筒的动态阴影\n同样影响原装手电筒",
	},
	mod_option_flashlight_flicker = {
		en = "Flashlight Flicker",
		de = "Taschenlampenflimmern",
		ru = "Мерцание света фонарика",
		["zh-cn"] = "手电筒闪烁",
	},
	mod_option_flashlight_flicker_start = {
		en = "Flicker on Activate",
		de = "Filmmern beim Einschalten",
		ru = "Мерцание при включении",
		["zh-cn"] = "开启时闪烁",
	},
	mod_option_flashlight_flicker_start_tooltip = {
		en = "Flashlights immediately flicker once when activated",
		de = "Taschenlampe flimmert direkt beim Einschalten ein Mal",
		ru = "Фонарики мигают один раз при активации.",
		["zh-cn"] = "开启手电筒时，立刻闪烁一次",
	},
	-- ##### ┬  ┌─┐┌─┐┌─┐┬─┐  ┌─┐┌─┐┬┌┐┌┌┬┐┌─┐┬─┐ #####################################################################
	-- ##### │  ├─┤└─┐├┤ ├┬┘  ├─┘│ │││││ │ ├┤ ├┬┘ #####################################################################
	-- ##### ┴─┘┴ ┴└─┘└─┘┴└─  ┴  └─┘┴┘└┘ ┴ └─┘┴└─ #####################################################################
	group_laser_pointer = {
		en = "Laser Pointer",
		de = "Laserpointer",
		ru = "Лазерный указатель",
		["zh-cn"] = "激光指示器",
	},
	mod_option_laser_pointer = {
		en = "Laser Pointer System",
		de = "Laserpointer System",
	},
	mod_option_laser_pointer_tooltip = {
		en = "Toggle laser pointer system",
		de = "Laserpointer System umschalten",
	},
	mod_option_laser_pointer_count = {
		en = "Strength",
		de = "Stärke",
		ru = "Сила свечения",
		["zh-cn"] = "强度",
	},
	mod_option_laser_pointer_count_tooltip = {
		en = "Strength of your own laser pointer",
		de = "Stärke des eigenen Laserpointers",
		ru = "Сила свечения вашего собственного лазерного указателя",
		["zh-cn"] = "自己激光指示器的强度",
	},
	mod_option_laser_pointer_count_others = {
		en = "Strength (Team)",
		de = "Stärke (Team)",
		ru = "Сила свечения (команда)",
		["zh-cn"] = "强度（团队）",
	},
	mod_option_laser_pointer_count_others_tooltip = {
		en = "Strength of your teammate's laser pointer",
		de = "Stärke der Laserpointer von Mitspielern",
		ru = "Сила свечения лазерного указателя ваших союзников.",
		["zh-cn"] = "队友激光指示器的强度",
	},
	mod_option_deactivate_crosshair_laser = {
		en = "Deactivate Crosshair ",
		de = "Zielkreuz Deaktivieren ",
		ru = "Деактивировать перекрестие ",
		["zh-cn"] = "禁用准星 ",
	},
	mod_option_deactivate_crosshair_laser_tooltip = {
		en = "Crosshair is automatically hidden when laser pointer is activated",
		de = "Zielkreuz wird automatisch versteckt wenn Laserpointer angeschaltet wird",
		ru = "Перекрестие автоматически скрывается при активации лазерного указателя.",
		["zh-cn"] = "开启激光指示器时自动隐藏准星",
	},
	mod_option_laser_pointer_dot_size = {
		en = "Dot Size",
		de = "Punktgröße",
		ru = "Размер точки",
		["zh-cn"] = "圆点大小",
	},
	mod_option_laser_pointer_dot_size_tooltip = {
		en = "Sets the size of the dot at the end point of the laser",
		de = "Legt die Größe des Punktes am Ende des Lasers fest",
		ru = "Устанавливает размер точки на конце лазера.",
		["zh-cn"] = "设置激光末端圆点的大小",
	},
	-- mod_option_laser_pointer_wild = {
	-- 	en = "Wild Flickering",
	-- 	de = "Flimmert Wild",
	-- 	ru = "Дикое мерцание",
	-- 	["zh-cn"] = "强烈闪烁",
	-- },
	-- mod_option_laser_pointer_wild_tooltip = {
	-- 	en = "The flashlight of the laser pointer constantly flickers",
	-- 	de = "Die Taschenlampe des Laserpointers flimmert kontinuierlich",
	-- 	ru = "Фонарик лазерной указки будет постоянно мерцать.",
	-- 	["zh-cn"] = "激光指示器的手电筒持续闪烁",
	-- },
	mod_option_laser_pointer_weapon_dot = {
		en = "Weapon Shine Effect",
		de = "Waffen Scheineffekt",
		ru = "Эффект блеска на оружии",
		["zh-cn"] = "武器闪光效果",
	},
	mod_option_laser_pointer_weapon_dot_tooltip = {
		en = "Sets if there is a shine effect at the laser pointer",
		de = "Legt fest ob am Laserpointer ein Scheineffekt ist",
		ru = "Устанавливает наличие эффекта свечения лазерного указателя.",
		["zh-cn"] = "设置激光指示器配件上是否有闪光效果",
	},
	-- mod_option_laser_pointer_hit_indicator = {
	-- 	en = "Hit Indicator Flash",
	-- 	de = "Trefferindikator Blitz",
	-- 	ru = "Вспышка при попадании",
	-- 	["zh-cn"] = "命中指示器闪光",
	-- },
	-- mod_option_laser_pointer_hit_indicator_tooltip = {
	-- 	en = "Use laser dot as a flashing hit indicator",
	-- 	de = "Benutzt Laserpunkt als blitzenden Trefferindikator",
	-- 	ru = "Используйте лазерную точку в качестве вспыхивающего индикатора попаданий.",
	-- 	["zh-cn"] = "以激光圆点作为闪光的命中指示器",
	-- },
	-- mod_option_laser_pointer_hit_color = {
	-- 	en = "Normal Hit Color",
	-- 	de = "Normale Trefferfarbe",
	-- 	ru = "Обычный цвет попадания",
	-- 	["zh-cn"] = "普通命中颜色",
	-- },
	-- mod_option_laser_pointer_hit_color_tooltip = {
	-- 	en = "Sets color for normal hits",
	-- 	de = "Legt Farbe für normale Treffer fest",
	-- 	ru = "Устанавливает цвет для обычных попаданий.",
	-- 	["zh-cn"] = "设置普通命中的颜色",
	-- },
	-- mod_option_laser_pointer_hit_weakspot_color = {
	-- 	en = "Weakspot Hit Color",
	-- 	de = "Schwachstelle Trefferfarbe",
	-- 	ru = "Цвет попадания в уязвимое место",
	-- 	["zh-cn"] = "弱点命中颜色",
	-- },
	-- mod_option_laser_pointer_hit_weakspot_color_tooltip = {
	-- 	en = "Sets color for weakspot hits",
	-- 	de = "Legt Farbe für Schwachstellen-Treffer fest",
	-- 	ru = "Устанавливает цвет для попаданий в уязвимые места.",
	-- 	["zh-cn"] = "设置弱点命中的颜色",
	-- },
	-- mod_option_laser_pointer_hit_critical_color = {
	-- 	en = "Critical Hit Color",
	-- 	de = "Kritische Trefferfarbe",
	-- 	ru = "Цвет критического попадания",
	-- 	["zh-cn"] = "暴击命中颜色",
	-- },
	-- mod_option_laser_pointer_hit_critical_color_tooltip = {
	-- 	en = "Sets color for critical hits",
	-- 	de = "Legt Farbe für kritische Treffer fest",
	-- 	ru = "Устанавливает цвет для критических попаданий.",
	-- 	["zh-cn"] = "设置暴击命中的颜色",
	-- },
	-- mod_option_laser_pointer_kill_color = {
	-- 	en = "Kill Color",
	-- 	de = "Tötungsfarbe",
	-- 	ru = "Цвет при убийстве",
	-- 	["zh-cn"] = "击杀颜色",
	-- },
	-- mod_option_laser_pointer_kill_color_tooltip = {
	-- 	en = "Sets color for hits that kill an enemy",
	-- 	de = "Legt Farbe für Treffer fest die einen Gegner töten",
	-- 	ru = "Устанавливает цвет для убийства врагов.",
	-- 	["zh-cn"] = "设置击杀敌人时的颜色",
	-- },
	-- mod_option_laser_pointer_hit_indicator_brightness = {
	-- 	en = "Brightness",
	-- 	de = "Helligkeit",
	-- 	ru = "Яркость",
	-- 	["zh-cn"] = "亮度",
	-- },
	-- mod_option_laser_pointer_hit_indicator_brightness_tooltip = {
	-- 	en = "Sets brightness of hit indicators",
	-- 	de = "Legt Helligkeit der Trefferindikatoren fest",
	-- 	ru = "Устанавливает яркость вспышки индикатора попаданий.",
	-- 	["zh-cn"] = "设置命中指示器的亮度",
	-- },
	-- mod_option_laser_pointer_hit_indicator_size = {
	-- 	en = "Size",
	-- 	de = "Größe",
	-- 	ru = "Размер",
	-- 	["zh-cn"] = "大小",
	-- },
	-- mod_option_laser_pointer_hit_indicator_size_tooltip = {
	-- 	en = "Sets size of hit indicators",
	-- 	de = "Legt Größe der Trefferindikatoren fest",
	-- 	ru = "Устанавливает размер вспышки индикатора попаданий.",
	-- 	["zh-cn"] = "设置命中指示器的大小",
	-- },
	-- mod_option_laser_pointer_hit_color_white = {
	-- 	en = "{#color(255,255,255)}{#reset()}",
	-- },
	-- mod_option_laser_pointer_hit_color_yellow = {
	-- 	en = "{#color(255,255,0)}{#reset()}",
	-- },
	-- mod_option_laser_pointer_hit_color_red = {
	-- 	en = "{#color(255,0,0)}{#reset()}",
	-- },
	-- mod_option_laser_pointer_hit_color_green = {
	-- 	en = "{#color(0,255,0)}{#reset()}",
	-- },
	-- mod_option_laser_pointer_hit_color_blue = {
	-- 	en = "{#color(0,0,255)}{#reset()}",
	-- },
	-- mod_option_laser_pointer_hit_color_gold = {
	-- 	en = "{#color(171,141,63)}{#reset()}",
	-- },
	-- ##### ┌┐ ┌─┐┌┬┐┌┬┐┌─┐┬─┐┬ ┬ ####################################################################################
	-- ##### ├┴┐├─┤ │  │ ├┤ ├┬┘└┬┘ ####################################################################################
	-- ##### └─┘┴ ┴ ┴  ┴ └─┘┴└─ ┴  ####################################################################################
	group_battery = {
		en = "Battery",
		de = "Batterie",
		ru = "Батарея",
		["zh-cn"] = "电池",
	},
	mod_option_battery_show = {
		en = "Show Bar",
		de = "Leiste anzeigen",
		ru = "Показывать полоску",
		["zh-cn"] = "显示状态条",
	},
	mod_option_battery_show_tooltip = {
		en = "Shows a bar with your current battery charge",
		de = "Zeigt einen Balken mit deinter aktuellen Batterieladung",
		ru = "Показывает полоску с текущим зарядом аккумулятора.",
		["zh-cn"] = "显示当前电池充能的状态指示条",
	},
	mod_option_battery_show_threshold = {
		en = "When under",
		de = "Wenn weniger als",
		ru = "Когда заряд ниже",
		["zh-cn"] = "仅当低于",
	},
	mod_option_battery_show_threshold_tooltip = {
		en = "Shows battery bar only when charge is under selected percentage",
		de = "Zeigt den Batteriebalken nur an, wenn die Ladung unter dem ausgewählten Prozentsatz liegt",
		ru = "Показывает полоску заряда батареи только тогда, когда уровень заряда ниже выбранного процента.",
		["zh-cn"] = "仅在充能低于所选百分比时显示电池状态条",
	},
	mod_option_battery_show_threshold_10 = {
		en = "10%%",
	},
	mod_option_battery_show_threshold_25 = {
		en = "25%%",
	},
	mod_option_battery_show_threshold_50 = {
		en = "50%%",
	},
	mod_option_battery_show_threshold_75 = {
		en = "75%%",
	},
	mod_option_battery_show_threshold_100 = {
		en = "100%%",
	},
	mod_hud_display_name_battery = {
		en = "Battery",
		de = "Batterie",
		ru = "Батарея",
		["zh-cn"] = "电池",
	},
	-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┬┐┌─┐┌─┐┌┬┐┬ ┬  ┌─┐┌─┐  ┌─┐┬┌─┐┬  ┌┬┐ ###############################################
	-- ##### │││├┤ ├─┤├─┘│ ││││   ││├┤ ├─┘ │ ├─┤  │ │├┤   ├┤ │├┤ │   ││ ###############################################
	-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ─┴┘└─┘┴   ┴ ┴ ┴  └─┘└    └  ┴└─┘┴─┘─┴┘ ###############################################
	group_weapon_dof = {
		en = "Weapon Depth of Field",
		de = "Waffen-Tiefenunschärfe",
		ru = "Глубина резкости оружия",
		["zh-cn"] = "武器景深",
	},
	mod_option_misc_weapon_dof = {
		en = "Depth of Field System",
		de = "Tiefenunschärfe-System",
	},
	mod_option_misc_weapon_dof_tooltip = {
		en = "Toggle depth of field system",
		de = "Tiefenunschärfe-System umschalten",
	},
	mod_option_misc_weapon_dof_no_aim = {
		en = "Not Aiming",
		de = "Nicht Zielen",
		ru = "Без прицеливания",
		["zh-cn"] = "未瞄准",
	},
	mod_option_misc_weapon_dof_no_aim_tooltip = {
		en = "Applies depth of field to weapon when not aiming",
		de = "Tiefenunschärfe für Waffe, wenn nicht gezielt wird",
		ru = "Применяет глубину резкости к оружию, когда вы не целитесь.",
		["zh-cn"] = "未瞄准时应用武器景深效果",
	},
	mod_option_misc_weapon_dof_strength_no_aim = {
		en = "Strength ",
		de = "Stärke ",
		ru = "Сила эффекта ",
		["zh-cn"] = "强度 ",
	},
	mod_option_misc_weapon_dof_strength_no_aim_tooltip = {
		en = "Depth of field strength when not aiming",
		de = "Stärke der Tiefenunschärfe, wenn nicht gezielt wird",
		ru = "Сила глубины резкости, когда вы не прицеливаетесь.",
		["zh-cn"] = "未瞄准时的景深强度",
	},
	mod_option_misc_weapon_dof_scope = {
		en = "Scope / Reflex",
		de = "Zielfernrohr / Reflexvisier",
		ru = "Открытый прицел",
		["zh-cn"] = "光学 / 反射瞄具",
	},
	mod_option_misc_weapon_dof_scope_tooltip = {
		en = "Applies depth of field to weapon when aiming with a scope / reflex sight",
		de = "Tiefenunschärfe für Waffe, wenn mit Zielfernrohr / Reflexvisier gezielt wird",
		ru = "Применяет глубину резкости к оружию при прицеливании в оптические прицелы или коллиматоры.",
		["zh-cn"] = "使用光学 / 反射瞄具瞄准时应用武器景深效果",
	},
	mod_option_misc_weapon_dof_strength_scope = {
		en = "Strength  ",
		de = "Stärke  ",
		ru = "Сила эффекта  ",
		["zh-cn"] = "强度  ",
	},
	mod_option_misc_weapon_dof_strength_scope_tooltip = {
		en = "Depth of field strength when aiming with a scope / reflex sight",
		de = "Stärke der Tiefenunschärfe, wenn mit Zielfernrohr / Reflexvisier gezielt wird",
		ru = "Сила глубины резкости при прицеливании через прицел/коллиматорный прицел.",
		["zh-cn"] = "使用光学 / 反射瞄具瞄准时的景深强度",
	},
	mod_option_misc_weapon_dof_sight = {
		en = "Iron Sights",
		de = "Kimme und Korn",
		ru = "Мушки",
		["zh-cn"] = "机械瞄具",
	},
	mod_option_misc_weapon_dof_sight_tooltip = {
		en = "Applies depth of field to weapon when aiming with iron sights",
		de = "Tiefenunschärfe für Waffe, wenn mit Kimme und Korn gezielt wird",
		ru = "Применяет глубину резкости к оружию при прицеливании через мушку.",
		["zh-cn"] = "使用机械瞄具瞄准时应用武器景深效果",
	},
	mod_option_misc_weapon_dof_strength_sight = {
		en = "Strength   ",
		de = "Stärke   ",
		ru = "Сила эффекта   ",
		["zh-cn"] = "强度   ",
	},
	mod_option_misc_weapon_dof_strength_sight_tooltip = {
		en = "Depth of field strength when aiming with iron sights",
		de = "Stärke der Tiefenunschärfe, wenn mit Kimme und Korn gezielt wird",
		ru = "Сила глубины резкости при прицеливании через мушку.",
		["zh-cn"] = "使用机械瞄具瞄准时的景深强度",
	},
	-- ##### ┌─┐┬ ┬┌─┐┌┬┐┌─┐┌┬┐┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌  ┬  ┬┬┌─┐┬ ┬ #########################################################
	-- ##### │  │ │└─┐ │ │ │││││┌─┘├─┤ │ ││ ││││  └┐┌┘│├┤ │││ #########################################################
	-- ##### └─┘└─┘└─┘ ┴ └─┘┴ ┴┴└─┘┴ ┴ ┴ ┴└─┘┘└┘   └┘ ┴└─┘└┴┘ #########################################################
	loc_weapon_inventory_next_button = {
		en = ">",
	},
	loc_weapon_inventory_prev_button = {
		en = "<",
	},
	loc_weapon_inventory_reload_definitions_button = {
		en = "Reload Definitions",
		de = "Definitionen neu laden",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset All",
		de = "Alles Zurücksetzen",
		ru = "Сбросить всё",
		["zh-cn"] = "重置所有",
	},
	loc_weapon_inventory_no_reset_button = {
		en = "No Changes",
		de = "Keine Änderungen",
		ru = "Без изменений",
		["zh-cn"] = "无更改",
	},
	loc_weapon_inventory_randomize_button = {
		en = "Randomize",
		de = "Zufällig",
		ru = "Случайно",
		["zh-cn"] = "随机",
	},
	-- loc_weapon_inventory_demo_button = {
	-- 	en = "Demo",
	-- 	de = "Demo",
	-- 	ru = "Демонстрация",
	-- 	["zh-cn"] = "演示",
	-- },
	loc_inventory_menu_weapon_preset_intro_text_1 = {
		en = "Weapon Presets",
		ru = "Предустановки оружия",
		["zh-cn"] = "武器预设",
	},
	loc_inventory_menu_weapon_preset_intro_text_2 = {
		en = "Weapon Presets Description",
		ru = "Описание предустановок оружия",
		["zh-cn"] = "武器预设描述",
	},
	-- ##### ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌─┐┬  ┌─┐┌┬┐┌─┐ ##########################################################
	-- ##### ├─┤ │  │ ├─┤│  ├─┤│││├┤ │││ │   └─┐│  │ │ │ └─┐ ##########################################################
	-- ##### ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴┴ ┴└─┘┘└┘ ┴   └─┘┴─┘└─┘ ┴ └─┘ ##########################################################
	loc_weapon_cosmetics_customization_flashlight = {
		en = "Special",
		de = "Spezial",
		ru = "Специальный",
		["zh-cn"] = "特殊",
	},
	loc_weapon_cosmetics_customization_barrel = {
		en = "Barrel",
		de = "Lauf",
		ru = "Ствол",
		["zh-cn"] = "枪管",
	},
	loc_weapon_cosmetics_customization_underbarrel = {
		en = "Underbarrel",
		de = "Unterlauf",
		ru = "Подствольник",
		["zh-cn"] = "枪管下挂",
	},
	loc_weapon_cosmetics_customization_muzzle = {
		en = "Muzzle",
		de = "Mündung",
		ru = "Дуло",
		["zh-cn"] = "枪口",
	},
	loc_weapon_cosmetics_customization_receiver = {
		en = "Receiver",
		de = "Gehäuse",
		ru = "Ствольная коробка",
		["zh-cn"] = "机匣",
	},
	loc_weapon_cosmetics_customization_magazine = {
		en = "Magazine",
		de = "Magazin",
		ru = "Магазин",
		["zh-cn"] = "弹匣",
	},
	loc_weapon_cosmetics_customization_grip = {
		en = "Grip",
		de = "Griff",
		ru = "Рукоять",
		["zh-cn"] = "握把",
	},
	loc_weapon_cosmetics_customization_bayonet = {
		en = "Bayonet",
		de = "Bajonett",
		ru = "Штык",
		["zh-cn"] = "刺刀",
	},
	loc_weapon_cosmetics_customization_handle = {
		en = "Handle",
		de = "Handgriff",
		ru = "Ручка",
		["zh-cn"] = "握柄",
	},
	loc_weapon_cosmetics_customization_stock = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_ventilation = {
		en = "Ventilation",
		de = "Ventilation",
		ru = "Охлаждение",
		["zh-cn"] = "通气孔",
	},
	loc_weapon_cosmetics_customization_stock_2 = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_stock_3 = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_sight = {
		en = "Sight",
		de = "Visier",
		ru = "Прицел",
		["zh-cn"] = "瞄具",
	},
	loc_weapon_cosmetics_customization_sight_2 = {
		en = "Sight",
		de = "Visier",
		ru = "Прицел",
		["zh-cn"] = "瞄具",
	},
	loc_weapon_cosmetics_customization_body = {
		en = "Body",
		de = "Aufbau",
		ru = "Основа",
		["zh-cn"] = "主体",
	},
	loc_weapon_cosmetics_customization_rail = {
		en = "Rail",
		de = "Schiene",
		ru = "Рельса",
		["zh-cn"] = "导轨",
	},
	loc_weapon_cosmetics_customization_pommel = {
		en = "Pommel",
		de = "Knauf",
		ru = "Навершие",
		["zh-cn"] = "柄头",
	},
	loc_weapon_cosmetics_customization_hilt = {
		en = "Hilt",
		de = "Heft",
		ru = "Эфес",
		["zh-cn"] = "握柄",
	},
	loc_weapon_cosmetics_customization_head = {
		en = "Head",
		de = "Kopf",
		ru = "Оголовье",
		["zh-cn"] = "头部",
	},
	loc_weapon_cosmetics_customization_blade = {
		en = "Blade",
		de = "Klinge",
		ru = "Клинок",
		["zh-cn"] = "刃部",
	},
	loc_weapon_cosmetics_customization_scabbard = {
		en = "Scabbard",
		de = "Schwertscheide",
	},
	loc_weapon_cosmetics_customization_teeth = {
		en = "Teeth",
		de = "Zähne",
		ru = "Зубья",
		["zh-cn"] = "锯齿",
	},
	loc_weapon_cosmetics_customization_chain = {
		en = "Chain",
		de = "Kette",
		ru = "Цепь",
		["zh-cn"] = "链条",
	},
	loc_weapon_cosmetics_customization_shaft = {
		en = "Shaft",
		de = "Schaft",
		ru = "Рукоять",
		["zh-cn"] = "杆部",
	},
	loc_weapon_cosmetics_customization_connector = {
		en = "Connector",
		de = "Verbindung",
		ru = "Соединитель",
		["zh-cn"] = "接头",
	},
	loc_weapon_cosmetics_customization_left = {
		en = "Shield",
		de = "Schild",
		ru = "Щит",
		["zh-cn"] = "盾牌",
	},
	loc_weapon_cosmetics_customization_emblem_right = {
		en = "Emblem Right",
		de = "Wappen Rechts",
		ru = "Эмблема правая",
		["zh-cn"] = "右侧装饰",
	},
	loc_weapon_cosmetics_customization_emblem_left = {
		en = "Emblem Left",
		de = "Wappen Links",
		ru = "Эмблема левая",
		["zh-cn"] = "左侧装饰",
	},
	loc_weapon_cosmetics_customization_shaft_lower = {
		en = "Lower Shaft",
		de = "Unterer Schaft",
		ru = "Нижняя часть рукояти",
		["zh-cn"] = "杆底",
	},
	loc_weapon_cosmetics_customization_shaft_upper = {
		en = "Upper Shaft",
		de = "Oberer Schaft",
		ru = "Верхняя часть рукояти",
		["zh-cn"] = "杆顶",
	},
	loc_weapon_cosmetics_customization_trinket_hook = {
		en = "Trinket Hook",
		de = "Trinket Haken",
		ru = "Кольцо для брелка",
		["zh-cn"] = "饰品钩",
	},
}
