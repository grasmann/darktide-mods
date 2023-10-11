local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local unit_alive = Unit.alive
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_has_node = Unit.has_node
    local unit_node = Unit.node
    local unit_flow_event = Unit.flow_event
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_get_child_units = Unit.get_child_units
    local Quaternion = Quaternion
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local QuaternionBox = QuaternionBox
    local quaternion_box = QuaternionBox
    local quaternion_unbox = QuaternionBox.unbox
    local math = math
    local math_ease_out_elastic = math.ease_out_elastic
    local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
    local math_random = math.random
    local vector3 = Vector3
    local vector3_lerp = vector3.lerp
    local vector3 = vector3
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3_one = vector3.one
    local vector3_zero = vector3.zero
    local World = World
    local world_unlink_unit = World.unlink_unit
    local world_link_unit = World.link_unit
    local world_destroy_unit = World.destroy_unit
    local pairs = pairs
    local ipairs = ipairs
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local managers = Managers
    local table = table
    local tostring = tostring
    table.multi = function(v, c)
        local t = {}
        for i = 1, c do
            t[#t+1] = v
        end
        return t
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
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local ATTACHMENT_SPAWN_STATUS = table.enum("waiting_for_load", "fully_spawned")
mod.step_animation_time_melee = .3
mod.step_animation_time = .3
mod.step_animation_wobble_melee = .75
mod.step_animation_wobble = 1.5
mod.visible_equipment_offsets = {
    ogryn = {
        melee = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(0, 2.5, 2.5)},
            backpack = {position = vector3_box(.75, .5, .2), rotation = vector3_box(180, -30, 135), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, 0, -2.5)},
        },
        ranged = {
            default = {position = vector3_box(.7, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
        },
    },
    human = {
        melee = {
            default = {position = vector3_box(.3, .225, -.1), rotation = vector3_box(180, -80, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.025, .0125, 0), step_rotation = vector3_box(0, 1.25, 1.25)},
            backpack = {position = vector3_box(.3, .25, -.225), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.025, .0125, 0), step_rotation = vector3_box(0, 1.25, 1.25)},
        },
        ranged = {
            default = {position = vector3_box(.3, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            backpack = {position = vector3_box(.3, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
        },
    },
    --#region Ogryn Guns
        ogryn_heavystubber_p1_m1 = {
            dummy_function = function(slot)
                local slot_info_id = mod:get_slot_info_id(slot.item)
                local slot_infos = mod:persistent_table("weapon_customization").attachment_slot_infos
                local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                if attachment_slot_info then
                    local receiver = attachment_slot_info.attachment_slot_to_unit["receiver"]
                    if receiver and unit_alive(receiver) then
                        local node_index = 17
                        local rot = vector3(0, 0, 90)
                        local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                        unit_set_local_rotation(receiver, node_index, rotation)
                    end
                end
            end,
        },
        ogryn_rippergun_p1_m1 = {
            default = {position = vector3_box(.5, .6, .4), rotation = vector3_box(200, 0, 90)},
            backpack = {position = vector3_box(-.2, .6, .6), rotation = vector3_box(200, 60, 70)},
            dummy_function = function(slot)
                -- Get slot info
                local slot_info_id = mod:get_slot_info_id(slot.item)
                local slot_infos = mod:persistent_table("weapon_customization").attachment_slot_infos
                local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                if attachment_slot_info then
                    local handle = attachment_slot_info.attachment_slot_to_unit["handle"]
                    local attachment = attachment_slot_info.unit_to_attachment_name[handle]
                    if handle and unit_alive(handle) then
                        local node_index = 6
                        if attachment == "handle_04" then node_index = 3 end
                        local rot = vector3(0, 0, 90)
                        local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                        unit_set_local_rotation(handle, node_index, rotation)
                    end
                end
            end,
        },
        ogryn_gauntlet_p1_m1 = {
            default = {position = vector3_box(0, .6, .2), rotation = vector3_box(200, 0, 90)},
            backpack = {position = vector3_box(-.2, .9, .1), rotation = vector3_box(-90, 15, 15)},
        },
        ogryn_thumper_p1_m1 = {
            default = {position = vector3_box(.2, .5, .5), rotation = vector3_box(200, 0, 90)},
            backpack = {position = vector3_box(-.2, .5, .6), rotation = vector3_box(200, 60, 70)},
            step_sounds = {SoundEventAliases.sfx_ads_up.events.ogryn_thumper_p1_m1},
        },
    --#endregion
    --#region Ogryn Melee
        ogryn_club_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90)},
            backpack = {position = vector3_box(.75, .5, .2), rotation = vector3_box(180, -30, 135)},
        },
        ogryn_powermaul_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90)},
            backpack = {position = vector3_box(.9, .5, .6), rotation = vector3_box(180, -30, 135)},
        },
        ogryn_powermaul_slabshield_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90),
                position2 = vector3_box(.2, .45, -.2), rotation2 = vector3_box(0, 90, 70),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(.9, .5, .6), rotation = vector3_box(180, -30, 135),
                position2 = vector3_box(.2, .45, -.2), rotation2 = vector3_box(0, 90, 70),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            step_sounds2 = {
                SoundEventAliases.sfx_weapon_foley_left_hand_01.events.ogryn_powermaul_slabshield_p1_m1,
                SoundEventAliases.sfx_weapon_foley_left_hand_02.events.ogryn_powermaul_slabshield_p1_m1,
            },
        },
    --#endregion
    --#region Guns
        forcestaff_p1_m1 = {
            default = {position = vector3_box(.3, .2, .075), rotation = vector3_box(180, 80, 90)},
            backpack = {position = vector3_box(.3, .25, .2), rotation = vector3_box(160, 90, 90)},
        }
    --#endregion
}
--#region Copies
    --#region Ogryn Guns
        mod.visible_equipment_offsets.ogryn_heavystubber_p1_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
        mod.visible_equipment_offsets.ogryn_heavystubber_p1_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
        mod.visible_equipment_offsets.ogryn_rippergun_p1_m2 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
        mod.visible_equipment_offsets.ogryn_rippergun_p1_m3 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
        mod.visible_equipment_offsets.ogryn_thumper_p1_m2 = mod.visible_equipment_offsets.ogryn_thumper_p1_m1
    --#endregion
    --#region Ogryn Melee
        -- mod.visible_equipment_offsets.ogryn_combatblade_p1_m2 = mod.visible_equipment_offsets.ogryn_combatblade_p1_m1
        -- mod.visible_equipment_offsets.ogryn_combatblade_p1_m3 = mod.visible_equipment_offsets.ogryn_combatblade_p1_m1
        -- mod.visible_equipment_offsets.ogryn_club_p2_m2 = mod.visible_equipment_offsets.ogryn_club_p2_m1
        -- mod.visible_equipment_offsets.ogryn_club_p2_m3 = mod.visible_equipment_offsets.ogryn_club_p2_m1
    --#endregion
    --#region Guns
        mod.visible_equipment_offsets.forcestaff_p2_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
        mod.visible_equipment_offsets.forcestaff_p3_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
        mod.visible_equipment_offsets.forcestaff_p4_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
    --#endregion
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Load a package
mod.load_package = function(self, package_name)
    if managers.package:package_is_known(package_name) then
        if not managers.package:has_loaded(package_name) and not managers.package:is_loading(package_name) then
            managers.package:load(package_name, "weapon_customization")
        end
    end
