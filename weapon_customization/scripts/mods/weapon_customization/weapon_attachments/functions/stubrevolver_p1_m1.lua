local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table = table
    local table_icombine = table.icombine
    local table_model_table = table.model_table
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
    local _item_melee = _item.."/melee"
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

return {
    body_attachments = function(default)
        local attachments = {
            {id = "body_01",        name = "Body 1"},
            {id = "body_02",        name = "Body 2"},
            {id = "body_03",        name = "Body 3"},
            {id = "body_04",        name = "Body 4"},
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
            {name = "body_01",      model = _item_melee.."/full/stubgun_pistol_full_01"},
            {name = "body_02",      model = _item_ranged.."/recievers/stubgun_pistol_receiver_02"},
            {name = "body_03",      model = _item_ranged.."/recievers/stubgun_pistol_receiver_03"},
            {name = "body_04",      model = _item_ranged.."/recievers/stubgun_pistol_receiver_ml01"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
            {id = "barrel_04",      name = "Barrel 4"},
            {id = "barrel_05",      name = "Barrel 5"},
            {id = "barrel_06",      name = "Barrel 6"},
            {id = "barrel_07",      name = "Barrel 7"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_06"},
            {name = "barrel_07",      model = _item_ranged.."/barrels/stubgun_pistol_barrel_ml01"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    rail_attachments = function(default)
        local attachments = {
            {id = "rail_01",        name = "Rail 1"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "rail_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    rail_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "rail_default", model = ""},
            {name = "rail_01",      model = _item_ranged.."/rails/stubgun_pistol_rail_off"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    speed_loader_attachments = function(default)
        local attachments = {
            {id = "speedloader_01",        name = "Speedloader"},
        }
        if default == nil then default = true end
        if default then return table_icombine(
            {{id = "speedloader_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    speed_loader_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table_model_table({
            {name = "speedloader_default", model = ""},
            {name = "speedloader_01",      model = _item_ranged.."/bullets/stubgun_pistol_bullet_speedloader"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
}