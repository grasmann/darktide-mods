local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local visual_loadout_customization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local player_character_sound_event_aliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
local weapon_templates = mod:original_require("scripts/utilities/weapon/weapon_template")

-- local ogryn = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/ogryn")
-- local human = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/breeds/human")
-- local autogun_p1_m1 = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/weapons/autogun_p1_m1")
local settings = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/settings")

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local VisibleEquipmentExtension = class("VisibleEquipmentExtension")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local CLASS = CLASS
    local pairs = pairs
    local world = World
    local table = table
    local rawget = rawget
    local vector3 = Vector3
    local tostring = tostring
    local math_abs = math.abs
    local matrix4x4 = Matrix4x4
    local unit_node = unit.node
    local math_lerp = math.lerp
    local math_clamp = math.clamp
    local unit_alive = unit.alive
    local table_size = table.size
    local quaternion = Quaternion
    local table_find = table.find
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local math_random = math.random
    local string_find = string.find
    local vector3_lerp = vector3.lerp
    local vector3_zero = vector3.zero
    local unit_get_data = unit.get_data
    local unit_has_node = unit.has_node
    local table_combine = table.combine
    local quaternion_box = QuaternionBox
    local math_ease_sine = math.ease_sine
    local table_contains = table.contains
    local world_link_unit = world.link_unit
    local quaternion_lerp = quaternion.lerp
    local vector3_unbox = vector3_box.unbox
    local world_unlink_unit = world.unlink_unit
    local world_destroy_unit = world.destroy_unit
    local quaternion_unbox = quaternion_box.unbox
    local quaternion_multiply = quaternion.multiply
    local unit_world_rotation = unit.world_rotation
    local matrix4x4_transform = matrix4x4.transform
    local unit_local_position = unit.local_position
    local unit_local_rotation = unit.local_rotation
    local quaternion_identity = quaternion.identity
    local quaternion_matrix4x4 = quaternion.matrix4x4
    local quaternion_to_vector = quaternion.to_vector
    local script_unit_extension = script_unit.extension
    local quaternion_from_vector = quaternion.from_vector
    local unit_set_local_position = unit.set_local_position
    local unit_set_local_rotation = unit.set_local_rotation
    local unit_set_unit_visibility = unit.set_unit_visibility
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOTS = {"slot_primary", "slot_secondary"}
local SLOT_ATTACHMENTS = {"left", "right"}
local SLOT_GEAR_EXTRA_COSMETIC = "slot_gear_extra_cosmetic"
local EMPTY_BACKPACK = "content/items/characters/player/human/backpacks/empty_backpack"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

VisibleEquipmentExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Set pt variable
    self.pt = mod:pt()
    -- Set variables
    self.equipment_component = extension_init_data.equipment_component
    self.profile = unit_get_data(unit, "visible_equipment_profile")
    self.unit = unit
    self.rotation = vector3_box(quaternion_to_vector(unit_local_rotation(unit, 1)))
    self.difference = 1
    self.right_foot_next = true
    -- Clear slot tables
    self:clear_slot_tables()
    -- Create equipment component tables
    self:reset_pt_tables()
    -- Initialized
    self.initialized = true
end

VisibleEquipmentExtension.extensions_ready = function(self)
    -- Get extensions
    self.visual_loadout_extension = script_unit_extension(self.unit, "visual_loadout_system")
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.locomotion_extension = script_unit_extension(self.unit, "locomotion_system")
    self.fx_extension = script_unit_extension(self.unit, "fx_system")
    -- Get unit data and components
    self.unit_data = script_unit_extension(self.unit, "unit_data_system")
    self.movement_state_component = self.unit_data and self.unit_data:read_component("movement_state")
    self.alternate_fire_component = self.unit_data and self.unit_data:read_component("alternate_fire")
    self.character_state_component = self.unit_data and self.unit_data:read_component("character_state")
    self.sprint_character_state_component = self.unit_data and self.unit_data:read_component("sprint_character_state")
end

VisibleEquipmentExtension.destroy = function(self)
    -- Initialized
    self.initialized = false
    -- Delete visible equipment
    self:delete_all()
    -- Clear equipment component tables
    self:unset_pt_tables()
