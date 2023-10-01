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
    local unit_alive = Unit.alive
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_has_node = Unit.has_node
    local unit_node = Unit.node
    local unit_flow_event = Unit.flow_event
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_get_child_units = Unit.get_child_units
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_box = QuaternionBox
    local quaternion_unbox = QuaternionBox.unbox
    local math_ease_out_elastic = math.ease_out_elastic
    local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
    local vector3_lerp = Vector3.lerp
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3_one = vector3.one
    local vector3_zero = vector3.zero
    local world_unlink_unit = World.unlink_unit
    local world_link_unit = World.link_unit
    local pairs = pairs
    local ipairs = ipairs
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local managers = Managers
    local table = table
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
        ogryn_rippergun_p1_m1 = {
            default = {position = vector3_box(.5, .6, .4), rotation = vector3_box(200, 0, 90)},
            backpack = {position = vector3_box(-.2, .6, .6), rotation = vector3_box(200, 60, 70)},
            step_sounds = {SoundEventAliases.sfx_ads_up.events.default},
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
                position2 = vector3_box(.2, .6, .1), rotation2 = vector3_box(0, 90, 90),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(.9, .5, .6), rotation = vector3_box(180, -30, 135),
                position2 = vector3_box(.2, .6, .1), rotation2 = vector3_box(0, 90, 90),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            step_sounds2 = {
                SoundEventAliases.sfx_weapon_foley_left_hand_01.events.ogryn_powermaul_slabshield_p1_m1,
                SoundEventAliases.sfx_weapon_foley_left_hand_02.events.ogryn_powermaul_slabshield_p1_m1,
            },
            -- step_sounds2 = {SoundEventAliases.sfx_ads_up.events.default},
        },
    --#endregion
    forcestaff_p1_m1 = {
        default = {position = vector3_box(.3, .2, .075), rotation = vector3_box(180, 80, 90)},
        backpack = {position = vector3_box(.3, .25, .2), rotation = vector3_box(160, 90, 90)},
    }
}
--#region Copies
    --#region Ogryn Guns
        -- mod.visible_equipment_offsets.ogryn_heavystubber_p1_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
        -- mod.visible_equipment_offsets.ogryn_heavystubber_p1_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
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

mod.load_package = function(self, package_name)
    if not managers.package:package_is_known(package_name) then
        managers.package:load(package_name, "weapon_customization")
    end
end

-- Check if player has a backpack
mod.has_backpack = function(self, player, player_unit)
    -- Get profile
	local profile = player and player:profile()
    -- -- Check profile and get local player profile if necessary ( meat grinder )
	-- if not profile then profile = managers.player:local_player(1):profile() end
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
        -- player_unit = inventory_cosmetics_view._preview_player.player_unit
        -- self._character_spawn_data
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

mod.get_equipment_data = function(self, slot)
    -- Get item type
    local item = slot.item and slot.item.__master_item
    local item_type = item and item.item_type == "WEAPON_MELEE" and "melee" or "ranged"
    local item_name = item and self:item_name_from_content_string(item.name)
    -- Get breed
    local player = self:player_from_unit(slot.player_unit)
    local profile = player and player:profile()
    local breed = profile and profile.archetype.breed or "human"
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
        -- dummy_function = item_data and item_data.dummy_function,
    }
    
    return equipment_data, sounds, sounds2
end

