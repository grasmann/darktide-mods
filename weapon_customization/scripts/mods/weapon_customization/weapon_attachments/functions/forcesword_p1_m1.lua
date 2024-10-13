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
            {id = "force_sword_grip_01",      name = "Grip 1"},
            {id = "force_sword_grip_02",      name = "Grip 2"},
            {id = "force_sword_grip_03",      name = "Grip 3"},
            {id = "force_sword_grip_04",      name = "Grip 4"},
            {id = "force_sword_grip_05",      name = "Grip 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_grip_default", model = ""},
            {name = "force_sword_grip_01",      model = _item_melee.."/grips/force_sword_grip_01"},
            {name = "force_sword_grip_02",      model = _item_melee.."/grips/force_sword_grip_02"},
            {name = "force_sword_grip_03",      model = _item_melee.."/grips/force_sword_grip_03"},
            {name = "force_sword_grip_04",      model = _item_melee.."/grips/force_sword_grip_04"},
            {name = "force_sword_grip_05",      model = _item_melee.."/grips/force_sword_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    blade_attachments = function(default)
        local attachments = {
            {id = "force_sword_blade_01",      name = "Blade 1"},
            {id = "force_sword_blade_02",      name = "Blade 2"},
            {id = "force_sword_blade_03",      name = "Blade 3"},
            {id = "force_sword_blade_04",      name = "Blade 4"},
            {id = "force_sword_blade_05",      name = "Blade 5"},
            {id = "force_sword_blade_ml01",      name = "Blade 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_blade_default", model = ""},
            {name = "force_sword_blade_01",      model = _item_melee.."/blades/force_sword_blade_01"},
            {name = "force_sword_blade_02",      model = _item_melee.."/blades/force_sword_blade_02"},
            {name = "force_sword_blade_03",      model = _item_melee.."/blades/force_sword_blade_03"},
            {name = "force_sword_blade_04",      model = _item_melee.."/blades/force_sword_blade_04"},
            {name = "force_sword_blade_05",      model = _item_melee.."/blades/force_sword_blade_05"},
            {name = "force_sword_blade_ml01",      model = _item_melee.."/blades/force_sword_blade_ml01"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "force_sword_pommel_01", name = "Force Sword 1"},
            {id = "force_sword_pommel_02", name = "Force Sword 2"},
            {id = "force_sword_pommel_03", name = "Force Sword 3"},
            {id = "force_sword_pommel_04", name = "Force Sword 4"},
            {id = "force_sword_pommel_05", name = "Force Sword 5"},
            {id = "force_sword_pommel_ml01", name = "Force Sword 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "pommel_default",        model = ""},
            {name = "force_sword_pommel_01", model = _item_melee.."/pommels/force_sword_pommel_01"},
            {name = "force_sword_pommel_02", model = _item_melee.."/pommels/force_sword_pommel_02"},
            {name = "force_sword_pommel_03", model = _item_melee.."/pommels/force_sword_pommel_03"},
            {name = "force_sword_pommel_04", model = _item_melee.."/pommels/force_sword_pommel_04"},
            {name = "force_sword_pommel_05", model = _item_melee.."/pommels/force_sword_pommel_05"},
            {name = "force_sword_pommel_ml01", model = _item_melee.."/pommels/force_sword_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    hilt_attachments = function(default)
        local attachments = {
            {id = "force_sword_hilt_01",      name = "Hilt 1"},
            {id = "force_sword_hilt_02",      name = "Hilt 2"},
            {id = "force_sword_hilt_03",      name = "Hilt 3"},
            {id = "force_sword_hilt_04",      name = "Hilt 4"},
            {id = "force_sword_hilt_05",      name = "Hilt 5"},
            {id = "force_sword_hilt_06",      name = "Hilt 6"},
            {id = "force_sword_hilt_07",      name = "Hilt 7"},
            {id = "force_sword_hilt_ml01",      name = "Hilt 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "force_sword_hilt_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    hilt_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "force_sword_hilt_default", model = ""},
            {name = "force_sword_hilt_01",      model = _item_melee.."/hilts/force_sword_hilt_01"},
            {name = "force_sword_hilt_02",      model = _item_melee.."/hilts/force_sword_hilt_02"},
            {name = "force_sword_hilt_03",      model = _item_melee.."/hilts/force_sword_hilt_03"},
            {name = "force_sword_hilt_04",      model = _item_melee.."/hilts/force_sword_hilt_04"},
            {name = "force_sword_hilt_05",      model = _item_melee.."/hilts/force_sword_hilt_05"},
            {name = "force_sword_hilt_06",      model = _item_melee.."/hilts/force_sword_hilt_06"},
            {name = "force_sword_hilt_07",      model = _item_melee.."/hilts/force_sword_hilt_07"},
            {name = "force_sword_hilt_ml01",      model = _item_melee.."/hilts/force_sword_hilt_ml01"},
        }, parent, angle, move, remove, type or "hilt", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}