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
            {id = "barrel_01", name = "Heavy Barrel 1"},
            {id = "barrel_02", name = "Heavy Barrel 2"},
            {id = "barrel_03", name = "Heavy Barrel 3"},
            {id = "barrel_04", name = "Heavy Barrel 4"},
            {id = "barrel_05", name = "Heavy Barrel 5"},
            {id = "barrel_06", name = "Light Barrel 1"},
            {id = "barrel_07", name = "Light Barrel 2"},
            {id = "barrel_08", name = "Light Barrel 3"},
            {id = "barrel_09", name = "Heavy Barrel 6"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/stubgun_ogryn_barrel_01"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/stubgun_ogryn_barrel_02"},
            {name = "barrel_08",      model = _item_ranged.."/barrels/stubgun_ogryn_barrel_03"},
            {name = "barrel_09",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01", name = "Heavy Receiver 1"},
            {id = "receiver_02", name = "Heavy Receiver 2"},
            {id = "receiver_03", name = "Heavy Receiver 3"},
            {id = "receiver_04", name = "Heavy Receiver 4"},
            {id = "receiver_05", name = "Light Receiver 1"},
            {id = "receiver_06", name = "Light Receiver 2"},
            {id = "receiver_07", name = "Light Receiver 3"},
            {id = "receiver_08", name = "Heavy Receiver 5"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/stubgun_ogryn_receiver_01"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/stubgun_ogryn_receiver_02"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/stubgun_ogryn_receiver_03"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Heavy Magazine 1"},
            {id = "magazine_02", name = "Heavy Magazine 2"},
            {id = "magazine_03", name = "Heavy Magazine 3"},
            {id = "magazine_04", name = "Heavy Magazine 4"},
            {id = "magazine_05", name = "Heavy Magazine 5"},
            {id = "magazine_06", name = "Light Magazine 1"},
            {id = "magazine_07", name = "Light Magazine 2"},
            {id = "magazine_08", name = "Light Magazine 3"},
            {id = "magazine_09", name = "Heavy Magazine 6"},
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
            {name = "magazine_01",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_04"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_05"},
            {name = "magazine_06",      model = _item_ranged.."/magazines/stubgun_ogryn_magazine_01"},
            {name = "magazine_07",      model = _item_ranged.."/magazines/stubgun_ogryn_magazine_02"},
            {name = "magazine_08",      model = _item_ranged.."/magazines/stubgun_ogryn_magazine_03"},
            {name = "magazine_09",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_ml01"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Heavy Grip 1"},
            {id = "grip_02", name = "Heavy Grip 2"},
            {id = "grip_03", name = "Heavy Grip 3"},
            {id = "grip_04", name = "Light Grip 1"},
            {id = "grip_05", name = "Light Grip 2"},
            {id = "grip_06", name = "Light Grip 3"},
            {id = "grip_07", name = "Heavy Grip 4"},
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
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_03"},
            {name = "grip_04",      model = _item_ranged.."/grips/stubgun_ogryn_grip_01"},
            {name = "grip_05",      model = _item_ranged.."/grips/stubgun_ogryn_grip_02"},
            {name = "grip_06",      model = _item_ranged.."/grips/stubgun_ogryn_grip_03"},
            {name = "grip_07",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}