mod.position_equipment = function(self, slot)
    local node_name = nil
    local item = slot.item and slot.item.__master_item
    local item_name = item and self:item_name_from_content_string(item.name)
    local player = self:player_from_unit(slot.player_unit)
    local profile = player and player:profile()
    local breed = profile and profile.archetype.breed
    local player_name = player and player:name()
    -- mod:echo(tostring(player_name).." = "..tostring(breed))

    if unit_has_node(slot.player_unit, "j_backpackattach") then
        node_name = "j_backpackattach"
    elseif unit_has_node(slot.player_unit, "j_backpackoffset") then
        node_name = "j_backpackoffset"
    end

    if node_name and unit_has_node(slot.player_unit, node_name) then
        local node_index = unit_node(slot.player_unit, node_name)

        local units = {slot.dummy}
        if item_name == "ogryn_powermaul_slabshield_p1_m1" then
            units = {slot.dummy_attachments[3], slot.dummy_attachments[1]}
        end

        for i, unit in pairs(units) do
            if unit and unit_alive(unit) then
                local add = i == 1 and "" or tostring(i)
                local position_name = "position"..add
                local rotation_name = "rotation"..add
                local scale_name = "scale"..add
                local dummy_name = "dummy"..tostring(i)

                world_unlink_unit(slot.world, unit)
                world_link_unit(slot.world, unit, 1, slot.player_unit, node_index, true)

                local equipment_data = self:get_equipment_data(slot)
                -- if equipment_data.dummy_function then
                --     local slot_info_id = self:get_slot_info_id(slot.item)
                --     equipment_data.dummy_function(unit, slot_info_id)
                -- end

                unit_set_local_position(unit, 1, vector3_unbox(equipment_data[position_name]))
                local rot = vector3_unbox(equipment_data[rotation_name])
                local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                unit_set_local_rotation(unit, 1, rotation)
                unit_set_local_scale(unit, 1, vector3_unbox(equipment_data[scale_name]))

                local default_position_name = "default_position"..add
                local default_rotation_name = "default_rotation"..add

                slot[default_position_name] = equipment_data[position_name]
                slot[default_rotation_name] = equipment_data[rotation_name]

                slot[dummy_name] = unit
            end
        end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.EquipmentComponent, "unequip_item", function(func, self, slot, ...)
	-- Check slot dummy
	if slot.dummy then
		-- Get unit spawner
		local unit_spawner = self._unit_spawner
		-- Mark attachment units for deletion
		if slot.dummy_attachments then
			for _, unit in pairs(slot.dummy_attachments) do
				unit_spawner:mark_for_deletion(unit)
			end
		end
		-- Mark base unit for deletion
		unit_spawner:mark_for_deletion(slot.dummy)
		-- Delete references
		slot.dummy_attachments = nil
		slot.dummy = nil
	end
	-- Original function
	func(self, slot, ...)
end)

mod:hook_require("scripts/utilities/footstep", function(instance)
    
    if not instance._trigger_material_footstep then instance._trigger_material_footstep = instance.trigger_material_footstep end
    instance.trigger_material_footstep = function(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter)
        if mod:get("mod_option_visible_equipment") then
            local equipment = mod:persistent_table("weapon_customization").player_equipment
            if equipment[unit] and sound_alias then
                equipment[unit].trigger = true
                local locomotion_ext = script_unit.extension(unit, "locomotion_system")
                equipment[unit].speed = locomotion_ext:move_speed() * .25
            end
        end
        return instance._trigger_material_footstep(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter)
    end

end)

mod.register_player_equipment = function(self, player_unit, slot)
    local equipment = mod:persistent_table("weapon_customization").player_equipment
    equipment[player_unit] = equipment[player_unit] or {}
    equipment[player_unit][slot] = equipment[player_unit][slot] or {}
    equipment[player_unit].equipment = equipment[player_unit].equipment or {}
    equipment[player_unit].equipment[slot.name] = slot
end

mod.update_equipment_visibility = function(self)
    -- Get registered equipments
    local registered_equipment = self:persistent_table("weapon_customization").player_equipment
    -- Iterate registered equipments
    for player_unit, step_animation in pairs(registered_equipment) do
        -- Get equipment
        local equipment = step_animation.equipment
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
                    -- Set equipment visibility
                    unit_set_unit_visibility(unit, visible, true)
                end
            end
        end
    end
