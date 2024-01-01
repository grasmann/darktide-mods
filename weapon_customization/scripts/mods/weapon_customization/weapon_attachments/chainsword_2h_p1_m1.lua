local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local vector3_box = Vector3Box
    local table = table
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local functions = {
    grip_attachments = function(default)
        local attachments = {
            {id = "2h_chain_sword_grip_01",      name = "Grip 1"},
            {id = "2h_chain_sword_grip_02",      name = "Grip 2"},
            {id = "2h_chain_sword_grip_03",      name = "Grip 3"},
            {id = "2h_chain_sword_grip_04",      name = "Grip 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "2h_chain_sword_grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "2h_chain_sword_grip_default", model = ""},
            {name = "2h_chain_sword_grip_01",      model = _item_melee.."/grips/2h_chain_sword_grip_01"},
            {name = "2h_chain_sword_grip_02",      model = _item_melee.."/grips/2h_chain_sword_grip_02"},
            {name = "2h_chain_sword_grip_03",      model = _item_melee.."/grips/2h_chain_sword_grip_03"},
            {name = "2h_chain_sword_grip_04",      model = _item_melee.."/grips/2h_chain_sword_grip_04"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    body_attachments = function(default)
        local attachments = {
            {id = "2h_chain_sword_body_01",      name = "Body 1"},
            {id = "2h_chain_sword_body_02",      name = "Body 2"},
            {id = "2h_chain_sword_body_03",      name = "Body 3"},
            {id = "2h_chain_sword_body_04",      name = "Body 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "2h_chain_sword_body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "2h_chain_sword_body_default", model = ""},
            {name = "2h_chain_sword_body_01",      model = _item_melee.."/full/2h_chain_sword_body_01"},
            {name = "2h_chain_sword_body_02",      model = _item_melee.."/full/2h_chain_sword_body_02"},
            {name = "2h_chain_sword_body_03",      model = _item_melee.."/full/2h_chain_sword_body_03"},
            {name = "2h_chain_sword_body_04",      model = _item_melee.."/full/2h_chain_sword_body_04"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    chain_attachments = function(default)
        local attachments = {
            {id = "2h_chain_sword_chain_01",      name = "Chain 1"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "2h_chain_sword_chain_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    chain_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "2h_chain_sword_chain_default", model = ""},
            {name = "2h_chain_sword_chain_01",      model = _item_melee.."/chains/2h_chain_sword_chain_01"},
        }, parent, angle, move, remove, type or "chain", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            grip = functions.grip_attachments(),
            body = functions.body_attachments(),
            chain = functions.chain_attachments(),
        },
        models = table.combine(
            -- {customization_default_position = vector3_box(0, 3, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.chain_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            functions.body_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)