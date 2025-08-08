local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/autogun_p1_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

return {
    weapon_sling_attachments = function(default)
        local attachments = {
            {id = "weapon_sling_01", name = "Weapon Sling 1"},
            {id = "weapon_sling_02", name = "Weapon Sling 2"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    weapon_sling_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "default",         model = ""},
            {name = "weapon_sling_01", model = "core/units/empty_root"},
            {name = "weapon_sling_02", model = "core/units/empty_root"},
        }, parent, angle, move, remove, type or "weapon_sling", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    flashlights_attachments = function(default)
        local attachments = {
            {id = "flashlight_01",            name = mod:localize("mod_attachment_flashlight_01")},
            {id = "flashlight_02",            name = mod:localize("mod_attachment_flashlight_02")},
            {id = "flashlight_03",            name = mod:localize("mod_attachment_flashlight_03")},
            {id = "flashlight_04",            name = mod:localize("mod_attachment_flashlight_04")},
            {id = "flashlight_ogryn_01",      name = mod:localize("mod_attachment_flashlight_05")},
            {id = "flashlight_ogryn_long_01", name = mod:localize("mod_attachment_flashlight_06")},
            {id = "laser_pointer",            name = mod:localize("mod_attachment_laser_pointer")},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    flashlight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        local flashlight_data = {
            {{loc_flashlight_light_cone = 3}, {loc_flashlight_intensity = 2}, {loc_flashlight_battery = 3}},
            {{loc_flashlight_light_cone = 1}, {loc_flashlight_intensity = 2}, {loc_flashlight_battery = 4}},
            {{loc_flashlight_light_cone = 4}, {loc_flashlight_intensity = 3}, {loc_flashlight_battery = 1}},
            {{loc_flashlight_light_cone = 2}, {loc_flashlight_intensity = 4}, {loc_flashlight_battery = 2}},
            {{loc_flashlight_light_cone = 2}, {loc_flashlight_intensity = 2}, {loc_flashlight_battery = 2}},
        }
        return table.model_table({
            {name = "default",                  model = ""},
            {name = "flashlight_01",            model = _item_ranged.."/flashlights/flashlight_01", data = flashlight_data[1]},
            {name = "flashlight_02",            model = _item_ranged.."/flashlights/flashlight_02", data = flashlight_data[2]},
            {name = "flashlight_03",            model = _item_ranged.."/flashlights/flashlight_03", data = flashlight_data[3]},
            {name = "flashlight_04",            model = _item_ranged.."/flashlights/flashlight_05", data = flashlight_data[4]},
            {name = "flashlight_ogryn_01",      model = _item_ranged.."/flashlights/flashlight_ogryn_01", data = flashlight_data[3]},
            {name = "flashlight_ogryn_long_01", model = _item_ranged.."/flashlights/flashlight_ogryn_long_01", data = flashlight_data[4]},
            {name = "laser_pointer",            model = _item_ranged.."/flashlights/flashlight_05", data = flashlight_data[5]},
        }, parent, angle, move, remove, type or "flashlight", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01",      name = "Grip 1"},
            {id = "grip_02",      name = "Grip 2"},
            {id = "grip_03",      name = "Grip 3"},
            {id = "grip_04",      name = "Grip 4"},
            {id = "grip_05",      name = "Grip 5"},
            {id = "grip_06",      name = "Autogun 1"},
            {id = "grip_07",      name = "Autogun 2"},
            {id = "grip_08",      name = "Autogun 3"},
            {id = "grip_43",      name = "Autogun 4"},
            {id = "grip_09",      name = "Braced Autogun 1"},
            {id = "grip_10",      name = "Braced Autogun 2"},
            {id = "grip_11",      name = "Braced Autogun 3"},
            {id = "grip_31",      name = "Braced Autogun 4"},
            {id = "grip_32",      name = "Braced Autogun 5"},
            {id = "grip_44",      name = "Braced Autogun 6"},
            {id = "grip_12",      name = "Headhunter Autogun 1"},
            {id = "grip_45",      name = "Headhunter Autogun 2"},
            {id = "grip_30",      name = "Boltgun Pistol 1"},
            {id = "grip_35",      name = "Boltgun Pistol 2"},
            {id = "grip_36",      name = "Boltgun Pistol 3"},
            {id = "grip_37",      name = "Boltgun Pistol 4"},
            {id = "grip_13",      name = "Boltgun 1"},
            {id = "grip_14",      name = "Boltgun 2"},
            {id = "grip_15",      name = "Boltgun 3"},
            {id = "grip_34",      name = "Boltgun 4"},
            {id = "grip_47",      name = "Boltgun 5"},
            {id = "grip_38",      name = "Boltgun 6"},
            {id = "grip_19",      name = "Laspistol 1"},
            {id = "grip_20",      name = "Laspistol 2"},
            {id = "grip_21",      name = "Laspistol 3"},
            {id = "grip_33",      name = "Laspistol 4"},
            {id = "grip_39",      name = "Laspistol 5"},
            {id = "grip_40",      name = "Laspistol 6"},
            {id = "grip_22",      name = "Lasgun 1"},
            {id = "grip_23",      name = "Lasgun 2"},
            {id = "grip_24",      name = "Lasgun 3"},
            {id = "grip_48",      name = "Lasgun 4"},
            {id = "grip_25",      name = "Lasgun 5"},
            {id = "grip_26",      name = "Lasgun 6"},
            {id = "grip_46",      name = "Lasgun 7"},
            {id = "grip_27",      name = "Flamer 1"},
            {id = "grip_28",      name = "Flamer 2"},
            {id = "grip_29",      name = "Flamer 3"},
            {id = "grip_41",      name = "Flamer 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_ranged.."/grips/grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/grip_03"},
            {name = "grip_04",      model = _item_ranged.."/grips/grip_04"},
            {name = "grip_05",      model = _item_ranged.."/grips/grip_05"},
            {name = "grip_06",      model = _item_ranged.."/grips/autogun_rifle_grip_01"},
            {name = "grip_07",      model = _item_ranged.."/grips/autogun_rifle_grip_02"},
            {name = "grip_08",      model = _item_ranged.."/grips/autogun_rifle_grip_03"},
            {name = "grip_09",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_01"},
            {name = "grip_10",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_02"},
            {name = "grip_11",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_03"},
            {name = "grip_12",      model = _item_ranged.."/grips/autogun_rifle_grip_killshot_01"},
            {name = "grip_13",      model = _item_ranged.."/grips/boltgun_rifle_grip_01"},
            {name = "grip_14",      model = _item_ranged.."/grips/boltgun_rifle_grip_02"},
            {name = "grip_15",      model = _item_ranged.."/grips/boltgun_rifle_grip_03"},
            {name = "grip_19",      model = _item_ranged.."/grips/lasgun_pistol_grip_01"},
            {name = "grip_20",      model = _item_ranged.."/grips/lasgun_pistol_grip_02"},
            {name = "grip_21",      model = _item_ranged.."/grips/lasgun_pistol_grip_03"},
            {name = "grip_22",      model = _item_ranged.."/grips/lasgun_rifle_grip_01"},
            {name = "grip_23",      model = _item_ranged.."/grips/lasgun_rifle_grip_02"},
            {name = "grip_24",      model = _item_ranged.."/grips/lasgun_rifle_grip_03"},
            {name = "grip_25",      model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_02"},
            {name = "grip_26",      model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_03"},
            {name = "grip_27",      model = _item_ranged.."/grips/flamer_rifle_grip_01"},
            {name = "grip_28",      model = _item_ranged.."/grips/flamer_rifle_grip_02"},
            {name = "grip_29",      model = _item_ranged.."/grips/flamer_rifle_grip_03"},
            {name = "grip_30",      model = _item_ranged.."/grips/boltgun_pistol_grip_01"},
            {name = "grip_31",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_04"},
            {name = "grip_32",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_05"},
            {name = "grip_33",      model = _item_ranged.."/grips/lasgun_pistol_grip_04"},
            {name = "grip_34",      model = _item_ranged.."/grips/boltgun_rifle_grip_04"},
            {name = "grip_35",      model = _item_ranged.."/grips/boltgun_pistol_grip_02"},
            {name = "grip_36",      model = _item_ranged.."/grips/boltgun_pistol_grip_03"},
            {name = "grip_37",      model = _item_ranged.."/grips/boltgun_pistol_grip_ml01"},
            {name = "grip_38",      model = _item_ranged.."/grips/boltgun_rifle_grip_ml01"},
            {name = "grip_39",      model = _item_ranged.."/grips/lasgun_pistol_grip_05"},
            {name = "grip_40",      model = _item_ranged.."/grips/lasgun_pistol_grip_ml01"},
            {name = "grip_41",      model = _item_ranged.."/grips/flamer_rifle_grip_04"},
            {name = "grip_42",      model = _item_ranged.."/grips/flamer_rifle_grip_ml01"},
            {name = "grip_43",      model = _item_ranged.."/grips/autogun_rifle_grip_ml01"},
            {name = "grip_44",      model = _item_ranged.."/grips/autogun_rifle_grip_ak_ml01"},
            {name = "grip_45",      model = _item_ranged.."/grips/autogun_rifle_grip_killshot_ml01"},
            {name = "grip_46",      model = _item_ranged.."/grips/lasgun_rifle_elysian_grip_ml01"},
            {name = "grip_47",      model = _item_ranged.."/grips/boltgun_rifle_grip_05"},
            {name = "grip_48",      model = _item_ranged.."/grips/lasgun_rifle_grip_04"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    bayonet_none = function()
        return {
            {id = "autogun_bayonet_default", name = mod:localize("mod_attachment_none")},
        }
    end,
    bayonet_attachments = function(default)
        local attachments= {
            {id = "autogun_bayonet_01",      name = "Bayonet 1"},
            {id = "autogun_bayonet_02",      name = "Bayonet 2"},
            {id = "autogun_bayonet_03",      name = "Bayonet 3"},
            {id = "autogun_bayonet_05",      name = "Bayonet 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "autogun_bayonet_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    bayonet_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "autogun_bayonet_default", model = ""},
            {name = "autogun_bayonet_01",      model = _item_ranged.."/bayonets/bayonet_01"},
            {name = "autogun_bayonet_02",      model = _item_ranged.."/bayonets/bayonet_02"},
            {name = "autogun_bayonet_03",      model = _item_ranged.."/bayonets/bayonet_03"},
            {name = "autogun_bayonet_05",      model = _item_ranged.."/bayonets/bayonet_05"},
            {name = "autogun_bayonet_none",    model = ""},
        }, parent, angle, move, remove, type or "bayonet", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    reflex_sights_attachments = function(default, none)
        local attachments = {
            {id = "reflex_sight_01", name = "Reflex Sight 1"},
            {id = "reflex_sight_02", name = "Reflex Sight 2"},
            {id = "reflex_sight_03", name = "Reflex Sight 3"},
            -- {id = "sight_none",      name = ""},
        }
        if none then attachments[#attachments+1] = {id = "sight_none",      name = ""} end
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    reflex_sights_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sight_default",   model = ""},
            {name = "reflex_sight_01", model = _item_ranged.."/sights/reflex_sight_01"},
            {name = "reflex_sight_02", model = _item_ranged.."/sights/reflex_sight_02"},
            {name = "reflex_sight_03", model = _item_ranged.."/sights/reflex_sight_03"},
            {name = "sight_none",      model = ""},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
            {rail = "rail_01"},
            {rail = "rail_01"},
            {rail = "rail_default"},
        }, hide_mesh, mesh_move)
    end,

    scope_sights_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "scope_sight_01",   model = _item_ranged.."/sights/reflex_sight_01"},
            {name = "scope_sight_02",   model = _item_ranged.."/sights/reflex_sight_02"},
            {name = "scope_sight_03",   model = _item_ranged.."/sights/reflex_sight_03"},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip or {
            {rail = "rail_01"},
            {rail = "rail_01"},
            {rail = "rail_01"},
        }, hide_mesh, mesh_move)
    end,

    scope_lens_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "scope_lens_default",   model = ""},
            {name = "scope_lens_01",   model = _item_ranged.."/flashlights/flashlight_01"},
            {name = "scope_lens_02",   model = _item_ranged.."/bullets/rippergun_rifle_bullet_01"},
        }, parent, angle, move, remove, type or "lens", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    scope_lens_2_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "scope_lens_default",   model = ""},
            {name = "scope_lens_2_01",   model = _item_ranged.."/flashlights/flashlight_01"},
            {name = "scope_lens_2_02",   model = _item_ranged.."/bullets/rippergun_rifle_bullet_01"},
        }, parent, angle, move, remove, type or "lens_2", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    sight_default = function()
        return {
            {id = "sight_default", name = mod:localize("mod_attachment_default")}
        }
    end,
    sight_none = function()
        return {
            {id = "sight_none", name = mod:localize("mod_attachment_none")}
        }
    end,
    scopes_attachments = function(default)
        local attachments = {
            {id = "scope_03", name = mod:localize("mod_attachment_scope_03")},
            {id = "scope_01", name = mod:localize("mod_attachment_scope_01")},
            {id = "scope_02", name = mod:localize("mod_attachment_scope_02")},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sights_attachments = function(default)
        local attachments = {
            {id = "autogun_rifle_sight_01",          name = "Autogun"},
            {id = "autogun_rifle_ak_sight_01",       name = "Braced Autogun"},
            {id = "autogun_rifle_killshot_sight_01", name = "Headhunter Autogun"},
            {id = "lasgun_rifle_sight_01",           name = "Lasgun"},
            {id = "scope_03",                        name = mod:localize("mod_attachment_scope_03")},
            {id = "scope_01",                        name = mod:localize("mod_attachment_scope_01")},
            {id = "scope_02",                        name = mod:localize("mod_attachment_scope_02")},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "sight_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sights_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "sight_default",                   model = ""},
            {name = "autogun_rifle_ak_sight_01",       model = _item_ranged.."/sights/autogun_rifle_ak_sight_01"},
            {name = "autogun_rifle_sight_01",          model = _item_ranged.."/sights/autogun_rifle_sight_01"},
            {name = "autogun_rifle_killshot_sight_01", model = _item_ranged.."/sights/autogun_rifle_killshot_sight_01"},
            {name = "lasgun_rifle_sight_01",           model = _item_ranged.."/sights/lasgun_rifle_sight_01"},
            -- content/items/weapons/player/ranged/scopes/scope_1
            {name = "scope_01",                        model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_02"},
            {name = "scope_02",                        model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_04"},
            {name = "scope_03",                        model = _item_ranged.."/muzzles/lasgun_rifle_krieg_muzzle_05"},
            {name = "sight_none",                      model = ""},
        }, parent, angle, move, remove, type or "sight", no_support, automatic_equip or {
            {rail = "rail_default"},
            {rail = "rail_01"},
        }, hide_mesh, mesh_move)
    end,

    stock_attachments = function(default)
        local attachments = {
            {id = "no_stock",               name = mod:localize("mod_attachment_no_stock")},
            {id = "stock_01",               name = "Stock 1"},
            {id = "stock_02",               name = "Stock 2"},
            {id = "stock_03",               name = "Stock 3"},
            {id = "stock_04",               name = "Stock 4"},
            {id = "stock_05",               name = "Stock 5"},
            {id = "autogun_rifle_stock_01", name = "Infantry Autogun 1"},
            {id = "autogun_rifle_stock_02", name = "Infantry Autogun 2"},
            {id = "autogun_rifle_stock_03", name = "Infantry Autogun 3"},
            {id = "autogun_rifle_stock_04", name = "Infantry Autogun 4"},
            {id = "autogun_rifle_stock_ml01", name = "Infantry Autogun 5"},
            {id = "autogun_rifle_stock_05", name = "Braced Autogun 1"},
            {id = "autogun_rifle_stock_06", name = "Braced Autogun 2"},
            {id = "autogun_rifle_stock_07", name = "Braced Autogun 3"},
            {id = "autogun_rifle_stock_08", name = "Headhunter Autogun 1"},
            {id = "autogun_rifle_stock_09", name = "Headhunter Autogun 2"},
            {id = "autogun_rifle_killshot_stock_ml01", name = "Headhunter Autogun 3"},
            {id = "lasgun_stock_01",        name = "Infantry Lasgun 1"},
            {id = "lasgun_stock_02",        name = "Infantry Lasgun 2"},
            {id = "lasgun_stock_03",        name = "Infantry Lasgun 3"},
            {id = "lasgun_stock_04",        name = "Infantry Lasgun 4"},
            {id = "lasgun_stock_05",        name = "Infantry Lasgun 5"},
            {id = "autogun_rifle_stock_10", name = "Braced Autogun 4"},
            {id = "autogun_rifle_stock_11", name = "Braced Autogun 5"},
            {id = "autogun_rifle_stock_12", name = "Braced Autogun 6"},
            {id = "autogun_rifle_stock_13", name = "Braced Autogun 7"},
            {id = "autogun_rifle_stock_14", name = "Braced Autogun 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "stock_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "stock_default",          model = ""},
            {name = "no_stock",               model = ""},
            {name = "stock_01",               model = _item_ranged.."/stocks/stock_01"},
            {name = "stock_02",               model = _item_ranged.."/stocks/stock_02"},
            {name = "stock_03",               model = _item_ranged.."/stocks/stock_03"},
            {name = "stock_04",               model = _item_ranged.."/stocks/stock_04"},
            {name = "stock_05",               model = _item_ranged.."/stocks/stock_05"},
            {name = "autogun_rifle_stock_01", model = _item_ranged.."/stocks/autogun_rifle_stock_01"},
            {name = "autogun_rifle_stock_02", model = _item_ranged.."/stocks/autogun_rifle_stock_02"},
            {name = "autogun_rifle_stock_03", model = _item_ranged.."/stocks/autogun_rifle_stock_03"},
            {name = "autogun_rifle_stock_04", model = _item_ranged.."/stocks/autogun_rifle_stock_04"},
            {name = "autogun_rifle_stock_ml01", model = _item_ranged.."/stocks/autogun_rifle_stock_ml01"},
            {name = "autogun_rifle_stock_05", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_01"},
            {name = "autogun_rifle_stock_06", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_02"},
            {name = "autogun_rifle_stock_07", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_03"},
            {name = "autogun_rifle_stock_10", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_04"},
            {name = "autogun_rifle_stock_11", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_05"},
            {name = "autogun_rifle_stock_12", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_06"},
            {name = "autogun_rifle_stock_13", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_07"},
            {name = "autogun_rifle_stock_14", model = _item_ranged.."/stocks/autogun_rifle_ak_stock_ml01"},
            {name = "autogun_rifle_stock_08", model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_01"},
            {name = "autogun_rifle_stock_09", model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_02"},
            {name = "autogun_rifle_killshot_stock_ml01", model = _item_ranged.."/stocks/autogun_rifle_killshot_stock_ml01"},
            {name = "lasgun_stock_01",        model = _item_ranged.."/stocks/lasgun_rifle_stock_01"},
            {name = "lasgun_stock_02",        model = _item_ranged.."/stocks/lasgun_rifle_stock_02"},
            {name = "lasgun_stock_03",        model = _item_ranged.."/stocks/lasgun_rifle_stock_03"},
            {name = "lasgun_stock_04",        model = _item_ranged.."/stocks/lasgun_rifle_stock_04"},
            {name = "lasgun_stock_05",        model = _item_ranged.."/stocks/lasgun_rifle_stock_05"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move)
    end,

    ogryn_bayonet_attachments = function(default)
        local attachments = {
            {id = "bayonet_01",       name = "Bayonet 1"},
            {id = "bayonet_02",       name = "Bayonet 2"},
            {id = "bayonet_03",       name = "Bayonet 3"},
            {id = "bayonet_04",       name = "Bayonet 4"},
            {id = "bayonet_05",       name = "Bayonet 5"},
            {id = "bayonet_06",       name = "Bayonet 6"},
            {id = "bayonet_blade_01", name = "Blade"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "bayonet_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    ogryn_bayonet_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "bayonet_default",  model = ""},
            {name = "bayonet_01",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_01"},
            {name = "bayonet_02",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_02"},
            {name = "bayonet_03",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_03"},
            {name = "bayonet_04",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_04"},
            {name = "bayonet_05",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_ml01"},
            {name = "bayonet_blade_01", model = _item_melee.."/blades/combat_sword_blade_01"},
            {name = "bayonet_06",       model = _item_ranged.."/bayonets/rippergun_rifle_bayonet_05"},
        }, parent, angle, move, remove, type or "bayonet", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    
    magazine_attachments = function(default)
        local attachments = {
            {id = "magazine_01",             name = "Autogun 1"},
            {id = "magazine_02",             name = "Autogun 2"},
            {id = "magazine_03",             name = "Autogun 3"},
            {id = "magazine_04",             name = "Autogun 4"},
            {id = "auto_pistol_magazine_01", name = "Autopistol 1"},
            {id = "bolter_magazine_01",      name = "Bolter 1"},
            {id = "bolter_magazine_02",      name = "Bolter 2"},
            {id = "boltpistol_magazine_01",  name = "Boltpistol 1"},
            {id = "boltpistol_magazine_02",  name = "Boltpistol 2"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default",        model = ""},
            {name = "magazine_01",             model = _item_ranged.."/magazines/autogun_rifle_magazine_01"},
            {name = "magazine_02",             model = _item_ranged.."/magazines/autogun_rifle_magazine_02"},
            {name = "magazine_03",             model = _item_ranged.."/magazines/autogun_rifle_magazine_03"},
            {name = "magazine_04",             model = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01"},
            {name = "auto_pistol_magazine_01", model = _item_ranged.."/magazines/autogun_pistol_magazine_01"},
            {name = "bolter_magazine_01",      model = _item_ranged.."/magazines/boltgun_rifle_magazine_01"},
            {name = "bolter_magazine_02",      model = _item_ranged.."/magazines/boltgun_rifle_magazine_02"},
            {name = "boltpistol_magazine_01",  model = _item_ranged.."/magazines/boltgun_pistol_magazine_01"},
            {name = "boltpistol_magazine_02",  model = _item_ranged.."/magazines/boltgun_pistol_magazine_02"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
}