end

-- Check if player has a backpack
mod.has_backpack = function(self, player, player_unit)
    -- Get profile
	local profile = player and player:profile()
    -- Get cosmetic extra slot gear
	local extra = profile and profile.loadout_item_data.slot_gear_extra_cosmetic
    -- Cosmetic view
    local presentation_item = nil
    -- local player_unit = player.player_unit
    if managers.ui:view_active("inventory_cosmetics_view") then
        local inventory_cosmetics_view = managers.ui:view_instance("inventory_cosmetics_view")
        profile = inventory_cosmetics_view and inventory_cosmetics_view._presentation_profile or profile
        presentation_item = profile.loadout.slot_gear_extra_cosmetic
        presentation_item = presentation_item and presentation_item.name
    end
    -- Get extra gear id
    local real_item = extra and extra.id
	local item = presentation_item or real_item
    local equipment = self:persistent_table("weapon_customization").player_equipment
    local player_equipment = equipment[player_unit]
    if player_equipment and player_equipment.last_change ~= item then
        player_equipment.trigger = true
        player_equipment.last_change = item
    end
    -- Check if not empty backpack
	return not item or item ~= "content/items/characters/player/human/backpacks/empty_backpack"
end

mod.hide_bullets = function(self, slot)
    -- Get slot info
    local slot_info_id = mod:get_slot_info_id(slot.item)
    local slot_infos = mod:persistent_table("weapon_customization").attachment_slot_infos
    local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
    if attachment_slot_info then
        for i = 1, 5 do
            local bullet_add = i == 1 and "" or "_0"..tostring(i)
            local bullet = attachment_slot_info.attachment_slot_to_unit["bullet"..bullet_add]
            if bullet then
                world_destroy_unit(slot.world, bullet)
            end
        end
    end
