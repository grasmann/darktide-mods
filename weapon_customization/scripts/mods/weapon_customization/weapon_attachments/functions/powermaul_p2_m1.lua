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
    shaft_attachments = function(default)
        local attachments = {
            {id = "human_power_maul_short_shaft_01",       name = "Small Shaft 1"},
            {id = "human_power_maul_short_shaft_02",       name = "Small Shaft 2"},
            {id = "human_power_maul_short_shaft_03",       name = "Small Shaft 3"},
            {id = "human_power_maul_short_shaft_deluxe01", name = "Small Shaft 4"},
            {id = "human_power_maul_short_shaft_deluxe02", name = "Small Shaft 5"},
            {id = "human_power_maul_short_shaft_ml01",     name = "Small Shaft 6"},
            {id = "human_power_maul_short_shaft_ml02",     name = "Small Shaft 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default",  model = ""},
            {name = "human_power_maul_short_shaft_01",       model = _item_ranged.."/shafts/human_power_maul_short_shaft_01"},
            {name = "human_power_maul_short_shaft_02",       model = _item_ranged.."/shafts/human_power_maul_short_shaft_02"},
            {name = "human_power_maul_short_shaft_03",       model = _item_ranged.."/shafts/human_power_maul_short_shaft_03"},
            {name = "human_power_maul_short_shaft_deluxe01", model = _item_ranged.."/shafts/human_power_maul_short_shaft_deluxe01"},
            {name = "human_power_maul_short_shaft_deluxe02", model = _item_ranged.."/shafts/human_power_maul_short_shaft_deluxe02"},
            {name = "human_power_maul_short_shaft_ml01",     model = _item_ranged.."/shafts/human_power_maul_short_shaft_ml01"},
            {name = "human_power_maul_short_shaft_ml02",     model = _item_ranged.."/shafts/human_power_maul_short_shaft_ml02"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "human_power_maul_short_head_01",       name = "Small Head 1"},
            {id = "human_power_maul_short_head_02",       name = "Small Head 2"},
            {id = "human_power_maul_short_head_03",       name = "Small Head 3"},
            {id = "human_power_maul_short_head_deluxe01", name = "Small Head 4"},
            {id = "human_power_maul_short_head_deluxe02", name = "Small Head 5"},
            {id = "human_power_maul_short_head_ml01",     name = "Small Head 6"},
            {id = "human_power_maul_short_head_ml02",     name = "Small Head 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default",  model = ""},
            {name = "human_power_maul_short_head_01",       model = _item_melee.."/heads/human_power_maul_short_head_01"},
            {name = "human_power_maul_short_head_02",       model = _item_melee.."/heads/human_power_maul_short_head_02"},
            {name = "human_power_maul_short_head_03",       model = _item_melee.."/heads/human_power_maul_short_head_03"},
            {name = "human_power_maul_short_head_deluxe01", model = _item_melee.."/heads/human_power_maul_short_head_deluxe01"},
            {name = "human_power_maul_short_head_deluxe02", model = _item_melee.."/heads/human_power_maul_short_head_deluxe02"},
            {name = "human_power_maul_short_head_ml01",     model = _item_melee.."/heads/human_power_maul_short_head_ml01"},
            {name = "human_power_maul_short_head_ml02",     model = _item_melee.."/heads/human_power_maul_short_head_ml02"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "human_power_maul_short_connector_01",       name = "Small Connector 1"},
            {id = "human_power_maul_short_connector_02",       name = "Small Connector 2"},
            {id = "human_power_maul_short_connector_03",       name = "Small Connector 3"},
            {id = "human_power_maul_short_connector_deluxe01", name = "Small Connector 4"},
            {id = "human_power_maul_short_connector_deluxe02", name = "Small Connector 5"},
            {id = "human_power_maul_short_connector_ml01",     name = "Small Connector 6"},
            {id = "human_power_maul_short_connector_ml02",     name = "Small Connector 7"},
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
            {name = "connector_default",  model = ""},
            {name = "human_power_maul_short_connector_01",       model = _item_melee.."/connectors/human_power_maul_short_connector_01"},
            {name = "human_power_maul_short_connector_02",       model = _item_melee.."/connectors/human_power_maul_short_connector_02"},
            {name = "human_power_maul_short_connector_03",       model = _item_melee.."/connectors/human_power_maul_short_connector_03"},
            {name = "human_power_maul_short_connector_deluxe01", model = _item_melee.."/connectors/human_power_maul_short_connector_deluxe01"},
            {name = "human_power_maul_short_connector_deluxe02", model = _item_melee.."/connectors/human_power_maul_short_connector_deluxe02"},
            {name = "human_power_maul_short_connector_ml01",     model = _item_melee.."/connectors/human_power_maul_short_connector_ml01"},
            {name = "human_power_maul_short_connector_ml02",     model = _item_melee.."/connectors/human_power_maul_short_connector_ml02"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}