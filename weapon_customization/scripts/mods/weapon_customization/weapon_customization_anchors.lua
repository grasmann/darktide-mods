local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _ogryn_heavystubber_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_heavystubber_p1_m1")
local _ogryn_rippergun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_rippergun_p1_m1")
local _ogryn_thumper_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_thumper_p1_m1")
local _ogryn_gauntlet_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_gauntlet_p1_m1")
local _ogryn_club_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_club_p1_m1")
local _ogryn_combatblade_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_combatblade_p1_m1")
local _ogryn_powermaul_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_powermaul_p1_m1")
local _ogryn_powermaul_slabshield_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_powermaul_slabshield_p1_m1")
local _ogryn_club_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_club_p2_m1")
local _lasgun_common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_common")
local _lasgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p1_m1")
local _lasgun_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p2_m1")
local _lasgun_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p3_m1")
local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autogun_p1_m1")
local _autopistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autopistol_p1_m1")
local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p1_m1")
local _bolter_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/bolter_p1_m1")
local _stubrevolver_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/stubrevolver_p1_m1")
local _plasmagun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/plasmagun_p1_m1")
local _laspistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/laspistol_p1_m1")
local _flamer_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/flamer_p1_m1")
local _forcestaff_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/forcestaff_p1_m1")

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local _barrel_sound = UISoundEvents.talents_equip_talent
local _receiver_sound = UISoundEvents.weapons_equip_weapon
local _magazine_sound = UISoundEvents.weapons_trinket_select
local _grip_sound = UISoundEvents.smart_tag_hud_default
local _knife_sound = UISoundEvents.end_screen_summary_plasteel_zero

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
--#endregion

