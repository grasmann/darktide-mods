local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
local InputService = mod:original_require("scripts/managers/input/input_service")

local VisibleEquipmentOffsets = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/visible_equipment/offsets")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local unit_alive = Unit.alive
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local unit_local_position = Unit.local_position
    local unit_local_rotation = Unit.local_rotation
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_scale = Unit.set_local_scale
    local unit_has_node = Unit.has_node
    local unit_node = Unit.node
    local unit_flow_event = Unit.flow_event
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_get_child_units = Unit.get_child_units
    local vector3 = Vector3
    local vector3_lerp = vector3.lerp
    local vector3 = vector3
    local vector3_box = Vector3Box
    local vector3_unbox = vector3_box.unbox
    local vector3_one = vector3.one
    local vector3_zero = vector3.zero
    local Matrix4x4 = Matrix4x4
    local matrix4x4_transform = Matrix4x4.transform
    local Quaternion = Quaternion
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local quaternion_to_euler_angles_xyz = Quaternion.to_euler_angles_xyz
    local QuaternionBox = QuaternionBox
    local quaternion_box = QuaternionBox
    local quaternion_unbox = QuaternionBox.unbox
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_to_vector = function(quaternion)
        local x, y, z = quaternion_to_euler_angles_xyz(quaternion)
        return vector3(x, y, z)
    end
    local math = math
    local math_ease_out_elastic = math.ease_out_elastic
    local math_easeInCubic = math.easeInCubic
	local math_easeOutCubic = math.easeOutCubic
    local math_random = math.random
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
local REFERENCE = "weapon_customization"
local WEAPON_MELEE = "WEAPON_MELEE"
local ANIM_TIME_MELEE = .3
local ANIM_TIME_WOBBLE_MELEE = .3
local WEAPON_RANGED = "WEAPON_RANGED"
local ANIM_TIME_RANGED = .3
local ANIM_TIME_WOBBLE_RANGED = .5
local SLOT_UNARMED = "slot_unarmed"
local SLAB_SHIELD = "ogryn_powermaul_slabshield_p1_m1"
local BACKPACK_ATTACH = "j_backpackattach"
local BACKPACK_OFFSET = "j_backpackoffset"
local BACKPACK_EMPTY = "content/items/characters/player/human/backpacks/empty_backpack"
local STEP_STATE = "step"
local STEP_WOBBLE = "wobble"

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local VisibleEquipmentExtension = class("VisibleEquipmentExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

VisibleEquipmentExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.world = extension_init_context.world
    self.is_local_unit = extension_init_data.is_local_unit
    self.loading_spawn_point = extension_init_data.loading_spawn_point
    self.equipment_component = extension_init_data.equipment_component
    self.equipment = extension_init_data.equipment
    self.wielded_slot = extension_init_data.wielded_slot
    self.player_unit = extension_init_data.player_unit
    self.profile = extension_init_data.profile
    self.ui_profile_spawner = extension_init_data.ui_profile_spawner
    self.back_node = self:get_back_node()
    self.trigger_wobble = nil
    self.back_change = nil
    self.first_person_extension = script_unit.extension(self.player_unit, "first_person_system")
    self.locomotion_ext = script_unit.extension(self.player_unit, "locomotion_system")
    self.fx_extension = script_unit.extension(self.player_unit, "fx_system")
    self.extension_manager = managers.state.extension
    self.unit_spawner = self.equipment_component._unit_spawner
    self.step_speed = 1
    -- Slot specific
    self.slot_loaded = {}
    self.item_names = {}
    self.item_types = {}
    self.dummy_units = {}
    self.equipment_data = {}
    self.slot_infos = {}
    self.packages = {}
    self.step_animation = {}
    self.sounds = {}
    -- Initialized
    self.initialized = true
end

VisibleEquipmentExtension.delete = function(self)
    -- Iterate slots
    for slot_name, slot in pairs(self.equipment) do
        -- Delete
        self:delete_slot(slot)
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

VisibleEquipmentExtension.has_backpack = function(self)
    -- Get cosmetic extra slot gear
    local gear_extra = self.equipment["slot_gear_extra_cosmetic"]
	local real_item = gear_extra and gear_extra.item and gear_extra.item.name
    -- mod:echo(tostring(real_item))
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
    -- Trigger wobble
    if item and self.back_change ~= item then
        self.trigger_wobble = true
        self.back_change = item
    end
    -- Check if not empty backpack
	return item and item ~= BACKPACK_EMPTY
end

VisibleEquipmentExtension.get_equipment_data = function(self, slot)
    -- Check if has backpack
    local data_type = self:has_backpack() and "backpack" or "default"
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
    -- Compile equipment data
    local equipment_data = {
        position = {item_equipment_data.position, item_equipment_data.position2},
        rotation = {item_equipment_data.rotation, item_equipment_data.rotation2},
        scale = {item_equipment_data.scale, item_equipment_data.scale2},
        step_move = {item_equipment_data.step_move, item_equipment_data.step_move2},
        step_rotation = {item_equipment_data.step_rotation, item_equipment_data.step_rotation2},
        init = item_data and item_data.init,
        wield = item_data and item_data.wield,
    }
    return equipment_data, sounds, sounds2
end

VisibleEquipmentExtension.get_back_node = function(self)
    if self.player_unit and unit_alive(self.player_unit) then
        if unit_has_node(self.player_unit, BACKPACK_ATTACH) then
            return BACKPACK_ATTACH
        elseif unit_has_node(self.player_unit, BACKPACK_OFFSET) then
            return BACKPACK_OFFSET
        else
            return 1
        end
    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

mod.hide_bullets = function(self, attachment_units)
    if attachment_units and #attachment_units > 0 then
        local hide_units = {"bullet_01", "bullet_02", "bullet_03", "bullet_04", "bullet_05",
            "casing_01", "casing_02", "casing_03", "casing_04", "casing_05"}
        -- Iterate attachments
        for _, unit in pairs(attachment_units) do
            -- Check hide unit
            if table.contains(hide_units, Unit.get_data(unit, "attachment_slot")) then
                -- Hide
                unit_set_unit_visibility(unit, false, false)
                unit_set_local_scale(unit, 1, vector3(0, 0, 0))
            end
        end
    end
end

VisibleEquipmentExtension.hide_bullets = function(self, slot)
    mod:hide_bullets(self.dummy_units[slot].attachments)
    -- local hide_units = {"bullet_01", "bullet_02", "bullet_03", "bullet_04", "bullet_05",
    --     "casing_01", "casing_02", "casing_03", "casing_04", "casing_05"}
    -- -- Iterate attachments
    -- for _, unit in pairs(self.dummy_units[slot].attachments) do
    --     -- Check hide unit
    --     if table.contains(hide_units, Unit.get_data(unit, "attachment_slot")) then
    --         -- Hide
    --         unit_set_unit_visibility(unit, false, false)
    --         unit_set_local_scale(unit, 1, vector3(0, 0, 0))
    --     end
    -- end
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

VisibleEquipmentExtension.position_equipment = function(self)
    -- Attach to node
    local node_index, attach_unit = unit_node(self.player_unit, self.back_node), self.player_unit
    -- local backpack_unit = self:has_backpack() and self.equipment["slot_gear_extra_cosmetic"]
    --     and self.equipment["slot_gear_extra_cosmetic"].unit_3p
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        -- Check dummies
        if self.dummy_units[slot] then
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
                    -- Link unit to attachment node
                    world_unlink_unit(self.world, unit)
                    world_link_unit(self.world, unit, 1, attach_unit, node_index, true)
                    -- Position equipment
                    unit_set_local_position(unit, 1, vector3_unbox(data.position[i]))
                    -- Rotate equipment
                    local rot = vector3_unbox(data.rotation[i])
                    local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                    unit_set_local_rotation(unit, 1, rotation)
                    -- Scale equipment
                    unit_set_local_scale(unit, 1, vector3_unbox(data.scale[i]))
                    -- if backpack_unit and unit_alive(backpack_unit) then
                    --     world_unlink_unit(self.world, unit)
                    --     world_link_unit(self.world, unit, 1, backpack_unit, 4, false)
                    -- end
                end
            end
        end
    end
end

VisibleEquipmentExtension.release_slot_packages = function(self, slot)
	for sound, package_id in pairs(self.packages[slot]) do
        -- Set unused
		mod:persistent_table(REFERENCE).used_packages.visible_equipment[sound] = nil
        -- Unload package
		managers.package:release(package_id)
        -- Remove package id
        mod:persistent_table(REFERENCE).loaded_packages.visible_equipment[sound] = nil
        self.packages[slot][sound] = nil
	end
end

VisibleEquipmentExtension.load_slot_packages = function(self, slot, packages)
    for _, sound in pairs(packages) do
        -- Check if loaded
        if not mod:persistent_table(REFERENCE).loaded_packages.visible_equipment[sound] then
            -- Prevent unload
            mod:persistent_table(REFERENCE).used_packages.visible_equipment[sound] = true
            -- Load package
            mod:persistent_table(REFERENCE).loaded_packages.visible_equipment[sound] = managers.package:load(sound, REFERENCE)
            -- Set package id
            self.packages[slot][sound] = mod:persistent_table(REFERENCE).loaded_packages.visible_equipment[sound]
        end
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

VisibleEquipmentExtension.on_equip_slot = function(self, slot)
    -- Check item
	local item = slot.item and slot.item.__master_item
	if not self.slot_loaded[slot] and item and (item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED)
            and (slot.item_loaded or slot.attachment_spawn_status == ATTACHMENT_SPAWN_STATUS.fully_spawned) then
        -- Item name
        self.item_names[slot] = mod:item_name_from_content_string(item.name)
        -- Item type
        self.item_types[slot] = item.item_type
        -- Animation
        self.step_animation[slot] = {}
        self.step_animation[slot].time = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_MELEE or ANIM_TIME_RANGED
        self.step_animation[slot].time_wobble = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_WOBBLE_MELEE or ANIM_TIME_WOBBLE_RANGED
        -- Attach settings
        local attach_settings = self.equipment_component:_attach_settings()
        self.equipment_component:_fill_attach_settings_3p(attach_settings, slot)
		attach_settings.skip_link_children = true
        -- Spawn dummy weapon
        self.dummy_units[slot] = {}
		self.dummy_units[slot].base, self.dummy_units[slot].attachments = VisualLoadoutCustomization.spawn_item(slot.item, attach_settings, self.player_unit)
        VisualLoadoutCustomization.add_extensions(nil, self.dummy_units[slot].attachments, attach_settings)
        -- Hide bullets
        self:hide_bullets(slot)
        -- Equipment data
        local data, sounds_1, sounds_2 = self:get_equipment_data(slot)
        local sounds_3 = SoundEventAliases.sfx_ads_up.events[self.item_names[slot]]
            or SoundEventAliases.sfx_ads_down.events[self.item_names[slot]]
            or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
            or SoundEventAliases.sfx_equip.events.default
        self.equipment_data[slot] = data
        -- Load sound packages
        self.packages[slot] = {}
        self:load_slot_packages(slot, table.icombine(
            sounds_1 or {},
            sounds_2 or {},
            {sounds_3}
        ))
        -- Sounds
        self.sounds[slot] = {
            sounds_1,
            sounds_2,
            sounds_3,
        }
        -- Init function
        if self.equipment_data[slot].init then
            self.equipment_data[slot].init(self, slot)
        end
        -- Trigger equipment animation
        self.trigger_wobble = true
        self.slot_loaded[slot] = true
    end
    -- Position equipment
    self:position_equipment()
    -- Visibility
    self:on_update_item_visibility()
end

VisibleEquipmentExtension.delete_slot = function(self, slot)
    -- Check base unit
    if self.dummy_units[slot] and self.dummy_units[slot].base then
        -- Check attachment units
        if self.dummy_units[slot].attachments then
            -- Iterate attachments
            for _, unit in pairs(self.dummy_units[slot].attachments) do
                -- Check unit
                if unit and unit_alive(unit) then
                    -- Unlink unit
                    world_unlink_unit(self.world, unit)
                    -- Delete unit
                    world_destroy_unit(self.world, unit)
                end
            end
        end
        if self.dummy_units[slot].base and unit_alive(self.dummy_units[slot].base) then
            -- Unlink unit
            world_unlink_unit(self.world, self.dummy_units[slot].base)
            -- Delete unit
            world_destroy_unit(self.world, self.dummy_units[slot].base)
        end
    end
    -- Delete references
    self.dummy_units[slot] = nil
    self.item_names[slot] = nil
    self.item_types[slot] = nil
    self.equipment_data[slot] = nil
    self.packages[slot] = nil
    self.slot_loaded[slot] = nil
    self.step_animation[slot] = nil
    self.sounds[slot] = nil
end

VisibleEquipmentExtension.on_unequip_slot = function(self, slot)
    -- Delete
    self:delete_slot(slot)
end

VisibleEquipmentExtension.on_wield_slot = function(self, slot)
    -- Set new wielded slot
    self.wielded_slot = slot
    -- Execute optional wield function
    if self.equipment_data[slot] and self.equipment_data[slot].wield then
        self.equipment_data[slot].wield(self, self.wielded_slot)
    end
end

VisibleEquipmentExtension.on_unwield_slot = function(self, slot)
    -- Execute optional unwield function
    if self.equipment_data[slot] and self.equipment_data[slot].unwield then
        self.equipment_data[slot].unwield(self, self.wielded_slot)
    end
end

VisibleEquipmentExtension.on_update_item_visibility = function(self, wielded_slot)
    -- Update wielded slot
    if wielded_slot then
        self:on_unwield_slot(self.wielded_slot)
        self.wielded_slot = self.equipment[wielded_slot]
        self:on_wield_slot(self.wielded_slot)
    end
    -- Iterate slots
    for slot_name, slot in pairs(self.equipment) do
        -- Check units
        if self.dummy_units[slot] then
            -- Get units
            local units = {self.dummy_units[slot].base}
            if self.item_names[slot] == SLAB_SHIELD then
                units = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
            end
            -- Iterate units
            for i, unit in pairs(units) do
                -- Check unit
                if unit and unit_alive(unit) then
                    -- Get visibility
                    local wielded_slot = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
                    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
                    local visible = slot_name ~= wielded_slot and (not self.is_local_unit or not first_person)
                    -- Set equipment visibility
                    unit_set_unit_visibility(unit, visible, true)
                end
            end
        end
    end
end

VisibleEquipmentExtension.load_slots = function(self)
    if self.initialized then
        -- Iterate slots
        for slot_name, slot in pairs(self.equipment) do
            -- Equip
            self:on_equip_slot(slot)
        end
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

VisibleEquipmentExtension.update = function(self, dt, t)
    if self.initialized then
        -- Equipment data
        self:update_equipment_data()
        -- Position
        self:position_equipment()
        -- Animation
        self:update_animation(dt, t)
    end
end

VisibleEquipmentExtension.update_equipment_data = function(self)
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        -- Check slot
        if self.slot_loaded[slot] then
            -- Update data
            self.equipment_data[slot] = self:get_equipment_data(slot)
        end
    end
end

-- VisibleEquipmentExtension.set_speed = function(self, speed)
--     self.step_speed = speed
-- end

VisibleEquipmentExtension.update_animation = function(self, dt, t)
    local locomotion = (self.locomotion_ext and self.locomotion_ext:move_speed() or 0)
    self.step_speed = math.max(locomotion, 1) * .2
    -- mod:echot("speed: "..tostring(self.step_speed))
    -- Check trigger
    if self.trigger_wobble then
        for slot_name, slot in pairs(self.equipment) do
            if self.slot_loaded[slot] and self.step_animation[slot] then
                if self.step_animation[slot].state ~= STEP_STATE then
                    self.step_animation[slot].end_time = t + (self.step_animation[slot].time / self.step_speed)
                    self.step_animation[slot].state = STEP_STATE
                end
            end
        end
        self.trigger_wobble = nil
    end

    -- Process animation part step
    for slot_name, slot in pairs(self.equipment) do
        -- Check slot
        if self.slot_loaded[slot] then
            -- Get data
            local data = self.equipment_data[slot]
            -- Animation
            if self.step_animation[slot] then
                -- Get units
                local units = {self.dummy_units[slot].base}
                if self.item_names[slot] == SLAB_SHIELD then
                    units = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
                end
                
                self.step_animation[slot].speed = self.step_speed

                -- Start step animation
                if not self.step_animation[slot].state and self.step_animation[slot].end_time then
                    self.step_animation[slot].state = STEP_STATE
                    -- Play sound
                    for i, unit in pairs(units) do
                        -- Set default position
                        if unit and unit_alive(unit) then
                            -- Set position
                            unit_set_local_position(unit, 1, vector3_unbox(data.position[i]))
                            -- Set rotation
                            local rot = vector3_unbox(data.rotation[i])
                            local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                    
                elseif self.step_animation[slot].state == STEP_STATE and t < self.step_animation[slot].end_time then
                    -- Lerp values
                    for i, unit in pairs(units) do
                        local progress = (self.step_animation[slot].end_time - t) / (self.step_animation[slot].time / self.step_animation[slot].speed)
                        local anim_progress = math.clamp(math.ease_sine(1 - progress), 0, 2)
                        if unit and unit_alive(unit) then
                            -- Set position
                            local default_position = vector3_unbox(data.position[i])
                            local position_move = vector3_unbox(data.step_move[1]) * math.max(self.step_animation[slot].speed, 1)
                            local lerp_position = vector3_lerp(default_position, default_position + position_move, anim_progress)
                            unit_set_local_position(unit, 1, lerp_position)
                            -- Set rotation
                            local default_rotation = vector3_unbox(data.rotation[i])
                            local rotation_move = vector3_unbox(data.step_rotation[1]) * math.max(self.step_animation[slot].speed, 1)
                            local lerp_rotation = vector3_lerp(default_rotation, default_rotation + rotation_move, anim_progress)
                            local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                    -- Check end of part step
                elseif self.step_animation[slot].state == STEP_STATE and t >= self.step_animation[slot].end_time then
                    -- Start part wobble
                    -- mod:echot("self.step_speed: "..tostring(self.step_speed))
                    self.step_animation[slot].state = STEP_WOBBLE
                    self.step_animation[slot].end_time = t + (self.step_animation[slot].time_wobble / self.step_animation[slot].speed)
                    for i, unit in pairs(units) do
                        -- Set move position and rotation
                        if unit and unit_alive(unit) then
                            -- Set position
                            local default_position = vector3_unbox(data.position[i])
                            local position_move = vector3_unbox(data.step_move[1]) * math.max(self.step_animation[slot].speed, 1)
                            unit_set_local_position(unit, 1, default_position + position_move)
                            -- Set rotation
                            local default_rotation = vector3_unbox(data.rotation[i])
                            local rotation_move = vector3_unbox(data.step_rotation[1]) * math.max(self.step_animation[slot].speed, 1)
                            local lerp_rotation = default_rotation + rotation_move
                            local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                    -- Play sound
                    local sound = nil
                    local wielded_slot = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
                    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
                    local play_sound = (not self.is_local_unit and mod:get("mod_option_visible_equipment_sounds") ~= "off")
                        or (self.is_local_unit and (not first_person or mod:get("mod_option_visible_equipment_own_sounds_fp"))
                        and mod:get("mod_option_visible_equipment_sounds") == "all")
                    if play_sound and slot_name ~= wielded_slot then
                        local sounds = i == 1 and self.sounds[slot][1] or self.sounds[slot][2]
                        local rnd = sounds and math_random(1, #sounds)
                        sound = sounds and sounds[rnd] or self.sounds[slot][3]
                        if sound and self.fx_extension then
                            self.fx_extension:trigger_wwise_event(sound, true, true, self.player_unit, 1, "foley_speed", self.step_animation[slot].speed)
                        end
                    end

                elseif self.step_animation[slot].state == STEP_WOBBLE and t < self.step_animation[slot].end_time then
                    -- Lerp values
                    local progress = (self.step_animation[slot].end_time - t) / (self.step_animation[slot].time_wobble / self.step_animation[slot].speed)
                    -- local anim_progress = progress
                    -- if self.step_speed <= 1 then
                    --     anim_progress = math.clamp(math_ease_out_elastic(1 - progress), 0, 2)
                    -- else
                    --     anim_progress = math.clamp(math.ease_sine(1 - progress), 0, 2)
                    -- end
                    local anim_progress = math.clamp(math_ease_out_elastic(1 - progress), 0, 2)
                    for i, unit in pairs(units) do
                        if unit and unit_alive(unit) then
                            -- Set position
                            local default_position = vector3_unbox(data.position[i])
                            local position_move = vector3_unbox(data.step_move[1]) * math.max(self.step_animation[slot].speed, 1)
                            local lerp_position = vector3_lerp(default_position + position_move, default_position, anim_progress)
                            unit_set_local_position(unit, 1, lerp_position)
                            -- Set rotation
                            local default_rotation = vector3_unbox(data.rotation[i])
                            local rotation_move = vector3_unbox(data.step_rotation[1]) * math.max(self.step_animation[slot].speed, 1)
                            local lerp_rotation = vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress)
                            local rotation = quaternion_from_euler_angles_xyz(lerp_rotation[1], lerp_rotation[2], lerp_rotation[3])
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                    if progress > .5 and self.step_speed > 1 then
                        self.step_animation[slot].state = STEP_STATE
                        -- self.step_animation[slot].end_time = t + (self.step_animation[slot].time / self.step_animation[slot].speed)
                    end
                    -- Check part end
                elseif self.step_animation[slot].state == STEP_WOBBLE and t >= self.step_animation[slot].end_time then
                    -- if self.step_speed <= 1 then
                    --     self.step_animation[slot].state = nil
                    --     self.step_animation[slot].end_time = nil
                    -- else
                    --     self.step_animation[slot].state = STEP_STATE
                    --     self.step_animation[slot].end_time = t + (self.step_animation[slot].time / self.step_animation[slot].speed)
                    -- end
                    -- -- End animation
                    self.step_animation[slot].state = nil
                    self.step_animation[slot].end_time = nil
                    for i, unit in pairs(units) do
                        -- Set default position and rotation
                        if unit and unit_alive(unit) then
                            -- Set position
                            local default_position = vector3_unbox(data.position[i])
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            local default_rotation = vector3_unbox(data.rotation[i])
                            -- local rot = dd[slot].rotation[i]
                            local rotation = quaternion_from_euler_angles_xyz(default_rotation[1], default_rotation[2], default_rotation[3])
                            unit_set_local_rotation(unit, 1, rotation)
                        end
                    end
                end
            end
        end
    end
end

return VisibleEquipmentExtension