end

-- Get equipment data for a slot
mod.get_equipment_data = function(self, slot)
    -- Get item type
    local item = slot.item and slot.item.__master_item
    local item_type = item and item.item_type == "WEAPON_MELEE" and "melee" or "ranged"
    local item_name = item and self:item_name_from_content_string(item.name)
    -- Get persistent table
    local equipment = mod:persistent_table("weapon_customization").player_equipment
    local player = equipment[slot.player_unit].player
    local breed = equipment[slot.player_unit].breed
    -- Check if has backpack
    local data_type = self:has_backpack(player, slot.player_unit) and "backpack" or "default"
    -- Get default data
    local base_equipment_data = self.visible_equipment_offsets[breed][item_type][data_type]
    local item_data = self.visible_equipment_offsets[item_name]
    local item_equipment_data = item_data and item_data[data_type]
    local sounds = item_data and item_data.step_sounds
    local sounds2 = item_data and item_data.step_sounds2
    local equipment_data = {
        position = item_equipment_data and item_equipment_data.position or base_equipment_data.position,
        position2 = item_equipment_data and item_equipment_data.position2 or base_equipment_data.position,
        rotation = item_equipment_data and item_equipment_data.rotation or base_equipment_data.rotation,
        rotation2 = item_equipment_data and item_equipment_data.rotation2 or base_equipment_data.rotation,
        scale = item_equipment_data and item_equipment_data.scale or base_equipment_data.scale,
        scale2 = item_equipment_data and item_equipment_data.scale2 or base_equipment_data.scale,
        step_move = item_equipment_data and item_equipment_data.step_move or base_equipment_data.step_move,
        step_move2 = item_equipment_data and item_equipment_data.step_move2 or base_equipment_data.step_move,
        step_rotation = item_equipment_data and item_equipment_data.step_rotation or base_equipment_data.step_rotation,
        step_rotation2 = item_equipment_data and item_equipment_data.step_rotation2 or base_equipment_data.step_rotation,
        dummy_function = item_data and item_data.dummy_function,
    }
    
    return equipment_data, sounds, sounds2
end

-- Position equipment of a slot
mod.position_equipment = function(self, slot)
    if slot.player_unit and unit_alive(slot.player_unit) then
        local node_name = nil
        -- Get item
        local item = slot.item and slot.item.__master_item
        local item_name = item and self:item_name_from_content_string(item.name)
        -- Get attachment node
        if unit_has_node(slot.player_unit, "j_backpackattach") then
            node_name = "j_backpackattach"
        elseif unit_has_node(slot.player_unit, "j_backpackoffset") then
            node_name = "j_backpackoffset"
        end
        -- Attach to node
        if node_name and unit_has_node(slot.player_unit, node_name) then
            local node_index = unit_node(slot.player_unit, node_name)
            -- Get list of units ( Slab shield )
            local units = {slot.dummy}
            if item_name == "ogryn_powermaul_slabshield_p1_m1" then
                units = {slot.dummy_attachments[3], slot.dummy_attachments[1]}
            end
            -- Iterate units
            for i, unit in pairs(units) do
                if unit and unit_alive(unit) then
                    -- Property names
                    local add = i == 1 and "" or tostring(i)
                    local position_name = "position"..add
                    local rotation_name = "rotation"..add
                    local scale_name = "scale"..add
                    local dummy_name = "dummy"..tostring(i)
                    -- Link unit to attachment node
                    world_unlink_unit(slot.world, unit)
                    world_link_unit(slot.world, unit, 1, slot.player_unit, node_index, true)
                    -- Get attachment data
                    local equipment_data = self:get_equipment_data(slot)
                    -- Position equipment
                    unit_set_local_position(unit, 1, vector3_unbox(equipment_data[position_name]))
                    -- Rotate equipment
                    local rot = vector3_unbox(equipment_data[rotation_name])
                    local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                    unit_set_local_rotation(unit, 1, rotation)
                    -- Scale equipment
                    unit_set_local_scale(unit, 1, vector3_unbox(equipment_data[scale_name]))
                    -- Default property names
                    local default_position_name = "default_position"..add
                    local default_rotation_name = "default_rotation"..add
                    -- Set default values
                    slot[default_position_name] = equipment_data[position_name]
                    slot[default_rotation_name] = equipment_data[rotation_name]
                    -- Save unit reference
                    slot[dummy_name] = unit
                end
            end
        end
    end
