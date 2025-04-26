local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

return {
    long_shaft_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_shaft_01", name = "Thunderhammer 1"},
            {id = "thunder_hammer_shaft_02", name = "Thunderhammer 2"},
            {id = "thunder_hammer_shaft_03", name = "Thunderhammer 3"},
            {id = "thunder_hammer_shaft_04", name = "Thunderhammer 4"},
            {id = "thunder_hammer_shaft_05", name = "Thunderhammer 5"},
            {id = "shaft_lower_01",          name = "Staff 1"},
            {id = "shaft_lower_02",          name = "Staff 2"},
            {id = "shaft_lower_03",          name = "Staff 3"},
            {id = "shaft_lower_04",          name = "Staff 4"},
            {id = "shaft_lower_05",          name = "Staff 5"},
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
            {name = "thunder_hammer_shaft_01", model = _item_ranged.."/shafts/thunder_hammer_shaft_01"},
            {name = "thunder_hammer_shaft_02", model = _item_ranged.."/shafts/thunder_hammer_shaft_02"},
            {name = "thunder_hammer_shaft_03", model = _item_ranged.."/shafts/thunder_hammer_shaft_03"},
            {name = "thunder_hammer_shaft_04", model = _item_ranged.."/shafts/thunder_hammer_shaft_04"},
            {name = "thunder_hammer_shaft_05", model = _item_ranged.."/shafts/thunder_hammer_shaft_05"},
            {name = "shaft_lower_01",          model = _item_ranged.."/shafts/force_staff_shaft_lower_01"},
            {name = "shaft_lower_02",          model = _item_ranged.."/shafts/force_staff_shaft_lower_02"},
            {name = "shaft_lower_03",          model = _item_ranged.."/shafts/force_staff_shaft_lower_03"},
            {name = "shaft_lower_04",          model = _item_ranged.."/shafts/force_staff_shaft_lower_04"},
            {name = "shaft_lower_05",          model = _item_ranged.."/shafts/force_staff_shaft_lower_05"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default) -- Last update 1.5.4
        local attachments = {
            {id = "thunder_hammer_connector_01",   name = "Thunderhammer 1"},
            {id = "thunder_hammer_connector_02",   name = "Thunderhammer 2"},
            {id = "thunder_hammer_connector_03",   name = "Thunderhammer 3"},
            {id = "thunder_hammer_connector_04",   name = "Thunderhammer 4"},
            {id = "thunder_hammer_connector_05",   name = "Thunderhammer 5"},
            {id = "thunder_hammer_connector_ml01", name = "Thunderhammer ML01"},
            {id = "thunder_hammer_connector_06",   name = "Thunderhammer 6"},
            {id = "force_staff_full_01",           name = "Force Staff 1"},
            {id = "force_staff_full_02",           name = "Force Staff 2"},
            {id = "force_staff_full_03",           name = "Force Staff 3"},
            {id = "force_staff_full_04",           name = "Force Staff 4"},
            {id = "force_staff_full_05",           name = "Force Staff 5"},
            {id = "force_staff_full_ml01",         name = "Force Staff ML01"},
            {id = "2h_power_maul_connector_01",    name = "Power Maul 1"},
            {id = "2h_power_maul_connector_02",    name = "Power Maul 2"},
            {id = "2h_power_maul_connector_03",    name = "Power Maul 3"},
            {id = "2h_power_maul_connector_04",    name = "Power Maul 4"},
            {id = "2h_power_maul_connector_05",    name = "Power Maul 5"},
            {id = "2h_power_maul_connector_ml01",  name = "Power Maul ML01"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve) -- Last update 1.5.4
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "connector_default", model = ""},
            {name = "thunder_hammer_connector_01",   model = _item_melee.."/connectors/thunder_hammer_connector_01"},
            {name = "thunder_hammer_connector_02",   model = _item_melee.."/connectors/thunder_hammer_connector_02"},
            {name = "thunder_hammer_connector_03",   model = _item_melee.."/connectors/thunder_hammer_connector_03"},
            {name = "thunder_hammer_connector_04",   model = _item_melee.."/connectors/thunder_hammer_connector_04"},
            {name = "thunder_hammer_connector_05",   model = _item_melee.."/connectors/thunder_hammer_connector_05"},
            {name = "thunder_hammer_connector_ml01", model = _item_melee.."/connectors/thunder_hammer_connector_ml01"},
            {name = "thunder_hammer_connector_06",   model = _item_melee.."/connectors/thunder_hammer_connector_06"},
            {name = "force_staff_full_01",           model = _item_melee.."/full/force_staff_full_01"},
            {name = "force_staff_full_02",           model = _item_melee.."/full/force_staff_full_02"},
            {name = "force_staff_full_03",           model = _item_melee.."/full/force_staff_full_03"},
            {name = "force_staff_full_04",           model = _item_melee.."/full/force_staff_full_04"},
            {name = "force_staff_full_05",           model = _item_melee.."/full/force_staff_full_05"},
            {name = "force_staff_full_ml01",         model = _item_melee.."/full/force_staff_full_ml01"},
            {name = "2h_power_maul_connector_01",    model = _item_melee.."/connectors/2h_power_maul_connector_01"},
            {name = "2h_power_maul_connector_02",    model = _item_melee.."/connectors/2h_power_maul_connector_02"},
            {name = "2h_power_maul_connector_03",    model = _item_melee.."/connectors/2h_power_maul_connector_03"},
            {name = "2h_power_maul_connector_04",    model = _item_melee.."/connectors/2h_power_maul_connector_04"},
            {name = "2h_power_maul_connector_05",    model = _item_melee.."/connectors/2h_power_maul_connector_05"},
            {name = "2h_power_maul_connector_ml01",  model = _item_melee.."/connectors/2h_power_maul_connector_ml01"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,


    emblem_right_attachments = function(default)
        local attachments = {
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
            {id = "emblem_right_23", name = "Emblem 23"},
            {id = "emblem_right_24", name = "Emblem 24"},
            {id = "emblem_right_25", name = "Emblem 25"},
            {id = "emblem_right_26", name = "Emblem 26"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "emblem_right_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    emblem_right_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "emblem_right_default", model = ""},
            {name = "emblem_right_01",      model = _item_ranged.."/emblems/emblemright_01"},
            {name = "emblem_right_02",      model = _item_ranged.."/emblems/emblemright_02"},
            {name = "emblem_right_03",      model = _item_ranged.."/emblems/emblemright_03"},
            {name = "emblem_right_04",      model = _item_ranged.."/emblems/emblemright_04a"},
            {name = "emblem_right_05",      model = _item_ranged.."/emblems/emblemright_04b"},
            {name = "emblem_right_06",      model = _item_ranged.."/emblems/emblemright_04c"},
            {name = "emblem_right_07",      model = _item_ranged.."/emblems/emblemright_04d"},
            {name = "emblem_right_08",      model = _item_ranged.."/emblems/emblemright_04e"},
            {name = "emblem_right_09",      model = _item_ranged.."/emblems/emblemright_04f"},
            {name = "emblem_right_10",      model = _item_ranged.."/emblems/emblemright_05"},
            {name = "emblem_right_11",      model = _item_ranged.."/emblems/emblemright_06"},
            {name = "emblem_right_12",      model = _item_ranged.."/emblems/emblemright_07"},
            {name = "emblem_right_13",      model = _item_ranged.."/emblems/emblemright_08a"},
            {name = "emblem_right_14",      model = _item_ranged.."/emblems/emblemright_08b"},
            {name = "emblem_right_15",      model = _item_ranged.."/emblems/emblemright_08c"},
            {name = "emblem_right_16",      model = _item_ranged.."/emblems/emblemright_09a"},
            {name = "emblem_right_17",      model = _item_ranged.."/emblems/emblemright_09b"},
            {name = "emblem_right_18",      model = _item_ranged.."/emblems/emblemright_09c"},
            {name = "emblem_right_19",      model = _item_ranged.."/emblems/emblemright_09d"},
            {name = "emblem_right_20",      model = _item_ranged.."/emblems/emblemright_09e"},
            {name = "emblem_right_21",      model = _item_ranged.."/emblems/emblemright_10"},
            {name = "emblem_right_22",      model = _item_ranged.."/emblems/emblemright_11"},
            {name = "emblem_right_23",      model = _item_ranged.."/emblems/emblemright_12"},
            {name = "emblem_right_24",      model = _item_ranged.."/emblems/emblemright_13"},
            {name = "emblem_right_25",      model = _item_ranged.."/emblems/emblemright_14"},
            {name = "emblem_right_26",      model = _item_ranged.."/emblems/emblemright_15"},
        }, parent, angle, move, remove, type or "emblem_right", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    emblem_left_attachments = function(default)
        local attachments = {
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
            {id = "emblem_left_14", name = "Emblem 14"},
            {id = "emblem_left_15", name = "Emblem 15"},
            {id = "emblem_left_16", name = "Emblem 16"},
            {id = "emblem_left_17", name = "Emblem 17"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "emblem_left_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    emblem_left_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "emblem_left_default", model = ""},
            {name = "emblem_left_01",      model = _item_ranged.."/emblems/emblemleft_01"},
            {name = "emblem_left_02",      model = _item_ranged.."/emblems/emblemleft_02"},
            {name = "emblem_left_03",      model = _item_ranged.."/emblems/emblemleft_03"},
            {name = "emblem_left_04",      model = _item_ranged.."/emblems/emblemleft_04a"},
            {name = "emblem_left_05",      model = _item_ranged.."/emblems/emblemleft_04b"},
            {name = "emblem_left_06",      model = _item_ranged.."/emblems/emblemleft_04c"},
            {name = "emblem_left_07",      model = _item_ranged.."/emblems/emblemleft_04d"},
            {name = "emblem_left_08",      model = _item_ranged.."/emblems/emblemleft_04e"},
            {name = "emblem_left_09",      model = _item_ranged.."/emblems/emblemleft_04f"},
            {name = "emblem_left_10",      model = _item_ranged.."/emblems/emblemleft_05"},
            {name = "emblem_left_11",      model = _item_ranged.."/emblems/emblemleft_06"},
            {name = "emblem_left_12",      model = _item_ranged.."/emblems/emblemleft_10"},
            {name = "emblem_left_13",      model = _item_ranged.."/emblems/emblemleft_11"},
            {name = "emblem_left_14",      model = _item_ranged.."/emblems/emblemleft_12"},
            {name = "emblem_left_15",      model = _item_ranged.."/emblems/emblemleft_13"},
            {name = "emblem_left_16",      model = _item_ranged.."/emblems/emblemleft_14"},
            {name = "emblem_left_17",      model = _item_ranged.."/emblems/emblemleft_15"},
        }, parent, angle, move, remove, type or "emblem_left", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    decal_right_attachments = function(default)
        local attachments = {
            {id = "decal_right_01", name = "Decal 1"},
            {id = "decal_right_02", name = "Decal 2"},
            {id = "decal_right_03", name = "Decal 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "decal_right_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    decal_right_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "decal_right_default", model = ""},
            {name = "decal_right_01",      model = _item_ranged.."/decals/decalright_01"},
            {name = "decal_right_02",      model = _item_ranged.."/decals/decalright_02"},
            {name = "decal_right_03",      model = _item_ranged.."/decals/decalright_03"},
        }, parent, angle, move, remove, type or "emblem_right", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    decal_left_attachments = function(default)
        local attachments = {
            {id = "decal_left_01", name = "Decal 1"},
            {id = "decal_left_02", name = "Decal 2"},
            {id = "decal_left_03", name = "Decal 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "decal_left_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    decal_left_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "decal_left_default", model = ""},
            {name = "decal_left_01",      model = _item_ranged.."/decals/decalleft_01"},
            {name = "decal_left_02",      model = _item_ranged.."/decals/decalleft_02"},
            {name = "decal_left_03",      model = _item_ranged.."/decals/decalleft_03"},
        }, parent, angle, move, remove, type or "emblem_right", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    trinket_hook_attachments = function(default)
        local attachments = {
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
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "trinket_hook_default",       name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    trinket_hook_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "trinket_hook_default",     model = ""},
            {name = "trinket_hook_empty",       model = _item.."/trinkets/trinket_hook_empty"},
            {name = "trinket_hook_02_90",       model = _item.."/trinkets/trinket_hook_02_90"},
            {name = "trinket_hook_01_v",        model = _item.."/trinkets/trinket_hook_01_v"},
            {name = "trinket_hook_04_gold_v",   model = _item.."/trinkets/trinket_hook_04_gold_v"},
            {name = "trinket_hook_02",          model = _item.."/trinkets/trinket_hook_02"},
            {name = "trinket_hook_03",          model = _item.."/trinkets/trinket_hook_03"},
            {name = "trinket_hook_04_steel_v",  model = _item.."/trinkets/trinket_hook_04_steel_v"},
            {name = "trinket_hook_04_carbon",   model = _item.."/trinkets/trinket_hook_04_carbon"},
            {name = "trinket_hook_04_gold",     model = _item.."/trinkets/trinket_hook_04_gold"},
            {name = "trinket_hook_04_carbon_v", model = _item.."/trinkets/trinket_hook_04_carbon_v"},
            {name = "trinket_hook_04_coated",   model = _item.."/trinkets/trinket_hook_04_coated"},
            {name = "trinket_hook_01",          model = _item.."/trinkets/trinket_hook_01"},
            {name = "trinket_hook_04_steel",    model = _item.."/trinkets/trinket_hook_04_steel"},
            {name = "trinket_hook_02_45",       model = _item.."/trinkets/trinket_hook_02_45"},
            {name = "trinket_hook_05_gold",     model = _item.."/trinkets/trinket_hook_05_gold"},
            {name = "trinket_hook_05_carbon",   model = _item.."/trinkets/trinket_hook_05_carbon"},
            {name = "trinket_hook_05_coated_v", model = _item.."/trinkets/trinket_hook_05_coated_v"},
            {name = "trinket_hook_05_gold_v",   model = _item.."/trinkets/trinket_hook_05_gold_v"},
            {name = "trinket_hook_05_steel_v",  model = _item.."/trinkets/trinket_hook_05_steel_v"},
            {name = "trinket_hook_05_coated",   model = _item.."/trinkets/trinket_hook_05_coated"},
            {name = "trinket_hook_05_carbon_v", model = _item.."/trinkets/trinket_hook_05_carbon_v"},
            {name = "trinket_hook_03_v",        model = _item.."/trinkets/trinket_hook_03_v"},
            {name = "trinket_hook_05_steel",    model = _item.."/trinkets/trinket_hook_05_steel"},
            {name = "trinket_hook_04_coated_v", model = _item.."/trinkets/trinket_hook_04_coated_v"},
        }, parent, angle, move, remove, type or "trinket_hook", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    slot_trinket_1_attachments = function(default)
        return {
            {id = "slot_trinket_1", name = mod:localize("mod_attachment_default")},
        }
    end,
    slot_trinket_1_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_1 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_1", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
    slot_trinket_2_attachments = function(default)
        return {
            {id = "slot_trinket_2", name = mod:localize("mod_attachment_default")},
        }
    end,
    slot_trinket_2_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_2 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_2", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
}