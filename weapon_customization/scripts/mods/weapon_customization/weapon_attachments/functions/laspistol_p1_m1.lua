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
            {id = "laspistol_receiver_01",      name = "Laspistol Receiver 1"},
            {id = "laspistol_receiver_02",      name = "Laspistol Receiver 2"},
            {id = "laspistol_receiver_03",      name = "Laspistol Receiver 3"},
            {id = "laspistol_receiver_05",      name = "Laspistol Receiver 5"},
            {id = "laspistol_receiver_06",      name = "Laspistol Receiver 6"},
            {id = "laspistol_receiver_07",      name = "Laspistol Receiver 7"},
            {id = "laspistol_receiver_08",      name = "Laspistol Receiver 8"},
            {id = "laspistol_receiver_09",      name = "Laspistol Receiver 9"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "laspistol_receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "laspistol_receiver_default", model = ""},
            {name = "laspistol_receiver_01",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_01"},
            {name = "laspistol_receiver_02",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_02"},
            {name = "laspistol_receiver_03",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_03"},
            {name = "laspistol_receiver_04",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_04"},
            {name = "laspistol_receiver_05",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_05"},
            {name = "laspistol_receiver_06",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_06"},
            {name = "laspistol_receiver_07",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_07"},
            {name = "laspistol_receiver_08",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_08"},
            {name = "laspistol_receiver_09",      model = _item_ranged.."/recievers/lasgun_pistol_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",        name = "Magazine 1"},
            {id = "magazine_02",        name = "Magazine 2"},
            {id = "magazine_03",        name = "Magazine 3"},
            {id = "magazine_04",        name = "Magazine 4"},
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
            {name = "magazine_01",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/lasgun_pistol_magazine_04"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_05",      name = "Barrel 5"},
            {id = "barrel_06",      name = "Barrel 6"},
            {id = "barrel_07",      name = "Barrel 7"},
            {id = "barrel_08",      name = "Barrel 8"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_06"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_07"},
            {name = "barrel_08",      model = _item_ranged.."/barrels/lasgun_pistol_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    muzzle_attachments = function(default)
        local attachments = {
            {id = "muzzle_01",      name = "Muzzle 1"},
            {id = "muzzle_02",      name = "Muzzle 2"}, -- buggy
            {id = "muzzle_03",      name = "Muzzle 3"},
            {id = "muzzle_04",      name = "Muzzle 4"},
            {id = "muzzle_05",      name = "Muzzle 5"},
            {id = "muzzle_06",      name = "Muzzle 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "muzzle_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "muzzle_default", model = ""},
            {name = "muzzle_01",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_01"},
            {name = "muzzle_02",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_02"}, -- buggy
            {name = "muzzle_03",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_03"},
            {name = "muzzle_04",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_04"},
            {name = "muzzle_05",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_05"},
            {name = "muzzle_06",      model = _item_ranged.."/muzzles/lasgun_pistol_muzzle_ml01"},
        }, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    rail_attachments = function(default)
        local attachments = {
            {id = "rail_01",        name = "Rail 1"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "rail_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    rail_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "rail_default", model = ""},
            {name = "rail_01",      model = _item_ranged.."/rails/lasgun_pistol_rail_01"},
        }, parent, angle, move, remove, type or "rail", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "lasgun_pistol_stock_01",         name = "Ventilation 1"},
            {id = "lasgun_pistol_stock_02",         name = "Ventilation 2"},
            {id = "lasgun_pistol_stock_03",         name = "Ventilation 3"},
            {id = "lasgun_pistol_stock_04",         name = "Ventilation 4"},
            {id = "lasgun_pistol_stock_ml01",         name = "Ventilation 5"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "lasgun_pistol_stock_default",    name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "lasgun_pistol_stock_default", model = ""},
            {name = "lasgun_pistol_stock_01",      model = _item_ranged.."/stocks/lasgun_pistol_stock_01"},
            {name = "lasgun_pistol_stock_02",      model = _item_ranged.."/stocks/lasgun_pistol_stock_02"},
            {name = "lasgun_pistol_stock_03",      model = _item_ranged.."/stocks/lasgun_pistol_stock_03"},
            {name = "lasgun_pistol_stock_04",      model = _item_ranged.."/stocks/lasgun_pistol_stock_04"},
            {name = "lasgun_pistol_stock_ml01",      model = _item_ranged.."/stocks/lasgun_pistol_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}