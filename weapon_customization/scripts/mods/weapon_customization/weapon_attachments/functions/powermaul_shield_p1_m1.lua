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
    shield_attachments = function(default)
        local attachments = {
            {id = "left_01", name = "Assault Shield 1"},
            {id = "left_02", name = "Slab Shield 1"},
            {id = "left_03", name = "Bulwark Shield"},
            {id = "left_04", name = "Slab Shield 2"},
            {id = "left_05", name = "Slab Shield 3"},
            {id = "left_06", name = "Slab Shield 4"},
            {id = "left_07", name = "Slab Shield 5"},
            {id = "left_08", name = "Slab Shield 6"},
            {id = "left_09", name = "Slab Shield 7"},
            {id = "left_10", name = "Slab Shield 8"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "left_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shield_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "left_default", model = ""},
            {name = "left_01",      model = _item_melee.."/assault_shield_p1_m1"},
            {name = "left_02",      model = _item_melee.."/ogryn_slabshield_p1_m1"},
            {name = "left_03",      model = _item_melee.."/ogryn_bulwark_shield_01"},
            {name = "left_04",      model = _item_melee.."/ogryn_slabshield_p1_m3"},
            {name = "left_05",      model = _item_melee.."/ogryn_slabshield_p1_m2"},
            {name = "left_06",      model = _item_melee.."/ogryn_slabshield_p1_04"},
            {name = "left_07",      model = _item_melee.."/ogryn_powermaul_slabshield_p1_05"},
            {name = "left_08",      model = _item_melee.."/ogryn_slabshield_p1_ml01"},
            {name = "left_09",      model = _item_melee.."/ogryn_slabshield_p1_05"},
            {name = "left_10",      model = _item_melee.."/ogryn_slabshield_p1_06"},
        }, parent, angle, move, remove, type or "left", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
}