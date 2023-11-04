local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
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
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
            {id = "grip_04", name = "Grip 4"},
            {id = "grip_05", name = "Grip 5"},
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
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    sight_attachments = function(default)
        local attachments = {
            {id = "sight_01", name = "Sight 1"},
            {id = "sight_02", name = "No Sight"},
            {id = "sight_03", name = "Sight 3"},
            {id = "sight_04", name = "Sight 4"},
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
            {name = "sight_02",      model = _item_ranged.."/sights/shotgun_grenade_sight_02"},
            {name = "sight_03",      model = _item_ranged.."/sights/shotgun_grenade_sight_03"},
            {name = "sight_04",      model = _item_ranged.."/sights/shotgun_grenade_sight_04"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    body_attachments = function(default)
        local attachments = {
            {id = "body_01", name = "Body 1"},
            {id = "body_02", name = "Body 2"},
            {id = "body_03", name = "Body 3"},
            {id = "body_04", name = "Body 4"},
            {id = "body_05", name = "Body 5"},
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
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            -- Native
            sight = functions.sight_attachments(),
            grip = functions.grip_attachments(),
            body = functions.body_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
        },
        models = table.combine(
            -- Native
            functions.grip_models(nil, 0, vector3_box(-.3, -3, 0), vector3_box(0, -.2, 0)),
            functions.sight_models(nil, -.5, vector3_box(.2, -3, 0), vector3_box(0, 0, .2), nil, nil, nil, nil, true),
            functions.body_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, 0), vector3_box(.4, 0, 0)),
            _common_ranged.ogryn_bayonet_models("body", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(-.3, -6, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.1, -6, 0), vector3_box(-.2, 0, 0))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(-90, 0, 0), scale = vector3_box(1.5, 1.5, 1.5)}},
                {bayonet = {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"laser_pointer|flashlight_04"},
                    flashlight = {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                {flashlight = {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                -- Emblems
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(-.12, .22, .11), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {emblem_left = {offset = true, position = vector3_box(-.12, .22, .11), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)}, -- Emblems
                    emblem_right = {offset = true, position = vector3_box(.123, .765, .11), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)