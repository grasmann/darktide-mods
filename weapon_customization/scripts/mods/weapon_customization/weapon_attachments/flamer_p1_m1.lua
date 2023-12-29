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
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01",      name = "Flamer 1"},
            {id = "receiver_02",      name = "Flamer 2"},
            {id = "receiver_03",      name = "Flamer 3"},
            {id = "receiver_04",      name = "Flamer 4"},
            {id = "receiver_05",      name = "Flamer 5"},
            {id = "receiver_06",      name = "Flamer 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/flamer_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/flamer_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/flamer_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/flamer_rifle_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/flamer_rifle_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/flamer_rifle_receiver_06"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",      name = "Flamer 1"},
            {id = "magazine_02",      name = "Flamer 2"},
            {id = "magazine_03",      name = "Flamer 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/flamer_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/flamer_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/flamer_rifle_magazine_03"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        local attachments = {
            {id = "barrel_01",      name = "Flamer 1"},
            {id = "barrel_02",      name = "Flamer 2"},
            {id = "barrel_03",      name = "Flamer 3"},
            {id = "barrel_04",      name = "Flamer 4"},
            {id = "barrel_05",      name = "Flamer 5"},
            {id = "barrel_06",      name = "Flamer 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/flamer_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/flamer_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/flamer_rifle_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/flamer_rifle_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/flamer_rifle_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/flamer_rifle_barrel_06"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = { -- Done 16.10.2023
            flashlight = _common_ranged.flashlights_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            barrel = functions.barrel_attachments(),
            grip = _common_ranged.grip_attachments(),
        },
        models = table.combine( -- Done 16.10.2023
            _common_ranged.flashlight_models("receiver", -2.5, vector3_box(-.3, -3, -.05), vector3_box(.2, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -3, 0), vector3_box(-.2, 0, 0)),
            _common_ranged.grip_models(nil, .4, vector3_box(-.4, -4, .1), vector3_box(0, 0, -.1)),
            _common.trinket_hook_models(nil, 0, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, .2, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.3, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }, {
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_05_carbon"},
            })
        ),
        anchors = { -- Done 16.10.2023
            flashlight_01 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_02 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_03 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            flashlight_04 = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)},
            fixes = {
                {dependencies = {"barrel_01"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .425, 0), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .46, 0), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03"}, -- Emblems
                    flashlight = {position = vector3_box(.035, .44, .005), rotation = vector3_box(0, 35, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04"}, -- Emblems
                    flashlight = {position = vector3_box(.04, .44, .005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05"}, -- Emblems
                    flashlight = {position = vector3_box(.05, .32, .08), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06"}, -- Emblems
                    flashlight = {position = vector3_box(.04, .42, .005), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_06"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0525, .215, .005), rotation = vector3_box(5, 10, 180), scale = vector3_box(1.1, -1.1, 1.1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_06"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0525, .215, .005), rotation = vector3_box(5, 10, 180), scale = vector3_box(1.1, 1.1, 1.1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0525, .215, .005), rotation = vector3_box(5, -10, 0), scale = vector3_box(1.1, 1.1, 1.1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_05"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1875, -.09), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, -.75, .75)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_05"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1875, -.09), rotation = vector3_box(0, 0, 180), scale = vector3_box(.75, .75, .75)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0275, .1875, -.09), rotation = vector3_box(0, 0, 0), scale = vector3_box(.75, .75, .75)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0385, .0215, -.085), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, -1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_04"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0385, .0215, -.085), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, 1.2, 1.2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0385, .0215, -.085), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.045, .215, -.05), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, -1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_03"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.045, .215, -.05), rotation = vector3_box(0, 0, 180), scale = vector3_box(1.2, 1.2, 1.2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.045, .215, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.2, 1.2, 1.2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.05, .13, .0125), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_02"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.05, .13, .0125), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "barrel", position = vector3_box(.05, .13, .0125), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1, 0), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"receiver_02|receiver_04|receiver_05|receiver_06", "barrel_01"}, -- Emblems
                    emblem_left = {parent = "barrel", position = vector3_box(-.0275, .1, 0), rotation = vector3_box(0, 0, 180), scale = vector3_box(1, 1, 1)},
                    emblem_right = {parent = "barrel", position = vector3_box(.0275, .1, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_01|receiver_03", "emblem_left_02"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.045, -.01, .105), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {dependencies = {"receiver_01|receiver_03"}, -- Emblems
                    emblem_left = {offset = true, position = vector3_box(-.045, -.01, .105), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {offset = true, position = vector3_box(.045, -.01, .105), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.04075, .42, 0), rotation = vector3_box(0, 45, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {grip = {offset = true, position = vector3_box(0, -.01, .02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)