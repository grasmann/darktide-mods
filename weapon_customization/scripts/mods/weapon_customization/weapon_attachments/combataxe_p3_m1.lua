local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
    local _common_melee = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_melee")
    local _combataxe_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/functions/combataxe_p3_m1")
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

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local _chain_axe_grips = "chain_axe_grip_01|chain_axe_grip_02|chain_axe_grip_03|chain_axe_grip_04|chain_axe_grip_05|chain_axe_grip_ml01"
--#endregion

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

local changes = {}
return table.combine(
    _combataxe_p3_m1,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            -- head = _combataxe_p3_m1.head_attachments(),
            head = _common_melee.axe_head_attachments(),
            pommel = _combataxe_p3_m1.pommel_attachments(),
            -- grip = _combataxe_p3_m1.grip_attachments(),
            grip = _common_melee.medium_grip_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2)),
            _common_melee.axe_head_models({
                {parent = nil, angle = 0, move = vector3_box(.1, -4, -.1), remove = vector3_box(0, 0, .4), type = nil, no_support = nil, automatic_equip = nil, hide_mesh = nil, mesh_move = nil, special_resolve = function(gear_id, item, attachment, attachment_list)
                    changes = {}
                    local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
                    local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
                    local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                    -- if string_find(attachment, "default") then
                    if mod:cached_find(attachment, "default") then
                        if grip ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                        if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                    else
                        if grip == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                        if pommel == "pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
                    end
                    return changes
                end}
            }),
            _common_melee.medium_grip_models({
                {parent = nil, angle = 0, move = vector3_box(-.1, -4, .2), remove = vector3_box(0, 0, 0), type = nil, no_support = nil, automatic_equip = nil, hide_mesh = nil, mesh_move = nil, special_resolve = function(gear_id, item, attachment, attachment_list)
                    changes = {}
                    local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
                    local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
                    local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                    -- if string_find(attachment, "default") then
                    if mod:cached_find(attachment, "default") then
                        if head ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                        if pommel ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                    else
                        if head == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                        if pommel == "pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
                    end
                    return changes
                end}
            }),
            _combataxe_p3_m1.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), nil, nil, nil, nil, nil, function(gear_id, item, attachment, attachment_list)
                changes = {}
                local grip = attachment_list and attachment_list["grip"] or mod.gear_settings:get(item, "grip")
                local pommel = attachment_list and attachment_list["pommel"] or mod.gear_settings:get(item, "pommel")
                local head = attachment_list and attachment_list["head"] or mod.gear_settings:get(item, "head")
                -- if string_find(attachment, "default") or string_find(attachment, "shovel_pommel_06") then
                if mod:cached_find(attachment, "default") or mod:cached_find(attachment, "shovel_pommel_06") then
                    if head ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                    if grip ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                else
                    if head == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                    if grip == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                end
                return changes
            end)
        ),
        anchors = {
            fixes = {
                -- Grips
                {dependencies = {_chain_axe_grips},
                    grip = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1.5)}},
            }
        },
    }
)