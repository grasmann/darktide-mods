local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
    local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
    local InputService = mod:original_require("scripts/managers/input/input_service")
    local footstep_intervals_templates = mod:original_require("scripts/settings/equipment/footstep/footstep_intervals_templates")
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
    local VisibleEquipmentOffsets = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/visible_equipment/offsets")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local math = math
    local type = type
    local World = World
    local pairs = pairs
    local CLASS = CLASS
    local table = table
    local class = class
    local ipairs = ipairs
    local string = string
    local vector3 = Vector3
    local vector3 = vector3
    local wc_perf = wc_perf
    local callback = callback
    local math_abs = math.abs
    local managers = Managers
    local tostring = tostring
    local unit_node = Unit.node
    local Matrix4x4 = Matrix4x4
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local table_enum = table.enum
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local vector3_one = vector3.one
    local math_random = math.random
    local string_find = string.find
    local vector3_lerp = vector3.lerp
    local vector3_zero = vector3.zero
    local wc_perf_stop = wc_perf.stop
    local unit_get_data = Unit.get_data
    local unit_set_data = Unit.set_data
    local unit_has_data = Unit.has_data
    local unit_has_node = Unit.has_node
    local QuaternionBox = QuaternionBox
    local table_combine = table.combine
    local wc_perf_start = wc_perf.start
    local quaternion_box = QuaternionBox
    local table_icombine = table.icombine
    local unit_flow_event = Unit.flow_event
    local vector3_unbox = vector3_box.unbox
    local world_link_unit = World.link_unit
    local math_easeOutCubic = math.easeOutCubic
    local math_easeInCubic = math.easeInCubic
    local world_unlink_unit = World.unlink_unit
    local quaternion_unbox = QuaternionBox.unbox
    local world_destroy_unit = World.destroy_unit
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_local_position = Unit.local_position
    local unit_local_rotation = Unit.local_rotation
    local matrix4x4_transform = Matrix4x4.transform
    local unit_set_local_scale = Unit.set_local_scale
    local unit_get_child_units = Unit.get_child_units
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_to_vector = Quaternion.to_vector
    local math_ease_out_elastic = math.ease_out_elastic
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_force_stream_meshes = Unit.force_stream_meshes
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local OFF = "off"
    local ALL = "all"
    local WALK = "walk"
    local SPRINT = "sprint"
    local STEP_STATE = "step"
    local DEFAULT = "default"
    local ANIM_TIME_MELEE = .3
    local ANIM_TIME_RANGED = .3
    local BACKPACK = "backpack"
    local STEP_WOBBLE = "wobble"
    local ANIM_TIME_WOBBLE_MELEE = .6
    local ANIM_TIME_WOBBLE_RANGED = .6
    local WEAPON_MELEE = "WEAPON_MELEE"
    local STEP_STATE_BACK = "step_back"
    local SLOT_UNARMED = "slot_unarmed"
    local SLOT_PRIMARY = "slot_primary"
    local WEAPON_RANGED = "WEAPON_RANGED"
    local SLOT_SECONDARY = "slot_secondary"
    local REFERENCE = "weapon_customization"
    local BACKPACK_ATTACH = "j_backpackattach"
    local BACKPACK_OFFSET = "j_backpackoffset"
    local SLAB_SHIELD = "ogryn_powermaul_slabshield_p1_m1"
    local SLOT_GEAR_EXTRA_COSMETIC = "slot_gear_extra_cosmetic"
    local ATTACHMENT_SPAWN_STATUS = table_enum("waiting_for_load", "fully_spawned")
    local BACKPACK_EMPTY = "content/items/characters/player/human/backpacks/empty_backpack"
    local WEIGHT_FACTORS = {
        light = .66,
        medium = .33,
        heavy = .1,
    }
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local VisibleEquipmentExtension = class("VisibleEquipmentExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

VisibleEquipmentExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Parent
    VisibleEquipmentExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.init", 2)
    -- Attributes
    self.loading_spawn_point = extension_init_data.loading_spawn_point
    self.equipment_component = extension_init_data.equipment_component
    self.equipment = extension_init_data.equipment
    self.wielded_slot = extension_init_data.wielded_slot or SLOT_UNARMED
    self.ui_profile_spawner = extension_init_data.ui_profile_spawner
    self.back_node = self:current_back_node()
    self:set_foot_step_interval()
    self.trigger_wobble = nil
    self.back_change = nil
    self.unit_spawner = self.equipment_component._unit_spawner
    self.step_speed = 1
    self.is_in_hub = mod:is_in_hub()
    -- Slot specific
    self.slot_loaded = {}
    self.slot_is_loading = {}
    self.item_names = {}
    self.item_types = {}
    self.dummy_units = {}
    self.is_linked = {}
    self.equipment_data = {}
    self.slot_infos = {}
    self.packages = {}
    self.step_animation = {}
    self.sounds = {}
    self.rotate_animation = {}
    self.weapon_template = {}
    self.size = {}
    self.weight = {}
    self.visible = {}
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Settings
    self:on_settings_changed()
    -- Initialized
    self.initialized = true
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.delete = function(self)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.delete", 2)
    -- Events
    managers.event:unregister(self, "weapon_customization_settings_changed")
    -- Uninitialize
    self.initialized = false
    -- Iterate slots
    for slot_name, slot in pairs(self.equipment) do
        -- Delete
        self:delete_slot(slot)
    end
    -- Performance
    wc_perf_stop(perf)
    -- Parent
    VisibleEquipmentExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

VisibleEquipmentExtension.backpack_name = function(self)
    if self:has_backpack() then
        return self.backpack_name
    end
end

VisibleEquipmentExtension.has_backpack = function(self)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.has_backpack", 2)
    -- Get cosmetic extra slot gear
    local gear_extra = self.equipment[SLOT_GEAR_EXTRA_COSMETIC]
	local real_item = gear_extra and gear_extra.item and gear_extra.item.name
    -- Cosmetic view
    local presentation_item = nil
    local inventory_cosmetics_view = mod:get_cosmetic_view()
    if inventory_cosmetics_view then
        local profile = inventory_cosmetics_view and inventory_cosmetics_view._presentation_profile or self.profile
        presentation_item = profile.loadout.slot_gear_extra_cosmetic
        presentation_item = presentation_item and presentation_item.name
    end
    -- Get extra gear id
	local item = presentation_item or real_item
    self.backpack_name = item and mod:item_name_from_content_string(item)
    -- Trigger wobble
    if item and self.back_change ~= item then
        self.trigger_wobble = true
        self.back_change = item
    end
    -- Performance
    wc_perf_stop(perf)
    -- Check if not empty backpack
	return item and item ~= BACKPACK_EMPTY
end

VisibleEquipmentExtension.equipment_data_by_slot = function(self, slot)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.equipment_data_by_slot", 2)
    -- Check if has backpack
    local data_type = self:has_backpack() and BACKPACK or DEFAULT
    local offsets = mod.visible_equipment_offsets
    -- Get data
    local item_data = offsets[self.item_names[slot]]
    local item_equipment_data = item_data and item_data[data_type]
    -- Bots
    item_equipment_data = item_equipment_data or offsets.human[self.item_types[slot]][data_type]
    -- Loading
    if self.loading_spawn_point then
        item_equipment_data = item_data and item_data.loading[self.loading_spawn_point]
        if not item_equipment_data then
            if slot.name == "slot_scondary" then
                item_equipment_data = mod.visible_equipment_offsets.human[WEAPON_RANGED].loading[self.loading_spawn_point]
            else
                item_equipment_data = mod.visible_equipment_offsets.human[WEAPON_MELEE].loading[self.loading_spawn_point]
            end
        end
    end
    -- Sounds
    local sounds = item_equipment_data and item_equipment_data.step_sounds or item_data and item_data.step_sounds
    local sounds2 = item_equipment_data and item_equipment_data.step_sounds2 or item_data and item_data.step_sounds2
    local attach_node = item_equipment_data and item_equipment_data.attach_node or item_data and item_data.attach_node
    -- Compile equipment data
    local equipment_data = {
        position = {item_equipment_data.position, item_equipment_data.position2},
        rotation = {item_equipment_data.rotation, item_equipment_data.rotation2},
        scale = {item_equipment_data.scale, item_equipment_data.scale2},
        step_move = {item_equipment_data.step_move, item_equipment_data.step_move2},
        step_rotation = {item_equipment_data.step_rotation, item_equipment_data.step_rotation2},
        init = item_data and item_data.init,
        wield = item_data and item_data.wield,
        attach_node = attach_node,
    }
    -- Performance
    wc_perf_stop(perf)
    -- Return data
    return equipment_data, sounds, sounds2
end

VisibleEquipmentExtension.weapon_unit = function(self, slot_id)
    local slot = self.equipment and self.equipment[slot_id]
    return slot and self.dummy_units[slot] and self.dummy_units[slot].base
end

VisibleEquipmentExtension.current_back_node = function(self)
    if self.player_unit and unit_alive(self.player_unit) then
        if unit_has_node(self.player_unit, BACKPACK_ATTACH) then
            return BACKPACK_ATTACH
        elseif unit_has_node(self.player_unit, BACKPACK_OFFSET) then
            return BACKPACK_OFFSET
        end
    end
    return 1
end

VisibleEquipmentExtension.get_breed = function(self)
    return self.back_node == BACKPACK_OFFSET and "ogryn" or "human"
end

VisibleEquipmentExtension.get_foot_step_interval = function(self)
    -- local crouching = self.movement_state_component and self.movement_state_component.is_crouching
    -- local alt_fire = self.alternate_fire_component and self.alternate_fire_component.is_active
    -- local sprint = self.sprint_character_state_component and self.sprint_character_state_component.is_sprinting
    -- sprint = self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == SPRINT or sprint
    -- crouching = self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == WALK or crouching
    if self:is_sprinting() then
        if self.footstep_intervals and self.footstep_intervals.sprinting then return self.footstep_intervals.sprinting end
        return footstep_intervals_templates.default.sprinting
    elseif self:is_crouching() then
        if self:is_alt_fire() then
            if self.footstep_intervals and self.footstep_intervals.crouch_walking_alternate_fire then return self.footstep_intervals.crouch_walking_alternate_fire end
            return footstep_intervals_templates.default.crouch_walking_alternate_fire
        end
        if self.footstep_intervals and self.footstep_intervals.crouch_walking then return self.footstep_intervals.crouch_walking end
        return footstep_intervals_templates.default.crouch_walking
    else
        if self:is_alt_fire() then
            if self.footstep_intervals and self.footstep_intervals.walking_alternate_fire then return self.footstep_intervals.walking_alternate_fire end
            return footstep_intervals_templates.default.walking_alternate_fire
        end
        if self.footstep_intervals and self.footstep_intervals.walking then return self.footstep_intervals.walking end
        return footstep_intervals_templates.default.walking
    end
end

VisibleEquipmentExtension.is_weapon_slot = function(self, slot)
    return slot.name == SLOT_SECONDARY or slot.name == SLOT_PRIMARY
end

VisibleEquipmentExtension.is_alt_fire = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

VisibleEquipmentExtension.is_crouching = function(self)
    local is_crouching = self.movement_state_component and self.movement_state_component.is_crouching
    return self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == WALK or is_crouching
end

VisibleEquipmentExtension.is_sprinting = function(self)
    local is_sprinting = self.sprint_character_state_component and self.sprint_character_state_component.is_sprinting
    return self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == SPRINT or is_sprinting
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

VisibleEquipmentExtension.set_spectated = function(self, spectated)
    self.spectated = spectated
end

VisibleEquipmentExtension.set_foot_step_interval = function(self)
    if self.initialized then
        local wielded_slot = self.wielded_slot
        if wielded_slot and self.slot_loaded[wielded_slot] then
            local item = wielded_slot and wielded_slot.item
            local weapon_template = self.weapon_template[wielded_slot]
            self.footstep_intervals = weapon_template and weapon_template.footstep_intervals
        elseif not wielded_slot or wielded_slot.name == SLOT_UNARMED then
            local breed = self:get_breed()
            local hub = self.is_in_hub and "_hub" or ""
            local name = "unarmed_"..tostring(breed)..tostring(hub)
            if footstep_intervals_templates[name] then
                self.footstep_intervals = footstep_intervals_templates[name]
            end
        end
    end
end

mod:hook_require("scripts/settings/equipment/footstep/footstep_intervals_templates", function(footstep_intervals_templates)
    footstep_intervals_templates.unarmed_human_hub = {
		crouch_walking = 0.61,
		walking = 0.37,
		sprinting = 0.33
	}
	footstep_intervals_templates.unarmed_ogryn_hub = {
		crouch_walking = 0.70,
		walking = 0.60,
		sprinting = 0.54
	}
end)

VisibleEquipmentExtension.set_estimated_weapon_data = function(self, slot)
    local item_name = self.item_names[slot]
    local size = "medium"
    local weight = "medium"

    -- Names
    local entries = {
        combatknife_ = {size = "small", weight = "light"},
        forcestaff_ = {size = "huge", weight = "medium"},
        autopistol_ = {size = "small", weight = "small"},
        bolter_ = {size = "medium", weight = "heavy"},
        chainsword_2h_ = {size = "huge", weight = "heavy"},
        flamer_ = {size = "medium", weight = "heavy"},
        plasmagun_ = {size = "medium", weight = "heavy"},
        powermaul_2h_ = {size = "huge", weight = "heavy"},
        thunderhammer_2h_ = {size = "huge", weight = "heavy"},
        ogryn_gauntlet_ = {size = "huge", weight = "heavy"},
        ogryn_heavystubber_ = {size = "huge", weight = "heavy"},
        ogryn_powermaul_slabshield_ = {size = "huge", weight = "heavy"},
        ogryn_rippergun_ = {size = "huge", weight = "heavy"},
        ogryn_thumper_ = {size = "huge", weight = "medium"},
    }
    for search, entry in pairs(entries) do
        if string_find(item_name, search) then
            size = entry.size
            weight = entry.weight
        end
    end

    -- Attachments

    --

    self.size[slot] = size
    self.weight[slot] = weight

end

VisibleEquipmentExtension.hide_bullets = function(self, slot)
    mod:hide_bullets(self.dummy_units[slot].attachments)
end

VisibleEquipmentExtension.trigger_step = function(self, optional_time_overwrite)
    self.trigger_wobble = true
    self.time_overwrite = optional_time_overwrite
    for slot_name, slot in pairs(self.equipment) do
        if self.step_animation[slot] then
            self.step_animation[slot].time = self.time_overwrite or self.step_animation[slot].time
            self.step_animation[slot].time_wobble = self.time_overwrite or self.step_animation[slot].time_wobble
        end
    end
end

VisibleEquipmentExtension.link_equipment = function(self)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.link_equipment", 2)
    -- Attach to node
    local node_index, attach_unit = unit_node(self.player_unit, self.back_node), self.player_unit
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        -- Check dummies
        if self.dummy_units[slot] and not self.is_linked[slot] then
            -- Data
            local data = self.equipment_data[slot]
            local attach_node = data.attach_node
            local attach_node_index = nil
            if attach_node and unit_has_node(self.player_unit, attach_node) then
                attach_node_index = unit_node(self.player_unit, attach_node)
            end
            -- Get list of units ( Slab shield )
            local units = {self.dummy_units[slot].base}
            if self.item_names[slot] == SLAB_SHIELD then
                units = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
            end
            -- Iterate units
            for i, unit in pairs(units) do
                if unit and unit_alive(unit) then
                    -- Link unit to attachment node
                    world_unlink_unit(self.world, unit)
                    world_link_unit(self.world, unit, 1, attach_unit, attach_node_index or node_index, true)
                    -- Scale equipment
                    local ms = unit_get_data(unit, "unit_manipulation_scale_offset") 
                    ms = ms and vector3_unbox(ms) or vector3(0, 0, 0)
                    unit_set_local_scale(unit, 1, vector3_unbox(data.scale[i]) + ms)
                end
            end
            -- Set linked
            self.is_linked[slot] = true
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.position_equipment = function(self) --, optional_position, optional_rotation)
    -- local optional_position = optional_position or vector3(0, 0, 0)
    -- local opt_rot = optional_rotation or vector3(0, 0, 0)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.position_equipment", 2)
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        -- Check dummies
        if self.dummy_units[slot] and self.is_linked[slot] then
            -- Data
            local data = self.equipment_data[slot]
            -- Get list of units ( Slab shield )
            local units = {self.dummy_units[slot].base}
            if self.item_names[slot] == SLAB_SHIELD then
                units = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
            end
            -- Iterate units
            for i, unit in pairs(units) do
                if unit and unit_alive(unit) then
                    local rot = vector3_unbox(data.rotation[i])
                    local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                    -- Position equipment
                    local mp = unit_get_data(unit, "unit_manipulation_position_offset") 
                    mp = mp and vector3_unbox(mp) or vector3(0, 0, 0)
                    unit_set_local_position(unit, 1, vector3_unbox(data.position[i]) + mp)
                    -- Rotate equipment
                    local mr = unit_get_data(unit, "unit_manipulation_rotation_offset")
                    mr = mr and quaternion_unbox(mr) or Quaternion.identity()
                    rotation = Quaternion.multiply(rotation, mr)
                    unit_set_local_rotation(unit, 1, rotation)
                end
            end
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.delete_slot = function(self, slot)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.delete_slot", 2)
    local extension_manager = managers.state.extension
    -- Check base unit
    if self.dummy_units[slot] and self.dummy_units[slot].base then
        -- Check attachment units
        if self.dummy_units[slot].attachments then
            -- Iterate attachments
            for _, unit in pairs(self.dummy_units[slot].attachments) do
                -- Check unit
                if unit and unit_alive(unit) then
                    if extension_manager then
                        extension_manager:unregister_unit(unit)
                    end
                    -- Unlink unit
                    world_unlink_unit(self.world, unit)
                end
            end
            for _, unit in pairs(self.dummy_units[slot].attachments) do
                -- Check unit
                if unit and unit_alive(unit) then
                    -- Delete unit
                    world_destroy_unit(self.world, unit)
                end
            end
        end
        if self.dummy_units[slot].base and unit_alive(self.dummy_units[slot].base) then
            if extension_manager then
                extension_manager:unregister_unit(self.dummy_units[slot].base)
            end
            -- Unlink unit
            world_unlink_unit(self.world, self.dummy_units[slot].base)
            -- Delete unit
            world_destroy_unit(self.world, self.dummy_units[slot].base)
        end
    end
    -- Package
    self:release_slot_packages(slot)
    -- Delete references
    self.dummy_units[slot] = nil
    self.item_names[slot] = nil
    self.item_types[slot] = nil
    self.equipment_data[slot] = nil
    self.packages[slot] = nil
    self.slot_loaded[slot] = nil
    self.slot_is_loading[slot] = nil
    self.step_animation[slot] = nil
    self.sounds[slot] = nil
    self.rotate_animation[slot] = nil
    self.is_linked[slot] = nil
    self.slot_infos[slot] = nil
    self.weapon_template[slot] = nil
    self.size[slot] = nil
    self.weight[slot] = nil
    self.visible[slot] = nil
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.cb_on_unit_3p_streaming_complete = function(self, slot)
end

