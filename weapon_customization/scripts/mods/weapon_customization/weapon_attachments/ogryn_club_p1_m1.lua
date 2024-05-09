local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _ogryn_club_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_club_p1_m1")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local vector3_box = Vector3Box
    local table = table
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    _ogryn_club_p1_m1,
    {
        attachments = {
            -- Native
            grip = _ogryn_club_p1_m1.grip_attachments(),
            pommel = _ogryn_club_p1_m1.pommel_attachments(),
            head = _ogryn_club_p1_m1.head_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            _ogryn_club_p1_m1.head_models(nil, 0, vector3_box(.1, -4, -.1), vector3_box(0, 0, .4), "head", {
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
            _ogryn_club_p1_m1.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", nil, nil, nil, true, function(gear_id, item, attachment)
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
            _ogryn_club_p1_m1.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", nil, nil, nil, "both", function(gear_id, item, attachment)
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