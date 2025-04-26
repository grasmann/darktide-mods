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
            {id = "thunder_hammer_shaft_01",   name = "Thunder Hammer 1"},
            {id = "thunder_hammer_shaft_02",   name = "Thunder Hammer 2"},
            {id = "thunder_hammer_shaft_03",   name = "Thunder Hammer 3"},
            {id = "thunder_hammer_shaft_04",   name = "Thunder Hammer 4"},
            {id = "thunder_hammer_shaft_05",   name = "Thunder Hammer 5"},
            {id = "thunder_hammer_shaft_ml01", name = "Thunder Hammer ML01"},
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
            {name = "shaft_default",             model = ""},
            {name = "thunder_hammer_shaft_01",   model = _item_ranged.."/shafts/thunder_hammer_shaft_01"},
            {name = "thunder_hammer_shaft_02",   model = _item_ranged.."/shafts/thunder_hammer_shaft_02"},
            {name = "thunder_hammer_shaft_03",   model = _item_ranged.."/shafts/thunder_hammer_shaft_03"},
            {name = "thunder_hammer_shaft_04",   model = _item_ranged.."/shafts/thunder_hammer_shaft_04"},
            {name = "thunder_hammer_shaft_05",   model = _item_ranged.."/shafts/thunder_hammer_shaft_05"},
            {name = "thunder_hammer_shaft_ml01", model = _item_ranged.."/shafts/thunder_hammer_shaft_ml01"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_head_01",   name = "Head 1"},
            {id = "thunder_hammer_head_02",   name = "Head 2"},
            {id = "thunder_hammer_head_03",   name = "Head 3"},
            {id = "thunder_hammer_head_04",   name = "Head 4"},
            {id = "thunder_hammer_head_05",   name = "Head 5"},
            {id = "thunder_hammer_head_06",   name = "Head 6"},
            {id = "thunder_hammer_head_ml01", name = "Head 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "thunder_hammer_head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "thunder_hammer_head_default", model = ""},
            {name = "thunder_hammer_head_01",      model = _item_melee.."/heads/thunder_hammer_head_01"},
            {name = "thunder_hammer_head_02",      model = _item_melee.."/heads/thunder_hammer_head_02"},
            {name = "thunder_hammer_head_03",      model = _item_melee.."/heads/thunder_hammer_head_03"},
            {name = "thunder_hammer_head_04",      model = _item_melee.."/heads/thunder_hammer_head_04"},
            {name = "thunder_hammer_head_05",      model = _item_melee.."/heads/thunder_hammer_head_05"},
            {name = "thunder_hammer_head_06",      model = _item_melee.."/heads/thunder_hammer_head_06"},
            {name = "thunder_hammer_head_ml01",    model = _item_melee.."/heads/thunder_hammer_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_pommel_01", name = "Thunder Hammer 1"},
            {id = "thunder_hammer_pommel_02", name = "Thunder Hammer 2"},
            {id = "thunder_hammer_pommel_03", name = "Thunder Hammer 3"},
            {id = "thunder_hammer_pommel_04", name = "Thunder Hammer 4"},
            {id = "thunder_hammer_pommel_05", name = "Thunder Hammer 5"},
            {id = "thunder_hammer_pommel_ml01", name = "Thunder Hammer 6"},
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
            {name = "pommel_default",           model = ""},
            {name = "thunder_hammer_pommel_01", model = _item_melee.."/pommels/thunder_hammer_pommel_01"},
            {name = "thunder_hammer_pommel_02", model = _item_melee.."/pommels/thunder_hammer_pommel_02"},
            {name = "thunder_hammer_pommel_03", model = _item_melee.."/pommels/thunder_hammer_pommel_03"},
            {name = "thunder_hammer_pommel_04", model = _item_melee.."/pommels/thunder_hammer_pommel_04"},
            {name = "thunder_hammer_pommel_05", model = _item_melee.."/pommels/thunder_hammer_pommel_05"},
            {name = "thunder_hammer_pommel_ml01", model = _item_melee.."/pommels/thunder_hammer_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_connector_01",   name = "Connector 1"},
            {id = "thunder_hammer_connector_02",   name = "Connector 2"},
            {id = "thunder_hammer_connector_03",   name = "Connector 3"},
            {id = "thunder_hammer_connector_04",   name = "Connector 4"},
            {id = "thunder_hammer_connector_05",   name = "Connector 5"},
            {id = "thunder_hammer_connector_06",   name = "Connector 6"},
            {id = "thunder_hammer_connector_ml01", name = "Connector 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "thunder_hammer_connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "thunder_hammer_connector_default", model = ""},
            {name = "thunder_hammer_connector_01",      model = _item_melee.."/connectors/thunder_hammer_connector_01"},
            {name = "thunder_hammer_connector_02",      model = _item_melee.."/connectors/thunder_hammer_connector_02"},
            {name = "thunder_hammer_connector_03",      model = _item_melee.."/connectors/thunder_hammer_connector_03"},
            {name = "thunder_hammer_connector_04",      model = _item_melee.."/connectors/thunder_hammer_connector_04"},
            {name = "thunder_hammer_connector_05",      model = _item_melee.."/connectors/thunder_hammer_connector_05"},
            {name = "thunder_hammer_connector_06",      model = _item_melee.."/connectors/thunder_hammer_connector_06"},
            {name = "thunder_hammer_connector_ml01",    model = _item_melee.."/connectors/thunder_hammer_connector_ml01"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}