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
            {id = "heavystubber_p2_barrel_01", name = "Barrel 1"},
            {id = "heavystubber_p2_barrel_02", name = "Barrel 2"},
            {id = "heavystubber_p2_barrel_03", name = "Barrel 3"},
            {id = "heavystubber_p2_barrel_04", name = "Barrel 4"},
            {id = "heavystubber_p2_barrel_05", name = "Barrel 5"},
            {id = "heavystubber_p2_barrel_06", name = "Barrel 6"},
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
            {name = "barrel_default",            model = ""},
            {name = "heavystubber_p2_barrel_01", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_01"},
            {name = "heavystubber_p2_barrel_02", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_02"},
            {name = "heavystubber_p2_barrel_03", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_03"},
            {name = "heavystubber_p2_barrel_04", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_ml01"},
            {name = "heavystubber_p2_barrel_05", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_ml02"},
            {name = "heavystubber_p2_barrel_06", model = _item_ranged.."/barrels/stubgun_ogryn_barrel_04"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "heavystubber_p2_receiver_01", name = "Receiver 1"},
            {id = "heavystubber_p2_receiver_02", name = "Receiver 2"},
            {id = "heavystubber_p2_receiver_03", name = "Receiver 3"},
            {id = "heavystubber_p2_receiver_04", name = "Receiver 4"},
            {id = "heavystubber_p2_receiver_05", name = "Receiver 5"},
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
            {name = "receiver_default",            model = ""},
            {name = "heavystubber_p2_receiver_01", model = _item_ranged.."/recievers/stubgun_ogryn_receiver_01"},
            {name = "heavystubber_p2_receiver_02", model = _item_ranged.."/recievers/stubgun_ogryn_receiver_02"},
            {name = "heavystubber_p2_receiver_03", model = _item_ranged.."/recievers/stubgun_ogryn_receiver_03"},
            {name = "heavystubber_p2_receiver_04", model = _item_ranged.."/recievers/stubgun_ogryn_receiver_ml01"},
            {name = "heavystubber_p2_receiver_05", model = _item_ranged.."/recievers/stubgun_ogryn_receiver_ml02"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "heavystubber_p2_magazine_01", name = "Magazine 1"},
            {id = "heavystubber_p2_magazine_02", name = "Magazine 2"},
            {id = "heavystubber_p2_magazine_03", name = "Magazine 3"},
            {id = "heavystubber_p2_magazine_04", name = "Magazine 4"},
            {id = "heavystubber_p2_magazine_05", name = "Magazine 5"},
            {id = "heavystubber_p2_magazine_06", name = "Magazine 6"},
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
            {name = "magazine_default",            model = ""},
            {name = "heavystubber_p2_magazine_01", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_01"},
            {name = "heavystubber_p2_magazine_02", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_02"},
            {name = "heavystubber_p2_magazine_03", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_03"},
            {name = "heavystubber_p2_magazine_04", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_ml01"},
            {name = "heavystubber_p2_magazine_05", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_ml02"},
            {name = "heavystubber_p2_magazine_06", model = _item_ranged.."/magazines/stubgun_ogryn_magazine_04"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "heavystubber_p2_grip_01", name = "Light Grip 1"},
            {id = "heavystubber_p2_grip_02", name = "Light Grip 2"},
            {id = "heavystubber_p2_grip_03", name = "Light Grip 3"},
            {id = "heavystubber_p2_grip_04", name = "Light Grip 4"},
            {id = "heavystubber_p2_grip_05", name = "Light Grip 5"},
            {id = "heavystubber_p2_grip_06", name = "Light Grip 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "grip_default",            model = ""},
            {name = "heavystubber_p2_grip_01", model = _item_ranged.."/grips/stubgun_ogryn_grip_01"},
            {name = "heavystubber_p2_grip_02", model = _item_ranged.."/grips/stubgun_ogryn_grip_02"},
            {name = "heavystubber_p2_grip_03", model = _item_ranged.."/grips/stubgun_ogryn_grip_03"},
            {name = "heavystubber_p2_grip_04", model = _item_ranged.."/grips/stubgun_ogryn_grip_ml01"},
            {name = "heavystubber_p2_grip_05", model = _item_ranged.."/grips/stubgun_ogryn_grip_ml02"},
            {name = "heavystubber_p2_grip_06", model = _item_ranged.."/grips/stubgun_ogryn_grip_04"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}