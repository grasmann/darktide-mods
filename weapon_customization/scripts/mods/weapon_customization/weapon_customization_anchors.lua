local mod = get_mod("weapon_customization")

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

mod.debugged_units = function(self)
    local units = {}
    for weapon_name, weapon_anchors in pairs(self.anchors) do
        for attachment_name, attachment in pairs(weapon_anchors) do
            if attachment.hide then
                units[#units+1] = attachment.hide
            end
        end
    end
    return units
end

mod.anchors = {
    ogryn_heavystubber_p1_m1 = {
        ["flashlight_01"] = {
            position = Vector3Box(.09, .9, .13),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_02"] = {
            position = Vector3Box(.09, .9, .13),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_03"] = {
            position = Vector3Box(.09, .9, .13),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_04"] = {
            position = Vector3Box(.15, .86, .21),
            rotation = Vector3Box(0, 128, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["blade_01"] = {
            position = Vector3Box(0, 1.04, -0.39),
            rotation = Vector3Box(-90, 0, 0),
            scale = Vector3Box(2, 2, 2),
        },
    },
    ogryn_rippergun_p1_m1 = {
        ["flashlight_01"] = {
            position = Vector3Box(.09, .76, .35),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_02"] = {
            position = Vector3Box(.09, .76, .35),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_03"] = {
            position = Vector3Box(.09, .76, .35),
            rotation = Vector3Box(0, 311, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_04"] = {
            position = Vector3Box(.16, .76, .41),
            rotation = Vector3Box(0, 128, 0),
            scale = Vector3Box(2, 2, 2),
        },
    },
    ogryn_thumper_p1_m1 = {
        ["flashlight_01"] = {
            position = Vector3Box(.12, .33, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_02"] = {
            position = Vector3Box(.12, .33, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_03"] = {
            position = Vector3Box(.12, .33, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_04"] = {
            position = Vector3Box(.12, .33, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
    },
    ogryn_gauntlet_p1_m1 = {
        ["flashlight_01"] = {
            position = Vector3Box(.2, .18, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_02"] = {
            position = Vector3Box(.2, .18, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_03"] = {
            position = Vector3Box(.2, .18, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
        ["flashlight_04"] = {
            position = Vector3Box(.2, .18, .11),
            rotation = Vector3Box(0, 360, 0),
            scale = Vector3Box(2, 2, 2),
        },
    },
}
mod.anchors.ogryn_heavystubber_p1_m2 = mod.anchors.ogryn_heavystubber_p1_m1
mod.anchors.ogryn_heavystubber_p1_m3 = mod.anchors.ogryn_heavystubber_p1_m1
mod.anchors.ogryn_rippergun_p1_m2 = mod.anchors.ogryn_rippergun_p1_m1
mod.anchors.ogryn_rippergun_p1_m3 = mod.anchors.ogryn_rippergun_p1_m1
mod.anchors.ogryn_thumper_p1_m2 = mod.anchors.ogryn_thumper_p1_m1

mod.attachment = {
    ogryn_heavystubber_p1_m1 = {
        special = { --end_screen_summary_currency_icon_out
            {id = "default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}, --end_screen_summary_diamantine_zero end_screen_summary_plasteel_zero end_screen_summary_credits_zero
            {id = "blade_01", name = "Blade", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
            {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
        },
        barrel = {
            {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
        },
        receiver = {
            {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
        },
        magazine = {
            {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_03", name = "Magazine 3", sounds = {UISoundEvents.apparel_equip}},
        },
        grip = {
            {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
        },
    },
    ogryn_rippergun_p1_m1 = {
        special = {
            {id = "default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
            {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
        },
        barrel = {
            {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_04", name = "Barrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_05", name = "Barrel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_06", name = "Barrel 6", sounds = {UISoundEvents.weapons_equip_gadget}},
        },
        receiver = {
            {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_04", name = "Receiver 4", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_05", name = "Receiver 5", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "receiver_06", name = "Receiver 6", sounds = {UISoundEvents.weapons_equip_weapon}},
        },
        magazine = {
            {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_03", name = "Magazine 3", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_04", name = "Magazine 4", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_05", name = "Magazine 5", sounds = {UISoundEvents.apparel_equip}},
            {id = "magazine_06", name = "Magazine 6", sounds = {UISoundEvents.apparel_equip}},
        },
        handle = {
            {id = "handle_01", name = "Handle 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_02", name = "Handle 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_03", name = "Handle 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_04", name = "Handle 4", sounds = {UISoundEvents.weapons_swap}},
        },
        bayonet = {
            {id = "bayonet_01", name = "Bayonet 1", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "bayonet_02", name = "Bayonet 2", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "bayonet_03", name = "Bayonet 3", sounds = {UISoundEvents.weapons_equip_gadget}},
        },
    },
    ogryn_thumper_p1_m1 = {
        special = {
            {id = "default", name = "Default"},
            -- {id = "blade_01", name = "Blade"},
            {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
        },
        sight = {
            {id = "sight_01", name = "Sight 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "sight_03", name = "Sight 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "sight_04", name = "Sight 4", sounds = {UISoundEvents.weapons_swap}},
        },
        grip = {
            {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
        },
        body = {
            {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_02", name = "Body 2", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_03", name = "Body 3", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_04", name = "Body 4", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_05", name = "Body 5", sounds = {UISoundEvents.weapons_equip_weapon}},
        },
    },
    ogryn_gauntlet_p1_m1 = {
        special = {
            {id = "default", name = "Default"},
            -- {id = "blade_01", name = "Blade"},
            {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
            {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
        },
        barrel = {
            {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
            {id = "barrel_04", name = "Barrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
        },
        body = {
            {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_02", name = "Body 2", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_03", name = "Body 3", sounds = {UISoundEvents.weapons_equip_weapon}},
            {id = "body_04", name = "Body 4", sounds = {UISoundEvents.weapons_equip_weapon}},
        },
        -- magazine = {
        --     {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.weapons_swap}},
        --     {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.weapons_swap}},
        -- },
    },
    ogryn_club_p1_m1 = {
        grip = {
            {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
        },
        pommel = {
            {id = "pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
        },
        head = {
            {id = "head_01", name = "Head 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_02", name = "Head 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_03", name = "Head 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_04", name = "Head 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_05", name = "Head 5", sounds = {UISoundEvents.weapons_swap}},
        },
    },
    ogryn_combatblade_p1_m1 = {
        blade = {
            {id = "blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
            {id = "blade_06", name = "Blade 6", sounds = {UISoundEvents.weapons_swap}},
        },
        grip = {
            {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
            {id = "grip_06", name = "Grip 6", sounds = {UISoundEvents.weapons_swap}},
        },
        handle = {
            {id = "handle_01", name = "Handle 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_02", name = "Handle 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_03", name = "Handle 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_04", name = "Handle 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_05", name = "Handle 5", sounds = {UISoundEvents.weapons_swap}},
            {id = "handle_06", name = "Handle 6", sounds = {UISoundEvents.weapons_swap}},
        },
    },
    ogryn_powermaul_p1_m1 = {
        shaft = {
            {id = "shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
        },
        head = {
            {id = "head_01", name = "Head 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_02", name = "Head 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_03", name = "Head 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_04", name = "Head 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "head_05", name = "Head 5", sounds = {UISoundEvents.weapons_swap}},
        },
        pommel = {
            {id = "pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
        },
    },
    ogryn_club_p2_m1 = {
        body = {
            {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_swap}},
            {id = "body_02", name = "Body 2", sounds = {UISoundEvents.weapons_swap}},
            {id = "body_03", name = "Body 3", sounds = {UISoundEvents.weapons_swap}},
            {id = "body_04", name = "Body 4", sounds = {UISoundEvents.weapons_swap}},
            {id = "body_05", name = "Body 5", sounds = {UISoundEvents.weapons_swap}},
        },
    },
}
mod.attachment.ogryn_heavystubber_p1_m2 = mod.attachment.ogryn_heavystubber_p1_m1
mod.attachment.ogryn_heavystubber_p1_m3 = mod.attachment.ogryn_heavystubber_p1_m1
mod.attachment.ogryn_rippergun_p1_m2 = mod.attachment.ogryn_rippergun_p1_m1
mod.attachment.ogryn_rippergun_p1_m3 = mod.attachment.ogryn_rippergun_p1_m1
mod.attachment.ogryn_thumper_p1_m2 = mod.attachment.ogryn_thumper_p1_m1
mod.attachment.ogryn_combatblade_p1_m2 = mod.attachment.ogryn_combatblade_p1_m1
mod.attachment.ogryn_combatblade_p1_m3 = mod.attachment.ogryn_combatblade_p1_m1
mod.attachment.ogryn_powermaul_slabshield_p1_m1 = mod.attachment.ogryn_powermaul_p1_m1
mod.attachment.ogryn_club_p2_m2 = mod.attachment.ogryn_club_p2_m1
mod.attachment.ogryn_club_p2_m3 = mod.attachment.ogryn_club_p2_m1

mod.flashlight_attached = {}
mod.attached_flashlights = {}

mod.flashlights = {
    "flashlight_01",
    "flashlight_02",
    "flashlight_03",
    "flashlight_04",
}

mod.attachment_units = {
    ["#ID[c54f4d16d170cfdb]"] = "flashlight_01",
    ["#ID[28ae77de0a24aba6]"] = "flashlight_02",
    ["#ID[93567d1eb8abad0b]"] = "flashlight_03",
    ["#ID[1db94ec130a99e51]"] = "flashlight_04",
    ["#ID[9ed2469305ba9eb7]"] = "blade_01",
}

mod.attachment_slots = {
    "special",
    "barrel",
    "receiver",
    "magazine",
    "grip",
    "handle",
    "bayonet",
    "sight",
    "body",
    "pommel",
    "head",
    "blade",
    "shaft",
}

mod.attachment_models = {
    ogryn_heavystubber_p1_m1 = {
        default = {model = "", type = "flashlight"},
        blade_01 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_01", type = "flashlight"},
        flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight"},
        flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight"},
        flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight"},
        flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight"},
        barrel_01 = {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_01", type = "barrel"},
        barrel_02 = {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_02", type = "barrel"},
        barrel_03 = {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_03", type = "barrel"},
        receiver_01 = {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_01", type = "receiver"},
        receiver_02 = {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_02", type = "receiver"},
        receiver_03 = {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_03", type = "receiver"},
        magazine_01 = {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_01", type = "magazine"},
        magazine_02 = {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_02", type = "magazine"},
        magazine_03 = {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_03", type = "magazine"},
        grip_01 = {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_01", type = "grip"},
        grip_02 = {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_02", type = "grip"},
        grip_03 = {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_03", type = "grip"},
    },
    ogryn_rippergun_p1_m1 = {
        default = {model = "", type = "flashlight"},
        flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight"},
        flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight"},
        flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight"},
        flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight"},
        barrel_01 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_01", type = "barrel"},
        barrel_02 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_02", type = "barrel"},
        barrel_03 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_03", type = "barrel"},
        barrel_04 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_04", type = "barrel"},
        barrel_05 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_05", type = "barrel"},
        barrel_06 = {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_06", type = "barrel"},
        bayonet_01 = {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_01", type = "bayonet"},
        bayonet_02 = {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_02", type = "bayonet"},
        bayonet_03 = {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_03", type = "bayonet"},
        receiver_01 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_01", type = "receiver"},
        receiver_02 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_02", type = "receiver"},
        receiver_03 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_03", type = "receiver"},
        receiver_04 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_04", type = "receiver"},
        receiver_05 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_05", type = "receiver"},
        receiver_06 = {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_06", type = "receiver"},
        magazine_01 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_01", type = "magazine"},
        magazine_02 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_02", type = "magazine"},
        magazine_03 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_03", type = "magazine"},
        magazine_04 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_04", type = "magazine"},
        magazine_05 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_05", type = "magazine"},
        magazine_06 = {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_06", type = "magazine"},
        handle_01 = {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_01", type = "handle"},
        handle_02 = {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_02", type = "handle"},
        handle_03 = {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_03", type = "handle"},
        handle_04 = {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_04", type = "handle"},
    },
    ogryn_thumper_p1_m1 = {
        default = {model = "", type = "flashlight"},
        flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight"},
        flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight"},
        flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight"},
        flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight"},
        sight_01 = {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_01", type = "sight"},
        sight_03 = {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_03", type = "sight"},
        sight_04 = {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_04", type = "sight"},
        grip_01 = {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_01", type = "grip"},
        grip_02 = {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_02", type = "grip"},
        grip_03 = {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_03", type = "grip"},
        grip_04 = {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_04", type = "grip"},
        grip_05 = {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_05", type = "grip"},
        body_01 = {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_01", type = "body"},
        body_02 = {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_02", type = "body"},
        body_03 = {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_03", type = "body"},
        body_04 = {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_04", type = "body"},
        body_05 = {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_05", type = "body"},
    },
    ogryn_gauntlet_p1_m1 = {
        default = {model = "", type = "flashlight"},
        flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight"},
        flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight"},
        flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight"},
        flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight"},
        barrel_01 = {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_01", type = "barrel"},
        barrel_02 = {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_02", type = "barrel"},
        barrel_03 = {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_03", type = "barrel"},
        barrel_04 = {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_04", type = "barrel"},
        body_01 = {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_01", type = "body"},
        body_02 = {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_02", type = "body"},
        body_03 = {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_03", type = "body"},
        body_04 = {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_04", type = "body"},
        -- magazine_01 = {model = "content/items/weapons/player/ranged/magazines/gauntlet_basic_magazine_01", type = "magazine"},
        -- magazine_02 = {model = "content/items/weapons/player/ranged/magazines/gauntlet_basic_magazine_02", type = "magazine"},
    },
    ogryn_club_p1_m1 = {
        grip_01 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_01", type = "grip"},
        grip_02 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_02", type = "grip"},
        grip_03 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_03", type = "grip"},
        grip_04 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_04", type = "grip"},
        grip_05 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_05", type = "grip"},
        pommel_01 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_01", type = "pommel"},
        pommel_02 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_02", type = "pommel"},
        pommel_03 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_03", type = "pommel"},
        pommel_04 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_04", type = "pommel"},
        pommel_05 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_05", type = "pommel"},
        head_01 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_01", type = "head"},
        head_02 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_02", type = "head"},
        head_03 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_03", type = "head"},
        head_04 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_04", type = "head"},
        head_05 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_05", type = "head"},
    },
    ogryn_combatblade_p1_m1 = {
        blade_01 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_01", type = "blade"},
        blade_02 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_02", type = "blade"},
        blade_03 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_03", type = "blade"},
        blade_04 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_04", type = "blade"},
        blade_05 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_05", type = "blade"},
        blade_06 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_06", type = "blade"},
        grip_01 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_01", type = "grip"},
        grip_02 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_02", type = "grip"},
        grip_03 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_03", type = "grip"},
        grip_04 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_04", type = "grip"},
        grip_05 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_05", type = "grip"},
        grip_06 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_06", type = "grip"},
        handle_01 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_01", type = "handle"},
        handle_02 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_02", type = "handle"},
        handle_03 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_03", type = "handle"},
        handle_04 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_04", type = "handle"},
        handle_05 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_05", type = "handle"},
        handle_06 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_06", type = "handle"},
    },
    ogryn_powermaul_p1_m1 = {
        shaft_01 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_01", type = "shaft"},
        shaft_02 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_02", type = "shaft"},
        shaft_03 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_03", type = "shaft"},
        shaft_04 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_04", type = "shaft"},
        shaft_05 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_05", type = "shaft"},
        head_01 = {model = "content/items/weapons/player/melee/heads/power_maul_head_01", type = "head"},
        head_02 = {model = "content/items/weapons/player/melee/heads/power_maul_head_02", type = "head"},
        head_03 = {model = "content/items/weapons/player/melee/heads/power_maul_head_03", type = "head"},
        head_04 = {model = "content/items/weapons/player/melee/heads/power_maul_head_04", type = "head"},
        head_05 = {model = "content/items/weapons/player/melee/heads/power_maul_head_05", type = "head"},
        pommel_01 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_01", type = "pommel"},
        pommel_02 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_02", type = "pommel"},
        pommel_03 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_03", type = "pommel"},
        pommel_04 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_04", type = "pommel"},
        pommel_05 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_05", type = "pommel"},
    },
    ogryn_club_p2_m1 = {
        body_01 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_01", type = "body"},
        body_02 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_02", type = "body"},
        body_03 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_03", type = "body"},
        body_04 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_04", type = "body"},
        body_05 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_05", type = "body"},
    },
}

mod.attachment_models.ogryn_heavystubber_p1_m2 = mod.attachment_models.ogryn_heavystubber_p1_m1
mod.attachment_models.ogryn_heavystubber_p1_m3 = mod.attachment_models.ogryn_heavystubber_p1_m1
mod.attachment_models.ogryn_rippergun_p1_m2 = mod.attachment_models.ogryn_rippergun_p1_m1
mod.attachment_models.ogryn_rippergun_p1_m3 = mod.attachment_models.ogryn_rippergun_p1_m1
mod.attachment_models.ogryn_thumper_p1_m2 = mod.attachment_models.ogryn_thumper_p1_m1
mod.attachment_models.ogryn_combatblade_p1_m2 = mod.attachment_models.ogryn_combatblade_p1_m1
mod.attachment_models.ogryn_combatblade_p1_m3 = mod.attachment_models.ogryn_combatblade_p1_m1
mod.attachment_models.ogryn_powermaul_slabshield_p1_m1 = mod.attachment_models.ogryn_powermaul_p1_m1
mod.attachment_models.ogryn_club_p2_m2 = mod.attachment_models.ogryn_club_p2_m1
mod.attachment_models.ogryn_club_p2_m3 = mod.attachment_models.ogryn_club_p2_m1