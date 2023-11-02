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
    local tv = table.tv
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

return {
    flashlights_attachments = function()
        return {
            {id = "default",       name = mod:localize("mod_attachment_default"),},
            {id = "flashlight_01", name = mod:localize("mod_attachment_flashlight_01")},
            {id = "flashlight_02", name = mod:localize("mod_attachment_flashlight_02")},
            {id = "flashlight_03", name = mod:localize("mod_attachment_flashlight_03")},
            {id = "flashlight_04", name = mod:localize("mod_attachment_flashlight_04")},
            {id = "laser_pointer", name = mod:localize("mod_attachment_laser_pointer")},
        }
    end,
    flashlight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- local t = type or "flashlight"
        -- local n = no_support or {}
        -- local ae = automatic_equip or {}
        -- local h = hide_mesh or {}
        -- return {
        --     default =       {model = "",                                         type = tv(t, 1), parent = tv(parent, 1), angle = tv(a, 1), move = tv(m, 1), remove = tv(r, 1), mesh_move = false, no_support = tv(n, 1), automatic_equip = tv(ae, 1), hide_mesh = tv(h, 1)},
        --     flashlight_01 = {model = _item_ranged.."/flashlights/flashlight_01", type = tv(t, 2), parent = tv(parent, 2), angle = tv(a, 2), move = tv(m, 2), remove = tv(r, 2), mesh_move = false, no_support = tv(n, 2), automatic_equip = tv(ae, 2), hide_mesh = tv(h, 2)},
        --     flashlight_02 = {model = _item_ranged.."/flashlights/flashlight_02", type = tv(t, 3), parent = tv(parent, 3), angle = tv(a, 3), move = tv(m, 3), remove = tv(r, 3), mesh_move = false, no_support = tv(n, 3), automatic_equip = tv(ae, 3), hide_mesh = tv(h, 3)},
        --     flashlight_03 = {model = _item_ranged.."/flashlights/flashlight_03", type = tv(t, 4), parent = tv(parent, 4), angle = tv(a, 4), move = tv(m, 4), remove = tv(r, 4), mesh_move = false, no_support = tv(n, 4), automatic_equip = tv(ae, 4), hide_mesh = tv(h, 4)},
        --     flashlight_04 = {model = _item_ranged.."/flashlights/flashlight_05", type = tv(t, 5), parent = tv(parent, 5), angle = tv(a, 5), move = tv(m, 5), remove = tv(r, 5), mesh_move = false, no_support = tv(n, 5), automatic_equip = tv(ae, 5), hide_mesh = tv(h, 5)},
        --     laser_pointer = {model = _item_ranged.."/flashlights/flashlight_05", type = tv(t, 6), parent = tv(parent, 6), angle = tv(a, 6), move = tv(m, 6), remove = tv(r, 6), mesh_move = false, no_support = tv(n, 6), automatic_equip = tv(ae, 6), hide_mesh = tv(h, 6)},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            default = "",
            flashlight_01 = _item_ranged.."/flashlights/flashlight_01",
            flashlight_02 = _item_ranged.."/flashlights/flashlight_02",
            flashlight_03 = _item_ranged.."/flashlights/flashlight_03",
            flashlight_04 = _item_ranged.."/flashlights/flashlight_05",
            laser_pointer = _item_ranged.."/flashlights/flashlight_05",
        }, parent, angle, move, remove, type or "flashlight", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    grip_attachments = function()
        return {
            {id = "grip_default", name = mod:localize("mod_attachment_default")},
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
            {id = "grip_30", name = "Boltgun Pistol 1"},
            {id = "grip_31", name = "Braced Autogun 4"},
            {id = "grip_32", name = "Braced Autogun 5"},
            {id = "grip_33", name = "Laspistol 4"},
        }
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        -- local _p = "parent"
        -- local _mm = "mesh_move"
        -- local a, _a = angle             or 0,                    "angle"
        -- local m, _m = move              or vector3_box(0, 0, 0), "move"
        -- local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        -- local t, _t = type              or "grip",               "type"
        -- local n, _n = no_support        or {},                   "no_support"
        -- local ae, _ae = automatic_equip or {},                   "automatic_equip"
        -- local h, _h = hide_mesh         or {},                   "hide_mesh"
        -- return {
        --     grip_default = {model = "",                                                    type = t, parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1)},
        --     grip_01 =      {model = _item_ranged.."/grips/grip_01",                        type = t, parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2)},
        --     grip_02 =      {model = _item_ranged.."/grips/grip_02",                        type = t, parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3)},
        --     grip_03 =      {model = _item_ranged.."/grips/grip_03",                        type = t, parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4)},
        --     grip_04 =      {model = _item_ranged.."/grips/grip_04",                        type = t, parent = tv(parent, 5), angle = tv(a, 5), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5)},
        --     grip_05 =      {model = _item_ranged.."/grips/grip_05",                        type = t, parent = tv(parent, 6), angle = tv(a, 6), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 6), no_support = tv(n, 6)},
        --     grip_06 =      {model = _item_ranged.."/grips/autogun_rifle_grip_01",          type = t, parent = tv(parent, 7), angle = tv(a, 7), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 7), no_support = tv(n, 7)},
        --     grip_07 =      {model = _item_ranged.."/grips/autogun_rifle_grip_02",          type = t, parent = tv(parent, 8), angle = tv(a, 8), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 8), no_support = tv(n, 8)},
        --     grip_08 =      {model = _item_ranged.."/grips/autogun_rifle_grip_03",          type = t, parent = tv(parent, 9), angle = tv(a, 9), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 9), no_support = tv(n, 9)},
        --     grip_09 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_01",       type = t, parent = tv(parent, 10), angle = tv(a, 10), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 10), no_support = tv(n, 10)},
        --     grip_10 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_02",       type = t, parent = tv(parent, 11), angle = tv(a, 11), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 11), no_support = tv(n, 11)},
        --     grip_11 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_03",       type = t, parent = tv(parent, 12), angle = tv(a, 12), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 12), no_support = tv(n, 12)},
        --     grip_12 =      {model = _item_ranged.."/grips/autogun_rifle_grip_killshot_01", type = t, parent = tv(parent, 13), angle = tv(a, 13), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 13), no_support = tv(n, 13)},
        --     grip_13 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_01",          type = t, parent = tv(parent, 14), angle = tv(a, 14), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 14), no_support = tv(n, 14)},
        --     grip_14 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_02",          type = t, parent = tv(parent, 15), angle = tv(a, 15), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 15), no_support = tv(n, 15)},
        --     grip_15 =      {model = _item_ranged.."/grips/boltgun_rifle_grip_03",          type = t, parent = tv(parent, 16), angle = tv(a, 16), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 16), no_support = tv(n, 16)},
        --     grip_19 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_01",          type = t, parent = tv(parent, 17), angle = tv(a, 17), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 17), no_support = tv(n, 17)},
        --     grip_20 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_02",          type = t, parent = tv(parent, 18), angle = tv(a, 18), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 18), no_support = tv(n, 18)},
        --     grip_21 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_03",          type = t, parent = tv(parent, 19), angle = tv(a, 19), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 19), no_support = tv(n, 19)},
        --     grip_22 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_01",           type = t, parent = tv(parent, 20), angle = tv(a, 20), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 20), no_support = tv(n, 20)},
        --     grip_23 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_02",           type = t, parent = tv(parent, 21), angle = tv(a, 21), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 21), no_support = tv(n, 21)},
        --     grip_24 =      {model = _item_ranged.."/grips/lasgun_rifle_grip_03",           type = t, parent = tv(parent, 22), angle = tv(a, 22), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 22), no_support = tv(n, 22)},
        --     grip_25 =      {model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_02",   type = t, parent = tv(parent, 23), angle = tv(a, 23), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 23), no_support = tv(n, 23)},
        --     grip_26 =      {model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_03",   type = t, parent = tv(parent, 24), angle = tv(a, 24), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 24), no_support = tv(n, 24)},
        --     grip_27 =      {model = _item_ranged.."/grips/flamer_rifle_grip_01",           type = t, parent = tv(parent, 25), angle = tv(a, 25), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 25), no_support = tv(n, 25)},
        --     grip_28 =      {model = _item_ranged.."/grips/flamer_rifle_grip_02",           type = t, parent = tv(parent, 26), angle = tv(a, 26), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 26), no_support = tv(n, 26)},
        --     grip_29 =      {model = _item_ranged.."/grips/flamer_rifle_grip_03",           type = t, parent = tv(parent, 27), angle = tv(a, 27), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 27), no_support = tv(n, 27)},
        --     grip_30 =      {model = _item_ranged.."/grips/boltgun_pistol_grip_01",         type = t, parent = tv(parent, 28), angle = tv(a, 28), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 28), no_support = tv(n, 28)},
        --     grip_31 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_04",       type = t, parent = tv(parent, 29), angle = tv(a, 29), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 29), no_support = tv(n, 29)},
        --     grip_32 =      {model = _item_ranged.."/grips/autogun_rifle_grip_ak_05",       type = t, parent = tv(parent, 30), angle = tv(a, 30), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 30), no_support = tv(n, 30)},
        --     grip_33 =      {model = _item_ranged.."/grips/lasgun_pistol_grip_04",          type = t, parent = tv(parent, 31), angle = tv(a, 31), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 31), no_support = tv(n, 31)},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            grip_default = "",
            grip_01 = _item_ranged.."/grips/grip_01",
            grip_02 = _item_ranged.."/grips/grip_02",
            grip_03 = _item_ranged.."/grips/grip_03",
            grip_04 = _item_ranged.."/grips/grip_04",
            grip_05 = _item_ranged.."/grips/grip_05",
            grip_06 = _item_ranged.."/grips/autogun_rifle_grip_01",
            grip_07 = _item_ranged.."/grips/autogun_rifle_grip_02",
            grip_08 = _item_ranged.."/grips/autogun_rifle_grip_03",
            grip_09 = _item_ranged.."/grips/autogun_rifle_grip_ak_01",
            grip_10 = _item_ranged.."/grips/autogun_rifle_grip_ak_02",
            grip_11 = _item_ranged.."/grips/autogun_rifle_grip_ak_03",
            grip_12 = _item_ranged.."/grips/autogun_rifle_grip_killshot_01",
            grip_13 = _item_ranged.."/grips/boltgun_rifle_grip_01",
            grip_14 = _item_ranged.."/grips/boltgun_rifle_grip_02",
            grip_15 = _item_ranged.."/grips/boltgun_rifle_grip_03",
            grip_19 = _item_ranged.."/grips/lasgun_pistol_grip_01",
            grip_20 = _item_ranged.."/grips/lasgun_pistol_grip_02",
            grip_21 = _item_ranged.."/grips/lasgun_pistol_grip_03",
            grip_22 = _item_ranged.."/grips/lasgun_rifle_grip_01",
            grip_23 = _item_ranged.."/grips/lasgun_rifle_grip_02",
            grip_24 = _item_ranged.."/grips/lasgun_rifle_grip_03",
            grip_25 = _item_ranged.."/grips/lasgun_rifle_elysian_grip_02",
            grip_26 = _item_ranged.."/grips/lasgun_rifle_elysian_grip_03",
            grip_27 = _item_ranged.."/grips/flamer_rifle_grip_01",
            grip_28 = _item_ranged.."/grips/flamer_rifle_grip_02",
            grip_29 = _item_ranged.."/grips/flamer_rifle_grip_03",
            grip_30 = _item_ranged.."/grips/boltgun_pistol_grip_01",
            grip_31 = _item_ranged.."/grips/autogun_rifle_grip_ak_04",
            grip_32 = _item_ranged.."/grips/autogun_rifle_grip_ak_05",
            grip_33 = _item_ranged.."/grips/lasgun_pistol_grip_04",
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    bayonet_attachments = function()
        return {
            {id = "autogun_bayonet_default",    name = mod:localize("mod_attachment_default")},
            {id = "autogun_bayonet_01",         name = "Bayonet 1"},
            {id = "autogun_bayonet_02",         name = "Bayonet 2"},
            {id = "autogun_bayonet_03",         name = "Bayonet 3"},
        }
    end,
    bayonet_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "bayonet",            "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {},                   "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            autogun_bayonet_default = {model = "",                                   type = "bayonet", parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = tv(r, 1), mesh_move = false},
            autogun_bayonet_01 =      {model = _item_ranged.."/bayonets/bayonet_01", type = "bayonet", parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = tv(r, 2), mesh_move = false},
            autogun_bayonet_02 =      {model = _item_ranged.."/bayonets/bayonet_02", type = "bayonet", parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = tv(r, 3), mesh_move = false},
            autogun_bayonet_03 =      {model = _item_ranged.."/bayonets/bayonet_03", type = "bayonet", parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = tv(r, 4), mesh_move = false},
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
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "sight",              "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
        },                                                       "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            sight_default =   {model = "",                                      type = t, parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1)},
            reflex_sight_01 = {model = _item_ranged.."/sights/reflex_sight_01", type = t, parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2)},
            reflex_sight_02 = {model = _item_ranged.."/sights/reflex_sight_02", type = t, parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3)},
            reflex_sight_03 = {model = _item_ranged.."/sights/reflex_sight_03", type = t, parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4)},
            sight_none =      {model = "",                                      type = t, parent = tv(parent, 5), angle = tv(a, 5), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5)},
        }
    end,
    sight_default = function()
        return {
            {id = "sight_default",  name = mod:localize("mod_attachment_default")}
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
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "sight",              "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
        },                                                       "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            sight_default =                   {model = "",                                                      type = t, parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1)},
            autogun_rifle_ak_sight_01 =       {model = _item_ranged.."/sights/autogun_rifle_ak_sight_01",       type = t, parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2)},
            autogun_rifle_sight_01 =          {model = _item_ranged.."/sights/autogun_rifle_sight_01",          type = t, parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3)},
            autogun_rifle_killshot_sight_01 = {model = _item_ranged.."/sights/autogun_rifle_killshot_sight_01", type = t, parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4)},
            lasgun_rifle_sight_01 =           {model = _item_ranged.."/sights/lasgun_rifle_sight_01",           type = t, parent = tv(parent, 5), angle = tv(a, 5), move = m, remove = r, mesh_move = false, automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5)},
        }
    end,
    stock_attachments = function()
        return {
            {id = "no_stock", name = mod:localize("mod_attachment_no_stock")},
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
            {id = "autogun_rifle_stock_10", name = "Braced Autogun 4"},
            {id = "autogun_rifle_stock_11", name = "Braced Autogun 5"},
            {id = "lasgun_stock_04", name = "Infantry Lasgun 4"},
        }
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "stock",              "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {},                   "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            stock_default =          {model = "",                                                      type = t, parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = r, mesh_move = false},
            no_stock =               {model = "",                                                      type = t, parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = r, mesh_move = false},
            stock_01 =               {model = _item_ranged.."/stocks/stock_01",                        type = t, parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = r, mesh_move = false},
            stock_02 =               {model = _item_ranged.."/stocks/stock_02",                        type = t, parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = r, mesh_move = false},
            stock_03 =               {model = _item_ranged.."/stocks/stock_03",                        type = t, parent = tv(parent, 5), angle = tv(a, 5), move = m, remove = r, mesh_move = false},
            stock_04 =               {model = _item_ranged.."/stocks/stock_04",                        type = t, parent = tv(parent, 6), angle = tv(a, 6), move = m, remove = r, mesh_move = false},
            stock_05 =               {model = _item_ranged.."/stocks/stock_05",                        type = t, parent = tv(parent, 7), angle = tv(a, 7), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_01 = {model = _item_ranged.."/stocks/autogun_rifle_stock_01",          type = t, parent = tv(parent, 8), angle = tv(a, 8), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_02 = {model = _item_ranged.."/stocks/autogun_rifle_stock_02",          type = t, parent = tv(parent, 9), angle = tv(a, 9), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_03 = {model = _item_ranged.."/stocks/autogun_rifle_stock_03",          type = t, parent = tv(parent, 10), angle = tv(a, 10), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_04 = {model = _item_ranged.."/stocks/autogun_rifle_stock_04",          type = t, parent = tv(parent, 11), angle = tv(a, 11), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_05 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_01",       type = t, parent = tv(parent, 12), angle = tv(a, 12), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_06 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_02",       type = t, parent = tv(parent, 13), angle = tv(a, 13), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_07 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_03",       type = t, parent = tv(parent, 14), angle = tv(a, 14), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_08 = {model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_01", type = t, parent = tv(parent, 15), angle = tv(a, 15), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_09 = {model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_02", type = t, parent = tv(parent, 16), angle = tv(a, 16), move = m, remove = r, mesh_move = false},
            lasgun_stock_01 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_01",           type = t, parent = tv(parent, 17), angle = tv(a, 17), move = m, remove = r, mesh_move = false},
            lasgun_stock_02 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_02",           type = t, parent = tv(parent, 18), angle = tv(a, 18), move = m, remove = r, mesh_move = false},
            lasgun_stock_03 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_03",           type = t, parent = tv(parent, 19), angle = tv(a, 19), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_10 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_04",       type = t, parent = tv(parent, 20), angle = tv(a, 20), move = m, remove = r, mesh_move = false},
            autogun_rifle_stock_11 = {model = _item_ranged.."/stocks/autogun_rifle_ak_stock_05",       type = t, parent = tv(parent, 21), angle = tv(a, 21), move = m, remove = r, mesh_move = false},
            lasgun_stock_04 =        {model = _item_ranged.."/stocks/lasgun_rifle_stock_04",           type = t, parent = tv(parent, 22), angle = tv(a, 22), move = m, remove = r, mesh_move = false},
        }
    end,
    ogryn_bayonet_attachments = function()
        return {
            {id = "bayonet_default",    name = mod:localize("mod_attachment_default")},
            {id = "bayonet_01",         name = "Bayonet 1"},
            {id = "bayonet_02",         name = "Bayonet 2"},
            {id = "bayonet_03",         name = "Bayonet 3"},
            {id = "bayonet_04",         name = "Bayonet 4"},
            {id = "bayonet_blade_01",   name = "Blade"},
        }
    end,
    ogryn_bayonet_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "bayonet",            "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {},                   "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            bayonet_default =  {model = "",                                                   [_t] = tv(t, 1), [_p] = tv(parent, 1), [_a] = tv(a, 1), [_m] = tv(m, 1), [_r] = tv(r, 1), [_n] = tv(n, 1), [_ae] = tv(ae, 1), [_mm] = false},
            bayonet_01 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_01", [_t] = tv(t, 2), [_p] = tv(parent, 2), [_a] = tv(a, 2), [_m] = tv(m, 2), [_r] = tv(r, 2), [_n] = tv(n, 2), [_ae] = tv(ae, 2), [_mm] = false},
            bayonet_02 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_02", [_t] = tv(t, 3), [_p] = tv(parent, 3), [_a] = tv(a, 3), [_m] = tv(m, 3), [_r] = tv(r, 3), [_n] = tv(n, 3), [_ae] = tv(ae, 3), [_mm] = false},
            bayonet_03 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_03", [_t] = tv(t, 4), [_p] = tv(parent, 4), [_a] = tv(a, 4), [_m] = tv(m, 4), [_r] = tv(r, 4), [_n] = tv(n, 4), [_ae] = tv(ae, 4), [_mm] = false},
            bayonet_04 =       {model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_04", [_t] = tv(t, 5), [_p] = tv(parent, 5), [_a] = tv(a, 5), [_m] = tv(m, 5), [_r] = tv(r, 5), [_n] = tv(n, 5), [_ae] = tv(ae, 5), [_mm] = false},
            bayonet_blade_01 = {model = _item_melee.."/blades/combat_sword_blade_01",         [_t] = tv(t, 6), [_p] = tv(parent, 6), [_a] = tv(a, 6), [_m] = tv(m, 6), [_r] = tv(r, 6), [_n] = tv(n, 6), [_ae] = tv(ae, 6), [_mm] = false},
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
            -- {id = "bolter_magazine_03",      name = "Boltgun Pistol A"},
        }
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh)
        local _p = "parent"
        local _mm = "mesh_move"
        local a, _a = angle             or 0,                    "angle"
        local m, _m = move              or vector3_box(0, 0, 0), "move"
        local r, _r = remove            or vector3_box(0, 0, 0), "remove"
        local t, _t = type              or "magazine",           "type"
        local n, _n = no_support        or {},                   "no_support"
        local ae, _ae = automatic_equip or {},                   "automatic_equip"
        local h, _h = hide_mesh         or {},                   "hide_mesh"
        return {
            magazine_default =        {model = "",                                                      type = t, parent = tv(parent, 1), angle = tv(a, 1), move = m, remove = r, mesh_move = false},
            magazine_01 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_01",    type = t, parent = tv(parent, 2), angle = tv(a, 2), move = m, remove = r, mesh_move = false},
            magazine_02 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_02",    type = t, parent = tv(parent, 3), angle = tv(a, 3), move = m, remove = r, mesh_move = false},
            magazine_03 =             {model = _item_ranged.."/magazines/autogun_rifle_magazine_03",    type = t, parent = tv(parent, 4), angle = tv(a, 4), move = m, remove = r, mesh_move = false},
            magazine_04 =             {model = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01", type = t, parent = tv(parent, 5), angle = tv(a, 5), move = m, remove = r, mesh_move = false},
            auto_pistol_magazine_01 = {model = _item_ranged.."/magazines/autogun_pistol_magazine_01",   type = t, parent = tv(parent, 6), angle = tv(a, 6), move = m, remove = r, mesh_move = false},
            bolter_magazine_01 =      {model = _item_ranged.."/magazines/boltgun_rifle_magazine_01",    type = t, parent = tv(parent, 7), angle = tv(a, 7), move = m, remove = r},
            bolter_magazine_02 =      {model = _item_ranged.."/magazines/boltgun_rifle_magazine_02",    type = t, parent = tv(parent, 8), angle = tv(a, 8), move = m, remove = r},
            -- bolter_magazine_03 =      {model = _item_ranged.."/magazines/boltgun_pistol_magazine_01",    type = t, parent = tv(parent, 9), angle = a, move = m, remove = r},
        }
    end,
}