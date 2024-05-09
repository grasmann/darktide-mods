local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _combataxe_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p2_m1")
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

return table.combine(
    _combataxe_p2_m1,
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
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            -- _common_melee.axe_grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.medium_grip_models({
				{parent = nil, angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, -.2)}
			}),
            _common_melee.axe_head_models({
                {parent = nil, angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, .2)}
            }),
            _common_melee.pommel_models({
                {parent = nil, angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, -.2)}
            })
        ),
        anchors = {

        },
    }
)