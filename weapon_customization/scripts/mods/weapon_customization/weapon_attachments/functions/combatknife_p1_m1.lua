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
            {id = "knife_grip_01",      name = "Combat Knife 1"},
            {id = "knife_grip_02",      name = "Combat Knife 2"},
            {id = "knife_grip_03",      name = "Combat Knife 3"},
            {id = "knife_grip_04",      name = "Combat Knife 4"},
            {id = "knife_grip_05",      name = "Combat Knife 5"},
            {id = "knife_grip_06",      name = "Combat Knife 6"},
            {id = "knife_grip_07",      name = "Combat Knife 7"},
            {id = "combat_knife_grip_ml01",      name = "Combat Knife 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "knife_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "knife_grip_default", model = ""},
            {name = "knife_grip_01",      model = _item_melee.."/grips/combat_knife_grip_01"},
            {name = "knife_grip_02",      model = _item_melee.."/grips/combat_knife_grip_02"},
            {name = "knife_grip_03",      model = _item_melee.."/grips/combat_knife_grip_03"},
            {name = "knife_grip_04",      model = _item_melee.."/grips/combat_knife_grip_04"},
            {name = "knife_grip_05",      model = _item_melee.."/grips/combat_knife_grip_05"},
            {name = "knife_grip_06",      model = _item_melee.."/grips/combat_knife_grip_06"},
            {name = "knife_grip_07",      model = _item_melee.."/grips/combat_knife_grip_07"},
            {name = "combat_knife_grip_ml01",      model = _item_melee.."/grips/combat_knife_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    body_attachments = function(default)
        local attachments = {
            {id = "knife_body_01",      name = "Combat Knife 1"},
            {id = "knife_body_02",      name = "Combat Knife 2"},
            {id = "knife_body_03",      name = "Combat Knife 3"},
            {id = "knife_body_04",      name = "Combat Knife 4"},
            {id = "knife_body_05",      name = "Combat Knife 5"},
            {id = "knife_body_06",      name = "Combat Knife 6"},
            {id = "knife_body_07",      name = "Combat Knife 7"},
            {id = "knife_body_08",      name = "Combat Knife 8"},
            {id = "knife_body_09",      name = "Combat Knife 9"},
            {id = "combat_knife_blade_ml01", name = "Combat Knife 10"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "knife_body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "knife_body_default", model = ""},
            {name = "knife_body_01",      model = _item_melee.."/blades/combat_knife_blade_01"},
            {name = "knife_body_02",      model = _item_melee.."/blades/combat_knife_blade_02"},
            {name = "knife_body_03",      model = _item_melee.."/blades/combat_knife_blade_03"},
            {name = "knife_body_04",      model = _item_melee.."/blades/combat_knife_blade_04"},
            {name = "knife_body_05",      model = _item_melee.."/blades/combat_knife_blade_05"},
            {name = "knife_body_06",      model = _item_melee.."/blades/combat_knife_blade_06"},
            {name = "knife_body_07",      model = _item_melee.."/blades/combat_knife_blade_07"},
            {name = "knife_body_08",      model = _item_melee.."/blades/combat_knife_blade_08"},
            {name = "knife_body_09",      model = _item_melee.."/blades/combat_knife_blade_09"},
            {name = "combat_knife_blade_ml01",      model = _item_melee.."/blades/combat_knife_blade_ml01"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}