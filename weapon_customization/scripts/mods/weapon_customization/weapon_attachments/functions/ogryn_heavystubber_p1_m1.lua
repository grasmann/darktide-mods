local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")

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
    local tv = table.tv
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
            {id = "barrel_05", name = "Barrel 5"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/stubgun_heavy_ogryn_barrel_05"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01", name = "Receiver 1"},
            {id = "receiver_02", name = "Receiver 2"},
            {id = "receiver_03", name = "Receiver 3"},
            {id = "receiver_04", name = "Receiver 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/stubgun_heavy_ogryn_receiver_04"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
            {id = "magazine_03", name = "Magazine 3"},
            {id = "magazine_04", name = "Magazine 4"},
            {id = "magazine_05", name = "Magazine 5"},
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
            {name = "magazine_01",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_04"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/stubgun_heavy_ogryn_magazine_05"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
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
            {name = "grip_01",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/stubgun_heavy_ogryn_grip_03"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            -- Native
            receiver = functions.receiver_attachments(),
            barrel = functions.barrel_attachments(),
            magazine = functions.magazine_attachments(),
            grip = functions.grip_attachments(),
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
            functions.barrel_models(nil, -.25, vector3_box(.35, -3, 0), vector3_box(0, .2, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2)),
            functions.grip_models(nil, .3, vector3_box(-.4, -3, 0), vector3_box(0, -.2, 0), "grip", {
                {"trinket_hook_default"},
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
            }, {
                {trinket_hook = "!trinket_hook_default|trinket_hook_default"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
            }),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, -.2), vector3_box(.4, 0, .4)),
            _common_ranged.ogryn_bayonet_models("receiver", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(.1, -6, -.1), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.3, -6, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, .3, vector3_box(-.6, -5, .1), vector3_box(0, -.1, -.1))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {position = vector3_box(0, 1.04, -0.39), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {bayonet = {position = vector3_box(0, 1.08, -0.36), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"flashlight_04|laser_pointer"},
                    flashlight = {position = vector3_box(.15, .86, .21), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)}},
                {flashlight = {position = vector3_box(.09, .9, .13), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)}},
                -- Emblems
                {dependencies = {"emblem_left_02"},
                    emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {emblem_left = {offset = true, position = vector3_box(-.09, .42, .085), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)}}, -- Emblem left
            }
        },
        sounds = {
            magazine = {
                detach = {SoundEventAliases.sfx_reload_lever_pull.events.ogryn_heavystubber_p1_m1},
                attach = {SoundEventAliases.sfx_reload_lever_release.events.ogryn_heavystubber_p1_m1},
            }
        },
    }
)