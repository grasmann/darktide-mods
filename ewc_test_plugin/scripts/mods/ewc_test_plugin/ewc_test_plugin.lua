local mod = get_mod("ewc_test_plugin")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local vector3_box = Vector3Box
    local table_clone = table.clone
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local extended_weapon_customization_plugin = {
    attachments = {
        autogun_p1_m1 = {
            magazine = {
                autogun_rifle_magazine_01_double = {
                    replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_01_double",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.09, -1.5, -.1},
                },
            },
        },
    },
    kitbashs = {
        ["content/items/weapons/player/ranged/magazines/autogun_rifle_magazine_01_double"] = {
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
            display_name = "loc_scope_01",
            description = "loc_description_scope_01",
            attach_node = "ap_magazine_01",
            dev_name = "loc_scope_01",
        },
    },
}

extended_weapon_customization_plugin.attachments.autogun_p1_m2 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p1_m3 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p2_m1 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p2_m2 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p2_m3 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p3_m1 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p3_m2 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)
extended_weapon_customization_plugin.attachments.autogun_p3_m3 = table_clone(extended_weapon_customization_plugin.attachments.autogun_p1_m1)

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
