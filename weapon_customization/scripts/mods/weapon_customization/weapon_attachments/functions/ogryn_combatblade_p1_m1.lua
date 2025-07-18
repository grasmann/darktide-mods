local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
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
    blade_attachments = function(default)
        local attachments = {
            {id = "blade_01", name = "Blade 1"},
            {id = "blade_02", name = "Blade 2"},
            {id = "blade_03", name = "Blade 3"},
            {id = "blade_04", name = "Blade 4"},
            {id = "blade_05", name = "Blade 5"},
            {id = "blade_06", name = "Blade 6"},
            {id = "blade_07", name = "Blade 7"},
            {id = "blade_08", name = "Blade 8"},
            {id = "blade_09", name = "Blade 9"},
            {id = "combat_blade_blade_ml01", name = "Blade 10"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "blade_default", model = ""},
            {name = "blade_01",      model = _item_melee.."/blades/combat_blade_blade_01"},
            {name = "blade_02",      model = _item_melee.."/blades/combat_blade_blade_02"},
            {name = "blade_03",      model = _item_melee.."/blades/combat_blade_blade_03"},
            {name = "blade_04",      model = _item_melee.."/blades/combat_blade_blade_04"},
            {name = "blade_05",      model = _item_melee.."/blades/combat_blade_blade_05"},
            {name = "blade_06",      model = _item_melee.."/blades/combat_blade_blade_06"},
            {name = "blade_07",      model = _item_melee.."/blades/combat_blade_blade_07"},
            {name = "blade_08",      model = _item_melee.."/blades/combat_blade_blade_08"},
            {name = "blade_09",      model = _item_melee.."/blades/combat_blade_blade_10"},
            {name = "combat_blade_blade_ml01",      model = _item_melee.."/blades/combat_blade_blade_ml01"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
            {id = "grip_04", name = "Grip 4"},
            {id = "grip_05", name = "Grip 5"},
            {id = "grip_06", name = "Grip 6"},
            {id = "grip_07", name = "Grip 7"},
            {id = "grip_08", name = "Grip 8"},
            {id = "grip_09", name = "Grip 9"},
            {id = "combat_blade_grip_ml01", name = "Grip 10"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_melee.."/grips/combat_blade_grip_01"},
            {name = "grip_02",      model = _item_melee.."/grips/combat_blade_grip_02"},
            {name = "grip_03",      model = _item_melee.."/grips/combat_blade_grip_03"},
            {name = "grip_04",      model = _item_melee.."/grips/combat_blade_grip_04"},
            {name = "grip_05",      model = _item_melee.."/grips/combat_blade_grip_05"},
            {name = "grip_06",      model = _item_melee.."/grips/combat_blade_grip_06"},
            {name = "grip_07",      model = _item_melee.."/grips/combat_blade_grip_07"},
            {name = "grip_08",      model = _item_melee.."/grips/combat_blade_grip_08"},
            {name = "grip_09",      model = _item_melee.."/grips/combat_blade_grip_09"},
            {name = "combat_blade_grip_ml01",      model = _item_melee.."/grips/combat_blade_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
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
            {id = "handle_08", name = "Handle 8"},
            {id = "handle_09", name = "Handle 9"},
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
            {name = "handle_01",      model = _item_ranged.."/handles/combat_blade_handle_01"},
            {name = "handle_02",      model = _item_ranged.."/handles/combat_blade_handle_02"},
            {name = "handle_03",      model = _item_ranged.."/handles/combat_blade_handle_03"},
            {name = "handle_04",      model = _item_ranged.."/handles/combat_blade_handle_04"},
            {name = "handle_05",      model = _item_ranged.."/handles/combat_blade_handle_05"},
            {name = "handle_06",      model = _item_ranged.."/handles/combat_blade_handle_06"},
            {name = "handle_07",      model = _item_ranged.."/handles/combat_blade_handle_07"},
            {name = "handle_08",      model = _item_ranged.."/handles/combat_blade_handle_08"},
            {name = "handle_09",      model = _item_ranged.."/handles/combat_blade_handle_09"},
        }, parent, angle, move, remove, type or "handle", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}