end

-- Register player equipment for slot
mod.register_player_equipment = function(self, player_unit, slot)
    -- Get persistent table
    local equipment = mod:persistent_table("weapon_customization").player_equipment
    -- Set equipment
    equipment[player_unit] = equipment[player_unit] or {}
    equipment[player_unit][slot] = equipment[player_unit][slot] or {}
    equipment[player_unit].equipment = equipment[player_unit].equipment or {}
    equipment[player_unit].equipment[slot.name] = slot
    -- Get breed
    local player = self:player_from_unit(slot.player_unit)
    local player_name = player:name()
    local profile = player and player:profile()
    local breed = profile and profile.archetype.breed or "human"
    equipment[player_unit].name = equipment[player_unit].name or player_name
    equipment[player_unit].player = equipment[player_unit].player or player
    equipment[player_unit].breed = equipment[player_unit].breed or breed
    -- Dummy function
    local equipment_data = self:get_equipment_data(slot)
    if equipment_data.dummy_function then
        equipment_data.dummy_function(slot)
    end
    -- Hide bullets
    self:hide_bullets(slot)
    -- Position equipment
    mod:position_equipment(slot)
end

mod.get_sound_effect = function(self, item_name)
    return SoundEventAliases.sfx_ads_up.events[item_name]
        or SoundEventAliases.sfx_ads_down.events[item_name]
        or SoundEventAliases.sfx_equip.events.default
end

-- Update equipment visibility
mod.update_equipment_visibility = function(self)
    -- Get registered equipments
    local registered_equipment = self:persistent_table("weapon_customization").player_equipment
    -- Iterate registered equipments
    for player_unit, step_animation in pairs(registered_equipment) do
        -- Get equipment
        local equipment = step_animation.equipment
        if equipment then
            -- Get wielded slot
            local loadout_extension = script_unit.extension(player_unit, "visual_loadout_system")
            local inventory_component = loadout_extension and loadout_extension._inventory_component
            local wielded_slot = inventory_component and inventory_component.wielded_slot or "slot_unarmed"
            -- Iterate slots
            for slot_name, slot in pairs(equipment) do
                -- Get item name
                local item = slot.item and slot.item.__master_item
                local item_name = item and self:item_name_from_content_string(item.name)
                -- Get units
                local units = {slot.dummy}
                if item_name == "ogryn_powermaul_slabshield_p1_m1" then
                    units = {slot.dummy1, slot.dummy2}
                end
                -- Iterate units
                for i, unit in pairs(units) do
                    if unit and unit_alive(unit) then
                        -- Get visibility
                        local visible = self:get("mod_option_visible_equipment") and slot_name ~= wielded_slot
                            and (slot.player_unit ~= self.player_unit or self:is_in_third_person())
                        -- Set equipment visibility
                        unit_set_unit_visibility(unit, visible, true)
                    end
                end
                -- Position equipment
                mod:position_equipment(slot)
            end
        end
    end
end

