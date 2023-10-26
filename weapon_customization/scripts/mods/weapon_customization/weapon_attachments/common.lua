local mod = get_mod("weapon_customization")

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

return {
    flashlights_attachments = function()
        return {
            {id = "default",       name = "Default",},
            {id = "flashlight_01", name = "Flashlight 1"},
            {id = "flashlight_02", name = "Flashlight 2"},
            {id = "flashlight_03", name = "Flashlight 3"},
            {id = "flashlight_04", name = "Flashlight 4"},
            {id = "laser_pointer", name = "Laser Pointer"},
        }
    end,
    flashlight_models = function(parent, angle, move, remove, mesh_move)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            default =       {model = "",                                         type = "flashlight", parent = tv(parent, 1), angle = a, move = tv(m, 1), remove = tv(r, 1), mesh_move = false},
            flashlight_01 = {model = _item_ranged.."/flashlights/flashlight_01", type = "flashlight", parent = tv(parent, 2), angle = a, move = tv(m, 2), remove = tv(r, 2), mesh_move = false},
            flashlight_02 = {model = _item_ranged.."/flashlights/flashlight_02", type = "flashlight", parent = tv(parent, 3), angle = a, move = tv(m, 3), remove = tv(r, 3), mesh_move = false},
            flashlight_03 = {model = _item_ranged.."/flashlights/flashlight_03", type = "flashlight", parent = tv(parent, 4), angle = a, move = tv(m, 4), remove = tv(r, 4), mesh_move = false},
            flashlight_04 = {model = _item_ranged.."/flashlights/flashlight_05", type = "flashlight", parent = tv(parent, 5), angle = a, move = tv(m, 5), remove = tv(r, 5), mesh_move = false},
            laser_pointer = {model = _item_ranged.."/flashlights/flashlight_05", type = "flashlight", parent = tv(parent, 6), angle = a, move = tv(m, 6), remove = tv(r, 6), mesh_move = false},
        }
    end,
    emblem_right_attachments = function()
        return {
            {id = "emblem_right_default", name = "Default"},
            {id = "emblem_right_01", name = "Emblem 1"},
            {id = "emblem_right_02", name = "Emblem 2"},
            {id = "emblem_right_03", name = "Emblem 3"},
            {id = "emblem_right_04", name = "Emblem 4"},
            {id = "emblem_right_05", name = "Emblem 5"},
            {id = "emblem_right_06", name = "Emblem 6"},
            {id = "emblem_right_07", name = "Emblem 7"},
            {id = "emblem_right_08", name = "Emblem 8"},
            {id = "emblem_right_09", name = "Emblem 9"},
            {id = "emblem_right_10", name = "Emblem 10"},
            {id = "emblem_right_11", name = "Emblem 11"},
            {id = "emblem_right_12", name = "Emblem 12"},
            {id = "emblem_right_13", name = "Emblem 13"},
            {id = "emblem_right_14", name = "Emblem 14"},
            {id = "emblem_right_15", name = "Emblem 15"},
            {id = "emblem_right_16", name = "Emblem 16"},
            {id = "emblem_right_17", name = "Emblem 17"},
            {id = "emblem_right_18", name = "Emblem 18"},
            {id = "emblem_right_19", name = "Emblem 19"},
            {id = "emblem_right_20", name = "Emblem 20"},
            {id = "emblem_right_21", name = "Emblem 21"},
        }
    end,
    emblem_right_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            emblem_right_default = {model = "",                                       type = "emblem_right", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_01 =      {model = _item_ranged.."/emblems/emblemright_01",  type = "emblem_right", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_02 =      {model = _item_ranged.."/emblems/emblemright_02",  type = "emblem_right", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_03 =      {model = _item_ranged.."/emblems/emblemright_03",  type = "emblem_right", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_04 =      {model = _item_ranged.."/emblems/emblemright_04a", type = "emblem_right", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_05 =      {model = _item_ranged.."/emblems/emblemright_04b", type = "emblem_right", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_06 =      {model = _item_ranged.."/emblems/emblemright_04c", type = "emblem_right", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_07 =      {model = _item_ranged.."/emblems/emblemright_04d", type = "emblem_right", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_08 =      {model = _item_ranged.."/emblems/emblemright_04e", type = "emblem_right", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_09 =      {model = _item_ranged.."/emblems/emblemright_04f", type = "emblem_right", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_10 =      {model = _item_ranged.."/emblems/emblemright_05",  type = "emblem_right", parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_11 =      {model = _item_ranged.."/emblems/emblemright_06",  type = "emblem_right", parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_12 =      {model = _item_ranged.."/emblems/emblemright_07",  type = "emblem_right", parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_13 =      {model = _item_ranged.."/emblems/emblemright_08a", type = "emblem_right", parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_14 =      {model = _item_ranged.."/emblems/emblemright_08b", type = "emblem_right", parent = tv(parent, 15), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_15 =      {model = _item_ranged.."/emblems/emblemright_08c", type = "emblem_right", parent = tv(parent, 16), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_16 =      {model = _item_ranged.."/emblems/emblemright_09a", type = "emblem_right", parent = tv(parent, 17), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_17 =      {model = _item_ranged.."/emblems/emblemright_09b", type = "emblem_right", parent = tv(parent, 18), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_18 =      {model = _item_ranged.."/emblems/emblemright_09c", type = "emblem_right", parent = tv(parent, 19), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_19 =      {model = _item_ranged.."/emblems/emblemright_09d", type = "emblem_right", parent = tv(parent, 20), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_20 =      {model = _item_ranged.."/emblems/emblemright_09e", type = "emblem_right", parent = tv(parent, 21), angle = a, move = m, remove = r, mesh_move = false},
            emblem_right_21 =      {model = _item_ranged.."/emblems/emblemright_10",  type = "emblem_right", parent = tv(parent, 22), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    emblem_left_attachments = function()
        return {
            {id = "emblem_left_default", name = "Default"},
            {id = "emblem_left_01", name = "Emblem 1"},
            {id = "emblem_left_02", name = "Emblem 2"},
            {id = "emblem_left_03", name = "Emblem 3"},
            {id = "emblem_left_04", name = "Emblem 4"},
            {id = "emblem_left_05", name = "Emblem 5"},
            {id = "emblem_left_06", name = "Emblem 6"},
            {id = "emblem_left_07", name = "Emblem 7"},
            {id = "emblem_left_08", name = "Emblem 8"},
            {id = "emblem_left_09", name = "Emblem 9"},
            {id = "emblem_left_10", name = "Emblem 10"},
            {id = "emblem_left_11", name = "Emblem 11"},
            {id = "emblem_left_12", name = "Emblem 12"},
        }
    end,
    emblem_left_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            emblem_left_default = {model = "",                                      type = "emblem_left", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_01 =      {model = _item_ranged.."/emblems/emblemleft_01",  type = "emblem_left", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_02 =      {model = _item_ranged.."/emblems/emblemleft_02",  type = "emblem_left", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_03 =      {model = _item_ranged.."/emblems/emblemleft_03",  type = "emblem_left", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_04 =      {model = _item_ranged.."/emblems/emblemleft_04a", type = "emblem_left", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_05 =      {model = _item_ranged.."/emblems/emblemleft_04b", type = "emblem_left", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_06 =      {model = _item_ranged.."/emblems/emblemleft_04c", type = "emblem_left", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_07 =      {model = _item_ranged.."/emblems/emblemleft_04d", type = "emblem_left", parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_08 =      {model = _item_ranged.."/emblems/emblemleft_04e", type = "emblem_left", parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_09 =      {model = _item_ranged.."/emblems/emblemleft_04f", type = "emblem_left", parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_10 =      {model = _item_ranged.."/emblems/emblemleft_05",  type = "emblem_left", parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_11 =      {model = _item_ranged.."/emblems/emblemleft_06",  type = "emblem_left", parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            emblem_left_12 =      {model = _item_ranged.."/emblems/emblemleft_10",  type = "emblem_left", parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    grip_attachments = function()
        return {
            {id = "grip_default", name = "Default"},
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
            {id = "grip_04", name = "Grip 4"},
            {id = "grip_05", name = "Grip 5"},
            {id = "grip_06", name = "Autogun 1"},
            {id = "grip_07", name = "Autogun 2"},
            {id = "grip_08", name = "Autogun 3"},
            {id = "grip_09", name = "Braced Autogun 1"},
            {id = "grip_10", name = "Braced Autogun 2"},
            {id = "grip_11", name = "Braced Autogun 3"},
            {id = "grip_12", name = "Headhunter Autogun"},
            {id = "grip_13", name = "Boltgun 1"},
            {id = "grip_14", name = "Boltgun 2"},
            {id = "grip_15", name = "Boltgun 3"},
            {id = "grip_19", name = "Laspistol 1"},
            {id = "grip_20", name = "Laspistol 2"},
            {id = "grip_21", name = "Laspistol 3"},
            {id = "grip_22", name = "Lasgun 1"},
            {id = "grip_23", name = "Lasgun 2"},
            {id = "grip_24", name = "Lasgun 3"},
            {id = "grip_25", name = "Lasgun 4"},
            {id = "grip_26", name = "Lasgun 5"},
            {id = "grip_27", name = "Flamer 1"},
            {id = "grip_28", name = "Flamer 2"},
            {id = "grip_29", name = "Flamer 3"},
        }
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "grip"
        local n = no_support or {}
        local ae = automatic_equip or {}
        return {
            grip_default = {model = "",                                                    type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1)},
            grip_01 =      {model = _item_ranged.."/grips/grip_01",                        type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2)},
            grip_02 =      {model = _item_ranged.."/grips/grip_02",                        type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3)},
            grip_03 =      {model = _item_ranged.."/grips/grip_03",                        type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4)},
            grip_04 =      {model = _item_ranged.."/grips/grip_04",                        type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5)},
            grip_05 =      {model = _item_ranged.."/grips/grip_05",                        type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 6), no_support = tv(n, 6)},
            grip_06 =      {model = _item_ranged.."/grips/autogun_rifle_grip_01",          type = t, parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 7), no_support = tv(n, 7)},
            grip_07 =      {model = _item_ranged.."/grips/autogun_rifle_grip_02",          type = t, parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 8), no_support = tv(n, 8)},
            grip_08 =      {model = _item_ranged.."/grips/autogun_rifle_grip_03",          type = t, parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 9), no_support = tv(n, 9)},
            grip_09 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_01",       type = t, parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 10), no_support = tv(n, 10)},
            grip_10 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_02",       type = t, parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 11), no_support = tv(n, 11)},
            grip_11 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_03",       type = t, parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 12), no_support = tv(n, 12)},
            grip_12 =      {model = _item_ranged.."/grips/autogun_rifle_grip_killshot_01", type = t, parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 13), no_support = tv(n, 13)},
            grip_13 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_01",          type = t, parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 14), no_support = tv(n, 14)},
            grip_14 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_02",          type = t, parent = tv(parent, 15), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 15), no_support = tv(n, 15)},
            grip_15 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_03",          type = t, parent = tv(parent, 16), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 16), no_support = tv(n, 16)},
            grip_19 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_01",          type = t, parent = tv(parent, 17), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 17), no_support = tv(n, 17)},
            grip_20 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_02",          type = t, parent = tv(parent, 18), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 18), no_support = tv(n, 18)},
            grip_21 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_03",          type = t, parent = tv(parent, 19), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 19), no_support = tv(n, 19)},
            grip_22 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_01",           type = t, parent = tv(parent, 20), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 20), no_support = tv(n, 20)},
            grip_23 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_02",           type = t, parent = tv(parent, 21), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 21), no_support = tv(n, 21)},
            grip_24 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_03",           type = t, parent = tv(parent, 22), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 22), no_support = tv(n, 22)},
            grip_25 =      {model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_02",   type = t, parent = tv(parent, 23), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 23), no_support = tv(n, 23)},
            grip_26 =      {model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_03",   type = t, parent = tv(parent, 24), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 24), no_support = tv(n, 24)},
            grip_27 =      {model = _item_ranged.."/grips/flamer_rifle_grip_01",           type = t, parent = tv(parent, 25), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 25), no_support = tv(n, 25)},
            grip_28 =      {model = _item_ranged.."/grips/flamer_rifle_grip_02",           type = t, parent = tv(parent, 26), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 26), no_support = tv(n, 26)},
            grip_29 =      {model = _item_ranged.."/grips/flamer_rifle_grip_03",           type = t, parent = tv(parent, 27), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 27), no_support = tv(n, 27)},
        }
    end,
    bayonet_attachments = function()
        return {
            {id = "autogun_bayonet_default",    name = "Default"},
            {id = "autogun_bayonet_01",         name = "Bayonet 1"},
            {id = "autogun_bayonet_02",         name = "Bayonet 2"},
            {id = "autogun_bayonet_03",         name = "Bayonet 3"},
        }
    end,
    bayonet_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            autogun_bayonet_default = {model = "",                                   type = "bayonet", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false},
            autogun_bayonet_01 =      {model = _item_ranged.."/bayonets/bayonet_01", type = "bayonet", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = false},
            autogun_bayonet_02 =      {model = _item_ranged.."/bayonets/bayonet_02", type = "bayonet", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = false},
            autogun_bayonet_03 =      {model = _item_ranged.."/bayonets/bayonet_03", type = "bayonet", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = false},
        }
    end,
    reflex_sights_attachments = function()
        return {
            {id = "reflex_sight_01", name = "Reflex Sight 1"},
            {id = "reflex_sight_02", name = "Reflex Sight 2"},
            {id = "reflex_sight_03", name = "Reflex Sight 3"},
            -- {id = "scope", name = "Scope", sounds = {_magazine_sound}},
        }
    end,
    reflex_sights_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "sight"
        local n = no_support or {}
        local ae = automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
        }
        local h = hide_mesh or {}
        return {
            sight_default =   {model = "",                                      type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1)},
            reflex_sight_01 = {model = _item_ranged.."/sights/reflex_sight_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2)},
            reflex_sight_02 = {model = _item_ranged.."/sights/reflex_sight_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3)},
            reflex_sight_03 = {model = _item_ranged.."/sights/reflex_sight_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4)},
            sight_none =      {model = "",                                      type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5)},
            -- scope =           {model = _item_ranged.."/sights/scope_01", type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 6), no_support = tv(n, 6),
            --     hide_mesh = table.icombine(
            --         tv(h, 6),
            --         {"sight", 1}
            --     )},
        }
    end,
    sight_default = function()
        return {
            {id = "sight_default",  name = "Default"}
        }
    end,
    sights_attachments = function()
        return {
            {id = "autogun_rifle_sight_01", name = "Autogun"},
            {id = "autogun_rifle_ak_sight_01", name = "Braced Autogun"},
            {id = "autogun_rifle_killshot_sight_01", name = "Headhunter Autogun"},
            {id = "lasgun_rifle_sight_01", name = "Lasgun"},
        }
    end,
    sights_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "sight"
        local n = no_support or {}
        local ae = automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
        }
        local h = hide_mesh or {}
        return {
            sight_default =                   {model = "",                                                      type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1)},
            autogun_rifle_ak_sight_01 =       {model = _item_ranged.."/sights/autogun_rifle_ak_sight_01",       type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2)},
            autogun_rifle_sight_01 =          {model = _item_ranged.."/sights/autogun_rifle_sight_01",          type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3)},
            autogun_rifle_killshot_sight_01 = {model = _item_ranged.."/sights/autogun_rifle_killshot_sight_01", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4)},
            lasgun_rifle_sight_01 =           {model = _item_ranged.."/sights/lasgun_rifle_sight_01",           type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5)},
        }
    end,
    stock_attachments = function()
        return {
            {id = "no_stock", name = "No Stock"},
            {id = "stock_01", name = "Stock 1"},
            {id = "stock_02", name = "Stock 2"},
            {id = "stock_03", name = "Stock 3"},
            {id = "stock_04", name = "Stock 4"},
            {id = "stock_05", name = "Stock 5"},
            {id = "autogun_rifle_stock_01", name = "Infantry Autogun 1"},
            {id = "autogun_rifle_stock_02", name = "Infantry Autogun 2"},
            {id = "autogun_rifle_stock_03", name = "Infantry Autogun 3"},
            {id = "autogun_rifle_stock_04", name = "Infantry Autogun 4"},
            {id = "autogun_rifle_stock_05", name = "Braced Autogun 1"},
            {id = "autogun_rifle_stock_06", name = "Braced Autogun 2"},
            {id = "autogun_rifle_stock_07", name = "Braced Autogun 3"},
            {id = "autogun_rifle_stock_08", name = "Headhunter Autogun 1"},
            {id = "autogun_rifle_stock_09", name = "Headhunter Autogun 2"},
            {id = "lasgun_stock_01", name = "Infantry Lasgun 1"},
            {id = "lasgun_stock_02", name = "Infantry Lasgun 2"},
            {id = "lasgun_stock_03", name = "Infantry Lasgun 3"},
        }
    end,
    stock_models = function(parent, angle, move, remove, type)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "stock"
        return {
            stock_default =          {model = "",                                                      type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            no_stock =               {model = "",                                                      type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            stock_01 =               {model = _item_ranged.."/stocks/stock_01",                        type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            stock_02 =               {model = _item_ranged.."/stocks/stock_02",                        type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            stock_03 =               {model = _item_ranged.."/stocks/stock_03",                        type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            stock_04 =               {model = _item_ranged.."/stocks/stock_04",                        type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            stock_05 =               {model = _item_ranged.."/stocks/stock_05",                        type = t, parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_01 = {model = _item_ranged.."/stocks/autogun_rifle_stock_01",          type = t, parent = tv(parent, 8), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_02 = {model = _item_ranged.."/stocks/autogun_rifle_stock_02",          type = t, parent = tv(parent, 9), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_03 = {model = _item_ranged.."/stocks/autogun_rifle_stock_03",          type = t, parent = tv(parent, 10), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_04 = {model = _item_ranged.."/stocks/autogun_rifle_stock_04",          type = t, parent = tv(parent, 11), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_05 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_01",       type = t, parent = tv(parent, 12), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_06 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_02",       type = t, parent = tv(parent, 13), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_07 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_03",       type = t, parent = tv(parent, 14), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_08 = {model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_01", type = t, parent = tv(parent, 15), angle = a, move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_09 = {model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_02", type = t, parent = tv(parent, 16), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_stock_01 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_01",           type = t, parent = tv(parent, 17), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_stock_02 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_02",           type = t, parent = tv(parent, 18), angle = a, move = m, remove = r, mesh_move = false},
            lasgun_stock_03 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_03",           type = t, parent = tv(parent, 19), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    trinket_hook_attachments = function()
        return {
            {id = "trinket_hook_default",       name = "Default"},
            {id = "trinket_hook_empty",         name = "No Trinket Hook"},
            {id = "trinket_hook_01",            name = "Trinket Hook 1"},
            {id = "trinket_hook_01_v",          name = "Trinket Hook 1 V"},
            {id = "trinket_hook_02",            name = "Trinket Hook 2"},
            {id = "trinket_hook_02_45",         name = "Trinket Hook 2 45"},
            {id = "trinket_hook_02_90",         name = "Trinket Hook 2 90"},
            {id = "trinket_hook_03",            name = "Trinket Hook 3"},
            {id = "trinket_hook_03_v",          name = "Trinket Hook 3 V"},
            {id = "trinket_hook_04_steel",      name = "Trinket Hook 4 Steel"},
            {id = "trinket_hook_04_steel_v",    name = "Trinket Hook 4 Steel V"},
            {id = "trinket_hook_04_coated",     name = "Trinket Hook 4 Coated"},
            {id = "trinket_hook_04_coated_v",   name = "Trinket Hook 4 Coated V"},
            {id = "trinket_hook_04_carbon",     name = "Trinket Hook 4 Carbon"},
            {id = "trinket_hook_04_carbon_v",   name = "Trinket Hook 4 Carbon V"},
            {id = "trinket_hook_04_gold",       name = "Trinket Hook 4 Gold"},
            {id = "trinket_hook_04_gold_v",     name = "Trinket Hook 4 Gold V"},
            {id = "trinket_hook_05_steel",      name = "Trinket Hook 5 Steel"},
            {id = "trinket_hook_05_steel_v",    name = "Trinket Hook 5 Steel V"},
            {id = "trinket_hook_05_coated",     name = "Trinket Hook 5 Coated"},
            {id = "trinket_hook_05_coated_v",   name = "Trinket Hook 5 Coated V"},
            {id = "trinket_hook_05_carbon",     name = "Trinket Hook 5 Carbon"},
            {id = "trinket_hook_05_carbon_v",   name = "Trinket Hook 5 Carbon V"},
            {id = "trinket_hook_05_gold",       name = "Trinket Hook 5 Gold"},
            {id = "trinket_hook_05_gold_v",     name = "Trinket Hook 5 Gold V"},
        }
    end,
    trinket_hook_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            trinket_hook_default =     {model = "",                                          type = "trinket_hook", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false},
            trinket_hook_02_90 =       {model = _item.."/trinkets/trinket_hook_02_90",       type = "trinket_hook", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = false},
            trinket_hook_01_v =        {model = _item.."/trinkets/trinket_hook_01_v",        type = "trinket_hook", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = false},
            trinket_hook_04_gold_v =   {model = _item.."/trinkets/trinket_hook_04_gold_v",   type = "trinket_hook", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = false},
            trinket_hook_02 =          {model = _item.."/trinkets/trinket_hook_02",          type = "trinket_hook", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), mesh_move = false},
            trinket_hook_03 =          {model = _item.."/trinkets/trinket_hook_03",          type = "trinket_hook", parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6), mesh_move = false},
            trinket_hook_04_steel_v =  {model = _item.."/trinkets/trinket_hook_04_steel_v",  type = "trinket_hook", parent = tv(parent, 7), angle = a, move = m, remove = tv(r, 7), mesh_move = false},
            trinket_hook_04_carbon =   {model = _item.."/trinkets/trinket_hook_04_carbon",   type = "trinket_hook", parent = tv(parent, 8), angle = a, move = m, remove = tv(r, 8), mesh_move = false},
            trinket_hook_04_gold =     {model = _item.."/trinkets/trinket_hook_04_gold",     type = "trinket_hook", parent = tv(parent, 9), angle = a, move = m, remove = tv(r, 9), mesh_move = false},
            trinket_hook_04_carbon_v = {model = _item.."/trinkets/trinket_hook_04_carbon_v", type = "trinket_hook", parent = tv(parent, 10), angle = a, move = m, remove = tv(r, 10), mesh_move = false},
            trinket_hook_04_coated =   {model = _item.."/trinkets/trinket_hook_04_coated",   type = "trinket_hook", parent = tv(parent, 11), angle = a, move = m, remove = tv(r, 11), mesh_move = false},
            trinket_hook_01 =          {model = _item.."/trinkets/trinket_hook_01",          type = "trinket_hook", parent = tv(parent, 12), angle = a, move = m, remove = tv(r, 12), mesh_move = false},
            trinket_hook_04_steel =    {model = _item.."/trinkets/trinket_hook_04_steel",    type = "trinket_hook", parent = tv(parent, 13), angle = a, move = m, remove = tv(r, 13), mesh_move = false},
            trinket_hook_02_45 =       {model = _item.."/trinkets/trinket_hook_02_45",       type = "trinket_hook", parent = tv(parent, 14), angle = a, move = m, remove = tv(r, 14), mesh_move = false},
            trinket_hook_empty =       {model = _item.."/trinkets/trinket_hook_empty",       type = "trinket_hook", parent = tv(parent, 15), angle = a, move = m, remove = tv(r, 15), mesh_move = false, no_animation = true},
            trinket_hook_05_gold =     {model = _item.."/trinkets/trinket_hook_05_gold",     type = "trinket_hook", parent = tv(parent, 16), angle = a, move = m, remove = tv(r, 16), mesh_move = false},
            trinket_hook_05_carbon =   {model = _item.."/trinkets/trinket_hook_05_carbon",   type = "trinket_hook", parent = tv(parent, 17), angle = a, move = m, remove = tv(r, 17), mesh_move = false},
            trinket_hook_05_coated_v = {model = _item.."/trinkets/trinket_hook_05_coated_v", type = "trinket_hook", parent = tv(parent, 18), angle = a, move = m, remove = tv(r, 18), mesh_move = false},
            trinket_hook_05_gold_v =   {model = _item.."/trinkets/trinket_hook_05_gold_v",   type = "trinket_hook", parent = tv(parent, 19), angle = a, move = m, remove = tv(r, 19), mesh_move = false},
            trinket_hook_05_steel_v =  {model = _item.."/trinkets/trinket_hook_05_steel_v",  type = "trinket_hook", parent = tv(parent, 20), angle = a, move = m, remove = tv(r, 20), mesh_move = false},
            trinket_hook_05_coated =   {model = _item.."/trinkets/trinket_hook_05_coated",   type = "trinket_hook", parent = tv(parent, 21), angle = a, move = m, remove = tv(r, 21), mesh_move = false},
            trinket_hook_05_carbon_v = {model = _item.."/trinkets/trinket_hook_05_carbon_v", type = "trinket_hook", parent = tv(parent, 22), angle = a, move = m, remove = tv(r, 22), mesh_move = false},
            trinket_hook_03_v =        {model = _item.."/trinkets/trinket_hook_03_v",        type = "trinket_hook", parent = tv(parent, 23), angle = a, move = m, remove = tv(r, 23), mesh_move = false},
            trinket_hook_05_steel =    {model = _item.."/trinkets/trinket_hook_05_steel",    type = "trinket_hook", parent = tv(parent, 24), angle = a, move = m, remove = tv(r, 24), mesh_move = false},
            trinket_hook_04_coated_v = {model = _item.."/trinkets/trinket_hook_04_coated_v", type = "trinket_hook", parent = tv(parent, 25), angle = a, move = m, remove = tv(r, 25), mesh_move = false},
        }
    end,
    slot_trinket_1_attachments = function()
        return {
            {id = "slot_trinket_1", name = "Default"},
        }
    end,
    slot_trinket_1_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_1 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_1", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
    slot_trinket_2_attachments = function()
        return {
            {id = "slot_trinket_2", name = "Default"},
        }
    end,
    slot_trinket_2_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            slot_trinket_2 = {model = _item.."/trinkets/empty_trinket", type = "slot_trinket_2", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false, no_support = {"trinket_hook"}, automatic_equip = {trinket_hook = "trinket_hook_empty"}},
        }
    end,
    ogryn_bayonet_attachments = function()
        return {
            {id = "bayonet_default",    name = "Default"},
            {id = "bayonet_01",         name = "Bayonet 1"},
            {id = "bayonet_02",         name = "Bayonet 2"},
            {id = "bayonet_03",         name = "Bayonet 3"},
            {id = "bayonet_blade_01",   name = "Blade"},
        }
    end,
    ogryn_bayonet_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            bayonet_default =  {model = "",                                                   type = "bayonet", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1), mesh_move = false},
            bayonet_01 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_01", type = "bayonet", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2), mesh_move = false},
            bayonet_02 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_02", type = "bayonet", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3), mesh_move = false},
            bayonet_03 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_03", type = "bayonet", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4), mesh_move = false},
            bayonet_blade_01 = {model = _item_melee.."/blades/combat_sword_blade_01",         type = "bayonet", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5), mesh_move = false},
        }
    end,
    magazine_attachments = function()
        return {
            {id = "magazine_01",             name = "Autogun 1"},
            {id = "magazine_02",             name = "Autogun 2"},
            {id = "magazine_03",             name = "Autogun 3"},
            {id = "magazine_04",             name = "Braced Autogun 4"},
            {id = "auto_pistol_magazine_01", name = "Magazine 1"},
            {id = "bolter_magazine_01",      name = "Bolter Magazine A"},
            {id = "bolter_magazine_02",      name = "Bolter Magazine B"},
        }
    end,
    magazine_models = function(parent, angle, move, remove, type)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "magazine"
        return {
            magazine_default =        {model = "",                                                      type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            magazine_01 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_01",    type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = false},
            magazine_02 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_02",    type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
            magazine_03 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_03",    type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = false},
            magazine_04 =             {model = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = false},
            auto_pistol_magazine_01 = {model = _item_ranged.."/magazines/autogun_pistol_magazine_01",   type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = false},
            bolter_magazine_01 =      {model = _item_ranged.."/magazines/boltgun_rifle_magazine_01",    type = t, parent = tv(parent, 7), angle = a, move = m, remove = r},
            bolter_magazine_02 =      {model = _item_ranged.."/magazines/boltgun_rifle_magazine_02",    type = t, parent = tv(parent, 8), angle = a, move = m, remove = r},
        }
    end,
}