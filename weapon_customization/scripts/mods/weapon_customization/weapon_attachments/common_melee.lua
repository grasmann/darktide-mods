local mod = get_mod("weapon_customization")

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
    local tv = table.tv
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

return {
    grip_default = function()
        return {
            {id = "grip_default",  name = mod:localize("mod_attachment_default")}
        }
    end,
    axe_grip_attachments = function()
        return {
            {id = "axe_grip_01",     name = "Combat Axe 1"},
            {id = "axe_grip_02",     name = "Combat Axe 2"},
            {id = "axe_grip_03",     name = "Combat Axe 3"},
            {id = "axe_grip_04",     name = "Combat Axe 4"},
            {id = "axe_grip_05",     name = "Combat Axe 5"},
            {id = "axe_grip_06",     name = "Combat Axe 6"},
            {id = "hatchet_grip_01", name = "Tactical Axe 1"},
            {id = "hatchet_grip_02", name = "Tactical Axe 2"},
            {id = "hatchet_grip_03", name = "Tactical Axe 3"},
            {id = "hatchet_grip_04", name = "Tactical Axe 4"},
            {id = "hatchet_grip_05", name = "Tactical Axe 5"},
            {id = "hatchet_grip_06", name = "Tactical Axe 6"},
        }
    end,
    axe_grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default =    {model = "",                                    type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_01 =     {model = _item_melee.."/grips/axe_grip_01",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_02 =     {model = _item_melee.."/grips/axe_grip_02",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_03 =     {model = _item_melee.."/grips/axe_grip_03",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_04 =     {model = _item_melee.."/grips/axe_grip_04",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_05 =     {model = _item_melee.."/grips/axe_grip_05",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_06 =     {model = _item_melee.."/grips/axe_grip_06",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_01 = {model = _item_melee.."/grips/hatchet_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_02 = {model = _item_melee.."/grips/hatchet_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_03 = {model = _item_melee.."/grips/hatchet_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_04 = {model = _item_melee.."/grips/hatchet_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_05 = {model = _item_melee.."/grips/hatchet_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_06 = {model = _item_melee.."/grips/hatchet_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    head_default = function()
        return {
            {id = "head_default",  name = mod:localize("mod_attachment_default")}
        }
    end,
    axe_head_attachments = function()
        return {
            {id = "axe_head_01",     name = "Combat Axe 1"},
            {id = "axe_head_02",     name = "Combat Axe 2"},
            {id = "axe_head_03",     name = "Combat Axe 3"},
            {id = "axe_head_04",     name = "Combat Axe 4"},
            {id = "axe_head_05",     name = "Combat Axe 5"},
            {id = "hatchet_head_01", name = "Tactical Axe 1"},
            {id = "hatchet_head_02", name = "Tactical Axe 2"},
            {id = "hatchet_head_03", name = "Tactical Axe 3"},
            {id = "hatchet_head_04", name = "Tactical Axe 4"},
            {id = "hatchet_head_05", name = "Tactical Axe 5"},
        }
    end,
    axe_head_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            head_default =    {model = "",                                    type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_01 =     {model = _item_melee.."/heads/axe_head_01",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_02 =     {model = _item_melee.."/heads/axe_head_02",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_03 =     {model = _item_melee.."/heads/axe_head_03",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_04 =     {model = _item_melee.."/heads/axe_head_04",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_head_05 =     {model = _item_melee.."/heads/axe_head_05",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_head_01 = {model = _item_melee.."/heads/hatchet_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_head_02 = {model = _item_melee.."/heads/hatchet_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_head_03 = {model = _item_melee.."/heads/hatchet_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_head_04 = {model = _item_melee.."/heads/hatchet_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_head_05 = {model = _item_melee.."/heads/hatchet_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    pommel_default = function()
        return {
            {id = "pommel_default",  name = mod:localize("mod_attachment_default")}
        }
    end,
    axe_pommel_attachments = function()
        return {
            {id = "axe_pommel_01",     name = "Combat Axe 1"},
            {id = "axe_pommel_02",     name = "Combat Axe 2"},
            {id = "axe_pommel_03",     name = "Combat Axe 3"},
            {id = "axe_pommel_04",     name = "Combat Axe 4"},
            {id = "axe_pommel_05",     name = "Combat Axe 5"},
            {id = "hatchet_pommel_01", name = "Tactical Axe 1"},
            {id = "hatchet_pommel_02", name = "Tactical Axe 2"},
            {id = "hatchet_pommel_03", name = "Tactical Axe 3"},
            {id = "hatchet_pommel_04", name = "Tactical Axe 4"},
        }
    end,
    axe_pommel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            pommel_default =    {model = "",                                        type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_01 =     {model = _item_melee.."/pommels/axe_pommel_01",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_02 =     {model = _item_melee.."/pommels/axe_pommel_02",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_03 =     {model = _item_melee.."/pommels/axe_pommel_03",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_04 =     {model = _item_melee.."/pommels/axe_pommel_04",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_pommel_05 =     {model = _item_melee.."/pommels/axe_pommel_05",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_pommel_01 = {model = _item_melee.."/pommels/hatchet_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_pommel_02 = {model = _item_melee.."/pommels/hatchet_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_pommel_03 = {model = _item_melee.."/pommels/hatchet_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_pommel_04 = {model = _item_melee.."/pommels/hatchet_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    human_power_maul_shaft_attachments = function(default)
        local attachments = {
            {id = "small_shaft_01", name = "Small Shaft 1"},
            {id = "small_shaft_02", name = "Small Shaft 2"},
            {id = "small_shaft_03", name = "Small Shaft 3"},
            {id = "small_shaft_04", name = "Small Shaft 4"},
            {id = "small_shaft_05", name = "Small Shaft 5"},
            {id = "small_shaft_06", name = "Small Shaft 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default",  model = ""},
            {name = "small_shaft_01", model = _item_ranged.."/shafts/human_power_maul_shaft_01"},
            {name = "small_shaft_02", model = _item_ranged.."/shafts/human_power_maul_shaft_02"},
            {name = "small_shaft_03", model = _item_ranged.."/shafts/human_power_maul_shaft_03"},
            {name = "small_shaft_04", model = _item_ranged.."/shafts/human_power_maul_shaft_04"},
            {name = "small_shaft_05", model = _item_ranged.."/shafts/human_power_maul_shaft_05"},
            {name = "small_shaft_06", model = _item_ranged.."/shafts/human_power_maul_shaft_06"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    human_power_maul_head_attachments = function(default)
        local attachments = {
            {id = "small_head_01", name = "Small Head 1"},
            {id = "small_head_02", name = "Small Head 2"},
            {id = "small_head_03", name = "Small Head 3"},
            {id = "small_head_04", name = "Small Head 4"},
            {id = "small_head_05", name = "Small Head 5"},
            {id = "small_head_06", name = "Small Head 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default",  model = ""},
            {name = "small_head_01", model = _item_melee.."/heads/human_power_maul_head_01"},
            {name = "small_head_02", model = _item_melee.."/heads/human_power_maul_head_02"},
            {name = "small_head_03", model = _item_melee.."/heads/human_power_maul_head_03"},
            {name = "small_head_04", model = _item_melee.."/heads/human_power_maul_head_04"},
            {name = "small_head_05", model = _item_melee.."/heads/human_power_maul_head_05"},
            {name = "small_head_06", model = _item_melee.."/heads/human_power_maul_head_06"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    human_power_maul_connector_attachments = function(default)
        local attachments = {
            {id = "small_connector_01", name = "Small Connector 1"},
            {id = "small_connector_02", name = "Small Connector 2"},
            {id = "small_connector_03", name = "Small Connector 3"},
            {id = "small_connector_04", name = "Small Connector 4"},
            {id = "small_connector_05", name = "Small Connector 5"},
            {id = "small_connector_06", name = "Small Connector 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "connector_default",  model = ""},
            {name = "small_connector_01", model = _item_melee.."/connectors/human_power_maul_connector_01"},
            {name = "small_connector_02", model = _item_melee.."/connectors/human_power_maul_connector_02"},
            {name = "small_connector_03", model = _item_melee.."/connectors/human_power_maul_connector_03"},
            {name = "small_connector_04", model = _item_melee.."/connectors/human_power_maul_connector_04"},
            {name = "small_connector_05", model = _item_melee.."/connectors/human_power_maul_connector_05"},
            {name = "small_connector_06", model = _item_melee.."/connectors/human_power_maul_connector_06"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}