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
            {id = "sabre_grip_01",      name = "Grip 1"},
            {id = "sabre_grip_02",      name = "Grip 2"},
            {id = "sabre_grip_03",      name = "Grip 3"},
            {id = "sabre_grip_04",      name = "Grip 4"},
            {id = "sabre_grip_05",      name = "Grip 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sabre_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sabre_grip_default", model = ""},
            {name = "sabre_grip_01",      model = _item_melee.."/grips/sabre_grip_01"},
            {name = "sabre_grip_02",      model = _item_melee.."/grips/sabre_grip_02"},
            {name = "sabre_grip_03",      model = _item_melee.."/grips/sabre_grip_03"},
            {name = "sabre_grip_04",      model = _item_melee.."/grips/sabre_grip_04"},
            {name = "sabre_grip_05",      model = _item_melee.."/grips/sabre_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    body_attachments = function(default)
        local attachments = {
            {id = "sabre_blade_01",      name = "Blade 1"},
            {id = "sabre_blade_02",      name = "Blade 2"},
            {id = "sabre_blade_03",      name = "Blade 3"},
            {id = "sabre_blade_04",      name = "Blade 4"},
            {id = "sabre_blade_05",      name = "Blade 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sabre_blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sabre_blade_default", model = ""},
            {name = "sabre_blade_01",      model = _item_melee.."/blades/sabre_blade_01"},
            {name = "sabre_blade_02",      model = _item_melee.."/blades/sabre_blade_02"},
            {name = "sabre_blade_03",      model = _item_melee.."/blades/sabre_blade_03"},
            {name = "sabre_blade_04",      model = _item_melee.."/blades/sabre_blade_04"},
            {name = "sabre_blade_05",      model = _item_melee.."/blades/sabre_blade_05"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}