VisibleEquipmentExtension.load_slot = function(self, slot)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.load_slot", 2)
    -- Load
    if self.initialized and self:is_weapon_slot(slot) then
        local item = slot.item and slot.item.__master_item
        if not self.slot_loaded[slot] and not self.slot_is_loading[slot] then
            local item_good = item and (item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED)
            local loaded = slot.item_loaded or slot.attachment_spawn_status == ATTACHMENT_SPAWN_STATUS.fully_spawned
            if item_good and loaded then
                self.slot_is_loading[slot] = true
                -- Item name
                self.item_names[slot] = mod:item_name_from_content_string(item.name)
                -- Item type
                self.item_types[slot] = item.item_type
                -- Animation
                self.step_animation[slot] = {}
                self.step_animation[slot].time = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_MELEE or ANIM_TIME_RANGED
                self.step_animation[slot].time_wobble = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_WOBBLE_MELEE or ANIM_TIME_WOBBLE_RANGED
                self.rotate_animation[slot] = {}
                self.weapon_template[slot] = WeaponTemplate.weapon_template_from_item(slot.item)
                -- Attach settings
                local attach_settings = self.equipment_component:_attach_settings()
                self.equipment_component:_fill_attach_settings_3p(attach_settings, slot)
                attach_settings.skip_link_children = true
                -- Spawn dummy weapon
                self.dummy_units[slot] = {}
                self.dummy_units[slot].base, self.dummy_units[slot].attachments = VisualLoadoutCustomization.spawn_item(slot.item, attach_settings, self.player_unit)
                -- mod:info("self.dummy_units[slot].base: "..tostring(self.dummy_units[slot].base))
                -- for i, unit in pairs(self.dummy_units[slot].attachments) do
                --     mod:info("self.dummy_units[slot].attachments"..tostring(i)..": "..tostring(self.dummy_units[slot].base))
                -- end
                -- unit_set_data(self.dummy_units[slot].base, "visible_equipment", true)
                -- VisualLoadoutCustomization.add_extensions(nil, self.dummy_units[slot].attachments, attach_settings)
                -- Performance
                local callback = callback(self, "cb_on_unit_3p_streaming_complete", slot)
                unit_force_stream_meshes(self.dummy_units[slot].base, callback, true)
                if self.dummy_units[slot].attachments then
                    for _, unit in pairs(self.dummy_units[slot].attachments) do
                        unit_force_stream_meshes(unit, callback, true)
                    end
                end
                -- Hide bullets
                self:hide_bullets(slot)
                -- Equipment data
                local data, sounds_1, sounds_2 = self:equipment_data_by_slot(slot)
                local sounds_3 = SoundEventAliases.sfx_ads_up.events[self.item_names[slot]]
                    or SoundEventAliases.sfx_ads_down.events[self.item_names[slot]]
                    or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
                    or SoundEventAliases.sfx_equip.events.default
                local sounds_4 = SoundEventAliases.sfx_weapon_foley_left_hand_01.events[self.item_names[slot]]
                    or SoundEventAliases.sfx_ads_down.events[self.item_names[slot]]
                    or SoundEventAliases.sfx_ads_down.events.default
                self.equipment_data[slot] = data
                -- Load sound packages
                self.packages[slot] = {}
                self:load_slot_packages(slot, table_icombine(
                    sounds_1 or {},
                    sounds_2 or {},
                    {sounds_3},
                    {sounds_4},
                    self:get_dependencies(slot)
                ))
                -- Sounds
                self.sounds[slot] = {
                    sounds_1,
                    sounds_2,
                    sounds_3,
                    sounds_4,
                }
                -- Init function
                if self.equipment_data[slot].init then
                    self.equipment_data[slot].init(self, slot)
                end
                -- Estimate values
                self:set_estimated_weapon_data(slot)
                -- Trigger equipment animation
                self.trigger_wobble = true
                -- Position equipment
                self:link_equipment()
                self:position_equipment()
                -- Visibility
                self:on_update_item_visibility()
                -- Set flags
                self.slot_loaded[slot] = true
                self.slot_is_loading[slot] = nil
            end
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.play_equipment_sound = function(self, slot, index, allow_crouching, allow_wielded)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.play_equipment_sound", 2)
    -- Play
    local wielded_slot_name = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
    local slot = slot or self.equipment[wielded_slot_name]
    local index = index or 1
    -- Play sound
    local sound = nil
    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
    local play_sound = (not self.is_local_unit and self.sound ~= OFF)
        or (self.is_local_unit and (not first_person or self.sound_fp)
        and self.sound == ALL)
    local slot_valid = slot and (slot.name ~= wielded_slot_name or allow_wielded)
    local allow_crouching = allow_crouching or true
    local crouching = not self:is_crouching() or allow_crouching
    local husk = not self.is_local_unit and not self.spectated
    if play_sound and slot_valid and crouching and self.sounds[slot] then
        local sounds = index == 1 and self.sounds[slot][1] or self.sounds[slot][2]
        local rnd = sounds and math_random(1, #sounds)
        sound = sounds and sounds[rnd] or self.sounds[slot][3]
        if not self:is_sprinting() then sound = self.sounds[slot][4] end
        if sound and self.fx_extension then
            self.fx_extension:trigger_wwise_event(sound, husk, true, self.player_unit, 1, "foley_speed", self.step_speed)
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

-- ##### ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #####################################################################################
-- ##### ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #####################################################################################
-- ##### ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #####################################################################################

VisibleEquipmentExtension.get_dependencies = function(self, slot)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.get_dependencies", 2)
    -- Setup definitions
    mod:setup_item_definitions()
    local found_packages = {}
    -- Get master item
    local item = slot.item and slot.item.__master_item
    -- Get definition
    local item_definition = mod:persistent_table(REFERENCE).item_definitions[item.name]
    -- Check resource dependencies
    if item_definition and item_definition.resource_dependencies then
        -- Iterate dependencies
        for package_name, _ in pairs(item_definition.resource_dependencies) do
            -- Add package
            found_packages[#found_packages+1] = package_name
        end
    end
    -- Performance
    wc_perf_stop(perf)
    -- Return package list
    return found_packages
end

VisibleEquipmentExtension.release_slot_packages = function(self, slot)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.release_slot_packages", 2)
    -- Release
    local count = 0
    if self.packages[slot] then
        for package_name, package_id in pairs(self.packages[slot]) do
            -- Unload package
            managers.package:release(package_id)
            -- Remove package id
            self.packages[slot][package_name] = nil

            count = count + 1
        end
    end
    if count > 0 then
        mod:print("Release "..tostring(count).." packages for "..tostring(self.player_unit).." "..tostring(slot.name))
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.load_slot_packages = function(self, slot, packages)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.load_slot_packages", 2)
    -- Load
    local count = 0
    for _, package_name in pairs(packages) do
        -- Check if loaded
        if not self.packages[slot][package_name] then
            -- Load package
            local ref = REFERENCE.."_"..tostring(self.player_unit)
            self.packages[slot][package_name] = managers.package:load(package_name, ref)
            
            count = count + 1
        end
    end
    if count > 0 then
        mod:print("Load "..tostring(count).." packages for "..tostring(self.player_unit).." "..tostring(slot.name))
    end
    -- Performance
    wc_perf_stop(perf)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

VisibleEquipmentExtension.on_equip_slot = function(self, slot)
    self:load_slot(slot)
end

VisibleEquipmentExtension.on_unequip_slot = function(self, slot)
    self:delete_slot(slot)
end

VisibleEquipmentExtension.on_wield_slot = function(self, slot)
    -- Set new wielded slot
    self.wielded_slot = slot
    -- Execute optional wield function
    if self.equipment_data[slot] and self.equipment_data[slot].wield then
        self.equipment_data[slot].wield(self, self.wielded_slot)
    end

    -- if self.dummy_units[slot] and self.dummy_units[slot].base and self.dummy_units[slot].attachments then
    --     local item = slot.item and slot.item.__master_item
    --     mod:spawn_premium_effects(item, self.dummy_units[slot].base, self.dummy_units[slot].attachments, self.world)
    -- end

    -- Set step interval
    self:set_foot_step_interval()
end

VisibleEquipmentExtension.on_unwield_slot = function(self, slot)
    -- Execute optional unwield function
    if self.equipment_data[slot] and self.equipment_data[slot].unwield then
        self.equipment_data[slot].unwield(self, self.wielded_slot)
    end

    -- if self.dummy_units[slot] and self.dummy_units[slot].base and self.dummy_units[slot].attachments then
    --     local item = slot.item and slot.item.__master_item
    --     mod:despawn_premium_effects(item, self.dummy_units[slot].base, self.dummy_units[slot].attachments, self.world)
    -- end

    -- Set step interval
    self:set_foot_step_interval()
end

VisibleEquipmentExtension.on_update_item_visibility = function(self, wielded_slot)
    -- Update wielded slot
    if wielded_slot then
        self:on_unwield_slot(self.wielded_slot)
        self.wielded_slot = self.equipment[wielded_slot]
        self:on_wield_slot(self.wielded_slot)
    end
    -- Update visibility
    self:update_equipment_visibility()
end

VisibleEquipmentExtension.on_footstep = function(self)
    -- Check mod optionm
    if self.on then
        local locomotion_ext = script_unit.extension(self.player_unit, "locomotion_system")
        local speed = locomotion_ext and locomotion_ext:move_speed() or 0
        if speed > 0 then
            self:set_foot_step_interval()
            self:trigger_step()
        end
    end
end

VisibleEquipmentExtension.on_settings_changed = function(self)
    self.on = mod:get("mod_option_visible_equipment")
    self.sound = mod:get("mod_option_visible_equipment_sounds")
    self.sound_fp = mod:get("mod_option_visible_equipment_own_sounds_fp")
end

VisibleEquipmentExtension.load_slots = function(self)
    -- Iterate slots
    for slot_name, slot in pairs(self.equipment) do
        -- Load
        self:load_slot(slot)
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

VisibleEquipmentExtension.update = function(self, dt, t)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.update", 2)
    -- Update
    if self.initialized then
        -- Equipment data
        self:update_equipment_data()
        -- Position
        self:position_equipment()
        -- Animation
        self:update_animation(dt, t)
        -- Visibility
        self:on_update_item_visibility()
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.update_equipment_visibility = function(self, dt, t)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.update_equipment_visibility", 2)
    -- Values
    local wielded_slot = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
    local spectated = not self.is_local_unit and (not self.spectated or not first_person)
    local player = self.is_local_unit and not first_person
    -- Iterate slots
    for slot_name, slot in pairs(self.equipment) do
        -- Values
        local slot_not_wielded = slot_name ~= wielded_slot
        local visible = slot_not_wielded and (player or spectated)
        -- Check units
        if self.dummy_units[slot] then
            local item = slot.item and slot.item.__master_item
            -- Get units
            local units = table_combine({self.dummy_units[slot].base}, self.dummy_units[slot].attachments)
            -- if self.item_names[slot] == SLAB_SHIELD then
            --     units = self.dummy_units[slot].attachments
            -- end
            -- Iterate units
            for i, unit in pairs(units) do
                -- Check unit
                if unit and unit_alive(unit) then
                    -- Set equipment visibility
                    unit_set_unit_visibility(unit, visible, true)
                    -- if visible then
                    --     mod:spawn_premium_effects(item, self.dummy_units[slot].base, self.dummy_units[slot].attachments, self.world)
                    -- else
                    --     mod:despawn_premium_effects(item, self.dummy_units[slot].base, self.dummy_units[slot].attachments, self.world)
                    -- end
                end
            end
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.update_equipment_data = function(self)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.update_equipment_data", 2)
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        -- Check slot
        if self.slot_loaded[slot] then
            -- Update data
            self.equipment_data[slot] = self:equipment_data_by_slot(slot)
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

VisibleEquipmentExtension.get_vectors_almost_same = function(self, v1, v2, tolerance)
    local tolerance = tolerance or .5
    local v1 = v1 or vector3_zero()
    local v2 = v2 or vector3_zero()
    if math_abs(v1[1] - v2[1]) < tolerance and math_abs(v1[2] - v2[2]) < tolerance and math_abs(v1[3] - v2[3]) < tolerance then
        return true
    end
end

VisibleEquipmentExtension.update_animation = function(self, dt, t)
    -- Performance
    local perf = wc_perf_start("VisibleEquipmentExtension.update_animation", 2)
    -- Update
    local locomotion = (self.locomotion_ext and self.locomotion_ext:move_speed() or 0)
    self.step_speed = math.max(math.abs(locomotion), 1)
    local wobble_was_triggered = self.trigger_wobble
    self.trigger_wobble = nil
    local rotation_unit = not self.is_in_hub and self.first_person_unit or self.player_unit
    local parent_rotation = quaternion_to_vector(unit_world_rotation(rotation_unit, 1))
    local last_player_rotation = self.last_player_rotation and vector3_unbox(self.last_player_rotation) or parent_rotation
    local rotation_diff = last_player_rotation - parent_rotation
    self.last_player_rotation = vector3_box(parent_rotation)
    -- Process animation part step
    for slot_name, slot in pairs(self.equipment) do
        -- Check slot
        if self.slot_loaded[slot] then
            -- Weight
            local weight = self.weight[slot]
            local weight_factor = weight and WEIGHT_FACTORS[weight] or .33
            -- Get units
            local units = {self.dummy_units[slot].base}
            if self.item_names[slot] == SLAB_SHIELD then
                units = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
            end
            -- Get data
            local data = self.equipment_data[slot]
            -- Animation
            if self.step_animation[slot] then
                -- Lengths
                self.step_animation[slot].length = self:get_foot_step_interval()
                self.step_animation[slot].step_length = self.step_animation[slot].length * .4
                self.step_animation[slot].back_length = self.step_animation[slot].length * .6
                self.step_animation[slot].wobble_length = self.step_animation[slot].length * 6
                -- Trigger
                if wobble_was_triggered then
                    if locomotion == 0 then
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    elseif self.step_animation[slot].state ~= STEP_STATE and self.step_animation[slot].state ~= STEP_STATE_BACK then
                        if slot.name == SLOT_SECONDARY then
                            self.step_animation[slot].state = STEP_STATE
                            self.step_animation[slot].end_time = t + self.step_animation[slot].step_length * 1
                        else
                            self.step_animation[slot].state = STEP_STATE
                            self.step_animation[slot].end_time = t + self.step_animation[slot].step_length * 2
                        end
                    end
                end
                -- Values
                local get_values = function(i, speed)
                    local default_position = vector3_unbox(data.position[i])
                    local position_move = vector3_unbox(data.step_move[i]) * (speed or self.step_speed)
                    local default_rotation = vector3_unbox(data.rotation[i])
                    local rotation_move = vector3_unbox(data.step_rotation[i]) * (speed or self.step_speed)
                    return default_position, position_move, default_rotation, rotation_move
                end
                -- Start step animation
                if not self.step_animation[slot].state and self.step_animation[slot].end_time then
                    if locomotion > 0 then
                        self.step_animation[slot].state = STEP_STATE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].step_length
                    else
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    end
                    -- Play sound
                    for i, unit in pairs(units) do
                        -- Set default position
                        if unit and unit_alive(unit) then
                            -- Set position
                            local default_position = vector3_unbox(data.position[i])
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            local rotation = quaternion_from_vector(vector3_unbox(data.rotation[i]))
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                    
                -- STEP
                elseif self.step_animation[slot].state == STEP_STATE and t < self.step_animation[slot].end_time then
                    if locomotion == 0 then
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    end
                    -- Lerp values
                    for i, unit in pairs(units) do
                        local progress = (self.step_animation[slot].end_time - t) / self.step_animation[slot].step_length
                        local anim_progress = math.ease_sine(1 - progress)
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            local lerp_position = vector3_lerp(default_position, default_position + position_move, anim_progress)
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, lerp_position)
                            -- Set rotation
                            local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation, default_rotation + rotation_move, anim_progress))
                            unit_set_local_rotation(unit, 1, lerp_rotation)
                        end
                    end

                -- STEP end
                elseif self.step_animation[slot].state == STEP_STATE and t >= self.step_animation[slot].end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        self.step_animation[slot].state = STEP_STATE_BACK
                        self.step_animation[slot].end_time = t + self.step_animation[slot].back_length
                    else
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    end
                    for i, unit in pairs(units) do
                        -- Set move position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, default_position + position_move)
                            -- Set rotation
                            local lerp_rotation = quaternion_from_vector(default_rotation + rotation_move)
                            unit_set_local_rotation(unit, 1, lerp_rotation)
                            -- Play sound
                            self:play_equipment_sound(slot, i)
                        end
                    end

                -- STEP BACK
                elseif self.step_animation[slot].state == STEP_STATE_BACK and t < self.step_animation[slot].end_time then
                    if locomotion == 0 then
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    end
                    -- Lerp values
                    for i, unit in pairs(units) do
                        local progress = (self.step_animation[slot].end_time - t) / self.step_animation[slot].back_length
                        local anim_progress = math.ease_sine(1 - progress)
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            local lerp_position = vector3_lerp(default_position + position_move, default_position, anim_progress)
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, lerp_position)
                            -- Set rotation
                            local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress))
                            unit_set_local_rotation(unit, 1, lerp_rotation)
                        end
                    end

                -- STEP BACK end
                elseif self.step_animation[slot].state == STEP_STATE_BACK and t >= self.step_animation[slot].end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        self.step_animation[slot].state = STEP_STATE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].step_length
                    else
                        self.step_animation[slot].state = STEP_WOBBLE
                        self.step_animation[slot].end_time = t + self.step_animation[slot].wobble_length
                    end
                    for i, unit in pairs(units) do
                        -- Set move position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            local lerp_rotation = quaternion_from_vector(default_rotation)
                            unit_set_local_rotation(unit, 1, lerp_rotation)
                        end
                    end

                -- WOBBLE
                elseif self.step_animation[slot].state == STEP_WOBBLE and t < self.step_animation[slot].end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        if slot.name == SLOT_SECONDARY then
                            self.step_animation[slot].state = STEP_STATE
                            self.step_animation[slot].end_time = t + self.step_animation[slot].step_length * 1
                        else
                            self.step_animation[slot].state = STEP_STATE
                            self.step_animation[slot].end_time = t + self.step_animation[slot].step_length * 2
                        end
                    end
                    -- Lerp values
                    local progress = (self.step_animation[slot].end_time - t) / self.step_animation[slot].wobble_length
                    local anim_progress = math_ease_out_elastic(1 - progress)
                    for i, unit in pairs(units) do
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            local lerp_position = vector3_lerp(default_position + position_move, default_position, anim_progress)
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, lerp_position)
                            -- Set rotation
                            local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress))
                            unit_set_local_rotation(unit, 1, lerp_rotation)
                        end
                    end

                -- WOBBLE end
                elseif self.step_animation[slot].state == STEP_WOBBLE and t >= self.step_animation[slot].end_time then
                    -- -- End animation
                    self.step_animation[slot].state = nil
                    self.step_animation[slot].end_time = nil
                    for i, unit in pairs(units) do
                        -- Set default position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- mod:info("VisibleEquipmentExtension.update_animation: "..tostring(unit))
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            local rotation = quaternion_from_vector(default_rotation)
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                end
            end
            -- Rotation
            for i, unit in pairs(units) do
                -- Set default position and rotation
                if unit and unit_alive(unit) then
                    local rotation = unit_local_rotation(unit, 1)
                    local angle = rotation_diff[3] --+ position_diff[1]
                    -- reduce the angle  
                    angle = angle % 360; 
                    -- force it to be the positive remainder, so that 0 <= angle < 360  
                    angle = (angle + 360) % 360;  
                    -- force into the minimum absolute value residue class, so that -180 < angle <= 180  
                    if angle > 180 then angle = angle - 360 end
                    angle = angle * weight_factor
                    angle = angle * -1

                    local new_diff = vector3(math.abs(angle) * .5, angle, -angle)
                    if slot.name == SLOT_SECONDARY then
                        new_diff = vector3(angle, -angle, -math.abs(angle) * .5)
                    end
                    
                    local saved_current = self.rotate_animation[slot].current
                    local current_rotation = saved_current and vector3_unbox(saved_current)
                    local current = current_rotation or vector3_zero()
                    local mat = quaternion_matrix4x4(rotation)
                    local rotated_pos = matrix4x4_transform(mat, new_diff)

                    if not self:get_vectors_almost_same(rotated_pos, vector3_zero(), .1) then
                        current = current + rotated_pos
                    end

                    if slot.name == SLOT_SECONDARY then
                        current = current - current * (dt * 8)
                    else
                        current = current - current * (dt * 6)
                    end

                    for i = 1, 3 do
                        if slot.name == SLOT_SECONDARY then
                            current[i] = math.clamp(current[i], -15, 10)
                        else
                            current[i] = math.clamp(current[i], -10, 15)
                        end
                    end

                    local new_euler_rotation = quaternion_from_vector(current)
                    local new_rotation = Quaternion.multiply(rotation, new_euler_rotation)
                    unit_set_local_rotation(unit, 1, new_rotation)
                    self.rotate_animation[slot].current = vector3_box(current)
                end
            end
        end
    end
    -- Performance
    wc_perf_stop(perf)
end

return VisibleEquipmentExtension
