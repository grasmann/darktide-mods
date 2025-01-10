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

local power_maul_heads = "power_maul_head_01|power_maul_head_02|power_maul_head_03|power_maul_head_04|power_maul_head_05|power_maul_head_ml01"
local small_power_maul_heads = "human_power_maul_head_01|human_power_maul_head_02|human_power_maul_head_03|human_power_maul_head_04|human_power_maul_head_05|human_power_maul_head_06|human_power_maul_head_ml01"
local power_maul_connectors = "2h_power_maul_connector_01|2h_power_maul_connector_02|2h_power_maul_connector_03|2h_power_maul_connector_04|2h_power_maul_connector_05|2h_power_maul_connector_ml01"
local power_maul_2h_heads = "2h_power_maul_head_01|2h_power_maul_head_02|2h_power_maul_head_03|2h_power_maul_head_04|2h_power_maul_head_05|2h_power_maul_head_ml01"
local thunderhammer_heads = "thunder_hammer_head_01|thunder_hammer_head_02|thunder_hammer_head_03|thunder_hammer_head_04|thunder_hammer_head_05|thunder_hammer_head_ml01"
local thunderhammer_connectors = "thunder_hammer_connector_01|thunder_hammer_connector_02|thunder_hammer_connector_03|thunder_hammer_connector_04|thunder_hammer_connector_05|thunder_hammer_connector_ml01"
local force_staff_fulls = "force_staff_full_01|force_staff_full_02|force_staff_full_03|force_staff_full_04|force_staff_full_05|force_staff_full_ml01"
-- local chain_axe_shafts = "chain_axe_shaft_01|chain_axe_shaft_02|chain_axe_shaft_03|chain_axe_shaft_04|chain_axe_shaft_05|chain_axe_shaft_ml01"
local ogryn_powermaul_pommels = "ogryn_powermaul_pommel_01|ogryn_powermaul_pommel_02|ogryn_powermaul_pommel_03|ogryn_powermaul_pommel_04|ogryn_powermaul_pommel_05|ogryn_powermaul_pommel_06"
local ogryn_club_pommels = "ogryn_club_pommel_01|ogryn_club_pommel_02|ogryn_club_pommel_03|ogryn_club_pommel_04|ogryn_club_pommel_05|shovel_ogryn_pommel_ml01"
local ogryn_pickaxe_shafts = "pickaxe_shaft_01|pickaxe_shaft_02|pickaxe_shaft_03|pickaxe_shaft_04|ogryn_pickaxe_shaft_ml01"
local force_staff_shafts = "shaft_lower_01|shaft_lower_02|shaft_lower_03|shaft_lower_04|shaft_lower_05|shaft_lower_06"
local power_maul_shafts = "2h_power_maul_shaft_01|2h_power_maul_shaft_02|2h_power_maul_shaft_03|2h_power_maul_shaft_04|2h_power_maul_shaft_05|2h_power_maul_shaft_06|2h_power_maul_shaft_ml01"

local list_a = {"thunder_hammer_connector_03", "thunder_hammer_connector_04", "thunder_hammer_connector_05", "thunder_hammer_connector_ml01",
    "force_staff_full_01", "force_staff_full_02", "force_staff_full_03", "force_staff_full_04", "force_staff_full_05", "force_staff_full_ml01",
    "2h_power_maul_connector_01", "2h_power_maul_connector_02", "2h_power_maul_connector_03", "2h_power_maul_connector_04", "2h_power_maul_connector_05", "2h_power_maul_connector_ml01"}

