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
            {id = "power_sword_grip_01",      name = "Grip 1"},
            {id = "power_sword_grip_02",      name = "Grip 2"},
            {id = "power_sword_grip_03",      name = "Grip 3"},
            {id = "power_sword_grip_04",      name = "Grip 4"},
            {id = "power_sword_grip_05",      name = "Grip 5"},
            {id = "power_sword_grip_06",      name = "Grip 6"},
            {id = "power_sword_grip_ml01",      name = "Grip 7"},
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
            {name = "power_sword_grip_default", model = ""},
            {name = "power_sword_grip_01",      model = _item_melee.."/grips/power_sword_grip_01"},
            {name = "power_sword_grip_02",      model = _item_melee.."/grips/power_sword_grip_02"},
            {name = "power_sword_grip_03",      model = _item_melee.."/grips/power_sword_grip_03"},
            {name = "power_sword_grip_04",      model = _item_melee.."/grips/power_sword_grip_04"},
            {name = "power_sword_grip_05",      model = _item_melee.."/grips/power_sword_grip_05"},
            {name = "power_sword_grip_06",      model = _item_melee.."/grips/power_sword_grip_06"},
            {name = "power_sword_grip_ml01",      model = _item_melee.."/grips/power_sword_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    blade_attachments = function(default)
        local attachments = {
            {id = "power_sword_blade_01",      name = "Blade 1"},
            {id = "power_sword_blade_02",      name = "Blade 2"},
            {id = "power_sword_blade_03",      name = "Blade 3"},
            {id = "power_sword_blade_05",      name = "Blade 5"},
            {id = "power_sword_blade_06",      name = "Blade 6"},
            {id = "power_sword_blade_07",      name = "Blade 7"},
            {id = "power_sword_blade_ml01",      name = "Blade 8"},
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
            {name = "power_sword_blade_default", model = ""},
            {name = "power_sword_blade_01",      model = _item_melee.."/blades/power_sword_blade_01"},
            {name = "power_sword_blade_02",      model = _item_melee.."/blades/power_sword_blade_02"},
            {name = "power_sword_blade_03",      model = _item_melee.."/blades/power_sword_blade_03"},
            {name = "power_sword_blade_05",      model = _item_melee.."/blades/power_sword_blade_05"},
            {name = "power_sword_blade_06",      model = _item_melee.."/blades/power_sword_blade_06"},
            {name = "power_sword_blade_07",      model = _item_melee.."/blades/power_sword_blade_07"},
            {name = "power_sword_blade_ml01",    model = _item_melee.."/blades/power_sword_blade_ml01"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "power_sword_pommel_01",   name = "Power Sword 1"},
            {id = "power_sword_pommel_02",   name = "Power Sword 2"},
            {id = "power_sword_pommel_03",   name = "Power Sword 3"},
            {id = "power_sword_pommel_04",   name = "Power Sword 4"},
            {id = "power_sword_pommel_05",   name = "Power Sword 5"},
            {id = "power_sword_pommel_ml01", name = "Power Sword 6"},
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
            {name = "pommel_default",          model = ""},
            {name = "power_sword_pommel_01",   model = _item_melee.."/pommels/power_sword_pommel_01"},
            {name = "power_sword_pommel_02",   model = _item_melee.."/pommels/power_sword_pommel_02"},
            {name = "power_sword_pommel_03",   model = _item_melee.."/pommels/power_sword_pommel_03"},
            {name = "power_sword_pommel_04",   model = _item_melee.."/pommels/power_sword_pommel_05"},
            {name = "power_sword_pommel_05",   model = _item_melee.."/pommels/power_sword_pommel_06"},
            {name = "power_sword_pommel_ml01", model = _item_melee.."/pommels/power_sword_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    hilt_attachments = function(default)
        local attachments = {
            {id = "power_sword_hilt_01",      name = "Hilt 1"},
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
            {name = "power_sword_hilt_default", model = ""},
            {name = "power_sword_hilt_01",      model = _item_melee.."/hilts/power_sword_hilt_01"},
        }, parent, angle, move, remove, type or "hilt", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}