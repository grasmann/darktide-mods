local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _ogryn_club_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_club_p2_m1")
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _small_shafts = "small_shaft_01|small_shaft_02|small_shaft_03|small_shaft_04|small_shaft_05|small_shaft_06"
    local _small_heads = "small_head_01|small_head_02|small_head_03|small_head_04|small_head_05|small_head_06"
    local _bodies = "body_01|body_02|body_03|body_04|body_05"
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
    _ogryn_club_p2_m1,
    {
        attachments = {
            -- Native
            body = _ogryn_club_p2_m1.body_attachments(),
            -- Melee
            shaft = _common_melee.human_power_maul_shaft_attachments(),
            head = _common_melee.human_power_maul_head_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            _ogryn_club_p2_m1.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
                changes = {}
                local shaft = attachment_list and attachment_list["shaft"] or mod.gear_settings:get(item, "shaft")
                local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                local body = attachment_list and attachment_list["body"] or mod.gear_settings:get(item, "body")
                if attachment ~= "body_none" then
                    if shaft ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if head ~= "head_default" then changes["head"] = "head_default" end
                elseif attachment == "body_none" then
                    if shaft == "shaft_default" then changes["shaft"] = _small_shafts end
                    if head == "head_default" then changes["head"] = _small_heads end
                end
                return changes
            end),
            -- Melee
            _common_melee.human_power_maul_shaft_models("body", 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
                changes = {}
                local shaft = attachment_list and attachment_list["shaft"] or mod.gear_settings:get(item, "shaft")
                local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                local body = attachment_list and attachment_list["body"] or mod.gear_settings:get(item, "body")
                -- if string_find(attachment, "default") then
                if mod:cached_find(attachment, "default") then
                    if shaft ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if head ~= "head_default" then changes["head"] = "head_default" end
                    if body == "body_none" then changes["body"] = _bodies end
                else
                    if shaft == "shaft_default" then changes["shaft"] = _small_shafts end
                    if head == "head_default" then changes["head"] = _small_heads end
                    if body ~= "body_none" then changes["body"] = "body_none" end
                end
                return changes
            end),
            _common_melee.human_power_maul_head_models("shaft", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
                changes = {}
                local shaft = attachment_list and attachment_list["shaft"] or mod.gear_settings:get(item, "shaft")
                local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                local body = attachment_list and attachment_list["body"] or mod.gear_settings:get(item, "body")
                -- if string_find(attachment, "default") then
                if mod:cached_find(attachment, "default") then
                    if shaft ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if head ~= "head_default" then changes["head"] = "head_default" end
                    if body == "body_none" then changes["body"] = _bodies end
                else
                    if shaft == "shaft_default" then changes["shaft"] = _small_shafts end
                    if head == "head_default" then changes["head"] = _small_heads end
                    if body ~= "body_none" then changes["body"] = "body_none" end
                end
                return changes
            end),
            -- Common
            _common.emblem_right_models("body", -2.5, vector3_box(0, -4, -.2), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("body", 0, vector3_box(.1, -4, -.2), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, -.5, vector3_box(0, -4, 0), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"small_shaft_03"},
                    shaft = {position = vector3_box(0, 0, .17), scale = vector3_box(3, 3, 3)},
                    trinket_hook = {parent = "shaft", position = vector3_box(0, 0, -.18)},
                    head = {position = vector3_box(0, 0, .12)}},
                {dependencies = {"small_shaft_04"},
                    shaft = {position = vector3_box(0, 0, .185), scale = vector3_box(3, 3, 3)},
                    trinket_hook = {parent = "shaft", position = vector3_box(0, 0, -.195)},
                    head = {position = vector3_box(0, 0, .1)}},
                {dependencies = {"!shaft_default"},
                    trinket_hook = {parent = "shaft", position = vector3_box(0, 0, -.17)}},
                {shaft = {position = vector3_box(0, 0, .15), scale = vector3_box(3, 3, 3)}},
                {head = {position = vector3_box(0, 0, .135)}},
                {dependencies = {"body_01"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.155, 0, 1.025), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "body", position = vector3_box(.155, 0, 1.025), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"body_02"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.15, -.02, .965), rotation = vector3_box(98, 7.5, 180), scale = vector3_box(2.5, 2.5, 2.5)},
                    emblem_right = {parent = "body", position = vector3_box(.155, -.005, 1.01), rotation = vector3_box(107.5, 0, 0), scale = vector3_box(2.5, 2.5, 2.5)}},
                {dependencies = {"body_03"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.1175, 0, .9), rotation = vector3_box(90, 0, 180), scale = vector3_box(5, 5, 5)},
                    emblem_right = {parent = "body", position = vector3_box(.1475, 0, .9), rotation = vector3_box(90, 0, 0), scale = vector3_box(5, 5, 5)}},
                {dependencies = {"body_04"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.16, .02, .985), rotation = vector3_box(80, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "body", position = vector3_box(.19, .02, .985), rotation = vector3_box(100, 0, -2.5), scale = vector3_box(4, 4, 4)}},
                {dependencies = {"body_05"}, -- Emblems
                    emblem_left = {parent = "body", position = vector3_box(-.19, .02, 1.02), rotation = vector3_box(45, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "body", position = vector3_box(.15, 0, 1.05), rotation = vector3_box(100, 0, -2.5), scale = vector3_box(4, 4, 4)}},
            },
        },
    }
)