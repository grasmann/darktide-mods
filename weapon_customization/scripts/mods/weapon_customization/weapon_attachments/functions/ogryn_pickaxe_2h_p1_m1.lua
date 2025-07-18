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
    pommel_attachments = function(default)
        local attachments = {
            {id = "pickaxe_pommel_01",            name = "Pickaxe 1"},
            {id = "pickaxe_pommel_02",            name = "Pickaxe 2"},
            {id = "pickaxe_pommel_03",            name = "Pickaxe 3"},
            {id = "pickaxe_pommel_04",            name = "Pickaxe 4"},
            {id = "pickaxe_pommel_05",            name = "Pickaxe 5"},
            {id = "pickaxe_pommel_07",            name = "Pickaxe 6"},
            {id = "ogryn_pickaxe_2h_pommel_ml01", name = "Pickaxe 7"},
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
            {name = "pommel_default",               model = ""},
            {name = "pickaxe_pommel_01",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_01"},
            {name = "pickaxe_pommel_02",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_02"},
            {name = "pickaxe_pommel_03",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_03"},
            {name = "pickaxe_pommel_04",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_04"},
            {name = "pickaxe_pommel_05",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_05"},
            {name = "pickaxe_pommel_07",            model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_07"},
            {name = "ogryn_pickaxe_2h_pommel_ml01", model = _item_melee.."/pommels/ogryn_pickaxe_2h_pommel_ml01"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    shaft_attachments = function(default)
        local attachments = {
            {id = "pickaxe_shaft_01",      name = "Pickaxe 1"},
            {id = "pickaxe_shaft_02",      name = "Pickaxe 2"},
            {id = "pickaxe_shaft_03",      name = "Pickaxe 3"},
            {id = "pickaxe_shaft_04",      name = "Pickaxe 4"},
            {id = "pickaxe_shaft_05",      name = "Pickaxe 5"},
            {id = "pickaxe_shaft_06",      name = "Pickaxe 6"},
            {id = "pickaxe_shaft_07",      name = "Pickaxe 7"},
            {id = "ogryn_pickaxe_shaft_ml01", name = "Pickaxe 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default", model = ""},
            {name = "pickaxe_shaft_01",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_01"},
            {name = "pickaxe_shaft_02",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_02"},
            {name = "pickaxe_shaft_03",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_03"},
            {name = "pickaxe_shaft_04",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_04"},
            {name = "pickaxe_shaft_05",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_05"},
            {name = "pickaxe_shaft_06",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_06"},
            {name = "pickaxe_shaft_07",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_07"},
            {name = "ogryn_pickaxe_shaft_ml01",      model = _item_melee.."/shafts/ogryn_pickaxe_shaft_ml01"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "pickaxe_head_01",            name = "Pickaxe 1"},
            {id = "pickaxe_head_02",            name = "Pickaxe 2"},
            {id = "pickaxe_head_03",            name = "Pickaxe 3"},
            {id = "pickaxe_head_04",            name = "Pickaxe 4"},
            {id = "pickaxe_head_05",            name = "Pickaxe 5"},
            {id = "pickaxe_head_06",            name = "Pickaxe 6"},
            {id = "pickaxe_head_07",            name = "Pickaxe 7"},
            {id = "ogryn_pickaxe_2h_head_ml01", name = "Pickaxe 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default", model = ""},
            {name = "pickaxe_head_01",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_01"},
            {name = "pickaxe_head_02",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_02"},
            {name = "pickaxe_head_03",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_03"},
            {name = "pickaxe_head_04",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_04"},
            {name = "pickaxe_head_05",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_05"},
            {name = "pickaxe_head_06",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_06"},
            {name = "pickaxe_head_07",            model = _item_melee.."/heads/ogryn_pickaxe_2h_head_07"},
            {name = "ogryn_pickaxe_2h_head_ml01", model = _item_melee.."/heads/ogryn_pickaxe_2h_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}