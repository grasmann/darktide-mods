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
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01", name = "Ripper Barrel 1"},
            {id = "barrel_02", name = "Ripper Barrel 2"},
            {id = "barrel_03", name = "Ripper Barrel 3"},
            {id = "barrel_04", name = "Ripper Barrel 4"},
            {id = "barrel_05", name = "Ripper Barrel 5"},
            {id = "barrel_06", name = "Ripper Barrel 6"},
            {id = "barrel_07", name = "Ripper Barrel 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_06"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01", name = "Receiver 1"},
            {id = "receiver_02", name = "Receiver 2"},
            {id = "receiver_03", name = "Receiver 3"},
            {id = "receiver_04", name = "Receiver 4"},
            {id = "receiver_05", name = "Receiver 5"},
            {id = "receiver_06", name = "Receiver 6"},
            {id = "receiver_07", name = "Receiver 7"},
            {id = "receiver_08", name = "Receiver 8"},
            {id = "receiver_09", name = "Receiver 9"},
            {id = "receiver_10", name = "Receiver 10"},
            {id = "receiver_11", name = "Receiver 11"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_06"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_07"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_08"},
            {name = "receiver_09",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_09"},
            {name = "receiver_10",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_ml01"},
            {name = "receiver_11",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_11"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move)
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
            {id = "magazine_08", name = "Magazine 8"},
            {id = "magazine_09", name = "Magazine 9"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_04"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_05"},
            {name = "magazine_06",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_06"},
            {name = "magazine_07",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_07"},
            {name = "magazine_08",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_ml01"},
            {name = "magazine_09",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_09"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    handle_attachments = function(default)
        local attachments = {
            {id = "handle_01", name = "Handle 1"},
            {id = "handle_02", name = "Handle 2"},
            {id = "handle_03", name = "Handle 3"},
            {id = "handle_04", name = "Handle 4"},
            {id = "handle_05", name = "Handle 5"},
            {id = "handle_06", name = "Handle 6"},
            {id = "handle_07", name = "Handle 7"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "handle_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    handle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "handle_default", model = ""},
            {name = "handle_01",      model = _item_ranged.."/handles/rippergun_rifle_handle_01"},
            {name = "handle_02",      model = _item_ranged.."/handles/rippergun_rifle_handle_02"},
            {name = "handle_03",      model = _item_ranged.."/handles/rippergun_rifle_handle_03"},
            {name = "handle_04",      model = _item_ranged.."/handles/rippergun_rifle_handle_04"},
            {name = "handle_05",      model = _item_ranged.."/handles/rippergun_rifle_handle_05"},
            {name = "handle_06",      model = _item_ranged.."/handles/rippergun_rifle_handle_ml01"},
            {name = "handle_07",      model = _item_ranged.."/handles/rippergun_rifle_handle_07"},
        }, parent, angle, move, remove, type or "handle", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
}