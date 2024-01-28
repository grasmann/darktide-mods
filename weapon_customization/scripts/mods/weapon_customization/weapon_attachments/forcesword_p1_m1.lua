local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_melee = _item.."/melee"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local string_gsub = string.gsub
    local vector3_box = Vector3Box
    local table = table
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local functions = {
    grip_attachments = function(default)
        local attachments = {
            {id = "force_sword_grip_01",      name = "Grip 1"},
            {id = "force_sword_grip_02",      name = "Grip 2"},
            {id = "force_sword_grip_03",      name = "Grip 3"},
            {id = "force_sword_grip_04",      name = "Grip 4"},
            {id = "force_sword_grip_05",      name = "Grip 5"},
            {id = "force_sword_grip_06",      name = "Grip 6"},
            {id = "force_sword_grip_07",      name = "Grip 7"},
            {id = "force_sword_grip_08",      name = "Grip 8"},
            {id = "force_sword_grip_09",      name = "Grip 9"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_grip_default", model = ""},
            {name = "force_sword_grip_01",      model = _item_melee.."/grips/force_sword_grip_01"},
            {name = "force_sword_grip_02",      model = _item_melee.."/grips/force_sword_grip_02"},
            {name = "force_sword_grip_03",      model = _item_melee.."/grips/force_sword_grip_03"},
            {name = "force_sword_grip_04",      model = _item_melee.."/grips/force_sword_grip_04"},
            {name = "force_sword_grip_05",      model = _item_melee.."/grips/force_sword_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    blade_attachments = function(default)
        local attachments = {
            {id = "force_sword_blade_01",      name = "Blade 1"},
            {id = "force_sword_blade_02",      name = "Blade 2"},
            {id = "force_sword_blade_03",      name = "Blade 3"},
            {id = "force_sword_blade_04",      name = "Blade 4"},
            {id = "force_sword_blade_05",      name = "Blade 5"},
            {id = "force_sword_blade_06",      name = "Blade 6"},
            {id = "force_sword_blade_07",      name = "Blade 7"},
            {id = "force_sword_blade_08",      name = "Blade 8"},
            {id = "force_sword_blade_09",      name = "Blade 9"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_blade_default", model = ""},
            {name = "force_sword_blade_01",      model = _item_melee.."/blades/force_sword_blade_01"},
            {name = "force_sword_blade_02",      model = _item_melee.."/blades/force_sword_blade_02"},
            {name = "force_sword_blade_03",      model = _item_melee.."/blades/force_sword_blade_03"},
            {name = "force_sword_blade_04",      model = _item_melee.."/blades/force_sword_blade_04"},
            {name = "force_sword_blade_05",      model = _item_melee.."/blades/force_sword_blade_05"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "force_sword_pommel_01",      name = "Pommel 1"},
            {id = "force_sword_pommel_02",      name = "Pommel 2"},
            {id = "force_sword_pommel_03",      name = "Pommel 3"},
            {id = "force_sword_pommel_04",      name = "Pommel 4"},
            {id = "force_sword_pommel_05",      name = "Pommel 5"},
            {id = "force_sword_pommel_06",      name = "Pommel 6"},
            {id = "force_sword_pommel_07",      name = "Pommel 7"},
            {id = "force_sword_pommel_08",      name = "Pommel 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_pommel_default", model = ""},
            {name = "force_sword_pommel_01",      model = _item_melee.."/pommels/force_sword_pommel_01"},
            {name = "force_sword_pommel_02",      model = _item_melee.."/pommels/force_sword_pommel_02"},
            {name = "force_sword_pommel_03",      model = _item_melee.."/pommels/force_sword_pommel_03"},
            {name = "force_sword_pommel_04",      model = _item_melee.."/pommels/force_sword_pommel_04"},
            {name = "force_sword_pommel_05",      model = _item_melee.."/pommels/force_sword_pommel_05"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    hilt_attachments = function(default)
        local attachments = {
            {id = "force_sword_hilt_01",      name = "Hilt 1"},
            {id = "force_sword_hilt_02",      name = "Hilt 2"},
            {id = "force_sword_hilt_03",      name = "Hilt 3"},
            {id = "force_sword_hilt_04",      name = "Hilt 4"},
            {id = "force_sword_hilt_05",      name = "Hilt 5"},
            {id = "force_sword_hilt_06",      name = "Hilt 6"},
            {id = "force_sword_hilt_07",      name = "Hilt 7"},
            {id = "force_sword_hilt_08",      name = "Hilt 8"},
            {id = "force_sword_hilt_09",      name = "Hilt 9"},
            {id = "force_sword_hilt_07",      name = "Hilt 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_hilt_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    hilt_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_hilt_default", model = ""},
            {name = "force_sword_hilt_01",      model = _item_melee.."/hilts/force_sword_hilt_01"},
            {name = "force_sword_hilt_02",      model = _item_melee.."/hilts/force_sword_hilt_02"},
            {name = "force_sword_hilt_03",      model = _item_melee.."/hilts/force_sword_hilt_03"},
            {name = "force_sword_hilt_04",      model = _item_melee.."/hilts/force_sword_hilt_04"},
            {name = "force_sword_hilt_05",      model = _item_melee.."/hilts/force_sword_hilt_05"},
            {name = "force_sword_hilt_06",      model = _item_melee.."/hilts/force_sword_hilt_06"},
            {name = "force_sword_hilt_07",      model = _item_melee.."/hilts/force_sword_hilt_07"},
        }, parent, angle, move, remove, type or "hilt", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}

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

local _2h_power_sword_pommels = "power_sword_2h_pommel_01|power_sword_2h_pommel_02|power_sword_2h_pommel_03"
local _power_sword_pommels = "power_sword_pommel_01|power_sword_pommel_02|power_sword_pommel_03|power_sword_pommel_04|power_sword_pommel_05"
local _power_sword_pommels_2_5 = string_gsub(_power_sword_pommels, "power_sword_pommel_01|", "")
local _force_sword_pommels = "force_sword_pommel_01|force_sword_pommel_02|force_sword_pommel_03|force_sword_pommel_04|force_sword_pommel_05"

return table.combine(
    functions,
    {
        --#region Old
            -- attachments = {
            --     -- Native
            --     grip = functions.grip_attachments(),
            --     pommel = functions.pommel_attachments(),
            --     hilt = functions.hilt_attachments(),
            --     blade = functions.blade_attachments(),
            --     -- Common
            --     trinket_hook = _common.trinket_hook_attachments(),
            --     emblem_right = _common.emblem_right_attachments(),
            --     emblem_left = _common.emblem_left_attachments(),
            -- },
            -- models = table.combine(
            --     -- {customization_default_position = vector3_box(0, 3, .35)},
            --     _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            --     _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            --     _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            --     functions.grip_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            --     functions.hilt_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            --     functions.blade_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            --     functions.pommel_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2))
            -- ),
        --#endregion
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- grip = functions.grip_attachments(),
            grip = _common_melee.sword_grip_attachments(),
            -- pommel = functions.pommel_attachments(),
            pommel = _common_melee.pommel_attachments(),
            -- blade = functions.blade_attachments(),
            blade = _common_melee.sword_blade_attachments(),
            -- hilt = functions.hilt_attachments(),
            hilt = _common_melee.sword_hilt_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("blade", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("blade", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            -- functions.hilt_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .1)),
            _common_melee.sword_hilt_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .1)),
            -- functions.grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.sword_grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0), "grip", {
                -- No support
                {},
                -- Power Sword
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                -- 2H Power Sword
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                -- Force Sword
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                {"pommel_none"},
                -- Sabre
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt_none"},
                {"pommel", "hilt"},
                -- Falchion
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                -- Combat Sword
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                {"pommel", "hilt"},
                -- Knife
                {"pommel"},
                {"pommel"},
                {"pommel"},
                {"pommel"},
                {"pommel", "hilt"},
                {"pommel"},
                {"pommel"},
            }, {
                -- Automatic equip
                {},
                -- Power Sword
                {pommel = "pommel_none|power_sword_pommel_01"},
                {pommel = "pommel_none|power_sword_pommel_02"},
                {pommel = "pommel_none|power_sword_pommel_03"},
                {pommel = "pommel_none|power_sword_pommel_04"},
                {pommel = "pommel_none|power_sword_pommel_05"},
                {pommel = "pommel_none|power_sword_pommel_05"},
                -- 2H Power Sword
                {pommel = "pommel_none|power_sword_2h_pommel_01"},
                {pommel = "pommel_none|power_sword_2h_pommel_02"},
                {pommel = "pommel_none|power_sword_2h_pommel_03"},
                -- Force Sword
                {pommel = "pommel_none|force_sword_pommel_01"},
                {pommel = "pommel_none|force_sword_pommel_02"},
                {pommel = "pommel_none|force_sword_pommel_03"},
                {pommel = "pommel_none|force_sword_pommel_04"},
                {pommel = "pommel_none|force_sword_pommel_05"},
                {pommel = "pommel_none|force_sword_pommel_05"},
                -- Sabre
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                -- Falchion
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                -- Combat Sword
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                -- Knife
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "!hilt_none|hilt_none"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
                {pommel = "!pommel_none|pommel_none", hilt = "hilt_none|hilt_default"},
            }),
            -- functions.blade_models("hilt", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_melee.sword_blade_models("hilt", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2), "blade", {
                -- No support
                {},
                -- Power Sword
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                -- 2H Power Sword
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                -- Force Sword
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                -- Sabre
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                -- Falchion
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                -- Combat Sword
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
                {"hilt_default"},
            }, {
                -- Automatic equip
                {},
                -- Power Sword
                {hilt = "hilt_default|power_sword_hilt_01"},
                {hilt = "hilt_default|power_sword_hilt_01"},
                {hilt = "hilt_default|power_sword_hilt_01"},
                {hilt = "hilt_default|power_sword_hilt_01"},
                {hilt = "hilt_default|power_sword_hilt_01"},
                -- 2H Power Sword
                {hilt = "hilt_default|power_sword_2h_hilt_01"},
                {hilt = "hilt_default|power_sword_2h_hilt_02"},
                {hilt = "hilt_default|power_sword_2h_hilt_03"},
                -- Force Sword
                {hilt = "hilt_default|force_sword_hilt_01"},
                {hilt = "hilt_default|force_sword_hilt_02"},
                {hilt = "hilt_default|force_sword_hilt_03"},
                {hilt = "hilt_default|force_sword_hilt_04"},
                {hilt = "hilt_default|force_sword_hilt_05"},
                {hilt = "hilt_default|force_sword_hilt_06"},
                -- Sabre
                {hilt = "hilt_default|force_sword_hilt_01"},
                {hilt = "hilt_default|force_sword_hilt_02"},
                {hilt = "hilt_default|force_sword_hilt_03"},
                {hilt = "hilt_default|force_sword_hilt_04"},
                {hilt = "hilt_default|force_sword_hilt_05"},
                -- Falchion
                {hilt = "hilt_default|force_sword_hilt_01"},
                {hilt = "hilt_default|force_sword_hilt_02"},
                {hilt = "hilt_default|force_sword_hilt_03"},
                {hilt = "hilt_default|force_sword_hilt_04"},
                {hilt = "hilt_default|force_sword_hilt_05"},
                -- Combat Sword
                {hilt = "hilt_default|force_sword_hilt_01"},
                {hilt = "hilt_default|force_sword_hilt_02"},
                {hilt = "hilt_default|force_sword_hilt_03"},
                {hilt = "hilt_default|force_sword_hilt_04"},
                {hilt = "hilt_default|force_sword_hilt_05"},
                {hilt = "hilt_default|force_sword_hilt_06"},
                {hilt = "hilt_default|force_sword_hilt_07"},
            }),
            -- functions.pommel_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.1))
            _common_melee.pommel_models("grip", 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.1))
        ),
        anchors = {
            fixes = {
                -- -- Bigger knife handles
                -- {dependencies = {"knife_grip_06"},
                --     grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale_node = 1, scale = vector3_box(1.5, 1.5, 1.5)}},
                -- {dependencies = {_knife_grips},
                --     grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale_node = 1, scale = vector3_box(1.5, 1.5, 1.5)}},
                -- -- No hilt
                -- {dependencies = {_sabre_grips, _falchion_grips, _combat_sword_grips, "knife_grip_05"},
                --     hilt = {parent = "grip", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},

                --#region Power sword pommels
                    {dependencies = {"power_sword_grip_01", _power_sword_pommels_2_5.."|".._2h_power_sword_pommels.."|".._force_sword_pommels},
                        pommel = {offset = true, position = vector3_box(0, 0, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                --#endregion

                -- --#region Hilts
                --     {dependencies = {"power_sword_2h_grip_02"},
                --         hilt = {parent = "grip", position = vector3_box(0, 0, -.015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- --#endregion

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
        },
    }
)