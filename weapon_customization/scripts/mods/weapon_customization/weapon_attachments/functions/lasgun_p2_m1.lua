local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
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
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01",        name = "Receiver 1"},
            {id = "receiver_02",        name = "Receiver 2"},
            {id = "receiver_03",        name = "Receiver 3"},
            {id = "receiver_04",        name = "Receiver 4"},
            {id = "receiver_05",        name = "Receiver 5"},
            {id = "receiver_06",        name = "Receiver 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_04"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_05"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_06"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/lasgun_rifle_krieg_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "stock_01",       name = "Stock 1"},
            {id = "stock_02",       name = "Stock 2"},
            {id = "stock_03",       name = "Stock 3"},
            {id = "stock_04",       name = "Stock 4"},
            {id = "stock_05",       name = "Stock 5"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "stock_default",  name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "stock_default", model = ""},
            {name = "stock_01",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_01"},
            {name = "stock_02",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_02"},
            {name = "stock_03",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_04"},
            {name = "stock_04",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_05"},
            {name = "stock_05",      model = _item_ranged.."/stocks/lasgun_rifle_krieg_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}