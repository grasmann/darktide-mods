local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/trinket_hook")
local flashlights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/flashlight")
local sights = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/sight")
local rails = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/rail")
local muzzles = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/muzzle")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_left")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/weapons/emblem_right")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
        flashlight = flashlights,
        sight = sights,
        rail = rails,
        muzzle = muzzles,
        body = {
            stubgun_pistol_full_01 = {
                replacement_path = _item_melee.."/full/stubgun_pistol_full_01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.05, -1.25, .15},
            },
            stubgun_pistol_receiver_02 = {
                replacement_path = _item_ranged.."/recievers/stubgun_pistol_receiver_02",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.05, -1.25, .15},
            },
            stubgun_pistol_receiver_03 = {
                replacement_path = _item_ranged.."/recievers/stubgun_pistol_receiver_03",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.05, -1.25, .15},
            },
            stubgun_pistol_receiver_ml01 = {
                replacement_path = _item_ranged.."/recievers/stubgun_pistol_receiver_ml01",
                icon_render_unit_rotation_offset = {90, 0, 45},
                icon_render_camera_position_offset = {-.05, -1.25, .15},
            },
        },
        barrel = {
            stubgun_pistol_barrel_01 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_02 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_02",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_03 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_03",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_04 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_04",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_05 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_05",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_06 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_06",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
            stubgun_pistol_barrel_ml01 = {
                replacement_path = _item_ranged.."/barrels/stubgun_pistol_barrel_ml01",
                icon_render_unit_rotation_offset = {90, 0, 30},
                icon_render_camera_position_offset = {-.185, -1.6, .15},
            },
        },
        stock = {
            shotgun_double_barrel_stock_01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_02 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_02",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_03 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_03",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
            shotgun_double_barrel_stock_ml01 = {
                replacement_path = _item_ranged.."/stocks/shotgun_double_barrel_stock_ml01",
                icon_render_unit_rotation_offset = {90, -10, 30},
                icon_render_camera_position_offset = {.15, -2, .2},
            },
        },
    },
    fixes = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0315),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "rail",
            requirements = {
                sight = {
                    has = reflex_sights.."|"..scopes,
                },
            },
            fix = {
                attach = {
                    rail = "lasgun_pistol_rail_01",
                },
                offset = {
                    position = vector3_box(0, -.07, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_04|stubgun_pistol_barrel_06",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1675, -.037),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_03|stubgun_pistol_barrel_ml01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1825, -.041),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_02",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .2025, -.0405),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_05",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1875, -.039),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        {attachment_slot = "muzzle",
            requirements = {
                barrel = {
                    has = "stubgun_pistol_barrel_01",
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1675, -.037),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
    attachment_slots = {
        sight = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        flashlight = {
            parent_slot = "sight",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.02, .03, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        muzzle = {
            parent_slot = "rail",
            default_path = _item_empty_trinket,
        },
        stock = {
            parent_slot = "body",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, -.1, -.1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
    },
}
