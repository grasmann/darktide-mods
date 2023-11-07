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
    body_attachments = function(default)
        local attachments = {
            {id = "body_01",   name = "Body 1"},
            {id = "body_02",   name = "Body 2"},
            {id = "body_03",   name = "Body 3"},
            {id = "body_04",   name = "Body 4"},
            {id = "body_05",   name = "Body 5"},
            {id = "body_none", name = "Body None", no_randomize = true},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "body_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "body_default", model = ""},
            {name = "body_01",      model = _item_melee.."/full/ogryn_club_pipe_full_01"},
            {name = "body_02",      model = _item_melee.."/full/ogryn_club_pipe_full_02"},
            {name = "body_03",      model = _item_melee.."/full/ogryn_club_pipe_full_03"},
            {name = "body_04",      model = _item_melee.."/full/ogryn_club_pipe_full_04"},
            {name = "body_05",      model = _item_melee.."/full/ogryn_club_pipe_full_05"},
            {name = "body_none",    model = _item_melee.."/ogryn_powermaul_p1_empty"},
        }, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
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
            body = functions.body_attachments(),
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
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2), nil, nil, nil, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                if attachment ~= "body_none" then
                    if mod:get_gear_setting(gear_id, "shaft", item) ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                elseif attachment == "body_none" then
                    if mod:get_gear_setting(gear_id, "shaft", item) == "shaft_default" then changes["shaft"] = "small_shaft_01" end
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "small_head_01" end
                end
                return changes
            end),
            -- Melee
            _common_melee.human_power_maul_shaft_models("body", 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2), nil, nil, nil, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "shaft", item) ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                else
                    if mod:get_gear_setting(gear_id, "shaft", item) == "shaft_default" then changes["shaft"] = "small_shaft_01" end
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "small_head_01" end
                    if mod:get_gear_setting(gear_id, "body", item) ~= "body_none" then changes["body"] = "body_none" end
                end
                return changes
            end),
            _common_melee.human_power_maul_head_models("shaft", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2), nil, nil, nil, nil, nil, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "shaft", item) ~= "shaft_default" then changes["shaft"] = "shaft_default" end
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                else
                    if mod:get_gear_setting(gear_id, "shaft", item) == "shaft_default" then changes["shaft"] = "small_shaft_01" end
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "small_head_01" end
                    if mod:get_gear_setting(gear_id, "body", item) ~= "body_none" then changes["body"] = "body_none" end
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