-- Update equipment animations
mod.update_equipment = function(self, dt)
    if self:get("mod_option_visible_equipment") then
        -- Get game time
        local t = managers.time:time("main")
        local registered_equipment = mod:persistent_table("weapon_customization").player_equipment
        -- Iterate players
        for player_unit, step_animation in pairs(registered_equipment) do
            if player_unit and unit_alive(player_unit) then
                if step_animation and step_animation.equipment then

                    -- Get equipment
                    local equipment = step_animation.equipment
                    -- Get wielded slot
                    local loadout_extension = script_unit.extension(player_unit, "visual_loadout_system")
                    local inventory_component = loadout_extension and loadout_extension._inventory_component
                    local wielded_slot = inventory_component and inventory_component.wielded_slot or "slot_unarmed"

                    -- Check trigger
                    if step_animation.trigger then
                        for slot_name, slot in pairs(equipment) do
                            if step_animation[slot].state ~= "step" then
                                local item = slot.item and slot.item.__master_item
                                local item_type = item and item.item_type == "WEAPON_MELEE" and "melee" or "ranged"
                                step_animation[slot] = step_animation[slot] or {}
                                step_animation[slot].end_time = t + (item_type == "ranged" and self.step_animation_time or self.step_animation_time_melee)
                                step_animation[slot].state = nil
                            end
                        end
                        step_animation.trigger = nil
                    end

                    local dd = {}

                    -- Process animation part step
                    for slot_name, slot in pairs(equipment) do
                        local item = slot.item and slot.item.__master_item
                        local item_name = item and self:item_name_from_content_string(item.name)
                        local item_type = item and item.item_type == "WEAPON_MELEE" and "melee" or "ranged"
                        local slot_data, slot_sounds, slot_sounds2 = self:get_equipment_data(slot)
                        
                        local units = {slot.dummy}
                        if item_name == "ogryn_powermaul_slabshield_p1_m1" then
                            units = {slot.dummy1, slot.dummy2}
                        end

                        step_animation[slot] = step_animation[slot] or {}
                        dd[slot] = {}
                        dd[slot].position = slot.default_position and vector3_unbox(slot.default_position) or vector3_zero()
                        dd[slot].position2 = slot.default_position2 and vector3_unbox(slot.default_position2) or vector3_zero()
                        dd[slot].rotation = slot.default_rotation and vector3_unbox(slot.default_rotation) or vector3_zero()
                        dd[slot].rotation2 = slot.default_rotation2 and vector3_unbox(slot.default_rotation2) or vector3_zero()
                        dd[slot].p_move = (slot_data.step_move and vector3_unbox(slot_data.step_move) or vector3_zero()) * (step_animation.speed or 1)
                        dd[slot].p_move2 = (slot_data.step_move2 and vector3_unbox(slot_data.step_move2) or vector3_zero()) * (step_animation.speed or 1)
                        dd[slot].r_move = (slot_data.step_rotation and vector3_unbox(slot_data.step_rotation) or vector3_zero()) * (step_animation.speed or 1)
                        dd[slot].r_move2 = (slot_data.step_rotation2 and vector3_unbox(slot_data.step_rotation2) or vector3_zero()) * (step_animation.speed or 1)

                        -- Start step animation
                        if not step_animation[slot].state and step_animation[slot].end_time then
                            step_animation[slot].state = "step"
                            
                            -- Play sound
                            local fx_extension = script_unit.extension(player_unit, "fx_system")
                            local player_position = unit_world_position(player_unit, 1)

                            for i, unit in pairs(units) do
                                local add = i == 1 and "" or tostring(i)
                                local position_name = "position"..add
                                local rotation_name = "rotation"..add

                                -- Set default position
                                if unit and unit_alive(unit) then
                                    -- Set position
                                    unit_set_local_position(unit, 1, dd[slot][position_name])
                                    -- Set rotation
                                    local rot = dd[slot][rotation_name]
                                    local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                                    unit_set_local_rotation(unit, 1, rotation)
                                end

                                -- Play sound
                                local sound = nil
                                local play_sound = (player_unit ~= self.player_unit and mod:get("mod_option_visible_equipment_sounds") ~= "off")
                                    or (player_unit == self.player_unit and (self:is_in_third_person() or mod:get("mod_option_visible_equipment_own_sounds_fp")) and mod:get("mod_option_visible_equipment_sounds") == "all")
                                if fx_extension and item_name and play_sound and slot_name ~= wielded_slot then
                                    local sounds = i == 1 and slot_sounds or slot_sounds2
                                    local rnd = sounds and math_random(1, #sounds)
                                    sound = sounds and sounds[rnd]
                                    sound = sound or mod:get_sound_effect(item_name)
                                    -- if item.item_type == "WEAPON_RANGED" then
                                    --     local rnd = sounds and math_random(1, #sounds)
                                    --     sound = sounds and sounds[rnd]
                                    --     sound = sound or mod:get_sound_effect(item_name)
                                    --         -- SoundEventAliases.sfx_weapon_up.events[item_name]
                                    --         -- or SoundEventAliases.sfx_grab_clip.events[item_name] or SoundEventAliases.sfx_weapon_up.events.default
                                    -- elseif item.item_type == "WEAPON_MELEE" then
                                    --     local rnd = sounds and math_random(1, #sounds)
                                    --     sound = sounds and sounds[rnd]
                                    --     sound = sound or mod:get_sound_effect(item_name)
                                    --         -- SoundEventAliases.sfx_weapon_up.events[item_name]
                                    --         -- or SoundEventAliases.sfx_grab_clip.events[item_name] or SoundEventAliases.sfx_weapon_up.events.default
                                    -- end
                                    if sound then
                                        mod:load_package(sound)
                                        fx_extension:trigger_wwise_event(sound, true, true, player_unit, 1, "foley_speed", step_animation.speed)-- player_position)--, player_unit, 1)--, "foley_speed", step_animation.speed)
                                    end
                                end
                            end
                            
                        elseif step_animation[slot].state == "step" and t < step_animation[slot].end_time then
                            -- Lerp values
                            for i, unit in pairs(units) do
                                local add = i == 1 and "" or tostring(i)
                                local position_name = "position"..add
                                local rotation_name = "rotation"..add
                                local p_move_name = "p_move"..add
                                local r_move_name = "r_move"..add

                                local progress = (step_animation[slot].end_time - t) / (item_type == "ranged" and self.step_animation_time or self.step_animation_time_melee)
                                local anim_progress = math_easeOutCubic(1 - progress)
                                local lerp_position = vector3_lerp(dd[slot][position_name], dd[slot][position_name] + dd[slot][p_move_name], anim_progress)
                                local lerp_rotation = vector3_lerp(dd[slot][rotation_name], dd[slot][rotation_name] + dd[slot][r_move_name], anim_progress)
                            
                                if unit and unit_alive(unit) then
                                    -- Set position
                                    unit_set_local_position(unit, 1, lerp_position)
                                    -- Set rotation
                                    local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                    unit_set_local_rotation(unit, 1, rotation)
                                end
                            end
                            -- Check end of part step
                        elseif step_animation[slot].state == "step" and t >= step_animation[slot].end_time then
                            -- Start part wobble
                            step_animation[slot].state = "wobble"
                            step_animation[slot].end_time = t + (item_type == "ranged" and self.step_animation_wobble or self.step_animation_wobble_melee)
                            for i, unit in pairs(units) do
                                local add = i == 1 and "" or tostring(i)
                                local position_name = "position"..add
                                local rotation_name = "rotation"..add
                                local p_move_name = "p_move"..add
                                local r_move_name = "r_move"..add

                                -- Set move position and rotation
                                if unit and unit_alive(unit) then
                                    -- Set position
                                    unit_set_local_position(unit, 1, dd[slot][position_name] + dd[slot][p_move_name])
                                    -- Set rotation
                                    local lerp_rotation = dd[slot][rotation_name] + dd[slot][r_move_name]
                                    local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                    unit_set_local_rotation(unit, 1, rotation)
                                end
                            end
                        elseif step_animation[slot].state == "wobble" and t < step_animation[slot].end_time then
                            for i, unit in pairs(units) do
                                local add = i == 1 and "" or tostring(i)
                                local position_name = "position"..add
                                local rotation_name = "rotation"..add
                                local p_move_name = "p_move"..add
                                local r_move_name = "r_move"..add

                                -- Lerp values
                                local progress = (step_animation[slot].end_time - t) / (item_type == "ranged" and self.step_animation_wobble or self.step_animation_wobble_melee)
                                local anim_progress = math_ease_out_elastic(1 - progress)
                                local lerp_position = vector3_lerp(dd[slot][position_name] + dd[slot][p_move_name], dd[slot][position_name], anim_progress)
                                local lerp_rotation = vector3_lerp(dd[slot][rotation_name] + dd[slot][r_move_name], dd[slot][rotation_name], anim_progress)

                                -- Set move position and rotation
                                if unit and unit_alive(unit) then
                                    -- Set position
                                    unit_set_local_position(unit, 1, lerp_position)
                                    -- Set rotation
                                    local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                    unit_set_local_rotation(unit, 1, rotation)
                                end
                            end
                            -- Check part end
                        elseif step_animation[slot].state == "wobble" and t >= step_animation[slot].end_time then
                            -- End animation
                            step_animation[slot].state = nil
                            step_animation[slot].end_time = nil
                            for i, unit in pairs(units) do
                                local add = i == 1 and "" or tostring(i)
                                local position_name = "position"..add
                                local rotation_name = "rotation"..add
                                local p_move_name = "p_move"..add
                                local r_move_name = "r_move"..add

                                -- Set default position and rotation
                                if unit and unit_alive(unit) then
                                    -- Set position
                                    unit_set_local_position(unit, 1, dd[slot][position_name])
                                    -- Set rotation
                                    local rot = dd[slot][rotation_name]
                                    local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                                    unit_set_local_rotation(unit, 1, rotation)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Get player from player_unit
