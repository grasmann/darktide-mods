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
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01", name = "Barrel 1"},
            {id = "barrel_02", name = "Barrel 2"},
            {id = "barrel_03", name = "Barrel 3"},
            {id = "barrel_04", name = "Barrel 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/gauntlet_basic_barrel_04"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    body_attachments = function(default)
        local attachments = {
            {id = "body_01", name = "Body 1"},
            {id = "body_02", name = "Body 2"},
            {id = "body_03", name = "Body 3"},
            {id = "body_04", name = "Body 4"},
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
            {name = "body_01",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_01"},
            {name = "body_02",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_02"},
            {name = "body_03",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_03"},
            {name = "body_04",      model = _item_ranged.."/recievers/gauntlet_basic_receiver_04"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/gauntlet_basic_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/gauntlet_basic_magazine_02"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
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
            barrel = functions.barrel_attachments(),
            body = functions.body_attachments(),
            magazine = functions.magazine_attachments(),
            -- Ranged
            flashlight = _common_ranged.flashlights_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            functions.barrel_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 1.5, 0), nil, nil, nil, nil, true),
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, 0, vector3_box(-.8, -4, 0), vector3_box(0, -.6, 0)),
            -- Ranged
            _common_ranged.ogryn_bayonet_models("barrel", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, 0), vector3_box(.4, 0, 0)),
            -- Common
            _common.emblem_right_models(nil, -3, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models(nil, 0, vector3_box(0, -2, 0), vector3_box(.2, 0, 0)),
            _common.trinket_hook_models("barrel", -.3, vector3_box(.25, -5, .1), vector3_box(-.2, 0, 0))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {position = vector3_box(0, .4, -0.27), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {bayonet = {position = vector3_box(0, .4, -0.27), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"laser_pointer|flashlight_04"},
                    flashlight = {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                {flashlight = {position = vector3_box(.2, .18, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                -- Trinket hook
                {dependencies = {"barrel_01"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_02"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.04), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_03"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"barrel_04"},
                    trinket_hook = {parent = "barrel", position = vector3_box(-.19, .375, -.08), rotation = vector3_box(0, 90, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                -- Emblems
                {dependencies = {"emblem_left_02"},
                    emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {emblem_left = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}, -- Emblems
                    emblem_right = {offset = true, position = vector3_box(.001, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            }
        },
    }
)