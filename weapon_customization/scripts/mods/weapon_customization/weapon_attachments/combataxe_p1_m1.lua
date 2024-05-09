local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _combataxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p1_m1")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local vector3_box = Vector3Box
    local table = table
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

local _chain_axe_grips = "chain_axe_grip_01|chain_axe_grip_02|chain_axe_grip_03|chain_axe_grip_04|chain_axe_grip_05"
local _ogryn_club_grips = "ogryn_club_grip_01|ogryn_club_grip_02|ogryn_club_grip_03|ogryn_club_grip_04|ogryn_club_grip_05"

return table.combine(
    _combataxe_p1_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- grip = table.icombine(
            --     _common_melee.axe_grip_attachments()
            -- ),
            grip = _common_melee.medium_grip_attachments(),
            head = table.icombine(
                _common_melee.axe_head_attachments()
            ),
            pommel = table.icombine(
                _common_melee.pommel_attachments(true, false, false, false)
            ),
        },
        models = table.combine(
            _common.emblem_right_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models(nil, -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            -- _common_melee.axe_grip_models(nil, 0, vector3_box(-.3, -2, .1), vector3_box(0, 0, 0)),
            _common_melee.medium_grip_models({
				{parent = nil, angle = 0, move = vector3_box(-.3, -2, .1), remove = vector3_box(0, 0, -.2)}
			}),
            _common_melee.axe_head_models({
                {parent = nil, angle = 0, move = vector3_box(0, -3, -.1), remove = vector3_box(0, 0, .2)}
            }),
            _common_melee.pommel_models({
                {parent = nil, angle = 0, move = vector3_box(-.5, -4, .3), remove = vector3_box(0, 0, -.2)}
            })
        ),
        anchors = {
            fixes = {
                {dependencies = {"axe_head_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"axe_head_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {_chain_axe_grips}, -- Grips
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {offset = true, position = vector3_box(0, 0, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                },
                {dependencies = {_ogryn_club_grips}, -- Grips
                    head = {offset = true, position = vector3_box(0, 0, .03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .6), scale_node = 5},
                    pommel = {offset = true, position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                },
            },
        },
    }
)