mod.player_from_unit = function(self, unit)
    if unit then
        local player_manager = managers.player
        for _, player in pairs(player_manager:players()) do
            if player.player_unit == unit then
                return player
            end
        end
    end
    return managers.player:local_player(1)
end

-- Initialize equipment slot
mod.initialize_equipment_slot = function(self, slot, player, world, player_unit, attach_settings, optional_mission_template)
    -- Check item
	local item = slot.item and slot.item.__master_item
	if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and not slot.dummy
            and (slot.item_loaded or slot.attachment_spawn_status == ATTACHMENT_SPAWN_STATUS.fully_spawned) then
        -- Add slot info
        slot.player_unit = player_unit
        slot.world = world
        -- Set attach settings
		attach_settings.skip_link_children = true
        -- Spawn dummy weapon
		slot.dummy, slot.dummy_attachments = VisualLoadoutCustomization.spawn_item(slot.item, attach_settings, player_unit, nil, optional_mission_template)
		VisualLoadoutCustomization.add_extensions(nil, slot.dummy_attachments, attach_settings)
        -- Unwield flow event
        unit_flow_event(slot.dummy, "lua_unwield")
        -- Step animation
        self:register_player_equipment(player_unit, slot)
        -- Get equipment
        self:position_equipment(slot)
    elseif item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and slot.dummy then
        -- Get equipment
        self:position_equipment(slot)
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.UIProfileSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, unit_3p, ...)
    func(self, unit_3p, ...)
    if self._character_spawn_data and self._character_spawn_data.profile then
        -- Get persistent table
        local equipment = mod:persistent_table("weapon_customization").player_equipment
        -- Set breed
        local profile = self._character_spawn_data.profile
        equipment[unit_3p] = equipment[unit_3p] or {}
        equipment[unit_3p].name = profile.name
        local archetype = profile.archetype
        local breed_name = archetype and archetype.breed or profile.breed
        equipment[unit_3p].breed = breed_name
    end