local changes = {}
return table.combine(
    _thunderhammer_2h_p1_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- shaft = _thunderhammer_2h_p1_m1.shaft_attachments(),
            shaft = table.icombine(
                _common_melee.medium_shaft_attachments(),
                _common_melee.long_shaft_attachments(false)
            ),
            -- pommel = _thunderhammer_2h_p1_m1.pommel_attachments(),
            pommel = _common_melee.pommel_attachments(true, true, false, false),
            connector = _common.connector_attachments(),
            -- head = functions.head_attachments(),
            head = _common_melee.blunt_head_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 4, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            -- _thunderhammer_2h_p1_m1.shaft_models(nil, 0, vector3_box(-.5, -3, .3), vector3_box(0, 0, 0)),
            -- _common_melee.small_shaft_models(nil, 0, vector3_box(-.5, -3, .3), vector3_box(0, 0, 0)),
            _common_melee.medium_shaft_models({
				{parent = nil, angle = 0, move = vector3_box(-.5, -3, .3), remove = vector3_box(0, 0, 0)}
			}),
            _common_melee.long_shaft_models({
				{parent = nil, angle = 0, move = vector3_box(-.5, -3, .3), remove = vector3_box(0, 0, 0), no_support = {
                    {"pommel_none"},
                    -- Force staff
                    {"pommel"},
                    {"pommel"},
                    {"pommel"},
                    {"pommel"},
                    {"pommel"},
                    {"pommel"},
                }, automatic_equip = {
                    {},
                    -- Force staff
                    {pommel = "pommel_none"},
                    {pommel = "pommel_none"},
                    {pommel = "pommel_none"},
                    {pommel = "pommel_none"},
                    {pommel = "pommel_none"},
                    {pommel = "pommel_none"},
                }},
                {parent = nil, angle = 0, move = vector3_box(-.5, -3, .3), remove = vector3_box(0, 0, 0), no_support = {
                    {"pommel_none"},
                    -- Pickaxe
                    {"pommel_none"},
                    {"pommel_none"},
                    {"pommel_none"},
                    {"pommel_none"},
                    {"pommel_none"},
                }, automatic_equip = {
                    {},
                    -- Pickaxe
                    {pommel = "pommel_none|pommel_default"},
                    {pommel = "pommel_none|pommel_default"},
                    {pommel = "pommel_none|pommel_default"},
                    {pommel = "pommel_none|pommel_default"},
                    {pommel = "pommel_none|pommel_default"},
                }}
			}),
            _common.connector_models("shaft", 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .1), "connector", {
                {},
                -- Thunder
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                -- Staff
                {"trinket_hook_empty", "trinket_hook_default"},
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
                {"trinket_hook_empty", "trinket_hook_default"},
            }, {
                {},
                -- Thunder
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                -- Staff
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
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
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
            }, nil, {
                false,
            }, function(gear_id, item, attachment, attachment_list)
                changes = {}
                if table.contains(list_a, attachment) then
                    local trinket_hook = attachment_list and attachment_list["trinket_hook"] or mod.gear_settings:get(item, "trinket_hook")
                    if trinket_hook == "trinket_hook_empty" then
                        changes["trinket_hook"] = "trinket_hook_01"
                    end
                end
                return changes
            end),
            -- functions.head_models(nil, 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2)),
            _common_melee.blunt_head_models("connector", 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2), "head"),
            -- _thunderhammer_2h_p1_m1.pommel_models(nil, 0, vector3_box(-.75, -4, .5), vector3_box(0, 0, -.1))
            _common_melee.pommel_models({
                {parent = nil, angle = 0, move = vector3_box(-.75, -4, .5), remove = vector3_box(0, 0, -.1)}
            })
        ),
        anchors = {
            fixes = {

                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, power_maul_shafts},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.17), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .4)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, "pickaxe_shaft_03"},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.4), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, ogryn_pickaxe_shafts},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.5), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, force_staff_shafts},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -1.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .4)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, "thunder_hammer_shaft_01|thunder_hammer_shaft_05"},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.12), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .4)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels, "thunder_hammer_shaft_02"},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.15), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .4)}},
                {dependencies = {ogryn_powermaul_pommels.."|"..ogryn_club_pommels},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.4, .4, .4)}},

                {dependencies = {force_staff_fulls, "2h_power_maul_shaft_03"},
                    connector = {parent = "shaft", position = vector3_box(0, 0, .4), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {force_staff_fulls, "2h_power_maul_shaft_04|2h_power_maul_shaft_05"},
                    connector = {parent = "shaft", position = vector3_box(0, 0, .36), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {force_staff_fulls, power_maul_shafts},
                    center_mass = vector3_box(0, 0, -.5),
                    shaft = {offset = true, position = vector3_box(0, 0, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    connector = {parent = "shaft", position = vector3_box(0, 0, .415), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {power_maul_shafts},
                    center_mass = vector3_box(0, 0, -.5),
                    shaft = {offset = true, position = vector3_box(0, 0, .15), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {force_staff_shafts},
                    center_mass = vector3_box(0, 0, 1.25),
                    connector = {parent = "shaft", position = vector3_box(0, 0, -.3), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -1.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    shaft = {offset = true, position = vector3_box(0, 0, 1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {ogryn_pickaxe_shafts, power_maul_heads, force_staff_fulls},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {ogryn_pickaxe_shafts, small_power_maul_heads, force_staff_fulls},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_pickaxe_shafts, power_maul_heads}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .275), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {"pickaxe_shaft_03"},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.4), rotation = vector3_box(0, 0, 0), scale = vector3_box(4, 4, 3)}},
                {dependencies = {ogryn_pickaxe_shafts, force_staff_fulls, power_maul_heads},
                    head = {parent = "connector", position = vector3_box(0, 0, .3), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_pickaxe_shafts, force_staff_fulls, power_maul_2h_heads},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_pickaxe_shafts, force_staff_fulls},
                    head = {parent = "connector", position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {ogryn_pickaxe_shafts},
                    center_mass = vector3_box(0, 0, -.6),
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    connector = {parent = "shaft", position = vector3_box(0, 0, 1.25), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 2)},
                    pommel = {parent = "shaft", position = vector3_box(0, 0, -.5), rotation = vector3_box(0, 0, 0), scale = vector3_box(4, 4, 3)},
                    shaft = {offset = true, position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .5)}},

                {dependencies = {"force_staff_full_03", power_maul_heads}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"force_staff_full_04", power_maul_heads}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"force_staff_full_03"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"force_staff_full_04"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"force_staff_full_02|force_staff_full_05|force_staff_full_ml01", power_maul_heads}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"force_staff_full_02|force_staff_full_05|force_staff_full_ml01"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {force_staff_fulls, power_maul_heads}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {force_staff_fulls}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {power_maul_heads, "2h_power_maul_connector_01"},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {power_maul_heads, "2h_power_maul_connector_02|2h_power_maul_connector_03"},
                    head = {parent = "connector", position = vector3_box(0, 0, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {power_maul_heads, "2h_power_maul_connector_04|2h_power_maul_connector_05|2h_power_maul_connector_ml01"},
                    head = {parent = "connector", position = vector3_box(0, 0, .22), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {power_maul_heads, thunderhammer_connectors},
                    head = {parent = "connector", position = vector3_box(0, 0, .18), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {power_maul_heads},
                    head = {parent = "connector", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                -- {dependencies = {chain_axe_shafts},
                --     shaft = {offset = true, position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 2)},
                --     connector = {parent = "shaft", position = vector3_box(0, 0, .22), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, .5)}},

            },
        },
    }
)