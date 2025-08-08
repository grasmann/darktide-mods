local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _powersword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powersword_p1_m1")
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

local _power_sword_blades = "power_sword_blade_01|power_sword_blade_02|power_sword_blade_03|power_sword_blade_04|power_sword_blade_05"
local _2h_power_sword_blades = "power_sword_2h_blade_01|power_sword_2h_blade_02|power_sword_2h_blade_03"
local _force_sword_blades = "force_sword_blade_01|force_sword_blade_02|force_sword_blade_03|force_sword_blade_04|force_sword_blade_05|force_sword_blade_06"
local _sabre_blades = "sabre_blade_01|sabre_blade_02|sabre_blade_03|sabre_blade_04|sabre_blade_05"
local _falchion_blades = "falchion_blade_01|falchion_blade_02|falchion_blade_03|falchion_blade_04|falchion_blade_05"
local _combat_sword_blades = "combat_sword_blade_01|combat_sword_blade_02|combat_sword_blade_03|combat_sword_blade_04|combat_sword_blade_05|combat_sword_blade_06|combat_sword_blade_07"

local _2h_power_sword_hilts = "power_sword_2h_hilt_01|power_sword_2h_hilt_02|power_sword_2h_hilt_03"
local _force_sword_hilts = "force_sword_hilt_01|force_sword_hilt_02|force_sword_hilt_03|force_sword_hilt_04|force_sword_hilt_05|force_sword_hilt_06|force_sword_hilt_07"

local _power_sword_grips = "power_sword_grip_01|power_sword_grip_02|power_sword_grip_03|power_sword_grip_04|power_sword_grip_05|power_sword_grip_06"
local _2h_power_sword_grips = "power_sword_2h_grip_01|power_sword_2h_grip_02|power_sword_2h_grip_03"
local _force_sword_grips = "force_sword_grip_01|force_sword_grip_02|force_sword_grip_03|force_sword_grip_04|force_sword_grip_05|force_sword_grip_06"
local _sabre_grips = "sabre_grip_01|sabre_grip_02|sabre_grip_03|sabre_grip_04|sabre_grip_05"
local _falchion_grips = "falchion_grip_01|falchion_grip_02|falchion_grip_03|falchion_grip_04|falchion_grip_05"
local _combat_sword_grips = "combat_sword_grip_01|combat_sword_grip_02|combat_sword_grip_03|combat_sword_grip_04|combat_sword_grip_05|combat_sword_grip_06"
local _knife_grips = "knife_grip_01|knife_grip_02|knife_grip_03|knife_grip_04|knife_grip_05|knife_grip_06|knife_grip_07"

