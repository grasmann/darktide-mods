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
            {id = "receiver_01",        name = "Recon Lasgun 1"},
            {id = "receiver_02",        name = "Recon Lasgun 2"},
            {id = "receiver_03",        name = "Recon Lasgun 3"},
            {id = "receiver_04",        name = "Recon Lasgun 4"},
            {id = "receiver_05",        name = "Recon Lasgun 5"},
            {id = "receiver_06",        name = "Recon Lasgun 6"},
            {id = "receiver_07",        name = "Recon Lasgun 7"},
            {id = "receiver_08",        name = "Recon Lasgun 8"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_06"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_07"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/lasgun_rifle_elysian_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "stock_01",      name = "Recon Lasgun 1"},
            {id = "stock_02",      name = "Recon Lasgun 2"},
            {id = "stock_03",      name = "Recon Lasgun 3"},
            {id = "stock_04",      name = "Recon Lasgun 4"},
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
            {name = "stock_01",      model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_01"},
            {name = "stock_02",      model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_02"},
            {name = "stock_03",      model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_03"},
            {name = "stock_04",      model = _item_ranged.."/stocks/lasgun_rifle_elysian_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",      name = "Recon Lasgun"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/lasgun_elysian_magazine_01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    sight_attachments = function(default)
        local attachments = {
            {id = "elysian_sight_01",      name = "Recon Lasgun 1"},
            {id = "elysian_sight_02",      name = "Recon Lasgun 2"},
            {id = "elysian_sight_03",      name = "Recon Lasgun 3"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "elysian_sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "elysian_sight_default", model = ""},
            {name = "elysian_sight_01",      model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_01"},
            {name = "elysian_sight_02",      model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_02"},
            {name = "elysian_sight_03",      model = _item_ranged.."/sights/lasgun_rifle_elysian_sight_03"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}