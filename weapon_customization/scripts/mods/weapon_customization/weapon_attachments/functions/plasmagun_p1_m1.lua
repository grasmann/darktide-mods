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
            {id = "receiver_01", name = "Receiver 1"},
            {id = "receiver_02", name = "Receiver 2"},
            {id = "receiver_03", name = "Receiver 3"},
            {id = "receiver_04", name = "Receiver 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "receiver_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/plasma_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/plasma_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/plasma_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/plasma_rifle_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
            {id = "magazine_03", name = "Magazine 3"},
            {id = "magazine_04", name = "Magazine 4"},
            {id = "magazine_05", name = "Magazine 5"},
            {id = "magazine_06", name = "Magazine 6"},
            {id = "magazine_07", name = "Magazine 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "magazine_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/plasma_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/plasma_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/melta_gun_magazine_01"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/plasma_rifle_magazine_03"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/plasma_rifle_magazine_04"},
            {name = "magazine_06",      model = _item_ranged.."/magazines/plasma_rifle_magazine_06"},
            {name = "magazine_07",      model = _item_ranged.."/magazines/plasma_rifle_magazine_ml01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01", name = "Barrel 1"},
            {id = "barrel_02", name = "Barrel 2"},
            {id = "barrel_03", name = "Barrel 3"},
            {id = "barrel_04", name = "Barrel 4"},
            {id = "barrel_05", name = "Barrel 5"},
            {id = "barrel_06", name = "Barrel 6"},
            {id = "barrel_07", name = "Barrel 7"},
            {id = "barrel_08", name = "Barrel 8"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/plasma_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/plasma_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/plasma_rifle_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/plasma_rifle_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/plasma_rifle_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/plasma_rifle_barrel_07"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/plasma_rifle_barrel_08"},
            {name = "barrel_08",      model = _item_ranged.."/barrels/plasma_rifle_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        local attachments = {
            {id = "plasma_rifle_stock_01", name = "Ventilation 1"},
            {id = "plasma_rifle_stock_02", name = "Ventilation 2"},
            {id = "plasma_rifle_stock_03", name = "Ventilation 3"},
            {id = "plasma_rifle_stock_04", name = "Ventilation 4"},
            {id = "plasma_rifle_stock_05", name = "Ventilation 5"},
            {id = "plasma_rifle_stock_07", name = "Ventilation 6"},
            {id = "plasma_rifle_stock_08", name = "Ventilation 7"},
            {id = "plasma_rifle_stock_ml01", name = "Ventilation 8"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "plasma_rifle_stock_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "plasma_rifle_stock_default", model = ""},
            {name = "plasma_rifle_stock_01",      model = _item_ranged.."/stocks/plasma_rifle_stock_01"},
            {name = "plasma_rifle_stock_02",      model = _item_ranged.."/stocks/plasma_rifle_stock_02"},
            {name = "plasma_rifle_stock_03",      model = _item_ranged.."/stocks/plasma_rifle_stock_03"},
            {name = "plasma_rifle_stock_04",      model = _item_ranged.."/stocks/plasma_rifle_stock_04"},
            {name = "plasma_rifle_stock_05",      model = _item_ranged.."/stocks/plasma_rifle_stock_05"},
            {name = "plasma_rifle_stock_07",      model = _item_ranged.."/stocks/plasma_rifle_stock_07"},
            {name = "plasma_rifle_stock_08",      model = _item_ranged.."/stocks/plasma_rifle_stock_08"},
            {name = "plasma_rifle_stock_ml01",      model = _item_ranged.."/stocks/plasma_rifle_stock_ml01"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Plasmagun Grip 1"},
            {id = "grip_02", name = "Plasmagun Grip 2"},
            {id = "grip_03", name = "Plasmagun Grip 3"},
            {id = "grip_04", name = "Plasmagun Grip 4"},
            {id = "grip_05", name = "Plasmagun Grip 5"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "grip_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_ranged.."/grips/plasma_rifle_grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/plasma_rifle_grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/plasma_rifle_grip_03"},
            {name = "grip_04",      model = _item_ranged.."/grips/plasma_rifle_grip_04"},
            {name = "grip_05",      model = _item_ranged.."/grips/plasma_rifle_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end
}