end

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
                            local player_position = Unit.world_position(player_unit, 1)

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
                                    or (player_unit == self.player_unit and self:is_in_third_person() and mod:get("mod_option_visible_equipment_sounds") == "all")
                                if fx_extension and item_name and play_sound and slot_name ~= wielded_slot then
                                    local sounds = i == 1 and slot_sounds or slot_sounds2
                                    if item.item_type == "WEAPON_RANGED" then
                                        local rnd = sounds and math.random(1, #sounds)
                                        sound = sounds and sounds[rnd]
                                        sound = sound or SoundEventAliases.sfx_weapon_up.events[item_name]
                                            or SoundEventAliases.sfx_grab_clip.events[item_name] or SoundEventAliases.sfx_weapon_up.events.default
                                    elseif item.item_type == "WEAPON_MELEE" then
                                        local rnd = sounds and math.random(1, #sounds)
                                        sound = sounds and sounds[rnd]
                                        sound = sound or SoundEventAliases.sfx_weapon_up.events[item_name]
                                            or SoundEventAliases.sfx_grab_clip.events[item_name] or SoundEventAliases.sfx_weapon_up.events.default
                                    end
                                    if sound then
                                        mod:load_package(sound)
                                        fx_extension:trigger_wwise_event(sound, player_position, player_unit, 1)--, "foley_speed", step_animation.speed)
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
        -- Get equipment
        self:position_equipment(slot)
        -- Step animation
        self:register_player_equipment(player_unit, slot)
    elseif item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and slot.dummy then
        -- Get equipment
        self:position_equipment(slot)
    end
end

mod:hook(CLASS.PlayerUnitVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    for slot_name, slot in pairs(self._equipment) do
        local item = slot.item and slot.item.__master_item
        if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and not slot.dummy then
            local attach_settings = self._equipment_component:_attach_settings()
            self._equipment_component:_fill_attach_settings_3p(attach_settings, slot)
            mod:initialize_equipment_slot(slot, self._player, self._equipment_component._world, unit, attach_settings, nil)
            self:force_update_item_visibility()
        end
    end
end)

mod:hook(CLASS.PlayerHuskVisualLoadoutExtension, "update", function(func, self, unit, dt, t, ...)
    func(self, unit, dt, t, ...)
    for slot_name, slot in pairs(self._equipment) do
        local item = slot.item and slot.item.__master_item
        if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and not slot.dummy then
            local attach_settings = self._equipment_component:_attach_settings()
            self._equipment_component:_fill_attach_settings_3p(attach_settings, slot)
            mod:initialize_equipment_slot(slot, self._player, self._equipment_component._world, unit, attach_settings, nil)
            self:force_update_item_visibility()
        end
    end
end)

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)

    local attach_settings = self:_attach_settings()
    self:_fill_attach_settings_3p(attach_settings, slot)
    mod:initialize_equipment_slot(slot, self._player, self._world, unit_3p, attach_settings, optional_mission_template)
end)

mod:hook(CLASS.EquipmentComponent, "_spawn_item_units", function(func, self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, ...)
    func(self, slot, unit_3p, unit_1p, attach_settings, optional_mission_template, ...)

    self:_fill_attach_settings_3p(attach_settings, slot)
    mod:initialize_equipment_slot(slot, self._player, self._world, unit_3p, attach_settings, optional_mission_template)
end)

mod:hook(CLASS.EquipmentComponent, "_spawn_attachments", function(func, self, slot, optional_mission_template, ...)
    func(self, slot, optional_mission_template, ...)

    local attach_settings = self:_attach_settings()
    self:_fill_attach_settings_3p(attach_settings, slot)
    mod:initialize_equipment_slot(slot, self._player, self._world, slot.parent_unit_3p, attach_settings, optional_mission_template)
end)

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
            local item = slot.item and slot.item.__master_item
            local item_name = item and mod:item_name_from_content_string(item.name)

            -- Units
            local units = {slot.dummy}
            if item_name == "ogryn_powermaul_slabshield_p1_m1" then
                units = {slot.dummy1, slot.dummy2}
            end

            for i, unit in pairs(units) do
                if unit and unit_alive(unit) then
                    local visible = mod:get("mod_option_visible_equipment") and slot_name ~= wielded_slot
                    -- Set equipment visibility
                    unit_set_unit_visibility(unit, visible, true)
                end
            end
            -- Position equipment
            mod:position_equipment(slot)
            -- Trigger
            local equipment = mod:persistent_table("weapon_customization").player_equipment
            local player_equipment = equipment[unit_3p]
            if player_equipment and player_equipment.last_wield ~= wielded_slot then
                player_equipment.trigger = true
                player_equipment.last_wield = wielded_slot
            end
        end
    end
end)
