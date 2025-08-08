local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _chainaxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/chainaxe_p1_m1")
    local _combataxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p1_m1")
    local _combataxe_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p2_m1")
    local _combataxe_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p3_m1")
    local _forcesword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/forcesword_p1_m1")
    local _forcesword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/forcesword_2h_p1_m1")
    local _ogryn_club_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_club_p1_m1")
    local _ogryn_powermaul_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_powermaul_p1_m1")
    local _powermaul_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powermaul_2h_p1_m1")
    local _powersword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powersword_p1_m1")
    local _powersword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/powersword_2h_p1_m1")
    local _thunderhammer_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/thunderhammer_2h_p1_m1")
    local _forcestaff_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/forcestaff_p1_m1")
    local _ogryn_pickaxe_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_pickaxe_2h_p1_m1")
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _item = "content/items/weapons/player"
    local _item_ranged = _item.."/ranged"
    local _item_melee = _item.."/melee"
    local _item_minion = "content/items/weapons/minions"
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local string = string
    local string_find = string.find
    local vector3_box = Vector3Box
    local table = table
    local table_icombine = table.icombine
    local table_combine = table.combine
    local table_model_table = table.model_table
    local table_merge_recursive = table.merge_recursive
    local tv = table.tv
    local pairs = pairs
    local ipairs = ipairs
    local type = type
--#endregion

