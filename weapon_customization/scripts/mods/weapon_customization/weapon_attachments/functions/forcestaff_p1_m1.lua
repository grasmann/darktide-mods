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
    staff_head_attachments = function(default)
        local attachments = {
            {id = "head_01",      name = "Head 1"},
            {id = "head_02",      name = "Head 2"},
            {id = "head_03",      name = "Head 3"},
            {id = "head_04",      name = "Head 4"},
            {id = "head_05",      name = "Head 5"},
            {id = "head_06",      name = "Head 6"},
            {id = "head_07",      name = "Head 7"},
            {id = "head_08",      name = "Head 8"},
            {id = "head_09",      name = "Head 9"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    staff_head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default", model = ""},
            {name = "head_01",      model = _item_melee.."/heads/force_staff_head_01"},
            {name = "head_02",      model = _item_melee.."/heads/force_staff_head_02"},
            {name = "head_03",      model = _item_melee.."/heads/force_staff_head_03"},
            {name = "head_04",      model = _item_melee.."/heads/force_staff_head_04"},
            {name = "head_05",      model = _item_melee.."/heads/force_staff_head_05"},
            {name = "head_06",      model = _item_melee.."/heads/force_staff_head_06"},
            {name = "head_07",      model = _item_melee.."/heads/force_staff_head_07"},
            {name = "head_08",      model = _item_melee.."/heads/force_staff_head_08"},
            {name = "head_09",      model = _item_melee.."/heads/force_staff_head_09"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    staff_body_attachments = function(default)
        local attachments = {
            {id = "body_01",      name = "Body 1"},
            {id = "body_02",      name = "Body 2"},
            {id = "body_03",      name = "Body 3"},
            {id = "body_04",      name = "Body 4"},
            {id = "body_05",      name = "Body 5"},
            {id = "force_staff_full_ml01",      name = "Body 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    staff_body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "body_default", model = ""},
            {name = "body_01",      model = _item_melee.."/full/force_staff_full_01"},
            {name = "body_02",      model = _item_melee.."/full/force_staff_full_02"},
            {name = "body_03",      model = _item_melee.."/full/force_staff_full_03"},
            {name = "body_04",      model = _item_melee.."/full/force_staff_full_04"},
            {name = "body_05",      model = _item_melee.."/full/force_staff_full_05"},
            {name = "force_staff_full_ml01",      model = _item_melee.."/full/force_staff_full_ml01"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    staff_shaft_upper_attachments = function(default)
        local attachments = {
            {id = "shaft_upper_01",      name = "Upper Shaft 1"},
            {id = "shaft_upper_02",      name = "Upper Shaft 2"},
            {id = "shaft_upper_03",      name = "Upper Shaft 3"},
            {id = "shaft_upper_04",      name = "Upper Shaft 4"},
            {id = "shaft_upper_05",      name = "Upper Shaft 5"},
            {id = "shaft_upper_06",      name = "Upper Shaft 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_upper_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    staff_shaft_upper_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_upper_default", model = ""},
            {name = "shaft_upper_01",      model = _item_ranged.."/shafts/force_staff_shaft_upper_01"},
            {name = "shaft_upper_02",      model = _item_ranged.."/shafts/force_staff_shaft_upper_02"},
            {name = "shaft_upper_03",      model = _item_ranged.."/shafts/force_staff_shaft_upper_03"},
            {name = "shaft_upper_04",      model = _item_ranged.."/shafts/force_staff_shaft_upper_04"},
            {name = "shaft_upper_05",      model = _item_ranged.."/shafts/force_staff_shaft_upper_05"},
            {name = "shaft_upper_06",      model = _item_ranged.."/shafts/force_staff_shaft_upper_ml01"},
        }, parent, angle, move, remove, type or "shaft_upper", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,



    staff_shaft_lower_attachments = function(default)
        local attachments = {
            {id = "shaft_lower_01",      name = "Lower Shaft 1"},
            {id = "shaft_lower_02",      name = "Lower Shaft 2"},
            {id = "shaft_lower_03",      name = "Lower Shaft 3"},
            {id = "shaft_lower_04",      name = "Lower Shaft 4"},
            {id = "shaft_lower_05",      name = "Lower Shaft 5"},
            {id = "shaft_lower_06",      name = "Lower Shaft 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_lower_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    staff_shaft_lower_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_lower_default", model = ""},
            {name = "shaft_lower_01",      model = _item_ranged.."/shafts/force_staff_shaft_lower_01"},
            {name = "shaft_lower_02",      model = _item_ranged.."/shafts/force_staff_shaft_lower_02"},
            {name = "shaft_lower_03",      model = _item_ranged.."/shafts/force_staff_shaft_lower_03"},
            {name = "shaft_lower_04",      model = _item_ranged.."/shafts/force_staff_shaft_lower_04"},
            {name = "shaft_lower_05",      model = _item_ranged.."/shafts/force_staff_shaft_lower_05"},
            {name = "shaft_lower_06",      model = _item_ranged.."/shafts/force_staff_shaft_lower_ml01"},
        }, parent, angle, move, remove, type or "shaft_lower", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}