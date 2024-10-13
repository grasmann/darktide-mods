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
    body_attachments = function(default)
        local attachments = {
            {id = "body_01",   name = "Body 1"},
            {id = "body_02",   name = "Body 2"},
            {id = "body_03",   name = "Body 3"},
            {id = "body_04",   name = "Body 4"},
            {id = "body_05",   name = "Body 5"},
            {id = "body_06",   name = "Body 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "body_default", model = ""},
            {name = "body_01",      model = _item_melee.."/full/ogryn_club_pipe_full_01"},
            {name = "body_02",      model = _item_melee.."/full/ogryn_club_pipe_full_02"},
            {name = "body_03",      model = _item_melee.."/full/ogryn_club_pipe_full_03"},
            {name = "body_04",      model = _item_melee.."/full/ogryn_club_pipe_full_04"},
            {name = "body_05",      model = _item_melee.."/full/ogryn_club_pipe_full_05"},
            {name = "body_06",      model = _item_melee.."/full/ogryn_club_pipe_full_ml01"},
            {name = "body_none",    model = _item_melee.."/ogryn_powermaul_p1_empty"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}