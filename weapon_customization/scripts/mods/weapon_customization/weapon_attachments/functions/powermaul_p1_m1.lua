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
            {id = "small_shaft_01", name = "Small Shaft 1"},
            {id = "small_shaft_02", name = "Small Shaft 2"},
            {id = "small_shaft_03", name = "Small Shaft 3"},
            {id = "small_shaft_04", name = "Small Shaft 4"},
            {id = "small_shaft_05", name = "Small Shaft 5"},
            {id = "small_shaft_06", name = "Small Shaft 6"},
            {id = "small_shaft_07", name = "Small Shaft 7"},
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
            {name = "small_shaft_01", model = _item_ranged.."/shafts/human_power_maul_shaft_01"},
            {name = "small_shaft_02", model = _item_ranged.."/shafts/human_power_maul_shaft_02"},
            {name = "small_shaft_03", model = _item_ranged.."/shafts/human_power_maul_shaft_03"},
            {name = "small_shaft_04", model = _item_ranged.."/shafts/human_power_maul_shaft_04"},
            {name = "small_shaft_05", model = _item_ranged.."/shafts/human_power_maul_shaft_05"},
            {name = "small_shaft_06", model = _item_ranged.."/shafts/human_power_maul_shaft_06"},
            {name = "small_shaft_07", model = _item_ranged.."/shafts/human_power_maul_shaft_ml01"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "small_head_01", name = "Small Head 1"},
            {id = "small_head_02", name = "Small Head 2"},
            {id = "small_head_03", name = "Small Head 3"},
            {id = "small_head_04", name = "Small Head 4"},
            {id = "small_head_05", name = "Small Head 5"},
            {id = "small_head_06", name = "Small Head 6"},
            {id = "small_head_07", name = "Small Head 7"},
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
            {name = "small_head_01", model = _item_melee.."/heads/human_power_maul_head_01"},
            {name = "small_head_02", model = _item_melee.."/heads/human_power_maul_head_02"},
            {name = "small_head_03", model = _item_melee.."/heads/human_power_maul_head_03"},
            {name = "small_head_04", model = _item_melee.."/heads/human_power_maul_head_04"},
            {name = "small_head_05", model = _item_melee.."/heads/human_power_maul_head_05"},
            {name = "small_head_06", model = _item_melee.."/heads/human_power_maul_head_06"},
            {name = "small_head_07", model = _item_melee.."/heads/human_power_maul_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "small_connector_01", name = "Small Connector 1"},
            {id = "small_connector_02", name = "Small Connector 2"},
            {id = "small_connector_03", name = "Small Connector 3"},
            {id = "small_connector_04", name = "Small Connector 4"},
            {id = "small_connector_05", name = "Small Connector 5"},
            {id = "small_connector_06", name = "Small Connector 6"},
            {id = "small_connector_07", name = "Small Connector 7"},
            {id = "small_connector_08", name = "Small Connector 8"},
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
            {name = "small_connector_01", model = _item_melee.."/connectors/human_power_maul_connector_01"},
            {name = "small_connector_02", model = _item_melee.."/connectors/human_power_maul_connector_02"},
            {name = "small_connector_03", model = _item_melee.."/connectors/human_power_maul_connector_03"},
            {name = "small_connector_04", model = _item_melee.."/connectors/human_power_maul_connector_04"},
            {name = "small_connector_05", model = _item_melee.."/connectors/human_power_maul_connector_05"},
            {name = "small_connector_06", model = _item_melee.."/connectors/human_power_maul_connector_06"},
            {name = "small_connector_07", model = _item_melee.."/connectors/human_power_maul_connector_07"},
            {name = "small_connector_08", model = _item_melee.."/connectors/human_power_maul_connector_ml01"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}