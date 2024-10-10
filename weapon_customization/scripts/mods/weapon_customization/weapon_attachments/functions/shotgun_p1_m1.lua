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
    sight_attachments = function(default)
        local attachments = {
            {id = "sight_01",      name = "Sight 1"},
            {id = "sight_04",      name = "Sight 4"},
            {id = "sight_05",      name = "Sight 5"},
            {id = "sight_06",      name = "Sight 6"},
            {id = "sight_07",      name = "Sight 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "sight_default", model = ""},
            {name = "sight_01",      model = _item_ranged.."/sights/shotgun_rifle_sight_01"},
            {name = "sight_04",      model = _item_ranged.."/sights/shotgun_rifle_sight_04"},
            {name = "sight_05",      model = _item_ranged.."/sights/shotgun_pump_action_sight_01"},
            {name = "sight_06",      model = _item_ranged.."/sights/shotgun_pump_action_sight_02"},
            {name = "sight_07",      model = _item_ranged.."/sights/shotgun_double_barrel_sight_01"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01",      name = "Receiver 1"},
            {id = "receiver_02",      name = "Receiver 2"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/shotgun_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/shotgun_rifle_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "shotgun_rifle_stock_01",      name = "Stock 1"},
            {id = "shotgun_rifle_stock_02",      name = "Stock 2"},
            {id = "shotgun_rifle_stock_03",      name = "Stock 3"},
            {id = "shotgun_rifle_stock_04",      name = "Stock 4"},
            {id = "shotgun_rifle_stock_07",      name = "Stock 7"},
            {id = "shotgun_rifle_stock_08",      name = "Stock 8"},
            {id = "shotgun_rifle_stock_09",      name = "Stock 9"},
            {id = "shotgun_rifle_stock_10",      name = "Stock 10"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "shotgun_rifle_stock_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "shotgun_rifle_stock_default", model = ""},
            {name = "shotgun_rifle_stock_01",      model = _item_ranged.."/stocks/shotgun_rifle_stock_01"},
            {name = "shotgun_rifle_stock_02",      model = _item_ranged.."/stocks/shotgun_rifle_stock_03"},
            {name = "shotgun_rifle_stock_03",      model = _item_ranged.."/stocks/shotgun_rifle_stock_05"},
            {name = "shotgun_rifle_stock_04",      model = _item_ranged.."/stocks/shotgun_rifle_stock_06"},
            {name = "shotgun_rifle_stock_07",      model = _item_ranged.."/stocks/shotgun_rifle_stock_07"},
            {name = "shotgun_rifle_stock_08",      model = _item_ranged.."/stocks/shotgun_rifle_stock_08"},
            {name = "shotgun_rifle_stock_09",      model = _item_ranged.."/stocks/shotgun_rifle_stock_09"},
            {name = "shotgun_rifle_stock_10",      model = _item_ranged.."/stocks/shotgun_rifle_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_07",      name = "Barrel 7"},
            {id = "barrel_08",      name = "Barrel 8"},
            {id = "barrel_09",      name = "Barrel 9"},
            {id = "barrel_10",      name = "Barrel 10"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_04"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_05"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_06"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_07"},
            {name = "barrel_08",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_08"},
            {name = "barrel_09",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_09"},
            {name = "barrel_10",      model = _item_ranged.."/barrels/shotgun_rifle_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    underbarrel_attachments = function(default)
        local attachments = {
            {id = "underbarrel_01",      name = "Underbarrel 1"},
            {id = "underbarrel_02",      name = "Underbarrel 2"},
            {id = "underbarrel_03",      name = "Underbarrel 3"},
            {id = "underbarrel_04",      name = "Underbarrel 4"},
            {id = "underbarrel_07",      name = "Underbarrel 7"},
            {id = "underbarrel_08",      name = "Underbarrel 8"},
            {id = "underbarrel_09",      name = "Underbarrel 9"},
            {id = "underbarrel_10",      name = "Underbarrel 10"},
            {id = "underbarrel_11",      name = "Underbarrel 11"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "underbarrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    underbarrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "underbarrel_default", model = ""},
            {name = "underbarrel_01",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_01"},
            {name = "underbarrel_02",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_04"},
            {name = "underbarrel_03",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_05"},
            {name = "underbarrel_04",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_06"},
            {name = "underbarrel_07",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_07"},
            {name = "underbarrel_08",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_08"},
            {name = "underbarrel_09",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_01"},
            {name = "underbarrel_10",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_02"},
            {name = "underbarrel_11",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_03"},
            {name = "no_underbarrel",      model = ""},
        }, parent, angle, move, remove, type or "underbarrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}