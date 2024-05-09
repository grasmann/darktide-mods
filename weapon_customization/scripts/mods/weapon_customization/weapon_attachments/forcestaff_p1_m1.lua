local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _forcestaff_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/forcestaff_p1_m1")
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
    _forcestaff_p1_m1,
    {
        attachments = {
            shaft_lower = _forcestaff_p1_m1.staff_shaft_lower_attachments(),
            shaft_upper = _forcestaff_p1_m1.staff_shaft_upper_attachments(),
            body = _forcestaff_p1_m1.staff_body_attachments(),
            head = _forcestaff_p1_m1.staff_head_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(-.5, 8, .75)},
            _forcestaff_p1_m1.staff_head_models(nil, 0, vector3_box(.15, -8.5, -.8), vector3_box(0, 0, .4)),
            _forcestaff_p1_m1.staff_body_models(nil, 0, vector3_box(.1, -7, -.65), vector3_box(0, 0, .2)),
            _forcestaff_p1_m1.staff_shaft_upper_models(nil, 0, vector3_box(-.25, -5.5, -.4), vector3_box(0, 0, .1)),
            _forcestaff_p1_m1.staff_shaft_lower_models(nil, 0, vector3_box(-.75, -4, .5), vector3_box(0, 0, -.1)),
            _common.emblem_right_models("body", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("body", 0, vector3_box(0, -3, 0), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                {dependencies = {"body_01"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "body", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)