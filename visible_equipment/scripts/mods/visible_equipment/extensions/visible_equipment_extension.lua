local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local visual_loadout_customization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local player_character_sound_event_aliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")
local weapon_templates = mod:original_require("scripts/utilities/weapon/weapon_template")

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
    local managers = Managers
    local math_abs = math.abs
    local matrix4x4 = Matrix4x4
    local unit_node = unit.node
    local math_lerp = math.lerp
    local table_keys = table.keys
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
    local unit_get_child_units = unit.get_child_units
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
local EMPTY_BACKPACK_DEV = "empty_backpack"
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
    self.from_ui_profile_spawner = extension_init_data.from_ui_profile_spawner
    self.profile = unit_get_data(unit, "visible_equipment_profile")
    self.unit = unit
    self.is_local_unit = self.unit == mod:me() and not self.from_ui_profile_spawner
    self.rotation = vector3_box(quaternion_to_vector(unit_local_rotation(unit, 1)))
    self.difference = 1
    self.right_foot_next = true
    self.settings = mod.settings
    -- Clear slot tables
    self:clear_slot_tables()
    -- Create equipment component tables
    self:reset_pt_tables()
    -- Initialized
    self.initialized = true
    -- Events
    managers.event:register(self, "visible_equipment_settings_changed", "on_settings_changed")
    self:on_settings_changed()
end

VisibleEquipmentExtension.extensions_ready = function(self)
    -- Get extensions
    self.player_visibility = script_unit_extension(self.unit, "player_visibility_system")
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

VisibleEquipmentExtension.on_settings_changed = function(self)
    self.sound_self = mod:get("mod_option_sounds_self")
    self.sound_others = mod:get("mod_option_sounds_others")
    self.animations = mod:get("mod_option_animations")
    self.random_placements = mod:get("mod_option_random_placements")
end

VisibleEquipmentExtension.destroy = function(self)
    -- Events
    managers.event:unregister(self, "visible_equipment_settings_changed")
    -- Initialized
    self.initialized = false
    -- Delete visible equipment
    self:delete_all()
    -- Clear equipment component tables
    self:unset_pt_tables()
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

VisibleEquipmentExtension.add_object = function(self, slot, attachments, name)
    -- Get object by name
    local object = table_find(attachments, name)
    -- Check
    if object then
        -- Add object
        self.objects[slot][#self.objects[slot]+1] = object
        -- Add name
        self.names[slot][#self.names[slot]+1] = name
        self.items[slot][#self.items[slot]+1] = slot.item
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
            previous = {},
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
        -- Sheathed
        self.sheathed[slot] = true
        -- Iterate through objects
        for index, obj in pairs(self.objects[slot]) do
            -- Anim values
            self.anim[slot].default_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].default_rotation[obj] = vector3_box(vector3_zero())
            self.anim[slot].start_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].start_rotation[obj] = vector3_box(vector3_zero())
            self.anim[slot].end_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].end_rotation[obj] = vector3_box(vector3_zero())
            self.anim[slot].current_position[obj] = vector3_box(vector3_zero())
            self.anim[slot].current_rotation[obj] = vector3_box(vector3_zero())
        end
        -- Set loaded
        self.loaded[slot] = true
        -- Position slot objects
        self:position_slot_objects(slot)
    end
end

VisibleEquipmentExtension.delete_all = function(self, target_slot)
    -- Get equipment component infos
    local equipment_component = self.equipment_component
    local unit_spawner = equipment_component._unit_spawner
    local all_attachment_units = self.pt.attachment_units_by_equipment_component[equipment_component]
    local all_item_units = self.pt.item_units_by_equipment_component[equipment_component]
    local world = equipment_component._world
    -- Delete attachment unit(s)
    if all_attachment_units then
        for slot_name, attachments in pairs(all_attachment_units) do
            if not target_slot or target_slot == slot_name then
                local item_unit = all_item_units[slot_name]
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
                            world_unlink_unit(world, attachment_unit)
                            -- Delete attachment unit
                            unit_spawner:mark_for_deletion(attachment_unit)
                        end
                    end
                    -- Unset attachment units
                    attachment_units = nil
                end
            end
        end
    end
    -- Delete item unit(s)
    if all_item_units then
        for slot_name, item_unit in pairs(all_item_units) do
            if not target_slot or target_slot == slot_name then
                -- Delete item unit
                if item_unit and unit_alive(item_unit) then
                    -- Unlink item unit
                    world_unlink_unit(world, item_unit)
                    -- Delete item unit
                    unit_spawner:mark_for_deletion(item_unit)
                    -- Unset item unit
                    item_unit = nil
                end
            end
        end
    end
    -- Check if a specific slot was deleted
    -- If not, clear slot tables
    if not target_slot then
        -- Clear slot tables
        self:clear_slot_tables()
    end