return table.combine(
    _powersword_p1_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- grip = functions.grip_attachments(),
            grip = _common_melee.sword_grip_attachments(),
            -- pommel = functions.pommel_attachments(),
            pommel = _common_melee.pommel_attachments(true, false, false, false),
            -- blade = functions.blade_attachments(),
            blade = _common_melee.sword_blade_attachments(),
            -- hilt = functions.hilt_attachments(),
            hilt = _common_melee.sword_hilt_attachments(),
            scabbard = _common_melee.scabbard_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("blade", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("blade", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            -- functions.hilt_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .1)),
            _common_melee.sword_hilt_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .1)),
            -- functions.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.sword_grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0), "grip" --, {
            --     -- No support
            --     {},
            --     -- Power Sword
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     -- 2H Power Sword
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     -- Force Sword
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     {"pommel_none"},
            --     -- Sabre
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt_none"},
            --     {"pommel", "hilt"},
            --     -- Falchion
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     -- Combat Sword
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     {"pommel", "hilt"},
            --     -- Knife
            --     {"pommel"},
            --     {"pommel"},
            --     {"pommel"},
            --     {"pommel"},
            --     {"pommel", "hilt"},
            --     {"pommel"},
            --     {"pommel"},
            -- }, {
            --     -- Automatic equip
            --     {},
            --     -- Power Sword
            --     {pommel = "pommel_none|power_sword_pommel_01"},
            --     {pommel = "pommel_none|power_sword_pommel_02"},
            --     {pommel = "pommel_none|power_sword_pommel_03"},
            --     {pommel = "pommel_none|power_sword_pommel_04"},
            --     {pommel = "pommel_none|power_sword_pommel_05"},
            --     {pommel = "pommel_none|power_sword_pommel_05"},
            --     -- 2H Power Sword
            --     {pommel = "pommel_none|power_sword_2h_pommel_01"},
            --     {pommel = "pommel_none|power_sword_2h_pommel_02"},
            --     {pommel = "pommel_none|power_sword_2h_pommel_03"},
            --     -- Force Sword
            --     {pommel = "pommel_none|force_sword_pommel_01"},
            --     {pommel = "pommel_none|force_sword_pommel_02"},
            --     {pommel = "pommel_none|force_sword_pommel_03"},
            --     {pommel = "pommel_none|force_sword_pommel_04"},
            --     {pommel = "pommel_none|force_sword_pommel_05"},
            --     {pommel = "pommel_none|force_sword_pommel_05"},
            --     -- Sabre
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     -- Falchion
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     -- Combat Sword
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     -- Knife
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            --     {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            -- }),
            ),
            -- functions.blade_models("hilt", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_melee.sword_blade_models("hilt", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2), "blade" --, {
            --     -- No support
            --     {},
            --     -- Power Sword
            --     {"hilt"},
            --     {"hilt"},
            --     {"hilt"},
            --     {"hilt"},
            --     {"hilt"},
            --     -- 2H Power Sword
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     -- Force Sword
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     -- Sabre
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     -- Falchion
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     -- Combat Sword
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            --     {"hilt_default"},
            -- }, {
            --     -- Automatic equip
            --     {},
            --     -- Power Sword
            --     {hilt = "!hilt_default|hilt_default"},
            --     {hilt = "!hilt_default|hilt_default"},
            --     {hilt = "!hilt_default|hilt_default"},
            --     {hilt = "!hilt_default|hilt_default"},
            --     {hilt = "!hilt_default|hilt_default"},
            --     -- 2H Power Sword
            --     {hilt = "hilt_default|power_sword_2h_hilt_01"},
            --     {hilt = "hilt_default|power_sword_2h_hilt_02"},
            --     {hilt = "hilt_default|power_sword_2h_hilt_03"},
            --     -- Force Sword
            --     {hilt = "hilt_default|force_sword_hilt_01"},
            --     {hilt = "hilt_default|force_sword_hilt_02"},
            --     {hilt = "hilt_default|force_sword_hilt_03"},
            --     {hilt = "hilt_default|force_sword_hilt_04"},
            --     {hilt = "hilt_default|force_sword_hilt_05"},
            --     {hilt = "hilt_default|force_sword_hilt_06"},
            --     -- Sabre
            --     {hilt = "hilt_default|force_sword_hilt_01"},
            --     {hilt = "hilt_default|force_sword_hilt_02"},
            --     {hilt = "hilt_default|force_sword_hilt_03"},
            --     {hilt = "hilt_default|force_sword_hilt_04"},
            --     {hilt = "hilt_default|force_sword_hilt_05"},
            --     -- Falchion
            --     {hilt = "hilt_default|force_sword_hilt_01"},
            --     {hilt = "hilt_default|force_sword_hilt_02"},
            --     {hilt = "hilt_default|force_sword_hilt_03"},
            --     {hilt = "hilt_default|force_sword_hilt_04"},
            --     {hilt = "hilt_default|force_sword_hilt_05"},
            --     -- Combat Sword
            --     {hilt = "hilt_default|force_sword_hilt_01"},
            --     {hilt = "hilt_default|force_sword_hilt_02"},
            --     {hilt = "hilt_default|force_sword_hilt_03"},
            --     {hilt = "hilt_default|force_sword_hilt_04"},
            --     {hilt = "hilt_default|force_sword_hilt_05"},
            --     {hilt = "hilt_default|force_sword_hilt_06"},
            --     {hilt = "hilt_default|force_sword_hilt_07"},
            -- }),
            ),
            -- functions.pommel_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.1))
            _common_melee.pommel_models({
                {parent = "grip", angle = 0, move = vector3_box(0, 0, 0), remove = vector3_box(0, 0, -.1)}
            }),
            _common_melee.scabbard_models("blade", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2))
        ),
        anchors = {
            fixes = {
                -- Bigger knife handles
                {dependencies = {"knife_grip_06"},
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale_node = 1, scale = vector3_box(1.5, 1.5, 1.5)}},
                {dependencies = {_knife_grips},
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale_node = 1, scale = vector3_box(1.5, 1.5, 1.5)}},
                -- No hilt
                {dependencies = {_sabre_grips, _falchion_grips, _combat_sword_grips, "knife_grip_05"},
                    hilt = {parent = "grip", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                {dependencies = {"combat_sword_blade_01", "combat_sword_blade_07"},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_combat_sword_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {"falchion_blade_01"},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_falchion_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {"sabre_blade_01"},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_sabre_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {"force_sword_blade_01"},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_force_sword_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, -.08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_2h_power_sword_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.41, 1.21, 1.14)}},
                {dependencies = {"power_sword_blade_04"},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {dependencies = {_power_sword_blades},
                    scabbard = {parent = "blade", position = vector3_box(0, 0, .08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.36, 1.2, 1)}},
                {scabbard = {parent = "blade", position = vector3_box(0, 0, .082), rotation = vector3_box(0, 0, 0), scale = vector3_box(2.49, 1.082, .694)}},

                --#region Power sword blades
                    -- Power sword grips - 2H power sword blade
                    {dependencies = {"power_sword_2h_grip_02", _power_sword_blades},
                        blade = {parent = "grip", position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_2h_power_sword_grips, _power_sword_blades},
                        blade = {parent = "grip", position = vector3_box(0, 0, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                --#endregion
                --#region 2H Power sword blades
                    -- Power sword grips - 2H power sword blade
                    {dependencies = {_power_sword_grips, _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- 2H Power sword grips - 2H power sword blade
                    {dependencies = {"power_sword_2h_grip_02", _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_2h_power_sword_grips, _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- Force sword grips - 2H power sword blade
                    {dependencies = {"force_sword_grip_01|force_sword_grip_06", _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .014), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {"force_sword_grip_02|force_sword_grip_05", _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .0025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_force_sword_grips, _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- Sabre grips - 2H power sword blade
                    {dependencies = {"sabre_grip_04", _2h_power_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {"sabre_grip_05", _2h_power_sword_blades},
                        blade = {parent = "grip", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                --#endregion
                --#region Force sword blades
                    -- Power sword grips - Force sword blade
                    {dependencies = {_power_sword_grips, _force_sword_blades, _force_sword_hilts},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_power_sword_grips, _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .0775), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- 2H Power sword grips - Force sword blade
                    {dependencies = {"power_sword_2h_grip_02", _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_2h_power_sword_grips, _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- Force sword grips - Force sword blade
                    {dependencies = {"force_sword_grip_01|force_sword_grip_06", _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .014), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {"force_sword_grip_02|force_sword_grip_05", _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .0025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {_force_sword_grips, _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    -- Sabre grips - 2H power sword blade
                    {dependencies = {"sabre_grip_04", _force_sword_blades},
                        blade = {parent = "hilt", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                        hilt = {parent = "grip", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                    {dependencies = {"sabre_grip_05", _force_sword_blades},
                        blade = {parent = "grip", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                --#endregion

                -- {dependencies = {_2h_power_sword_blades, _force_sword_blades, _sabre_blades, _falchion_blades, _combat_sword_blades},
                --     blade = {parent = "hilt", position = vector3_box(0, 0, -.01), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                -- {dependencies = {_sabre_grips, _falchion_grips, _combat_sword_grips},
                --     blade = {parent = "grip", position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"knife_grip_05"},
                    blade = {parent = "grip", position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {_knife_grips},
                    blade = {parent = "hilt", position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    hilt = {parent = "grip", position = vector3_box(0, 0, .04), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},

                -- {dependencies = {"power_sword_2h_grip_01|power_sword_2h_grip_03", _power_sword_blades},
                --     blade = {parent = "grip", position = vector3_box(0, 0, -.01), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- {dependencies = {"power_sword_2h_grip_02", _power_sword_blades},
                --     blade = {parent = "grip", position = vector3_box(0, 0, -.04), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        }
    }
)