--#region Table functions
    --#region Melee
        --#region Shovel
            local _shovel_functions = {
                shovel_head_attachments = function()
                    return {
                        {id = "shovel_head_default", name = "Default", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_head_01",      name = "Head 1",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_head_02",      name = "Head 2",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_head_03",      name = "Head 3",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_head_04",      name = "Head 4",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_head_05",      name = "Head 5",  sounds = {UISoundEvents.weapons_swap}},
                    }
                end,
                shovel_head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
                    local a = angle or 0
                    local m = move or vector3_box(0, 0, 0)
                    local r = remove or vector3_box(0, 0, 0)
                    local t = type or "head"
                    local n = no_support or {}
                    local ae = automatic_equip or {}
                    local h = hide_mesh or {}
                    return {
                        shovel_head_default =   {model = "",                                        type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
                        shovel_head_01 =        {model = _item_melee.."/heads/shovel_head_01",      type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
                        shovel_head_02 =        {model = _item_melee.."/heads/shovel_head_02",      type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
                        shovel_head_03 =        {model = _item_melee.."/heads/shovel_head_03",      type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
                        shovel_head_04 =        {model = _item_melee.."/heads/shovel_head_04",      type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
                        shovel_head_05 =        {model = _item_melee.."/heads/shovel_head_05",      type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
                    }
                end,
                shovel_grip_attachments = function()
                    return {
                        {id = "shovel_grip_default", name = "Default", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_grip_01",      name = "Grip 1",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_grip_02",      name = "Grip 2",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_grip_03",      name = "Grip 3",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_grip_04",      name = "Grip 4",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_grip_05",      name = "Grip 5",  sounds = {UISoundEvents.weapons_swap}},
                    }
                end,
                shovel_grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
                    local a = angle or 0
                    local m = move or vector3_box(0, 0, 0)
                    local r = remove or vector3_box(0, 0, 0)
                    local t = type or "grip"
                    local n = no_support or {}
                    local ae = automatic_equip or {}
                    local h = hide_mesh or {}
                    return {
                        shovel_grip_default =   {model = "",                                   type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
                        shovel_grip_01 =        {model = _item_melee.."/grips/shovel_grip_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
                        shovel_grip_02 =        {model = _item_melee.."/grips/shovel_grip_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
                        shovel_grip_03 =        {model = _item_melee.."/grips/shovel_grip_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
                        shovel_grip_04 =        {model = _item_melee.."/grips/shovel_grip_04", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
                        shovel_grip_05 =        {model = _item_melee.."/grips/shovel_grip_05", type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
                    }
                end,
                shovel_pommel_attachments = function()
                    return {
                        {id = "shovel_pommel_default", name = "Default",  sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_01",      name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_02",      name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_03",      name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_04",      name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_05",      name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                        {id = "shovel_pommel_06",      name = "Krieg",    sounds = {UISoundEvents.weapons_swap}},
                    }
                end,
                shovel_pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
                    local a = angle or 0
                    local m = move or vector3_box(0, 0, 0)
                    local r = remove or vector3_box(0, 0, 0)
                    local t = type or "pommel"
                    local n = no_support or {}
                    local ae = automatic_equip or {}
                    local h = hide_mesh or {}
                    return {
                        shovel_pommel_default = {model = "",                                        type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
                        shovel_pommel_01 =      {model = _item_melee.."/pommels/shovel_pommel_01",  type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
                        shovel_pommel_02 =      {model = _item_melee.."/pommels/shovel_pommel_02",  type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
                        shovel_pommel_03 =      {model = _item_melee.."/pommels/shovel_pommel_03",  type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
                        shovel_pommel_04 =      {model = _item_melee.."/pommels/shovel_pommel_04",  type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
                        shovel_pommel_05 =      {model = _item_melee.."/pommels/shovel_pommel_05",  type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
                        shovel_pommel_06 =      {model = _item_melee.."/full/krieg_shovel_full_01", type = t, parent = tv(parent, 7), angle = a, move = m, remove = r, automatic_equip = tv(ae, 7), no_support = tv(n, 7), special_resolve = special_resolve},
                    }
                end
            }
        --#endregion
        local _axe_grip_attachments = function()
            return {
                {id = "axe_grip_01", name = "Combat Axe 1", sounds = {_grip_sound}},
                {id = "axe_grip_02", name = "Combat Axe 2", sounds = {_grip_sound}},
                {id = "axe_grip_03", name = "Combat Axe 3", sounds = {_grip_sound}},
                {id = "axe_grip_04", name = "Combat Axe 4", sounds = {_grip_sound}},
                {id = "axe_grip_05", name = "Combat Axe 5", sounds = {_grip_sound}},
                {id = "axe_grip_06", name = "Combat Axe 6", sounds = {_grip_sound}},
                {id = "hatchet_grip_01", name = "Tactical Axe 1", sounds = {_grip_sound}},
                {id = "hatchet_grip_02", name = "Tactical Axe 2", sounds = {_grip_sound}},
                {id = "hatchet_grip_03", name = "Tactical Axe 3", sounds = {_grip_sound}},
                {id = "hatchet_grip_04", name = "Tactical Axe 4", sounds = {_grip_sound}},
                {id = "hatchet_grip_05", name = "Tactical Axe 5", sounds = {_grip_sound}},
                {id = "hatchet_grip_06", name = "Tactical Axe 6", sounds = {_grip_sound}},
            }
        end
        local _axe_grip_models = function()
            return {
                grip_default =    {model = "",                                    type = "grip"},
                axe_grip_01 =     {model = _item_melee.."/grips/axe_grip_01",     type = "grip"},
                axe_grip_02 =     {model = _item_melee.."/grips/axe_grip_02",     type = "grip"},
                axe_grip_03 =     {model = _item_melee.."/grips/axe_grip_03",     type = "grip"},
                axe_grip_04 =     {model = _item_melee.."/grips/axe_grip_04",     type = "grip"},
                axe_grip_05 =     {model = _item_melee.."/grips/axe_grip_05",     type = "grip"},
                axe_grip_06 =     {model = _item_melee.."/grips/axe_grip_06",     type = "grip"},
                hatchet_grip_01 = {model = _item_melee.."/grips/hatchet_grip_01", type = "grip"},
                hatchet_grip_02 = {model = _item_melee.."/grips/hatchet_grip_02", type = "grip"},
                hatchet_grip_03 = {model = _item_melee.."/grips/hatchet_grip_03", type = "grip"},
                hatchet_grip_04 = {model = _item_melee.."/grips/hatchet_grip_04", type = "grip"},
                hatchet_grip_05 = {model = _item_melee.."/grips/hatchet_grip_05", type = "grip"},
                hatchet_grip_06 = {model = _item_melee.."/grips/hatchet_grip_06", type = "grip"},
            }
        end
        local _axe_head_attachments = function()
            return {
                {id = "axe_head_01", name = "Combat Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_head_02", name = "Combat Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_head_03", name = "Combat Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_head_04", name = "Combat Axe 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_head_05", name = "Combat Axe 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_head_01", name = "Tactical Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_head_02", name = "Tactical Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_head_03", name = "Tactical Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_head_04", name = "Tactical Axe 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_head_05", name = "Tactical Axe 5", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _axe_head_models = function()
            return {
                head_default =    {model = "",                                    type = "head"},
                axe_head_01 =     {model = _item_melee.."/heads/axe_head_01",     type = "head"},
                axe_head_02 =     {model = _item_melee.."/heads/axe_head_02",     type = "head"},
                axe_head_03 =     {model = _item_melee.."/heads/axe_head_03",     type = "head"},
                axe_head_04 =     {model = _item_melee.."/heads/axe_head_04",     type = "head"},
                axe_head_05 =     {model = _item_melee.."/heads/axe_head_05",     type = "head"},
                hatchet_head_01 = {model = _item_melee.."/heads/hatchet_head_01", type = "head"},
                hatchet_head_02 = {model = _item_melee.."/heads/hatchet_head_02", type = "head"},
                hatchet_head_03 = {model = _item_melee.."/heads/hatchet_head_03", type = "head"},
                hatchet_head_04 = {model = _item_melee.."/heads/hatchet_head_04", type = "head"},
                hatchet_head_05 = {model = _item_melee.."/heads/hatchet_head_05", type = "head"},
            }
        end
        local _ogryn_pommel_attachments = function()
            return {
                {id = "shovel_pommel_01", name = "Shovel 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "shovel_pommel_02", name = "Shovel 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "shovel_pommel_03", name = "Shovel 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "shovel_pommel_04", name = "Shovel 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "shovel_pommel_05", name = "Shovel 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "power_maul_pommel_01", name = "Power Maul 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "power_maul_pommel_02", name = "Power Maul 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "power_maul_pommel_03", name = "Power Maul 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "power_maul_pommel_04", name = "Power Maul 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "power_maul_pommel_05", name = "Power Maul 5", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _ogryn_pommel_models = function()
            return {
                shovel_pommel_01 =     {model = _item_melee.."/pommels/shovel_ogryn_pommel_01", type = "pommel"},
                shovel_pommel_02 =     {model = _item_melee.."/pommels/shovel_ogryn_pommel_02", type = "pommel"},
                shovel_pommel_03 =     {model = _item_melee.."/pommels/shovel_ogryn_pommel_03", type = "pommel"},
                shovel_pommel_04 =     {model = _item_melee.."/pommels/shovel_ogryn_pommel_04", type = "pommel"},
                shovel_pommel_05 =     {model = _item_melee.."/pommels/shovel_ogryn_pommel_05", type = "pommel"},
                power_maul_pommel_01 = {model = _item_melee.."/pommels/power_maul_pommel_01",   type = "pommel"},
                power_maul_pommel_02 = {model = _item_melee.."/pommels/power_maul_pommel_02",   type = "pommel"},
                power_maul_pommel_03 = {model = _item_melee.."/pommels/power_maul_pommel_03",   type = "pommel"},
                power_maul_pommel_04 = {model = _item_melee.."/pommels/power_maul_pommel_04",   type = "pommel"},
                power_maul_pommel_05 = {model = _item_melee.."/pommels/power_maul_pommel_05",   type = "pommel"},
            }
        end
        local _pommel_attachments = function()
            return {
                {id = "axe_pommel_01", name = "Combat Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_pommel_02", name = "Combat Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_pommel_03", name = "Combat Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_pommel_04", name = "Combat Axe 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_pommel_05", name = "Combat Axe 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_pommel_01", name = "Tactical Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_pommel_02", name = "Tactical Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_pommel_03", name = "Tactical Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_pommel_04", name = "Tactical Axe 4", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _pommel_models = function()
            return {
                pommel_default =    {model = "",                                        type = "pommel"},
                axe_pommel_01 =     {model = _item_melee.."/pommels/axe_pommel_01",     type = "pommel"},
                axe_pommel_02 =     {model = _item_melee.."/pommels/axe_pommel_02",     type = "pommel"},
                axe_pommel_03 =     {model = _item_melee.."/pommels/axe_pommel_03",     type = "pommel"},
                axe_pommel_04 =     {model = _item_melee.."/pommels/axe_pommel_04",     type = "pommel"},
                axe_pommel_05 =     {model = _item_melee.."/pommels/axe_pommel_05",     type = "pommel"},
                hatchet_pommel_01 = {model = _item_melee.."/pommels/hatchet_pommel_01", type = "pommel"},
                hatchet_pommel_02 = {model = _item_melee.."/pommels/hatchet_pommel_02", type = "pommel"},
                hatchet_pommel_03 = {model = _item_melee.."/pommels/hatchet_pommel_03", type = "pommel"},
                hatchet_pommel_04 = {model = _item_melee.."/pommels/hatchet_pommel_04", type = "pommel"},
            }
        end
    --#endregion
--#endregion

--#region Anchors
    mod.anchors = {
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.anchors,
            ogryn_rippergun_p1_m1 = _ogryn_rippergun_p1_m1.anchors,
            ogryn_thumper_p1_m1 = _ogryn_thumper_p1_m1.anchors,
            ogryn_gauntlet_p1_m1 = _ogryn_gauntlet_p1_m1.anchors,
        --#endregion
        --#region Ogryn Melee
            ogryn_club_p1_m1 = _ogryn_club_p1_m1.anchors,
            ogryn_combatblade_p1_m1 = _ogryn_combatblade_p1_m1.anchors,
            ogryn_powermaul_p1_m1 = _ogryn_powermaul_p1_m1.anchors,
            ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.anchors,
            ogryn_club_p2_m1 = _ogryn_club_p2_m1.anchors,
        --#endregion
        --#region Guns
            autopistol_p1_m1 = _autopistol_p1_m1.anchors,
            shotgun_p1_m1 = _shotgun_p1_m1.anchors,
            bolter_p1_m1 = _bolter_p1_m1.anchors,
            stubrevolver_p1_m1 = _stubrevolver_p1_m1.anchors,
            plasmagun_p1_m1 = _plasmagun_p1_m1.anchors,
            laspistol_p1_m1 = _laspistol_p1_m1.anchors,
            autogun_p1_m1 = _autogun_p1_m1.anchors,
            lasgun_p1_m1 = _lasgun_p1_m1.anchors,
            lasgun_p2_m1 = _lasgun_p2_m1.anchors,
            lasgun_p3_m1 = _lasgun_p3_m1.anchors,
            flamer_p1_m1 = _flamer_p1_m1.anchors,
        --#endregion
        --#region Melee
            combataxe_p1_m1 = {
            },
            combatknife_p1_m1 = {  
            },
        --#endregion
    }
    --#region Copies
        --#region Ogryn Guns
            mod.anchors.ogryn_heavystubber_p1_m2 = mod.anchors.ogryn_heavystubber_p1_m1
            mod.anchors.ogryn_heavystubber_p1_m3 = mod.anchors.ogryn_heavystubber_p1_m1
            mod.anchors.ogryn_rippergun_p1_m2 = mod.anchors.ogryn_rippergun_p1_m1
            mod.anchors.ogryn_rippergun_p1_m3 = mod.anchors.ogryn_rippergun_p1_m1
            mod.anchors.ogryn_thumper_p1_m2 = mod.anchors.ogryn_thumper_p1_m1
        --#endregion
        --#region Ogryn Melee
            mod.anchors.ogryn_combatblade_p1_m2 = mod.anchors.ogryn_combatblade_p1_m1
            mod.anchors.ogryn_combatblade_p1_m3 = mod.anchors.ogryn_combatblade_p1_m1
            mod.anchors.ogryn_club_p2_m2 = mod.anchors.ogryn_club_p2_m1
            mod.anchors.ogryn_club_p2_m3 = mod.anchors.ogryn_club_p2_m1
        --#endregion
        --#region Guns
            mod.anchors.shotgun_p1_m2 = mod.anchors.shotgun_p1_m1
            mod.anchors.shotgun_p1_m3 = mod.anchors.shotgun_p1_m1
            mod.anchors.bolter_p1_m2 = mod.anchors.bolter_p1_m1
            mod.anchors.bolter_p1_m3 = mod.anchors.bolter_p1_m1
            mod.anchors.autogun_p1_m2 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p1_m3 = mod.anchors.autogun_p1_m1
            -- mod.anchors.autogun_p2_m2 = mod.anchors.autogun_p2_m1
            -- mod.anchors.autogun_p2_m3 = mod.anchors.autogun_p2_m1
            -- mod.anchors.autogun_p3_m2 = mod.anchors.autogun_p3_m1
            -- mod.anchors.autogun_p3_m3 = mod.anchors.autogun_p3_m1
            mod.anchors.autogun_p2_m1 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p2_m2 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p2_m3 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p3_m1 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p3_m2 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p3_m3 = mod.anchors.autogun_p1_m1
            mod.anchors.lasgun_p1_m2 = mod.anchors.lasgun_p1_m1
            mod.anchors.lasgun_p1_m3 = mod.anchors.lasgun_p1_m1
            mod.anchors.lasgun_p2_m2 = mod.anchors.lasgun_p2_m1
            mod.anchors.lasgun_p2_m3 = mod.anchors.lasgun_p2_m1
            mod.anchors.lasgun_p3_m2 = mod.anchors.lasgun_p3_m1
            mod.anchors.lasgun_p3_m3 = mod.anchors.lasgun_p3_m1
        --#endregion
        --#region Melee
            mod.anchors.combataxe_p1_m2 = mod.anchors.combataxe_p1_m1
            mod.anchors.combataxe_p1_m3 = mod.anchors.combataxe_p1_m1
        --#endregion
    --#endregion
--#endregion

--#region Attachments
    mod.attachment = {
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.attachments,
            ogryn_rippergun_p1_m1 = _ogryn_rippergun_p1_m1.attachments,
            ogryn_thumper_p1_m1 = _ogryn_thumper_p1_m1.attachments,
            ogryn_gauntlet_p1_m1 = _ogryn_gauntlet_p1_m1.attachments,
        --#endregion
        --#region Ogryn Melee
            ogryn_club_p1_m1 = _ogryn_club_p1_m1.attachments,
            ogryn_combatblade_p1_m1 = _ogryn_combatblade_p1_m1.attachments,
            ogryn_powermaul_p1_m1 = _ogryn_powermaul_p1_m1.attachments,
            ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.attachments,
            ogryn_club_p2_m1 = _ogryn_club_p2_m1.attachments,
        --#endregion
        --#region Guns
            autopistol_p1_m1 = _autopistol_p1_m1.attachments,
            shotgun_p1_m1 = _shotgun_p1_m1.attachments,
            bolter_p1_m1 = _bolter_p1_m1.attachments,
            stubrevolver_p1_m1 = _stubrevolver_p1_m1.attachments,
            plasmagun_p1_m1 = _plasmagun_p1_m1.attachments,
            laspistol_p1_m1 = _laspistol_p1_m1.attachments,
            autogun_p1_m1 = _autogun_p1_m1.attachments,
            lasgun_p1_m1 = _lasgun_p1_m1.attachments,
            lasgun_p2_m1 = _lasgun_p2_m1.attachments,
            lasgun_p3_m1 = _lasgun_p3_m1.attachments,
            flamer_p1_m1 = _flamer_p1_m1.attachments,
            forcestaff_p1_m1 = _forcestaff_p1_m1.attachments,
        --#endregion
        --#region Melee
            combataxe_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = table.icombine(
                    {{id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _axe_grip_attachments()
                ),
                head = table.icombine(
                    {{id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _axe_head_attachments()
                ),
                pommel = table.icombine(
                    {{id = "pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _pommel_attachments()
                ),
            },
            combataxe_p2_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = table.icombine(
                    {{id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _axe_grip_attachments()
                ),
                head = table.icombine(
                    {{id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _axe_head_attachments()
                ),
                pommel = table.icombine(
                    {{id = "pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _pommel_attachments()
                ),
            },
            combatknife_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "knife_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "knife_grip_01", name = "Combat Knife 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_grip_02", name = "Combat Knife 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_grip_03", name = "Combat Knife 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_grip_04", name = "Combat Knife 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_grip_05", name = "Combat Knife 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_grip_06", name = "Combat Knife 6", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "knife_body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "knife_body_01", name = "Combat Knife 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_body_02", name = "Combat Knife 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_body_03", name = "Combat Knife 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_body_04", name = "Combat Knife 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_body_05", name = "Combat Knife 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "knife_body_06", name = "Combat Knife 6", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            powersword_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "power_sword_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "power_sword_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_grip_06", name = "Grip 6", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "power_sword_pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "power_sword_pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                },
                blade = {
                    {id = "power_sword_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "power_sword_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "power_sword_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            chainaxe_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "chain_axe_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_axe_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                shaft = {
                    {id = "chain_axe_shaft_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_axe_shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                blade = {
                    {id = "chain_axe_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_axe_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_axe_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                },
                teeth = {
                    {id = "chain_axe_teeth_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_axe_teeth_01", name = "Chain 1", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            chainsword_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "chain_sword_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_sword_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "chain_sword_body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_sword_body_01", name = "Body 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_body_02", name = "Body 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "chain_sword_body_03", name = "Body 3", sounds = {UISoundEvents.weapons_swap}},
                    -- {id = "chain_sword_body_04", name = "Body 4", sounds = {UISoundEvents.weapons_swap}}, --buggy
                    -- {id = "chain_sword_body_05", name = "Body 5", sounds = {UISoundEvents.weapons_swap}}, --buggy
                    {id = "chain_sword_body_06", name = "Body 6", sounds = {UISoundEvents.weapons_swap}},
                },
                chain = {
                    {id = "chain_sword_chain_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "chain_sword_chain_01", name = "Chain 1", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            combataxe_p3_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                head = _shovel_functions.shovel_head_attachments(),
                pommel = _shovel_functions.shovel_pommel_attachments(),
                grip = _shovel_functions.shovel_grip_attachments(),
            },
            combatsword_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "combat_sword_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "combat_sword_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "combat_sword_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "combat_sword_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "combat_sword_blade_06", name = "Blade 6", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            thunderhammer_2h_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                shaft = {
                    {id = "thunder_hammer_shaft_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "thunder_hammer_shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "thunder_hammer_pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "thunder_hammer_pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                },
                connector = {
                    {id = "thunder_hammer_connector_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "thunder_hammer_connector_01", name = "Connector 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_connector_02", name = "Connector 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_connector_03", name = "Connector 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_connector_04", name = "Connector 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_connector_05", name = "Connector 5", sounds = {UISoundEvents.weapons_swap}},
                },
                head = {
                    {id = "thunder_hammer_head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "thunder_hammer_head_01", name = "Head 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_head_02", name = "Head 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_head_03", name = "Head 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_head_04", name = "Head 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "thunder_hammer_head_05", name = "Head 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            powermaul_2h_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                shaft = {
                    {id = "2h_power_maul_shaft_default", name = "Default", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "2h_power_maul_pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_power_maul_pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                },
                connector = {
                    {id = "2h_power_maul_connector_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_power_maul_connector_01", name = "Connector 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_connector_02", name = "Connector 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_connector_03", name = "Connector 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_connector_04", name = "Connector 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_connector_05", name = "Connector 5", sounds = {UISoundEvents.weapons_swap}},
                },
                head = {
                    {id = "2h_power_maul_head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_power_maul_head_01", name = "Head 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_head_02", name = "Head 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_head_03", name = "Head 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_head_04", name = "Head 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_power_maul_head_05", name = "Head 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            chainsword_2h_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "2h_chain_sword_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_chain_sword_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_chain_sword_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_chain_sword_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "2h_chain_sword_body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_chain_sword_body_01", name = "Body 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_chain_sword_body_02", name = "Body 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "2h_chain_sword_body_03", name = "Body 3", sounds = {UISoundEvents.weapons_swap}},
                },
                chain = {
                    {id = "2h_chain_sword_chain_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "2h_chain_sword_chain_01", name = "Chain 1", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            combatsword_p2_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "falchion_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "falchion_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "falchion_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "falchion_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "falchion_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            forcesword_p1_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "force_sword_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "force_sword_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "force_sword_pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "force_sword_pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                },
                hilt = {
                    {id = "force_sword_hilt_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "force_sword_hilt_01", name = "Hilt 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_hilt_02", name = "Hilt 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_hilt_03", name = "Hilt 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_hilt_04", name = "Hilt 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_hilt_05", name = "Hilt 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_hilt_06", name = "Hilt 6", sounds = {UISoundEvents.weapons_swap}},
                },
                blade = {
                    {id = "force_sword_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "force_sword_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "force_sword_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            combatsword_p3_m1 = {
                trinket_hook = _common_functions.trinket_hook_attachments(),
                emblem_right = _common_functions.emblem_right_attachments(),
                emblem_left = _common_functions.emblem_left_attachments(),
                grip = {
                    {id = "sabre_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "sabre_grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "sabre_blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "sabre_blade_01", name = "Blade 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_blade_02", name = "Blade 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_blade_03", name = "Blade 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_blade_04", name = "Blade 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sabre_blade_05", name = "Blade 5", sounds = {UISoundEvents.weapons_swap}},
                },
            },
        --#endregion
    }

    --#region Copies
        --#region Ogryn Guns
            mod.attachment.ogryn_heavystubber_p1_m2 = mod.attachment.ogryn_heavystubber_p1_m1
            mod.attachment.ogryn_heavystubber_p1_m3 = mod.attachment.ogryn_heavystubber_p1_m1
            mod.attachment.ogryn_rippergun_p1_m2 = mod.attachment.ogryn_rippergun_p1_m1
            mod.attachment.ogryn_rippergun_p1_m3 = mod.attachment.ogryn_rippergun_p1_m1
            mod.attachment.ogryn_thumper_p1_m2 = mod.attachment.ogryn_thumper_p1_m1
        --#endregion
        --#region Ogryn Melee
            mod.attachment.ogryn_combatblade_p1_m2 = mod.attachment.ogryn_combatblade_p1_m1
            mod.attachment.ogryn_combatblade_p1_m3 = mod.attachment.ogryn_combatblade_p1_m1
            -- mod.attachment.ogryn_powermaul_slabshield_p1_m1 = mod.attachment.ogryn_powermaul_p1_m1
            mod.attachment.ogryn_club_p2_m2 = mod.attachment.ogryn_club_p2_m1
            mod.attachment.ogryn_club_p2_m3 = mod.attachment.ogryn_club_p2_m1
        --#endregion
        --#region Guns
            mod.attachment.shotgun_p1_m2 = mod.attachment.shotgun_p1_m1
            mod.attachment.shotgun_p1_m3 = mod.attachment.shotgun_p1_m1
            mod.attachment.bolter_p1_m2 = mod.attachment.bolter_p1_m1
            mod.attachment.bolter_p1_m3 = mod.attachment.bolter_p1_m1
            mod.attachment.stubrevolver_p1_m2 = mod.attachment.stubrevolver_p1_m1
            mod.attachment.stubrevolver_p1_m3 = mod.attachment.stubrevolver_p1_m1
            mod.attachment.autogun_p1_m2 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p1_m3 = mod.attachment.autogun_p1_m1
            -- mod.attachment.autogun_p2_m2 = mod.attachment.autogun_p2_m1
            -- mod.attachment.autogun_p2_m3 = mod.attachment.autogun_p2_m1
            -- mod.attachment.autogun_p3_m2 = mod.attachment.autogun_p3_m1
            -- mod.attachment.autogun_p3_m3 = mod.attachment.autogun_p3_m1
            mod.attachment.autogun_p2_m1 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p2_m2 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p2_m3 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p3_m1 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p3_m2 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p3_m3 = mod.attachment.autogun_p1_m1
            mod.attachment.lasgun_p1_m2 = mod.attachment.lasgun_p1_m1
            mod.attachment.lasgun_p1_m3 = mod.attachment.lasgun_p1_m1
            mod.attachment.lasgun_p2_m2 = mod.attachment.lasgun_p2_m1
            mod.attachment.lasgun_p2_m3 = mod.attachment.lasgun_p2_m1
            mod.attachment.lasgun_p3_m2 = mod.attachment.lasgun_p3_m1
            mod.attachment.lasgun_p3_m3 = mod.attachment.lasgun_p3_m1
            mod.attachment.forcestaff_p2_m1 = mod.attachment.forcestaff_p1_m1
            mod.attachment.forcestaff_p3_m1 = mod.attachment.forcestaff_p1_m1
            mod.attachment.forcestaff_p4_m1 = mod.attachment.forcestaff_p1_m1
        --#endregion
        --#region Melee
            mod.attachment.combataxe_p1_m2 = mod.attachment.combataxe_p1_m1
            mod.attachment.combataxe_p1_m3 = mod.attachment.combataxe_p1_m1
            mod.attachment.combataxe_p2_m2 = mod.attachment.combataxe_p2_m1
            mod.attachment.combataxe_p2_m3 = mod.attachment.combataxe_p2_m1
            mod.attachment.powersword_p1_m2 = mod.attachment.powersword_p1_m1
            mod.attachment.combatsword_p1_m2 = mod.attachment.combatsword_p1_m1
            mod.attachment.combatsword_p1_m3 = mod.attachment.combatsword_p1_m1
            mod.attachment.thunderhammer_2h_p1_m2 = mod.attachment.thunderhammer_2h_p1_m1
            mod.attachment.combatsword_p2_m2 = mod.attachment.combatsword_p2_m1
            mod.attachment.combatsword_p2_m3 = mod.attachment.combatsword_p2_m1
            mod.attachment.forcesword_p1_m2 = mod.attachment.forcesword_p1_m1
            mod.attachment.forcesword_p1_m3 = mod.attachment.forcesword_p1_m1
            mod.attachment.combatsword_p3_m2 = mod.attachment.combatsword_p3_m1
            mod.attachment.combatsword_p3_m3 = mod.attachment.combatsword_p3_m1
        --#endregion
    --#endregion
--#endregion

--#region Data
    mod.special_types = {
        "special_bullet",
        "melee",
        "knife",
        "melee_hand",
    }
    mod.add_custom_attachments = {
        flashlight = "flashlights",
        laser_pointer = "laser_pointers",
        bayonet = "bayonets",
        stock = "stocks",
        stock_2 = "stocks",
        stock_3 = "shotgun_stocks",
        rail = "rails",
        emblem_left = "emblems_left",
        emblem_right = "emblems_right",
        sight_2 = "reflex_sights",
        help_sight = "help_sights",
        muzzle = "muzzles",
        trinket_hook = "trinket_hooks",
        slot_trinket_1 = "slot_trinket_1",
        slot_trinket_2 = "slot_trinket_2",
    }
    mod.slot_trinket_1 = {
        "slot_trinket_1",
    }
    mod.slot_trinket_2 = {
        "slot_trinket_2",
    }
    mod.special_actions = {
        "weapon_extra_pressed",
    }
    mod.trinket_hooks = {
        "trinket_hook_default",
        "trinket_hook_empty",
        "trinket_hook_01",
        "trinket_hook_01_v",
        "trinket_hook_02",
        "trinket_hook_02_45",
        "trinket_hook_02_90",
        "trinket_hook_03",
        "trinket_hook_03_v",
        "trinket_hook_04_steel",
        "trinket_hook_04_steel_v",
        "trinket_hook_04_coated",
        "trinket_hook_04_coated_v",
        "trinket_hook_04_carbon",
        "trinket_hook_04_carbon_v",
        "trinket_hook_04_gold",
        "trinket_hook_04_gold_v",
        "trinket_hook_05_steel",
        "trinket_hook_05_steel_v",
        "trinket_hook_05_coated",
        "trinket_hook_05_coated_v",
        "trinket_hook_05_carbon",
        "trinket_hook_05_carbon_v",
        "trinket_hook_05_gold",
        "trinket_hook_05_gold_v",
    }
    mod.text_overwrite = {
        plasmagun_p1_m1 = {
            loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
        },
        laspistol_p1_m1 = {
            loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
        },
    }
    mod.help_sights = {
        -- "sight_default",
        "bolter_sight_01",
    }
    mod.automatic_slots = {
        "rail",
        "help_sight",
    }
    mod.reflex_sights = {
        "reflex_sight_01",
        "reflex_sight_02",
        "reflex_sight_03",
        -- "scope",
    }
    mod.sights = {
        "lasgun_rifle_elysian_sight_01",
        "lasgun_rifle_elysian_sight_02",
        "lasgun_rifle_elysian_sight_03",
        "autogun_rifle_ak_sight_01",
        "autogun_rifle_sight_01",
        "autogun_rifle_killshot_sight_01",
        "lasgun_rifle_sight_01",
        "sight_01",
    }
    mod.all_sights = table.combine(
        mod.reflex_sights,
        mod.sights
    )
    mod.rails = {
        "rail_default",
        "rail_01"
    }
    mod.muzzles = {
        "muzzle_01",
        "muzzle_02",
        "muzzle_03",
        "muzzle_04",
        "muzzle_05",
        "barrel_01",
        "barrel_02",
        "barrel_03",
        "barrel_04",
        "barrel_05",
        "barrel_06",
    }
    mod.emblems_right = {
        "emblem_right_01",
        "emblem_right_02",
        "emblem_right_03",
        "emblem_right_04",
        "emblem_right_05",
        "emblem_right_06",
        "emblem_right_07",
        "emblem_right_08",
        "emblem_right_09",
        "emblem_right_10",
        "emblem_right_11",
        "emblem_right_12",
        "emblem_right_13",
        "emblem_right_14",
        "emblem_right_15",
        "emblem_right_16",
        "emblem_right_17",
        "emblem_right_18",
        "emblem_right_19",
        "emblem_right_20",
        "emblem_right_21",
    }
    mod.emblems_left = {
        "emblem_left_01",
        "emblem_left_02",
        "emblem_left_03",
        "emblem_left_04",
        "emblem_left_05",
        "emblem_left_06",
        "emblem_left_07",
        "emblem_left_08",
        "emblem_left_09",
        "emblem_left_10",
        "emblem_left_11",
        "emblem_left_12",
    }
    mod.flashlights = {
        "flashlight_01",
        "flashlight_02",
        "flashlight_03",
        "flashlight_04",
        "laser_pointer",
    }
    mod.laser_pointers = {
        "flashlight_04",
    }
    mod.bayonets = {
        "bayonet_blade_01",
        "autogun_bayonet_01",
        "autogun_bayonet_02",
        "autogun_bayonet_03",
        "bayonet_01",
        "bayonet_02",
        "bayonet_03",
    }
    mod.stocks = {
        "autogun_rifle_stock_01",
        "autogun_rifle_stock_02",
        "autogun_rifle_stock_03",
        "autogun_rifle_stock_04",
        "autogun_rifle_stock_05",
        "autogun_rifle_stock_06",
        "autogun_rifle_stock_07",
        "autogun_rifle_stock_08",
        "autogun_rifle_stock_09",
        "stock_01",
        "stock_02",
        "stock_03",
        "stock_04",
        "stock_05",
        "lasgun_stock_01",
        "lasgun_stock_02",
        "lasgun_stock_03",
    }
    mod.shotgun_stocks = {
        "shotgun_rifle_stock_01",
        "shotgun_rifle_stock_02",
        "shotgun_rifle_stock_03",
        "shotgun_rifle_stock_04",
    }
    mod.attachment_units = {
        ["#ID[c54f4d16d170cfdb]"] = "flashlight_01",
        ["#ID[28ae77de0a24aba6]"] = "flashlight_02",
        ["#ID[93567d1eb8abad0b]"] = "flashlight_03",
        ["#ID[1db94ec130a99e51]"] = "flashlight_04",
        ["#ID[9ed2469305ba9eb7]"] = "bayonet_blade_01",
        ["#ID[fb7d93784a24faa0]"] = "bayonet_01",
        ["#ID[a1a6d59dcc2d6f56]"] = "bayonet_02",
        ["#ID[c42336380c6bc902]"] = "bayonet_03",
        ["#ID[3a32b0205efe4d98]"] = "autogun_rifle_stock_01",
        ["#ID[93d6f1e2cc3f6623]"] = "autogun_rifle_stock_02",
        ["#ID[dd28bd8305193b80]"] = "autogun_rifle_stock_03",
        ["#ID[7467bc5f53a97942]"] = "autogun_rifle_stock_04",
        ["#ID[6e29c4a9efbd1449]"] = "autogun_bayonet_01",
        ["#ID[81347ad48c2a24e1]"] = "autogun_bayonet_02",
        ["#ID[282093393ef1b500]"] = "autogun_bayonet_03",
        ["#ID[900f45d6ed020f0c]"] = "stock_01",
        ["#ID[67654e3011a5e407]"] = "stock_02",
        ["#ID[55a01ebb60937e94]"] = "stock_03",
        ["#ID[d607b405027432d9]"] = "stock_04",
        ["#ID[891692deb6c77ef1]"] = "stock_05",
        -- ["#ID[bc25db1df0670d2a]"] = "bulwark_shield_01",
    }
    mod.attachment_slots = {
        "flashlight",
        "handle",
        "bayonet",
        "muzzle",
        "barrel",
        "underbarrel",
        "receiver",
        "magazine",
        "magazine2",
        "rail",
        "sight",
        "sight_2",
        "help_sight",
        "grip",
        "stock",
        "stock_2",
        "stock_3",
        "body",
        "pommel",
        "hilt",
        "head",
        "blade",
        "teeth",
        "chain",
        "connector",
        "shaft",
        "left",
        "emblem_right",
        "emblem_left",
        "shaft_lower",
        "shaft_upper",
        "trinket_hook",
        "slot_trinket_1",
        "slot_trinket_2",
    }
--#endregion

--#region Models
    mod.attachment_models = {
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.models,
            ogryn_rippergun_p1_m1 = _ogryn_rippergun_p1_m1.models,
            ogryn_thumper_p1_m1 = _ogryn_thumper_p1_m1.models,
            ogryn_gauntlet_p1_m1 = _ogryn_gauntlet_p1_m1.models,
        --#endregion
        --#region Ogryn Melee
            ogryn_club_p1_m1 = _ogryn_club_p1_m1.models,
            ogryn_combatblade_p1_m1 = _ogryn_combatblade_p1_m1.models,
            ogryn_powermaul_p1_m1 = _ogryn_powermaul_p1_m1.models,
            ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.models,
            ogryn_club_p2_m1 = _ogryn_club_p2_m1.models,
        --#endregion
        --#region Guns
            autopistol_p1_m1 = _autopistol_p1_m1.models,
            shotgun_p1_m1 = _shotgun_p1_m1.models,
            bolter_p1_m1 = _bolter_p1_m1.models,
            stubrevolver_p1_m1 = _stubrevolver_p1_m1.models,
            plasmagun_p1_m1 = _plasmagun_p1_m1.models,
            laspistol_p1_m1 = _laspistol_p1_m1.models,
            autogun_p1_m1 = _autogun_p1_m1.models,
            lasgun_p1_m1 = _lasgun_p1_m1.models,
            lasgun_p2_m1 = _lasgun_p2_m1.models,
            lasgun_p3_m1 = _lasgun_p3_m1.models,
            flamer_p1_m1 = _flamer_p1_m1.models,
            forcestaff_p1_m1 = _forcestaff_p1_m1.models,
        --#endregion
        --#region Melee
            combataxe_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                _axe_grip_models(),
                _axe_head_models(),
                _pommel_models()
            ),
            combataxe_p2_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                _axe_grip_models(),
                _axe_head_models(),
                _pommel_models()
            ),
            combatknife_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    knife_grip_default = {model = "", type = "grip"},
                    knife_grip_01 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_01", type = "grip"},
                    knife_grip_02 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_02", type = "grip"},
                    knife_grip_03 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_03", type = "grip"},
                    knife_grip_04 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_04", type = "grip"},
                    knife_grip_05 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_05", type = "grip"},
                    knife_grip_06 = {model = "content/items/weapons/player/melee/grips/combat_knife_grip_06", type = "grip"},
                    knife_body_default = {model = "", type = "body"},
                    knife_body_01 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_01", type = "body"},
                    knife_body_02 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_02", type = "body"},
                    knife_body_03 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_03", type = "body"},
                    knife_body_04 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_04", type = "body"},
                    knife_body_05 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_05", type = "body"},
                    knife_body_06 = {model = "content/items/weapons/player/melee/blades/combat_knife_blade_06", type = "body"},
                }
            ),
            powersword_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    power_sword_grip_default = {model = "", type = "grip"},
                    power_sword_grip_01 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_01", type = "grip"},
                    power_sword_grip_02 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_02", type = "grip"},
                    power_sword_grip_03 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_03", type = "grip"},
                    power_sword_grip_04 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_04", type = "grip"},
                    power_sword_grip_05 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_05", type = "grip"},
                    power_sword_grip_06 = {model = "content/items/weapons/player/melee/grips/power_sword_grip_06", type = "grip"},
                    power_sword_pommel_default = {model = "", type = "pommel"},
                    power_sword_pommel_01 = {model = "content/items/weapons/player/melee/pommels/power_sword_pommel_01", type = "pommel"},
                    power_sword_pommel_02 = {model = "content/items/weapons/player/melee/pommels/power_sword_pommel_02", type = "pommel"},
                    power_sword_pommel_03 = {model = "content/items/weapons/player/melee/pommels/power_sword_pommel_03", type = "pommel"},
                    power_sword_pommel_04 = {model = "content/items/weapons/player/melee/pommels/power_sword_pommel_05", type = "pommel"},
                    power_sword_pommel_05 = {model = "content/items/weapons/player/melee/pommels/power_sword_pommel_06", type = "pommel"},
                    power_sword_blade_default = {model = "", type = "blade"},
                    power_sword_blade_01 = {model = "content/items/weapons/player/melee/blades/power_sword_blade_01", type = "blade"},
                    power_sword_blade_02 = {model = "content/items/weapons/player/melee/blades/power_sword_blade_02", type = "blade"},
                    power_sword_blade_03 = {model = "content/items/weapons/player/melee/blades/power_sword_blade_03", type = "blade"},
                    power_sword_blade_04 = {model = "content/items/weapons/player/melee/blades/power_sword_blade_05", type = "blade"},
                    power_sword_blade_05 = {model = "content/items/weapons/player/melee/blades/power_sword_blade_06", type = "blade"},
                }
            ),
            chainaxe_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    chain_axe_teeth_default = {model = "", type = "teeth"},
                    chain_axe_teeth_01 = {model = "content/items/weapons/player/melee/chains/chain_axe_chain_01", type = "teeth"},
                    chain_axe_blade_default = {model = "", type = "blade"},
                    chain_axe_blade_01 = {model = "content/items/weapons/player/melee/blades/chain_axe_blade_01", type = "blade"},
                    chain_axe_blade_02 = {model = "content/items/weapons/player/melee/blades/chain_axe_blade_02", type = "blade"},
                    chain_axe_blade_03 = {model = "content/items/weapons/player/melee/blades/chain_axe_blade_03", type = "blade"},
                    chain_axe_blade_04 = {model = "content/items/weapons/player/melee/blades/chain_axe_blade_04", type = "blade"},
                    chain_axe_blade_05 = {model = "content/items/weapons/player/melee/blades/chain_axe_blade_05", type = "blade"},
                    chain_axe_grip_default = {model = "", type = "grip"},
                    chain_axe_grip_01 = {model = "content/items/weapons/player/melee/grips/chain_axe_grip_01", type = "grip"},
                    chain_axe_grip_02 = {model = "content/items/weapons/player/melee/grips/chain_axe_grip_02", type = "grip"},
                    chain_axe_grip_03 = {model = "content/items/weapons/player/melee/grips/chain_axe_grip_03", type = "grip"},
                    chain_axe_grip_04 = {model = "content/items/weapons/player/melee/grips/chain_axe_grip_04", type = "grip"},
                    chain_axe_grip_05 = {model = "content/items/weapons/player/melee/grips/chain_axe_grip_05", type = "grip"},
                    chain_axe_shaft_default = {model = "", type = "shaft"},
                    chain_axe_shaft_01 = {model = "content/items/weapons/player/ranged/shafts/chain_axe_shaft_01", type = "shaft"},
                    chain_axe_shaft_02 = {model = "content/items/weapons/player/ranged/shafts/chain_axe_shaft_02", type = "shaft"},
                    chain_axe_shaft_03 = {model = "content/items/weapons/player/ranged/shafts/chain_axe_shaft_03", type = "shaft"},
                    chain_axe_shaft_04 = {model = "content/items/weapons/player/ranged/shafts/chain_axe_shaft_04", type = "shaft"},
                    chain_axe_shaft_05 = {model = "content/items/weapons/player/ranged/shafts/chain_axe_shaft_05", type = "shaft"},
                }
            ),
            chainsword_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    chain_sword_grip_default = {model = "", type = "grip"},
                    chain_sword_grip_01 = {model = "content/items/weapons/player/melee/grips/chain_sword_grip_01", type = "grip"},
                    chain_sword_grip_02 = {model = "content/items/weapons/player/melee/grips/chain_sword_grip_02", type = "grip"},
                    chain_sword_grip_03 = {model = "content/items/weapons/player/melee/grips/chain_sword_grip_03", type = "grip"},
                    chain_sword_grip_04 = {model = "content/items/weapons/player/melee/grips/chain_sword_grip_04", type = "grip"},
                    chain_sword_grip_05 = {model = "content/items/weapons/player/melee/grips/chain_sword_grip_05", type = "grip"},
                    chain_sword_body_default = {model = "", type = "body"},
                    chain_sword_body_01 = {model = "content/items/weapons/player/melee/full/chain_sword_full_01", type = "body"},
                    chain_sword_body_02 = {model = "content/items/weapons/player/melee/full/chain_sword_full_02", type = "body"},
                    chain_sword_body_03 = {model = "content/items/weapons/player/melee/full/chain_sword_full_03", type = "body"},
                    -- chain_sword_body_04 = {model = "content/items/weapons/player/melee/full/chain_sword_full_04", type = "body"}, --buggy
                    -- chain_sword_body_05 = {model = "content/items/weapons/player/melee/full/chain_sword_full_05", type = "body"}, --buggy
                    chain_sword_body_06 = {model = "content/items/weapons/player/melee/full/chain_sword_full_06", type = "body"},
                    chain_sword_chain_default = {model = "", type = "chain"},
                    chain_sword_chain_01 = {model = "content/items/weapons/player/melee/chains/chain_sword_chain_01", type = "chain"},
                }
            ),
            combataxe_p3_m1 = table.combine(
                _common_functions.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
                _common_functions.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
                _common_functions.trinket_hook_models(nil, 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2)),
                _shovel_functions.shovel_head_models(nil, 0, vector3_box(.1, -4, -.1), vector3_box(0, 0, .4), "head", {
                    -- {"trinket_hook_empty"},
                }, {}, {}, function(gear_id, item, attachment)
                    local changes = {}
                    if string_find(attachment, "default") then
                        if mod:get_gear_setting(gear_id, "grip", item) ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                        if mod:get_gear_setting(gear_id, "pommel", item) ~= "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_default" end
                    else
                        if mod:get_gear_setting(gear_id, "grip", item) == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                        if mod:get_gear_setting(gear_id, "pommel", item) == "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_01" end
                    end
                    return changes
                end),
                _shovel_functions.shovel_grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", {}, {}, {}, function(gear_id, item, attachment)
                    local changes = {}
                    if string_find(attachment, "default") then
                        if mod:get_gear_setting(gear_id, "head", item) ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                        if mod:get_gear_setting(gear_id, "pommel", item) ~= "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_default" end
                    else
                        if mod:get_gear_setting(gear_id, "head", item) == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                        if mod:get_gear_setting(gear_id, "pommel", item) == "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_01" end
                    end
                    return changes
                end),
                _shovel_functions.shovel_pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", {}, {}, {}, function(gear_id, item, attachment)
                    local changes = {}
                    if string_find(attachment, "default") or string_find(attachment, "shovel_pommel_06") then
                        if mod:get_gear_setting(gear_id, "head", item) ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                        if mod:get_gear_setting(gear_id, "grip", item) ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                    else
                        if mod:get_gear_setting(gear_id, "head", item) == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                        if mod:get_gear_setting(gear_id, "grip", item) == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                    end
                    return changes
                end)
            ),
            combatsword_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    combat_sword_grip_default = {model = "", type = "grip"},
                    combat_sword_grip_01 = {model = "content/items/weapons/player/melee/grips/combat_sword_grip_01", type = "grip"},
                    combat_sword_grip_02 = {model = "content/items/weapons/player/melee/grips/combat_sword_grip_02", type = "grip"},
                    combat_sword_grip_03 = {model = "content/items/weapons/player/melee/grips/combat_sword_grip_03", type = "grip"},
                    combat_sword_grip_04 = {model = "content/items/weapons/player/melee/grips/combat_sword_grip_04", type = "grip"},
                    combat_sword_grip_05 = {model = "content/items/weapons/player/melee/grips/combat_sword_grip_05", type = "grip"},
                    combat_sword_blade_default = {model = "", type = "body"},
                    combat_sword_blade_01 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_01", type = "body"},
                    combat_sword_blade_02 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_02", type = "body"},
                    combat_sword_blade_03 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_03", type = "body"},
                    combat_sword_blade_04 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_04", type = "body"},
                    combat_sword_blade_05 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_05", type = "body"},
                    combat_sword_blade_06 = {model = "content/items/weapons/player/melee/blades/combat_sword_blade_06", type = "body"},
                }
            ),
            thunderhammer_2h_p1_m1 = table.combine(
                {customization_default_position = vector3_box(0, 3, .35)},
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    thunder_hammer_shaft_default = {model = "", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_shaft_01 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_01", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_shaft_02 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_02", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_shaft_03 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_03", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_shaft_04 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_04", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_shaft_05 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_05", type = "shaft", move = vector3_box(-.5, -3, .3)},
                    thunder_hammer_pommel_default = {model = "", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_pommel_01 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_01", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_pommel_02 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_05", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_pommel_03 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_03", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_pommel_04 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_04", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_pommel_05 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_05", type = "pommel", move = vector3_box(-.75, -4, .5)},
                    thunder_hammer_connector_default = {model = "", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_connector_01 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_01", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_connector_02 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_02", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_connector_03 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_03", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_connector_04 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_04", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_connector_05 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_05", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    thunder_hammer_head_default = {model = "", type = "head", move = vector3_box(.15, -6.5, -.4)},
                    thunder_hammer_head_01 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_01", type = "head", move = vector3_box(.15, -6.5, -.4)},
                    thunder_hammer_head_02 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_02", type = "head", move = vector3_box(.15, -6.5, -.4)},
                    thunder_hammer_head_03 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_03", type = "head", move = vector3_box(.15, -6.5, -.4)},
                    thunder_hammer_head_04 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_04", type = "head", move = vector3_box(.15, -6.5, -.4)},
                    thunder_hammer_head_05 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_05", type = "head", move = vector3_box(.15, -6.5, -.4)},
                }
            ),
            powermaul_2h_p1_m1 = table.combine(
                {customization_default_position = vector3_box(0, 2, .35)},
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    ["2h_power_maul_shaft_default"] = {model = "", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_01"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_01", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_02"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_02", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_03"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_03", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_04"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_04", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_05"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_05", type = "shaft", move = vector3_box(-.3, -3, .2)},
                    ["2h_power_maul_pommel_default"] = {model = "", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_01"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_01", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_02"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_05", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_03"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_03", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_04"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_04", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_05"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_05", type = "pommel", move = vector3_box(-.5, -4, .5)},
                    ["2h_power_maul_connector_default"] = {model = "", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_01"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_01", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_02"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_02", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_03"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_03", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_04"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_04", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_05"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_05", type = "connector", move = vector3_box(0, -5.5, -.4)},
                    ["2h_power_maul_head_default"] = {model = "", type = "head", move = vector3_box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_01"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_01", type = "head", move = vector3_box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_02"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_02", type = "head", move = vector3_box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_03"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_03", type = "head", move = vector3_box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_04"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_04", type = "head", move = vector3_box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_05"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_05", type = "head", move = vector3_box(.05, -4.5, -.5)},
                }
            ),
            chainsword_2h_p1_m1 = table.combine(
                -- {customization_default_position = vector3_box(0, 2, .35)},
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    ["2h_chain_sword_grip_default"] = {model = "", type = "grip"},
                    ["2h_chain_sword_grip_01"] = {model = "content/items/weapons/player/melee/grips/2h_chain_sword_grip_01", type = "grip"},
                    ["2h_chain_sword_grip_02"] = {model = "content/items/weapons/player/melee/grips/2h_chain_sword_grip_02", type = "grip"},
                    ["2h_chain_sword_grip_03"] = {model = "content/items/weapons/player/melee/grips/2h_chain_sword_grip_03", type = "grip"},
                    ["2h_chain_sword_body_default"] = {model = "", type = "body"},
                    ["2h_chain_sword_body_01"] = {model = "content/items/weapons/player/melee/full/2h_chain_sword_body_01", type = "body"},
                    ["2h_chain_sword_body_02"] = {model = "content/items/weapons/player/melee/full/2h_chain_sword_body_02", type = "body"},
                    ["2h_chain_sword_body_03"] = {model = "content/items/weapons/player/melee/full/2h_chain_sword_body_03", type = "body"},
                    ["2h_chain_sword_chain_default"] = {model = "", type = "chain"},
                    ["2h_chain_sword_chain_01"] = {model = "content/items/weapons/player/melee/chains/2h_chain_sword_chain_01", type = "chain"},
                }
            ),
            combatsword_p2_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    falchion_grip_default = {model = "", type = "grip"},
                    falchion_grip_01 = {model = "content/items/weapons/player/melee/grips/falchion_grip_01", type = "grip"},
                    falchion_grip_02 = {model = "content/items/weapons/player/melee/grips/falchion_grip_02", type = "grip"},
                    falchion_grip_03 = {model = "content/items/weapons/player/melee/grips/falchion_grip_03", type = "grip"},
                    falchion_grip_04 = {model = "content/items/weapons/player/melee/grips/falchion_grip_04", type = "grip"},
                    falchion_grip_05 = {model = "content/items/weapons/player/melee/grips/falchion_grip_05", type = "grip"},
                    falchion_blade_default = {model = "", type = "body"},
                    falchion_blade_01 = {model = "content/items/weapons/player/melee/blades/falchion_blade_01", type = "body"},
                    falchion_blade_02 = {model = "content/items/weapons/player/melee/blades/falchion_blade_02", type = "body"},
                    falchion_blade_03 = {model = "content/items/weapons/player/melee/blades/falchion_blade_03", type = "body"},
                    falchion_blade_04 = {model = "content/items/weapons/player/melee/blades/falchion_blade_04", type = "body"},
                    falchion_blade_05 = {model = "content/items/weapons/player/melee/blades/falchion_blade_05", type = "body"},
                }
            ),
            forcesword_p1_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    force_sword_grip_default = {model = "", type = "grip"},
                    force_sword_grip_01 = {model = "content/items/weapons/player/melee/grips/force_sword_grip_01", type = "grip"},
                    force_sword_grip_02 = {model = "content/items/weapons/player/melee/grips/force_sword_grip_02", type = "grip"},
                    force_sword_grip_03 = {model = "content/items/weapons/player/melee/grips/force_sword_grip_03", type = "grip"},
                    force_sword_grip_04 = {model = "content/items/weapons/player/melee/grips/force_sword_grip_04", type = "grip"},
                    force_sword_grip_05 = {model = "content/items/weapons/player/melee/grips/force_sword_grip_05", type = "grip"},
                    force_sword_pommel_default = {model = "", type = "pommel"},
                    force_sword_pommel_01 = {model = "content/items/weapons/player/melee/pommels/force_sword_pommel_01", type = "pommel"},
                    force_sword_pommel_02 = {model = "content/items/weapons/player/melee/pommels/force_sword_pommel_02", type = "pommel"},
                    force_sword_pommel_03 = {model = "content/items/weapons/player/melee/pommels/force_sword_pommel_03", type = "pommel"},
                    force_sword_pommel_04 = {model = "content/items/weapons/player/melee/pommels/force_sword_pommel_04", type = "pommel"},
                    force_sword_pommel_05 = {model = "content/items/weapons/player/melee/pommels/force_sword_pommel_05", type = "pommel"},
                    force_sword_hilt_default = {model = "", type = "hilt"},
                    force_sword_hilt_01 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_01", type = "hilt"},
                    force_sword_hilt_02 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_02", type = "hilt"},
                    force_sword_hilt_03 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_03", type = "hilt"},
                    force_sword_hilt_04 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_04", type = "hilt"},
                    force_sword_hilt_05 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_05", type = "hilt"},
                    force_sword_hilt_06 = {model = "content/items/weapons/player/melee/hilts/force_sword_hilt_06", type = "hilt"},
                    force_sword_blade_default = {model = "", type = "blade"},
                    force_sword_blade_01 = {model = "content/items/weapons/player/melee/blades/force_sword_blade_01", type = "blade"},
                    force_sword_blade_02 = {model = "content/items/weapons/player/melee/blades/force_sword_blade_02", type = "blade"},
                    force_sword_blade_03 = {model = "content/items/weapons/player/melee/blades/force_sword_blade_03", type = "blade"},
                    force_sword_blade_04 = {model = "content/items/weapons/player/melee/blades/force_sword_blade_04", type = "blade"},
                    force_sword_blade_05 = {model = "content/items/weapons/player/melee/blades/force_sword_blade_05", type = "blade"},
                }
            ),
            combatsword_p3_m1 = table.combine(
                _common_functions.emblem_right_models(),
                _common_functions.emblem_left_models(),
                _common_functions.trinket_hook_models(),
                {
                    sabre_grip_default = {model = "", type = "grip"},
                    sabre_grip_01 = {model = "content/items/weapons/player/melee/grips/sabre_grip_01", type = "grip"},
                    sabre_grip_02 = {model = "content/items/weapons/player/melee/grips/sabre_grip_02", type = "grip"},
                    sabre_grip_03 = {model = "content/items/weapons/player/melee/grips/sabre_grip_03", type = "grip"},
                    sabre_grip_04 = {model = "content/items/weapons/player/melee/grips/sabre_grip_04", type = "grip"},
                    sabre_grip_05 = {model = "content/items/weapons/player/melee/grips/sabre_grip_05", type = "grip"},
                    sabre_blade_default = {model = "", type = "body"},
                    sabre_blade_01 = {model = "content/items/weapons/player/melee/blades/sabre_blade_01", type = "body"},
                    sabre_blade_02 = {model = "content/items/weapons/player/melee/blades/sabre_blade_02", type = "body"},
                    sabre_blade_03 = {model = "content/items/weapons/player/melee/blades/sabre_blade_03", type = "body"},
                    sabre_blade_04 = {model = "content/items/weapons/player/melee/blades/sabre_blade_04", type = "body"},
                    sabre_blade_05 = {model = "content/items/weapons/player/melee/blades/sabre_blade_05", type = "body"},
                }
            ),
        --#endregion
    }

    --#region Copies
        --#region Ogryn Guns
            mod.attachment_models.ogryn_heavystubber_p1_m2 = mod.attachment_models.ogryn_heavystubber_p1_m1
            mod.attachment_models.ogryn_heavystubber_p1_m3 = mod.attachment_models.ogryn_heavystubber_p1_m1
            mod.attachment_models.ogryn_rippergun_p1_m2 = mod.attachment_models.ogryn_rippergun_p1_m1
            mod.attachment_models.ogryn_rippergun_p1_m3 = mod.attachment_models.ogryn_rippergun_p1_m1
            mod.attachment_models.ogryn_thumper_p1_m2 = mod.attachment_models.ogryn_thumper_p1_m1
        --#endregion
        --#region Ogryn Melee
            mod.attachment_models.ogryn_combatblade_p1_m2 = mod.attachment_models.ogryn_combatblade_p1_m1
            mod.attachment_models.ogryn_combatblade_p1_m3 = mod.attachment_models.ogryn_combatblade_p1_m1
            -- mod.attachment_models.ogryn_powermaul_slabshield_p1_m1 = mod.attachment_models.ogryn_powermaul_p1_m1
            mod.attachment_models.ogryn_club_p2_m2 = mod.attachment_models.ogryn_club_p2_m1
            mod.attachment_models.ogryn_club_p2_m3 = mod.attachment_models.ogryn_club_p2_m1
        --#endregion
        --region Guns
            mod.attachment_models.shotgun_p1_m2 = mod.attachment_models.shotgun_p1_m1
            mod.attachment_models.shotgun_p1_m3 = mod.attachment_models.shotgun_p1_m1
            mod.attachment_models.bolter_p1_m2 = mod.attachment_models.bolter_p1_m1
            mod.attachment_models.bolter_p1_m3 = mod.attachment_models.bolter_p1_m1
            mod.attachment_models.stubrevolver_p1_m2 = mod.attachment_models.stubrevolver_p1_m1
            mod.attachment_models.stubrevolver_p1_m3 = mod.attachment_models.stubrevolver_p1_m1
            mod.attachment_models.autogun_p1_m2 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p1_m3 = mod.attachment_models.autogun_p1_m1
            -- mod.attachment_models.autogun_p2_m2 = mod.attachment_models.autogun_p2_m1
            -- mod.attachment_models.autogun_p2_m3 = mod.attachment_models.autogun_p2_m1
            -- mod.attachment_models.autogun_p3_m2 = mod.attachment_models.autogun_p3_m1
            -- mod.attachment_models.autogun_p3_m3 = mod.attachment_models.autogun_p3_m1
            mod.attachment_models.autogun_p2_m1 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p2_m2 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p2_m3 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p3_m1 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p3_m2 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p3_m3 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.lasgun_p1_m2 = mod.attachment_models.lasgun_p1_m1
            mod.attachment_models.lasgun_p1_m3 = mod.attachment_models.lasgun_p1_m1
            mod.attachment_models.lasgun_p2_m2 = mod.attachment_models.lasgun_p2_m1
            mod.attachment_models.lasgun_p2_m3 = mod.attachment_models.lasgun_p2_m1
            mod.attachment_models.lasgun_p3_m2 = mod.attachment_models.lasgun_p3_m1
            mod.attachment_models.lasgun_p3_m3 = mod.attachment_models.lasgun_p3_m1
            mod.attachment_models.forcestaff_p2_m1 = mod.attachment_models.forcestaff_p1_m1
            mod.attachment_models.forcestaff_p3_m1 = mod.attachment_models.forcestaff_p1_m1
            mod.attachment_models.forcestaff_p4_m1 = mod.attachment_models.forcestaff_p1_m1
        --#endregion
        --region Melee
            mod.attachment_models.combataxe_p1_m2 = mod.attachment_models.combataxe_p1_m1
            mod.attachment_models.combataxe_p1_m3 = mod.attachment_models.combataxe_p1_m1
            mod.attachment_models.combataxe_p2_m2 = mod.attachment_models.combataxe_p1_m1
            mod.attachment_models.combataxe_p2_m3 = mod.attachment_models.combataxe_p1_m1
            mod.attachment_models.powersword_p1_m2 = mod.attachment_models.powersword_p1_m1
            mod.attachment_models.combatsword_p1_m2 = mod.attachment_models.combatsword_p1_m1
            mod.attachment_models.combatsword_p1_m3 = mod.attachment_models.combatsword_p1_m1
            mod.attachment_models.thunderhammer_2h_p1_m2 = mod.attachment_models.thunderhammer_2h_p1_m1
            mod.attachment_models.combatsword_p2_m2 = mod.attachment_models.combatsword_p2_m1
            mod.attachment_models.combatsword_p2_m3 = mod.attachment_models.combatsword_p2_m1
            mod.attachment_models.forcesword_p1_m2 = mod.attachment_models.forcesword_p1_m1
            mod.attachment_models.forcesword_p1_m3 = mod.attachment_models.forcesword_p1_m1
            mod.attachment_models.combatsword_p3_m2 = mod.attachment_models.combatsword_p3_m1
            mod.attachment_models.combatsword_p3_m3 = mod.attachment_models.combatsword_p3_m1
        --#endregion
    --#endregion
--#endregion