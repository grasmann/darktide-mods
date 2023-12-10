local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local vector3_box = Vector3Box
    local table = table
    local tv = table.tv
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

-- staff_shaft_lower_attachments = function()
--     return {
--         {id = "shaft_lower_default", name = mod:localize("mod_attachment_default")},
--         {id = "shaft_lower_01",      name = "Lower Shaft 1"},
--         {id = "shaft_lower_02",      name = "Lower Shaft 2"},
--         {id = "shaft_lower_03",      name = "Lower Shaft 3"},
--         {id = "shaft_lower_04",      name = "Lower Shaft 4"},
--         {id = "shaft_lower_05",      name = "Lower Shaft 5"},
--     }
-- end,
-- staff_shaft_lower_models = function(parent, angle, move, remove)
--     local a = angle or 0
--     local m = move or vector3_box(0, 0, 0)
--     local r = remove or vector3_box(0, 0, 0)
--     return {
--         shaft_lower_default = {model = "",                                                 type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--         shaft_lower_01 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_01", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--         shaft_lower_02 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_02", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--         shaft_lower_03 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_03", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--         shaft_lower_04 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_04", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--         shaft_lower_05 =      {model = _item_ranged.."/shafts/force_staff_shaft_lower_05", type = "shaft_lower", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
--     }
-- end,

return {
    long_shaft_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_shaft_01",      name = "Thunderhammer 1"},
            {id = "thunder_hammer_shaft_02",      name = "Thunderhammer 2"},
            {id = "thunder_hammer_shaft_03",      name = "Thunderhammer 3"},
            {id = "thunder_hammer_shaft_04",      name = "Thunderhammer 4"},
            {id = "thunder_hammer_shaft_05",      name = "Thunderhammer 5"},
            {id = "shaft_lower_01",      name = "Staff 1"},
            {id = "shaft_lower_02",      name = "Staff 2"},
            {id = "shaft_lower_03",      name = "Staff 3"},
            {id = "shaft_lower_04",      name = "Staff 4"},
            {id = "shaft_lower_05",      name = "Staff 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    long_shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default", model = ""},
            {name = "thunder_hammer_shaft_01",      model = _item_ranged.."/shafts/thunder_hammer_shaft_01"},
            {name = "thunder_hammer_shaft_02",      model = _item_ranged.."/shafts/thunder_hammer_shaft_02"},
            {name = "thunder_hammer_shaft_03",      model = _item_ranged.."/shafts/thunder_hammer_shaft_03"},
            {name = "thunder_hammer_shaft_04",      model = _item_ranged.."/shafts/thunder_hammer_shaft_04"},
            {name = "thunder_hammer_shaft_05",      model = _item_ranged.."/shafts/thunder_hammer_shaft_05"},
            {name = "shaft_lower_01",      model = _item_ranged.."/shafts/force_staff_shaft_lower_01"},
            {name = "shaft_lower_02",      model = _item_ranged.."/shafts/force_staff_shaft_lower_02"},
            {name = "shaft_lower_03",      model = _item_ranged.."/shafts/force_staff_shaft_lower_03"},
            {name = "shaft_lower_04",      model = _item_ranged.."/shafts/force_staff_shaft_lower_04"},
            {name = "shaft_lower_05",      model = _item_ranged.."/shafts/force_staff_shaft_lower_05"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_connector_01",      name = "Thunderhammer 1"},
            {id = "thunder_hammer_connector_02",      name = "Thunderhammer 2"},
            {id = "thunder_hammer_connector_03",      name = "Thunderhammer 3"},
            {id = "thunder_hammer_connector_04",      name = "Thunderhammer 4"},
            {id = "thunder_hammer_connector_05",      name = "Thunderhammer 5"},
            {id = "body_01",      name = "Force Staff 1"},
            {id = "body_02",      name = "Force Staff 2"},
            {id = "body_03",      name = "Force Staff 3"},
            {id = "body_04",      name = "Force Staff 4"},
            {id = "body_05",      name = "Force Staff 5"},
            {id = "2h_power_maul_connector_01",      name = "Power Maul 1"},
            {id = "2h_power_maul_connector_02",      name = "Power Maul 2"},
            {id = "2h_power_maul_connector_03",      name = "Power Maul 3"},
            {id = "2h_power_maul_connector_04",      name = "Power Maul 4"},
            {id = "2h_power_maul_connector_05",      name = "Power Maul 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "connector_default", model = ""},
            {name = "thunder_hammer_connector_01",      model = _item_melee.."/connectors/thunder_hammer_connector_01"},
            {name = "thunder_hammer_connector_02",      model = _item_melee.."/connectors/thunder_hammer_connector_02"},
            {name = "thunder_hammer_connector_03",      model = _item_melee.."/connectors/thunder_hammer_connector_03"},
            {name = "thunder_hammer_connector_04",      model = _item_melee.."/connectors/thunder_hammer_connector_04"},
            {name = "thunder_hammer_connector_05",      model = _item_melee.."/connectors/thunder_hammer_connector_05"},
            {name = "body_01",      model = _item_melee.."/full/force_staff_full_01"},
            {name = "body_02",      model = _item_melee.."/full/force_staff_full_02"},
            {name = "body_03",      model = _item_melee.."/full/force_staff_full_03"},
            {name = "body_04",      model = _item_melee.."/full/force_staff_full_04"},
            {name = "body_05",      model = _item_melee.."/full/force_staff_full_05"},
            {name = "2h_power_maul_connector_01",      model = _item_melee.."/connectors/2h_power_maul_connector_01"},
            {name = "2h_power_maul_connector_02",      model = _item_melee.."/connectors/2h_power_maul_connector_02"},
            {name = "2h_power_maul_connector_03",      model = _item_melee.."/connectors/2h_power_maul_connector_03"},
            {name = "2h_power_maul_connector_04",      model = _item_melee.."/connectors/2h_power_maul_connector_04"},
            {name = "2h_power_maul_connector_05",      model = _item_melee.."/connectors/2h_power_maul_connector_05"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,


    emblem_right_attachments = function()
        return {
            {id = "emblem_right_default", name = mod:localize("mod_attachment_default")},
            {id = "emblem_right_01", name = "Emblem 1"},
            {id = "emblem_right_02", name = "Emblem 2"},
            {id = "emblem_right_03", name = "Emblem 3"},
            {id = "emblem_right_04", name = "Emblem 4"},
            {id = "emblem_right_05", name = "Emblem 5"},
            {id = "emblem_right_06", name = "Emblem 6"},
            {id = "emblem_right_07", name = "Emblem 7"},
            {id = "emblem_right_08", name = "Emblem 8"},
            {id = "emblem_right_09", name = "Emblem 9"},
            {id = "emblem_right_10", name = "Emblem 10"},
            {id = "emblem_right_11", name = "Emblem 11"},
            {id = "emblem_right_12", name = "Emblem 12"},
            {id = "emblem_right_13", name = "Emblem 13"},
            {id = "emblem_right_14", name = "Emblem 14"},
            {id = "emblem_right_15", name = "Emblem 15"},
            {id = "emblem_right_16", name = "Emblem 16"},
            {id = "emblem_right_17", name = "Emblem 17"},
            {id = "emblem_right_18", name = "Emblem 18"},
            {id = "emblem_right_19", name = "Emblem 19"},
            {id = "emblem_right_20", name = "Emblem 20"},
            {id = "emblem_right_21", name = "Emblem 21"},
            {id = "emblem_right_22", name = "Emblem 22"},
        }
    end,
    emblem_right_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            emblem_right_default = {model = "",                                       type = "emblem_right", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_01 =      {model = _item_ranged.."/emblems/emblemright_01",  type = "emblem_right", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_02 =      {model = _item_ranged.."/emblems/emblemright_02",  type = "emblem_right", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_03 =      {model = _item_ranged.."/emblems/emblemright_03",  type = "emblem_right", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_04 =      {model = _item_ranged.."/emblems/emblemright_04a", type = "emblem_right", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_05 =      {model = _item_ranged.."/emblems/emblemright_04b", type = "emblem_right", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_06 =      {model = _item_ranged.."/emblems/emblemright_04c", type = "emblem_right", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_07 =      {model = _item_ranged.."/emblems/emblemright_04d", type = "emblem_right", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_08 =      {model = _item_ranged.."/emblems/emblemright_04e", type = "emblem_right", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_09 =      {model = _item_ranged.."/emblems/emblemright_04f", type = "emblem_right", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_10 =      {model = _item_ranged.."/emblems/emblemright_05",  type = "emblem_right", parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_11 =      {model = _item_ranged.."/emblems/emblemright_06",  type = "emblem_right", parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_12 =      {model = _item_ranged.."/emblems/emblemright_07",  type = "emblem_right", parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_13 =      {model = _item_ranged.."/emblems/emblemright_08a", type = "emblem_right", parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_14 =      {model = _item_ranged.."/emblems/emblemright_08b", type = "emblem_right", parent = tv(parent, 15), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_15 =      {model = _item_ranged.."/emblems/emblemright_08c", type = "emblem_right", parent = tv(parent, 16), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_16 =      {model = _item_ranged.."/emblems/emblemright_09a", type = "emblem_right", parent = tv(parent, 17), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_17 =      {model = _item_ranged.."/emblems/emblemright_09b", type = "emblem_right", parent = tv(parent, 18), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_18 =      {model = _item_ranged.."/emblems/emblemright_09c", type = "emblem_right", parent = tv(parent, 19), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_19 =      {model = _item_ranged.."/emblems/emblemright_09d", type = "emblem_right", parent = tv(parent, 20), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_20 =      {model = _item_ranged.."/emblems/emblemright_09e", type = "emblem_right", parent = tv(parent, 21), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_21 =      {model = _item_ranged.."/emblems/emblemright_10",  type = "emblem_right", parent = tv(parent, 22), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_22 =      {model = _item_ranged.."/emblems/emblemright_11",  type = "emblem_right", parent = tv(parent, 23), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    emblem_left_attachments = function()
        return {
            {id = "emblem_left_default", name = mod:localize("mod_attachment_default")},
            {id = "emblem_left_01", name = "Emblem 1"},
            {id = "emblem_left_02", name = "Emblem 2"},
            {id = "emblem_left_03", name = "Emblem 3"},
            {id = "emblem_left_04", name = "Emblem 4"},
            {id = "emblem_left_05", name = "Emblem 5"},
            {id = "emblem_left_06", name = "Emblem 6"},
            {id = "emblem_left_07", name = "Emblem 7"},
            {id = "emblem_left_08", name = "Emblem 8"},
            {id = "emblem_left_09", name = "Emblem 9"},
            {id = "emblem_left_10", name = "Emblem 10"},
            {id = "emblem_left_11", name = "Emblem 11"},
            {id = "emblem_left_12", name = "Emblem 12"},
            {id = "emblem_left_13", name = "Emblem 13"},
        }
    end,
    emblem_left_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            emblem_left_default = {model = "",                                      type = "emblem_left", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_01 =      {model = _item_ranged.."/emblems/emblemleft_01",  type = "emblem_left", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_02 =      {model = _item_ranged.."/emblems/emblemleft_02",  type = "emblem_left", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_03 =      {model = _item_ranged.."/emblems/emblemleft_03",  type = "emblem_left", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_04 =      {model = _item_ranged.."/emblems/emblemleft_04a", type = "emblem_left", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_05 =      {model = _item_ranged.."/emblems/emblemleft_04b", type = "emblem_left", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_06 =      {model = _item_ranged.."/emblems/emblemleft_04c", type = "emblem_left", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_07 =      {model = _item_ranged.."/emblems/emblemleft_04d", type = "emblem_left", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_08 =      {model = _item_ranged.."/emblems/emblemleft_04e", type = "emblem_left", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_09 =      {model = _item_ranged.."/emblems/emblemleft_04f", type = "emblem_left", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_10 =      {model = _item_ranged.."/emblems/emblemleft_05",  type = "emblem_left", parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_11 =      {model = _item_ranged.."/emblems/emblemleft_06",  type = "emblem_left", parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_12 =      {model = _item_ranged.."/emblems/emblemleft_10",  type = "emblem_left", parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_13 =      {model = _item_ranged.."/emblems/emblemleft_11",  type = "emblem_left", parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    decal_right_attachments = function()
        return {
            {id = "decal_right_default", name = mod:localize("mod_attachment_default")},
            {id = "decal_right_01", name = "Decal 1"},
            {id = "decal_right_02", name = "Decal 2"},
            {id = "decal_right_03", name = "Decal 3"},
        }
    end,
    decal_right_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            decal_right_default = {model = "",                                     type = "decal_right", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            decal_right_01 =      {model = _item_ranged.."/decals/decalright_01",  type = "decal_right", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            decal_right_02 =      {model = _item_ranged.."/decals/decalright_02",  type = "decal_right", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            decal_right_03 =      {model = _item_ranged.."/decals/decalright_03",  type = "decal_right", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    decal_left_attachments = function()
        return {
            {id = "decal_left_default", name = mod:localize("mod_attachment_default")},
            {id = "decal_left_01", name = "Decal 1"},
            {id = "decal_left_02", name = "Decal 2"},
            {id = "decal_left_03", name = "Decal 3"},
        }
    end,
    decal_left_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            decal_left_default = {model = "",                                    type = "decal_left", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            decal_left_01 =      {model = _item_ranged.."/decals/decalleft_01",  type = "decal_left", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            decal_left_02 =      {model = _item_ranged.."/decals/decalleft_02",  type = "decal_left", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            decal_left_03 =      {model = _item_ranged.."/decals/decalleft_03",  type = "decal_left", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    trinket_hook_attachments = function()
        return {
            {id = "trinket_hook_default",       name = mod:localize("mod_attachment_default")},
            {id = "trinket_hook_empty",         name = "No Trinket Hook"},
            {id = "trinket_hook_01",            name = "Trinket Hook 1"},
            {id = "trinket_hook_01_v",          name = "Trinket Hook 1 V"},
            {id = "trinket_hook_02",            name = "Trinket Hook 2"},
            {id = "trinket_hook_02_45",         name = "Trinket Hook 2 45"},
            {id = "trinket_hook_02_90",         name = "Trinket Hook 2 90"},
            {id = "trinket_hook_03",            name = "Trinket Hook 3"},
            {id = "trinket_hook_03_v",          name = "Trinket Hook 3 V"},
            {id = "trinket_hook_04_steel",      name = "Trinket Hook 4 Steel"},
            {id = "trinket_hook_04_steel_v",    name = "Trinket Hook 4 Steel V"},
            {id = "trinket_hook_04_coated",     name = "Trinket Hook 4 Coated"},
            {id = "trinket_hook_04_coated_v",   name = "Trinket Hook 4 Coated V"},
            {id = "trinket_hook_04_carbon",     name = "Trinket Hook 4 Carbon"},
            {id = "trinket_hook_04_carbon_v",   name = "Trinket Hook 4 Carbon V"},
            {id = "trinket_hook_04_gold",       name = "Trinket Hook 4 Gold"},
            {id = "trinket_hook_04_gold_v",     name = "Trinket Hook 4 Gold V"},
            {id = "trinket_hook_05_steel",      name = "Trinket Hook 5 Steel"},
            {id = "trinket_hook_05_steel_v",    name = "Trinket Hook 5 Steel V"},
            {id = "trinket_hook_05_coated",     name = "Trinket Hook 5 Coated"},
            {id = "trinket_hook_05_coated_v",   name = "Trinket Hook 5 Coated V"},
            {id = "trinket_hook_05_carbon",     name = "Trinket Hook 5 Carbon"},
            {id = "trinket_hook_05_carbon_v",   name = "Trinket Hook 5 Carbon V"},
            {id = "trinket_hook_05_gold",       name = "Trinket Hook 5 Gold"},
            {id = "trinket_hook_05_gold_v",     name = "Trinket Hook 5 Gold V"},
        }
    end,
    trinket_hook_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            trinket_hook_default =     {model = "",                                          type = "trinket_hook", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false},
            trinket_hook_02_90 =       {model = _item.."/trinkets/trinket_hook_02_90",       type = "trinket_hook", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = false},
            trinket_hook_01_v =        {model = _item.."/trinkets/trinket_hook_01_v",        type = "trinket_hook", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = false},
            trinket_hook_04_gold_v =   {model = _item.."/trinkets/trinket_hook_04_gold_v",   type = "trinket_hook", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = false},
            trinket_hook_02 =          {model = _item.."/trinkets/trinket_hook_02",          type = "trinket_hook", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), mesh_move = false},
            trinket_hook_03 =          {model = _item.."/trinkets/trinket_hook_03",          type = "trinket_hook", parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6), mesh_move = false},
            trinket_hook_04_steel_v =  {model = _item.."/trinkets/trinket_hook_04_steel_v",  type = "trinket_hook", parent = tv(parent, 7), angle = a, move = m, remove = tv(r, 7), mesh_move = false},
            trinket_hook_04_carbon =   {model = _item.."/trinkets/trinket_hook_04_carbon",   type = "trinket_hook", parent = tv(parent, 8), angle = a, move = m, remove = tv(r, 8), mesh_move = false},
            trinket_hook_04_gold =     {model = _item.."/trinkets/trinket_hook_04_gold",     type = "trinket_hook", parent = tv(parent, 9), angle = a, move = m, remove = tv(r, 9), mesh_move = false},
            trinket_hook_04_carbon_v = {model = _item.."/trinkets/trinket_hook_04_carbon_v", type = "trinket_hook", parent = tv(parent, 10), angle = a, move = m, remove = tv(r, 10), mesh_move = false},
            trinket_hook_04_coated =   {model = _item.."/trinkets/trinket_hook_04_coated",   type = "trinket_hook", parent = tv(parent, 11), angle = a, move = m, remove = tv(r, 11), mesh_move = false},
            trinket_hook_01 =          {model = _item.."/trinkets/trinket_hook_01",          type = "trinket_hook", parent = tv(parent, 12), angle = a, move = m, remove = tv(r, 12), mesh_move = false},
            trinket_hook_04_steel =    {model = _item.."/trinkets/trinket_hook_04_steel",    type = "trinket_hook", parent = tv(parent, 13), angle = a, move = m, remove = tv(r, 13), mesh_move = false},
            trinket_hook_02_45 =       {model = _item.."/trinkets/trinket_hook_02_45",       type = "trinket_hook", parent = tv(parent, 14), angle = a, move = m, remove = tv(r, 14), mesh_move = false},
            trinket_hook_empty =       {model = _item.."/trinkets/trinket_hook_empty",       type = "trinket_hook", parent = tv(parent, 15), angle = a, move = m, remove = tv(r, 15), mesh_move = false, no_animation = true},
            trinket_hook_05_gold =     {model = _item.."/trinkets/trinket_hook_05_gold",     type = "trinket_hook", parent = tv(parent, 16), angle = a, move = m, remove = tv(r, 16), mesh_move = false},
            trinket_hook_05_carbon =   {model = _item.."/trinkets/trinket_hook_05_carbon",   type = "trinket_hook", parent = tv(parent, 17), angle = a, move = m, remove = tv(r, 17), mesh_move = false},
            trinket_hook_05_coated_v = {model = _item.."/trinkets/trinket_hook_05_coated_v", type = "trinket_hook", parent = tv(parent, 18), angle = a, move = m, remove = tv(r, 18), mesh_move = false},
            trinket_hook_05_gold_v =   {model = _item.."/trinkets/trinket_hook_05_gold_v",   type = "trinket_hook", parent = tv(parent, 19), angle = a, move = m, remove = tv(r, 19), mesh_move = false},
            trinket_hook_05_steel_v =  {model = _item.."/trinkets/trinket_hook_05_steel_v",  type = "trinket_hook", parent = tv(parent, 20), angle = a, move = m, remove = tv(r, 20), mesh_move = false},
            trinket_hook_05_coated =   {model = _item.."/trinkets/trinket_hook_05_coated",   type = "trinket_hook", parent = tv(parent, 21), angle = a, move = m, remove = tv(r, 21), mesh_move = false},
            trinket_hook_05_carbon_v = {model = _item.."/trinkets/trinket_hook_05_carbon_v", type = "trinket_hook", parent = tv(parent, 22), angle = a, move = m, remove = tv(r, 22), mesh_move = false},
            trinket_hook_03_v =        {model = _item.."/trinkets/trinket_hook_03_v",        type = "trinket_hook", parent = tv(parent, 23), angle = a, move = m, remove = tv(r, 23), mesh_move = false},
            trinket_hook_05_steel =    {model = _item.."/trinkets/trinket_hook_05_steel",    type = "trinket_hook", parent = tv(parent, 24), angle = a, move = m, remove = tv(r, 24), mesh_move = false},
            trinket_hook_04_coated_v = {model = _item.."/trinkets/trinket_hook_04_coated_v", type = "trinket_hook", parent = tv(parent, 25), angle = a, move = m, remove = tv(r, 25), mesh_move = false},
        }
    end,
    slot_trinket_1_attachments = function()
        return {
            {id = "slot_trinket_1", name = mod:localize("mod_attachment_default")},
        }
    end,
    slot_trinket_1_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_1 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_1", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
    slot_trinket_2_attachments = function()
        return {
            {id = "slot_trinket_2", name = mod:localize("mod_attachment_default")},
        }
    end,
    slot_trinket_2_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_2 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_2", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
}