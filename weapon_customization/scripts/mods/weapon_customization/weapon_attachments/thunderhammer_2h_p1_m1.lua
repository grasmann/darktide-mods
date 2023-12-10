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
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

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
    shaft_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_shaft_01",      name = "Shaft 1"},
            {id = "thunder_hammer_shaft_02",      name = "Shaft 2"},
            {id = "thunder_hammer_shaft_03",      name = "Shaft 3"},
            {id = "thunder_hammer_shaft_04",      name = "Shaft 4"},
            {id = "thunder_hammer_shaft_05",      name = "Shaft 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "thunder_hammer_shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "thunder_hammer_shaft_default", model = ""},
            {name = "thunder_hammer_shaft_01",      model = _item_ranged.."/shafts/thunder_hammer_shaft_01"},
            {name = "thunder_hammer_shaft_02",      model = _item_ranged.."/shafts/thunder_hammer_shaft_02"},
            {name = "thunder_hammer_shaft_03",      model = _item_ranged.."/shafts/thunder_hammer_shaft_03"},
            {name = "thunder_hammer_shaft_04",      model = _item_ranged.."/shafts/thunder_hammer_shaft_04"},
            {name = "thunder_hammer_shaft_05",      model = _item_ranged.."/shafts/thunder_hammer_shaft_05"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_head_01",      name = "Head 1"},
            {id = "thunder_hammer_head_02",      name = "Head 2"},
            {id = "thunder_hammer_head_03",      name = "Head 3"},
            {id = "thunder_hammer_head_04",      name = "Head 4"},
            {id = "thunder_hammer_head_05",      name = "Head 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "thunder_hammer_head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "thunder_hammer_head_default", model = ""},
            {name = "thunder_hammer_head_01",      model = _item_melee.."/heads/thunder_hammer_head_01"},
            {name = "thunder_hammer_head_02",      model = _item_melee.."/heads/thunder_hammer_head_02"},
            {name = "thunder_hammer_head_03",      model = _item_melee.."/heads/thunder_hammer_head_03"},
            {name = "thunder_hammer_head_04",      model = _item_melee.."/heads/thunder_hammer_head_04"},
            {name = "thunder_hammer_head_05",      model = _item_melee.."/heads/thunder_hammer_head_05"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_pommel_01",      name = "Pommel 1"},
            {id = "thunder_hammer_pommel_02",      name = "Pommel 2"},
            {id = "thunder_hammer_pommel_03",      name = "Pommel 3"},
            {id = "thunder_hammer_pommel_04",      name = "Pommel 4"},
            {id = "thunder_hammer_pommel_05",      name = "Pommel 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "thunder_hammer_pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "thunder_hammer_pommel_default", model = ""},
            {name = "thunder_hammer_pommel_01",      model = _item_melee.."/pommels/thunder_hammer_pommel_01"},
            {name = "thunder_hammer_pommel_02",      model = _item_melee.."/pommels/thunder_hammer_pommel_02"},
            {name = "thunder_hammer_pommel_03",      model = _item_melee.."/pommels/thunder_hammer_pommel_03"},
            {name = "thunder_hammer_pommel_04",      model = _item_melee.."/pommels/thunder_hammer_pommel_04"},
            {name = "thunder_hammer_pommel_05",      model = _item_melee.."/pommels/thunder_hammer_pommel_05"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    connector_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_connector_01",      name = "Connector 1"},
            {id = "thunder_hammer_connector_02",      name = "Connector 2"},
            {id = "thunder_hammer_connector_03",      name = "Connector 3"},
            {id = "thunder_hammer_connector_04",      name = "Connector 4"},
            {id = "thunder_hammer_connector_05",      name = "Connector 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "thunder_hammer_connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "thunder_hammer_connector_default", model = ""},
            {name = "thunder_hammer_connector_01",      model = _item_melee.."/connectors/thunder_hammer_connector_01"},
            {name = "thunder_hammer_connector_02",      model = _item_melee.."/connectors/thunder_hammer_connector_02"},
            {name = "thunder_hammer_connector_03",      model = _item_melee.."/connectors/thunder_hammer_connector_03"},
            {name = "thunder_hammer_connector_04",      model = _item_melee.."/connectors/thunder_hammer_connector_04"},
            {name = "thunder_hammer_connector_05",      model = _item_melee.."/connectors/thunder_hammer_connector_05"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            shaft = functions.shaft_attachments(),
            pommel = functions.pommel_attachments(),
            connector = _common.connector_attachments(),
            -- head = functions.head_attachments(),
            head = _common_melee.blunt_head_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 4, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.shaft_models(nil, 0, vector3_box(-.5, -3, .3), vector3_box(0, 0, 0)),
            _common.connector_models("shaft", 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .1), "connector", {
                {},
                -- Thunder
                {"trinket_hook"},
                {"trinket_hook"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                -- Staff
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                -- Power
                {"trinket_hook"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
                {"trinket_hook_empty", "trinket_hook_default"},
            }, {
                {},
                -- Thunder
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                -- Staff
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                -- Power
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
                {trinket_hook = "trinket_hook_default|trinket_hook_01"},
            }, nil, {
                false,
            }, function(gear_id, item, attachment)
                local changes = {}
                local list_a = {"thunder_hammer_connector_03", "thunder_hammer_connector_04", "thunder_hammer_connector_05", "body_01", "body_02", "body_03", "body_04", "body_05", "2h_power_maul_connector_01", "2h_power_maul_connector_02", "2h_power_maul_connector_03", "2h_power_maul_connector_04", "2h_power_maul_connector_05"}
                if table.contains(list_a, attachment) then
                    local trinket_hook = mod:get_gear_setting(gear_id, "trinket_hook", item)
                    if trinket_hook == "trinket_hook_empty" then
                        changes["trinket_hook"] = "trinket_hook_01"
                    end
                end
                return changes
            end),
            -- functions.head_models(nil, 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2)),
            _common_melee.blunt_head_models("connector", 0, vector3_box(.15, -6.5, -.4), vector3_box(0, 0, .2), "head"),
            functions.pommel_models(nil, 0, vector3_box(-.75, -4, .5), vector3_box(0, 0, -.1))
        ),
        anchors = {
            fixes = {

                {dependencies = {"body_03", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_04", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_03"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .175), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"body_04"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"body_02|body_05", "head_01|head_02|head_03|head_04|head_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_02|body_05"}, 
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"body_01|body_02|body_03|body_04|body_05", "head_01|head_02|head_03|head_04|head_05"}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"body_01|body_02|body_03|body_04|body_05"}, 
                    connector = {parent = "shaft", position = vector3_box(0, 0, .61), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    head = {parent = "connector", position = vector3_box(0, 0, .25), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_01"},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_02|2h_power_maul_connector_03"},
                    head = {parent = "connector", position = vector3_box(0, 0, .27), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},
                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "2h_power_maul_connector_04|2h_power_maul_connector_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, .22), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05", "thunder_hammer_connector_01|thunder_hammer_connector_02|thunder_hammer_connector_03|thunder_hammer_connector_04|thunder_hammer_connector_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, .2), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

                {dependencies = {"head_01|head_02|head_03|head_04|head_05"},
                    head = {parent = "connector", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.33, .33, .33)}},

            },
        },
    }
)