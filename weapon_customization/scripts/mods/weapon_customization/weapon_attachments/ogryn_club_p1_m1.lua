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

local changes = {}
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
            }, nil, nil, "both", function(gear_id, item, attachment, attachment_list)
                changes = {}
                local item_name = mod.gear_settings:short_name(item.name)
                if item_name == "ogryn_club_p1_m1" then
                    local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
                    local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
                    if mod:cached_find(attachment, "default") or attachment == "ogryn_club_head_06" or attachment == "ogryn_club_head_07" then
                        if grip ~= "grip_default" then changes["grip"] = "grip_default" end
                        if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                    else
                        if not grip or grip == "grip_default" then changes["grip"] = "ogryn_club_grip_01" end
                        if not pommel or pommel == "pommel_default" then changes["pommel"] = "ogryn_club_pommel_01" end
                    end
                end
                return changes
            end),
            _ogryn_club_p1_m1.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", nil, nil, nil, true, function(gear_id, item, attachment, attachment_list)
                changes = {}
                local item_name = mod.gear_settings:short_name(item.name)
                if item_name == "ogryn_club_p1_m1" then
                    local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                    local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
                    if mod:cached_find(attachment, "default") then
                        if head ~= "head_default" then changes["head"] = "head_default" end
                        if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                    else
                        if not head or head == "head_default" then changes["head"] = "ogryn_club_head_01" end
                        if not pommel or pommel == "pommel_default" then changes["pommel"] = "ogryn_club_pommel_01" end
                    end
                end
                return changes
            end),
            _ogryn_club_p1_m1.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", nil, nil, nil, "both", function(gear_id, item, attachment, attachment_list)
                changes = {}
                local item_name = mod.gear_settings:short_name(item.name)
                if item_name == "ogryn_club_p1_m1" then
                    local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                    local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
                    if mod:cached_find(attachment, "default") then
                        if head ~= "head_default" then changes["head"] = "head_default" end
                        if grip ~= "grip_default" then changes["grip"] = "grip_default" end
                    else
                        if not head or head == "head_default" then changes["head"] = "ogryn_club_head_01" end
                        if not grip or grip == "grip_default" then changes["grip"] = "ogryn_club_grip_01" end
                    end
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
                --#region Emblems
                    {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .485), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .47), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                    {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                    {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .86), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .615), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_03"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .825), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.135, 0, .585), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                    {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .96), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .925), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.15, 0, .685), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},

                    {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_01"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .52), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_02"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_04"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.04, 0, .79), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .535), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                    {dependencies = {"ogryn_club_head_05"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(.04, 0, .77), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.115, 0, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                    {dependencies = {"ogryn_club_head_06"}, -- Emblems
                        emblem_left = {parent = "grip", position = vector3_box(-.01, -.2, .82), rotation = vector3_box(90, -17.5, 180), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.09, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},

                    {emblem_left = {parent = "grip", position = vector3_box(.005, -.2, .82), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                        emblem_right = {parent = "grip", position = vector3_box(.0975, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},
                --#endregion

                {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_04", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .12), mesh_position = vector3_box(0, 0, -.24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_01", "ogryn_club_grip_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_01", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_01", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_01", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_03", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_03", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_03", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_04", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_04", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_04", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_05", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_05", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_02", "ogryn_club_grip_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.1), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_02", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_02", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_04", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_04", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_04", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_05", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_05", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_03", "ogryn_club_grip_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_01", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_01", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_01", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .05), mesh_position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_03", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_03", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_04", "ogryn_club_grip_03", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_01", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_01", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_01", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_03", "ogryn_club_pommel_02", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_03", "ogryn_club_pommel_05", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"ogryn_club_head_05", "ogryn_club_grip_03", "ogryn_club_p1_m1"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
            },
        },
    }
)