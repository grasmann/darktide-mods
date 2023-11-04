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
            {id = "barrel_01", name = "Ripper Barrel 1"},
            {id = "barrel_02", name = "Ripper Barrel 2"},
            {id = "barrel_03", name = "Ripper Barrel 3"},
            {id = "barrel_04", name = "Ripper Barrel 4"},
            {id = "barrel_05", name = "Ripper Barrel 5"},
            {id = "barrel_06", name = "Ripper Barrel 6"},
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
            {name = "barrel_01",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_03"},
            {name = "barrel_04",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_04"},
            {name = "barrel_05",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_05"},
            {name = "barrel_06",      model = _item_ranged.."/barrels/rippergun_rifle_barrel_06"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    receiver_attachments = function(default)
        local attachments = {
            {id = "receiver_01", name = "Receiver 1"},
            {id = "receiver_02", name = "Receiver 2"},
            {id = "receiver_03", name = "Receiver 3"},
            {id = "receiver_04", name = "Receiver 4"},
            {id = "receiver_05", name = "Receiver 5"},
            {id = "receiver_06", name = "Receiver 6"},
            {id = "receiver_07", name = "Receiver 7"},
            {id = "receiver_08", name = "Receiver 8"},
            {id = "receiver_09", name = "Receiver 9"},
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
            {name = "receiver_01",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_01"},
            {name = "receiver_02",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_02"},
            {name = "receiver_03",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_03"},
            {name = "receiver_04",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_04"},
            {name = "receiver_05",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_05"},
            {name = "receiver_06",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_06"},
            {name = "receiver_07",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_07"},
            {name = "receiver_08",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_08"},
            {name = "receiver_09",      model = _item_ranged.."/recievers/rippergun_rifle_receiver_09"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
            {id = "magazine_03", name = "Magazine 3"},
            {id = "magazine_04", name = "Magazine 4"},
            {id = "magazine_05", name = "Magazine 5"},
            {id = "magazine_06", name = "Magazine 6"},
            {id = "magazine_07", name = "Magazine 7"},
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
            {name = "magazine_01",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_03"},
            {name = "magazine_04",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_04"},
            {name = "magazine_05",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_05"},
            {name = "magazine_06",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_06"},
            {name = "magazine_07",      model = _item_ranged.."/magazines/rippergun_rifle_magazine_07"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    handle_attachments = function(default)
        local attachments = {
            {id = "handle_01", name = "Handle 1"},
            {id = "handle_02", name = "Handle 2"},
            {id = "handle_03", name = "Handle 3"},
            {id = "handle_04", name = "Handle 4"},
            {id = "handle_05", name = "Handle 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "handle_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    handle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "handle_default", model = ""},
            {name = "handle_01",      model = _item_ranged.."/handles/rippergun_rifle_handle_01"},
            {name = "handle_02",      model = _item_ranged.."/handles/rippergun_rifle_handle_02"},
            {name = "handle_03",      model = _item_ranged.."/handles/rippergun_rifle_handle_03"},
            {name = "handle_04",      model = _item_ranged.."/handles/rippergun_rifle_handle_04"},
            {name = "handle_05",      model = _item_ranged.."/handles/rippergun_rifle_handle_05"},
        }, parent, angle, move, remove, type or "handle", no_support, automatic_equip, hide_mesh, mesh_move)
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
            barrel = functions.barrel_attachments(),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            handle = functions.handle_attachments(),
            -- Ranged
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            flashlight = _common_ranged.flashlights_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .6, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, 0, vector3_box(0, -3, .1), vector3_box(0, 0, -.2), nil, nil, nil, nil, true),
            functions.handle_models(nil, -.75, vector3_box(-.2, -4, -.1), vector3_box(-.2, 0, 0), nil, nil, nil, nil, true),
            -- Ranged
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(-.2, -3, -.1), vector3_box(.4, 0, .4)),
            _common_ranged.ogryn_bayonet_models({"", "", "", "", "", "receiver"}, -.5, vector3_box(.2, -2, 0), vector3_box(0, .4, 0)),
            -- Common
            _common.emblem_right_models("receiver", -3, vector3_box(-.2, -6, -.1), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.1, -6, -.1), vector3_box(.2, 0, 0)),
            _common.trinket_hook_models(nil, -.3, vector3_box(.15, -5, .1), vector3_box(0, 0, -.2))
        ),
        anchors = {
            fixes = {
                -- Bayonet
                {dependencies = {"bayonet_blade_01"},
                    bayonet = {position = vector3_box(0, .45, 0.025), rotation = vector3_box(-90, 0, 0), scale = vector3_box(2, 2, 2)}},
                -- Laser Pointer / Flashlight
                {dependencies = {"laser_pointer|flashlight_04"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.16, .76, .41), rotation = vector3_box(0, 128, 0), scale = vector3_box(2, 2, 2)}},
                {flashlight = {position = vector3_box(.09, .76, .35), rotation = vector3_box(0, 311, 0), scale = vector3_box(2, 2, 2)}},
                -- Emblems
                {dependencies = {"receiver_02"},
                    emblem_left = {offset = true, position = vector3_box(-.145, .3, .27), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {offset = true, position = vector3_box(.145, .615, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"receiver_09"},
                    emblem_left = {parent = "receiver", position = vector3_box(-.145, .3, .27), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "receiver", position = vector3_box(.145, .615, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"receiver_03"},
                    emblem_left = {offset = true, position = vector3_box(.0047, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    emblem_right = {offset = true, position = vector3_box(.0047, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"receiver_06"},
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, 1.5, 1.5)},
                    emblem_right = {offset = true, position = vector3_box(.06, 0, .05), rotation = vector3_box(0, -20, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
        sounds = {
            magazine = {
                detach = {SoundEventAliases.magazine_fail.events.ogryn_rippergun_p1_m1},
            }
        },
    }
)