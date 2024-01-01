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
local _item_melee = _item.."/melee"

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
            {id = "axe_grip_01",  name = "Combat Axe 1"},
            {id = "axe_grip_02",  name = "Combat Axe 2"},
            {id = "axe_grip_03",  name = "Combat Axe 3"},
            {id = "axe_grip_04",  name = "Combat Axe 4"},
            {id = "axe_grip_05",  name = "Combat Axe 5"},
            {id = "axe_grip_06",  name = "Combat Axe 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default",    name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "axe_grip_01",      model = _item_melee.."/grips/axe_grip_01"},
            {name = "axe_grip_02",      model = _item_melee.."/grips/axe_grip_02"},
            {name = "axe_grip_03",      model = _item_melee.."/grips/axe_grip_03"},
            {name = "axe_grip_04",      model = _item_melee.."/grips/axe_grip_04"},
            {name = "axe_grip_05",      model = _item_melee.."/grips/axe_grip_05"},
            {name = "axe_grip_06",      model = _item_melee.."/grips/axe_grip_06"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "axe_head_01",  name = "Combat Axe 1"},
            {id = "axe_head_02",  name = "Combat Axe 2"},
            {id = "axe_head_03",  name = "Combat Axe 3"},
            {id = "axe_head_04",  name = "Combat Axe 4"},
            {id = "axe_head_05",  name = "Combat Axe 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default", model = ""},
            {name = "axe_head_01",      model = _item_melee.."/heads/axe_head_01"},
            {name = "axe_head_02",      model = _item_melee.."/heads/axe_head_02"},
            {name = "axe_head_03",      model = _item_melee.."/heads/axe_head_03"},
            {name = "axe_head_04",      model = _item_melee.."/heads/axe_head_04"},
            {name = "axe_head_05",      model = _item_melee.."/heads/axe_head_05"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "axe_pommel_01",  name = "Combat Axe 1"},
            {id = "axe_pommel_02",  name = "Combat Axe 2"},
            {id = "axe_pommel_03",  name = "Combat Axe 3"},
            {id = "axe_pommel_04",  name = "Combat Axe 4"},
            {id = "axe_pommel_05",  name = "Combat Axe 5"},
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
            {name = "pommel_default", model = ""},
            {name = "axe_pommel_01",      model = _item_melee.."/pommels/axe_pommel_01"},
            {name = "axe_pommel_02",      model = _item_melee.."/pommels/axe_pommel_02"},
            {name = "axe_pommel_03",      model = _item_melee.."/pommels/axe_pommel_03"},
            {name = "axe_pommel_04",      model = _item_melee.."/pommels/axe_pommel_04"},
            {name = "axe_pommel_05",      model = _item_melee.."/pommels/axe_pommel_05"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
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
            grip = table.icombine(
                _common_melee.axe_grip_attachments()
            ),
            head = table.icombine(
                _common_melee.axe_head_attachments()
            ),
            pommel = table.icombine(
                _common_melee.axe_pommel_attachments()
            ),
        },
        models = table.combine(
            _common.emblem_right_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models(nil, -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.axe_grip_models(nil, 0, vector3_box(-.3, -2, .1), vector3_box(0, 0, 0)),
            _common_melee.axe_head_models(nil, 0, vector3_box(0, -3, -.1), vector3_box(0, 0, .2)),
            _common_melee.axe_pommel_models(nil, 0, vector3_box(-.5, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                {dependencies = {"axe_head_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"axe_head_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.015, .06, .16), rotation = vector3_box(90, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.015, .06, .16), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)