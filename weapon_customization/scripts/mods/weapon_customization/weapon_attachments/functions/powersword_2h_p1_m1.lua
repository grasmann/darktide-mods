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
    grip_attachments = function(default)
        local attachments = {
            {id = "2h_power_sword_grip_01",   name = "2H Power Sword 1"},
            {id = "2h_power_sword_grip_02",   name = "2H Power Sword 2"},
            {id = "2h_power_sword_grip_03",   name = "2H Power Sword 3"},
            -- {id = "2h_power_sword_grip_ml01", name = "2H Power Sword 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "power_sword_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "grip_default",             model = ""},
            {name = "2h_power_sword_grip_01",   model = _item_melee.."/grips/2h_power_sword_grip_01"},
            {name = "2h_power_sword_grip_02",   model = _item_melee.."/grips/2h_power_sword_grip_02"},
            {name = "2h_power_sword_grip_03",   model = _item_melee.."/grips/2h_power_sword_grip_03"},
            -- {name = "2h_power_sword_grip_ml01", model = _item_melee.."/grips/2h_power_sword_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    blade_attachments = function(default)
        local attachments = {
            {id = "2h_power_sword_blade_01",   name = "2H Power Sword 1"},
            {id = "2h_power_sword_blade_02",   name = "2H Power Sword 2"},
            {id = "2h_power_sword_blade_03",   name = "2H Power Sword 3"},
            {id = "2h_power_sword_blade_ml01", name = "2H Power Sword 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "power_sword_blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "blade_default",             model = ""},
            {name = "2h_power_sword_blade_01",   model = _item_melee.."/blades/2h_power_sword_blade_01"},
            {name = "2h_power_sword_blade_02",   model = _item_melee.."/blades/2h_power_sword_blade_02"},
            {name = "2h_power_sword_blade_03",   model = _item_melee.."/blades/2h_power_sword_blade_03"},
            {name = "2h_power_sword_blade_ml01", model = _item_melee.."/blades/2h_power_sword_blade_ml01"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "2h_power_sword_pommel_01",   name = "2H Power Sword 1"},
            {id = "2h_power_sword_pommel_02",   name = "2H Power Sword 2"},
            {id = "2h_power_sword_pommel_03",   name = "2H Power Sword 3"},
            {id = "2h_power_sword_pommel_ml01", name = "2H Power Sword 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "pommel_default",             model = ""},
            {name = "2h_power_sword_pommel_01",   model = _item_melee.."/pommels/2h_power_sword_pommel_01"},
            {name = "2h_power_sword_pommel_02",   model = _item_melee.."/pommels/2h_power_sword_pommel_02"},
            {name = "2h_power_sword_pommel_03",   model = _item_melee.."/pommels/2h_power_sword_pommel_03"},
            {name = "2h_power_sword_pommel_ml01", model = _item_melee.."/pommels/2h_power_sword_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    hilt_attachments = function(default)
        local attachments = {
            {id = "2h_power_sword_hilt_01",   name = "2H Power Sword 1"},
            {id = "2h_power_sword_hilt_02",   name = "2H Power Sword 2"},
            {id = "2h_power_sword_hilt_03",   name = "2H Power Sword 3"},
            {id = "2h_power_sword_hilt_ml01", name = "2H Power Sword 4"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "power_sword_hilt_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    hilt_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "hilt_default",             model = ""},
            {name = "2h_power_sword_hilt_01",   model = _item_melee.."/hilts/2h_power_sword_hilt_01"},
            {name = "2h_power_sword_hilt_02",   model = _item_melee.."/hilts/2h_power_sword_hilt_02"},
            {name = "2h_power_sword_hilt_03",   model = _item_melee.."/hilts/2h_power_sword_hilt_03"},
            {name = "2h_power_sword_hilt_ml01", model = _item_melee.."/hilts/2h_power_sword_hilt_ml01"},
        }, parent, angle, move, remove, type or "hilt", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}