end

VisibleEquipmentExtension.has_backpack = function(self)
    -- Get current profile value
    local profile = self.profile
    -- Get cosmetics view
    local inventory_cosmetics_view = mod:get_cosmetic_view()
    if inventory_cosmetics_view then
        -- Get presentation profile value
        profile = inventory_cosmetics_view and inventory_cosmetics_view._presentation_profile or profile
    end
    -- Get loadout from profile
    local slot_gear_extra_cosmetic = profile and profile.loadout[SLOT_GEAR_EXTRA_COSMETIC]
    -- Get backpack name
    local name = slot_gear_extra_cosmetic and slot_gear_extra_cosmetic.__master_item.name
    -- Return if name is not empty backpack
    return name and name ~= EMPTY_BACKPACK
end

VisibleEquipmentExtension.attach_settings = function(self, slot)
    local attach_settings = self.equipment_component:_attach_settings()
    self.equipment_component:_fill_attach_settings_3p(self.unit, attach_settings, slot)
    -- attach_settings.from_script_component = true
    attach_settings.skip_link_children = true
    return attach_settings
end

VisibleEquipmentExtension.add_object = function(self, slot, attachments, name)
    -- Get object by name
    local object = table_find(attachments, name)
    -- Check
    if object then
        -- Add object and name
        self.objects[slot][#self.objects[slot]+1] = object
        self.names[slot][#self.names[slot]+1] = name
    end
end

VisibleEquipmentExtension.spawn_slot = function(self, slot, optional_mission_template)
    -- Get into and settings
    local attach_settings = self:attach_settings(slot)
    -- Spawn visible equipment
    local weapon_skin_item = slot.item.slot_weapon_skin
    local skin_data = weapon_skin_item and weapon_skin_item ~= "" and rawget(attach_settings.item_definitions, weapon_skin_item)
    local skin_overrides = visual_loadout_customization.generate_attachment_overrides_lookup(slot.item, skin_data)
    local item_unit_3p = visual_loadout_customization.spawn_base_unit(slot.item, attach_settings, self.unit, optional_mission_template)
    local attachment_units_3p, unit_attachment_id_3p, unit_attachment_name_3p, _, item_name_by_unit_3p = visual_loadout_customization.spawn_item_attachments(slot.item, skin_overrides, attach_settings, item_unit_3p, true, false, true, optional_mission_template)
    -- Apply skins
    visual_loadout_customization.apply_material_overrides(slot.item, item_unit_3p, self.unit, attach_settings)
    if skin_data then
        visual_loadout_customization.apply_material_overrides(skin_data, item_unit_3p, self.unit, attach_settings)
    end
    -- Add extensions
    visual_loadout_customization.add_extensions(nil, attachment_units_3p and attachment_units_3p[item_unit_3p], attach_settings)
    -- Deform
    local deform_overrides = slot.deform_overrides
    if deform_overrides then
        for _, deform_override in pairs(deform_overrides) do
            visual_loadout_customization.apply_material_override(item_unit_3p, self.unit, false, deform_override, false)
        end
    end
    -- Return units
    return item_unit_3p, attachment_units_3p, unit_attachment_id_3p, unit_attachment_name_3p, item_name_by_unit_3p
end

VisibleEquipmentExtension.load_slot = function(self, slot, optional_mission_template)
    -- Check for valid slot
    if (not self.loaded[slot] and table_contains(SLOTS, slot.name)) then
        -- Spawn visible equipment
        local item_unit_3p, attachment_units_3p, unit_attachment_id_3p, unit_attachment_name_3p, item_name_by_unit_3p = self:spawn_slot(slot, optional_mission_template)
        -- Reset equipment component tables
        self:reset_slot_tables(slot)
        -- Save visible equipment to pt
        self:set_pt_tables(slot, item_unit_3p, attachment_units_3p, unit_attachment_id_3p, unit_attachment_name_3p, item_name_by_unit_3p)
        -- Get left and right objects
        for index, name in pairs(SLOT_ATTACHMENTS) do
            self:add_object(slot, unit_attachment_name_3p[item_unit_3p], name)
        end
        -- Item unit as sole object when no attachments
        if #self.objects == 0 then
            self.objects[slot][#self.objects[slot]+1] = item_unit_3p
            self.names[slot][#self.names[slot]+1] = "right"
            self.items[slot][#self.items[slot]+1] = slot.item
        end
        -- Setup animation tables
        self.anim[slot] = {
            current = {},
            interval = {},
            started = {},
            ending = {},
            state = {},
            strength_override = {},
            default_position = {},
            default_rotation = {},
            start_position = {},
            start_rotation = {},
            current_position = {},
            current_rotation = {},
            target_position = {},
            target_rotation = {},
            end_position = {},
            end_rotation = {},
        }
        -- Set loaded
        self.loaded[slot] = true
        -- Position objects
        self:position_objects(slot)
    end
end

VisibleEquipmentExtension.update_objects = function(self)
    -- Iterate through equipment
    for slot, units in pairs(self.objects) do
        -- Position objects
        self:position_objects(slot)
    end
end

VisibleEquipmentExtension.position_objects = function(self, slot)
    if self.loaded[slot] then
        -- Iterate through objects
        for index, obj in pairs(self.objects[slot]) do
            -- Get link node
            local node = 1
            if unit_has_node(self.unit, "j_spine2") then node = unit_node(self.unit, "j_spine2") end
            -- Get offset
            local name = self.names[slot][index]
            local backpack = self:has_backpack() and "backpack" or "default"
            local item_offset = settings.offsets[slot.item.weapon_template]
            local offset = item_offset and item_offset[backpack][name]
            local offset = offset or settings.offsets[slot.breed_name][slot.item.item_type][backpack][name] or settings.offsets[slot.breed_name][slot.item.item_type][backpack].right
            local position = offset and offset.position and vector3_unbox(offset.position) or vector3_zero()
            local rotation = offset and offset.rotation and quaternion_from_vector(vector3_unbox(offset.rotation)) or quaternion_identity()
            -- Link visible equipment
            world_unlink_unit(self.equipment_component._world, obj)
            world_link_unit(self.equipment_component._world, obj, 1, self.unit, node)
            -- Set offset
            unit_set_local_position(obj, 1, position)
            unit_set_local_rotation(obj, 1, rotation)
            -- Anim values
            self.anim[slot].default_position[obj] = vector3_box(position)
            self.anim[slot].default_rotation[obj] = vector3_box(quaternion_to_vector(rotation))
            self.anim[slot].start_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].start_rotation[obj] = vector3_box(vector3_zero())
            self.anim[slot].end_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].end_rotation[obj] = vector3_box(vector3_zero())
            self.anim[slot].current_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].current_rotation[obj] = vector3_box(vector3_zero())
        end
    end
end

VisibleEquipmentExtension.delete_all = function(self, target_slot)
    -- Delete attachment unit(s)
    local all_attachment_units = self.pt.attachment_units_by_equipment_component[self.equipment_component]
    if all_attachment_units then
        for slot_name, attachments in pairs(all_attachment_units) do
            if not target_slot or target_slot == slot_name then
                local item_unit = self.pt.item_units_by_equipment_component[self.equipment_component][slot_name]
                -- Delete attachments
                if attachments and item_unit then
                    -- Get weapon specific attachments
                    local attachment_units = attachments[item_unit]
                    -- Iterate through attachments
                    for i = #attachment_units, 1, -1 do
                        -- Get attachment unit
                        local attachment_unit = attachment_units[i]
                        if attachment_unit and unit_alive(attachment_unit) then
                            -- Unlink attachment unit
                            world_unlink_unit(self.equipment_component._world, attachment_unit)
                            -- Delete attachment unit
                            self.equipment_component._unit_spawner:mark_for_deletion(attachment_unit)
                        end
                    end
                    -- Unset attachment units
                    attachment_units = nil
                end
            end
        end
    end
    -- Delete item unit(s)
    local item_units = self.pt.item_units_by_equipment_component[self.equipment_component]
    if item_units then
        for slot_name, item_unit in pairs(item_units) do
            if not target_slot or target_slot == slot_name then
                -- Delete item unit
                if item_unit and unit_alive(item_unit) then
                    -- Unlink item unit
                    world_unlink_unit(self.equipment_component._world, item_unit)
                    -- Delete item unit
                    self.equipment_component._unit_spawner:mark_for_deletion(item_unit)
                    -- Unset item unit
                    item_unit = nil
                end
            end
        end
    end
    if not target_slot then
        -- Clear slot tables
        self:clear_slot_tables()
    end
end

VisibleEquipmentExtension.delete_slot = function(self, slot)
    -- Delete slot units
    self:delete_all(slot.name)
    -- Clear slot tables
    self:unset_slot_tables(slot)
end

VisibleEquipmentExtension.wield_slot = function(self, slot)
    -- Trigger animations and sounds
    self:animate_equipment(nil, 10)
    self:play_equipment_sound()
end

VisibleEquipmentExtension.update_item_visibility = function(self, equipment, wielded_slot)
    -- Set wielded slot
    self.wielded_slot = wielded_slot
    -- Iterate through equipment
    for slot_name, slot in pairs(equipment) do
        -- Check if slot should be processed
        if (table_contains(SLOTS, slot.name)) then
            -- Check slot
            if self.loaded[slot] then
                -- Hidden?
                local hide = (slot_name ~= wielded_slot and true) or false
                -- Iterate through objects
                for index, obj in pairs(self.objects[slot]) do
                    -- Set visibility
                    unit_set_unit_visibility(obj, hide, true)
                end
            end
        end
    end
end

VisibleEquipmentExtension.play_equipment_sound = function(self)
    -- Iterate through equipment
    for slot, units in pairs(self.objects) do
        -- -- Check slot objects
        if slot.name ~= self.wielded_slot then
            -- Get slot data
            local weapon_template = slot.item.weapon_template
            local breed_name = slot.breed_name
            local item_type = slot.item.item_type
            
            -- Get sounds
            local sounds =  settings.sounds[weapon_template] or settings.sounds[breed_name][item_type] or settings.sounds.default[item_type]
            local group = nil

            -- Get character state
            -- local unit_data = script_unit_extension(self.unit, "unit_data_system")
            if sounds then
                -- local character_state_name = unit_data:read_component("character_state").state_name
                local character_state_name = self.character_state_component and self.character_state_component.state_name or "walking"
                -- local is_crouching = unit_data:read_component("movement_state").is_crouching
                local is_crouching = self.movement_state_component and self.movement_state_component.is_crouching or false
                local accent, accent_timeout = false, 10

                if is_crouching then
                    accent = math_random(1, 20) == 1
                    accent_timeout = 10
                else
                    if character_state_name == "sprinting" then
                        accent = math_random(1, 5) == 1
                        accent_timeout = 10
                    else
                        accent = math_random(1, 10) == 1
                        accent_timeout = 5
                    end
                end

                accent = false

                if accent and sounds.accent and #sounds.accent > 0 and not self.accent[slot] then
                    self.accent[slot] = mod:game_time() + accent_timeout
                    group = sounds.accent[math_random(#sounds.accent)]
                elseif is_crouching and sounds.crouching and #sounds.crouching > 0 then
                    group = sounds.crouching[math_random(#sounds.crouching)]
                elseif sounds.default and #sounds.default > 0 then
                    group = sounds.default[math_random(#sounds.default)]
                end
            end

            group = group or "sfx_weapon_up"
            local sound = player_character_sound_event_aliases[group].events[weapon_template] or
                player_character_sound_event_aliases[group].events.default

            if sound and self.fx_extension then
                local husk = player_character_sound_event_aliases[group].has_husk_events
			    local move_speed = self.locomotion_extension and self.locomotion_extension:move_speed() or 1
                self.fx_extension:trigger_wwise_event(sound, husk, true, self.unit, 1, "foley_speed", move_speed)
            end
        end
    end
end

VisibleEquipmentExtension.footstep = function(self)
    self:play_equipment_sound()
    self:animate_equipment()
    self.right_foot_next = not self.right_foot_next
end

VisibleEquipmentExtension.footstep_interval = function(self, slot)
    -- self:extensions_ready()
    local weapon_template = weapon_templates.weapon_template_from_item(slot.item)
    local breed_footstep_intervals = weapon_template.breed_footstep_intervals
    local footstep_intervals = breed_footstep_intervals and breed_footstep_intervals[slot.breed_name] or weapon_template.footstep_intervals
    -- local unit_data = script_unit_extension(self.unit, "unit_data_system")
    local interval = .4
    if footstep_intervals then
        -- local character_state_name = unit_data:read_component("character_state").state_name
        local character_state_name = self.character_state_component and self.character_state_component.state_name or "walking"
        -- local is_crouching = unit_data:read_component("movement_state").is_crouching
        local is_crouching = self.movement_state_component and self.movement_state_component.is_crouching or false
        -- local alternate_fire_active = unit_data:read_component("alternate_fire").is_active
        local alternate_fire_active = self.alternate_fire_component and self.alternate_fire_component.is_active or false
        -- local sprint_character_state_component = unit_data:read_component("sprint_character_state")
        local sprint_sprint_overtime = self.sprint_character_state_component and self.sprint_character_state_component.sprint_overtime or 0

        if character_state_name == "sprinting" then
            interval = sprint_sprint_overtime > 0 and footstep_intervals.sprinting_overtime or footstep_intervals.sprinting
        elseif character_state_name == "walking" then
            if is_crouching then
                interval = alternate_fire_active and footstep_intervals.crouch_walking_alternate_fire or footstep_intervals.crouch_walking
            else
                interval = alternate_fire_active and footstep_intervals.walking_alternate_fire or footstep_intervals.walking
            end
        end

        interval = interval or footstep_intervals[character_state_name]
    end
    return interval
end

VisibleEquipmentExtension.update = function(self, dt, t)
    -- Rotation swing
    -- local first_person_extention = script_unit_extension(self.unit, "first_person_system")
	local first_person_unit = self.first_person_extension and self.first_person_extension:first_person_unit()
    local rotation_unit = (not mod:is_in_hub() and first_person_unit) or self.unit
    local rotation = quaternion_to_vector(unit_world_rotation(rotation_unit, 1))
    local difference = math_clamp((vector3_unbox(self.rotation) - rotation)[3], -10, 10)

    if math_abs(self.difference) < math_abs(difference) then
        self.difference = math_lerp(self.difference, difference, dt * 10)
    else
        self.difference = math_lerp(self.difference, difference, dt * 5)
    end
    
    self.rotation:store(rotation)

    for slot, units in pairs(self.objects) do
        if self.accent[slot] and self.accent[slot] < t then
            self.accent[slot] = nil
        end

        for index, obj in pairs(self.objects[slot]) do
            self.anim[slot].interval[obj] = self:footstep_interval(slot)
        end

        self:update_animation(dt, t, slot)
    end

end

VisibleEquipmentExtension.animate_equipment = function(self, animation, strength_override)
    local animation = animation or "default"
    for slot, units in pairs(self.objects) do
        -- if slot.name ~= self.wielded_slot then
            for index, obj in pairs(self.objects[slot]) do
                local name = self.names[slot][index]
                local step_animation = settings.footstep_animations[slot.item.weapon_template] or settings.footstep_animations[slot.breed_name][slot.item.item_type] or settings.footstep_animations
                self.anim[slot].current[obj] = step_animation[animation] and step_animation[animation][name] or step_animation[name]
                self.anim[slot].strength_override[obj] = strength_override
                self.anim[slot].started[obj] = nil
                self.anim[slot].ending[obj] = nil
            end
        -- end
    end
end

VisibleEquipmentExtension.update_animation = function(self, dt, t, slot)
    -- Iterate through objects
    for index, obj in pairs(self.objects[slot]) do
        -- Swing
        local angle = self.difference
        -- reduce the angle
        angle = angle % 360
        -- force it to be the positive remainder, so that 0 <= angle < 360
        angle = (angle + 360) % 360
        -- force into the minimum absolute value residue class, so that -180 < angle <= 180
        if angle > 180 then angle = angle - 360 end
        -- angle = angle * weight_factor
        angle = angle * -1
        -- Calculate momentum_drag 
        local momentum_drag = vector3_zero()
        if self.names[slot][index] == "left" then
            momentum_drag = vector3(angle, 0, math.abs(angle) * .5) * 3
        elseif slot.item.item_type == WEAPON_MELEE then
            -- momentum_drag = vector3(5, 10, 2.5) * self.difference
            momentum_drag = vector3(-angle, -angle, math.abs(angle) * .5) * 3
        elseif slot.item.item_type == WEAPON_RANGED then
            -- momentum_drag = vector3(5, -10, 2.5) * self.difference
            momentum_drag = vector3(angle, -angle, math.abs(angle) * .5) * 3
        end

        -- Iterate through equipment
        local right_foot_next = self.right_foot_next
        if self.first_person_extension and self.first_person_extension:is_in_first_person_mode() then
            right_foot_next = self.first_person_extension._right_foot_next
        end
        
        if self.anim[slot].current[obj] then
            if not self.anim[slot].started[obj] then

                local start_state = self.anim[slot].current[obj].start
                self.anim[slot].state[obj] = self.anim[slot].current[obj][start_state]
                -- self.anim[slot].started[obj] = nil

            elseif self.anim[slot].started[obj] then
                if self.anim[slot].ending[obj] < t then

                    local next_state = self.anim[slot].state[obj].next
                    self.anim[slot].state[obj] = self.anim[slot].current[obj][next_state]
                    self.anim[slot].started[obj] = nil
                    self.anim[slot].strength_override[obj] = nil
                    
                end
            end

            local interval = self.anim[slot].interval[obj] / 2
            -- if interval < .4 then interval = .4 end

            if self.anim[slot].state[obj] and not self.anim[slot].started[obj] then

                self.anim[slot].started[obj] = t
                self.anim[slot].ending[obj] = t + interval

                self.anim[slot].start_position[obj] = self.anim[slot].state[obj].start_position
                self.anim[slot].start_rotation[obj] = self.anim[slot].state[obj].start_rotation

                self.anim[slot].end_position[obj] = self.anim[slot].state[obj].end_position
                self.anim[slot].end_rotation[obj] = self.anim[slot].state[obj].end_rotation

            elseif not self.anim[slot].state[obj] then

                self.anim[slot].current[obj] = nil
                self.anim[slot].started[obj] = nil
                self.anim[slot].ending[obj] = nil

            end

            if self.anim[slot].started[obj] then

                local progress = (self.anim[slot].ending[obj] - t) / interval
                local anim_progress = math_ease_sine(1 - progress)

                local move_speed = self.locomotion_extension and self.locomotion_extension:move_speed() or 1

                local foot_multiplier = 1
                if move_speed == 0 then
                    move_speed = 1
                elseif slot.item.item_type == WEAPON_MELEE then
                    foot_multiplier = right_foot_next and 1 or .5
                elseif slot.item.item_type == WEAPON_RANGED then
                    foot_multiplier = right_foot_next and .5 or 1
                end

                local start_strength = move_speed * foot_multiplier
                local end_strength = move_speed * foot_multiplier
                if self.anim[slot].strength_override[obj] then
                    if self.anim[slot].state[obj].name == "step" then
                        end_strength = self.anim[slot].strength_override[obj]
                    elseif self.anim[slot].state[obj].name == "back" then
                        start_strength = self.anim[slot].strength_override[obj]
                    end
                end

                local start_position = vector3_unbox(self.anim[slot].start_position[obj]) * start_strength
                local start_rotation = vector3_unbox(self.anim[slot].start_rotation[obj]) * start_strength
                local end_position = vector3_unbox(self.anim[slot].end_position[obj]) * end_strength
                local end_rotation = vector3_unbox(self.anim[slot].end_rotation[obj]) * end_strength

                local target_position = vector3_lerp(start_position, end_position, anim_progress)
                local target_rotation = vector3_lerp(start_rotation, end_rotation, anim_progress)

                local current_position = vector3_lerp(vector3_unbox(self.anim[slot].current_position[obj]), target_position, dt * (5 * move_speed))
                local current_rotation = vector3_lerp(vector3_unbox(self.anim[slot].current_rotation[obj]), target_rotation, dt * (5 * move_speed))
                
                self.anim[slot].current_position[obj]:store(current_position)
                self.anim[slot].current_rotation[obj]:store(current_rotation)

                local position = vector3_unbox(self.anim[slot].default_position[obj]) + current_position
                local rotation = vector3_unbox(self.anim[slot].default_rotation[obj]) + current_rotation
                

                unit_set_local_position(obj, 1, position)
                -- rotation = quaternion_multiply(quaternion_from_vector(rotation), quaternion_from_vector(momentum_drag))
                unit_set_local_rotation(obj, 1, rotation)

                -- return

            end
        end

        -- local current_position = vector3_unbox(self.anim[slot].current_position[obj])
        local current_rotation = vector3_unbox(self.anim[slot].current_rotation[obj])

        -- local position = vector3_unbox(self.anim[slot].default_position[obj]) + unit_local_position(self.unit, 1)
        local rotation = vector3_unbox(self.anim[slot].default_rotation[obj]) + current_rotation

        -- unit_set_local_position(obj, 1, position)
        rotation = quaternion_multiply(quaternion_from_vector(rotation), quaternion_from_vector(momentum_drag))
        unit_set_local_rotation(obj, 1, rotation)

    end

end

-- ##### ┌─┐┬  ┌─┐┌┬┐  ┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐ #############################################################################
-- ##### └─┐│  │ │ │    │ ├─┤├┴┐│  ├┤ └─┐ #############################################################################
-- ##### └─┘┴─┘└─┘ ┴    ┴ ┴ ┴└─┘┴─┘└─┘└─┘ #############################################################################

VisibleEquipmentExtension.reset_slot_tables = function(self, slot)
    self.objects[slot] = {}
    self.accent[slot] = nil
    self.items[slot] = {}
    self.names[slot] = {}
    self.anim[slot] = {}
    self.loaded[slot] = false
end

VisibleEquipmentExtension.unset_slot_tables = function(self, slot)
    self.objects[slot] = nil
    self.accent[slot] = nil
    self.items[slot] = nil
    self.names[slot] = nil
    self.anim[slot] = nil
    self.loaded[slot] = nil
end

VisibleEquipmentExtension.clear_slot_tables = function(self)
    self.objects = {}
    self.accent = {}
    self.items = {}
    self.names = {}
    self.anim = {}
    self.loaded = {}
end

-- ##### ┌─┐┌┬┐  ┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐ ###################################################################################
-- ##### ├─┘ │    │ ├─┤├┴┐│  ├┤ └─┐ ###################################################################################
-- ##### ┴   ┴    ┴ ┴ ┴└─┘┴─┘└─┘└─┘ ###################################################################################

VisibleEquipmentExtension.reset_pt_tables = function(self)
    self.pt.item_units_by_equipment_component[self.equipment_component] = {}
    self.pt.attachment_units_by_equipment_component[self.equipment_component] = {}
    self.pt.unit_attachment_ids_by_equipment_component[self.equipment_component] = {}
    self.pt.unit_attachment_names_by_equipment_component[self.equipment_component] = {}
    self.pt.item_names_by_equipment_component[self.equipment_component] = {}
end

VisibleEquipmentExtension.unset_pt_tables = function(self)
    self.pt.item_units_by_equipment_component[self.equipment_component] = nil
    self.pt.attachment_units_by_equipment_component[self.equipment_component] = nil
    self.pt.unit_attachment_ids_by_equipment_component[self.equipment_component] = nil
    self.pt.unit_attachment_names_by_equipment_component[self.equipment_component] = nil
    self.pt.item_names_by_equipment_component[self.equipment_component] = nil
end

VisibleEquipmentExtension.set_pt_tables = function(self, slot, item_unit, attachment_units, attachment_ids, attachment_names, item_name)
    self.pt.item_units_by_equipment_component[self.equipment_component][slot.name] = item_unit
    self.pt.attachment_units_by_equipment_component[self.equipment_component][slot.name] = attachment_units
    self.pt.unit_attachment_ids_by_equipment_component[self.equipment_component][slot.name] = attachment_ids
    self.pt.unit_attachment_names_by_equipment_component[self.equipment_component][slot.name] = attachment_names
    self.pt.item_names_by_equipment_component[self.equipment_component][slot.name] = item_name
end
