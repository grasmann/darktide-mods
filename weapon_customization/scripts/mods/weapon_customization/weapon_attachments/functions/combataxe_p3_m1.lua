local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_melee = _item.."/melee"
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
    head_attachments = function(default)
        local attachments = {
            {id = "shovel_head_01",      name = "Head 1"},
            {id = "shovel_head_02",      name = "Head 2"},
            {id = "shovel_head_03",      name = "Head 3"},
            {id = "shovel_head_04",      name = "Head 4"},
            {id = "shovel_head_05",      name = "Head 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shovel_head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shovel_head_default", model = ""},
            {name = "shovel_head_01",      model = _item_melee.."/heads/shovel_head_01"},
            {name = "shovel_head_01",      model = _item_melee.."/heads/shovel_head_02"},
            {name = "shovel_head_01",      model = _item_melee.."/heads/shovel_head_03"},
            {name = "shovel_head_01",      model = _item_melee.."/heads/shovel_head_04"},
            {name = "shovel_head_01",      model = _item_melee.."/heads/shovel_head_05"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    grip_attachments = function(default)
        local attachments = {
            {id = "shovel_grip_01",      name = "Grip 1"},
            {id = "shovel_grip_02",      name = "Grip 2"},
            {id = "shovel_grip_03",      name = "Grip 3"},
            {id = "shovel_grip_04",      name = "Grip 4"},
            {id = "shovel_grip_05",      name = "Grip 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shovel_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shovel_grip_default", model = ""},
            {name = "shovel_grip_01",      model = _item_melee.."/grips/shovel_grip_01"},
            {name = "shovel_grip_02",      model = _item_melee.."/grips/shovel_grip_02"},
            {name = "shovel_grip_03",      model = _item_melee.."/grips/shovel_grip_03"},
            {name = "shovel_grip_04",      model = _item_melee.."/grips/shovel_grip_04"},
            {name = "shovel_grip_05",      model = _item_melee.."/grips/shovel_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    pommel_attachments = function(default)
        local attachments = {
            {id = "shovel_pommel_01",      name = "Pommel 1"},
            {id = "shovel_pommel_02",      name = "Pommel 2"},
            {id = "shovel_pommel_03",      name = "Pommel 3"},
            {id = "shovel_pommel_04",      name = "Pommel 4"},
            {id = "shovel_pommel_05",      name = "Pommel 5"},
            {id = "shovel_pommel_06",      name = "Krieg"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shovel_pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shovel_pommel_default", model = ""},
            {name = "shovel_pommel_01",      model = _item_melee.."/pommels/shovel_pommel_01"},
            {name = "shovel_pommel_02",      model = _item_melee.."/pommels/shovel_pommel_02"},
            {name = "shovel_pommel_03",      model = _item_melee.."/pommels/shovel_pommel_03"},
            {name = "shovel_pommel_04",      model = _item_melee.."/pommels/shovel_pommel_04"},
            {name = "shovel_pommel_05",      model = _item_melee.."/pommels/shovel_pommel_05"},
            {name = "shovel_pommel_06",      model = _item_melee.."/full/krieg_shovel_full_01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end
}