local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local braced_receivers = "autogun_rifle_ak_receiver_01|autogun_rifle_ak_receiver_02|autogun_rifle_ak_receiver_03|autogun_rifle_ak_receiver_ml01"
local braced_barrels = "autogun_rifle_barrel_ak_01|autogun_rifle_barrel_ak_02|autogun_rifle_barrel_ak_03|autogun_rifle_barrel_ak_04|autogun_rifle_barrel_ak_05|autogun_rifle_barrel_ak_06|autogun_rifle_barrel_ak_07|autogun_rifle_barrel_ak_08|autogun_rifle_barrel_ak_ml01"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local infantry_receivers = "autogun_rifle_receiver_01|autogun_rifle_receiver_ml01"
local scopes = "scope_01"

return {
    attachments = {
        barrel = {
            --#region Infantry
                autogun_rifle_barrel_01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_02 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_02",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_03 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_03",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_04 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_04",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_05 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_05",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_06 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_06",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_ml01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ml01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
            --#endregion
            --#region Braced
                autogun_rifle_barrel_ak_01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_02 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_02",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_03 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_03",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_04 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_04",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_05 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_05",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_06 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_06",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_07 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_07",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_08 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_08",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
                autogun_rifle_barrel_ak_ml01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_ak_ml01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.2, -3, 0},
                },
            --#endregion
            --#region Headhunter
                autogun_rifle_barrel_killshot_01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_killshot_03 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_03",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_killshot_04 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_04",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_killshot_05 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_05",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
                autogun_rifle_barrel_killshot_ml01 = {
                    replacement_path = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_ml01",
                    icon_render_unit_rotation_offset = {90, -20, 90 - 30},
                    icon_render_camera_position_offset = {-.15, -2.5, 0},
                },
            --#endregion
        },
        muzzle = {
            --#region Infantry
                autogun_rifle_muzzle_01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_muzzle_02 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_02",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_muzzle_03 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_03",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_muzzle_04 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_04",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_muzzle_05 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_05",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_muzzle_ml01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_muzzle_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
            --#endregion
            --#region Braced
                autogun_rifle_ak_muzzle_01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_ak_muzzle_02 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_02",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_ak_muzzle_03 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_03",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_ak_muzzle_04 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_04",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_ak_muzzle_05 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_05",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_ak_muzzle_ml01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
            --#endregion
            --#region Headhunter
                autogun_rifle_killshot_muzzle_01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_killshot_muzzle_03 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_03",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_killshot_muzzle_04 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_04",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_killshot_muzzle_05 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_05",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
                autogun_rifle_killshot_muzzle_ml01 = {
                    replacement_path = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 30},
                    icon_render_camera_position_offset = {-.15, -1, .15},
                },
            --#endregion
        },
        magazine = {
            autogun_rifle_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            autogun_rifle_magazine_02 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            autogun_rifle_magazine_03 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_magazine_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.125, -1.25, -.05},
            },
            autogun_rifle_ak_magazine_01 = {
                replacement_path = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.15, -1.45, -.1},
            }
        },
        receiver = {
            --#region Infantry
                autogun_rifle_receiver_01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_receiver_ml01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_receiver_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
            --#endregion
            --#region Braced
                autogun_rifle_ak_receiver_01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_ak_receiver_02 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_02",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_ak_receiver_03 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_03",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_ak_receiver_ml01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_ak_receiver_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
            --#endregion
            --#region Headhunter
                autogun_rifle_killshot_receiver_01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_killshot_receiver_02 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_02",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_killshot_receiver_03 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_03",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_killshot_receiver_04 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_04",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
                autogun_rifle_killshot_receiver_ml01 = {
                    replacement_path = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_ml01",
                    icon_render_unit_rotation_offset = {90, 0, 45},
                    icon_render_camera_position_offset = {-.175, -2, .25},
                },
            --#endregion
        },
        flashlight = {
            flashlight_01 = {
                replacement_path = _item_ranged.."/flashlights/flashlight_01",
                icon_render_unit_rotation_offset = {90, 0, 90 + 30},
                icon_render_camera_position_offset = {-.125, -.75, .15},
            },
            flashlight_02 = {
                replacement_path = _item_ranged.."/flashlights/flashlight_02",
                icon_render_unit_rotation_offset = {90, 0, 90 + 30},
                icon_render_camera_position_offset = {-.075, -.75, .15},
            },
            flashlight_03 = {
                replacement_path = _item_ranged.."/flashlights/flashlight_03",
                icon_render_unit_rotation_offset = {90, 0, 90 + 30},
                icon_render_camera_position_offset = {-.15, -.75, .15},
            },
            flashlight_05 = {
                replacement_path = _item_ranged.."/flashlights/flashlight_05",
                icon_render_unit_rotation_offset = {90, 0, 90 + 30},
                icon_render_camera_position_offset = {-.075, -.75, .15},
            },
        },
        sight = {
            autogun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            autogun_rifle_ak_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_rifle_ak_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            autogun_rifle_killshot_sight_01 = {
                replacement_path = _item_ranged.."/sights/autogun_rifle_killshot_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
            reflex_sight_01 = {
                replacement_path = _item_ranged.."/sights/reflex_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            reflex_sight_02 = {
                replacement_path = _item_ranged.."/sights/reflex_sight_02",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            reflex_sight_03 = {
                replacement_path = _item_ranged.."/sights/reflex_sight_03",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .175},
            },
            scope_01 = {
                replacement_path = _item_ranged.."/sights/scope_01",
                icon_render_unit_rotation_offset = {90, 0, -85},
                icon_render_camera_position_offset = {0, -.8, .45},
            },
        },
        stock = {
            --#region Infantry
                autogun_rifle_stock_01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_stock_02 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_02",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_stock_03 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_03",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_stock_04 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_04",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_stock_ml01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_stock_ml01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
            --#endregion
            --#region Braced
                autogun_rifle_ak_stock_01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_02 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_02",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_03 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_03",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_04 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_04",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_05 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_05",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_06 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_06",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_07 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_07",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_ak_stock_ml01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_ak_stock_ml01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
            --#endregion
            --#region Headhunter
                autogun_rifle_killshot_stock_01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_killshot_stock_01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_killshot_stock_02 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_killshot_stock_02",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
                autogun_rifle_killshot_stock_ml01 = {
                    replacement_path = _item_ranged.."/stocks/autogun_rifle_killshot_stock_ml01",
                    icon_render_unit_rotation_offset = {90, -10, 30},
                    icon_render_camera_position_offset = {.1, -1.5, .2},
                },
            --#endregion
        },
        grip = {
            autogun_rifle_grip_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_02 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_03 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },

            autogun_rifle_grip_ak_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_02 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_03 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_04 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_05 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_ak_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_ak_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },

            autogun_rifle_grip_killshot_01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_killshot_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
            autogun_rifle_grip_killshot_ml01 = {
                replacement_path = _item_ranged.."/grips/autogun_rifle_grip_killshot_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
        rail = {
            lasgun_rifle_rail_01 = {
                replacement_path = _item_ranged.."/rails/lasgun_rifle_rail_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {.075, -1, .05},
            },
        },
    },
    fixes = {
        {attachment_slot = "rail",
            requirements = {
                receiver = {
                    has = infantry_receivers,
                },
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_rifle_rail_01",
                },
                offset = {
                    position = vector3_box(0, -.05, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "barrel",
            requirements = {
                receiver = {
                    has = braced_receivers,
                },
                barrel = {
                    missing = braced_barrels,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, .0325),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "barrel",
            requirements = {
                receiver = {
                    missing = braced_receivers,
                },
                barrel = {
                    has = braced_barrels,
                }
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0325),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}