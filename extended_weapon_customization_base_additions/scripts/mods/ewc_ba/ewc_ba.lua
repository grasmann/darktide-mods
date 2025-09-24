local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

local extended_weapon_customization_plugin = {
    attachments = {},
    attachment_slots = {},
    fixes = {},
    kitbashs = {
        [_item_ranged.."/sights/scope_01"] = {
            attachments = {
                base = {
                    item = _item_ranged.."/sights/reflex_sight_03",
                    fix = {
                        hide = {
                            mesh = {5},
                        },
                    },
                    children = {
                        body = {
                            item = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_02",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(0, -.04, .035),
                                    rotation = vector3_box(0, 0, 0),
                                    scale = vector3_box(1.5, 1.5, 1.5),
                                },
                            },
                            children = {
                                lense_1 = {
                                    item = _item_ranged.."/bullets/rippergun_rifle_bullet_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .085, 0),
                                            rotation = vector3_box(0, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                        alpha = .25,
                                    },
                                },
                                lense_2 = {
                                    item = _item_ranged.."/bullets/rippergun_rifle_bullet_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .075, 0),
                                            rotation = vector3_box(180, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                        alpha = .25,
                                    },
                                },
                            },
                        },
                    },
                },
            },
            attach_node = "ap_sight_01",
            display_name = "loc_scope_01",
            description = "loc_description_scope_01",
            dev_name = "loc_scope_01",
        },
        [_item_ranged.."/magazines/autogun_rifle_magazine_01_double"] = {
            attachments = {
                double_magazine_1 = {
                    item = _item_ranged.."/magazines/autogun_rifle_magazine_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        double_magazine_clip = {
                            item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(.0325, -.01, -.15),
                                    rotation = vector3_box(0, 90, 0),
                                    scale = vector3_box(1, 1.2, .75),
                                },
                            },
                            children = {
                                double_magazine_2 = {
                                    item = _item_ranged.."/magazines/autogun_rifle_magazine_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(.15, .005, -.125),
                                            rotation = vector3_box(0, 90, 0),
                                            scale = vector3_box(1.3, .85, 1),
                                        },
                                    },
                                    children = {},
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_autogun_rifle_magazine_01_double",
            description = "loc_description_autogun_rifle_magazine_01_double",
            attach_node = "ap_magazine_01",
            dev_name = "loc_autogun_rifle_magazine_01_double",
        },
        [_item_ranged.."/magazines/autogun_rifle_magazine_02_double"] = {
            attachments = {
                double_magazine_1 = {
                    item = _item_ranged.."/magazines/autogun_rifle_magazine_02",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        double_magazine_clip = {
                            item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(.0325, -.01, -.15),
                                    rotation = vector3_box(0, 90, 0),
                                    scale = vector3_box(1, 1.2, .75),
                                },
                            },
                            children = {
                                double_magazine_2 = {
                                    item = _item_ranged.."/magazines/autogun_rifle_magazine_02",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(.15, .005, -.125),
                                            rotation = vector3_box(0, 90, 0),
                                            scale = vector3_box(1.3, .85, 1),
                                        },
                                    },
                                    children = {},
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_autogun_rifle_magazine_02_double",
            description = "loc_description_autogun_rifle_magazine_02_double",
            attach_node = "ap_magazine_01",
            dev_name = "loc_autogun_rifle_magazine_02_double",
        },
        [_item_ranged.."/magazines/autogun_rifle_magazine_03_double"] = {
            attachments = {
                double_magazine_1 = {
                    item = _item_ranged.."/magazines/autogun_rifle_magazine_03",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        double_magazine_clip = {
                            item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(.0325, -.01, -.15),
                                    rotation = vector3_box(0, 90, 0),
                                    scale = vector3_box(1, 1.2, .75),
                                },
                            },
                            children = {
                                double_magazine_2 = {
                                    item = _item_ranged.."/magazines/autogun_rifle_magazine_03",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(.15, .005, -.125),
                                            rotation = vector3_box(0, 90, 0),
                                            scale = vector3_box(1.3, .85, 1),
                                        },
                                    },
                                    children = {},
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_autogun_rifle_magazine_03_double",
            description = "loc_description_autogun_rifle_magazine_03_double",
            attach_node = "ap_magazine_01",
            dev_name = "loc_autogun_rifle_magazine_03_double",
        },
        [_item_ranged.."/magazines/autogun_rifle_ak_magazine_01_double"] = {
            attachments = {
                double_magazine_1 = {
                    item = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        double_magazine_clip = {
                            item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(.0325, 0, -.16),
                                    rotation = vector3_box(10, 90, 0),
                                    scale = vector3_box(1, 1.2, .75),
                                },
                            },
                            children = {
                                double_magazine_2 = {
                                    item = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(.15, .1, -.125),
                                            rotation = vector3_box(0, 90, 180),
                                            scale = vector3_box(1.3, .85, 1),
                                        },
                                    },
                                    children = {},
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_autogun_rifle_ak_magazine_01_double",
            description = "loc_description_autogun_rifle_ak_magazine_01_double",
            attach_node = "ap_magazine_01",
            dev_name = "loc_autogun_rifle_ak_magazine_01_double",
        },
        [_item_ranged.."/magazines/autogun_pistol_magazine_01_double"] = {
            attachments = {
                double_magazine_1 = {
                    item = _item_ranged.."/magazines/autogun_pistol_magazine_01",
                    fix = {
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, 0),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        double_magazine_clip = {
                            item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(.0325, -.01, -.15),
                                    rotation = vector3_box(0, 90, 0),
                                    scale = vector3_box(1, .8, .75),
                                },
                            },
                            children = {
                                double_magazine_2 = {
                                    item = _item_ranged.."/magazines/autogun_pistol_magazine_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(.15, .005, -.125),
                                            rotation = vector3_box(0, 90, 0),
                                            scale = vector3_box(1.3, 1.3, 1),
                                        },
                                    },
                                    children = {},
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_autogun_pistol_magazine_01_double",
            description = "loc_description_autogun_pistol_magazine_01_double",
            attach_node = "ap_magazine_01",
            dev_name = "loc_autogun_pistol_magazine_01_double",
        },
    },
}

local weapons_folder = "extended_weapon_customization_base_additions/scripts/mods/ewc_ba/weapons/"
local load_weapons = {
    "autogun_p1_m1",
    "autopistol_p1_m1",
    "bolter_p1_m1",
    "shotgun_p4_m1",
}

for _, file_name in pairs(load_weapons) do
    local data = mod:io_dofile(weapons_folder..file_name)

    if data then

        if data.attachments then
            extended_weapon_customization_plugin.attachments = table_merge_recursive(extended_weapon_customization_plugin.attachments, data.attachments)
        end

        if data.attachment_slots then
            extended_weapon_customization_plugin.attachment_slots = table_merge_recursive(extended_weapon_customization_plugin.attachment_slots, data.attachment_slots)
        end

        if data.fixes then
            extended_weapon_customization_plugin.fixes = table_merge_recursive(extended_weapon_customization_plugin.fixes, data.fixes)
        end

        if data.kitbashs then
            extended_weapon_customization_plugin.kitbashs = table_merge_recursive(extended_weapon_customization_plugin.kitbashs, data.kitbashs)
        end

    end

end

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
