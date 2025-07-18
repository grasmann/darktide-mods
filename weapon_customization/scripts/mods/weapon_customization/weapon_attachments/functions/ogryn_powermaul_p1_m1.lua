local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
    local _item_melee = _item.."/melee"
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table = table
    local table_icombine = table.icombine
    local table_model_table = table.model_table
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

return {
    shaft_attachments = function(default) -- Last update 1.5.4
        local attachments = {
            {id = "ogryn_powermaul_shaft_01",    name = "Ogryn Powermaul 1"},
            {id = "ogryn_powermaul_shaft_02",    name = "Ogryn Powermaul 2"},
            {id = "ogryn_powermaul_shaft_03",    name = "Ogryn Powermaul 3"},
            {id = "ogryn_powermaul_shaft_04",    name = "Ogryn Powermaul 4"},
            {id = "ogryn_powermaul_shaft_05",    name = "Ogryn Powermaul 5"},
            {id = "ogryn_powermaul_shaft_06",    name = "Ogryn Powermaul 6"},
            {id = "ogryn_powermaul_shaft_07",    name = "Ogryn Powermaul 7"},
            {id = "ogryn_power_maul_shaft_ml01", name = "Ogryn Powermaul ML01"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move) -- Last update 1.5.4
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "shaft_default",               model = ""},
            {name = "ogryn_powermaul_shaft_01",    model = _item_ranged.."/shafts/power_maul_shaft_01"},
            {name = "ogryn_powermaul_shaft_02",    model = _item_ranged.."/shafts/power_maul_shaft_02"},
            {name = "ogryn_powermaul_shaft_03",    model = _item_ranged.."/shafts/power_maul_shaft_03"},
            {name = "ogryn_powermaul_shaft_04",    model = _item_ranged.."/shafts/power_maul_shaft_04"},
            {name = "ogryn_powermaul_shaft_05",    model = _item_ranged.."/shafts/power_maul_shaft_05"},
            {name = "ogryn_powermaul_shaft_06",    model = _item_ranged.."/shafts/power_maul_shaft_06"},
            {name = "ogryn_powermaul_shaft_07",    model = _item_ranged.."/shafts/power_maul_shaft_07"},
            {name = "ogryn_power_maul_shaft_ml01", model = _item_ranged.."/shafts/power_maul_shaft_ml01"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "head_01", name = "Head 1"},
            {id = "head_02", name = "Head 2"},
            {id = "head_03", name = "Head 3"},
            {id = "head_04", name = "Head 4"},
            {id = "head_05", name = "Head 5"},
            {id = "head_06", name = "Head 6"},
            {id = "head_07", name = "Head 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "head_default", model = ""},
            {name = "head_01",      model = _item_melee.."/heads/power_maul_head_01"},
            {name = "head_02",      model = _item_melee.."/heads/power_maul_head_02"},
            {name = "head_03",      model = _item_melee.."/heads/power_maul_head_03"},
            {name = "head_04",      model = _item_melee.."/heads/power_maul_head_04"},
            {name = "head_05",      model = _item_melee.."/heads/power_maul_head_05"},
            {name = "head_06",      model = _item_melee.."/heads/power_maul_head_06"},
            {name = "head_07",      model = _item_melee.."/heads/power_maul_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "ogryn_powermaul_pommel_01", name = "Ogryn Powermaul 1"},
            {id = "ogryn_powermaul_pommel_02", name = "Ogryn Powermaul 2"},
            {id = "ogryn_powermaul_pommel_03", name = "Ogryn Powermaul 3"},
            {id = "ogryn_powermaul_pommel_04", name = "Ogryn Powermaul 4"},
            {id = "ogryn_powermaul_pommel_05", name = "Ogryn Powermaul 5"},
            {id = "ogryn_powermaul_pommel_06", name = "Ogryn Powermaul 6"},
            {id = "ogryn_powermaul_pommel_07", name = "Ogryn Powermaul 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "pommel_default",            model = ""},
            {name = "ogryn_powermaul_pommel_01", model = _item_melee.."/pommels/power_maul_pommel_01"},
            {name = "ogryn_powermaul_pommel_02", model = _item_melee.."/pommels/power_maul_pommel_02"},
            {name = "ogryn_powermaul_pommel_03", model = _item_melee.."/pommels/power_maul_pommel_03"},
            {name = "ogryn_powermaul_pommel_04", model = _item_melee.."/pommels/power_maul_pommel_04"},
            {name = "ogryn_powermaul_pommel_05", model = _item_melee.."/pommels/power_maul_pommel_05"},
            {name = "ogryn_powermaul_pommel_06", model = _item_melee.."/pommels/power_maul_pommel_06"},
            {name = "ogryn_powermaul_pommel_07", model = _item_melee.."/pommels/power_maul_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}