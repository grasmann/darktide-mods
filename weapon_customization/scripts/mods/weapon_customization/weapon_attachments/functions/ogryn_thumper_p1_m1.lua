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
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
            {id = "grip_04", name = "Grip 4"},
            {id = "grip_05", name = "Grip 5"},
            {id = "grip_06", name = "Grip 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_ranged.."/grips/shotgun_grenade_grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/shotgun_grenade_grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/shotgun_grenade_grip_03"},
            {name = "grip_04",      model = _item_ranged.."/grips/shotgun_grenade_grip_04"},
            {name = "grip_05",      model = _item_ranged.."/grips/shotgun_grenade_grip_05"},
            {name = "grip_06",      model = _item_ranged.."/grips/shotgun_grenade_grip_ml01"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    sight_attachments = function(default)
        local attachments = {
            {id = "sight_01", name = "Sight 1"},
            {id = "sight_02", name = "No Sight"},
            {id = "sight_03", name = "Sight 3"},
            {id = "sight_04", name = "Sight 4"},
            {id = "sight_05", name = "Sight 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sight_default",  name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sight_default", model = ""},
            {name = "sight_01",      model = _item_ranged.."/sights/shotgun_grenade_sight_01"},
            -- {name = "sight_02",      model = _item_ranged.."/sights/shotgun_grenade_sight_02"},
            {name = "sight_02",      model = ""},
            {name = "sight_03",      model = _item_ranged.."/sights/shotgun_grenade_sight_03"},
            {name = "sight_04",      model = _item_ranged.."/sights/shotgun_grenade_sight_04"},
            {name = "sight_05",      model = _item_ranged.."/sights/shotgun_grenade_sight_ml01"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    body_attachments = function(default)
        local attachments = {
            {id = "body_01", name = "Body 1"},
            {id = "body_02", name = "Body 2"},
            {id = "body_03", name = "Body 3"},
            {id = "body_04", name = "Body 4"},
            {id = "body_05", name = "Body 5"},
            {id = "body_06", name = "Body 6"},
            {id = "body_07", name = "Body 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "body_default", model = ""},
            {name = "body_01",      model = _item_melee.."/full/shotgun_grenade_full_01"},
            {name = "body_02",      model = _item_melee.."/full/shotgun_grenade_full_02"},
            {name = "body_03",      model = _item_melee.."/full/shotgun_grenade_full_03"},
            {name = "body_04",      model = _item_melee.."/full/shotgun_grenade_full_04"},
            {name = "body_05",      model = _item_melee.."/full/shotgun_grenade_full_05"},
            {name = "body_06",      model = _item_melee.."/full/shotgun_grenade_full_06"},
            {name = "body_07",      model = _item_melee.."/full/shotgun_grenade_full_ml01"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}