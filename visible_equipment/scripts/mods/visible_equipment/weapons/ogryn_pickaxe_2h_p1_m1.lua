local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _pickaxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/ogryn_pickaxe_2h_p1_m1")
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
    _pickaxe_p1_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- head = _combataxe_p3_m1.head_attachments(),
            head = _pickaxe_p1_m1.head_attachments(),
            pommel = _pickaxe_p1_m1.pommel_attachments(),
            -- grip = _combataxe_p3_m1.grip_attachments(),
            shaft = _pickaxe_p1_m1.shaft_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2)),
            _pickaxe_p1_m1.shaft_models(nil, 0, vector3_box(0, -1, -.2), vector3_box(0, 0, 0)),
            _pickaxe_p1_m1.head_models(nil, 0, vector3_box(.2, -1, .2), vector3_box(0, 0, .2)),
            _pickaxe_p1_m1.pommel_models(nil, 0, vector3_box(-.2, -1, -.4), vector3_box(0, 0, -.2))
            -- _common_melee.axe_head_models({
            --     {parent = nil, angle = 0, move = vector3_box(.1, -4, -.1), remove = vector3_box(0, 0, .4), type = nil, no_support = nil, automatic_equip = nil, hide_mesh = nil, mesh_move = nil, special_resolve = function(gear_id, item, attachment, attachment_list)
            --         changes = {}
            --         local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
            --         local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
            --         local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
            --         if string_find(attachment, "default") then
            --             if grip ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
            --             if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
            --         else
            --             if grip == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
            --             if pommel == "pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
            --         end
            --         return changes
            --     end}
            -- }),
            -- _common_melee.medium_grip_models({
            --     {parent = nil, angle = 0, move = vector3_box(-.1, -4, .2), remove = vector3_box(0, 0, 0), type = nil, no_support = nil, automatic_equip = nil, hide_mesh = nil, mesh_move = nil, special_resolve = function(gear_id, item, attachment, attachment_list)
            --         changes = {}
            --         local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
            --         local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
            --         local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
            --         if string_find(attachment, "default") then
            --             if head ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
            --             if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
            --         else
            --             if head == "shovel_head_default" then changes["head"] = "shovel_head_01" end
            --             if pommel == "pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
            --         end
            --         return changes
            --     end}
            -- }),
            -- _combataxe_p3_m1.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
            --     changes = {}
            --     local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
            --     local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
            --     local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
            --     if string_find(attachment, "default") or string_find(attachment, "shovel_pommel_06") then
            --         if head ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
            --         if grip ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
            --     else
            --         if head == "shovel_head_default" then changes["head"] = "shovel_head_01" end
            --         if grip == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
            --     end
            --     return changes
            -- end)
        ),
        anchors = {

        },
    }
)