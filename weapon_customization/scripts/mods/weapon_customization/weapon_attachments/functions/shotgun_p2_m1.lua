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
            {id = "double_barrel_sight_01", name = "Doublebarrel 1"},
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
            {name = "sight_default",          model = ""},
            {name = "double_barrel_sight_01", model = _item_ranged.."/sights/shotgun_double_barrel_sight_01"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "double_barrel_receiver_01", name = "Doublebarrel 1"},
            {id = "double_barrel_receiver_02", name = "Doublebarrel 2"},
            {id = "double_barrel_receiver_03", name = "Doublebarrel 3"},
            {id = "shotgun_double_barrel_receiver_ml01", name = "Doublebarrel 4"},
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
            {name = "receiver_default",          model = ""},
            {name = "double_barrel_receiver_01", model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_01"},
            {name = "double_barrel_receiver_02", model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_02"},
            {name = "double_barrel_receiver_03", model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_03"},
            {name = "shotgun_double_barrel_receiver_ml01", model = _item_ranged.."/recievers/shotgun_double_barrel_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "double_barrel_stock_01",      name = "Doublebarrel 1"},
            {id = "double_barrel_stock_02",      name = "Doublebarrel 2"},
            {id = "double_barrel_stock_03",      name = "Doublebarrel 3"},
            {id = "shotgun_double_barrel_stock_ml01",      name = "Doublebarrel 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "stock_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "stock_default", model = ""},
            {name = "double_barrel_stock_01",      model = _item_ranged.."/stocks/shotgun_double_barrel_stock_01"},
            {name = "double_barrel_stock_02",      model = _item_ranged.."/stocks/shotgun_double_barrel_stock_02"},
            {name = "double_barrel_stock_03",      model = _item_ranged.."/stocks/shotgun_double_barrel_stock_03"},
            {name = "shotgun_double_barrel_stock_ml01",      model = _item_ranged.."/stocks/shotgun_double_barrel_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "double_barrel_barrel_01", name = "Doublebarrel 1"},
            {id = "double_barrel_barrel_02", name = "Doublebarrel 2"},
            {id = "double_barrel_barrel_03", name = "Doublebarrel 3"},
            {id = "shotgun_double_barrel_ml01", name = "Doublebarrel 4"},
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
            {name = "barrel_default",          model = ""},
            {name = "double_barrel_barrel_01", model = _item_ranged.."/barrels/shotgun_double_barrel_01"},
            {name = "double_barrel_barrel_02", model = _item_ranged.."/barrels/shotgun_double_barrel_02"},
            {name = "double_barrel_barrel_03", model = _item_ranged.."/barrels/shotgun_double_barrel_03"},
            {name = "shotgun_double_barrel_ml01", model = _item_ranged.."/barrels/shotgun_double_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    -- underbarrel_attachments = function(default)
    --     local attachments = {
    --         {id = "underbarrel_01",      name = "Underbarrel 1"},
    --         {id = "underbarrel_02",      name = "Underbarrel 2"},
    --         {id = "underbarrel_03",      name = "Underbarrel 3"},
    --         {id = "underbarrel_04",      name = "Underbarrel 4"},
    --         {id = "underbarrel_07",      name = "Underbarrel 7"},
    --         {id = "underbarrel_08",      name = "Underbarrel 8"},
    --         {id = "underbarrel_09",      name = "Underbarrel 9"},
    --         {id = "underbarrel_10",      name = "Underbarrel 10"},
    --         {id = "underbarrel_11",      name = "Underbarrel 11"},
    --     }
    --     if default == nil then default = true end
    --     if default then return table_icombine(
    --         {{id = "underbarrel_default", name = mod:localize("mod_attachment_default")}},
    --         attachments)
    --     else return attachments end
    -- end,
    -- underbarrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    --     if mesh_move == nil then mesh_move = false end
    --     return table_model_table({
    --         {name = "underbarrel_default", model = ""},
    --         {name = "underbarrel_01",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_01"},
    --         {name = "underbarrel_02",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_04"},
    --         {name = "underbarrel_03",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_05"},
    --         {name = "underbarrel_04",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_06"},
    --         {name = "underbarrel_07",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_07"},
    --         {name = "underbarrel_08",      model = _item_ranged.."/underbarrels/shotgun_rifle_underbarrel_08"},
    --         {name = "underbarrel_09",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_01"},
    --         {name = "underbarrel_10",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_02"},
    --         {name = "underbarrel_11",      model = _item_ranged.."/underbarrels/shotgun_pump_action_underbarrel_03"},
    --         {name = "no_underbarrel",      model = ""},
    --     }, parent, angle, move, remove, type or "underbarrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    -- end,
}