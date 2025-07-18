local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
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
            {id = "2h_power_maul_shaft_01",   name = "Powermaul 1"},
            {id = "2h_power_maul_shaft_02",   name = "Powermaul 2"},
            {id = "2h_power_maul_shaft_03",   name = "Powermaul 3"},
            {id = "2h_power_maul_shaft_04",   name = "Powermaul 4"},
            {id = "2h_power_maul_shaft_05",   name = "Powermaul 5"},
            {id = "2h_power_maul_shaft_06",   name = "Powermaul 6"},
            {id = "2h_power_maul_shaft_07",   name = "Powermaul 7"},
            {id = "2h_power_maul_shaft_ml01", name = "Powermaul ML01"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve) -- Last update 1.5.4
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "shaft_default",            model = ""},
            {name = "2h_power_maul_shaft_01",   model = _item_melee.."/shafts/2h_power_maul_shaft_01"},
            {name = "2h_power_maul_shaft_02",   model = _item_melee.."/shafts/2h_power_maul_shaft_02"},
            {name = "2h_power_maul_shaft_03",   model = _item_melee.."/shafts/2h_power_maul_shaft_03"},
            {name = "2h_power_maul_shaft_04",   model = _item_melee.."/shafts/2h_power_maul_shaft_04"},
            {name = "2h_power_maul_shaft_05",   model = _item_melee.."/shafts/2h_power_maul_shaft_05"},
            {name = "2h_power_maul_shaft_06",   model = _item_melee.."/shafts/2h_power_maul_shaft_06"},
            {name = "2h_power_maul_shaft_07",   model = _item_melee.."/shafts/2h_power_maul_shaft_07"},
            {name = "2h_power_maul_shaft_ml01", model = _item_melee.."/shafts/2h_power_maul_shaft_ml01"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "2h_power_maul_head_01",      name = "Head 1"},
            {id = "2h_power_maul_head_02",      name = "Head 2"},
            {id = "2h_power_maul_head_03",      name = "Head 3"},
            {id = "2h_power_maul_head_04",      name = "Head 4"},
            {id = "2h_power_maul_head_05",      name = "Head 5"},
            {id = "2h_power_maul_head_06",      name = "Head 6"},
            {id = "2h_power_maul_head_07",      name = "Head 7"},
            {id = "2h_power_maul_head_ml01",    name = "Head 8"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "2h_power_maul_head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "2h_power_maul_head_default", model = ""},
            {name = "2h_power_maul_head_01",      model = _item_melee.."/heads/2h_power_maul_head_01"},
            {name = "2h_power_maul_head_02",      model = _item_melee.."/heads/2h_power_maul_head_02"},
            {name = "2h_power_maul_head_03",      model = _item_melee.."/heads/2h_power_maul_head_03"},
            {name = "2h_power_maul_head_04",      model = _item_melee.."/heads/2h_power_maul_head_04"},
            {name = "2h_power_maul_head_05",      model = _item_melee.."/heads/2h_power_maul_head_05"},
            {name = "2h_power_maul_head_06",      model = _item_melee.."/heads/2h_power_maul_head_06"},
            {name = "2h_power_maul_head_07",      model = _item_melee.."/heads/2h_power_maul_head_07"},
            {name = "2h_power_maul_head_ml01",      model = _item_melee.."/heads/2h_power_maul_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "2h_power_maul_pommel_01", name = "Powermaul 1"},
            {id = "2h_power_maul_pommel_02", name = "Powermaul 2"},
            {id = "2h_power_maul_pommel_03", name = "Powermaul 3"},
            {id = "2h_power_maul_pommel_04", name = "Powermaul 4"},
            {id = "2h_power_maul_pommel_05", name = "Powermaul 5"},
            {id = "2h_power_maul_pommel_06", name = "Powermaul 6"},
            {id = "2h_power_maul_pommel_07", name = "Powermaul 7"},
            {id = "2h_power_maul_pommel_ml01", name = "Powermaul 8"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "pommel_default",          model = ""},
            {name = "2h_power_maul_pommel_01", model = _item_melee.."/pommels/2h_power_maul_pommel_01"},
            {name = "2h_power_maul_pommel_02", model = _item_melee.."/pommels/2h_power_maul_pommel_02"},
            {name = "2h_power_maul_pommel_03", model = _item_melee.."/pommels/2h_power_maul_pommel_03"},
            {name = "2h_power_maul_pommel_04", model = _item_melee.."/pommels/2h_power_maul_pommel_04"},
            {name = "2h_power_maul_pommel_05", model = _item_melee.."/pommels/2h_power_maul_pommel_05"},
            {name = "2h_power_maul_pommel_06", model = _item_melee.."/pommels/2h_power_maul_pommel_06"},
            {name = "2h_power_maul_pommel_07", model = _item_melee.."/pommels/2h_power_maul_pommel_07"},
            {name = "2h_power_maul_pommel_ml01", model = _item_melee.."/pommels/2h_power_maul_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "2h_power_maul_connector_01",      name = "Connector 1"},
            {id = "2h_power_maul_connector_02",      name = "Connector 2"},
            {id = "2h_power_maul_connector_03",      name = "Connector 3"},
            {id = "2h_power_maul_connector_04",      name = "Connector 4"},
            {id = "2h_power_maul_connector_05",      name = "Connector 5"},
            {id = "2h_power_maul_connector_06",      name = "Connector 6"},
            {id = "2h_power_maul_connector_ml01",      name = "Connector 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "2h_power_maul_connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "2h_power_maul_connector_default", model = ""},
            {name = "2h_power_maul_connector_01",      model = _item_melee.."/connectors/2h_power_maul_connector_01"},
            {name = "2h_power_maul_connector_02",      model = _item_melee.."/connectors/2h_power_maul_connector_02"},
            {name = "2h_power_maul_connector_03",      model = _item_melee.."/connectors/2h_power_maul_connector_03"},
            {name = "2h_power_maul_connector_04",      model = _item_melee.."/connectors/2h_power_maul_connector_04"},
            {name = "2h_power_maul_connector_05",      model = _item_melee.."/connectors/2h_power_maul_connector_05"},
            {name = "2h_power_maul_connector_06",      model = _item_melee.."/connectors/2h_power_maul_connector_06"},
            {name = "2h_power_maul_connector_ml01",      model = _item_melee.."/connectors/2h_power_maul_connector_ml01"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}