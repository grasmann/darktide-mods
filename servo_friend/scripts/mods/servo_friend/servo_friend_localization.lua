-- File: servo_friend/scripts/mods/servo_friend/servo_friend_localization.lua
local Localize = Localize

return {
    mod_title = {
        en = "Servo Friend",
        de = "Servo Freund",
        ["zh-cn"] = "我的伺服颅骨",
        ru = "Серводруг",
    },
    mod_description = {
        en = "Adds a servo skull that follows you.",
        de = "Fügt einen Servo-Kopf hinzu, der dir folgt.",
        ["zh-cn"] = "现在一个伺服颅骨会成为你的伙伴，照亮你前方的道路",
        ru = "Servo Friend - Добавляет сервочереп, который следует за вами.",
    },

    mod_option_priority_order = {
        en = "Priority Order",
        de = "Prioritätsreihenfolge",
        ["zh-cn"] = "优先级顺序",
        ru = "Порядок приоритета",
    },
    mod_option_priority_order_tooltip = {
        en = "Choose what the Servo Friend prioritizes when alert mode, locked aiming, and focus targets compete.",
        de =
        "Legt fest, was der Servo-Freund priorisiert, wenn Alarmmodus, fixiertes Zielen und Fokusziele konkurrieren.",
        ["zh-cn"] = "选择当机魂预警、锁定瞄准和标记追踪同时竞争时，伺服颅骨应优先执行的行为。",
        ru =
        "Выберите, что Серводруг будет приоритетно выполнять, когда режим тревоги, фиксация на прицеле и цели фокусировки конкурируют.",
    },

    mod_option_roaming_area_tooltip = {
        en = "The area that the Servo Friend has to roam in. Set to 0 to disable roaming.",
        de = "Der Bereich, in dem der Servo-Freund wandert. Auf 0 setzen, um das Wandern zu deaktivieren.",
        ["zh-cn"] = "设定伺服颅骨的最大巡航活动范围（单位：米）。设置为 0 可禁用巡航。",
    },

    mod_option_focus_self = { -- loc_penance_menu_panel_option_highlights "Highlights"
        en = "Self-Focus",
        de = "Selbst-Fokus",
        ["zh-cn"] = "自身照明",
        ru = "Фокусировка на себе",
    },
    mod_option_focus_self_tooltip = {
        en = "Choose when the Servo Friend shines light on you from above.",
        de = "Wähle, wann der Servo-Freund Licht von oben auf dich scheint.",
        ["zh-cn"] = "选择伺服颅骨何时从上方照亮玩家自身。",
        ru = "Выберите, когда Серводруг подсвечивает вас сверху.",
    },
    mod_option_flashlight_color_red = {
        en = "Red",
        de = "Rot",
        ["zh-cn"] = "赤红频段",
    },
    mod_option_flashlight_color_green = {
        en = "Green",
        de = "Gruen",
        ["zh-cn"] = "翠绿频段",
    },
    mod_option_flashlight_color_blue = {
        en = "Blue",
        de = "Blau",
        ["zh-cn"] = "深蓝频段",
    },

    mod_option_alert_mode_lights = {
        en = "Lights",
        de = "Lichter",
        ["zh-cn"] = "灯光预警模式"
    },

    mod_option_victory_speech_frequency = {
        en = "Victory Speech Frequency",
        de = "Häufigkeit der Siegesreden",
        ["zh-cn"] = "凯旋宣言触发频率",
    },

    mod_option_debug = {
        en = "Debug Mode",
        de = "Debug",
        ["zh-cn"] = "调试模式",
    },
    mod_option_avoid_going_into_walls = {
        en = "Wall Detection",
        de = "Wand Erkennung",
        ["zh-cn"] = "结构体规避系统",
    },
    mod_option_avoid_going_into_walls_tooltip = {
        en = "Prevents the Servo Friend from going into walls.",
        de = "Verhindert, dass der Servo Freund in Wände geht.",
        ["zh-cn"] = "启用地形扫描协议，防止伺服助手嵌入墙体结构",
    },
    mod_option_avoid_daemonhost_tooltip = {
        en = "Prevents the Servo Friend from shining the flashlight on daemonhosts.",
        de = "Verhindert, dass der Servo Freund auf Daemonhosts leuchtet.",
        ["zh-cn"] = "激活灵能遮蔽场，避免伺服颅骨助手的光学传感器惊醒恶魔宿主",
    },
    mod_option_keep_packages = {
        en = "Keep Packages Loaded",
        de = "Pakete im Speicher behalten",
        ["zh-cn"] = "机魂永驻协议",
    },
    mod_option_keep_packages_tooltip = {
        en = "Keep the packages for Servo Friend and addons loaded on mod reload.",
        de = "Pakete fürs Servo Freund und Addons im Speicher halten, wenn die Mod neu geladen wird.",
        ["zh-cn"] = "重新加载mod后，在内存中维持伺服颅骨及其圣约插件的数据",
    },
    mod_option_hover_sound_effect = {
        en = "Hover Sound Effect",
        de = "Schwebe Sound Effekt",
        ["zh-cn"] = "悬浮音效反馈",
        ru = "Звуковой эффект парения",
    },
}
