local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _powermaul_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powermaul_2h_p1_m1")
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
    _powermaul_2h_p1_m1,
    {
        attachments = {
            -- Native
            pommel = _powermaul_2h_p1_m1.pommel_attachments(),
            -- Melee
            connector = table.icombine(
                _powermaul_2h_p1_m1.connector_attachments(),
                _common_melee.human_power_maul_connector_attachments(false)
            ),
            head = table.icombine(
                _powermaul_2h_p1_m1.head_attachments(),
                _common_melee.human_power_maul_head_attachments(false)
            ),
            shaft = table.icombine(
                _powermaul_2h_p1_m1.shaft_attachments()
                -- _common_melee.human_power_maul_shaft_attachments(false)
            ),
            -- Common
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 3, .35)},
            -- Native
            _powermaul_2h_p1_m1.shaft_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            _powermaul_2h_p1_m1.connector_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            _powermaul_2h_p1_m1.head_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            _powermaul_2h_p1_m1.pommel_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2)),
            -- Melee
            _common_melee.human_power_maul_shaft_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            _common_melee.human_power_maul_head_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            _common_melee.human_power_maul_connector_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            -- Common
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0))
        ),
        anchors = {

        },
    }
)