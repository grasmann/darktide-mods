local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _thunderhammer_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/thunderhammer_2h_p1_m1")
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
    _thunderhammer_2h_p1_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            shaft = _thunderhammer_2h_p1_m1.shaft_attachments(),
            pommel = _thunderhammer_2h_p1_m1.pommel_attachments(),
            connector = _common.connector_attachments(),
            -- head = functions.head_attachments(),
            head = _common_melee.blunt_head_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 4, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _thunderhammer_2h_p1_m1.shaft_models(nil, 0, vector3_box(-.5, -3, .3), vector3_box(0, 0, 0)),
            _common.connector_models("shaft", 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .1), "connector", {
                {},
                -- Thunder
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                -- Staff
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                -- Power
                {"trinket_hook"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
            }, {
                {},
                -- Thunder
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                -- Staff
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                -- Power
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
            }, nil, {
                false,
            }, function(gear_id, item, attachment)
                local changes = {}
                local list_a = {"thunder_hammer_connector_03", "thunder_hammer_connector_04", "thunder_hammer_connector_05", "body_01", "body_02", "body_03", "body_04", "body_05", "2h_power_maul_connector_01", "2h_power_maul_connector_02", "2h_power_maul_connector_03", "2h_power_maul_connector_04", "2h_power_maul_connector_05"}
                if table.contains(list_a, attachment) then
                    local trinket_hook = mod.gear_settings:get(item, "trinket_hook")
                    if trinket_hook == "trinket_hook_empty" then
                        changes["trinket_hook"] = "trinket_hook_01"
                    end
                end
                return changes
            end),
            -- functions.head_models(nil, 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2)),
            _common_melee.blunt_head_models("connector", 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2), "head"),
            _thunderhammer_2h_p1_m1.pommel_models(nil, 0, vector3_box(-.75, -4, .5), vector3_box(0, 0, -.1))
        ),
        anchors = {
            fixes = {

                {dependencies = {"body_03", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_04", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_03"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"body_04"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"body_02|body_05", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_02|body_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"body_01|body_02|body_03|body_04|body_05", "head_01|head_02|head_03|head_04|head_05"}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_01|body_02|body_03|body_04|body_05"}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_01"},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_02|2h_power_maul_connector_03"},
                    head = {parent = "connector", position = vector3_box(0, 0, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_04|2h_power_maul_connector_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, .22), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "thunder_hammer_connector_01|thunder_hammer_connector_02|thunder_hammer_connector_03|thunder_hammer_connector_04|thunder_hammer_connector_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

            },
        },
    }
)