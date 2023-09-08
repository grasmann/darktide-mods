local mod = get_mod("weapon_customization")

local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

mod.debugged_units = function(self)
    local units = {}
    for weapon_name, weapon_anchors in pairs(self.anchors) do
        for attachment_name, attachment in pairs(weapon_anchors) do
            if attachment.hide then
                units[#units+1] = attachment.hide
            end
        end
    end
    return units
end

--#region Table functions
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
            else
                res = t[1]
            end
        else
            res = t
        end
        if res == "" then
            return nil
        end
        return res
    end
    --#region Common
        local _flashlights_attachments = function()
            return {
                {id = "default",       name = "Default",      sounds = {UISoundEvents.smart_tag_pickup_default_enter}},
                {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.smart_tag_pickup_default_enter}},
                {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.smart_tag_pickup_default_enter}},
                {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.smart_tag_pickup_default_enter}},
                {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.smart_tag_pickup_default_enter}},
            }
        end
        local _flashlight_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                default =       {model = "",                                                              type = "flashlight", parent = tv(parent, 1), angle = angle, move = tv(move, 1), remove = tv(remove, 1)},
                flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight", parent = tv(parent, 2), angle = angle, move = tv(move, 1), remove = tv(remove, 2)},
                flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight", parent = tv(parent, 3), angle = angle, move = tv(move, 1), remove = tv(remove, 3)},
                flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight", parent = tv(parent, 4), angle = angle, move = tv(move, 1), remove = tv(remove, 4)},
                flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight", parent = tv(parent, 5), angle = angle, move = tv(move, 1), remove = tv(remove, 5)},
            } 
        end
        local _emblem_right_attachments = function()
            return {
                {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
            }
        end
        local _emblem_right_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                emblem_right_default = {model = "",                                                         type = "emblem_right", parent = tv(parent, 1), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01",    type = "emblem_right", parent = tv(parent, 2), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02",    type = "emblem_right", parent = tv(parent, 3), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03",    type = "emblem_right", parent = tv(parent, 4), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a",   type = "emblem_right", parent = tv(parent, 5), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b",   type = "emblem_right", parent = tv(parent, 6), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c",   type = "emblem_right", parent = tv(parent, 7), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d",   type = "emblem_right", parent = tv(parent, 8), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e",   type = "emblem_right", parent = tv(parent, 9), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f",   type = "emblem_right", parent = tv(parent, 10), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05",    type = "emblem_right", parent = tv(parent, 11), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06",    type = "emblem_right", parent = tv(parent, 12), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07",    type = "emblem_right", parent = tv(parent, 13), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a",   type = "emblem_right", parent = tv(parent, 14), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b",   type = "emblem_right", parent = tv(parent, 15), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c",   type = "emblem_right", parent = tv(parent, 16), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a",   type = "emblem_right", parent = tv(parent, 17), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b",   type = "emblem_right", parent = tv(parent, 18), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c",   type = "emblem_right", parent = tv(parent, 19), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d",   type = "emblem_right", parent = tv(parent, 20), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e",   type = "emblem_right", parent = tv(parent, 21), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10",    type = "emblem_right", parent = tv(parent, 22), angle = angle, move = move, remove = remove, no_mesh_move = true},
            }
        end
        local _emblem_left_attachments = function()
            return {
                {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
            }
        end
        local _emblem_left_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                emblem_left_default = {model = "",                                                      type = "emblem_left", parent = tv(parent, 1), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01",  type = "emblem_left", parent = tv(parent, 2), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02",  type = "emblem_left", parent = tv(parent, 3), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03",  type = "emblem_left", parent = tv(parent, 4), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left", parent = tv(parent, 5), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left", parent = tv(parent, 6), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left", parent = tv(parent, 7), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left", parent = tv(parent, 8), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left", parent = tv(parent, 9), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left", parent = tv(parent, 10), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05",  type = "emblem_left", parent = tv(parent, 11), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06",  type = "emblem_left", parent = tv(parent, 12), angle = angle, move = move, remove = remove, no_mesh_move = true},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10",  type = "emblem_left", parent = tv(parent, 13), angle = angle, move = move, remove = remove, no_mesh_move = true},
            }
        end
        local _grip_attachments = function()
            return {
                {id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_06", name = "Autogun 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_07", name = "Autogun 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_08", name = "Autogun 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_09", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_10", name = "Braced Autogun 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_11", name = "Braced Autogun 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_12", name = "Headhunter Autogun", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_13", name = "Boltgun 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_14", name = "Boltgun 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_15", name = "Boltgun 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_19", name = "Laspistol 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_20", name = "Laspistol 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_21", name = "Laspistol 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_22", name = "Lasgun 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_23", name = "Lasgun 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_24", name = "Lasgun 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_25", name = "Lasgun 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "grip_26", name = "Lasgun 5", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _grip_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                grip_default =  {model = "",                                                                            type = "grip", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                grip_01 =       {model = "content/items/weapons/player/ranged/grips/grip_01",                           type = "grip", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                grip_02 =       {model = "content/items/weapons/player/ranged/grips/grip_02",                           type = "grip", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                grip_03 =       {model = "content/items/weapons/player/ranged/grips/grip_03",                           type = "grip", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                grip_04 =       {model = "content/items/weapons/player/ranged/grips/grip_04",                           type = "grip", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                grip_05 =       {model = "content/items/weapons/player/ranged/grips/grip_05",                           type = "grip", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                grip_06 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_01",             type = "grip", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
                grip_07 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_02",             type = "grip", parent = tv(parent, 8), angle = angle, move = move, remove = remove},
                grip_08 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_03",             type = "grip", parent = tv(parent, 9), angle = angle, move = move, remove = remove},
                grip_09 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_ak_01",          type = "grip", parent = tv(parent, 10), angle = angle, move = move, remove = remove},
                grip_10 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_ak_02",          type = "grip", parent = tv(parent, 11), angle = angle, move = move, remove = remove},
                grip_11 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_ak_03",          type = "grip", parent = tv(parent, 12), angle = angle, move = move, remove = remove},
                grip_12 =       {model = "content/items/weapons/player/ranged/grips/autogun_rifle_grip_killshot_01",    type = "grip", parent = tv(parent, 13), angle = angle, move = move, remove = remove},
                grip_13 =       {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_01",             type = "grip", parent = tv(parent, 14), angle = angle, move = move, remove = remove},
                grip_14 =       {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_02",             type = "grip", parent = tv(parent, 15), angle = angle, move = move, remove = remove},
                grip_15 =       {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_03",             type = "grip", parent = tv(parent, 16), angle = angle, move = move, remove = remove},
                grip_19 =       {model = "content/items/weapons/player/ranged/grips/lasgun_pistol_grip_01",             type = "grip", parent = tv(parent, 17), angle = angle, move = move, remove = remove},
                grip_20 =       {model = "content/items/weapons/player/ranged/grips/lasgun_pistol_grip_02",             type = "grip", parent = tv(parent, 18), angle = angle, move = move, remove = remove},
                grip_21 =       {model = "content/items/weapons/player/ranged/grips/lasgun_pistol_grip_03",             type = "grip", parent = tv(parent, 19), angle = angle, move = move, remove = remove},
                grip_22 =       {model = "content/items/weapons/player/ranged/grips/lasgun_rifle_grip_01",              type = "grip", parent = tv(parent, 20), angle = angle, move = move, remove = remove},
                grip_23 =       {model = "content/items/weapons/player/ranged/grips/lasgun_rifle_grip_02",              type = "grip", parent = tv(parent, 21), angle = angle, move = move, remove = remove},
                grip_24 =       {model = "content/items/weapons/player/ranged/grips/lasgun_rifle_grip_03",              type = "grip", parent = tv(parent, 22), angle = angle, move = move, remove = remove},
                grip_25 =       {model = "content/items/weapons/player/ranged/grips/lasgun_rifle_elysian_grip_02",      type = "grip", parent = tv(parent, 23), angle = angle, move = move, remove = remove},
                grip_26 =       {model = "content/items/weapons/player/ranged/grips/lasgun_rifle_elysian_grip_03",      type = "grip", parent = tv(parent, 24), angle = angle, move = move, remove = remove},
            }
        end
        local _bayonet_attachments = function()
            return {
                {id = "autogun_bayonet_default",    name = "Default",   sounds = {UISoundEvents.end_screen_summary_plasteel_zero, UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "autogun_bayonet_01",         name = "Bayonet 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "autogun_bayonet_02",         name = "Bayonet 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "autogun_bayonet_03",         name = "Bayonet 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
            }
        end
        local _bayonet_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                autogun_bayonet_default =   {model = "",                                                        type = "bayonet", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                autogun_bayonet_01 =        {model = "content/items/weapons/player/ranged/bayonets/bayonet_01", type = "bayonet", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                autogun_bayonet_02 =        {model = "content/items/weapons/player/ranged/bayonets/bayonet_02", type = "bayonet", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                autogun_bayonet_03 =        {model = "content/items/weapons/player/ranged/bayonets/bayonet_03", type = "bayonet", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
            }
        end
        local _reflex_sights_attachments = function()
            return {
                {id = "reflex_sight_01", name = "Reflex Sight 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "reflex_sight_02", name = "Reflex Sight 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "reflex_sight_03", name = "Reflex Sight 3", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _reflex_sights_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                sight_default =     {model = "",                                                            type = "sight", parent = tv(parent, 1), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_01"}},
                reflex_sight_01 =   {model = "content/items/weapons/player/ranged/sights/reflex_sight_01",  type = "sight", parent = tv(parent, 2), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_01"}},
                reflex_sight_02 =   {model = "content/items/weapons/player/ranged/sights/reflex_sight_02",  type = "sight", parent = tv(parent, 3), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_01"}},
                reflex_sight_03 =   {model = "content/items/weapons/player/ranged/sights/reflex_sight_03",  type = "sight", parent = tv(parent, 4), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_01"}},
            }
        end
        local _sights_attachments = function()
            return {
                {id = "autogun_rifle_sight_01", name = "Autogun", sounds = {UISoundEvents.weapons_swap}},
                {id = "autogun_rifle_ak_sight_01", name = "Braced Autogun", sounds = {UISoundEvents.weapons_swap}},
                {id = "headhunter_autogun_sight_01", name = "Headhunter Autogun", sounds = {UISoundEvents.weapons_swap}},
                {id = "lasgun_sight_01", name = "Lasgun", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _sights_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                sight_default =                 {model = "",                                                                              type = "sight", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                autogun_rifle_ak_sight_01 =     {model = "content/items/weapons/player/ranged/sights/autogun_rifle_ak_sight_01",          type = "sight", parent = tv(parent, 2), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_default"}},
                autogun_rifle_sight_01 =        {model = "content/items/weapons/player/ranged/sights/autogun_rifle_sight_01",             type = "sight", parent = tv(parent, 3), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_default"}},
                headhunter_autogun_sight_01 =   {model = "content/items/weapons/player/ranged/sights/autogun_rifle_killshot_sight_01",    type = "sight", parent = tv(parent, 4), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_default"}},
                lasgun_sight_01 =               {model = "content/items/weapons/player/ranged/sights/lasgun_rifle_sight_01",              type = "sight", parent = tv(parent, 5), angle = angle, move = move, remove = remove, automatic_equip = {rail = "rail_default"}},
            }
        end
        local _stock_attachments = function()
            return {
                {id = "no_stock", name = "No Stock", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "stock_01", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "stock_02", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "stock_03", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "stock_04", name = "Stock 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "stock_05", name = "Stock 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_01", name = "Infantry Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_02", name = "Infantry Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_03", name = "Infantry Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_04", name = "Infantry Autogun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_05", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_06", name = "Braced Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_07", name = "Braced Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_08", name = "Headhunter Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "autogun_rifle_stock_09", name = "Headhunter Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "lasgun_stock_01", name = "Infantry Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "lasgun_stock_02", name = "Infantry Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "lasgun_stock_03", name = "Infantry Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _stock_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                stock_default =             {model = "",                                                                            type = "stock", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                no_stock =                  {model = "",                                                                            type = "stock", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                stock_01 =                  {model = "content/items/weapons/player/ranged/stocks/stock_01",                         type = "stock", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                stock_02 =                  {model = "content/items/weapons/player/ranged/stocks/stock_02",                         type = "stock", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                stock_03 =                  {model = "content/items/weapons/player/ranged/stocks/stock_03",                         type = "stock", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                stock_04 =                  {model = "content/items/weapons/player/ranged/stocks/stock_04",                         type = "stock", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                stock_05 =                  {model = "content/items/weapons/player/ranged/stocks/stock_05",                         type = "stock", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_01 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_01",           type = "stock", parent = tv(parent, 8), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_02 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_02",           type = "stock", parent = tv(parent, 9), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_03 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_03",           type = "stock", parent = tv(parent, 10), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_04 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_04",           type = "stock", parent = tv(parent, 11), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_05 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_ak_stock_01",        type = "stock", parent = tv(parent, 12), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_06 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_ak_stock_02",        type = "stock", parent = tv(parent, 13), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_07 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_ak_stock_03",        type = "stock", parent = tv(parent, 14), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_08 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_killshot_stock_01",  type = "stock", parent = tv(parent, 15), angle = angle, move = move, remove = remove},
                autogun_rifle_stock_09 =    {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_killshot_stock_02",  type = "stock", parent = tv(parent, 16), angle = angle, move = move, remove = remove},
                lasgun_stock_01 =           {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_stock_01",            type = "stock", parent = tv(parent, 17), angle = angle, move = move, remove = remove},
                lasgun_stock_02 =           {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_stock_02",            type = "stock", parent = tv(parent, 18), angle = angle, move = move, remove = remove},
                lasgun_stock_03 =           {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_stock_03",            type = "stock", parent = tv(parent, 19), angle = angle, move = move, remove = remove},
            }
        end
        local _trinket_hook_attachments = function()
            return {
                {id = "trinket_hook_default",       name = "Default",                   sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "trinket_hook_empty",         name = "No Trinket Hook",           sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_01",            name = "Trinket Hook 1",            sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_01_v",          name = "Trinket Hook 1 V",          sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_02",            name = "Trinket Hook 2",            sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_02_45",         name = "Trinket Hook 2 45",         sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_02_90",         name = "Trinket Hook 2 90",         sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_03",            name = "Trinket Hook 3",            sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_03_v",          name = "Trinket Hook 3 V",          sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_steel",      name = "Trinket Hook 4 Steel",      sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_steel_v",    name = "Trinket Hook 4 Steel V",    sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_coated",     name = "Trinket Hook 4 Coated",     sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_coated_v",   name = "Trinket Hook 4 Coated V",   sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_carbon",     name = "Trinket Hook 4 Carbon",     sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_carbon_v",   name = "Trinket Hook 4 Carbon V",   sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_gold",       name = "Trinket Hook 4 Gold",       sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_04_gold_v",     name = "Trinket Hook 4 Gold V",     sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_steel",      name = "Trinket Hook 5 Steel",      sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_steel_v",    name = "Trinket Hook 5 Steel V",    sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_coated",     name = "Trinket Hook 5 Coated",     sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_coated_v",   name = "Trinket Hook 5 Coated V",   sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_carbon",     name = "Trinket Hook 5 Carbon",     sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_carbon_v",   name = "Trinket Hook 5 Carbon V",   sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_gold",       name = "Trinket Hook 5 Gold",       sounds = {UISoundEvents.apparel_equip}},
                {id = "trinket_hook_05_gold_v",     name = "Trinket Hook 5 Gold V",     sounds = {UISoundEvents.apparel_equip}},
            }
        end
        local _trinket_hook_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                trinket_hook_default =      {model = "",                                                                type = "trinket_hook", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1), no_mesh_move = true},
                trinket_hook_02_90 =        {model = "content/items/weapons/player/trinkets/trinket_hook_02_90",        type = "trinket_hook", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2), no_mesh_move = true},
                trinket_hook_01_v =         {model = "content/items/weapons/player/trinkets/trinket_hook_01_v",         type = "trinket_hook", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3), no_mesh_move = true},
                trinket_hook_04_gold_v =    {model = "content/items/weapons/player/trinkets/trinket_hook_04_gold_v",    type = "trinket_hook", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4), no_mesh_move = true},
                trinket_hook_02 =           {model = "content/items/weapons/player/trinkets/trinket_hook_02",           type = "trinket_hook", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5), no_mesh_move = true},
                trinket_hook_03 =           {model = "content/items/weapons/player/trinkets/trinket_hook_03",           type = "trinket_hook", parent = tv(parent, 6), angle = angle, move = move, remove = tv(remove, 6), no_mesh_move = true},
                trinket_hook_04_steel_v =   {model = "content/items/weapons/player/trinkets/trinket_hook_04_steel_v",   type = "trinket_hook", parent = tv(parent, 7), angle = angle, move = move, remove = tv(remove, 7), no_mesh_move = true},
                trinket_hook_04_carbon =    {model = "content/items/weapons/player/trinkets/trinket_hook_04_carbon",    type = "trinket_hook", parent = tv(parent, 8), angle = angle, move = move, remove = tv(remove, 8), no_mesh_move = true},
                trinket_hook_04_gold =      {model = "content/items/weapons/player/trinkets/trinket_hook_04_gold",      type = "trinket_hook", parent = tv(parent, 9), angle = angle, move = move, remove = tv(remove, 9), no_mesh_move = true},
                trinket_hook_04_carbon_v =  {model = "content/items/weapons/player/trinkets/trinket_hook_04_carbon_v",  type = "trinket_hook", parent = tv(parent, 10), angle = angle, move = move, remove = tv(remove, 10), no_mesh_move = true},
                trinket_hook_04_coated =    {model = "content/items/weapons/player/trinkets/trinket_hook_04_coated",    type = "trinket_hook", parent = tv(parent, 11), angle = angle, move = move, remove = tv(remove, 11), no_mesh_move = true},
                trinket_hook_01 =           {model = "content/items/weapons/player/trinkets/trinket_hook_01",           type = "trinket_hook", parent = tv(parent, 12), angle = angle, move = move, remove = tv(remove, 12), no_mesh_move = true},
                trinket_hook_04_steel =     {model = "content/items/weapons/player/trinkets/trinket_hook_04_steel",     type = "trinket_hook", parent = tv(parent, 13), angle = angle, move = move, remove = tv(remove, 13), no_mesh_move = true},
                trinket_hook_02_45 =        {model = "content/items/weapons/player/trinkets/trinket_hook_02_45",        type = "trinket_hook", parent = tv(parent, 14), angle = angle, move = move, remove = tv(remove, 14), no_mesh_move = true},
                trinket_hook_empty =        {model = "content/items/weapons/player/trinkets/trinket_hook_empty",        type = "trinket_hook", parent = tv(parent, 15), angle = angle, move = move, remove = tv(remove, 15), no_mesh_move = true},
                trinket_hook_05_gold =      {model = "content/items/weapons/player/trinkets/trinket_hook_05_gold",      type = "trinket_hook", parent = tv(parent, 16), angle = angle, move = move, remove = tv(remove, 16), no_mesh_move = true},
                trinket_hook_05_carbon =    {model = "content/items/weapons/player/trinkets/trinket_hook_05_carbon",    type = "trinket_hook", parent = tv(parent, 17), angle = angle, move = move, remove = tv(remove, 17), no_mesh_move = true},
                trinket_hook_05_coated_v =  {model = "content/items/weapons/player/trinkets/trinket_hook_05_coated_v",  type = "trinket_hook", parent = tv(parent, 18), angle = angle, move = move, remove = tv(remove, 18), no_mesh_move = true},
                trinket_hook_05_gold_v =    {model = "content/items/weapons/player/trinkets/trinket_hook_05_gold_v",    type = "trinket_hook", parent = tv(parent, 19), angle = angle, move = move, remove = tv(remove, 19), no_mesh_move = true},
                trinket_hook_05_steel_v =   {model = "content/items/weapons/player/trinkets/trinket_hook_05_steel_v",   type = "trinket_hook", parent = tv(parent, 20), angle = angle, move = move, remove = tv(remove, 20), no_mesh_move = true},
                trinket_hook_05_coated =    {model = "content/items/weapons/player/trinkets/trinket_hook_05_coated",    type = "trinket_hook", parent = tv(parent, 21), angle = angle, move = move, remove = tv(remove, 21), no_mesh_move = true},
                trinket_hook_05_carbon_v =  {model = "content/items/weapons/player/trinkets/trinket_hook_05_carbon_v",  type = "trinket_hook", parent = tv(parent, 22), angle = angle, move = move, remove = tv(remove, 22), no_mesh_move = true},
                trinket_hook_03_v =         {model = "content/items/weapons/player/trinkets/trinket_hook_03_v",         type = "trinket_hook", parent = tv(parent, 23), angle = angle, move = move, remove = tv(remove, 23), no_mesh_move = true},
                trinket_hook_05_steel =     {model = "content/items/weapons/player/trinkets/trinket_hook_05_steel",     type = "trinket_hook", parent = tv(parent, 24), angle = angle, move = move, remove = tv(remove, 24), no_mesh_move = true},
                trinket_hook_04_coated_v =  {model = "content/items/weapons/player/trinkets/trinket_hook_04_coated_v",  type = "trinket_hook", parent = tv(parent, 25), angle = angle, move = move, remove = tv(remove, 25), no_mesh_move = true},
            }
        end
    --#endregion
    --#region Ogryn Guns
            -- talents_equip_talent - grenade launcher
        -- social_menu_unfriend_player - gas tank
        -- end_screen_summary_credits_stop - ?
        -- end_screen_summary_card_expand - ?
        -- smart_tag_pickup_default_enter - small
        -- end_screen_summary_experience_stop - ?
        -- mark_vendor_replace_contract - energy
            -- weapons_trinket_select - small
            -- smart_tag_hud_default - small
            -- weapons_skin_select - small
        local _stubber_barrel_attachments = function()
            return {
                {id = "barrel_default", name = "Default",   sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_01",      name = "Barrel 1",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_02",      name = "Barrel 2",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_03",      name = "Barrel 3",  sounds = {UISoundEvents.talents_equip_talent}},
            }
        end
        local _stubber_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                            type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                barrel_01 =         {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_01",   type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                barrel_02 =         {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_02",   type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                barrel_03 =         {model = "content/items/weapons/player/ranged/barrels/stubgun_heavy_ogryn_barrel_03",   type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
            }
        end
        local _stubber_receiver_attachments = function()
            return {
                {id = "receiver_default",   name = "Default",       sounds = {UISoundEvents.end_screen_summary_currency_icon_out, UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_01",        name = "Receiver 1",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_02",        name = "Receiver 2",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_03",        name = "Receiver 3",    sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _stubber_receiver_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                receiver_default =  {model = "",                                                                                type = "receiver", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                receiver_01 =       {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_01",   type = "receiver", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                receiver_02 =       {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_02",   type = "receiver", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                receiver_03 =       {model = "content/items/weapons/player/ranged/recievers/stubgun_heavy_ogryn_receiver_03",   type = "receiver", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
            }
        end
        local _stubber_magazine_attachments = function()
            return {
                {id = "magazine_default",   name = "Default",       sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_01",        name = "Magazine 1",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_02",        name = "Magazine 2",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_03",        name = "Magazine 3",    sounds = {UISoundEvents.weapons_trinket_select}},
            }
        end
        local _stubber_magazine_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                magazine_default =  {model = "",                                                                                type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = remove, no_mesh_move = true},
                magazine_01 =       {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_01",   type = "magazine", parent = tv(parent, 2), angle = angle, move = move, remove = remove, no_mesh_move = true},
                magazine_02 =       {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_02",   type = "magazine", parent = tv(parent, 3), angle = angle, move = move, remove = remove, no_mesh_move = true},
                magazine_03 =       {model = "content/items/weapons/player/ranged/magazines/stubgun_heavy_ogryn_magazine_03",   type = "magazine", parent = tv(parent, 4), angle = angle, move = move, remove = remove, no_mesh_move = true},
            }
        end
        local _stubber_grip_attachments = function()
            return {
                {id = "grip_default",   name = "Default",   sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "grip_01",        name = "Grip 1",    sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "grip_02",        name = "Grip 2",    sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "grip_03",        name = "Grip 3",    sounds = {UISoundEvents.smart_tag_hud_default}},
            }
        end
        local _stubber_grip_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                grip_default =  {model = "",                                                                        type = "grip", parent = tv(parent, 1), angle = angle, move = move, remove = remove, automatic_equip = {trinket_hook = "trinket_hook_default"}, no_mesh_move = true},
                grip_01 =       {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_01",   type = "grip", parent = tv(parent, 2), angle = angle, move = move, remove = remove, automatic_equip = {trinket_hook = "trinket_hook_default"}, no_support = {"trinket_hook"}, no_mesh_move = true},
                grip_02 =       {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_02",   type = "grip", parent = tv(parent, 3), angle = angle, move = move, remove = remove, automatic_equip = {trinket_hook = "trinket_hook_default"}, no_support = {"trinket_hook"}, no_mesh_move = true},
                grip_03 =       {model = "content/items/weapons/player/ranged/grips/stubgun_heavy_ogryn_grip_03",   type = "grip", parent = tv(parent, 4), angle = angle, move = move, remove = remove, automatic_equip = {trinket_hook = "trinket_hook_01"}, no_support = {"trinket_hook_empty"}, no_mesh_move = true},
            }
        end
        local _ogryn_bayonet_attachments = function()
            return {
                {id = "bayonet_default",    name = "Default",   sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "bayonet_01",         name = "Bayonet 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "bayonet_02",         name = "Bayonet 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "bayonet_03",         name = "Bayonet 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                {id = "bayonet_blade_01",   name = "Blade",     sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
            }
        end
        local _ogryn_bayonet_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                bayonet_default =   {model = "",                                                                        type = "bayonet", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                bayonet_01 =        {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_01", type = "bayonet", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                bayonet_02 =        {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_02", type = "bayonet", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                bayonet_03 =        {model = "content/items/weapons/player/ranged/bayonets/rippergun_rifle_bayonet_03", type = "bayonet", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                bayonet_blade_01 =  {model = "content/items/weapons/player/melee/blades/combat_sword_blade_01",         type = "bayonet", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
            }
        end
        local _ripper_barrel_attachments = function()
            return {
                {id = "barrel_default", name = "Default",   sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_01",      name = "Barrel 1",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_02",      name = "Barrel 2",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_03",      name = "Barrel 3",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_04",      name = "Barrel 4",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_05",      name = "Barrel 5",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_06",      name = "Barrel 6",  sounds = {UISoundEvents.talents_equip_talent}},
            }
        end
        local _ripper_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                        type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                barrel_01 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_01",   type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                barrel_02 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_02",   type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                barrel_03 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_03",   type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                barrel_04 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_04",   type = "barrel", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
                barrel_05 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_05",   type = "barrel", parent = tv(parent, 6), angle = angle, move = move, remove = tv(remove, 6)},
                barrel_06 =         {model = "content/items/weapons/player/ranged/barrels/rippergun_rifle_barrel_06",   type = "barrel", parent = tv(parent, 7), angle = angle, move = move, remove = tv(remove, 7)},
            }
        end
        local _ripper_receiver_attachments = function()
            return {
                {id = "receiver_default",   name = "Default",       sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_01",        name = "Receiver 1",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_02",        name = "Receiver 2",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_03",        name = "Receiver 3",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_04",        name = "Receiver 4",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_05",        name = "Receiver 5",    sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "receiver_06",        name = "Receiver 6",    sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _ripper_receiver_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                receiver_default =  {model = "",                                                                            type = "receiver", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1), no_support = {"trinket_hook_empty"}},
                receiver_01 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_01",   type = "receiver", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2), no_support = {"trinket_hook_empty"}},
                receiver_02 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_02",   type = "receiver", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3), no_support = {"trinket_hook_empty"}},
                receiver_03 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_03",   type = "receiver", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4), no_support = {"trinket_hook_empty"}},
                receiver_04 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_04",   type = "receiver", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5), no_support = {"trinket_hook_empty"}},
                receiver_05 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_05",   type = "receiver", parent = tv(parent, 6), angle = angle, move = move, remove = tv(remove, 6), no_support = {"trinket_hook_empty"}},
                receiver_06 =       {model = "content/items/weapons/player/ranged/recievers/rippergun_rifle_receiver_06",   type = "receiver", parent = tv(parent, 7), angle = angle, move = move, remove = tv(remove, 7), no_support = {"trinket_hook_empty"}},
            }
        end
        local _ripper_magazine_attachments = function()
            return {
                {id = "magazine_default",   name = "Default",       sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_01",        name = "Magazine 1",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_02",        name = "Magazine 2",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_03",        name = "Magazine 3",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_04",        name = "Magazine 4",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_05",        name = "Magazine 5",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_06",        name = "Magazine 6",    sounds = {UISoundEvents.weapons_trinket_select}},
            }
        end
        local _ripper_magazine_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                magazine_default =  {model = "",                                                                            type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_01 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_01",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_02 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_02",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_03 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_03",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_04 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_04",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_05 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_05",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_06 =       {model = "content/items/weapons/player/ranged/magazines/rippergun_rifle_magazine_06",   type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
            }
        end
        local _ripper_handle_attachments = function()
            return {
                {id = "handle_default", name = "Default",   sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "handle_01",      name = "Handle 1",  sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "handle_02",      name = "Handle 2",  sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "handle_03",      name = "Handle 3",  sounds = {UISoundEvents.smart_tag_hud_default}},
                {id = "handle_04",      name = "Handle 4",  sounds = {UISoundEvents.smart_tag_hud_default}},
            }
        end
        local _ripper_handle_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                handle_default =    {model = "",                                                                        type = "handle", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                handle_01 =         {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_01",   type = "handle", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                handle_02 =         {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_02",   type = "handle", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                handle_03 =         {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_03",   type = "handle", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                handle_04 =         {model = "content/items/weapons/player/ranged/handles/rippergun_rifle_handle_04",   type = "handle", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
            }
        end
        local _thumper_grip_attachments = function()
            return {
                {id = "grip_default",   name = "Default",   sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "grip_01",        name = "Grip 1",    sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "grip_02",        name = "Grip 2",    sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "grip_03",        name = "Grip 3",    sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "grip_04",        name = "Grip 4",    sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "grip_05",        name = "Grip 5",    sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _thumper_grip_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                grip_default =  {model = "",                                                                    type = "grip", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                grip_01 =       {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_01",   type = "grip", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                grip_02 =       {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_02",   type = "grip", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                grip_03 =       {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_03",   type = "grip", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                grip_04 =       {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_04",   type = "grip", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
                grip_05 =       {model = "content/items/weapons/player/ranged/grips/shotgun_grenade_grip_05",   type = "grip", parent = tv(parent, 6), angle = angle, move = move, remove = tv(remove, 6)},
            }
        end
        local _thumper_sight_attachments = function()
            return {
                {id = "sight_default",  name = "Default", sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "sight_01",       name = "Sight 1", sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "sight_02",       name = "No Sight", sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "sight_03",       name = "Sight 3", sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "sight_04",       name = "Sight 4", sounds = {UISoundEvents.weapons_trinket_select}},
            }
        end
        local _thumper_sight_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                sight_default = {model = "",                                                                    type = "sight", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                sight_01 =      {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_01", type = "sight", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                sight_02 =      {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_02", type = "sight", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                sight_03 =      {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_03", type = "sight", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                sight_04 =      {model = "content/items/weapons/player/ranged/sights/shotgun_grenade_sight_04", type = "sight", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
            }
        end
        local _thumper_body_attachments = function()
            return {
                {id = "body_default", name = "Default", sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_01",      name = "Body 1",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_02",      name = "Body 2",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_03",      name = "Body 3",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_04",      name = "Body 4",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_05",      name = "Body 5",  sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _thumper_body_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                body_default = {model = "",                                                                type = "body", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                body_01 =      {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_01", type = "body", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                body_02 =      {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_02", type = "body", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                body_03 =      {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_03", type = "body", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                body_04 =      {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_04", type = "body", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
                body_05 =      {model = "content/items/weapons/player/melee/full/shotgun_grenade_full_05", type = "body", parent = tv(parent, 6), angle = angle, move = move, remove = tv(remove, 6)},
            }
        end
        local _gauntlet_barrel_attachments = function()
            return {
                {id = "barrel_default", name = "Default",  sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_01",      name = "Barrel 1", sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_02",      name = "Barrel 2", sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_03",      name = "Barrel 3", sounds = {UISoundEvents.talents_equip_talent}},
                {id = "barrel_04",      name = "Barrel 4", sounds = {UISoundEvents.talents_equip_talent}},
            }
        end
        local _gauntlet_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default = {model = "",                                                                     type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1), no_mesh_move = "both"},
                barrel_01 =      {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_01", type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2), no_mesh_move = "both"},
                barrel_02 =      {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_02", type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3), no_mesh_move = "both"},
                barrel_03 =      {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_03", type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4), no_mesh_move = "both"},
                barrel_04 =      {model = "content/items/weapons/player/ranged/barrels/gauntlet_basic_barrel_04", type = "barrel", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5), no_mesh_move = "both"},
            }
        end
        local _gauntlet_body_attachments = function()
            return {
                {id = "body_default", name = "Default", sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_01",      name = "Body 1",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_02",      name = "Body 2",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_03",      name = "Body 3",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "body_04",      name = "Body 4",  sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _gauntlet_body_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                body_default = {model = "",                                                                         type = "body", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                body_01 =      {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_01", type = "body", parent = tv(parent, 2), angle = angle, move = move, remove = tv(remove, 2)},
                body_02 =      {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_02", type = "body", parent = tv(parent, 3), angle = angle, move = move, remove = tv(remove, 3)},
                body_03 =      {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_03", type = "body", parent = tv(parent, 4), angle = angle, move = move, remove = tv(remove, 4)},
                body_04 =      {model = "content/items/weapons/player/ranged/recievers/gauntlet_basic_receiver_04", type = "body", parent = tv(parent, 5), angle = angle, move = move, remove = tv(remove, 5)},
            }
        end
        local _gauntlet_magazine_attachments = function()
            return {
                {id = "magazine_default", name = "Default",    sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_01",      name = "Magazine 1", sounds = {UISoundEvents.weapons_trinket_select}},
                {id = "magazine_02",      name = "Magazine 2", sounds = {UISoundEvents.weapons_trinket_select}},
            }
        end
        local _gauntlet_magazine_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                magazine_default = {model = "",                                                                         type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_01 =      {model = "content/items/weapons/player/ranged/magazines/gauntlet_basic_magazine_01", type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
                magazine_02 =      {model = "content/items/weapons/player/ranged/magazines/gauntlet_basic_magazine_02", type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = tv(remove, 1)},
            }
        end
    --#endregion
    --#region Lasguns
        local _lasgun_barrel_attachments = function()
            return {
                {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "barrel_01", name = "Infantry Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_02", name = "Infantry Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_03", name = "Infantry Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_04", name = "Infantry Lasgun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_05", name = "Infantry Lasgun 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_06", name = "Infantry Lasgun 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_07", name = "Infantry Lasgun 7", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_08", name = "Infantry Lasgun 8", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_09", name = "Helbore Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_10", name = "Helbore Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_11", name = "Helbore Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_12", name = "Helbore Lasgun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_13", name = "Helbore Lasgun 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_14", name = "Recon Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_15", name = "Recon Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_16", name = "Recon Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_17", name = "Recon Lasgun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_18", name = "Recon Lasgun 5", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _lasgun_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                            type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                barrel_01 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_01",          type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                barrel_02 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_02",          type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                barrel_03 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_03",          type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                barrel_04 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_04",          type = "barrel", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                barrel_05 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_05",          type = "barrel", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                barrel_06 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_06",          type = "barrel", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
                barrel_07 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_07",          type = "barrel", parent = tv(parent, 8), angle = angle, move = move, remove = remove},
                barrel_08 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_barrel_08",          type = "barrel", parent = tv(parent, 9), angle = angle, move = move, remove = remove},
                barrel_09 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_krieg_barrel_01",    type = "barrel", parent = tv(parent, 10), angle = angle, move = move, remove = remove},
                barrel_10 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_krieg_barrel_02",    type = "barrel", parent = tv(parent, 11), angle = angle, move = move, remove = remove},
                barrel_11 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_krieg_barrel_04",    type = "barrel", parent = tv(parent, 12), angle = angle, move = move, remove = remove},
                barrel_12 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_krieg_barrel_05",    type = "barrel", parent = tv(parent, 13), angle = angle, move = move, remove = remove},
                barrel_13 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_krieg_barrel_06",    type = "barrel", parent = tv(parent, 14), angle = angle, move = move, remove = remove},
                barrel_14 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_elysian_barrel_01",  type = "barrel", parent = tv(parent, 15), angle = angle, move = move, remove = remove},
                barrel_15 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_elysian_barrel_02",  type = "barrel", parent = tv(parent, 16), angle = angle, move = move, remove = remove},
                barrel_16 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_elysian_barrel_03",  type = "barrel", parent = tv(parent, 17), angle = angle, move = move, remove = remove},
                barrel_17 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_elysian_barrel_04",  type = "barrel", parent = tv(parent, 18), angle = angle, move = move, remove = remove},
                barrel_18 =         {model = "content/items/weapons/player/ranged/barrels/lasgun_rifle_elysian_barrel_05",  type = "barrel", parent = tv(parent, 19), angle = angle, move = move, remove = remove},
            }
        end
        local _lasgun_muzzle_attachments = function()
            return {
                {id = "muzzle_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "muzzle_01", name = "Infantry Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_02", name = "Infantry Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_03", name = "Infantry Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_04", name = "Helbore Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_05", name = "Helbore Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_06", name = "Helbore Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_07", name = "Recon Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_08", name = "Recon Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_09", name = "Recon Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _lasgun_muzzle_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                muzzle_default =    {model = "",                                                                            type = "muzzle", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                muzzle_01 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_muzzle_01",          type = "muzzle", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                muzzle_02 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_muzzle_02",          type = "muzzle", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                muzzle_03 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_muzzle_03",          type = "muzzle", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                muzzle_04 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_02",    type = "muzzle", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                muzzle_05 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_04",    type = "muzzle", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                muzzle_06 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_krieg_muzzle_05",    type = "muzzle", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
                muzzle_07 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_elysian_muzzle_01",  type = "muzzle", parent = tv(parent, 8), angle = angle, move = move, remove = remove},
                muzzle_08 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_elysian_muzzle_02",  type = "muzzle", parent = tv(parent, 9), angle = angle, move = move, remove = remove},
                muzzle_09 =         {model = "content/items/weapons/player/ranged/muzzles/lasgun_rifle_elysian_muzzle_03",  type = "muzzle", parent = tv(parent, 10), angle = angle, move = move, remove = remove},
            }
        end
        local _lasgun_rail_attachments = function()
            return {
                {id = "rail_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "rail_01", name = "Rail 1", sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _lasgun_rail_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                rail_default =  {model = "",                                                                type = "rail", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                rail_01 =       {model = "content/items/weapons/player/ranged/rails/lasgun_rifle_rail_01",  type = "rail", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
            }
        end
        local _laspistol_receiver_attachments = function()
            return {
                {id = "laspistol_receiver_default", name = "Default",               sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "laspistol_receiver_01",      name = "Laspistol Receiver 1",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "laspistol_receiver_02",      name = "Laspistol Receiver 2",  sounds = {UISoundEvents.weapons_equip_weapon}},
                {id = "laspistol_receiver_03",      name = "Laspistol Receiver 3",  sounds = {UISoundEvents.weapons_equip_weapon}},
            }
        end
        local _laspistol_receiver_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                laspistol_receiver_default =    {model = "",                                                                        type = "receiver", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                laspistol_receiver_01 =         {model = "content/items/weapons/player/ranged/recievers/lasgun_pistol_receiver_01", type = "receiver", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                laspistol_receiver_02 =         {model = "content/items/weapons/player/ranged/recievers/lasgun_pistol_receiver_02", type = "receiver", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                laspistol_receiver_03 =         {model = "content/items/weapons/player/ranged/recievers/lasgun_pistol_receiver_03", type = "receiver", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
            }
        end
    --#endregion
    --#region Autoguns
        local _autogun_braced_barrel_attachments = function()
            return {
                {id = "barrel_07", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_08", name = "Braced Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_09", name = "Braced Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_10", name = "Braced Autogun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _autogun_braced_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                        type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                barrel_07 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_ak_01",  type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                barrel_08 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_ak_02",  type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                barrel_09 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_ak_03",  type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                barrel_10 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_ak_04",  type = "barrel", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
            }
        end
        local _autogun_headhunter_barrel_attachments = function()
            return {
                {id = "barrel_11", name = "Headhunter Autogun 11", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_12", name = "Headhunter Autogun 12", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _autogun_headhunter_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                                type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                barrel_11 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_killshot_01",    type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                barrel_12 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_killshot_03",    type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
            }
        end
        local _autogun_barrel_attachments = function()
            return {
                {id = "barrel_01", name = "Infantry Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_02", name = "Infantry Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_03", name = "Infantry Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_04", name = "Infantry Autogun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_05", name = "Infantry Autogun 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "barrel_06", name = "Infantry Autogun 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_07", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_08", name = "Braced Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_09", name = "Braced Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_10", name = "Braced Autogun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_11", name = "Headhunter Autogun 11", sounds = {UISoundEvents.weapons_equip_gadget}},
                -- {id = "barrel_12", name = "Headhunter Autogun 12", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _autogun_barrel_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                barrel_default =    {model = "",                                                                    type = "barrel", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                barrel_01 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_01", type = "barrel", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                barrel_02 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_02", type = "barrel", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                barrel_03 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_03", type = "barrel", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                barrel_04 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_04", type = "barrel", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                barrel_05 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_05", type = "barrel", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                barrel_06 =         {model = "content/items/weapons/player/ranged/barrels/autogun_rifle_barrel_06", type = "barrel", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
            }
        end
        local _autogun_muzzle_attachments = function()
            return {
                {id = "muzzle_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "muzzle_01", name = "Infantry Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_02", name = "Infantry Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_03", name = "Infantry Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_04", name = "Infantry Autogun 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_05", name = "Infantry Autogun 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_06", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_07", name = "Braced Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_08", name = "Braced Autogun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_09", name = "Headhunter Autogun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                {id = "muzzle_10", name = "Headhunter Autogun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
            }
        end
        local _autogun_muzzle_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                muzzle_default =    {model = "",                                                                                type = "muzzle", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                muzzle_01 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_muzzle_01",             type = "muzzle", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                muzzle_02 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_muzzle_02",             type = "muzzle", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                muzzle_03 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_muzzle_03",             type = "muzzle", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                muzzle_04 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_muzzle_04",             type = "muzzle", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
                muzzle_05 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_muzzle_05",             type = "muzzle", parent = tv(parent, 6), angle = angle, move = move, remove = remove},
                muzzle_06 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_ak_muzzle_01",          type = "muzzle", parent = tv(parent, 7), angle = angle, move = move, remove = remove},
                muzzle_07 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_ak_muzzle_02",          type = "muzzle", parent = tv(parent, 8), angle = angle, move = move, remove = remove},
                muzzle_08 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_ak_muzzle_03",          type = "muzzle", parent = tv(parent, 9), angle = angle, move = move, remove = remove},
                muzzle_09 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_killshot_muzzle_01",    type = "muzzle", parent = tv(parent, 10), angle = angle, move = move, remove = remove},
                muzzle_10 =         {model = "content/items/weapons/player/ranged/muzzles/autogun_rifle_killshot_muzzle_03",    type = "muzzle", parent = tv(parent, 11), angle = angle, move = move, remove = remove},
            }
        end
        local _autogun_magazine_attachments = function()
            return {
                {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                {id = "magazine_01", name = "Autogun 1", sounds = {UISoundEvents.apparel_equip}},
                {id = "magazine_02", name = "Autogun 2", sounds = {UISoundEvents.apparel_equip}},
                {id = "magazine_03", name = "Autogun 3", sounds = {UISoundEvents.apparel_equip}},
                {id = "magazine_04", name = "Braced Autogun 4", sounds = {UISoundEvents.apparel_equip}},
            }
        end
        local _autogun_magazine_models = function(parent, angle, move, remove)
            local angle = angle or 0
            local move = move or Vector3Box(0, 0, 0)
            local remove = remove or Vector3Box(0, 0, 0)
            return {
                magazine_default =  {model = "",                                                                            type = "magazine", parent = tv(parent, 1), angle = angle, move = move, remove = remove},
                magazine_01 =       {model = "content/items/weapons/player/ranged/magazines/autogun_rifle_magazine_01",     type = "magazine", parent = tv(parent, 2), angle = angle, move = move, remove = remove},
                magazine_02 =       {model = "content/items/weapons/player/ranged/magazines/autogun_rifle_magazine_02",     type = "magazine", parent = tv(parent, 3), angle = angle, move = move, remove = remove},
                magazine_03 =       {model = "content/items/weapons/player/ranged/magazines/autogun_rifle_magazine_03",     type = "magazine", parent = tv(parent, 4), angle = angle, move = move, remove = remove},
                magazine_04 =       {model = "content/items/weapons/player/ranged/magazines/autogun_rifle_ak_magazine_01",  type = "magazine", parent = tv(parent, 5), angle = angle, move = move, remove = remove},
            }
        end
        local _autogun_receiver_attachments = function()
            return {

            }
        end
    --#endregion
    --#region Melee
        local _axe_grip_attachments = function()
            return {
                {id = "axe_grip_01", name = "Combat Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_grip_02", name = "Combat Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_grip_03", name = "Combat Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_grip_04", name = "Combat Axe 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_grip_05", name = "Combat Axe 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "axe_grip_06", name = "Combat Axe 6", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_01", name = "Tactical Axe 1", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_02", name = "Tactical Axe 2", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_03", name = "Tactical Axe 3", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_04", name = "Tactical Axe 4", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_05", name = "Tactical Axe 5", sounds = {UISoundEvents.weapons_swap}},
                {id = "hatchet_grip_06", name = "Tactical Axe 6", sounds = {UISoundEvents.weapons_swap}},
            }
        end
        local _axe_grip_models = function()
            return {
                grip_default = {model = "", type = "grip"},
                axe_grip_01 = {model = "content/items/weapons/player/melee/grips/axe_grip_01", type = "grip"},
                axe_grip_02 = {model = "content/items/weapons/player/melee/grips/axe_grip_02", type = "grip"},
                axe_grip_03 = {model = "content/items/weapons/player/melee/grips/axe_grip_03", type = "grip"},
                axe_grip_04 = {model = "content/items/weapons/player/melee/grips/axe_grip_04", type = "grip"},
                axe_grip_05 = {model = "content/items/weapons/player/melee/grips/axe_grip_05", type = "grip"},
                axe_grip_06 = {model = "content/items/weapons/player/melee/grips/axe_grip_06", type = "grip"},
                hatchet_grip_01 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_01", type = "grip"},
                hatchet_grip_02 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_02", type = "grip"},
                hatchet_grip_03 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_03", type = "grip"},
                hatchet_grip_04 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_04", type = "grip"},
                hatchet_grip_05 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_05", type = "grip"},
                hatchet_grip_06 = {model = "content/items/weapons/player/melee/grips/hatchet_grip_06", type = "grip"},
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
                head_default = {model = "", type = "head"},
                axe_head_01 = {model = "content/items/weapons/player/melee/heads/axe_head_01", type = "head"},
                axe_head_02 = {model = "content/items/weapons/player/melee/heads/axe_head_02", type = "head"},
                axe_head_03 = {model = "content/items/weapons/player/melee/heads/axe_head_03", type = "head"},
                axe_head_04 = {model = "content/items/weapons/player/melee/heads/axe_head_04", type = "head"},
                axe_head_05 = {model = "content/items/weapons/player/melee/heads/axe_head_05", type = "head"},
                hatchet_head_01 = {model = "content/items/weapons/player/melee/heads/hatchet_head_01", type = "head"},
                hatchet_head_02 = {model = "content/items/weapons/player/melee/heads/hatchet_head_02", type = "head"},
                hatchet_head_03 = {model = "content/items/weapons/player/melee/heads/hatchet_head_03", type = "head"},
                hatchet_head_04 = {model = "content/items/weapons/player/melee/heads/hatchet_head_04", type = "head"},
                hatchet_head_05 = {model = "content/items/weapons/player/melee/heads/hatchet_head_05", type = "head"},
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
                shovel_pommel_01 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_01", type = "pommel"},
                shovel_pommel_02 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_02", type = "pommel"},
                shovel_pommel_03 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_03", type = "pommel"},
                shovel_pommel_04 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_04", type = "pommel"},
                shovel_pommel_05 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_05", type = "pommel"},
                power_maul_pommel_01 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_01", type = "pommel"},
                power_maul_pommel_02 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_02", type = "pommel"},
                power_maul_pommel_03 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_03", type = "pommel"},
                power_maul_pommel_04 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_04", type = "pommel"},
                power_maul_pommel_05 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_05", type = "pommel"},
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
                pommel_default = {model = "", type = "pommel"},
                axe_pommel_01 = {model = "content/items/weapons/player/melee/pommels/axe_pommel_01", type = "pommel"},
                axe_pommel_02 = {model = "content/items/weapons/player/melee/pommels/axe_pommel_02", type = "pommel"},
                axe_pommel_03 = {model = "content/items/weapons/player/melee/pommels/axe_pommel_03", type = "pommel"},
                axe_pommel_04 = {model = "content/items/weapons/player/melee/pommels/axe_pommel_04", type = "pommel"},
                axe_pommel_05 = {model = "content/items/weapons/player/melee/pommels/axe_pommel_05", type = "pommel"},
                hatchet_pommel_01 = {model = "content/items/weapons/player/melee/pommels/hatchet_pommel_01", type = "pommel"},
                hatchet_pommel_02 = {model = "content/items/weapons/player/melee/pommels/hatchet_pommel_02", type = "pommel"},
                hatchet_pommel_03 = {model = "content/items/weapons/player/melee/pommels/hatchet_pommel_03", type = "pommel"},
                hatchet_pommel_04 = {model = "content/items/weapons/player/melee/pommels/hatchet_pommel_04", type = "pommel"},
            }
        end
    --#endregion
--#endregion

--#region Anchors
    mod.anchors = {
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = { -- Done 5.9.2023
                flashlight_01 =    {position = Vector3Box(.09, .9, .13), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_02 =    {position = Vector3Box(.09, .9, .13), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_03 =    {position = Vector3Box(.09, .9, .13), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_04 =    {position = Vector3Box(.15, .86, .21), rotation = Vector3Box(0, 128, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_blade_01 = {position = Vector3Box(0, 1.04, -0.39), rotation = Vector3Box(-90, 0, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_01 =       {position = Vector3Box(0, 1.08, -0.36), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_02 =       {position = Vector3Box(0, 1.08, -0.36), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_03 =       {position = Vector3Box(0, 1.08, -0.36), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                fixes = {
                    {emblem_left = {offset = true, position = Vector3Box(-.09, .42, .085), rotation = Vector3Box(0, 0, 180), scale = Vector3Box(2, 2, 2)}}, -- Emblem left
                }
            },
            ogryn_rippergun_p1_m1 = { -- Done 8.9.2023
                flashlight_01 =    {position = Vector3Box(.09, .76, .35), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_02 =    {position = Vector3Box(.09, .76, .35), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_03 =    {position = Vector3Box(.09, .76, .35), rotation = Vector3Box(0, 311, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_04 =    {position = Vector3Box(.16, .76, .41), rotation = Vector3Box(0, 128, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_blade_01 = {position = Vector3Box(0, .45, 0.025), rotation = Vector3Box(-90, 0, 0), scale = Vector3Box(2, 2, 2)},
                fixes = {
                    {dependencies = {"receiver_02"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(-.145, .3, .27), rotation = Vector3Box(0, 0, 180), scale = Vector3Box(3, 3, 3)},
                        emblem_right = {offset = true, position = Vector3Box(.145, .615, .27), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(3, 3, 3)}},
                    {dependencies = {"receiver_03"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(.0047, 0, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(.0047, 0, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"receiver_06"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(0, 0, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1.5, 1.5, 1.5)},
                        emblem_right = {offset = true, position = Vector3Box(.06, 0, .05), rotation = Vector3Box(0, -20, 0), scale = Vector3Box(2, 2, 2)}},
                }
            },
            ogryn_thumper_p1_m1 = { -- Done 8.9.2023
                flashlight_01 =    {position = Vector3Box(.12, .33, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_02 =    {position = Vector3Box(.12, .33, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_03 =    {position = Vector3Box(.12, .33, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_04 =    {position = Vector3Box(.12, .33, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_blade_01 = {position = Vector3Box(0, .8, 0.065), rotation = Vector3Box(-90, 0, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_01 =       {position = Vector3Box(0, .9, 0.07), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_02 =       {position = Vector3Box(0, .9, 0.07), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_03 =       {position = Vector3Box(0, .9, 0.07), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                fixes = {
                    {emblem_left = {offset = true, position = Vector3Box(-.12, .22, .11), rotation = Vector3Box(0, 0, 180), scale = Vector3Box(2, 2, 2)}, -- Emblems
                        emblem_right = {offset = true, position = Vector3Box(.123, .765, .11), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(2, 2, 2)}},
                }
            },
            ogryn_gauntlet_p1_m1 = { -- Done 8.9.2023
                flashlight_01 =    {position = Vector3Box(.2, .18, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_02 =    {position = Vector3Box(.2, .18, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_03 =    {position = Vector3Box(.2, .18, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                flashlight_04 =    {position = Vector3Box(.2, .18, .11), rotation = Vector3Box(0, 360, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_blade_01 = {position = Vector3Box(0, .4, -0.27), rotation = Vector3Box(-90, 0, 0), scale = Vector3Box(2, 2, 2)},
                bayonet_01 =       {position = Vector3Box(0, .4, -0.27), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_02 =       {position = Vector3Box(0, .4, -0.27), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                bayonet_03 =       {position = Vector3Box(0, .4, -0.27), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                fixes = {
                    {dependencies = {"barrel_01"}, -- Trinket hook
                        trinket_hook = {parent = "barrel", position = Vector3Box(-.19, .375, -.08), rotation = Vector3Box(0, 90, 0), scale = Vector3Box(2.5, 2.5, 2.5)}},
                    {dependencies = {"barrel_02"}, -- Trinket hook
                        trinket_hook = {parent = "barrel", position = Vector3Box(-.19, .375, -.04), rotation = Vector3Box(0, 90, 0), scale = Vector3Box(2.5, 2.5, 2.5)}},
                    {dependencies = {"barrel_03"}, -- Trinket hook
                        trinket_hook = {parent = "barrel", position = Vector3Box(-.19, .375, -.08), rotation = Vector3Box(0, 90, 0), scale = Vector3Box(2.5, 2.5, 2.5)}},
                    {dependencies = {"barrel_04"}, -- Trinket hook
                        trinket_hook = {parent = "barrel", position = Vector3Box(-.19, .375, -.08), rotation = Vector3Box(0, 90, 0), scale = Vector3Box(2.5, 2.5, 2.5)}},
                    {emblem_left = {offset = true, position = Vector3Box(.001, 0, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}, -- Emblems
                        emblem_right = {offset = true, position = Vector3Box(.001, 0, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                }
            },
        --#endregion
        --#region Ogryn Melee
            ogryn_powermaul_slabshield_p1_m1 = {
                ["bulwark_shield_01"] = {
                    position = Vector3Box(0, 0, 0),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                    preview_only = true,
                },
            },
        --#endregion
        --#region Guns
            autopistol_p1_m1 = {
                ["autogun_rifle_stock_01"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_02"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_03"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_04"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_01"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_02"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_03"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_04"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_05"] = {
                    position = Vector3Box(0, -0.095, 0.065),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_bayonet_01"] = {
                    position = Vector3Box(0, 0.27, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_bayonet_02"] = {
                    position = Vector3Box(0, 0.27, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_bayonet_03"] = {
                    position = Vector3Box(-0.03, 0.12, 0.09),
                    rotation = Vector3Box(0, 90, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                -- ["fixes"] = {
                --     ["8"] = {
                --         ["barrel_03"] = {
                --             ["barrel_03"] = {
                --                 position = Vector3Box(0, 0.16, -.02),
                --                 rotation = Vector3Box(-30, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --     }
                -- }
            },
            shotgun_p1_m1 = {
                ["flashlight_01"] = {
                    position = Vector3Box(.045, .55, .06),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_02"] = {
                    position = Vector3Box(.045, .55, .06),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_03"] = {
                    position = Vector3Box(.045, .55, .06),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_04"] = {
                    position = Vector3Box(.045, .55, .06),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
            },
            bolter_p1_m1 = {
                ["flashlight_01"] = {
                    position = Vector3Box(.045, .3, .1),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_02"] = {
                    position = Vector3Box(.045, .3, .1),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_03"] = {
                    position = Vector3Box(.045, .3, .1),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_04"] = {
                    position = Vector3Box(.045, .3, .1),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_01"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_02"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_03"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_04"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_01"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_02"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_03"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_04"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_05"] = {
                    position = Vector3Box(0, -0.1, 0.08),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
            },
            stubrevolver_p1_m1 = {
                ["flashlight_01"] = {
                    position = Vector3Box(.01, .07, .01),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.5, .5, .5),
                },
                ["flashlight_02"] = {
                    position = Vector3Box(.01, .07, .01),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.5, .5, .5),
                },
                ["flashlight_03"] = {
                    position = Vector3Box(.01, .07, .01),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.5, .5, .5),
                },
                ["flashlight_04"] = {
                    position = Vector3Box(.01, .07, .01),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.5, .5, .5),
                },
                ["autogun_rifle_stock_02"] = {
                    position = Vector3Box(0, -0.055, 0.035),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.85, .85, .85),
                },
                ["autogun_rifle_stock_04"] = {
                    position = Vector3Box(0, -0.055, 0.035),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.85, .85, .85),
                },
                ["stock_05"] = {
                    position = Vector3Box(0, -0.055, 0.035),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(.85, .85, .85),
                },
            },
            plasmagun_p1_m1 = {
                ["autogun_rifle_stock_01"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_02"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_03"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["autogun_rifle_stock_04"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_01"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_02"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_03"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_04"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["stock_05"] = {
                    position = Vector3Box(0, -0.085, 0.045),
                    rotation = Vector3Box(0, 0, 0),
                    scale = Vector3Box(1, 1, 1),
                },
            },
            laspistol_p1_m1 = {
                flashlight_01 =             {position = Vector3Box(.03, .16, .035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                flashlight_02 =             {position = Vector3Box(.03, .16, .035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                flashlight_03 =             {position = Vector3Box(.03, .16, .035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                flashlight_04 =             {position = Vector3Box(.03, .16, .035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                autogun_rifle_stock_02 =    {position = Vector3Box(0, -0.09, 0.035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(.85, 1, .75)},
                autogun_rifle_stock_04 =    {position = Vector3Box(0, -0.09, 0.035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(.85, 1, .75)},
                stock_05 =                  {position = Vector3Box(0, -0.09, 0.035), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(.85, 1, .75)},
                autogun_bayonet_01 =        {position = Vector3Box(0, .14, -.033), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                autogun_bayonet_02 =        {position = Vector3Box(0, .14, -.033), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                autogun_bayonet_03 =        {position = Vector3Box(0, .05, -.033), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                fixes = {
                    {dependencies = {"laspistol_receiver_01", "barrel_02"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(.0025, 0, .007), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(.0025, 0, .007), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"laspistol_receiver_01", "barrel_03"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(-.005, .1, .05), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(-.005, .1, .05), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"laspistol_receiver_01", "barrel_04"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(-.005, .1, .05), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(-.005, .1, .05), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"laspistol_receiver_02", "!barrel_02"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(0, -.03, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(0, -.03, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"laspistol_receiver_02", "barrel_06"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(.001, -.025, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)},
                        emblem_right = {offset = true, position = Vector3Box(.001, -.025, 0), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                    {dependencies = {"laspistol_receiver_02", "barrel_04"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(-.005, -.08, .02), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(.5, .5, .5)},
                        emblem_right = {offset = true, position = Vector3Box(-.005, -.08, .02), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(.5, .5, .5)}},
                    {dependencies = {"laspistol_receiver_02", "barrel_05"}, -- Emblems
                        emblem_left = {offset = true, position = Vector3Box(-.005, -.08, .02), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(.5, .5, .5)},
                        emblem_right = {offset = true, position = Vector3Box(-.005, -.08, .02), rotation = Vector3Box(0, -25, 0), scale = Vector3Box(.5, .5, .5)}},
                    {dependencies = {"muzzle_03", "autogun_bayonet_03"}, -- Bayonet 3
                        bayonet = {offset = true, position = Vector3Box(0, .065, -.03), rotation = Vector3Box(0, 0, 0), scale = Vector3Box(1, 1, 1)}},
                },
            },
            autogun_p1_m1 = {
                ["scope_offset"] = Vector3Box(0, 0, .0125),
                -- ["fixes"] = {
                --     ["4"] = {
                --         ["receiver_01"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_02"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_03"] = {
                --             ["barrel_01"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_02"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_03"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_04"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_05"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_06"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_11"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_12"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --     },
                -- }
            },
            autogun_p2_m1 = {
                -- ["fixes"] = {
                --     ["3"] = {
                --         ["receiver_01"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_02"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_03"] = {
                --             ["barrel_01"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_02"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_03"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_04"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_05"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_06"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_11"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_12"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --     },
                -- }
            },
            autogun_p3_m1 = {
                ["scope_offset"] = Vector3Box(0, 0, .0125),
                -- ["fixes"] = {
                --     ["3"] = {
                --         ["receiver_01"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_02"] = {
                --             ["barrel_07"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_08"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_09"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_10"] = {
                --                 position = Vector3Box(0, .25, .048),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["receiver_03"] = {
                --             ["barrel_01"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_02"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_03"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_04"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_05"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_06"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_11"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --             ["barrel_12"] = {
                --                 position = Vector3Box(0, .175, .077),
                --                 rotation = Vector3Box(0, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --     },
                -- }
            },
            lasgun_p1_m1 = {
                ["no_scope_offset"] = Vector3Box(0, 0, -.0455),
                -- ["fixes"] = {
                --     ["6"] = {
                --         ["barrel_17"] = {
                --             ["barrel_17"] = {
                --                 position = Vector3Box(0, 0.325, -.03),
                --                 rotation = Vector3Box(-30, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --         ["barrel_18"] = {
                --             ["barrel_18"] = {
                --                 position = Vector3Box(0, 0.325, -.03),
                --                 rotation = Vector3Box(-30, 0, 0),
                --                 scale = Vector3Box(1, 1, 1),
                --             },
                --         },
                --     }
                -- }
            },
            lasgun_p2_m1 = {
                ["scope_offset"] = Vector3Box(0, 0, .0275),
            },
            lasgun_p3_m1 = {
                ["scope_offset"] = Vector3Box(0, 0, .0275),
                -- ["fixes"] = {
                --     ["autogun_bayonet_01"] = {
                --         ["muzzle_07"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_08"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_09"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --     },
                --     ["autogun_bayonet_02"] = {
                --         ["muzzle_07"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_08"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_09"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --     },
                --     ["autogun_bayonet_03"] = {
                --         ["muzzle_07"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_08"] = {
                --             position = Vector3Box(0, .65, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --         ["muzzle_09"] = {
                --             position = Vector3Box(0, .63, .05),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, 1, 1),
                --         },
                --     },
                --     ["rail_01"] = {
                --         ["receiver_01"] = {
                --             position = Vector3Box(0, .039, .185),
                --             rotation = Vector3Box(0, 0, 0),
                --             scale = Vector3Box(1, .96, 1),
                --         },
                --     },
                -- }
            },
            flamer_p1_m1 = {
                ["flashlight_01"] = {
                    position = Vector3Box(.04075, .42, 0),
                    rotation = Vector3Box(0, 45, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_02"] = {
                    position = Vector3Box(.04075, .42, 0),
                    rotation = Vector3Box(0, 45, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_03"] = {
                    position = Vector3Box(.04075, .42, 0),
                    rotation = Vector3Box(0, 45, 0),
                    scale = Vector3Box(1, 1, 1),
                },
                ["flashlight_04"] = {
                    position = Vector3Box(.04075, .42, 0),
                    rotation = Vector3Box(0, 45, 0),
                    scale = Vector3Box(1, 1, 1),
                },
            },
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
        --#region Guns
            mod.anchors.shotgun_p1_m2 = mod.anchors.shotgun_p1_m1
            mod.anchors.shotgun_p1_m3 = mod.anchors.shotgun_p1_m1
            mod.anchors.autogun_p1_m2 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p1_m3 = mod.anchors.autogun_p1_m1
            mod.anchors.autogun_p2_m2 = mod.anchors.autogun_p2_m1
            mod.anchors.autogun_p2_m3 = mod.anchors.autogun_p2_m1
            mod.anchors.autogun_p3_m2 = mod.anchors.autogun_p3_m1
            mod.anchors.autogun_p3_m3 = mod.anchors.autogun_p3_m1
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
            ogryn_heavystubber_p1_m1 = { -- Done 5.9.2023
                flashlight = _flashlights_attachments(),
                bayonet = _ogryn_bayonet_attachments(),
                barrel = _stubber_barrel_attachments(),
                receiver = _stubber_receiver_attachments(),
                magazine = _stubber_magazine_attachments(),
                grip = _stubber_grip_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                trinket_hook = _trinket_hook_attachments(),
            },
            ogryn_rippergun_p1_m1 = { -- Done 8.9.2023
                flashlight = _flashlights_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                bayonet = _ogryn_bayonet_attachments(),
                barrel = _ripper_barrel_attachments(),
                receiver = _ripper_receiver_attachments(),
                magazine = _ripper_magazine_attachments(),
                handle = _ripper_handle_attachments(),
                trinket_hook = _trinket_hook_attachments(),
            },
            ogryn_thumper_p1_m1 = { -- Done 8.9.2023
                flashlight = _flashlights_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                bayonet = _ogryn_bayonet_attachments(),
                sight = _thumper_sight_attachments(),
                grip = _thumper_grip_attachments(),
                body = _thumper_body_attachments(),
                trinket_hook = _trinket_hook_attachments(),
            },
            ogryn_gauntlet_p1_m1 = { -- Done 8.9.2023
                flashlight = _flashlights_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                bayonet = _ogryn_bayonet_attachments(),
                barrel = _gauntlet_barrel_attachments(),
                body = _gauntlet_body_attachments(),
                magazine = _gauntlet_magazine_attachments(),
                trinket_hook = _trinket_hook_attachments(),
            },
        --#endregion
        --#region Ogryn Melee
            ogryn_club_p1_m1 = {
                grip = {
                    {id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                head = {
                    {id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "head_01", name = "Head 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_02", name = "Head 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_03", name = "Head 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_04", name = "Head 4", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_05", name = "Head 5", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            ogryn_combatblade_p1_m1 = {
                blade = {
                    {id = "blade_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "blade_01", name = "Blade 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "blade_02", name = "Blade 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "blade_03", name = "Blade 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "blade_04", name = "Blade 4", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "blade_05", name = "Blade 5", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "blade_06", name = "Blade 6", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                },
                grip = {
                    {id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_04", name = "Grip 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_05", name = "Grip 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_06", name = "Grip 6", sounds = {UISoundEvents.weapons_swap}},
                },
                handle = {
                    {id = "handle_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "handle_01", name = "Handle 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "handle_02", name = "Handle 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "handle_03", name = "Handle 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "handle_04", name = "Handle 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "handle_05", name = "Handle 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "handle_06", name = "Handle 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            ogryn_powermaul_p1_m1 = {
                shaft = {
                    {id = "shaft_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                head = {
                    {id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "head_01", name = "Head 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_02", name = "Head 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_03", name = "Head 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_04", name = "Head 4", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_05", name = "Head 5", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                },
                pommel = {
                    {id = "pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            ogryn_powermaul_slabshield_p1_m1 = {
                shaft = {
                    {id = "shaft_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shaft_01", name = "Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_02", name = "Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_03", name = "Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_04", name = "Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_05", name = "Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                head = {
                    {id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "head_01", name = "Head 1", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_02", name = "Head 2", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_03", name = "Head 3", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_04", name = "Head 4", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                    {id = "head_05", name = "Head 5", sounds = {UISoundEvents.end_screen_summary_plasteel_zero}},
                },
                pommel = {
                    {id = "pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                left = {
                    {id = "left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "left_01", name = "Shield 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "bulwark_shield_01", name = "Shield 2", sounds = {UISoundEvents.weapons_swap}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            ogryn_club_p2_m1 = {
                body = {
                    {id = "body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "body_02", name = "Body 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "body_03", name = "Body 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "body_04", name = "Body 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "body_05", name = "Body 5", sounds = {UISoundEvents.weapons_swap}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
        --#endregion
        --#region Guns
            autopistol_p1_m1 = {
                flashlight = _flashlights_attachments(),
                trinket_hook = _trinket_hook_attachments(),
                grip = _grip_attachments(),
                stock = _stock_attachments(),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                    -- {id = "receiver_04", name = "Receiver 4", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_05", name = "Receiver 5", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_04", name = "Barrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_05", name = "Barrel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                },
                muzzle = {
                    {id = "muzzle_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "muzzle_01", name = "Muzzle 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_02", name = "Muzzle 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_03", name = "Muzzle 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_04", name = "Muzzle 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_05", name = "Muzzle 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                sight = {
                    {id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "sight_01", name = "Sight 1", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            shotgun_p1_m1 = {
                flashlight = {
                    {id = "default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
                },
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = {
                    {id = "shotgun_rifle_stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shotgun_rifle_stock_01", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "shotgun_rifle_stock_02", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "shotgun_rifle_stock_03", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "shotgun_rifle_stock_04", name = "Stock 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                sight = {
                    {id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "sight_01", name = "Sight 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sight_02", name = "Sight 2", sounds = {UISoundEvents.weapons_swap}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_04", name = "Barrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                underbarrel = {
                    {id = "underbarrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "underbarrel_01", name = "Underbarrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "underbarrel_02", name = "Underbarrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "underbarrel_03", name = "Underbarrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "underbarrel_04", name = "Underbarrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            bolter_p1_m1 = {
                flashlight = {
                    {id = "default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
                },
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                    {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.apparel_equip}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                underbarrel = {
                    {id = "underbarrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "underbarrel_01", name = "Underbarrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "underbarrel_02", name = "Underbarrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "underbarrel_03", name = "Underbarrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                grip = {
                    {id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                },
                sight = {
                    {id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "sight_01", name = "Sight 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "sight_02", name = "Sight 2", sounds = {UISoundEvents.weapons_swap}},
                },
                stock = {
                    {id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "autogun_rifle_stock_01", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_02", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_03", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_04", name = "Stock 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_01", name = "Stock 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_02", name = "Stock 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_03", name = "Stock 7", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_04", name = "Stock 8", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_05", name = "Stock 9", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            stubrevolver_p1_m1 = {
                flashlight = {
                    {id = "default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "flashlight_01", name = "Flashlight 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_02", name = "Flashlight 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_03", name = "Flashlight 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "flashlight_04", name = "Flashlight 4", sounds = {UISoundEvents.apparel_equip_small}},
                },
                body = {
                    {id = "body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                rail = {
                    {id = "rail_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "rail_01", name = "Rail 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = {
                    {id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "autogun_rifle_stock_02", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_04", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_05", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            plasmagun_p1_m1 = {
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                    {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.apparel_equip}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                grip = {
                    {id = "grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "grip_01", name = "Grip 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_02", name = "Grip 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "grip_03", name = "Grip 3", sounds = {UISoundEvents.weapons_swap}},
                },
                stock = {
                    {id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "plasma_rifle_stock_01", name = "Ventilation 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "plasma_rifle_stock_02", name = "Ventilation 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "plasma_rifle_stock_03", name = "Ventilation 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                stock_2 = {
                    {id = "stock_2_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "autogun_rifle_stock_01", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_02", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_03", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_04", name = "Stock 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_01", name = "Stock 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_02", name = "Stock 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_03", name = "Stock 7", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_04", name = "Stock 8", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_05", name = "Stock 9", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                emblem_right = {
                    {id = "emblem_right_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_right_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_13", name = "Emblem 13", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_14", name = "Emblem 14", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_15", name = "Emblem 15", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_16", name = "Emblem 16", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_17", name = "Emblem 17", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_18", name = "Emblem 18", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_19", name = "Emblem 19", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_20", name = "Emblem 20", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_right_21", name = "Emblem 21", sounds = {UISoundEvents.apparel_equip_small}},
                },
                emblem_left = {
                    {id = "emblem_left_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "emblem_left_01", name = "Emblem 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_02", name = "Emblem 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_03", name = "Emblem 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_04", name = "Emblem 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_05", name = "Emblem 5", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_06", name = "Emblem 6", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_07", name = "Emblem 7", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_08", name = "Emblem 8", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_09", name = "Emblem 9", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_10", name = "Emblem 10", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_11", name = "Emblem 11", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "emblem_left_12", name = "Emblem 12", sounds = {UISoundEvents.apparel_equip_small}},
                },
            },
            laspistol_p1_m1 = {
                flashlight = _flashlights_attachments(),
                receiver = _laspistol_receiver_attachments(),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                grip = _grip_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.weapons_swap}}},
                    _reflex_sights_attachments()
                ),
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.apparel_equip}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                    -- {id = "magazine_02", name = "Magazine 2", sounds = {UISoundEvents.apparel_equip}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_01", name = "Barrel 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Barrel 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Barrel 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_04", name = "Barrel 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_05", name = "Barrel 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_06", name = "Barrel 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                muzzle = {
                    {id = "muzzle_default", name = "Default", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_01", name = "Muzzle 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    -- {id = "muzzle_02", name = "Muzzle 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_03", name = "Muzzle 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "muzzle_04", name = "Muzzle 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                rail = {
                    {id = "rail_default", name = "Default", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "rail_01", name = "Rail 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = {
                    {id = "lasgun_pistol_stock_default", name = "Default"},
                    {id = "lasgun_pistol_stock_01", name = "Ventilation 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "lasgun_pistol_stock_02", name = "Ventilation 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "lasgun_pistol_stock_03", name = "Ventilation 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                stock_2 = {
                    {id = "stock_2_default",        name = "Default"},
                    {id = "autogun_rifle_stock_02", name = "Stock 1",   sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "autogun_rifle_stock_04", name = "Stock 2",   sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_05",               name = "Stock 3",   sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                -- sight = {
                --     {id = "sight_default", name = "Default", sounds = {UISoundEvents.weapons_swap}},
                --     {id = "sight_01", name = "Sight 1", sounds = {UISoundEvents.weapons_swap}},
                --     {id = "sight_02", name = "Sight 2", sounds = {UISoundEvents.weapons_swap}},
                --     {id = "sight_03", name = "Sight 3", sounds = {UISoundEvents.weapons_swap}},
                -- },
            },
            autogun_p1_m1 = {
                flashlight = _flashlights_attachments(),
                rail = _lasgun_rail_attachments(),
                grip = _grip_attachments(),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Infantry Autogun 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Headhunter Autogun 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    -- {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = table.icombine(
                    {{id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _stock_attachments()
                ),
                magazine = _autogun_magazine_attachments(),
                barrel = table.icombine(
                    {{id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _autogun_barrel_attachments(),
                    -- _autogun_braced_barrel_attachments(),
                    _autogun_headhunter_barrel_attachments()
                ),
                muzzle = _autogun_muzzle_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
            },
            autogun_p2_m1 = {
                flashlight = _flashlights_attachments(),
                rail = _lasgun_rail_attachments(),
                grip = _grip_attachments(),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    -- {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    -- {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Braced Autogun 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = table.icombine(
                    {{id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _stock_attachments()
                ),
                magazine = _autogun_magazine_attachments(),
                barrel = table.icombine(
                    {{id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    -- _autogun_barrel_attachments(),
                    _autogun_braced_barrel_attachments()
                    -- _autogun_headhunter_barrel_attachments()
                ),
                muzzle = _autogun_muzzle_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
            },
            autogun_p3_m1 = {
                flashlight = _flashlights_attachments(),
                rail = _lasgun_rail_attachments(),
                grip = _grip_attachments(),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Infantry Autogun 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Headhunter Autogun 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    -- {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = table.icombine(
                    {{id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _stock_attachments()
                ),
                magazine = _autogun_magazine_attachments(),
                barrel = table.icombine(
                    {{id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _autogun_barrel_attachments(),
                    -- _autogun_braced_barrel_attachments(),
                    _autogun_headhunter_barrel_attachments()
                ),
                muzzle = _autogun_muzzle_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
            },
            lasgun_p1_m1 = {
                flashlight = _flashlights_attachments(),
                rail = _lasgun_rail_attachments(),
                grip = _grip_attachments(),
                barrel = _lasgun_barrel_attachments(),
                muzzle = _lasgun_muzzle_attachments(),
                bayonet = _bayonet_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = table.icombine(
                    {{id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _stock_attachments()
                ),
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                },
            },
            lasgun_p2_m1 = {
                flashlight = _flashlights_attachments(),
                bayonet = _bayonet_attachments(),
                rail = _lasgun_rail_attachments(),
                barrel = _lasgun_barrel_attachments(),
                muzzle = _lasgun_muzzle_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Receiver 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Receiver 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Receiver 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = {
                    {id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "stock_01", name = "Stock 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_02", name = "Stock 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_03", name = "Stock 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Magazine 1", sounds = {UISoundEvents.apparel_equip}},
                },
            },
            lasgun_p3_m1 = {
                flashlight = _flashlights_attachments(),
                bayonet = _bayonet_attachments(),
                rail = _lasgun_rail_attachments(),
                grip = _grip_attachments(),
                barrel = _lasgun_barrel_attachments(),
                muzzle = _lasgun_muzzle_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                sight = table.icombine(
                    {{id = "sight_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    _reflex_sights_attachments(),
                    _sights_attachments()
                ),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Recon Lasgun 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Recon Lasgun 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Recon Lasgun 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_04", name = "Recon Lasgun 4", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_05", name = "Recon Lasgun 5", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_06", name = "Recon Lasgun 6", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                stock = {
                    {id = "stock_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "stock_01", name = "Recon Lasgun 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_02", name = "Recon Lasgun 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "stock_03", name = "Recon Lasgun 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Recon Lasgun", sounds = {UISoundEvents.apparel_equip}},
                },
            },
            flamer_p1_m1 = {
                flashlight = _flashlights_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                trinket_hook = _trinket_hook_attachments(),
                receiver = {
                    {id = "receiver_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "receiver_01", name = "Flamer 1", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_02", name = "Flamer 2", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_03", name = "Flamer 3", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_04", name = "Flamer 4", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_05", name = "Flamer 5", sounds = {UISoundEvents.weapons_equip_weapon}},
                    {id = "receiver_06", name = "Flamer 6", sounds = {UISoundEvents.weapons_equip_weapon}},
                },
                magazine = {
                    {id = "magazine_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "magazine_01", name = "Flamer 1", sounds = {UISoundEvents.apparel_equip}},
                    {id = "magazine_02", name = "Flamer 2", sounds = {UISoundEvents.apparel_equip}},
                    {id = "magazine_03", name = "Flamer 3", sounds = {UISoundEvents.apparel_equip}},
                },
                barrel = {
                    {id = "barrel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "barrel_01", name = "Flamer 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_02", name = "Flamer 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_03", name = "Flamer 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_04", name = "Flamer 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_05", name = "Flamer 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "barrel_06", name = "Flamer 6", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                grip = table.icombine(
                    -- {{id = "flamer_grip_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}}},
                    -- _grip_attachments(),
                    {
                        {id = "flamer_grip_01", name = "Flamer 1", sounds = {UISoundEvents.weapons_swap}},
                        {id = "flamer_grip_02", name = "Flamer 2", sounds = {UISoundEvents.weapons_swap}},
                        {id = "flamer_grip_03", name = "Flamer 3", sounds = {UISoundEvents.weapons_swap}},
                        -- {id = "plasma_grip_01", name = "Plasma 1", sounds = {UISoundEvents.weapons_swap}},
                        -- {id = "plasma_grip_02", name = "Plasma 2", sounds = {UISoundEvents.weapons_swap}},
                        -- {id = "plasma_grip_03", name = "Plasma 3", sounds = {UISoundEvents.weapons_swap}},
                    }
                ),
            },
            forcestaff_p1_m1 = {
                shaft_lower = {
                    {id = "shaft_lower_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shaft_lower_01", name = "Lower Shaft 1", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "shaft_lower_02", name = "Lower Shaft 2", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "shaft_lower_03", name = "Lower Shaft 3", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "shaft_lower_04", name = "Lower Shaft 4", sounds = {UISoundEvents.apparel_equip_small}},
                    {id = "shaft_lower_05", name = "Lower Shaft 5", sounds = {UISoundEvents.apparel_equip_small}},
                },
                shaft_upper = {
                    {id = "shaft_upper_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shaft_upper_01", name = "Upper Shaft 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_upper_02", name = "Upper Shaft 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_upper_03", name = "Upper Shaft 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_upper_04", name = "Upper Shaft 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shaft_upper_05", name = "Upper Shaft 5", sounds = {UISoundEvents.weapons_swap}},
                },
                body = {
                    {id = "body_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "body_01", name = "Body 1", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "body_02", name = "Body 2", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "body_03", name = "Body 3", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "body_04", name = "Body 4", sounds = {UISoundEvents.weapons_equip_gadget}},
                    {id = "body_05", name = "Body 5", sounds = {UISoundEvents.weapons_equip_gadget}},
                },
                head = {
                    {id = "head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "head_01", name = "Head 1", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_02", name = "Head 2", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_03", name = "Head 3", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_04", name = "Head 4", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_05", name = "Head 5", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_06", name = "Head 6", sounds = {UISoundEvents.apparel_equip}},
                    {id = "head_07", name = "Head 7", sounds = {UISoundEvents.apparel_equip}},
                },
            },
        --#endregion
        --#region Melee
            combataxe_p1_m1 = {
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                head = {
                    {id = "shovel_head_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shovel_head_01", name = "Head 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_head_02", name = "Head 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_head_03", name = "Head 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_head_04", name = "Head 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_head_05", name = "Head 5", sounds = {UISoundEvents.weapons_swap}},
                },
                pommel = {
                    {id = "shovel_pommel_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
                    {id = "shovel_pommel_01", name = "Pommel 1", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_02", name = "Pommel 2", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_03", name = "Pommel 3", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_04", name = "Pommel 4", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_05", name = "Pommel 5", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_06", name = "Pommel 6", sounds = {UISoundEvents.weapons_swap}},
                    {id = "shovel_pommel_07", name = "Pommel 7", sounds = {UISoundEvents.weapons_swap}},
                },
            },
            combatsword_p1_m1 = {
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
                shaft = {
                    {id = "2h_power_maul_shaft_default", name = "Default", sounds = {UISoundEvents.end_screen_summary_currency_icon_out}},
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
                trinket_hook = _trinket_hook_attachments(),
                emblem_right = _emblem_right_attachments(),
                emblem_left = _emblem_left_attachments(),
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
            -- mod.attachment.autogun_p2_m1 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p2_m2 = mod.attachment.autogun_p2_m1
            mod.attachment.autogun_p2_m3 = mod.attachment.autogun_p2_m1
            -- mod.attachment.autogun_p3_m1 = mod.attachment.autogun_p1_m1
            mod.attachment.autogun_p3_m2 = mod.attachment.autogun_p3_m1
            mod.attachment.autogun_p3_m3 = mod.attachment.autogun_p3_m1
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
    mod.text_overwrite = {
        plasmagun_p1_m1 = {
            loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
        },
        laspistol_p1_m1 = {
            loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
        },
    }

    mod.default_overwrite = {
        laspistol_p1_m1 = {
            receiver = "content/items/weapons/player/ranged/recievers/lasgun_pistol_receiver_03",
        }
    }

    mod.automatic_slots = {
        "rail",
    }

    mod.reflex_sights = {
        "reflex_sight_01",
        "reflex_sight_02",
        "reflex_sight_03",
    }

    mod.sights = {
        "lasgun_rifle_elysian_sight_01",
        "lasgun_rifle_elysian_sight_02",
        "lasgun_rifle_elysian_sight_03",
    }

    mod.rails = {
        "lasgun_rifle_rail_01"
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

    mod.flashlight_attached = {}
    mod.attached_flashlights = {}

    mod.flashlights = {
        "flashlight_01",
        "flashlight_02",
        "flashlight_03",
        "flashlight_04",
    }

    mod.bayonets = {
        "bayonet_blade_01",
        "bayonet_01",
        "bayonet_02",
        "bayonet_03",
    }

    mod.stocks = {
        "autogun_rifle_stock_01",
        "autogun_rifle_stock_02",
        "autogun_rifle_stock_03",
        "autogun_rifle_stock_04",
        "stock_01",
        "stock_02",
        "stock_03",
        "stock_04",
        "stock_05",
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
        ["#ID[bc25db1df0670d2a]"] = "bulwark_shield_01",
    }

    mod.attachment_slots = {
        "flashlight",
        "barrel",
        "underbarrel",
        "muzzle",
        "receiver",
        "magazine",
        "magazine2",
        "grip",
        "handle",
        "stock",
        "stock_2",
        "bayonet",
        "sight",
        "rail",
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
    }
--#endregion

--#region Models
    mod.attachment_models = {
        --#region Ogryn Guns
            ogryn_heavystubber_p1_m1 = table.combine( -- Done 5.9.2023
                _flashlight_models("receiver", -2.25, Vector3Box(0, -3, -.2), Vector3Box(.4, 0, .4)),
                _emblem_right_models("receiver", -3, Vector3Box(.3, -6, -.1), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(-.3, -6, -.1), Vector3Box(-.2, 0, 0)),
                _ogryn_bayonet_models("receiver", -.5, Vector3Box(.4, -2, 0), Vector3Box(0, .4, 0)),
                _stubber_barrel_models(nil, -.25, Vector3Box(.35, -3, 0), Vector3Box(0, .2, 0)),
                _stubber_receiver_models(nil, 0, Vector3Box(0, -1, 0), Vector3Box(0, 0, -.00001)),
                _stubber_magazine_models(nil, 0, Vector3Box(0, -3, .1), Vector3Box(0, 0, -.2)),
                _stubber_grip_models(nil, .3, Vector3Box(-.4, -3, 0), Vector3Box(0, -.2, 0)),
                _trinket_hook_models(nil, .3, Vector3Box(-.6, -5, .1), Vector3Box(0, 0, 0))
            ),
            ogryn_rippergun_p1_m1 = table.combine( -- Done 8.9.2023
                _flashlight_models("receiver", -2.25, Vector3Box(-.2, -3, -.1), Vector3Box(.4, 0, .4)),
                _emblem_right_models("receiver", -3, Vector3Box(-.2, -6, -.1), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(-.1, -6, -.1), Vector3Box(.2, 0, 0)),
                _ogryn_bayonet_models({"", "", "", "", "receiver"}, -.5, Vector3Box(.2, -2, 0), Vector3Box(0, .4, 0)),
                _ripper_barrel_models(nil, -.5, Vector3Box(.2, -2, 0), Vector3Box(0, .6, 0)),
                _ripper_receiver_models(nil, 0, Vector3Box(0, -1, 0), Vector3Box(0, 0, -.00001)),
                _ripper_magazine_models(nil, 0, Vector3Box(0, -3, .1), Vector3Box(0, 0, -.2)),
                _ripper_handle_models(nil, -.75, Vector3Box(-.2, -4, -.1), Vector3Box(-.2, 0, 0)),
                _trinket_hook_models(nil, -.3, Vector3Box(.15, -5, .1), Vector3Box(0, 0, 0))
            ),
            ogryn_thumper_p1_m1 = table.combine( -- Done 8.9.2023
                _flashlight_models("receiver", -2.25, Vector3Box(0, -3, 0), Vector3Box(.4, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(-.3, -6, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(-.1, -6, 0), Vector3Box(-.2, 0, 0)),
                _ogryn_bayonet_models("receiver", -.5, Vector3Box(.4, -2, 0), Vector3Box(0, .4, 0)),
                _thumper_grip_models(nil, 0, Vector3Box(-.3, -3, 0), Vector3Box(0, -.2, 0)),
                _thumper_sight_models(nil, -.5, Vector3Box(.2, -3, 0), Vector3Box(0, 0, .2)),
                _thumper_body_models(nil, 0, Vector3Box(0, -1, 0), Vector3Box(0, 0, -.00001)),
                _trinket_hook_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, 0))
            ),
            ogryn_gauntlet_p1_m1 = table.combine( -- Done 8.9.2023
                _flashlight_models("receiver", -2.25, Vector3Box(0, -3, 0), Vector3Box(.4, 0, 0)),
                _emblem_right_models(nil, -3, Vector3Box(-.1, -6, -.05), Vector3Box(.2, 0, 0)),
                _emblem_left_models(nil, 0, Vector3Box(-.3, -6, -.05), Vector3Box(.2, 0, 0)),
                _ogryn_bayonet_models("barrel", -.5, Vector3Box(.4, -2, 0), Vector3Box(0, .4, 0)),
                _gauntlet_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 2, 0)),
                _gauntlet_body_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, -.00001)),
                _gauntlet_magazine_models(nil, 0, Vector3Box(-.8, -4, 0), Vector3Box(0, -.6, 0)),
                _trinket_hook_models("barrel", -.3, Vector3Box(.25, -5, .1), Vector3Box(0, 0, 0))
            ),
        --#endregion
        --#region Ogryn Melee
            ogryn_club_p1_m1 = {
                grip_default = {model = "", type = "grip"},
                grip_01 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_01", type = "grip"},
                grip_02 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_02", type = "grip"},
                grip_03 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_03", type = "grip"},
                grip_04 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_04", type = "grip"},
                grip_05 = {model = "content/items/weapons/player/melee/grips/shovel_ogryn_grip_05", type = "grip"},
                pommel_default = {model = "", type = "pommel"},
                pommel_01 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_01", type = "pommel"},
                pommel_02 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_02", type = "pommel"},
                pommel_03 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_03", type = "pommel"},
                pommel_04 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_04", type = "pommel"},
                pommel_05 = {model = "content/items/weapons/player/melee/pommels/shovel_ogryn_pommel_05", type = "pommel"},
                head_default = {model = "", type = "head"},
                head_01 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_01", type = "head"},
                head_02 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_02", type = "head"},
                head_03 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_03", type = "head"},
                head_04 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_04", type = "head"},
                head_05 = {model = "content/items/weapons/player/melee/heads/shovel_ogryn_head_05", type = "head"},
                emblem_right_default = {model = "", type = "emblem_right"},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right"},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right"},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right"},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right"},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right"},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right"},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right"},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right"},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right"},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right"},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right"},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right"},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right"},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right"},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right"},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right"},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right"},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right"},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right"},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right"},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right"},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            ogryn_combatblade_p1_m1 = {
                blade_default = {model = "", type = "blade"},
                blade_01 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_01", type = "blade"},
                blade_02 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_02", type = "blade"},
                blade_03 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_03", type = "blade"},
                blade_04 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_04", type = "blade"},
                blade_05 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_05", type = "blade"},
                blade_06 = {model = "content/items/weapons/player/melee/blades/combat_blade_blade_06", type = "blade"},
                grip_default = {model = "", type = "grip"},
                grip_01 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_01", type = "grip"},
                grip_02 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_02", type = "grip"},
                grip_03 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_03", type = "grip"},
                grip_04 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_04", type = "grip"},
                grip_05 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_05", type = "grip"},
                grip_06 = {model = "content/items/weapons/player/melee/grips/combat_blade_grip_06", type = "grip"},
                handle_default = {model = "", type = "handle"},
                handle_01 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_01", type = "handle"},
                handle_02 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_02", type = "handle"},
                handle_03 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_03", type = "handle"},
                handle_04 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_04", type = "handle"},
                handle_05 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_05", type = "handle"},
                handle_06 = {model = "content/items/weapons/player/ranged/handles/combat_blade_handle_06", type = "handle"},
                emblem_right_default = {model = "", type = "emblem_right"},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right"},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right"},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right"},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right"},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right"},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right"},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right"},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right"},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right"},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right"},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right"},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right"},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right"},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right"},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right"},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right"},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right"},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right"},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right"},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right"},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right"},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            ogryn_powermaul_p1_m1 = {
                shaft_default = {model = "", type = "shaft"},
                shaft_01 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_01", type = "shaft"},
                shaft_02 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_02", type = "shaft"},
                shaft_03 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_03", type = "shaft"},
                shaft_04 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_04", type = "shaft"},
                shaft_05 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_05", type = "shaft"},
                head_default = {model = "", type = "head"},
                head_01 = {model = "content/items/weapons/player/melee/heads/power_maul_head_01", type = "head"},
                head_02 = {model = "content/items/weapons/player/melee/heads/power_maul_head_02", type = "head"},
                head_03 = {model = "content/items/weapons/player/melee/heads/power_maul_head_03", type = "head"},
                head_04 = {model = "content/items/weapons/player/melee/heads/power_maul_head_04", type = "head"},
                head_05 = {model = "content/items/weapons/player/melee/heads/power_maul_head_05", type = "head"},
                pommel_default = {model = "", type = "pommel"},
                pommel_01 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_01", type = "pommel"},
                pommel_02 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_02", type = "pommel"},
                pommel_03 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_03", type = "pommel"},
                pommel_04 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_04", type = "pommel"},
                pommel_05 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_05", type = "pommel"},
                emblem_right_default = {model = "", type = "emblem_right"},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right"},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right"},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right"},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right"},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right"},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right"},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right"},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right"},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right"},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right"},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right"},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right"},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right"},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right"},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right"},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right"},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right"},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right"},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right"},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right"},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right"},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            ogryn_powermaul_slabshield_p1_m1 = {
                left_default = {model = "", type = "left"},
                left_01 = {model = "content/items/weapons/player/melee/ogryn_slabshield_p1_m1", type = "left"},
                bulwark_shield_01 = {model = "content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01", type = "left"},
                shaft_default = {model = "", type = "shaft"},
                shaft_01 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_01", type = "shaft"},
                shaft_02 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_02", type = "shaft"},
                shaft_03 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_03", type = "shaft"},
                shaft_04 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_04", type = "shaft"},
                shaft_05 = {model = "content/items/weapons/player/ranged/shafts/power_maul_shaft_05", type = "shaft"},
                head_default = {model = "", type = "head"},
                head_01 = {model = "content/items/weapons/player/melee/heads/power_maul_head_01", type = "head"},
                head_02 = {model = "content/items/weapons/player/melee/heads/power_maul_head_02", type = "head"},
                head_03 = {model = "content/items/weapons/player/melee/heads/power_maul_head_03", type = "head"},
                head_04 = {model = "content/items/weapons/player/melee/heads/power_maul_head_04", type = "head"},
                head_05 = {model = "content/items/weapons/player/melee/heads/power_maul_head_05", type = "head"},
                pommel_default = {model = "", type = "pommel"},
                pommel_01 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_01", type = "pommel"},
                pommel_02 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_02", type = "pommel"},
                pommel_03 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_03", type = "pommel"},
                pommel_04 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_04", type = "pommel"},
                pommel_05 = {model = "content/items/weapons/player/melee/pommels/power_maul_pommel_05", type = "pommel"},
                emblem_right_default = {model = "", type = "emblem_right"},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right"},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right"},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right"},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right"},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right"},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right"},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right"},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right"},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right"},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right"},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right"},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right"},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right"},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right"},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right"},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right"},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right"},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right"},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right"},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right"},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right"},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            ogryn_club_p2_m1 = {
                body_default = {model = "", type = "body"},
                body_01 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_01", type = "body"},
                body_02 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_02", type = "body"},
                body_03 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_03", type = "body"},
                body_04 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_04", type = "body"},
                body_05 = {model = "content/items/weapons/player/melee/full/ogryn_club_pipe_full_05", type = "body"},
                emblem_right_default = {model = "", type = "emblem_right"},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right"},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right"},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right"},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right"},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right"},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right"},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right"},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right"},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right"},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right"},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right"},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right"},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right"},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right"},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right"},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right"},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right"},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right"},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right"},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right"},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right"},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
        --#endregion
        --#region Guns
            autopistol_p1_m1 = table.combine(
                _flashlight_models(nil, -2.5, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, Vector3Box(.1, 0, 0), Vector3Box(0, .4, -.025)),
                _grip_models(nil, -.1, Vector3Box(-.1, 0, 0), Vector3Box(0, -.1, -.1)),
                _stock_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, -.2, 0)),
                _trinket_hook_models(),
                {
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/autogun_pistol_receiver_01", type = "receiver"},
                    receiver_02 = {model = "content/items/weapons/player/ranged/recievers/autogun_pistol_receiver_02", type = "receiver"},
                    receiver_03 = {model = "content/items/weapons/player/ranged/recievers/autogun_pistol_receiver_03", type = "receiver"},
                    receiver_04 = {model = "content/items/weapons/player/ranged/recievers/autogun_pistol_receiver_04", type = "receiver"},
                    receiver_05 = {model = "content/items/weapons/player/ranged/recievers/autogun_pistol_receiver_05", type = "receiver"},
                    barrel_default = {model = "", type = "barrel"},
                    barrel_01 = {model = "content/items/weapons/player/ranged/barrels/autogun_pistol_barrel_01", type = "barrel"},
                    barrel_02 = {model = "content/items/weapons/player/ranged/barrels/autogun_pistol_barrel_02", type = "barrel"},
                    barrel_03 = {model = "content/items/weapons/player/ranged/barrels/autogun_pistol_barrel_03", type = "barrel"},
                    barrel_04 = {model = "content/items/weapons/player/ranged/barrels/autogun_pistol_barrel_04", type = "barrel"},
                    barrel_05 = {model = "content/items/weapons/player/ranged/barrels/autogun_pistol_barrel_05", type = "barrel"},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/autogun_pistol_magazine_01", type = "magazine"},
                    muzzle_default = {model = "", type = "muzzle"},
                    muzzle_01 = {model = "content/items/weapons/player/ranged/muzzles/autogun_pistol_muzzle_01", type = "muzzle"},
                    muzzle_02 = {model = "content/items/weapons/player/ranged/muzzles/autogun_pistol_muzzle_02", type = "muzzle"},
                    muzzle_03 = {model = "content/items/weapons/player/ranged/muzzles/autogun_pistol_muzzle_03", type = "muzzle"},
                    muzzle_04 = {model = "content/items/weapons/player/ranged/muzzles/autogun_pistol_muzzle_04", type = "muzzle"},
                    muzzle_05 = {model = "content/items/weapons/player/ranged/muzzles/autogun_pistol_muzzle_05", type = "muzzle"},
                    sight_default = {model = "", type = "sight"},
                    sight_01 = {model = "content/items/weapons/player/ranged/sights/autogun_pistol_sight_01", type = "sight"},
                }
            ),
            shotgun_p1_m1 = table.combine(
                {
                    default = {model = "", type = "flashlight", angle = -2.5},
                    flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight", angle = -2.5},
                    flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight", angle = -2.5},
                    flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight", angle = -2.5},
                    flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight", angle = -2.5},
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/shotgun_rifle_receiver_01", type = "receiver"},
                    shotgun_rifle_stock_default = {model = "", type = "stock", angle = .5},
                    shotgun_rifle_stock_01 = {model = "content/items/weapons/player/ranged/stocks/shotgun_rifle_stock_01", type = "stock", angle = .5},
                    shotgun_rifle_stock_02 = {model = "content/items/weapons/player/ranged/stocks/shotgun_rifle_stock_03", type = "stock", angle = .5},
                    shotgun_rifle_stock_03 = {model = "content/items/weapons/player/ranged/stocks/shotgun_rifle_stock_05", type = "stock", angle = .5},
                    shotgun_rifle_stock_04 = {model = "content/items/weapons/player/ranged/stocks/shotgun_rifle_stock_06", type = "stock", angle = .5},
                    sight_default = {model = "", type = "sight"},
                    sight_01 = {model = "content/items/weapons/player/ranged/sights/shotgun_rifle_sight_01", type = "sight"},
                    sight_02 = {model = "content/items/weapons/player/ranged/sights/shotgun_rifle_sight_04", type = "sight"},
                    barrel_default = {model = "", type = "barrel"},
                    barrel_01 = {model = "content/items/weapons/player/ranged/barrels/shotgun_rifle_barrel_01", type = "barrel"},
                    barrel_02 = {model = "content/items/weapons/player/ranged/barrels/shotgun_rifle_barrel_04", type = "barrel"},
                    barrel_03 = {model = "content/items/weapons/player/ranged/barrels/shotgun_rifle_barrel_05", type = "barrel"},
                    barrel_04 = {model = "content/items/weapons/player/ranged/barrels/shotgun_rifle_barrel_06", type = "barrel"},
                    underbarrel_default = {model = "", type = "underbarrel"},
                    underbarrel_01 = {model = "content/items/weapons/player/ranged/underbarrels/shotgun_rifle_underbarrel_01", type = "underbarrel"},
                    underbarrel_02 = {model = "content/items/weapons/player/ranged/underbarrels/shotgun_rifle_underbarrel_04", type = "underbarrel"},
                    underbarrel_03 = {model = "content/items/weapons/player/ranged/underbarrels/shotgun_rifle_underbarrel_05", type = "underbarrel"},
                    underbarrel_04 = {model = "content/items/weapons/player/ranged/underbarrels/shotgun_rifle_underbarrel_06", type = "underbarrel"},
                    emblem_right_default = {model = "", type = "emblem_right", angle = -3},
                    emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right", angle = -3},
                    emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right", angle = -3},
                    emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right", angle = -3},
                    emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right", angle = -3},
                    emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right", angle = -3},
                    emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right", angle = -3},
                    emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right", angle = -3},
                    emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right", angle = -3},
                    emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right", angle = -3},
                    emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right", angle = -3},
                    emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right", angle = -3},
                    emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right", angle = -3},
                    emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right", angle = -3},
                    emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right", angle = -3},
                    emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right", angle = -3},
                    emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right", angle = -3},
                    emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right", angle = -3},
                    emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right", angle = -3},
                    emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right", angle = -3},
                    emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right", angle = -3},
                    emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right", angle = -3},
                    emblem_left_default = {model = "", type = "emblem_left"},
                    emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                    emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                    emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                    emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                    emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                    emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                    emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                    emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                    emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                    emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                    emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                    emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
                }
            ),
            bolter_p1_m1 = table.combine(
                {
                    default = {model = "", type = "flashlight", angle = -2.5},
                    flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight", angle = -2.5},
                    flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight", angle = -2.5},
                    flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight", angle = -2.5},
                    flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight", angle = -2.5},
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/boltgun_rifle_receiver_01", type = "receiver"},
                    receiver_02 = {model = "content/items/weapons/player/ranged/recievers/boltgun_rifle_receiver_02", type = "receiver"},
                    receiver_03 = {model = "content/items/weapons/player/ranged/recievers/boltgun_rifle_receiver_03", type = "receiver"},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/boltgun_rifle_magazine_01", type = "magazine"},
                    magazine_02 = {model = "content/items/weapons/player/ranged/magazines/boltgun_rifle_magazine_02", type = "magazine"},
                    barrel_default = {model = "", type = "barrel"},
                    barrel_01 = {model = "content/items/weapons/player/ranged/barrels/boltgun_rifle_barrel_01", type = "barrel"},
                    underbarrel_default = {model = "", type = "underbarrel"},
                    underbarrel_01 = {model = "content/items/weapons/player/ranged/underbarrels/boltgun_rifle_underbarrel_01", type = "underbarrel"},
                    underbarrel_02 = {model = "content/items/weapons/player/ranged/underbarrels/boltgun_rifle_underbarrel_02", type = "underbarrel"},
                    underbarrel_03 = {model = "content/items/weapons/player/ranged/underbarrels/boltgun_rifle_underbarrel_03", type = "underbarrel"},
                    grip_default = {model = "", type = "grip"},
                    grip_01 = {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_01", type = "grip"},
                    grip_02 = {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_02", type = "grip"},
                    grip_03 = {model = "content/items/weapons/player/ranged/grips/boltgun_rifle_grip_03", type = "grip"},
                    sight_default = {model = "", type = "sight"},
                    sight_01 = {model = "content/items/weapons/player/ranged/sights/boltgun_rifle_sight_01", type = "sight"},
                    sight_02 = {model = "content/items/weapons/player/ranged/sights/boltgun_rifle_sight_02", type = "sight"},
                    stock_default = {model = "", type = "stock", angle = .5},
                    autogun_rifle_stock_01 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_01", type = "stock", angle = .5},
                    autogun_rifle_stock_02 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_02", type = "stock", angle = .5},
                    autogun_rifle_stock_03 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_03", type = "stock", angle = .5},
                    autogun_rifle_stock_04 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_04", type = "stock", angle = .5},
                    stock_01 = {model = "content/items/weapons/player/ranged/stocks/stock_01", type = "stock", angle = .5},
                    stock_02 = {model = "content/items/weapons/player/ranged/stocks/stock_02", type = "stock", angle = .5},
                    stock_03 = {model = "content/items/weapons/player/ranged/stocks/stock_03", type = "stock", angle = .5},
                    stock_04 = {model = "content/items/weapons/player/ranged/stocks/stock_04", type = "stock", angle = .5},
                    stock_05 = {model = "content/items/weapons/player/ranged/stocks/stock_05", type = "stock", angle = .5},
                    emblem_right_default = {model = "", type = "emblem_right", angle = -3},
                    emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right", angle = -3},
                    emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right", angle = -3},
                    emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right", angle = -3},
                    emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right", angle = -3},
                    emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right", angle = -3},
                    emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right", angle = -3},
                    emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right", angle = -3},
                    emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right", angle = -3},
                    emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right", angle = -3},
                    emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right", angle = -3},
                    emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right", angle = -3},
                    emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right", angle = -3},
                    emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right", angle = -3},
                    emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right", angle = -3},
                    emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right", angle = -3},
                    emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right", angle = -3},
                    emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right", angle = -3},
                    emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right", angle = -3},
                    emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right", angle = -3},
                    emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right", angle = -3},
                    emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right", angle = -3},
                    emblem_left_default = {model = "", type = "emblem_left"},
                    emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                    emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                    emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                    emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                    emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                    emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                    emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                    emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                    emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                    emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                    emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                    emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
                }
            ),
            stubrevolver_p1_m1 = {
                default = {model = "", type = "flashlight", angle = -2.5},
                flashlight_01 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_01", type = "flashlight", angle = -2.5},
                flashlight_02 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_02", type = "flashlight", angle = -2.5},
                flashlight_03 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_03", type = "flashlight", angle = -2.5},
                flashlight_04 = {model = "content/items/weapons/player/ranged/flashlights/flashlight_05", type = "flashlight", angle = -2.5},
                body_default = {model = "", type = "body"},
                body_01 = {model = "content/items/weapons/player/melee/full/stubgun_pistol_full_01", type = "body"},
                barrel_default = {model = "", type = "barrel"},
                barrel_01 = {model = "content/items/weapons/player/ranged/barrels/stubgun_pistol_barrel_01", type = "barrel"},
                barrel_02 = {model = "content/items/weapons/player/ranged/barrels/stubgun_pistol_barrel_02", type = "barrel"},
                barrel_03 = {model = "content/items/weapons/player/ranged/barrels/stubgun_pistol_barrel_03", type = "barrel"},
                rail_default = {model = "", type = "rail"},
                rail_01 = {model = "content/items/weapons/player/ranged/rails/stubgun_pistol_rail_off", type = "rail"},
                stock_default = {model = "", type = "stock", angle = .5},
                autogun_rifle_stock_02 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_02", type = "stock", angle = .5},
                autogun_rifle_stock_04 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_04", type = "stock", angle = .5},
                stock_05 = {model = "content/items/weapons/player/ranged/stocks/stock_05", type = "stock", angle = .5},
                emblem_right_default = {model = "", type = "emblem_right", angle = -3},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right", angle = -3},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right", angle = -3},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right", angle = -3},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right", angle = -3},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right", angle = -3},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right", angle = -3},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right", angle = -3},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right", angle = -3},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right", angle = -3},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right", angle = -3},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right", angle = -3},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right", angle = -3},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right", angle = -3},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right", angle = -3},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right", angle = -3},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right", angle = -3},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right", angle = -3},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right", angle = -3},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right", angle = -3},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right", angle = -3},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right", angle = -3},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            plasmagun_p1_m1 = {
                receiver_default = {model = "", type = "receiver"},
                receiver_01 = {model = "content/items/weapons/player/ranged/recievers/plasma_rifle_receiver_01", type = "receiver"},
                magazine_default = {model = "", type = "magazine"},
                magazine_01 = {model = "content/items/weapons/player/ranged/magazines/plasma_rifle_magazine_01", type = "magazine"},
                magazine_02 = {model = "content/items/weapons/player/ranged/magazines/plasma_rifle_magazine_02", type = "magazine"},
                barrel_default = {model = "", type = "barrel"},
                barrel_01 = {model = "content/items/weapons/player/ranged/barrels/plasma_rifle_barrel_01", type = "barrel"},
                barrel_02 = {model = "content/items/weapons/player/ranged/barrels/plasma_rifle_barrel_02", type = "barrel"},
                barrel_03 = {model = "content/items/weapons/player/ranged/barrels/plasma_rifle_barrel_03", type = "barrel"},
                grip_default = {model = "", type = "grip"},
                grip_01 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_01", type = "grip"},
                grip_02 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_02", type = "grip"},
                grip_03 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_03", type = "grip"},
                stock_default = {model = "", type = "stock", angle = 1},
                plasma_rifle_stock_01 = {model = "content/items/weapons/player/ranged/stocks/plasma_rifle_stock_01", type = "stock", angle = 1},
                plasma_rifle_stock_02 = {model = "content/items/weapons/player/ranged/stocks/plasma_rifle_stock_02", type = "stock", angle = 1},
                plasma_rifle_stock_03 = {model = "content/items/weapons/player/ranged/stocks/plasma_rifle_stock_03", type = "stock", angle = 1},
                stock_2_default = {model = "", type = "stock_2", angle = .5},
                autogun_rifle_stock_01 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_01", type = "stock_2", angle = .5},
                autogun_rifle_stock_02 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_02", type = "stock_2", angle = .5},
                autogun_rifle_stock_03 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_03", type = "stock_2", angle = .5},
                autogun_rifle_stock_04 = {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_04", type = "stock_2", angle = .5},
                stock_01 = {model = "content/items/weapons/player/ranged/stocks/stock_01", type = "stock_2", angle = .5},
                stock_02 = {model = "content/items/weapons/player/ranged/stocks/stock_02", type = "stock_2", angle = .5},
                stock_03 = {model = "content/items/weapons/player/ranged/stocks/stock_03", type = "stock_2", angle = .5},
                stock_04 = {model = "content/items/weapons/player/ranged/stocks/stock_04", type = "stock_2", angle = .5},
                stock_05 = {model = "content/items/weapons/player/ranged/stocks/stock_05", type = "stock_2", angle = .5},
                emblem_right_default = {model = "", type = "emblem_right", angle = -3},
                emblem_right_01 = {model = "content/items/weapons/player/ranged/emblems/emblemright_01", type = "emblem_right", angle = -3},
                emblem_right_02 = {model = "content/items/weapons/player/ranged/emblems/emblemright_02", type = "emblem_right", angle = -3},
                emblem_right_03 = {model = "content/items/weapons/player/ranged/emblems/emblemright_03", type = "emblem_right", angle = -3},
                emblem_right_04 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04a", type = "emblem_right", angle = -3},
                emblem_right_05 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04b", type = "emblem_right", angle = -3},
                emblem_right_06 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04c", type = "emblem_right", angle = -3},
                emblem_right_07 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04d", type = "emblem_right", angle = -3},
                emblem_right_08 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04e", type = "emblem_right", angle = -3},
                emblem_right_09 = {model = "content/items/weapons/player/ranged/emblems/emblemright_04f", type = "emblem_right", angle = -3},
                emblem_right_10 = {model = "content/items/weapons/player/ranged/emblems/emblemright_05", type = "emblem_right", angle = -3},
                emblem_right_11 = {model = "content/items/weapons/player/ranged/emblems/emblemright_06", type = "emblem_right", angle = -3},
                emblem_right_12 = {model = "content/items/weapons/player/ranged/emblems/emblemright_07", type = "emblem_right", angle = -3},
                emblem_right_13 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08a", type = "emblem_right", angle = -3},
                emblem_right_14 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08b", type = "emblem_right", angle = -3},
                emblem_right_15 = {model = "content/items/weapons/player/ranged/emblems/emblemright_08c", type = "emblem_right", angle = -3},
                emblem_right_16 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09a", type = "emblem_right", angle = -3},
                emblem_right_17 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09b", type = "emblem_right", angle = -3},
                emblem_right_18 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09c", type = "emblem_right", angle = -3},
                emblem_right_19 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09d", type = "emblem_right", angle = -3},
                emblem_right_20 = {model = "content/items/weapons/player/ranged/emblems/emblemright_09e", type = "emblem_right", angle = -3},
                emblem_right_21 = {model = "content/items/weapons/player/ranged/emblems/emblemright_10", type = "emblem_right", angle = -3},
                emblem_left_default = {model = "", type = "emblem_left"},
                emblem_left_01 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_01", type = "emblem_left"},
                emblem_left_02 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_02", type = "emblem_left"},
                emblem_left_03 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_03", type = "emblem_left"},
                emblem_left_04 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04a", type = "emblem_left"},
                emblem_left_05 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04b", type = "emblem_left"},
                emblem_left_06 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04c", type = "emblem_left"},
                emblem_left_07 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04d", type = "emblem_left"},
                emblem_left_08 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04e", type = "emblem_left"},
                emblem_left_09 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_04f", type = "emblem_left"},
                emblem_left_10 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_05", type = "emblem_left"},
                emblem_left_11 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_06", type = "emblem_left"},
                emblem_left_12 = {model = "content/items/weapons/player/ranged/emblems/emblemleft_10", type = "emblem_left"},
            },
            laspistol_p1_m1 = table.combine(
                _flashlight_models("receiver", -2.5, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, Vector3Box(.1, 0, 0), Vector3Box(0, .4, -.025)),
                _grip_models(nil, -.1, Vector3Box(-.1, 0, 0), Vector3Box(0, -.1, -.1)),
                _reflex_sights_models("rail", -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _laspistol_receiver_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, -.00001)),
                {
                    magazine_default =              {model = "",                                                                        type = "magazine",  angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(Vector3(0, 0, -.2))},
                    magazine_01 =                   {model = "content/items/weapons/player/ranged/magazines/lasgun_pistol_magazine_01", type = "magazine",  angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(Vector3(0, 0, -.2))},
                    -- magazine_02 =                   {model = "content/items/weapons/player/ranged/magazines/lasgun_pistol_magazine_02", type = "magazine"},
                    barrel_default =                {model = "",                                                                        type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_01 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_01",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_02 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_02",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_03 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_03",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_04 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_04",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_05 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_05",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    barrel_06 =                     {model = "content/items/weapons/player/ranged/barrels/lasgun_pistol_barrel_06",     type = "barrel",    angle = 0, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    muzzle_default =                {model = "",                                                                        type = "muzzle",    angle = -.5, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    muzzle_01 =                     {model = "content/items/weapons/player/ranged/muzzles/lasgun_pistol_muzzle_01",     type = "muzzle",    angle = -.5, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    -- muzzle_02 =                     {model = "content/items/weapons/player/ranged/muzzles/lasgun_pistol_muzzle_02",     type = "muzzle",    angle = -.5, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    muzzle_03 =                     {model = "content/items/weapons/player/ranged/muzzles/lasgun_pistol_muzzle_03",     type = "muzzle",    angle = -.5, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    muzzle_04 =                     {model = "content/items/weapons/player/ranged/muzzles/lasgun_pistol_muzzle_04",     type = "muzzle",    angle = -.5, move = Vector3Box(.1, 0, 0), remove = Vector3Box(0, .2, 0)},
                    rail_default =                  {model = "",                                                                        type = "rail",      angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, .2)},
                    rail_01 =                       {model = "content/items/weapons/player/ranged/rails/lasgun_pistol_rail_01",         type = "rail",      angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, .2)},
                    lasgun_pistol_stock_default =   {model = "",                                                                        type = "stock",     angle = 1, move = Vector3Box(-.1, 0, 0), remove = Vector3Box(0, -.2, 0)},
                    lasgun_pistol_stock_01 =        {model = "content/items/weapons/player/ranged/stocks/lasgun_pistol_stock_01",       type = "stock",     angle = 1, move = Vector3Box(-.1, 0, 0), remove = Vector3Box(0, -.2, 0)},
                    lasgun_pistol_stock_02 =        {model = "content/items/weapons/player/ranged/stocks/lasgun_pistol_stock_02",       type = "stock",     angle = 1, move = Vector3Box(-.1, 0, 0), remove = Vector3Box(0, -.2, 0)},
                    lasgun_pistol_stock_03 =        {model = "content/items/weapons/player/ranged/stocks/lasgun_pistol_stock_03",       type = "stock",     angle = 1, move = Vector3Box(-.1, 0, 0), remove = Vector3Box(0, -.2, 0)},
                    stock_2_default =               {model = "",                                                                        type = "stock_2",   parent = "receiver", angle = .5, move = Vector3Box(-.2, 0, 0), remove = Vector3Box(0, -.2, .035)},
                    autogun_rifle_stock_02 =        {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_02",       type = "stock_2",   parent = "receiver", angle = .5, move = Vector3Box(-.2, 0, 0), remove = Vector3Box(0, -.2, .035)},
                    autogun_rifle_stock_04 =        {model = "content/items/weapons/player/ranged/stocks/autogun_rifle_stock_04",       type = "stock_2",   parent = "receiver", angle = .5, move = Vector3Box(-.2, 0, 0), remove = Vector3Box(0, -.2, .035)},
                    stock_05 =                      {model = "content/items/weapons/player/ranged/stocks/stock_05",                     type = "stock_2",   parent = "receiver", angle = .5, move = Vector3Box(-.2, 0, 0), remove = Vector3Box(0, -.2, .035)},
                }
            ),
            autogun_p1_m1 = table.combine(
                _flashlight_models(nil, -2.5, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, Vector3Box(.1, 0, 0), Vector3Box(0, .4, -.025)),
                _grip_models(nil, -.1, Vector3Box(-.1, 0, 0), Vector3Box(0, -.1, -.1)),
                _reflex_sights_models("rail", -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _sights_models(nil, -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _stock_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, -.2, 0)),
                _autogun_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                -- _autogun_braced_barrel_models(),
                _autogun_headhunter_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _lasgun_rail_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, .2)),
                _autogun_muzzle_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _autogun_magazine_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, -.2)),
                _trinket_hook_models(),
                {
                    receiver_default =  {model = "",                                                                                    type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    receiver_01 =       {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_receiver_01",             type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    receiver_02 =       {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_killshot_receiver_01",    type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    -- receiver_03 = {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_ak_receiver_01", type = "receiver"},
                }
            ),
            autogun_p2_m1 = table.combine(
                _flashlight_models("barrel", -2.5, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, Vector3Box(.1, 0, 0), Vector3Box(0, .4, -.025)),
                _grip_models(nil, -.1, Vector3Box(-.1, 0, 0), Vector3Box(0, -.1, -.1)),
                _reflex_sights_models("rail", -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _sights_models(nil, -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _stock_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, -.2, 0)),
                -- _autogun_barrel_models(),
                _autogun_braced_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                -- _autogun_headhunter_barrel_models(),
                _lasgun_rail_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, .2)),
                _autogun_muzzle_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _autogun_magazine_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, -.2)),
                _trinket_hook_models(),
                {
                    receiver_default =  {model = "",                                                                            type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    -- receiver_01 = {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_receiver_01", type = "receiver"},
                    -- receiver_02 = {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_killshot_receiver_01", type = "receiver"},
                    receiver_03 =       {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_ak_receiver_01",  type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                }
            ),
            autogun_p3_m1 = table.combine(
                _flashlight_models("barrel", -2.5, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_right_models("receiver", -3, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _emblem_left_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(.2, 0, 0)),
                _bayonet_models({"barrel", "barrel", "barrel", "muzzle"}, -.5, Vector3Box(.1, 0, 0), Vector3Box(0, .4, -.025)),
                _grip_models(nil, -.1, Vector3Box(-.1, 0, 0), Vector3Box(0, -.1, -.1)),
                _reflex_sights_models("rail", -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _sights_models(nil, -.5, Vector3Box(0, 0, -.05), Vector3Box(0, -.2, 0)),
                _stock_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, -.2, 0)),
                _autogun_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _autogun_headhunter_barrel_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _lasgun_rail_models("receiver", 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, .2)),
                _autogun_muzzle_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, .2, 0)),
                _autogun_magazine_models(nil, 0, Vector3Box(0, 0, 0), Vector3Box(0, 0, -.2)),
                _trinket_hook_models(),
                {
                    receiver_default =  {model = "",                                                                                    type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    receiver_01 =       {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_receiver_01",             type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    receiver_02 =       {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_killshot_receiver_01",    type = "receiver", angle = 0, move = Vector3Box(0, 0, 0), remove = Vector3Box(0, 0, -.00001)},
                    -- receiver_03 = {model = "content/items/weapons/player/ranged/recievers/autogun_rifle_ak_receiver_01", type = "receiver"},
                }
            ),
            lasgun_p1_m1 = table.combine(
                _flashlight_models(),
                _emblem_right_models(),
                _emblem_left_models(),
                _bayonet_models(),
                _grip_models(),
                _lasgun_barrel_models(),
                _lasgun_muzzle_models(),
                _lasgun_rail_models(),
                _reflex_sights_models(),
                _sights_models(),
                _stock_models(),
                {
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_receiver_01", type = "receiver"},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/lasgun_rifle_magazine_01", type = "magazine"},
                }
            ),
            lasgun_p2_m1 = table.combine(
                _flashlight_models(),
                _emblem_right_models(),
                _emblem_left_models(),
                _bayonet_models(),
                _grip_models(),
                _lasgun_barrel_models(),
                _lasgun_muzzle_models(),
                _lasgun_rail_models(),
                _reflex_sights_models(),
                _sights_models(),
                {
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_krieg_receiver_01", type = "receiver"},
                    receiver_02 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_krieg_receiver_02", type = "receiver"},
                    receiver_03 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_krieg_receiver_04", type = "receiver"},
                    stock_default = {model = "", type = "stock", angle = .5},
                    stock_01 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_krieg_stock_01", type = "stock", angle = .5},
                    stock_02 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_krieg_stock_02", type = "stock", angle = .5},
                    stock_03 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_krieg_stock_04", type = "stock", angle = .5},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/lasgun_rifle_magazine_01", type = "magazine"},
                }
            ),
            lasgun_p3_m1 = table.combine(
                _flashlight_models(),
                _emblem_right_models(),
                _emblem_left_models(),
                _bayonet_models(),
                _grip_models(),
                _lasgun_barrel_models(),
                _lasgun_muzzle_models(),
                _lasgun_rail_models(),
                _reflex_sights_models(),
                _sights_models(),
                {
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_01", type = "receiver"},
                    receiver_02 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_02", type = "receiver"},
                    receiver_03 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_03", type = "receiver"},
                    receiver_04 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_04", type = "receiver"},
                    receiver_05 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_05", type = "receiver"},
                    receiver_06 = {model = "content/items/weapons/player/ranged/recievers/lasgun_rifle_elysian_receiver_06", type = "receiver"},
                    stock_default = {model = "", type = "stock", angle = .5},
                    stock_01 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_elysian_stock_01", type = "stock", angle = .5},
                    stock_02 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_elysian_stock_02", type = "stock", angle = .5},
                    stock_03 = {model = "content/items/weapons/player/ranged/stocks/lasgun_rifle_elysian_stock_03", type = "stock", angle = .5},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/lasgun_elysian_magazine_01", type = "magazine"},
                }
            ),
            flamer_p1_m1 = table.combine(
                _flashlight_models(),
                _emblem_right_models(),
                _emblem_left_models(),
                -- _grip_models(),
                _trinket_hook_models(),
                {
                    receiver_default = {model = "", type = "receiver"},
                    receiver_01 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_01", type = "receiver"},
                    receiver_02 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_02", type = "receiver"},
                    receiver_03 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_03", type = "receiver"},
                    receiver_04 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_04", type = "receiver"},
                    receiver_05 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_05", type = "receiver"},
                    receiver_06 = {model = "content/items/weapons/player/ranged/recievers/flamer_rifle_receiver_06", type = "receiver"},
                    magazine_default = {model = "", type = "magazine"},
                    magazine_01 = {model = "content/items/weapons/player/ranged/magazines/flamer_rifle_magazine_01", type = "magazine"},
                    magazine_02 = {model = "content/items/weapons/player/ranged/magazines/flamer_rifle_magazine_02", type = "magazine"},
                    magazine_03 = {model = "content/items/weapons/player/ranged/magazines/flamer_rifle_magazine_03", type = "magazine"},
                    barrel_default = {model = "", type = "barrel"},
                    barrel_01 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_01", type = "barrel"},
                    barrel_02 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_02", type = "barrel"},
                    barrel_03 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_03", type = "barrel"},
                    barrel_04 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_04", type = "barrel"},
                    barrel_05 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_05", type = "barrel"},
                    barrel_06 = {model = "content/items/weapons/player/ranged/barrels/flamer_rifle_barrel_06", type = "barrel"},
                    flamer_grip_default = {model = "", type = "grip"},
                    flamer_grip_01 = {model = "content/items/weapons/player/ranged/grips/flamer_rifle_grip_01", type = "grip"},
                    flamer_grip_02 = {model = "content/items/weapons/player/ranged/grips/flamer_rifle_grip_02", type = "grip"},
                    flamer_grip_03 = {model = "content/items/weapons/player/ranged/grips/flamer_rifle_grip_03", type = "grip"},
                    -- plasma_grip_01 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_01", type = "grip"},
                    -- plasma_grip_02 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_02", type = "grip"},
                    -- plasma_grip_03 = {model = "content/items/weapons/player/ranged/grips/plasma_rifle_grip_03", type = "grip"},
                }
            ),
            forcestaff_p1_m1 = {
                customization_default_position = Vector3Box(0, 8, .75),
                shaft_lower_default = {model = "", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_lower_01 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_lower_01", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_lower_02 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_lower_02", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_lower_03 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_lower_03", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_lower_04 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_lower_04", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_lower_05 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_lower_05", type = "shaft_lower", move = Vector3Box(-.75, -4, .5)},
                shaft_upper_default = {model = "", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                shaft_upper_01 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_upper_01", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                shaft_upper_02 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_upper_02", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                shaft_upper_03 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_upper_03", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                shaft_upper_04 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_upper_04", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                shaft_upper_05 = {model = "content/items/weapons/player/ranged/shafts/force_staff_shaft_upper_05", type = "shaft_upper", move = Vector3Box(-.25, -5.5, -.4)},
                body_default = {model = "", type = "body", move = Vector3Box(.1, -7, -.65)},
                body_01 = {model = "content/items/weapons/player/melee/full/force_staff_full_01", type = "body", move = Vector3Box(.1, -7, -.65)},
                body_02 = {model = "content/items/weapons/player/melee/full/force_staff_full_02", type = "body", move = Vector3Box(.1, -7, -.65)},
                body_03 = {model = "content/items/weapons/player/melee/full/force_staff_full_03", type = "body", move = Vector3Box(.1, -7, -.65)},
                body_04 = {model = "content/items/weapons/player/melee/full/force_staff_full_04", type = "body", move = Vector3Box(.1, -7, -.65)},
                body_05 = {model = "content/items/weapons/player/melee/full/force_staff_full_05", type = "body", move = Vector3Box(.1, -7, -.65)},
                head_default = {model = "", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_01 = {model = "content/items/weapons/player/melee/heads/force_staff_head_01", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_02 = {model = "content/items/weapons/player/melee/heads/force_staff_head_02", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_03 = {model = "content/items/weapons/player/melee/heads/force_staff_head_03", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_04 = {model = "content/items/weapons/player/melee/heads/force_staff_head_04", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_05 = {model = "content/items/weapons/player/melee/heads/force_staff_head_05", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_06 = {model = "content/items/weapons/player/melee/heads/force_staff_head_06", type = "head", move = Vector3Box(.15, -8.5, -.8)},
                head_07 = {model = "content/items/weapons/player/melee/heads/force_staff_head_07", type = "head", move = Vector3Box(.15, -8.5, -.8)},
            },
        --#endregion
        --#region Melee
            combataxe_p1_m1 = table.combine(
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
                _axe_grip_models(),
                _axe_head_models(),
                _pommel_models()
            ),
            combataxe_p2_m1 = table.combine(
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
                _axe_grip_models(),
                _axe_head_models(),
                _pommel_models()
            ),
            combatknife_p1_m1 = table.combine(
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
                {
                    shovel_head_default = {model = "", type = "head"},
                    shovel_head_01 = {model = "content/items/weapons/player/melee/heads/shovel_head_01", type = "head"},
                    shovel_head_02 = {model = "content/items/weapons/player/melee/heads/shovel_head_02", type = "head"},
                    shovel_head_03 = {model = "content/items/weapons/player/melee/heads/shovel_head_03", type = "head"},
                    shovel_head_04 = {model = "content/items/weapons/player/melee/heads/shovel_head_04", type = "head"},
                    shovel_head_05 = {model = "content/items/weapons/player/melee/heads/shovel_head_05", type = "head"},
                    shovel_pommel_default = {model = "", type = "pommel"},
                    shovel_pommel_01 = {model = "content/items/weapons/player/melee/full/prologue_shovel_full_01", type = "pommel", automatic_equip = {head = "shovel_head_default"}},
                    shovel_pommel_02 = {model = "content/items/weapons/player/melee/full/krieg_shovel_full_01", type = "pommel", automatic_equip = {head = "shovel_head_default"}},
                    shovel_pommel_03 = {model = "content/items/weapons/player/melee/pommels/shovel_pommel_01", type = "pommel"},
                    shovel_pommel_04 = {model = "content/items/weapons/player/melee/pommels/shovel_pommel_02", type = "pommel"},
                    shovel_pommel_05 = {model = "content/items/weapons/player/melee/pommels/shovel_pommel_03", type = "pommel"},
                    shovel_pommel_06 = {model = "content/items/weapons/player/melee/pommels/shovel_pommel_04", type = "pommel"},
                    shovel_pommel_07 = {model = "content/items/weapons/player/melee/pommels/shovel_pommel_05", type = "pommel"},
                }
            ),
            combatsword_p1_m1 = table.combine(
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                {customization_default_position = Vector3Box(0, 3, .35)},
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
                {
                    thunder_hammer_shaft_default = {model = "", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_shaft_01 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_01", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_shaft_02 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_02", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_shaft_03 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_03", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_shaft_04 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_04", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_shaft_05 = {model = "content/items/weapons/player/ranged/shafts/thunder_hammer_shaft_05", type = "shaft", move = Vector3Box(-.5, -3, .3)},
                    thunder_hammer_pommel_default = {model = "", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_pommel_01 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_01", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_pommel_02 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_05", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_pommel_03 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_03", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_pommel_04 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_04", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_pommel_05 = {model = "content/items/weapons/player/melee/pommels/thunder_hammer_pommel_05", type = "pommel", move = Vector3Box(-.75, -4, .5)},
                    thunder_hammer_connector_default = {model = "", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_connector_01 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_01", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_connector_02 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_02", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_connector_03 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_03", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_connector_04 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_04", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_connector_05 = {model = "content/items/weapons/player/melee/connectors/thunder_hammer_connector_05", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    thunder_hammer_head_default = {model = "", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                    thunder_hammer_head_01 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_01", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                    thunder_hammer_head_02 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_02", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                    thunder_hammer_head_03 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_03", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                    thunder_hammer_head_04 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_04", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                    thunder_hammer_head_05 = {model = "content/items/weapons/player/melee/heads/thunder_hammer_head_05", type = "head", move = Vector3Box(.15, -6.5, -.4)},
                }
            ),
            powermaul_2h_p1_m1 = table.combine(
                {customization_default_position = Vector3Box(0, 2, .35)},
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
                {
                    ["2h_power_maul_shaft_default"] = {model = "", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_01"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_01", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_02"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_02", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_03"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_03", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_04"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_04", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_shaft_05"] = {model = "content/items/weapons/player/melee/shafts/2h_power_maul_shaft_05", type = "shaft", move = Vector3Box(-.3, -3, .2)},
                    ["2h_power_maul_pommel_default"] = {model = "", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_01"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_01", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_02"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_05", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_03"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_03", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_04"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_04", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_pommel_05"] = {model = "content/items/weapons/player/melee/pommels/2h_power_maul_pommel_05", type = "pommel", move = Vector3Box(-.5, -4, .5)},
                    ["2h_power_maul_connector_default"] = {model = "", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_01"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_01", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_02"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_02", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_03"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_03", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_04"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_04", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_connector_05"] = {model = "content/items/weapons/player/melee/connectors/2h_power_maul_connector_05", type = "connector", move = Vector3Box(0, -5.5, -.4)},
                    ["2h_power_maul_head_default"] = {model = "", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_01"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_01", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_02"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_02", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_03"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_03", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_04"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_04", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                    ["2h_power_maul_head_05"] = {model = "content/items/weapons/player/melee/heads/2h_power_maul_head_05", type = "head", move = Vector3Box(.05, -4.5, -.5)},
                }
            ),
            chainsword_2h_p1_m1 = table.combine(
                -- {customization_default_position = Vector3Box(0, 2, .35)},
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
                _emblem_right_models(),
                _emblem_left_models(),
                _trinket_hook_models(),
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
            -- mod.attachment_models.autogun_p2_m1 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p2_m2 = mod.attachment_models.autogun_p2_m1
            mod.attachment_models.autogun_p2_m3 = mod.attachment_models.autogun_p2_m1
            -- mod.attachment_models.autogun_p3_m1 = mod.attachment_models.autogun_p1_m1
            mod.attachment_models.autogun_p3_m2 = mod.attachment_models.autogun_p3_m1
            mod.attachment_models.autogun_p3_m3 = mod.attachment_models.autogun_p3_m1
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