end

VisibleEquipmentExtension.delete_slot = function(self, slot)
    if self.loaded[slot] then
        -- Delete slot units
        self:delete_all(slot.name)
        -- Clear slot tables
        self:unset_slot_tables(slot)
    end
end

VisibleEquipmentExtension.unwield_slot = function(self, slot)
    if self.loaded[slot] and not self.sheathed[slot] then
        -- Set sheathed
        self.sheathed[slot] = true
        self.sheathing[slot] = true
        -- Animate
        self:animate_equipment(slot, "sheath", 10)
        -- Sound
        self:play_equipment_sound(slot, "accent")
    end
end

VisibleEquipmentExtension.wield_slot = function(self, slot)
    if self.loaded[slot] then
        -- Unset sheathed
        self.sheathed[slot] = nil
        self.sheathing[slot] = nil
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

VisibleEquipmentExtension.get_backpack = function(self)
    -- Get current profile value
    local profile = self.profile
    -- Get loadout from profile
    local slot_gear_extra_cosmetic = profile and profile.loadout[SLOT_GEAR_EXTRA_COSMETIC]
    -- Get backpack name
    local name = slot_gear_extra_cosmetic and slot_gear_extra_cosmetic.__master_item.dev_name
    -- Return if name is not empty backpack
    return name ~= EMPTY_BACKPACK_DEV and name
end

VisibleEquipmentExtension.attach_settings = function(self, slot)
    local attach_settings = self.equipment_component:_attach_settings()
    self.equipment_component:_fill_attach_settings_3p(self.unit, attach_settings, slot)
    -- attach_settings.from_script_component = true
    attach_settings.skip_link_children = true
    return attach_settings
end

VisibleEquipmentExtension.is_me = function(self)
    return mod:me() == self.unit
end

VisibleEquipmentExtension.should_play_sound = function(self)
    if self:is_me() then
        local in_first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
        local on = self.sound_self == "on"
        local fp = in_first_person and (on or self.sound_self == "first_person")
        local tp = not in_first_person and (on or self.sound_self == "third_person")
        return fp or tp
    else
        return self.sound_others == "on"
    end
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

VisibleEquipmentExtension.position_objects = function(self)
    -- Iterate through equipment
    for slot, units in pairs(self.objects) do
        -- Position objects
        self:position_slot_objects(slot)
    end
end

-- local debugged_backpacks = {}
-- local debug_backpack = function(name)
--     if not debugged_backpacks[name] then
--         debugged_backpacks[name] = true
--         mod:dtf(debugged_backpacks, "debugged_backpacks", 10)
--     end
-- end
-- local last_backpack = nil

