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
            {id = "axe_grip_01", name = "Combat Axe 1"},
            {id = "axe_grip_02", name = "Combat Axe 2"},
            {id = "axe_grip_03", name = "Combat Axe 3"},
            {id = "axe_grip_04", name = "Combat Axe 4"},
            {id = "axe_grip_05", name = "Combat Axe 5"},
            {id = "axe_grip_06", name = "Combat Axe 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default",    name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "axe_grip_01",  model = _item_melee.."/grips/axe_grip_01"},
            {name = "axe_grip_02",  model = _item_melee.."/grips/axe_grip_02"},
            {name = "axe_grip_03",  model = _item_melee.."/grips/axe_grip_03"},
            {name = "axe_grip_04",  model = _item_melee.."/grips/axe_grip_04"},
            {name = "axe_grip_05",  model = _item_melee.."/grips/axe_grip_05"},
            {name = "axe_grip_06",  model = _item_melee.."/grips/axe_grip_06"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "axe_head_01", name = "Combat Axe 1"},
            {id = "axe_head_02", name = "Combat Axe 2"},
            {id = "axe_head_03", name = "Combat Axe 3"},
            {id = "axe_head_04", name = "Combat Axe 4"},
            {id = "axe_head_05", name = "Combat Axe 5"},
            {id = "axe_head_ml01", name = "Combat Axe 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default", model = ""},
            {name = "axe_head_01",  model = _item_melee.."/heads/axe_head_01"},
            {name = "axe_head_02",  model = _item_melee.."/heads/axe_head_02"},
            {name = "axe_head_03",  model = _item_melee.."/heads/axe_head_03"},
            {name = "axe_head_04",  model = _item_melee.."/heads/axe_head_04"},
            {name = "axe_head_05",  model = _item_melee.."/heads/axe_head_05"},
            {name = "axe_head_ml01",  model = _item_melee.."/heads/axe_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "axe_pommel_01", name = "Combat Axe 1"},
            {id = "axe_pommel_02", name = "Combat Axe 2"},
            {id = "axe_pommel_03", name = "Combat Axe 3"},
            {id = "axe_pommel_04", name = "Combat Axe 4"},
            {id = "axe_pommel_05", name = "Combat Axe 5"},
            {id = "axe_pommel_ml01", name = "Combat Axe 6"},
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
            {name = "pommel_default", model = ""},
            {name = "axe_pommel_01",  model = _item_melee.."/pommels/axe_pommel_01"},
            {name = "axe_pommel_02",  model = _item_melee.."/pommels/axe_pommel_02"},
            {name = "axe_pommel_03",  model = _item_melee.."/pommels/axe_pommel_03"},
            {name = "axe_pommel_04",  model = _item_melee.."/pommels/axe_pommel_04"},
            {name = "axe_pommel_05",  model = _item_melee.."/pommels/axe_pommel_05"},
            {name = "axe_pommel_ml01",  model = _item_melee.."/pommels/axe_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}