end)

-- Delete dummy equipment units
mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
	-- Check slot dummy
	if slot.dummy then
		-- Get unit spawner
		local unit_spawner = self._unit_spawner
        local extension_manager = managers.state.extension
		-- Mark attachment units for deletion
		if slot.dummy_attachments then
			for _, unit in pairs(slot.dummy_attachments) do
                if unit and unit_alive(unit) then
                    if extension_manager then
                        extension_manager:unregister_unit(unit)
                    end
                    world_unlink_unit(self._world, unit)
                    unit_spawner:mark_for_deletion(unit)
                end
			end
		end
		-- Mark base unit for deletion
        if extension_manager then
            extension_manager:unregister_unit(slot.dummy)
        end
		unit_spawner:mark_for_deletion(slot.dummy)
		-- Delete references
		slot.dummy_attachments = nil
		slot.dummy = nil
	end
	-- Original function
	func(self, slot, ...)
end)

-- Capture footsteps for equipment animation
mod:hook_require("scripts/utilities/footstep", function(instance)
    -- Backup original function
    if not instance._trigger_material_footstep then instance._trigger_material_footstep = instance.trigger_material_footstep end
    -- Hook
    instance.trigger_material_footstep = function(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter)
        -- Check mod option
        if mod:get("mod_option_visible_equipment") then
            -- Check equipment
            local equipment = mod:persistent_table("weapon_customization").player_equipment
            if equipment[unit] and sound_alias then
                -- Trigger step
                equipment[unit].trigger = true
                -- Set speed
                local locomotion_ext = script_unit.extension(unit, "locomotion_system")
                equipment[unit].speed = locomotion_ext:move_speed() * .25
            end
        end
        -- Original function
        return instance._trigger_material_footstep(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter)
    end
end)