VisibleEquipmentExtension.position_slot_objects = function(self, slot)
    -- Iterate through objects
    for index, obj in pairs(self.objects[slot]) do
        -- Get offset
        local name = self.names[slot][index]
        -- Check backpack
        -- local backpacks = self.settings.backpacks
        local backpack_name = self:get_backpack()
        local backpack_table = backpack_name and self.settings.backpacks[backpack_name] or
            self.settings.backpacks.default
        local backpack_item_table = backpack_table and backpack_table[slot.item.item_type]
        local backpack_values = backpack_item_table and backpack_item_table[name] or
            backpack_table[name]
        -- if backpack_name then
        -- mod:echo(backpack_name)
        --     -- last_backpack = backpack_name
        -- --     -- debug_backpack(backpack_name)
        -- --     -- mod:echo("Values: "..tostring(backpack_values))
        -- end
        local backpack_group = backpack_name and "backpack" or "default"
        -- Item offsets
        local item_offset = self.settings.offsets[slot.item.weapon_template]
        -- local placement = self.pt.gear_placements[slot.item.gear_id]
        local placement = mod:gear_placement(slot.item.gear_id, nil, nil, true) --or "default" --or self.pt.gear_placements[slot.item.gear_id]
        if placement == "default" and backpack_group == "backpack" then placement = "backpack" end
        if placement == "backpack" and backpack_group == "default" then placement = "default" end
        -- if self.random_placements and not placement and not self.is_local_unit and item_offset and item_offset[placement] then
        --     local count = table_size(item_offset[placement])
        --     placement = table_keys(item_offset[placement])[math_random(1, count)]
        -- end
        local offset = (item_offset and item_offset[placement] and item_offset[placement][name]) or (item_offset and item_offset[backpack_group][name])
        -- offset = (item_offset and item_offset.leg_right and item_offset.leg_right[name]) or offset
        -- Breed offsets
        local breed_offsets = self.settings.offsets[slot.breed_name][slot.item.item_type]
        local offset = offset or breed_offsets[backpack_group][name] or
            breed_offsets[backpack_group].right
        -- Node
        local node_name = offset and offset.node or "j_spine2"
        local node_index = unit_has_node(self.unit, node_name) and unit_node(self.unit, node_name)
        -- Position and rotation
        local position = offset and offset.position and vector3_unbox(offset.position) or vector3_zero()
        local rotation = offset and offset.rotation and vector3_unbox(offset.rotation) or vector3_zero()
        -- Backpack
        position = position + vector3_unbox(backpack_values.position)
        rotation = rotation + vector3_unbox(backpack_values.rotation)
        -- Link visible equipment
        local world = self.equipment_component._world
        world_unlink_unit(world, obj)
        world_link_unit(world, obj, 1, self.unit, node_index)
        -- Set offset
        unit_set_local_position(obj, 1, position)
        unit_set_local_rotation(obj, 1, quaternion_from_vector(rotation))
        -- -- Anim values
        self.anim[slot].default_position[obj]:store(position)
        self.anim[slot].default_rotation[obj]:store(rotation)
        self.anim[slot].start_position[obj]:store(vector3_zero())
        self.anim[slot].start_rotation[obj]:store(vector3_zero())
        self.anim[slot].end_position[obj]:store(vector3_zero())
        self.anim[slot].end_rotation[obj]:store(vector3_zero())
        self.anim[slot].current_position[obj]:store(vector3_zero())
        self.anim[slot].current_rotation[obj]:store(vector3_zero())
    end
end

VisibleEquipmentExtension.update_item_visibility = function(self, equipment, wielded_slot)
    -- Set wielded slot
    self.wielded_slot = wielded_slot
    -- Iterate through equipment
    for slot_name, slot in pairs(equipment) do
        -- Check if slot should be processed
        if (table_contains(SLOTS, slot_name)) then
            -- Check slot
            if self.loaded[slot] then
                -- Hidden?
                local old_value = self.visible[slot]
                self.visible[slot] = (slot_name ~= wielded_slot and true) or false
                local player_invisible = self.player_visibility and not self.player_visibility:visible()
                local in_first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
                if player_invisible or in_first_person then self.visible[slot] = false end
                -- Iterate through objects
                for index, obj in pairs(self.objects[slot]) do
                    -- Set visibility
                    unit_set_unit_visibility(obj, self.visible[slot], true)
                end
                -- Animation in ui profile spawner
                if self.visible[slot] and not self.sheathed[slot] and self.from_ui_profile_spawner then
                    self:unwield_slot(slot)
                end
            end
        end
    end
end

-- ##### ┌─┐┌─┐┬ ┬┌┐┌┌┬┐┌─┐ ###########################################################################################
-- ##### └─┐│ ││ ││││ ││└─┐ ###########################################################################################
-- ##### └─┘└─┘└─┘┘└┘─┴┘└─┘ ###########################################################################################

VisibleEquipmentExtension.play_equipment_sound = function(self, optional_slot, optional_effect)
    -- Exit when sound requirements are not met
    if not self:should_play_sound() then return end
    -- Play sound
    if not optional_slot then
        -- Iterate through equipment
        for slot, units in pairs(self.objects) do
            -- Play sound for slot
            self:play_equipment_slot_sound(slot, optional_effect)
        end
    else
        -- Play sound for slot
        self:play_equipment_slot_sound(optional_slot, optional_effect)
    end
end