--#region Old
    -- head_attachments = function(default)
    --     local attachments = {
    --         {id = "head_01", name = "Head 1"},
    --         {id = "head_02", name = "Head 2"},
    --         {id = "head_03", name = "Head 3"},
    --         {id = "head_04", name = "Head 4"},
    --         {id = "head_05", name = "Head 5"},
    --     }
    --     if default == nil then default = true end
    --     if default then return table.icombine(
    --         {{id = "head_default", name = mod:localize("mod_attachment_default")}},
    --         attachments)
    --     else return attachments end
    -- end,
    -- head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
    --     if mesh_move == nil then mesh_move = false end
    --     return table.model_table({
    --         {name = "head_default", model = ""},
    --         {name = "head_01",      model = _item_melee.."/heads/power_maul_head_01"},
    --         {name = "head_02",      model = _item_melee.."/heads/power_maul_head_02"},
    --         {name = "head_03",      model = _item_melee.."/heads/power_maul_head_03"},
    --         {name = "head_04",      model = _item_melee.."/heads/power_maul_head_04"},
    --         {name = "head_05",      model = _item_melee.."/heads/power_maul_head_05"},
    --     }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move)
    -- end,

    -- head_attachments = function()
    --     return {
    --         {id = "2h_power_maul_head_default", name = mod:localize("mod_attachment_default")},
    --         {id = "2h_power_maul_head_01",      name = "Head 1"},
    --         {id = "2h_power_maul_head_02",      name = "Head 2"},
    --         {id = "2h_power_maul_head_03",      name = "Head 3"},
    --         {id = "2h_power_maul_head_04",      name = "Head 4"},
    --         {id = "2h_power_maul_head_05",      name = "Head 5"},
    --     }
    -- end,
    -- head_models = function(parent, angle, move, remove)
    --     local a = angle or 0
    --     local m = move or vector3_box(0, 0, 0)
    --     local r = remove or vector3_box(0, 0, 0)
    --     return {
    --         ["2h_power_maul_head_default"] = {model = "",                                          type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --         ["2h_power_maul_head_01"] =      {model = _item_melee.."/heads/2h_power_maul_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --         ["2h_power_maul_head_02"] =      {model = _item_melee.."/heads/2h_power_maul_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --         ["2h_power_maul_head_03"] =      {model = _item_melee.."/heads/2h_power_maul_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --         ["2h_power_maul_head_04"] =      {model = _item_melee.."/heads/2h_power_maul_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --         ["2h_power_maul_head_05"] =      {model = _item_melee.."/heads/2h_power_maul_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
    --     }
    -- end,
--#endregion

local data = {}
return {
    long_shaft_attachments = function(default) -- Last update 1.5.4
        local attachments = table_icombine(
            _forcestaff_p1_m1.staff_shaft_lower_attachments(false),
            _ogryn_pickaxe_2h_p1_m1.shaft_attachments(false)
        )
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    long_shaft_models = function(content) -- Last update 1.5.4
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _forcestaff_p1_m1.staff_shaft_lower_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _ogryn_pickaxe_2h_p1_m1.shaft_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve)
        )
    end,
    medium_shaft_attachments = function(default) -- Last update 1.5.4
        local attachments = table_icombine(
            _powermaul_2h_p1_m1.shaft_attachments(false),
            _thunderhammer_2h_p1_m1.shaft_attachments(false)
        )
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    medium_shaft_models = function(content) -- Last update 1.5.4
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _powermaul_2h_p1_m1.shaft_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _thunderhammer_2h_p1_m1.shaft_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve)
        )
    end,
    small_shaft_attachments = function(default) -- Last update 1.5.4
        local attachments = table_icombine(
            _chainaxe_p1_m1.shaft_attachments(false),
            _ogryn_powermaul_p1_m1.shaft_attachments(false)
        )
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    small_shaft_models = function(content) -- Last update 1.5.4
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _chainaxe_p1_m1.shaft_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _ogryn_powermaul_p1_m1.shaft_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve)
        )
    end,

    medium_grip_attachments = function(default)
        local attachments = table_icombine(
            _chainaxe_p1_m1.grip_attachments(false),
            _combataxe_p1_m1.grip_attachments(false),
            _combataxe_p2_m1.grip_attachments(false),
            _combataxe_p3_m1.grip_attachments(false),
            _ogryn_club_p1_m1.grip_attachments(false)
        )
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    medium_grip_models = function(content)
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _chainaxe_p1_m1.grip_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _combataxe_p1_m1.grip_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve),
            _combataxe_p2_m1.grip_models(data[3].parent, data[3].angle, data[3].move, data[3].remove, data[3].type, data[3].no_support, data[3].automatic_equip, data[3].hide_mesh, data[3].mesh_move, data[3].special_resolve),
            _combataxe_p3_m1.grip_models(data[4].parent, data[4].angle, data[4].move, data[4].remove, data[4].type, data[4].no_support, data[4].automatic_equip, data[4].hide_mesh, data[4].mesh_move, data[4].special_resolve),
            _ogryn_club_p1_m1.grip_models(data[5].parent, data[5].angle, data[5].move, data[5].remove, data[5].type, data[5].no_support, data[5].automatic_equip, data[5].hide_mesh, data[5].mesh_move, data[5].special_resolve)
        )
    end,
    pommel_attachments = function(default, none, krieg, prologue)
        local attachments = table_icombine(
            _combataxe_p1_m1.pommel_attachments(false),
            _combataxe_p2_m1.pommel_attachments(false),
            _combataxe_p3_m1.pommel_attachments(false, krieg, prologue),
            _forcesword_p1_m1.pommel_attachments(false),
            _forcesword_2h_p1_m1.pommel_attachments(false),
            _ogryn_club_p1_m1.pommel_attachments(false),
            _ogryn_powermaul_p1_m1.pommel_attachments(false),
            _powermaul_2h_p1_m1.pommel_attachments(false),
            _powersword_p1_m1.pommel_attachments(false),
            _powersword_2h_p1_m1.pommel_attachments(false),
            _thunderhammer_2h_p1_m1.pommel_attachments(false)
        )
        if default == nil then default = true end
        if none then attachments[#attachments+1] = {id = "pommel_none", name = ""} end
        -- mod:dtf(attachments, "pommel_attachments", 5)
        if default then return table.icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(content) --parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _combataxe_p1_m1.pommel_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _combataxe_p2_m1.pommel_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve),
            _combataxe_p3_m1.pommel_models(data[3].parent, data[3].angle, data[3].move, data[3].remove, data[3].type, data[3].no_support, data[3].automatic_equip, data[3].hide_mesh, data[3].mesh_move, data[3].special_resolve),
            _forcesword_p1_m1.pommel_models(data[4].parent, data[4].angle, data[4].move, data[4].remove, data[4].type, data[4].no_support, data[4].automatic_equip, data[4].hide_mesh, data[4].mesh_move, data[4].special_resolve),
            _forcesword_2h_p1_m1.pommel_models(data[4].parent, data[4].angle, data[4].move, data[4].remove, data[4].type, data[4].no_support, data[4].automatic_equip, data[4].hide_mesh, data[4].mesh_move, data[4].special_resolve),
            _ogryn_club_p1_m1.pommel_models(data[5].parent, data[5].angle, data[5].move, data[5].remove, data[5].type, data[5].no_support, data[5].automatic_equip, data[5].hide_mesh, data[5].mesh_move, data[5].special_resolve),
            _ogryn_powermaul_p1_m1.pommel_models(data[6].parent, data[6].angle, data[6].move, data[6].remove, data[6].type, data[6].no_support, data[6].automatic_equip, data[6].hide_mesh, data[6].mesh_move, data[6].special_resolve),
            _powermaul_2h_p1_m1.pommel_models(data[7].parent, data[7].angle, data[7].move, data[7].remove, data[7].type, data[7].no_support, data[7].automatic_equip, data[7].hide_mesh, data[7].mesh_move, data[7].special_resolve),
            _powersword_p1_m1.pommel_models(data[8].parent, data[8].angle, data[8].move, data[8].remove, data[8].type, data[8].no_support, data[8].automatic_equip, data[8].hide_mesh, data[8].mesh_move, data[8].special_resolve),
            _powersword_2h_p1_m1.pommel_models(data[8].parent, data[8].angle, data[8].move, data[8].remove, data[8].type, data[8].no_support, data[8].automatic_equip, data[8].hide_mesh, data[8].mesh_move, data[8].special_resolve),
            _thunderhammer_2h_p1_m1.pommel_models(data[9].parent, data[9].angle, data[9].move, data[9].remove, data[9].type, data[9].no_support, data[9].automatic_equip, data[9].hide_mesh, data[9].mesh_move, data[9].special_resolve),
            table.model_table({
                {name = "pommel_none", model = ""},
            }, data[10].parent, data[10].angle, data[10].move, data[10].remove, data[10].type or "pommel", data[10].no_support, data[10].automatic_equip, data[10].hide_mesh, data[10].mesh_move, data[10].special_resolve)
        )
    end,
    axe_head_attachments = function(default)
        local attachments = table_icombine(
            _combataxe_p1_m1.head_attachments(false),
            _combataxe_p2_m1.head_attachments(false),
            _combataxe_p3_m1.head_attachments(false)
        )
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    axe_head_models = function(content)
        data = {}
        for i = 1, 100, 1 do
            data[i] = tv(content, i)
            if data[i].mesh_move == nil then data[i].mesh_move = false end
        end
        return table.combine(
            _combataxe_p1_m1.head_models(data[1].parent, data[1].angle, data[1].move, data[1].remove, data[1].type, data[1].no_support, data[1].automatic_equip, data[1].hide_mesh, data[1].mesh_move, data[1].special_resolve),
            _combataxe_p2_m1.head_models(data[2].parent, data[2].angle, data[2].move, data[2].remove, data[2].type, data[2].no_support, data[2].automatic_equip, data[2].hide_mesh, data[2].mesh_move, data[2].special_resolve),
            _combataxe_p3_m1.head_models(data[3].parent, data[3].angle, data[3].move, data[3].remove, data[3].type, data[3].no_support, data[3].automatic_equip, data[3].hide_mesh, data[3].mesh_move, data[3].special_resolve)
        )
    end,


    -- power_sword_2h_blade_01|power_sword_2h_blade_02|power_sword_2h_blade_03
    scabbard_attachments = function(default)
        local attachments = {
            {id = "scabbard_01", name = "Scabbard 1"},
            {id = "scabbard_02", name = "Scabbard 2"},
            {id = "scabbard_03", name = "Scabbard 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine({{id = "scabbard_default", name = mod:localize("mod_attachment_default")}}, attachments)
        else return attachments end
    end,
    scabbard_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "scabbard_default", model = ""},
            {name = "scabbard_01",      model = _item_melee.."/full/chain_sword_full_01"},
            {name = "scabbard_02",      model = _item_melee.."/full/chain_sword_full_02"},
            {name = "scabbard_03",      model = _item_melee.."/full/chain_sword_full_03"},
        }, parent, angle, move, remove, type or "scabbard", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,


    blunt_head_attachments = function(default)
        local attachments = {
            {id = "thunder_hammer_head_01",     name = "Thunderhammer 1"},
            {id = "thunder_hammer_head_02",     name = "Thunderhammer 2"},
            {id = "thunder_hammer_head_03",     name = "Thunderhammer 3"},
            {id = "thunder_hammer_head_04",     name = "Thunderhammer 4"},
            {id = "thunder_hammer_head_05",     name = "Thunderhammer 5"},
            {id = "thunder_hammer_head_ml01",   name = "Thunderhammer ML01"},
            {id = "thunder_hammer_head_06",     name = "Thunderhammer 6"},
            {id = "power_maul_head_01",         name = "Power Maul 1"},
            {id = "power_maul_head_02",         name = "Power Maul 2"},
            {id = "power_maul_head_03",         name = "Power Maul 3"},
            {id = "power_maul_head_04",         name = "Power Maul 4"},
            {id = "power_maul_head_05",         name = "Power Maul 5"},
            {id = "power_maul_head_ml01",       name = "Power Maul ML01"},
            {id = "2h_power_maul_head_01",      name = "2H Power Maul 1"},
            {id = "2h_power_maul_head_02",      name = "2H Power Maul 2"},
            {id = "2h_power_maul_head_03",      name = "2H Power Maul 3"},
            {id = "2h_power_maul_head_04",      name = "2H Power Maul 4"},
            {id = "2h_power_maul_head_05",      name = "2H Power Maul 5"},
            {id = "2h_power_maul_head_ml01",      name = "2H Power Maul ML01"},
            {id = "human_power_maul_head_01",   name = "Small Power Maul 1"},
            {id = "human_power_maul_head_02",   name = "Small Power Maul 2"},
            {id = "human_power_maul_head_03",   name = "Small Power Maul 3"},
            {id = "human_power_maul_head_04",   name = "Small Power Maul 4"},
            {id = "human_power_maul_head_05",   name = "Small Power Maul 5"},
            {id = "human_power_maul_head_06",   name = "Small Power Maul 6"},
            {id = "human_power_maul_head_ml01", name = "Small Power Maul ML01"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blunt_head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default",  model = ""},
            {name = "thunder_hammer_head_01",     model = _item_melee.."/heads/thunder_hammer_head_01"},
            {name = "thunder_hammer_head_02",     model = _item_melee.."/heads/thunder_hammer_head_02"},
            {name = "thunder_hammer_head_03",     model = _item_melee.."/heads/thunder_hammer_head_03"},
            {name = "thunder_hammer_head_04",     model = _item_melee.."/heads/thunder_hammer_head_04"},
            {name = "thunder_hammer_head_05",     model = _item_melee.."/heads/thunder_hammer_head_05"},
            {name = "thunder_hammer_head_ml01",   model = _item_melee.."/heads/thunder_hammer_head_ml01"},
            {name = "thunder_hammer_head_06",     model = _item_melee.."/heads/thunder_hammer_head_06"},
            {name = "power_maul_head_01",         model = _item_melee.."/heads/power_maul_head_01"},
            {name = "power_maul_head_02",         model = _item_melee.."/heads/power_maul_head_02"},
            {name = "power_maul_head_03",         model = _item_melee.."/heads/power_maul_head_03"},
            {name = "power_maul_head_04",         model = _item_melee.."/heads/power_maul_head_04"},
            {name = "power_maul_head_05",         model = _item_melee.."/heads/power_maul_head_05"},
            {name = "power_maul_head_ml01",       model = _item_melee.."/heads/power_maul_head_ml01"},
            {name = "2h_power_maul_head_01",      model = _item_melee.."/heads/2h_power_maul_head_01"},
            {name = "2h_power_maul_head_02",      model = _item_melee.."/heads/2h_power_maul_head_02"},
            {name = "2h_power_maul_head_03",      model = _item_melee.."/heads/2h_power_maul_head_03"},
            {name = "2h_power_maul_head_04",      model = _item_melee.."/heads/2h_power_maul_head_04"},
            {name = "2h_power_maul_head_05",      model = _item_melee.."/heads/2h_power_maul_head_05"},
            {name = "2h_power_maul_head_ml01",    model = _item_melee.."/heads/2h_power_maul_head_ml01"},
            {name = "human_power_maul_head_01",   model = _item_melee.."/heads/human_power_maul_head_01"},
            {name = "human_power_maul_head_02",   model = _item_melee.."/heads/human_power_maul_head_02"},
            {name = "human_power_maul_head_03",   model = _item_melee.."/heads/human_power_maul_head_03"},
            {name = "human_power_maul_head_04",   model = _item_melee.."/heads/human_power_maul_head_04"},
            {name = "human_power_maul_head_05",   model = _item_melee.."/heads/human_power_maul_head_05"},
            {name = "human_power_maul_head_06",   model = _item_melee.."/heads/human_power_maul_head_06"},
            {name = "human_power_maul_head_ml01", model = _item_melee.."/heads/human_power_maul_head_ml01"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,

    grip_default = function()
        return {
            {id = "grip_default",  name = mod:localize("mod_attachment_default")}
        }
    end,
    axe_grip_attachments = function()
        return {
            {id = "axe_grip_01",     name = "Combat Axe 1"},
            {id = "axe_grip_02",     name = "Combat Axe 2"},
            {id = "axe_grip_03",     name = "Combat Axe 3"},
            {id = "axe_grip_04",     name = "Combat Axe 4"},
            {id = "axe_grip_05",     name = "Combat Axe 5"},
            {id = "axe_grip_06",     name = "Combat Axe 6"},
            {id = "hatchet_grip_01", name = "Tactical Axe 1"},
            {id = "hatchet_grip_02", name = "Tactical Axe 2"},
            {id = "hatchet_grip_03", name = "Tactical Axe 3"},
            {id = "hatchet_grip_04", name = "Tactical Axe 4"},
            {id = "hatchet_grip_05", name = "Tactical Axe 5"},
            {id = "hatchet_grip_06", name = "Tactical Axe 6"},
        }
    end,
    axe_grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default =    {model = "",                                    type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_01 =     {model = _item_melee.."/grips/axe_grip_01",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_02 =     {model = _item_melee.."/grips/axe_grip_02",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_03 =     {model = _item_melee.."/grips/axe_grip_03",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_04 =     {model = _item_melee.."/grips/axe_grip_04",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_05 =     {model = _item_melee.."/grips/axe_grip_05",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            axe_grip_06 =     {model = _item_melee.."/grips/axe_grip_06",     type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_01 = {model = _item_melee.."/grips/hatchet_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_02 = {model = _item_melee.."/grips/hatchet_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_03 = {model = _item_melee.."/grips/hatchet_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_04 = {model = _item_melee.."/grips/hatchet_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_05 = {model = _item_melee.."/grips/hatchet_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            hatchet_grip_06 = {model = _item_melee.."/grips/hatchet_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    head_default = function()
        return {
            {id = "head_default",  name = mod:localize("mod_attachment_default")}
        }
    end,
    --#region Old
        -- axe_head_attachments = function()
        --     return {
        --         {id = "axe_head_01",     name = "Combat Axe 1"},
        --         {id = "axe_head_02",     name = "Combat Axe 2"},
        --         {id = "axe_head_03",     name = "Combat Axe 3"},
        --         {id = "axe_head_04",     name = "Combat Axe 4"},
        --         {id = "axe_head_05",     name = "Combat Axe 5"},
        --         {id = "hatchet_head_01", name = "Tactical Axe 1"},
        --         {id = "hatchet_head_02", name = "Tactical Axe 2"},
        --         {id = "hatchet_head_03", name = "Tactical Axe 3"},
        --         {id = "hatchet_head_04", name = "Tactical Axe 4"},
        --         {id = "hatchet_head_05", name = "Tactical Axe 5"},
        --     }
        -- end,
        -- axe_head_models = function(parent, angle, move, remove)
        --     local a = angle or 0
        --     local m = move or vector3_box(0, 0, 0)
        --     local r = remove or vector3_box(0, 0, 0)
        --     return {
        --         head_default =    {model = "",                                    type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_head_01 =     {model = _item_melee.."/heads/axe_head_01",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_head_02 =     {model = _item_melee.."/heads/axe_head_02",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_head_03 =     {model = _item_melee.."/heads/axe_head_03",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_head_04 =     {model = _item_melee.."/heads/axe_head_04",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_head_05 =     {model = _item_melee.."/heads/axe_head_05",     type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_head_01 = {model = _item_melee.."/heads/hatchet_head_01", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_head_02 = {model = _item_melee.."/heads/hatchet_head_02", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_head_03 = {model = _item_melee.."/heads/hatchet_head_03", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_head_04 = {model = _item_melee.."/heads/hatchet_head_04", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_head_05 = {model = _item_melee.."/heads/hatchet_head_05", type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --     }
        -- end,
        -- pommel_default = function()
        --     return {
        --         {id = "pommel_default",  name = mod:localize("mod_attachment_default")}
        --     }
        -- end,
        -- pommel_attachments = function()
        --     return {
        --         {id = "axe_pommel_01",     name = "Combat Axe 1"},
        --         {id = "axe_pommel_02",     name = "Combat Axe 2"},
        --         {id = "axe_pommel_03",     name = "Combat Axe 3"},
        --         {id = "axe_pommel_04",     name = "Combat Axe 4"},
        --         {id = "axe_pommel_05",     name = "Combat Axe 5"},
        --         {id = "hatchet_pommel_01", name = "Tactical Axe 1"},
        --         {id = "hatchet_pommel_02", name = "Tactical Axe 2"},
        --         {id = "hatchet_pommel_03", name = "Tactical Axe 3"},
        --         {id = "hatchet_pommel_04", name = "Tactical Axe 4"},
        --         {id = "power_sword_pommel_01",      name = "Pommel 1"},
        --         {id = "power_sword_pommel_02",      name = "Pommel 2"},
        --         {id = "power_sword_pommel_03",      name = "Pommel 3"},
        --         {id = "power_sword_pommel_04",      name = "Pommel 4"},
        --         {id = "power_sword_pommel_05",      name = "Pommel 5"},
        --         {id = "power_sword_2h_pommel_01",      name = "2H Power Sword 1"},
        --         {id = "power_sword_2h_pommel_02",      name = "2H Power Sword 2"},
        --         {id = "power_sword_2h_pommel_03",      name = "2H Power Sword 3"},
        --         {id = "force_sword_pommel_01",      name = "Force Sword 1"},
        --         {id = "force_sword_pommel_02",      name = "Force Sword 2"},
        --         {id = "force_sword_pommel_03",      name = "Force Sword 3"},
        --         {id = "force_sword_pommel_04",      name = "Force Sword 4"},
        --         {id = "force_sword_pommel_05",      name = "Force Sword 5"},
        --     }
        -- end,
        -- pommel_models = function(parent, angle, move, remove)
        --     local a = angle or 0
        --     local m = move or vector3_box(0, 0, 0)
        --     local r = remove or vector3_box(0, 0, 0)
        --     return {
        --         pommel_default =    {model = "",                                        type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_pommel_01 =     {model = _item_melee.."/pommels/axe_pommel_01",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_pommel_02 =     {model = _item_melee.."/pommels/axe_pommel_02",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_pommel_03 =     {model = _item_melee.."/pommels/axe_pommel_03",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_pommel_04 =     {model = _item_melee.."/pommels/axe_pommel_04",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         axe_pommel_05 =     {model = _item_melee.."/pommels/axe_pommel_05",     type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_pommel_01 = {model = _item_melee.."/pommels/hatchet_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_pommel_02 = {model = _item_melee.."/pommels/hatchet_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_pommel_03 = {model = _item_melee.."/pommels/hatchet_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --         hatchet_pommel_04 = {model = _item_melee.."/pommels/hatchet_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        --     }
        -- end,
    --#endregion
    human_power_maul_shaft_attachments = function(default)
        local attachments = {
            {id = "small_shaft_01", name = "Small Shaft 1"},
            {id = "small_shaft_02", name = "Small Shaft 2"},
            {id = "small_shaft_03", name = "Small Shaft 3"},
            {id = "small_shaft_04", name = "Small Shaft 4"},
            {id = "small_shaft_05", name = "Small Shaft 5"},
            {id = "small_shaft_06", name = "Small Shaft 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default",  model = ""},
            {name = "small_shaft_01", model = _item_ranged.."/shafts/human_power_maul_shaft_01"},
            {name = "small_shaft_02", model = _item_ranged.."/shafts/human_power_maul_shaft_02"},
            {name = "small_shaft_03", model = _item_ranged.."/shafts/human_power_maul_shaft_03"},
            {name = "small_shaft_04", model = _item_ranged.."/shafts/human_power_maul_shaft_04"},
            {name = "small_shaft_05", model = _item_ranged.."/shafts/human_power_maul_shaft_05"},
            {name = "small_shaft_06", model = _item_ranged.."/shafts/human_power_maul_shaft_06"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    human_power_maul_head_attachments = function(default)
        local attachments = {
            {id = "small_head_01", name = "Small Head 1"},
            {id = "small_head_02", name = "Small Head 2"},
            {id = "small_head_03", name = "Small Head 3"},
            {id = "small_head_04", name = "Small Head 4"},
            {id = "small_head_05", name = "Small Head 5"},
            {id = "small_head_06", name = "Small Head 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default",  model = ""},
            {name = "small_head_01", model = _item_melee.."/heads/human_power_maul_head_01"},
            {name = "small_head_02", model = _item_melee.."/heads/human_power_maul_head_02"},
            {name = "small_head_03", model = _item_melee.."/heads/human_power_maul_head_03"},
            {name = "small_head_04", model = _item_melee.."/heads/human_power_maul_head_04"},
            {name = "small_head_05", model = _item_melee.."/heads/human_power_maul_head_05"},
            {name = "small_head_06", model = _item_melee.."/heads/human_power_maul_head_06"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    human_power_maul_connector_attachments = function(default)
        local attachments = {
            {id = "small_connector_01", name = "Small Connector 1"},
            {id = "small_connector_02", name = "Small Connector 2"},
            {id = "small_connector_03", name = "Small Connector 3"},
            {id = "small_connector_04", name = "Small Connector 4"},
            {id = "small_connector_05", name = "Small Connector 5"},
            {id = "small_connector_06", name = "Small Connector 6"},
            {id = "small_connector_07", name = "Small Connector 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "connector_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    human_power_maul_connector_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "connector_default",  model = ""},
            {name = "small_connector_01", model = _item_melee.."/connectors/human_power_maul_connector_01"},
            {name = "small_connector_02", model = _item_melee.."/connectors/human_power_maul_connector_02"},
            {name = "small_connector_03", model = _item_melee.."/connectors/human_power_maul_connector_03"},
            {name = "small_connector_04", model = _item_melee.."/connectors/human_power_maul_connector_04"},
            {name = "small_connector_05", model = _item_melee.."/connectors/human_power_maul_connector_05"},
            {name = "small_connector_06", model = _item_melee.."/connectors/human_power_maul_connector_06"},
            {name = "small_connector_07", model = _item_melee.."/connectors/human_power_maul_connector_ml01"},
        }, parent, angle, move, remove, type or "connector", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    sword_grip_attachments = function(default)
        local attachments = {
            {id = "power_sword_grip_01",      name = "Power Sword 1"},
            {id = "power_sword_grip_02",      name = "Power Sword 2"},
            {id = "power_sword_grip_03",      name = "Power Sword 3"},
            {id = "power_sword_grip_04",      name = "Power Sword 4"},
            {id = "power_sword_grip_05",      name = "Power Sword 5"},
            {id = "power_sword_grip_06",      name = "Power Sword 6"},
            {id = "power_sword_grip_ml01",      name = "Power Sword 7"},
            {id = "power_sword_2h_grip_01",      name = "2H Power Sword 1"},
            {id = "power_sword_2h_grip_02",      name = "2H Power Sword 2"},
            {id = "power_sword_2h_grip_03",      name = "2H Power Sword 3"},
            -- {id = "power_sword_2h_grip_ml01",    name = "2H Power Sword 4"},
            {id = "force_sword_grip_01",      name = "Force Sword 1"},
            {id = "force_sword_grip_02",      name = "Force Sword 2"},
            {id = "force_sword_grip_03",      name = "Force Sword 3"},
            {id = "force_sword_grip_04",      name = "Force Sword 4"},
            {id = "force_sword_grip_05",      name = "Force Sword 5"},
            {id = "force_sword_grip_06",      name = "Force Sword 6"},
            {id = "2h_force_sword_grip_01",   name = "2H Force Sword 1"},
            {id = "2h_force_sword_grip_02",   name = "2H Force Sword 2"},
            {id = "2h_force_sword_grip_03",   name = "2H Force Sword 3"},
            {id = "2h_force_sword_grip_ml01", name = "2H Force Sword 4"},
            {id = "2h_force_sword_grip_04",   name = "2H Force Sword 5"},
            {id = "2h_force_sword_grip_05",   name = "2H Force Sword 6"},
            {id = "sabre_grip_01",      name = "Sabre 1"},
            {id = "sabre_grip_02",      name = "Sabre 2"},
            {id = "sabre_grip_03",      name = "Sabre 3"},
            {id = "sabre_grip_04",      name = "Sabre 4"},
            {id = "sabre_grip_05",      name = "Sabre 5"},
            {id = "falchion_grip_01",      name = "Falchion 1"},
            {id = "falchion_grip_02",      name = "Falchion 2"},
            {id = "falchion_grip_03",      name = "Falchion 3"},
            {id = "falchion_grip_04",      name = "Falchion 4"},
            {id = "falchion_grip_05",      name = "Falchion 5"},
            {id = "combat_sword_grip_01",      name = "Combat Sword 1"},
            {id = "combat_sword_grip_02",      name = "Combat Sword 2"},
            {id = "combat_sword_grip_03",      name = "Combat Sword 3"},
            {id = "combat_sword_grip_04",      name = "Combat Sword 4"},
            {id = "combat_sword_grip_05",      name = "Combat Sword 5"},
            {id = "combat_sword_grip_06",      name = "Combat Sword 6"},
            {id = "knife_grip_01",      name = "Combat Knife 1"},
            {id = "knife_grip_02",      name = "Combat Knife 2"},
            {id = "knife_grip_03",      name = "Combat Knife 3"},
            {id = "knife_grip_04",      name = "Combat Knife 4"},
            {id = "knife_grip_05",      name = "Combat Knife 5"},
            {id = "knife_grip_06",      name = "Combat Knife 6"},
            {id = "knife_grip_07",      name = "Combat Knife 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sword_grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "power_sword_grip_01",      model = _item_melee.."/grips/power_sword_grip_01"},
            {name = "power_sword_grip_02",      model = _item_melee.."/grips/power_sword_grip_02"},
            {name = "power_sword_grip_03",      model = _item_melee.."/grips/power_sword_grip_03"},
            {name = "power_sword_grip_04",      model = _item_melee.."/grips/power_sword_grip_04"},
            {name = "power_sword_grip_05",      model = _item_melee.."/grips/power_sword_grip_05"},
            {name = "power_sword_grip_06",      model = _item_melee.."/grips/power_sword_grip_06"},
            {name = "power_sword_grip_ml01",      model = _item_melee.."/grips/power_sword_grip_ml01"},
            {name = "power_sword_2h_grip_01",      model = _item_melee.."/grips/2h_power_sword_grip_01"},
            {name = "power_sword_2h_grip_02",      model = _item_melee.."/grips/2h_power_sword_grip_02"},
            {name = "power_sword_2h_grip_03",      model = _item_melee.."/grips/2h_power_sword_grip_03"},
            -- {name = "power_sword_2h_grip_ml01",    model = _item_melee.."/grips/2h_power_sword_grip_ml01"},
            {name = "force_sword_grip_01",      model = _item_melee.."/grips/force_sword_grip_01"},
            {name = "force_sword_grip_02",      model = _item_melee.."/grips/force_sword_grip_02"},
            {name = "force_sword_grip_03",      model = _item_melee.."/grips/force_sword_grip_03"},
            {name = "force_sword_grip_04",      model = _item_melee.."/grips/force_sword_grip_04"},
            {name = "force_sword_grip_05",      model = _item_melee.."/grips/force_sword_grip_05"},
            {name = "force_sword_grip_06",      model = _item_melee.."/grips/force_sword_grip_06"},
            {name = "2h_force_sword_grip_01",   model = _item_melee.."/grips/2h_force_sword_grip_01"},
            {name = "2h_force_sword_grip_02",   model = _item_melee.."/grips/2h_force_sword_grip_02"},
            {name = "2h_force_sword_grip_03",   model = _item_melee.."/grips/2h_force_sword_grip_03"},
            {name = "2h_force_sword_grip_ml01", model = _item_melee.."/grips/2h_force_sword_grip_ml01"},
            {name = "2h_force_sword_grip_04",   model = _item_melee.."/grips/2h_force_sword_grip_04"},
            {name = "2h_force_sword_grip_05",   model = _item_melee.."/grips/2h_force_sword_grip_05"},
            {name = "sabre_grip_01",      model = _item_melee.."/grips/sabre_grip_01"},
            {name = "sabre_grip_02",      model = _item_melee.."/grips/sabre_grip_02"},
            {name = "sabre_grip_03",      model = _item_melee.."/grips/sabre_grip_03"},
            {name = "sabre_grip_04",      model = _item_melee.."/grips/sabre_grip_04"},
            {name = "sabre_grip_05",      model = _item_melee.."/grips/sabre_grip_05"},
            {name = "falchion_grip_01",      model = _item_melee.."/grips/falchion_grip_01"},
            {name = "falchion_grip_02",      model = _item_melee.."/grips/falchion_grip_02"},
            {name = "falchion_grip_03",      model = _item_melee.."/grips/falchion_grip_03"},
            {name = "falchion_grip_04",      model = _item_melee.."/grips/falchion_grip_04"},
            {name = "falchion_grip_05",      model = _item_melee.."/grips/falchion_grip_05"},
            {name = "combat_sword_grip_01",      model = _item_melee.."/grips/combat_sword_grip_01"},
            {name = "combat_sword_grip_02",      model = _item_melee.."/grips/combat_sword_grip_02"},
            {name = "combat_sword_grip_03",      model = _item_melee.."/grips/combat_sword_grip_03"},
            {name = "combat_sword_grip_04",      model = _item_melee.."/grips/combat_sword_grip_04"},
            {name = "combat_sword_grip_05",      model = _item_melee.."/grips/combat_sword_grip_05"},
            {name = "combat_sword_grip_06",      model = _item_melee.."/grips/combat_sword_grip_06"},
            {name = "knife_grip_01",      model = _item_melee.."/grips/combat_knife_grip_01"},
            {name = "knife_grip_02",      model = _item_melee.."/grips/combat_knife_grip_02"},
            {name = "knife_grip_03",      model = _item_melee.."/grips/combat_knife_grip_03"},
            {name = "knife_grip_04",      model = _item_melee.."/grips/combat_knife_grip_04"},
            {name = "knife_grip_05",      model = _item_melee.."/grips/combat_knife_grip_05"},
            {name = "knife_grip_06",      model = _item_melee.."/grips/combat_knife_grip_06"},
            {name = "knife_grip_07",      model = _item_melee.."/grips/combat_knife_grip_07"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,

    sword_blade_attachments = function(default)
        local attachments = {
            {id = "power_sword_blade_01",      name = "Power Sword 1"},
            {id = "power_sword_blade_02",      name = "Power Sword 2"},
            {id = "power_sword_blade_03",      name = "Power Sword 3"},
            {id = "power_sword_blade_04",      name = "Power Sword 4"},
            {id = "power_sword_blade_05",      name = "Power Sword 5"},
            {id = "power_sword_blade_06",      name = "Power Sword 6"},
            {id = "power_sword_blade_07",      name = "Power Sword 7"},
            {id = "power_sword_2h_blade_01",      name = "2H Power Sword 1"},
            {id = "power_sword_2h_blade_02",      name = "2H Power Sword 2"},
            {id = "power_sword_2h_blade_03",      name = "2H Power Sword 3"},
            {id = "power_sword_2h_blade_ml01",    name = "2H Power Sword 4"},
            {id = "force_sword_blade_01",      name = "Force Sword 1"},
            {id = "force_sword_blade_02",      name = "Force Sword 2"},
            {id = "force_sword_blade_03",      name = "Force Sword 3"},
            {id = "force_sword_blade_04",      name = "Force Sword 4"},
            {id = "force_sword_blade_05",      name = "Force Sword 5"},
            {id = "force_sword_blade_06",      name = "Force Sword 6"},
            {id = "force_sword_blade_ml01",      name = "Force Sword 7"},
            {id = "2h_force_sword_blade_01",   name = "2H Force Sword 1"},
            {id = "2h_force_sword_blade_02",   name = "2H Force Sword 2"},
            {id = "2h_force_sword_blade_03",   name = "2H Force Sword 3"},
            {id = "2h_force_sword_blade_ml01", name = "2H Force Sword 4"},
            {id = "2h_force_sword_blade_04",   name = "2H Force Sword 5"},
            {id = "2h_force_sword_blade_05",   name = "2H Force Sword 6"},
            {id = "sabre_blade_01",      name = "Sabre 1"},
            {id = "sabre_blade_02",      name = "Sabre 2"},
            {id = "sabre_blade_03",      name = "Sabre 3"},
            {id = "sabre_blade_04",      name = "Sabre 4"},
            {id = "sabre_blade_05",      name = "Sabre 5"},
            {id = "falchion_blade_01",      name = "Falchion 1"},
            {id = "falchion_blade_02",      name = "Falchion 2"},
            {id = "falchion_blade_03",      name = "Falchion 3"},
            {id = "falchion_blade_04",      name = "Falchion 4"},
            {id = "falchion_blade_05",      name = "Falchion 5"},
            {id = "combat_sword_blade_01",      name = "Combat Sword 1"},
            {id = "combat_sword_blade_02",      name = "Combat Sword 2"},
            {id = "combat_sword_blade_03",      name = "Combat Sword 3"},
            {id = "combat_sword_blade_04",      name = "Combat Sword 4"},
            {id = "combat_sword_blade_05",      name = "Combat Sword 5"},
            {id = "combat_sword_blade_06",      name = "Combat Sword 6"},
            {id = "combat_sword_blade_07",      name = "Combat Sword 7"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sword_blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "blade_default", model = ""},
            {name = "power_sword_blade_01",      model = _item_melee.."/blades/power_sword_blade_01"},
            {name = "power_sword_blade_02",      model = _item_melee.."/blades/power_sword_blade_02"},
            {name = "power_sword_blade_03",      model = _item_melee.."/blades/power_sword_blade_03"},
            {name = "power_sword_blade_04",      model = _item_melee.."/blades/power_sword_blade_05"},
            {name = "power_sword_blade_05",      model = _item_melee.."/blades/power_sword_blade_06"},
            {name = "power_sword_blade_06",      model = _item_melee.."/blades/power_sword_blade_ml01"},
            {name = "power_sword_blade_07",      model = _item_melee.."/blades/power_sword_blade_07"},
            {name = "power_sword_2h_blade_01",      model = _item_melee.."/blades/2h_power_sword_blade_01"},
            {name = "power_sword_2h_blade_02",      model = _item_melee.."/blades/2h_power_sword_blade_02"},
            {name = "power_sword_2h_blade_03",      model = _item_melee.."/blades/2h_power_sword_blade_03"},
            {name = "power_sword_2h_blade_ml01",    model = _item_melee.."/blades/2h_power_sword_blade_ml01"},
            {name = "force_sword_blade_01",      model = _item_melee.."/blades/force_sword_blade_01"},
            {name = "force_sword_blade_02",      model = _item_melee.."/blades/force_sword_blade_02"},
            {name = "force_sword_blade_03",      model = _item_melee.."/blades/force_sword_blade_03"},
            {name = "force_sword_blade_04",      model = _item_melee.."/blades/force_sword_blade_04"},
            {name = "force_sword_blade_05",      model = _item_melee.."/blades/force_sword_blade_05"},
            {name = "force_sword_blade_06",      model = _item_melee.."/blades/force_sword_blade_06"},
            {name = "force_sword_blade_ml01",    model = _item_melee.."/blades/force_sword_blade_ml01"},
            {name = "2h_force_sword_blade_01",   model = _item_melee.."/blades/2h_force_sword_blade_01"},
            {name = "2h_force_sword_blade_02",   model = _item_melee.."/blades/2h_force_sword_blade_02"},
            {name = "2h_force_sword_blade_03",   model = _item_melee.."/blades/2h_force_sword_blade_03"},
            {name = "2h_force_sword_blade_ml01", model = _item_melee.."/blades/2h_force_sword_blade_ml01"},
            {name = "2h_force_sword_blade_04",   model = _item_melee.."/blades/2h_force_sword_blade_04"},
            {name = "2h_force_sword_blade_05",   model = _item_melee.."/blades/2h_force_sword_blade_05"},
            {name = "sabre_blade_01",      model = _item_melee.."/blades/sabre_blade_01"},
            {name = "sabre_blade_02",      model = _item_melee.."/blades/sabre_blade_02"},
            {name = "sabre_blade_03",      model = _item_melee.."/blades/sabre_blade_03"},
            {name = "sabre_blade_04",      model = _item_melee.."/blades/sabre_blade_04"},
            {name = "sabre_blade_05",      model = _item_melee.."/blades/sabre_blade_05"},
            {name = "falchion_blade_01",      model = _item_melee.."/blades/falchion_blade_01"},
            {name = "falchion_blade_02",      model = _item_melee.."/blades/falchion_blade_02"},
            {name = "falchion_blade_03",      model = _item_melee.."/blades/falchion_blade_03"},
            {name = "falchion_blade_04",      model = _item_melee.."/blades/falchion_blade_04"},
            {name = "falchion_blade_05",      model = _item_melee.."/blades/falchion_blade_05"},
            {name = "combat_sword_blade_01",      model = _item_melee.."/blades/combat_sword_blade_01"},
            {name = "combat_sword_blade_02",      model = _item_melee.."/blades/combat_sword_blade_02"},
            {name = "combat_sword_blade_03",      model = _item_melee.."/blades/combat_sword_blade_03"},
            {name = "combat_sword_blade_04",      model = _item_melee.."/blades/combat_sword_blade_04"},
            {name = "combat_sword_blade_05",      model = _item_melee.."/blades/combat_sword_blade_05"},
            {name = "combat_sword_blade_06",      model = _item_melee.."/blades/combat_sword_blade_06"},
            {name = "combat_sword_blade_07",      model = _item_melee.."/blades/combat_sword_blade_07"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,

    sword_hilt_attachments = function(default)
        local attachments = {
            {id = "power_sword_hilt_01",      name = "Power Sword 1"},
            {id = "power_sword_2h_hilt_01",   name = "2H Power Sword 1"},
            {id = "power_sword_2h_hilt_02",   name = "2H Power Sword 2"},
            {id = "power_sword_2h_hilt_03",   name = "2H Power Sword 3"},
            {id = "power_sword_2h_hilt_ml01", name = "2H Power Sword 4"},
            {id = "force_sword_hilt_01",      name = "Force Sword 1"},
            {id = "force_sword_hilt_02",      name = "Force Sword 2"},
            {id = "force_sword_hilt_03",      name = "Force Sword 3"},
            {id = "force_sword_hilt_04",      name = "Force Sword 4"},
            {id = "force_sword_hilt_05",      name = "Force Sword 5"},
            {id = "force_sword_hilt_06",      name = "Force Sword 6"},
            {id = "force_sword_hilt_07",      name = "Force Sword 7"},
            {id = "force_sword_hilt_ml01",    name = "Force Sword 8"},
            {id = "2h_force_sword_hilt_01",   name = "2H Force Sword 1"},
            {id = "2h_force_sword_hilt_02",   name = "2H Force Sword 2"},
            {id = "2h_force_sword_hilt_03",   name = "2H Force Sword 3"},
            {id = "2h_force_sword_hilt_ml01", name = "2H Force Sword 4"},
            {id = "2h_force_sword_hilt_04",   name = "2H Force Sword 5"},
            {id = "2h_force_sword_hilt_05",   name = "2H Force Sword 6"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "hilt_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    sword_hilt_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "hilt_default", model = ""},
            {name = "power_sword_hilt_01",      model = _item_melee.."/hilts/power_sword_hilt_01"},
            {name = "power_sword_2h_hilt_01",   model = _item_melee.."/hilts/2h_power_sword_hilt_01"},
            {name = "power_sword_2h_hilt_02",   model = _item_melee.."/hilts/2h_power_sword_hilt_02"},
            {name = "power_sword_2h_hilt_03",   model = _item_melee.."/hilts/2h_power_sword_hilt_03"},
            {name = "power_sword_2h_hilt_ml01", model = _item_melee.."/hilts/2h_power_sword_hilt_ml01"},
            {name = "force_sword_hilt_01",      model = _item_melee.."/hilts/force_sword_hilt_01"},
            {name = "force_sword_hilt_02",      model = _item_melee.."/hilts/force_sword_hilt_02"},
            {name = "force_sword_hilt_03",      model = _item_melee.."/hilts/force_sword_hilt_03"},
            {name = "force_sword_hilt_04",      model = _item_melee.."/hilts/force_sword_hilt_04"},
            {name = "force_sword_hilt_05",      model = _item_melee.."/hilts/force_sword_hilt_05"},
            {name = "force_sword_hilt_06",      model = _item_melee.."/hilts/force_sword_hilt_06"},
            {name = "force_sword_hilt_07",      model = _item_melee.."/hilts/force_sword_hilt_07"},
            {name = "force_sword_hilt_ml01",    model = _item_melee.."/hilts/force_sword_hilt_ml01"},
            {name = "2h_force_sword_hilt_01",   model = _item_melee.."/hilts/2h_force_sword_hilt_01"},
            {name = "2h_force_sword_hilt_02",   model = _item_melee.."/hilts/2h_force_sword_hilt_02"},
            {name = "2h_force_sword_hilt_03",   model = _item_melee.."/hilts/2h_force_sword_hilt_03"},
            {name = "2h_force_sword_hilt_ml01", model = _item_melee.."/hilts/2h_force_sword_hilt_ml01"},
            {name = "2h_force_sword_hilt_04",   model = _item_melee.."/hilts/2h_force_sword_hilt_04"},
            {name = "2h_force_sword_hilt_05",   model = _item_melee.."/hilts/2h_force_sword_hilt_05"},
        }, parent, angle, move, remove, type or "hilt", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
}