local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local trinket_hooks = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/trinket_hook")
local emblem_right = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_right")
local emblem_left = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/attachments/emblem_left")

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

local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

return {
    attachments = {
        emblem_left = emblem_left,
        emblem_right = emblem_right,
        trinket_hook = trinket_hooks,
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
    },
}
