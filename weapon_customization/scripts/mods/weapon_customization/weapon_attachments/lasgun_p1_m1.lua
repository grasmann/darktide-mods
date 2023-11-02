local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
local _bolter_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/bolter_p1_m1")

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

local tv = function(t, i)
    local res = nil
    if type(t) == "table" then
        if #t >= i then
            res = t[i]
        elseif #t >= 1 then
            res = t[1]
        else
            return nil
        end
    else
        res = t
    end
    if res == "" then
        return nil
    end
    return res
end
table.combine = function(...)
    local arg = {...}
    local combined = {}
    for _, t in ipairs(arg) do
        for name, value in pairs(t) do
            combined[name] = value
        end
    end
    return combined
end
table.icombine = function(...)
    local arg = {...}
    local combined = {}
    for _, t in ipairs(arg) do
        for _, value in pairs(t) do
            combined[#combined+1] = value
        end
    end
    return combined
end

local functions = {
    receiver_attachments = function()
        return {
            {id = "receiver_default",   name = mod:localize("mod_attachment_default")},
            {id = "receiver_01",        name = "Receiver 1"},
            {id = "receiver_02",        name = "Receiver 2"},
        }
    end,
    receiver_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            receiver_default = {model = "",                                                  type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            receiver_01 =      {model = _item_ranged.."/recievers/lasgun_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            receiver_02 =      {model = _item_ranged.."/recievers/lasgun_rifle_receiver_02", type = "receiver", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 6.10.2023
            flashlight = _common_ranged.flashlights_attachments(),
            rail = _common_lasgun.rail_attachments(),
            grip = _common_ranged.grip_attachments(),
            barrel = _common_lasgun.barrel_attachments(),
            muzzle = _common_lasgun.muzzle_attachments(),
            bayonet = _common_ranged.bayonet_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            sight = table.icombine(
                _common_ranged.sight_default(),
                _common_ranged.reflex_sights_attachments(),
                _common_ranged.sights_attachments()
            ),
            help_sight = _bolter_p1_m1.sight_attachments(),
            receiver = functions.receiver_attachments(),
            stock = table.icombine(
                {{id = "stock_default", name = mod:localize("mod_attachment_default")}},
                _common_ranged.stock_attachments()
            ),
            magazine = _common_lasgun.magazine_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
            slot_trinket_1 = _common.slot_trinket_1_attachments(),
        },
        models = table.combine( -- Done 6.10.2023
            _common_ranged.flashlight_models(nil, -2.5, vector3_box(-.4, -3, 0), vector3_box(.2, 0, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            _common.emblem_right_models("receiver", -3, vector3_box(-.2, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.2, -4, 0), vector3_box(.2, 0, 0)),
            _common_ranged.bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, vector3_box(.3, -3, 0), vector3_box(0, .4, -.034)),
            _common_ranged.grip_models(nil, .4, vector3_box(-.4, -4, .1), vector3_box(0, -.1, -.1)),
            _common_lasgun.barrel_models(nil, -.3, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            _common_lasgun.muzzle_models(nil, -.5, vector3_box(.4, -3, 0), vector3_box(0, .2, 0)),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_ranged.reflex_sights_models("rail", .2, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "sight_default"},
            }, {
                {{"receiver", 5}},
            }),
            _common_ranged.sights_models(nil, .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", {}, {
                {rail = "rail_default", help_sight = "sight_default"},
                {rail = "rail_01", help_sight = "bolter_sight_01"},
                {rail = "rail_default", help_sight = "bolter_sight_01"},
                {rail = "rail_01", help_sight = "bolter_sight_01"},
                {rail = "rail_default", help_sight = "sight_default"},
            }, {
                {{"receiver", 5}},
                {{"receiver", 5}},
                {{"receiver", 5}},
                {{"receiver", 5}},
                {{"receiver", 5}, {"sight", 1}},
            }),
            _bolter_p1_m1.sight_models("receiver", .35, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "help_sight", {}, {}, {}),
            _common_ranged.stock_models(nil, .5, vector3_box(-.6, -4, 0), vector3_box(0, -.4, -.11)),
            _common.trinket_hook_models("barrel", 0, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            _common.slot_trinket_1_models("trinket_hook", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_lasgun.magazine_models(nil, .2, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 6.10.2023
            no_scope_offset = {position = vector3_box(0, 0, -.0455)},
            -- help_sight = {position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0), scale_node = 5},
            fixes = {
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, 0, 0), mesh_position = vector3_box(.007, 0, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(.825, 1, 1), scale_node = 6}},
                {dependencies = {"lasgun_rifle_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, -.0285), rotation = vector3_box(.1, 0, 0)}},
                {dependencies = {"autogun_rifle_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(-.0975, .03, -.075), mesh_position = vector3_box(.0975, 0, .075), scale = vector3_box(.7, 1, 1), scale_node = 5},
                    help_sight = {offset = true, position = vector3_box(.056, 0, -.045), scale = vector3_box(.645, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, -.011), rotation = vector3_box(.3, 0, 0)}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .0225, 0), mesh_position = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(.056, 0, -.046), scale = vector3_box(.645, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_ak_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, -.0135), rotation = vector3_box(0, 0, 0)}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Lasgun sight
                    sight = {offset = true, position = vector3_box(0, .0225, 0), mesh_position = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1), scale_node = 1},
                    help_sight = {offset = true, position = vector3_box(.056, 0, -.046), scale = vector3_box(.645, .75, 1), scale_node = 5}},
                {dependencies = {"autogun_rifle_killshot_sight_01"}, -- Infantry sight
                    no_scope_offset = {position = vector3_box(0, 0, -.012), rotation = vector3_box(.4, 0, 0)}},
                {help_sight = {parent = "receiver", position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0), scale_node = 5}},
                {dependencies = {"barrel_01", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .195, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_03", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .195, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_04", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_05", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_06", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_07", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_07", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "muzzle", position = vector3_box(0, .065, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_08", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_08", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .27, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_09", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_09", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_10", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .495, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_10", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .495, -.03), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_11", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .42, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_11", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .42, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_12", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_12", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .36, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_13", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .35, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_13", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .35, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_14", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_14", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_15", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .17, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_15", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .17, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_16", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .19, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_16", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .19, -.042), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_17", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_17", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18", "autogun_bayonet_01"}, -- Bayonet 1
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18", "autogun_bayonet_02"}, -- Bayonet 2
                    bayonet = {parent = "barrel", position = vector3_box(0, .18, -.043), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"autogun_bayonet_03", "muzzle_07|muzzle_08|muzzle_09"}, -- Bayonet 3
                    bayonet = {parent = "muzzle", position = vector3_box(0, .05, -.032), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},

                {dependencies = {"barrel_17"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(0, .075, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_18"}, -- Trinket hook
                    trinket_hook = {parent = "barrel", position = vector3_box(0, .075, -.11), rotation = vector3_box(-45, 0, 0), scale = vector3_box(1, 1, 1)}},
            },
        },
    }
)