-- Load dummy equipment units
mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    -- Iterate slots
    for slot_name, slot in pairs(self._equipment) do
        -- Get item
        local item = slot.item and slot.item.__master_item
        -- Check item and dummy
        if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and not slot.dummy then
            -- Get attach settings
            local attach_settings = self._equipment_component:_attach_settings()
            self._equipment_component:_fill_attach_settings_3p(attach_settings, slot)
            -- Initialize slot
            mod:initialize_equipment_slot(slot, self._player, self._equipment_component._world, unit, attach_settings, nil)
            -- Update visibility
            self:force_update_item_visibility()
        end
    end
end)

-- Load dummy equipment units
mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    -- Iterate slots
    for slot_name, slot in pairs(self._equipment) do
        -- Get item
        local item = slot.item and slot.item.__master_item
        -- Check item and dummy
        if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and not slot.dummy then
            -- Get attach settings
            local attach_settings = self._equipment_component:_attach_settings()
            self._equipment_component:_fill_attach_settings_3p(attach_settings, slot)
            -- Initialize slot
            mod:initialize_equipment_slot(slot, self._player, self._equipment_component._world, unit, attach_settings, nil)
            -- Update visibility
            self:force_update_item_visibility()
        end
    end
end)

-- Load dummy equipment on equip
mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    -- Get attach settings
    local attach_settings = self:_attach_settings()
    self:_fill_attach_settings_3p(attach_settings, slot)
    -- Initialize slot
    mod:initialize_equipment_slot(slot, self._player, self._world, unit_3p, attach_settings, optional_mission_template)
end)

-- Load dummy equipment
mod:hook(CLASS.EquipmentComponent, "_spawn_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, ...)
    func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, ...)
    -- Get attach settings
    self:_fill_attach_settings_3p(attach_settings, slot)
    -- Initialize slot
    mod:initialize_equipment_slot(slot, self._player, self._world, unit_3p, attach_settings, optional_mission_template)
end)

-- Load dummy equipment
mod:hook(CLASS.EquipmentComponent, "_spawn_attachments", function(func, self, slot, optional_mission_template, ...)
    func(self, slot, optional_mission_template, ...)
    -- Get attach settings
    local attach_settings = self:_attach_settings()
    self:_fill_attach_settings_3p(attach_settings, slot)
    -- Initialize slot
    mod:initialize_equipment_slot(slot, self._player, self._world, slot.parent_unit_3p, attach_settings, optional_mission_template)
end)

-- Update dummy equipment visibility
mod:hook(CLASS.EquipmentComponent, "update_item_visibility", function(func, equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
	func(equipment, wielded_slot, unit_3p, unit_1p, first_person_mode, ...)
    -- Managed slots
    local slots = {"slot_primary", "slot_secondary"}
    -- Iterate slots
    for _, slot_name in pairs(slots) do
        -- Get slot
        local slot = equipment[slot_name]
        -- Check slot
        if slot and slot.dummy then
            -- Get item
            local item = slot.item and slot.item.__master_item
            local item_name = item and mod:item_name_from_content_string(item.name)
            -- Get units ( Slab shield )
            local units = {slot.dummy}
            if item_name == "ogryn_powermaul_slabshield_p1_m1" then
                units = {slot.dummy1, slot.dummy2}
            end
            -- Iterate units
            for i, unit in pairs(units) do
                if unit and unit_alive(unit) then
                    local visible = mod:get("mod_option_visible_equipment") and slot_name ~= wielded_slot
                        and (slot.player_unit ~= mod.player_unit or mod:is_in_third_person())
                    -- Set equipment visibility
                    unit_set_unit_visibility(unit, visible, true)
                end
            end
            -- Position equipment
            mod:position_equipment(slot)

            -- Trigger equipment animation
            local equipment_ = mod:persistent_table("weapon_customization").player_equipment
            local player_equipment = equipment_[unit_3p]
            if player_equipment and player_equipment.last_wield ~= wielded_slot then
                player_equipment.trigger = true
                player_equipment.last_wield = wielded_slot
            end
        end
    end
end)
