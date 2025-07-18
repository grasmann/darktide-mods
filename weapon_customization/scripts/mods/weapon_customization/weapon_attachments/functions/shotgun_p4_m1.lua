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
            {id = "assault_shotgun_receiver_01",       name = "Assault Shotgun Receiver 1"},
            {id = "assault_shotgun_receiver_02",       name = "Assault Shotgun Receiver 2"},
            {id = "assault_shotgun_receiver_03",       name = "Assault Shotgun Receiver 3"},
            {id = "assault_shotgun_receiver_deluxe01", name = "Assault Shotgun Receiver Deluxe01"},
            {id = "assault_shotgun_receiver_ml01",     name = "Assault Shotgun Receiver ML01"},
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
            {name = "assault_shotgun_receiver_01",       model = _item_ranged.."/recievers/assault_shotgun_receiver_01"},
            {name = "assault_shotgun_receiver_02",       model = _item_ranged.."/recievers/assault_shotgun_receiver_02"},
            {name = "assault_shotgun_receiver_03",       model = _item_ranged.."/recievers/assault_shotgun_receiver_03"},
            {name = "assault_shotgun_receiver_deluxe01", model = _item_ranged.."/recievers/assault_shotgun_receiver_deluxe01"},
            {name = "assault_shotgun_receiver_ml01",     model = _item_ranged.."/recievers/assault_shotgun_receiver_ml01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "assault_shotgun_grip_01",       name = "Assault Shotgun Grip 1"},
            {id = "assault_shotgun_grip_deluxe01", name = "Assault Shotgun Grip Deluxe01"},
            {id = "assault_shotgun_grip_ml01",     name = "Assault Shotgun Grip ML01"},
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
            {name = "grip_default",                  model = ""},
            {name = "assault_shotgun_grip_01",       model = _item_ranged.."/grips/assault_shotgun_grip_01"},
            {name = "assault_shotgun_grip_deluxe01", model = _item_ranged.."/grips/assault_shotgun_grip_deluxe01"},
            {name = "assault_shotgun_grip_ml01",     model = _item_ranged.."/grips/assault_shotgun_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    underbarrel_attachments = function(default)
        local attachments = {
            {id = "assault_shotgun_underbarrel_01",      name = "Assault Shotgun Underbarrel 1"},
            {id = "assault_shotgun_underbarrel_02",      name = "Assault Shotgun Underbarrel 2"},
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
            {name = "assault_shotgun_underbarrel_01",      model = _item_ranged.."/underbarrels/assault_shotgun_underbarrel_01"},
            {name = "assault_shotgun_underbarrel_02",      model = _item_ranged.."/underbarrels/assault_shotgun_underbarrel_02"},
            {name = "no_underbarrel",      model = ""},
        }, parent, angle, move, remove, type or "underbarrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}