VisibleEquipmentExtension.play_equipment_slot_sound = function(self, slot, effect)
    -- Exit when sound requirements are not met
    if not self:should_play_sound() then return end
    -- Play sound
    if self.loaded[slot] and (self.wielded_slot ~= slot.name or self.sheathing[slot]) then
        -- Get slot data
        local weapon_template = slot.item.weapon_template
        local breed_name = slot.breed_name
        local item_type = slot.item.item_type
        effect = effect or "default"
        -- Get sounds
        local sounds =  self.settings.sounds[weapon_template] or self.settings.sounds[breed_name][item_type] or self.settings.sounds.default[item_type]
        local group = nil
        -- Get character state
        if sounds then
            local character_state_name = self.character_state_component and self.character_state_component.state_name or "walking"
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
            accent = false -- <- TEMPORARY
            if accent and sounds.accent and #sounds.accent > 0 and not self.accent[slot] then
                self.accent[slot] = mod:time() + accent_timeout
                group = sounds.accent[math_random(#sounds.accent)]
            elseif self.sheathing[slot] then
                group = "sfx_equip"
            elseif is_crouching and sounds.crouching and #sounds.crouching > 0 then
                group = sounds.crouching[math_random(#sounds.crouching)]
            elseif sounds[effect] and #sounds[effect] > 0 then
                group = sounds[effect][math_random(#sounds[effect])]
            elseif sounds.default and #sounds.default > 0 then
                group = sounds.default[math_random(#sounds.default)]
            end
        end
        -- Testing
        group = group or "sfx_ads_up"
        local sound = player_character_sound_event_aliases[group].events[weapon_template] or
            player_character_sound_event_aliases[group].events.default
        -- Check sound and extension
        if sound and self.fx_extension then
            -- Play sound
            local husk = player_character_sound_event_aliases[group].has_husk_events
            local move_speed = self.locomotion_extension and self.locomotion_extension:move_speed() or 1
            self.fx_extension:trigger_wwise_event(sound, husk, true, self.unit, 1, "foley_speed", move_speed)
        end
    end
end

-- ##### ┌─┐┌─┐┌─┐┌┬┐┌─┐┌┬┐┌─┐┌─┐ #####################################################################################
-- ##### ├┤ │ ││ │ │ └─┐ │ ├┤ ├─┘ #####################################################################################
-- ##### └  └─┘└─┘ ┴ └─┘ ┴ └─┘┴   #####################################################################################

VisibleEquipmentExtension.footstep = function(self)
    -- Play sound
    self:play_equipment_sound()
    -- Animate
    self:animate_equipment()
    -- Switch foot
    self.right_foot_next = not self.right_foot_next
end

VisibleEquipmentExtension.footstep_interval = function(self, slot)
    -- Get info
    local weapon_template = weapon_templates.weapon_template_from_item(slot.item)
    local breed_footstep_intervals = weapon_template.breed_footstep_intervals
    local footstep_intervals = breed_footstep_intervals and breed_footstep_intervals[slot.breed_name] or weapon_template.footstep_intervals
    -- Get interval
    local interval = .4
    if footstep_intervals then
        local character_state_name = self.character_state_component and self.character_state_component.state_name or "walking"
        local is_crouching = self.movement_state_component and self.movement_state_component.is_crouching or false
        local alternate_fire_active = self.alternate_fire_component and self.alternate_fire_component.is_active or false
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
    -- Return
    return interval
end

VisibleEquipmentExtension.update = function(self, dt, t)
    -- Calculate rotation difference
	local first_person_unit = self.first_person_extension and self.first_person_extension:first_person_unit()
    local rotation_unit = (not mod:is_in_hub() and first_person_unit) or self.unit
    local rotation = quaternion_to_vector(unit_world_rotation(rotation_unit, 1))
    local difference = math_clamp((vector3_unbox(self.rotation) - rotation)[3], -10, 10)
    self.difference = math_lerp(self.difference, difference, dt * 4)
    self.rotation:store(rotation)
    -- Iterate through equipment
    for slot, units in pairs(self.objects) do
        -- Update accent
        if self.accent[slot] and self.accent[slot] < t then
            self.accent[slot] = nil
        end
        -- Update animation
        if self.animations then
            -- Update animation interval
            for index, obj in pairs(self.objects[slot]) do
                self.anim[slot].interval[obj] = self:footstep_interval(slot)
            end
            -- Update animation
            self:update_animation(dt, t, slot)
        end
    end

end

-- ##### ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌ ######################################################################################
-- ##### ├─┤│││││││├─┤ │ ││ ││││ ######################################################################################
-- ##### ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘ ######################################################################################

VisibleEquipmentExtension.animate_equipment = function(self, optional_slot, optional_animation, optional_strength)
    -- Exit when animations are not enabled
    if not self.animations then return end
    -- Animate
    local animation = optional_animation or "default"
    if not optional_slot then
        for slot, units in pairs(self.objects) do
            self:animate_slot(slot, animation, optional_strength)
        end
    else
        self:animate_slot(optional_slot, animation, optional_strength)
    end
end

VisibleEquipmentExtension.animate_slot = function(self, slot, animation, strength_override)
    -- Exit when animations are not enabled
    if not self.animations then return end
    -- Animate, iterate through slot objects
    for index, obj in pairs(self.objects[slot]) do
        -- Get animation
        local anim = self.anim[slot]
        local name = self.names[slot][index]
        local animation_table = self.settings.animations[slot.item.weapon_template] or
            self.settings.animations[slot.breed_name][slot.item.item_type] or
            self.settings.animations
        local specific_animation = animation_table[animation] and animation_table[animation][name]
        local new_animation = specific_animation or animation_table[name]
        -- Check animation requirements
        if not anim.current[obj] or new_animation.interrupt or not anim.current[obj].interrupt then
            -- Set animation
            anim.previous[obj] = new_animation
            anim.current[obj] = new_animation
            anim.strength_override[obj] = strength_override
            anim.started[obj] = nil
            anim.ending[obj] = nil
        end
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
        if not self.from_ui_profile_spawner then
            angle = angle * -1
        end
        -- Momentum vector
        local item_momentum = self.settings.momentum[slot.item.weapon_template]
        local side_momentum = item_momentum and item_momentum[self.names[slot][index]]
        local default_momentum = self.settings.momentum[slot.item.item_type][self.names[slot][index]]
        local momentum = (side_momentum and side_momentum.momentum) or (default_momentum and default_momentum.momentum)
        local momentum_vector = momentum and vector3_unbox(momentum) or vector3_zero()

        -- Calculate momentum_drag 
        -- local momentum_drag = vector3_zero()
        local multiplier = self.from_ui_profile_spawner and -2 or 2
        local momentum_drag = (momentum_vector * angle) * multiplier
        -- Get foot side
        local right_foot_next = self.right_foot_next
        -- Check if first person extension is set up
        if self.first_person_extension and self.first_person_extension:is_in_first_person_mode() then
            -- Get foot side
            right_foot_next = self.first_person_extension._right_foot_next
        end
        
        local anim = self.anim[slot]
        -- Check for current active animation
        if anim.current[obj] then
            -- Check if not started yet
            if not anim.started[obj] then
                -- Get start state
                local start_state = anim.current[obj].start
                -- Set start state
                anim.state[obj] = anim.current[obj][start_state]
            -- Check if started
            elseif anim.started[obj] then
                -- Check timer if elapsed
                if anim.ending[obj] < t then
                    -- Get next state
                    local next_state = anim.state[obj].next
                    -- Set next state
                    anim.state[obj] = anim.current[obj][next_state]
                    -- Reset timer
                    anim.started[obj] = nil
                    -- Reset strength
                    anim.strength_override[obj] = nil
                end
            end

            -- Get interval
            local states = anim.current[obj].states
            local interval = anim.current[obj].interval or self:footstep_interval(slot) / states --anim.interval[obj] / states
            -- local interval = anim.interval[obj] / states
            -- Get state
            local state = anim.state[obj]

            -- Check state is valid and not started yet
            if state and not anim.started[obj] then
                -- Set timer
                anim.started[obj] = t
                anim.ending[obj] = t + interval
                -- Set start and end positions and rotations
                anim.start_position[obj] = state.start_position
                anim.start_rotation[obj] = state.start_rotation
                anim.end_position[obj] = state.end_position
                anim.end_rotation[obj] = state.end_rotation

            -- Check state is not valid
            elseif not state then
                -- Reset animation
                anim.current[obj] = nil
                anim.started[obj] = nil
                anim.ending[obj] = nil
                self.sheathing[slot] = nil
            end

            -- Check if any animation is started
            if anim.started[obj] then
                self.sheathing[slot] = nil
                -- Calculate progress
                -- local progress = (anim.ending[obj] - t) / interval
                local progress = ((anim.started[obj] + interval) - t) / interval
                local anim_progress = math_ease_sine(1 - progress)
                -- Get move speed multiplier
                local move_speed = self.locomotion_extension and self.locomotion_extension:move_speed() or 1
                -- Get foot multiplier
                local foot_multiplier = 1
                if move_speed == 0 then
                    move_speed = 1
                elseif slot.item.item_type == WEAPON_MELEE then
                    foot_multiplier = right_foot_next and 1 or .5
                elseif slot.item.item_type == WEAPON_RANGED then
                    foot_multiplier = right_foot_next and .5 or 1
                end
                -- Get strength multiplier
                local start_strength = move_speed * foot_multiplier
                local end_strength = move_speed * foot_multiplier
                if anim.strength_override[obj] then
                    if state.name == "step" then
                        end_strength = anim.strength_override[obj]
                    elseif state.name == "back" then
                        start_strength = anim.strength_override[obj]
                    end
                end
                -- No modifier
                if state.no_modifiers then
                    start_strength = 1
                    end_strength = 1
                    move_speed = 1
                end
                -- Calculate start and end positions and rotations
                local start_position = vector3_unbox(anim.start_position[obj]) * start_strength
                local start_rotation = vector3_unbox(anim.start_rotation[obj]) * start_strength
                local end_position = vector3_unbox(anim.end_position[obj]) * end_strength
                local end_rotation = vector3_unbox(anim.end_rotation[obj]) * end_strength
                -- Calculate current target positions and rotations
                local target_position = vector3_lerp(start_position, end_position, progress)
                local target_rotation = vector3_lerp(start_rotation, end_rotation, progress)
                -- Calculate current positions and rotations
                local current_position = vector3_lerp(vector3_unbox(anim.current_position[obj]), target_position, anim_progress)
                local current_rotation = vector3_lerp(vector3_unbox(anim.current_rotation[obj]), target_rotation, anim_progress)
                -- Store current positions and rotations
                anim.current_position[obj]:store(current_position)
                anim.current_rotation[obj]:store(current_rotation)
                -- Calculate final positions and rotations
                local position = vector3_unbox(anim.default_position[obj]) + current_position
                local rotation = quaternion_from_vector(vector3_unbox(anim.default_rotation[obj]) + current_rotation)
                -- Set final positions and rotations
                unit_set_local_position(obj, 1, position)
                unit_set_local_rotation(obj, 1, rotation)
            end
        end

        -- Get momentum drag
        -- local current_position = vector3_unbox(anim.current_position[obj])
        local current_rotation = vector3_unbox(anim.current_rotation[obj])
        -- Calculate final positions and rotations
        -- local position = vector3_unbox(anim.default_position[obj]) + unit_local_position(self.unit, 1)
        local rotation = vector3_unbox(anim.default_rotation[obj]) + current_rotation
        -- Set final positions and rotations
        -- unit_set_local_position(obj, 1, position)
        local mat = quaternion_matrix4x4(quaternion_from_vector(rotation))
        local rotated_pos = matrix4x4_transform(mat, momentum_drag)
        rotation = quaternion_multiply(quaternion_from_vector(rotation), quaternion_from_vector(rotated_pos))
        unit_set_local_rotation(obj, 1, rotation)

    end

end

-- ##### ┌─┐┬  ┌─┐┌┬┐  ┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐ #############################################################################
-- ##### └─┐│  │ │ │    │ ├─┤├┴┐│  ├┤ └─┐ #############################################################################
-- ##### └─┘┴─┘└─┘ ┴    ┴ ┴ ┴└─┘┴─┘└─┘└─┘ #############################################################################

VisibleEquipmentExtension.reset_slot_tables = function(self, slot)
    self.objects[slot] = {}
    self.accent[slot] = nil
    self.sheathed[slot] = nil
    self.sheathing[slot] = nil
    self.items[slot] = {}
    self.names[slot] = {}
    self.anim[slot] = {}
    self.loaded[slot] = false
    self.visible[slot] = {}
end

VisibleEquipmentExtension.unset_slot_tables = function(self, slot)
    self.objects[slot] = nil
    self.accent[slot] = nil
    self.sheathed[slot] = nil
    self.sheathing[slot] = nil
    self.items[slot] = nil
    self.names[slot] = nil
    self.anim[slot] = nil
    self.loaded[slot] = nil
    self.visible[slot] = nil
end

VisibleEquipmentExtension.clear_slot_tables = function(self)
    self.objects = {}
    self.accent = {}
    self.sheathed = {}
    self.sheathing = {}
    self.items = {}
    self.names = {}
    self.anim = {}
    self.loaded = {}
    self.visible = {}
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
