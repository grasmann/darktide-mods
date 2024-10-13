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
            {id = "ogryn_club_head_01", name = "Ogryn Club 1"},
            {id = "ogryn_club_head_02", name = "Ogryn Club 2"},
            {id = "ogryn_club_head_03", name = "Ogryn Club 3"},
            {id = "ogryn_club_head_04", name = "Ogryn Club 4"},
            {id = "ogryn_club_head_05", name = "Ogryn Club 5"},
            {id = "ogryn_club_head_06", name = "Krieg", no_randomize = true},
            {id = "ogryn_club_head_07", name = "Prologue", no_randomize = true},
            {id = "shovel_ogryn_head_ml01", name = "Ogryn Club 8"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "head_default",       model = ""},
            {name = "ogryn_club_head_01", model = _item_melee.."/heads/shovel_ogryn_head_01"},
            {name = "ogryn_club_head_02", model = _item_melee.."/heads/shovel_ogryn_head_02"},
            {name = "ogryn_club_head_03", model = _item_melee.."/heads/shovel_ogryn_head_03"},
            {name = "ogryn_club_head_04", model = _item_melee.."/heads/shovel_ogryn_head_04"},
            {name = "ogryn_club_head_05", model = _item_melee.."/heads/shovel_ogryn_head_05"},
            {name = "ogryn_club_head_06", model = _item_melee.."/full/krieg_shovel_ogryn_full_01"},
            {name = "ogryn_club_head_07", model = _item_melee.."/full/prologue_shovel_ogryn_full_01"},
            {name = "shovel_ogryn_head_ml01", model = _item_melee.."/heads/shovel_ogryn_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "ogryn_club_grip_01", name = "Ogryn Club 1"},
            {id = "ogryn_club_grip_02", name = "Ogryn Club 2"},
            {id = "ogryn_club_grip_03", name = "Ogryn Club 3"},
            {id = "ogryn_club_grip_04", name = "Ogryn Club 4"},
            {id = "ogryn_club_grip_05", name = "Ogryn Club 5"},
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
            {name = "grip_default",       model = ""},
            {name = "ogryn_club_grip_01", model = _item_melee.."/grips/shovel_ogryn_grip_01"},
            {name = "ogryn_club_grip_02", model = _item_melee.."/grips/shovel_ogryn_grip_02"},
            {name = "ogryn_club_grip_03", model = _item_melee.."/grips/shovel_ogryn_grip_03"},
            {name = "ogryn_club_grip_04", model = _item_melee.."/grips/shovel_ogryn_grip_04"},
            {name = "ogryn_club_grip_05", model = _item_melee.."/grips/shovel_ogryn_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "ogryn_club_pommel_01", name = "Ogryn Club 1"},
            {id = "ogryn_club_pommel_02", name = "Ogryn Club 2"},
            {id = "ogryn_club_pommel_03", name = "Ogryn Club 3"},
            {id = "ogryn_club_pommel_04", name = "Ogryn Club 4"},
            {id = "ogryn_club_pommel_05", name = "Ogryn Club 5"},
            {id = "shovel_ogryn_pommel_ml01", name = "Ogryn Club 6"},
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
            {name = "pommel_default",       model = ""},
            {name = "ogryn_club_pommel_01", model = _item_melee.."/pommels/shovel_ogryn_pommel_01"},
            {name = "ogryn_club_pommel_02", model = _item_melee.."/pommels/shovel_ogryn_pommel_02"},
            {name = "ogryn_club_pommel_03", model = _item_melee.."/pommels/shovel_ogryn_pommel_03"},
            {name = "ogryn_club_pommel_04", model = _item_melee.."/pommels/shovel_ogryn_pommel_04"},
            {name = "ogryn_club_pommel_05", model = _item_melee.."/pommels/shovel_ogryn_pommel_05"},
            {name = "shovel_ogryn_pommel_ml01", model = _item_melee.."/pommels/shovel_ogryn_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}