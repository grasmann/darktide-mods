local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")

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
    head_attachments = function(default)
        local attachments = {
            {id = "head_01", name = "Head 1"},
            {id = "head_02", name = "Head 2"},
            {id = "head_03", name = "Head 3"},
            {id = "head_04", name = "Head 4"},
            {id = "head_05", name = "Head 5"},
            {id = "head_06", name = "Krieg", no_randomize = true},
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
            {name = "head_01",      model = _item_melee.."/heads/shovel_ogryn_head_01"},
            {name = "head_02",      model = _item_melee.."/heads/shovel_ogryn_head_02"},
            {name = "head_03",      model = _item_melee.."/heads/shovel_ogryn_head_03"},
            {name = "head_04",      model = _item_melee.."/heads/shovel_ogryn_head_04"},
            {name = "head_05",      model = _item_melee.."/heads/shovel_ogryn_head_05"},
            {name = "head_06",      model = _item_melee.."/full/krieg_shovel_ogryn_full_01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
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
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_melee.."/grips/shovel_ogryn_grip_01"},
            {name = "grip_02",      model = _item_melee.."/grips/shovel_ogryn_grip_02"},
            {name = "grip_03",      model = _item_melee.."/grips/shovel_ogryn_grip_03"},
            {name = "grip_04",      model = _item_melee.."/grips/shovel_ogryn_grip_04"},
            {name = "grip_05",      model = _item_melee.."/grips/shovel_ogryn_grip_05"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "pommel_01", name = "Pommel 1"},
            {id = "pommel_02", name = "Pommel 2"},
            {id = "pommel_03", name = "Pommel 3"},
            {id = "pommel_04", name = "Pommel 4"},
            {id = "pommel_05", name = "Pommel 5"},
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
            {name = "pommel_01",      model = _item_melee.."/pommels/shovel_ogryn_pommel_01"},
            {name = "pommel_02",      model = _item_melee.."/pommels/shovel_ogryn_pommel_02"},
            {name = "pommel_03",      model = _item_melee.."/pommels/shovel_ogryn_pommel_03"},
            {name = "pommel_04",      model = _item_melee.."/pommels/shovel_ogryn_pommel_04"},
            {name = "pommel_05",      model = _item_melee.."/pommels/shovel_ogryn_pommel_05"},
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
            -- Native
            grip = functions.grip_attachments(),
            pommel = functions.pommel_attachments(),
            head = functions.head_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            functions.head_models(nil, 0, vector3_box(.1, -4, -.1), vector3_box(0, 0, .4), "head", {
                {"trinket_hook_empty"},
            }, nil, nil, "both", function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") or string_find(attachment, "head_06") then
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "grip_default" then changes["grip"] = "grip_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "grip", item) == "grip_default" then changes["grip"] = "grip_01" end
                    if mod:get_gear_setting(gear_id, "pommel", item) == "pommel_default" then changes["pommel"] = "pommel_01" end
                end
                return changes
            end),
            functions.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", nil, nil, nil, true, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "head_01" end
                    if mod:get_gear_setting(gear_id, "pommel", item) == "pommel_default" then changes["pommel"] = "pommel_01" end
                end
                return changes
            end),
            functions.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", nil, nil, nil, "both", function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "grip_default" then changes["grip"] = "grip_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "head_01" end
                    if mod:get_gear_setting(gear_id, "grip", item) == "grip_default" then changes["grip"] = "grip_01" end
                end
                return changes
            end),
            -- Common
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models("head", 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"head_01", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .485), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .47), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_02", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_03", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .86), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .615), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .825), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .585), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_04", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .96), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .925), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .685), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_05", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .52), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .79), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .535), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .77), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_06"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(-.01, -.2, .82), rotation = vector3_box(90, -17.5, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.09, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},

                {emblem_left = {parent = "grip", position = vector3_box(.005, -.2, .82), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.0975, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},

                {dependencies = {"head_01", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_01", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .12), mesh_position = vector3_box(0, 0, -.24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_01", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .05), mesh_position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
            },
        },
    }
)