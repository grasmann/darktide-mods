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
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local ATTACHMENT_SPAWN_STATUS = table.enum("waiting_for_load", "fully_spawned")

mod.visible_equipment_offsets = {
    ogryn = {
        melee = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(0, 0, 10)},
            backpack = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(0, 0, 10)},
        },
        ranged = {
            default = {position = vector3_box(.7, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(-10, 2, 0)},
            backpack = {position = vector3_box(.7, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(-10, 2, 0)},
        },
    },
    human = {
        melee = {
            default = {position = vector3_box(.3, .3, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(0, 0, 10)},
            backpack = {position = vector3_box(.3, .3, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(0, 0, 10)},
        },
        ranged = {
            default = {position = vector3_box(.3, .3, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(-10, 2, 0)},
            backpack = {position = vector3_box(.3, .3, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1), angular_move = vector3_box(-10, 2, 0)},
        },
    }
    -- ogryn_heavystubber_p1_m1 = {
    --     default = {position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_one()},
    --     backpack = {position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_one()},
    -- },
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Check if player has a backpack
mod.has_backpack = function(self, player)
    -- Get profile
	local profile = player and player:profile()
    -- Check profile and get local player profile if necessary ( meat grinder )
	if not profile then profile = managers.player:local_player(1):profile() end
    -- Get cosmetic extra slot gear
	local extra = profile.loadout_item_data.slot_gear_extra_cosmetic
    -- Get extra gear id
	local item = extra and extra.id
    -- Check if not empty backpack
	return item and item ~= "items/characters/player/human/backpacks/empty_backpack"
end

mod.get_equipment_data = function(self, slot)
    -- Get item type
    local item = slot.item and slot.item.__master_item
    local item_type = item.item_type == "WEAPON_MELEE" and "melee" or "ranged"
    -- Get breed
    local profile = slot.player:profile()
    local breed = profile and profile.archetype.breed or "human"
    -- Check if has backpack
    local data_type = self:has_backpack(slot.player) and "backpack" or "default"
    -- Get default data
    local equipment_data = self.visible_equipment_offsets[breed][item_type][data_type]
    
    return equipment_data
end

mod.position_equipment = function(self, slot)
    local node_name = nil
    local item = slot.item and slot.item.__master_item
    local profile = slot.player and slot.player:profile()
    local breed = profile and profile.archetype.breed
    -- local player_unit = slot.player_unit

    if unit_has_node(slot.player_unit, "j_backpackattach") then
        node_name = "j_backpackattach"
    elseif unit_has_node(slot.player_unit, "j_backpackoffset") then
        node_name = "j_backpackoffset"
    end

    if node_name and unit_has_node(slot.player_unit, node_name) then
        local node_index = unit_node(slot.player_unit, node_name)
        if slot.dummy and unit_alive(slot.dummy) then
            world_unlink_unit(slot.world, slot.dummy)
            world_link_unit(slot.world, slot.dummy, 1, slot.player_unit, node_index, true)

            local equipment_data = self:get_equipment_data(slot)

            unit_set_local_position(slot.dummy, 1, vector3_unbox(equipment_data.position))
            local rot = vector3_unbox(equipment_data.rotation)
            local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
            unit_set_local_rotation(slot.dummy, 1, rotation)
            unit_set_local_scale(slot.dummy, 1, vector3_unbox(equipment_data.scale))

            slot.default_position = equipment_data.position
            slot.default_rotation = equipment_data.rotation
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
        -- mod.step_animations[unit] = mod.step_animations[unit] or {}
        local equipment = mod:persistent_table("weapon_customization").player_equipment
        if equipment[unit] then
            equipment[unit].trigger = true
            equipment[unit].speed = optional_set_speed_parameter
        end
        return instance._trigger_material_footstep(sound_alias, wwise_world, physics_world, source_id, unit, node, query_from, query_to, optional_set_speed_parameter, optional_set_first_person_parameter)
    end

end)

mod.step_animation_time = .2
mod.step_animation_wobble = 3
mod.step_animation_angular = 2
-- mod.step_animations = {}
-- mod.step_animation_end = nil
-- mod.step_animation_state = nil

mod.register_player_equipment = function(self, player_unit, slot)
    local equipment = mod:persistent_table("weapon_customization").player_equipment
    equipment[player_unit] = equipment[player_unit] or {}
    equipment[player_unit].equipment = equipment[player_unit].equipment or {}
    equipment[player_unit].equipment[slot.name] = slot
end

mod.update_equipment = function(self, dt)
    -- if self.initialized then
        -- Get players
        -- local players = managers.player:players()
        -- if #players == 0 then
        --     players = {managers.player:local_player(1)}
        -- end
        -- Slots
        -- local slots = {"slot_primary", "slot_secondary"}
        -- Get game time
        local t = managers.time:time("main")
        local equipment = mod:persistent_table("weapon_customization").player_equipment
        -- Iterate players
        for player_unit, step_animation in pairs(equipment) do
            -- Get player unit
            -- local player_unit = player.player_unit
            if player_unit and unit_alive(player_unit) then
                -- Get step animation
                -- self.step_animations[player_unit] = self.step_animations[player_unit] or {}
                -- local step_animation = self.step_animations[player_unit]
                -- Check
                if step_animation and step_animation.equipment then

                    -- Check trigger
                    if step_animation.trigger then
                        step_animation.end_time = t + self.step_animation_time
                        step_animation.state = nil
                        step_animation.trigger = nil
                        -- mod:echo("speed: "..tostring(step_animation.speed))
                    end

                    -- Rotation
                    local node_name = "j_hips"
                    if unit_has_node(player_unit, "j_backpackattach") then
                        node_name = "j_backpackattach"
                    elseif unit_has_node(player_unit, "j_backpackoffset") then
                        node_name = "j_backpackoffset"
                    end
                    local player_rotation = Unit.world_rotation(player_unit, Unit.node(player_unit, node_name))
                    local direction = Quaternion.forward(player_rotation)
                    local last_rotation = step_animation.last_rotation and quaternion_unbox(step_animation.last_rotation) or player_rotation
                    local last_direction = Quaternion.forward(last_rotation) or direction
                    if not mod:vector3_equal(direction, last_direction) then
                        local _, _, z, _ = Quaternion.to_euler_angles_xyz(player_rotation)
                        local _, _, z2, _ = Quaternion.to_euler_angles_xyz(last_rotation)
                        local new_angular_move = z2 - z
                        local old_angular_move = step_animation.angular_move or 0
                        -- step_animation.angular_move = math.clamp(new_angular_move, -2, 2)
                        if (new_angular_move > 0 and new_angular_move > old_angular_move)
                                or (new_angular_move < 0 and new_angular_move < old_angular_move)
                                or (old_angular_move < 0 and new_angular_move > 0)
                                or (old_angular_move > 0 and new_angular_move < 0) then
                            step_animation.angular_move = math.clamp(new_angular_move, -2, 2)
                            -- step_animation.angular_move_end_time = t + self.step_animation_angular
                        end
                        step_animation.angular_move_end_time = t + self.step_animation_angular
                    end
                    step_animation.last_rotation = quaternion_box(player_rotation)

                    -- Get equipment
                    local loadout_extension = script_unit.extension(player_unit, "visual_loadout_system")
                    -- local equipment = loadout_extension and loadout_extension._equipment
                    local equipment = step_animation.equipment
                    -- Get wielded slot
                    local inventory_component = loadout_extension and loadout_extension._inventory_component
                    local wielded_slot = inventory_component and inventory_component.wielded_slot or "slot_unarmed"

                    local dd = {}
                    for slot_name, slot in pairs(equipment) do
                        -- local slot = equipment[slot_name]
                        dd[slot] = {}
                        dd[slot].position = slot.default_position and vector3_unbox(slot.default_position) or vector3_zero()
                        dd[slot].rotation = slot.default_rotation and vector3_unbox(slot.default_rotation) or vector3_zero()
                        dd[slot].p_move = dd[slot].position * -.07
                        dd[slot].r_move = dd[slot].rotation * -.07
                    end

                    -- Start step animation
                    if not step_animation.state and step_animation.end_time then
                        step_animation.state = "step"
                        -- Set default position for slots
                        for slot_name, slot in pairs(equipment) do
                            -- Get slot
                            -- local slot = equipment[slot_name]
                            if slot.dummy and unit_alive(slot.dummy) then
                                -- Set position
                                unit_set_local_position(slot.dummy, 1, dd[slot].position)
                                -- Set rotation
                                local rotation = quaternion_from_euler_angles_xyz(dd[slot].rotation[1], dd[slot].rotation[2], dd[slot].rotation[3])
                                unit_set_local_rotation(slot.dummy, 1, rotation)
                            end
                        end
                        
                    end

                    -- Process animation part step
                    if step_animation.state == "step" then
                        -- Process slots
                        for slot_name, slot in pairs(equipment) do
                            -- Get slot
                            -- local slot = equipment[slot_name]
                            -- Lerp values
                            local progress = (step_animation.end_time - t) / self.step_animation_time
                            local anim_progress = math_easeOutCubic(1 - progress)
                            local lerp_position = vector3_lerp(dd[slot].position, dd[slot].position + dd[slot].p_move, anim_progress)
                            local lerp_rotation = vector3_lerp(dd[slot].rotation, dd[slot].rotation + dd[slot].r_move, anim_progress)
                            if slot.dummy and unit_alive(slot.dummy) then
                                -- Set position and rotation
                                unit_set_local_position(slot.dummy, 1, lerp_position)
                                local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                unit_set_local_rotation(slot.dummy, 1, rotation)
                            end
                        end
                        -- Check end of part step
                        if t >= step_animation.end_time then
                            -- Start part wobble
                            step_animation.state = "wobble"
                            step_animation.end_time = t + self.step_animation_wobble
                            -- Process slots
                            for slot_name, slot in pairs(equipment) do
                                -- Get slot
                                -- local slot = equipment[slot_name]
                                if slot.dummy and unit_alive(slot.dummy) then
                                    -- Set position and rotation
                                    unit_set_local_position(slot.dummy, 1, dd[slot].position + dd[slot].p_move)
                                    local lerp_rotation = dd[slot].rotation + dd[slot].r_move
                                    local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                    unit_set_local_rotation(slot.dummy, 1, rotation)
                                end
                                -- Get item
                                local item = slot.item and slot.item.__master_item
                                if item then
                                    local item_name = self:item_name_from_content_string(item.name)
                                    local fx_extension = script_unit.extension(player_unit, "fx_system")
                                    local player_position = Unit.world_position(player_unit, 1)
                                    -- Play sound
                                    if player_unit ~= self.player_unit or self:is_in_third_person() and slot_name ~= wielded_slot then
                                        local sound = nil
                                        if item.item_type == "WEAPON_RANGED" then
                                            sound = SoundEventAliases.sfx_grab_clip.events[item_name] or SoundEventAliases.sfx_weapon_up.events[item_name] or SoundEventAliases.sfx_weapon_up.events.default
                                            -- if sound then fx_extension:trigger_wwise_event(sound, player_position, player_unit, 1) end

                                        elseif item.item_type == "WEAPON_MELEE" then
                                            -- sound = SoundEventAliases.sfx_equip.events[item_name]
                                            -- if sound then fx_extension:trigger_wwise_event(sound, false, slot.player_unit, 1) end
                                        end
                                        if sound then
                                            fx_extension:trigger_wwise_event(sound, player_position, player_unit, 1, "foley_speed", step_animation.speed)
                                        end
                                    end
                                end
                            end
                        end

                    -- Process part wobble
                    elseif step_animation.state == "wobble" then
                        -- Process slots
                        for slot_name, slot in pairs(equipment) do
                            -- Get slot
                            -- local slot = equipment[slot_name]
                            -- Lerp values
                            local progress = (step_animation.end_time - t) / self.step_animation_wobble
                            local anim_progress = math_ease_out_elastic(1 - progress)
                            local lerp_position = vector3_lerp(dd[slot].position + dd[slot].p_move, dd[slot].position, anim_progress)
                            local lerp_rotation = vector3_lerp(dd[slot].rotation + dd[slot].r_move, dd[slot].rotation, anim_progress)
                            if slot.dummy and unit_alive(slot.dummy) then
                                -- Set position and rotation
                                unit_set_local_position(slot.dummy, 1, lerp_position)
                                local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                                unit_set_local_rotation(slot.dummy, 1, rotation)
                            end
                        end
                        -- Check part end
                        if t >= step_animation.end_time then
                            -- End animation
                            step_animation.state = nil
                            step_animation.end_time = nil
                            -- Process slots
                            for slot_name, slot in pairs(equipment) do
                                -- Get slot
                                -- local slot = equipment[slot_name]
                                if slot.dummy and unit_alive(slot.dummy) then
                                    -- Set position and rotation
                                    unit_set_local_position(slot.dummy, 1, dd[slot].position)
                                    local rotation = quaternion_from_euler_angles_xyz(dd[slot].rotation[1], dd[slot].rotation[2], dd[slot].rotation[3])
                                    unit_set_local_rotation(slot.dummy, 1, rotation)
                                end
                            end
                        end

                    end

                    if step_animation.angular_move then

                        local angular_lerp_move = step_animation.angular_move
                        if step_animation.angular_move_end_time then
                            if t < step_animation.angular_move_end_time then
                                local progress = (step_animation.angular_move_end_time - t) / self.step_animation_angular
                                local anim_progress = math_ease_out_elastic(1 - progress)
                                angular_lerp_move = math.lerp(step_animation.angular_move, 0, anim_progress)
                            else
                                step_animation.angular_move = 0
                                angular_lerp_move = 0
                                step_animation.angular_move_end_time = nil
                            end
                        end

                        for slot_name, slot in pairs(equipment) do
                            if slot.dummy and unit_alive(slot.dummy) then
                                local equipment_data = self:get_equipment_data(slot)
                                -- local end_rotation = Unit.local_rotation(slot.dummy, 1)
                                -- local x, y, z = Quaternion.to_euler_angles_xyz(dd[slot].rotation)
                                -- z = z + step_animation.angular_move
                                local angular_move = equipment_data.angular_move and vector3_unbox(equipment_data.angular_move) or vector3_zero()
                                local rotation = dd[slot].rotation + angular_move * angular_lerp_move
                                local end_rotation = Quaternion.from_euler_angles_xyz(rotation[1], rotation[2], rotation[3])
                                Unit.set_local_rotation(slot.dummy, 1, end_rotation)
                            end
                        end
                    end
                end
            end
        end
    -- end
end

mod.initialize_equipment_slot = function(self, slot, player, world, player_unit, attach_settings, optional_mission_template)
    -- Check item
	local item = slot.item and slot.item.__master_item
	if item and (item.item_type == "WEAPON_MELEE" or item.item_type == "WEAPON_RANGED") and slot.item_loaded and not slot.dummy then
        -- Add slot info
        slot.player = player or managers.player:local_player(1)
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
    end
end

mod:hook(CLASS.EquipmentComponent, "equip_item", function(func, self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)
    func(self, unit_3p, unit_1p, slot, item, optional_existing_unit_3p, deform_overrides, optional_breed_name, optional_mission_template, ...)

    local attach_settings = self:_attach_settings()
    self:_fill_attach_settings_3p(attach_settings, slot)
    mod:initialize_equipment_slot(slot, self._player, self._world, slot.parent_unit_3p, attach_settings, optional_mission_template)
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
		if slot and slot.dummy and slot.player then
            -- Set equipment visibility
			unit_set_unit_visibility(slot.dummy, slot_name ~= wielded_slot, true)
            -- Position equipment
            mod:position_equipment(slot)
		end
	end
end)
