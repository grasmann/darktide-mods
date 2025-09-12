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
        autopistol_p1_m1 = {
            receiver = {
                autogun_pistol_receiver_01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
                autogun_pistol_receiver_02 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_02",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
                autogun_pistol_receiver_03 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_03",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
                autogun_pistol_receiver_04 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_04",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
                autogun_pistol_receiver_05 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_05",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
                autogun_pistol_receiver_ml01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_pistol_receiver_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
            },
        },
        bolter_p1_m1 = {
            sight = {
                scope_02 = {
                    replacement_path = _item_ranged.."/sights/scope_02",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.2, -2.75, .25},
                },
            }
        },
    },
    fixes = {
        bolter_p1_m1 = {
            {attachment_slot = "sight",
                requirements = {
                    sight = {
                        has = "scope_02",
                    },
                },
                fix = {
                    offset = {
                        position = vector3_box(0, .1, -.01),
                        rotation = vector3_box(0, 0, 0),
                    },
                },
            },
        }
    },
    kitbash = {
        ["content/items/weapons/player/ranged/sights/scope_02"] = {
            attachments = {
                base = {
                    item = "content/items/weapons/player/ranged/sights/reflex_sight_02",
                    fix = {
                        disable_in_ui = true,
                        offset = {
                            node = 1,
                            position = vector3_box(0, 0, .115),
                            rotation = vector3_box(0, 0, 0),
                            scale = vector3_box(1, 1, 1),
                        },
                    },
                    children = {
                        body = {
                            item = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_04",
                            fix = {
                                offset = {
                                    node = 1,
                                    position = vector3_box(0, -.04, .05),
                                    rotation = vector3_box(0, 0, 0),
                                    scale = vector3_box(1.5, 1.5, 1.5),
                                },
                            },
                            children = {
                                lense_1 = {
                                    item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .085, 0),
                                            rotation = vector3_box(0, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                    },
                                },
                                lense_2 = {
                                    item = "content/items/weapons/player/ranged/bullets/rippergun_rifle_bullet_01",
                                    fix = {
                                        offset = {
                                            node = 1,
                                            position = vector3_box(0, .075, 0),
                                            rotation = vector3_box(180, 0, 0),
                                            scale = vector3_box(1, .35, 1),
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
            display_name = "loc_scope_01",
            description = "loc_description_scope_01",
            attach_node = "ap_sight",
            dev_name = "loc_scope_01",
        },
    }
}

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
