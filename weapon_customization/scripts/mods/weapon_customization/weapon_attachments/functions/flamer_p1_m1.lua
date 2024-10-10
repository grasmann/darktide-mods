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
            {id = "receiver_01",      name = "Flamer 1"},
            {id = "receiver_02",      name = "Flamer 2"},
            {id = "receiver_03",      name = "Flamer 3"},
            {id = "receiver_04",      name = "Flamer 4"},
            {id = "receiver_05",      name = "Flamer 5"},
            {id = "receiver_06",      name = "Flamer 6"},
            {id = "receiver_07",      name = "Flamer 7"},
            {id = "receiver_08",      name = "Flamer 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/flamer_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/flamer_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/flamer_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/flamer_rifle_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/flamer_rifle_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/flamer_rifle_receiver_06"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/flamer_rifle_receiver_07"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/flamer_rifle_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",      name = "Flamer 1"},
            {id = "magazine_02",      name = "Flamer 2"},
            {id = "magazine_03",      name = "Flamer 3"},
            {id = "magazine_04",      name = "Flamer 4"},
            {id = "magazine_05",      name = "Flamer 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/flamer_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/flamer_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/flamer_rifle_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/flamer_rifle_magazine_04"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/flamer_rifle_magazine_ml01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Flamer 1"},
            {id = "barrel_02",      name = "Flamer 2"},
            {id = "barrel_03",      name = "Flamer 3"},
            {id = "barrel_04",      name = "Flamer 4"},
            {id = "barrel_05",      name = "Flamer 5"},
            {id = "barrel_06",      name = "Flamer 6"},
            {id = "barrel_07",      name = "Flamer 7"},
            {id = "barrel_08",      name = "Flamer 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/flamer_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/flamer_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/flamer_rifle_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/flamer_rifle_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/flamer_rifle_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/flamer_rifle_barrel_06"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/flamer_rifle_barrel_07"},
            {name = "barrel_08",      model = _item_ranged.."/barrels/flamer_rifle_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}