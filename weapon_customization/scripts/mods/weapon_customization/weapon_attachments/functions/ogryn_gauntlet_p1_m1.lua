local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
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
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01", name = "Barrel 1"},
            {id = "barrel_02", name = "Barrel 2"},
            {id = "barrel_03", name = "Barrel 3"},
            {id = "barrel_04", name = "Barrel 4"},
            {id = "barrel_05", name = "Barrel 5"},
            {id = "barrel_06", name = "Barrel 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_ml01"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_05"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    body_attachments = function(default)
        local attachments = {
            {id = "body_01", name = "Body 1"},
            {id = "body_02", name = "Body 2"},
            {id = "body_03", name = "Body 3"},
            {id = "body_04", name = "Body 4"},
            {id = "body_05", name = "Body 5"},
            {id = "body_06", name = "Body 6"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "body_default", model = ""},
            {name = "body_01",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_01"},
            {name = "body_02",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_02"},
            {name = "body_03",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_03"},
            {name = "body_04",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_04"},
            {name = "body_05",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_ml01"},
            {name = "body_06",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_06"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/gauntlet_basic_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/gauntlet_basic_magazine_02"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}