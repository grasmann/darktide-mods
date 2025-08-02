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
    local ScriptCamera = mod:original_require("scripts/foundation/utilities/script_camera")
    -- local VisibleEquipmentOffsets = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/visible_equipment/offsets")
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
    local callback = callback
    local math_abs = math.abs
    local managers = Managers
    local tostring = tostring
    local unit_node = Unit.node
    local Matrix4x4 = Matrix4x4
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local table_enum = table.enum
    local table_size = table.size
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local math_random = math.random
    local vector3_lerp = vector3.lerp
    local vector3_zero = vector3.zero
    local unit_get_data = Unit.get_data
    local unit_has_node = Unit.has_node
    local table_combine = table.combine
    local quaternion_box = QuaternionBox
    local table_contains = table.contains
    local table_icombine = table.icombine
    local vector3_unbox = vector3_box.unbox
    local world_link_unit = World.link_unit
    local world_unlink_unit = World.unlink_unit
    local quaternion_unbox = quaternion_box.unbox
    local world_destroy_unit = World.destroy_unit
    local unit_world_rotation = Unit.world_rotation
    local unit_local_rotation = Unit.local_rotation
    local matrix4x4_transform = Matrix4x4.transform
    local unit_set_local_scale = Unit.set_local_scale
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local quaternion_to_vector = Quaternion.to_vector
    local math_ease_out_elastic = math.ease_out_elastic
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_force_stream_meshes = Unit.force_stream_meshes
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local DEBUG = false
    local OFF = "off"
    local ALL = "all"
    local WALK = "walk"
    local SPRINT = "sprint"
    local STEP_STATE = "step"
    local DEFAULT = "default"
    local ANIM_TIME_MELEE = .3
    local ANIM_TIME_RANGED = .3
    local OGRYN_ANIM_MULTIPLIER = 1.5
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
    local EMPTY_UNIT = "core/units/empty_root"
    local SLAB_SHIELD = "ogryn_powermaul_slabshield_p1_m1"
    -- local ASSAULT_SHIELD = "assault_shield_p1_m1"
    local MAUL_SHIELD = "powermaul_shield_p1_m1"
    local MAUL_SHIELD2 = "powermaul_shield_p1_m2"
    local PISTOL_SHIELD = "shotpistol_shield_p1_m1"
    local SLOT_GEAR_EXTRA_COSMETIC = "slot_gear_extra_cosmetic"
    local ATTACHMENT_SPAWN_STATUS = table_enum("waiting_for_load", "fully_spawned")
    local BACKPACK_EMPTY = "content/items/characters/player/human/backpacks/empty_backpack"
    local WEIGHT_FACTORS = {
        light = .66,
        medium = .33,
        heavy = .1,
    }
    local rnd_attach = {
        "hips_front",
        "hips_back",
        "hips_left",
        "hips_right",
        "chest",
        "back_right",
        "back_left",
    }
    local no_rnd_attach = {
        "forcestaff_p1_m1",
        "forcestaff_p2_m1",
        "forcestaff_p3_m1",
        "forcestaff_p4_m1",
        "ogryn_powermaul_slabshield_p1_m1",
        "shotpistol_shield_p1_m1",
        "powermaul_shield_p1_m1",
        "powermaul_shield_p1_m2",
        "ogryn_pickaxe_2h_p1_m1",
        "ogryn_pickaxe_2h_p1_m2",
        "ogryn_pickaxe_2h_p1_m3",
    }
    -- Names
    local weapon_size_data = {
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
    local check_packages_timer = nil
    local check_packages_time = 1
    local gear_node_correction = {
        huge_weapons = {
            hips_left = "back_left",
            hips_right = "back_right",
            hips_front = "back_left",
            hips_back = "back_right",
            leg_left = "back_right",
            leg_right = "back_left",
            chest = "back_left"
        },
        medium_weapons = {
            leg_left = "back_left",
            leg_right = "back_right",
            hips_front = "back_left",
            hips_back = "back_right",
            chest = "back_right"
        },
        backpack = {
            back_left = "back_left",
            back_right = "back_right"
        },
        alternative = {
            back_left = "back_right",
            back_right = "back_left",
            backpack_left = "backpack_right",
            backpack_right = "backpack_left",
            hips_left = "hips_right",
            hips_right = "hips_left",
            hips_front = "hips_back",
            hips_back = "hips_front",
            leg_left = "leg_right",
            leg_right = "leg_left",
            chest = "hips_back"
        }
    }
    local gear_size_limits = {
        human = {huge = 2.5, medium = 1.5},
        ogryn = {huge = 2.5, medium = 2},
    }
--#endregion

-- mod:hook(CLASS.ExtensionManager, "unregister_units", function(func, self, units, num_units, unregister_from_level_units, ...)
--     local world = managers.world and managers.world:world("level_world")
--     if world then
--         for _, unit in pairs(units) do
--             world_unlink_unit(world, unit)
--         end
--     end
-- end)

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
    -- Attributes
    self.profile = extension_init_data.profile
    self.ui_profile_spawner = extension_init_data.ui_profile_spawner
    self.loading_spawn_point = extension_init_data.loading_spawn_point
    self.equipment_component = extension_init_data.equipment_component
    self.equipment = extension_init_data.equipment
    self.wielded_slot = extension_init_data.wielded_slot or SLOT_UNARMED
    self.back_node = self:current_back_node()
    self.position_overwrite = {}
    self.rotation_overwrite = {}
    self.scale_overwrite = {}
    self.last_player_rotation = vector3_box(vector3_zero())
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
    -- self.center_mass_units = {}
    self.dummy_units = {}
    self.slot_units = {}
    self.center_mass_units = {}
    -- self.helper_units = {}
    self.is_linked = {}
    self.center_mass_applied = {}
    self.equipment_data = {}
    self.slot_infos = {}
    self.packages = {}
    self.step_animation = {}
    self.sounds = {}
    self.rotate_animation = {}
    self.weapon_template = {}
    self.gear_nodes = {}
    self.size = {}
    self.weight = {}
    self.visible = {}
    self.wobble = {}
    -- Spawn attach units
    self:spawn_gear_attach_points()
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    managers.event:register(self, "weapon_customization_attach_point_changed", "on_attach_point_changed")
    managers.event:register(self, "weapon_customization_cutscene", "set_cutscene")
    -- managers.event:register(self, "weapon_customization_mission_intro", "set_mission_intro")
    -- Settings
    self:on_settings_changed()
    -- Initialized
    self.initialized = true
end

VisibleEquipmentExtension.extensions_ready = function(self, world, unit)
    
end

VisibleEquipmentExtension.delete = function(self)
    -- Events
    managers.event:unregister(self, "weapon_customization_settings_changed")
    managers.event:unregister(self, "weapon_customization_attach_point_changed")
    managers.event:unregister(self, "weapon_customization_cutscene")
    -- managers.event:unregister(self, "weapon_customization_mission_intro")
    -- Uninitialize
    self.initialized = false
    -- -- Iterate slots
    -- for slot, _ in pairs(self.dummy_units) do
    --     -- Delete
    --     self:delete_slot(slot)
    -- end
    self:delete_slots()
    -- Helper units
    -- local helper_units = self.helper_units
    -- if helper_units and table_size(helper_units) > 0 then
    --     mod:echo("Deleting helper units")
    --     for attach_name, unit in pairs(helper_units) do
    --         if unit and unit_alive(unit) then
    --             world_unlink_unit(self.world, unit)
    --             world_destroy_unit(self.world, unit)
    --         end
    --     end
    --     self.helper_units = nil
    -- else
    --     mod:echot("error helper units = "..tostring(self.helper_units))
    -- end
    self:despawn_gear_attach_points()
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
    self.backpack_name = item and mod.gear_settings:short_name(item)
    -- Trigger wobble
    if item and self.back_change ~= item then
        -- self.trigger_wobble = true
        self:trigger_step()
        self.back_change = item
    end
    -- Check if not empty backpack
	return item and item ~= BACKPACK_EMPTY
end

VisibleEquipmentExtension.gear_node_units = function(self)
    return self.helper_units
end

VisibleEquipmentExtension.spawn_gear_attach_points = function(self, unit_or_nil)
    if not self.helper_units then
        local unit = unit_or_nil and unit_alive(unit_or_nil) and unit_or_nil or self.player_unit
        self.helper_units = mod.gear_settings:spawn_gear_attach_points(self:get_breed(), self.world, unit)
    end
end

VisibleEquipmentExtension.despawn_gear_attach_points = function(self)
    if self.helper_units and table_size(self.helper_units) > 0 then
        for attach_name, unit in pairs(self.helper_units) do
            if unit and unit_alive(unit) then
                world_unlink_unit(self.world, unit)
                world_destroy_unit(self.world, unit)
            end
        end
        self.helper_units = nil
    end
end

VisibleEquipmentExtension.equipment_data_by_slot = function(self, slot)
    -- Check if has backpack
    local data_type = self:has_backpack() and BACKPACK or DEFAULT
    local offsets = mod.visible_equipment_offsets
    -- Get data
    local item_data = offsets[self.item_names[slot]]
    local item_equipment_data = item_data and item_data[data_type]
    local center_mass = item_data and item_data.center_mass
    local center_mass2 = item_data and item_data.center_mass2
    local item_type = self.item_types[slot]
    local breed = self:get_breed()
    -- Bots
    item_equipment_data = item_equipment_data or offsets[breed][item_type] and offsets[breed][item_type][data_type]
    center_mass = center_mass or offsets[breed][item_type] and offsets[breed][item_type].center_mass
    center_mass2 = center_mass2 or offsets[breed][item_type] and offsets[breed][item_type].center_mass2
    center_mass = mod.gear_settings:apply_fixes(slot.item, "center_mass") or center_mass
    center_mass2 = mod.gear_settings:apply_fixes(slot.item, "center_mass2") or center_mass2
    -- Loading
    if self.loading_spawn_point then
        item_equipment_data = item_data and item_data.loading[self.loading_spawn_point]
        if not item_equipment_data then
            if slot.name == "slot_scondary" then
                item_equipment_data = offsets.human[WEAPON_RANGED].loading[self.loading_spawn_point]
            else
                item_equipment_data = offsets.human[WEAPON_MELEE].loading[self.loading_spawn_point]
            end
        end
    end
    -- Sounds
    local sounds = item_equipment_data and item_equipment_data.step_sounds or item_data and item_data.step_sounds
    local sounds2 = item_equipment_data and item_equipment_data.step_sounds2 or item_data and item_data.step_sounds2
    -- Attach node
    local attach_node = item_equipment_data and item_equipment_data.attach_node or item_data and item_data.attach_node
    local gear_node_offsets = mod.gear_node_offsets[breed] and mod.gear_node_offsets[breed].default and mod.gear_node_offsets[breed].default[item_type]
    local gear_position, gear_position2, gear_rotation, gear_scale = nil, nil, nil, nil
    local slot_gear_node = self.gear_nodes[slot]
    if slot_gear_node and gear_node_offsets then
        gear_position = gear_node_offsets[slot_gear_node] and gear_node_offsets[slot_gear_node].position
        gear_position2 = gear_node_offsets[slot_gear_node] and gear_node_offsets[slot_gear_node].position2
        gear_rotation = gear_node_offsets[slot_gear_node] and gear_node_offsets[slot_gear_node].rotation
        gear_scale = gear_node_offsets[slot_gear_node] and gear_node_offsets[slot_gear_node].scale
    end
    local position_fix = mod.gear_settings:apply_fixes(slot.item, "position")
    local position2_fix = mod.gear_settings:apply_fixes(slot.item, "position2")
    gear_position = (position_fix and (position_fix[data_type] or position_fix)) or gear_position
    gear_position2 = (position2_fix and (position2_fix[data_type] or position2_fix)) or gear_position2
    -- Scale
    local scale = gear_scale or item_equipment_data.scale
    local scale2 = gear_scale or item_equipment_data.scale2
    scale = mod.gear_settings:apply_fixes(slot.item, "scale") or scale
    scale2 = mod.gear_settings:apply_fixes(slot.item, "scale2") or scale2
    -- Compile equipment data
    local equipment_data = {
        position = {gear_position or item_equipment_data.position, gear_position2 or item_equipment_data.position2},
        rotation = {gear_rotation or item_equipment_data.rotation, item_equipment_data.rotation2},
        scale = {scale, scale2},
        -- center_mass = {item_equipment_data.center_mass or item_data and item_data.center_mass, item_equipment_data.center_mass2 or item_data and item_data.center_mass2},
        center_mass = {center_mass, center_mass2},
        step_move = {item_equipment_data.step_move, item_equipment_data.step_move2},
        step_rotation = {item_equipment_data.step_rotation, item_equipment_data.step_rotation2},
        init = item_data and item_data.init,
        wield = item_data and item_data.wield,
        attach_node = attach_node,
    }
    -- Return data
    return equipment_data, sounds, sounds2
end

VisibleEquipmentExtension.weapon_unit = function(self, slot_id)
    local slot = self.equipment and self.equipment[slot_id]
    return slot and self.dummy_units[slot] and self.dummy_units[slot].base
end

VisibleEquipmentExtension.weapon_size = function(self, slot_id)
    local slot = self.equipment and self.equipment[slot_id]
    return slot and self.dummy_units[slot] and mod:weapon_size(self.dummy_units[slot].attachments) or 0
end

VisibleEquipmentExtension.weapon_item = function(self, slot_id)
    local slot = self.equipment and self.equipment[slot_id]
    return slot and slot.item
end

VisibleEquipmentExtension.current_back_node = function(self)
    local player_unit = self.player_unit
    if player_unit and unit_alive(player_unit) then
        if unit_has_node(player_unit, BACKPACK_ATTACH) then
            return BACKPACK_ATTACH
        elseif unit_has_node(player_unit, BACKPACK_OFFSET) then
            return BACKPACK_OFFSET
        end
    end
    return 1
end

VisibleEquipmentExtension.get_foot_step_interval = function(self)
    -- local crouching = self.movement_state_component and self.movement_state_component.is_crouching
    -- local alt_fire = self.alternate_fire_component and self.alternate_fire_component.is_active
    -- local sprint = self.sprint_character_state_component and self.sprint_character_state_component.is_sprinting
    -- sprint = self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == SPRINT or sprint
    -- crouching = self.is_in_hub and self.hub_jog_character_state and self.hub_jog_character_state.move_state == WALK or crouching
    local footstep_intervals = self.footstep_intervals
    local breed = self:get_breed()
    if self:is_sprinting() then
        if footstep_intervals and footstep_intervals.sprinting then return breed == "ogryn" and footstep_intervals.sprinting * OGRYN_ANIM_MULTIPLIER or footstep_intervals.sprinting end
        return breed == "ogryn" and footstep_intervals_templates.default.sprinting * OGRYN_ANIM_MULTIPLIER or footstep_intervals_templates.default.sprinting
    elseif self:is_crouching() then
        if self:is_alt_fire() then
            if footstep_intervals and footstep_intervals.crouch_walking_alternate_fire then return breed == "ogryn" and footstep_intervals.crouch_walking_alternate_fire * OGRYN_ANIM_MULTIPLIER or footstep_intervals.crouch_walking_alternate_fire end
            return breed == "ogryn" and footstep_intervals_templates.default.crouch_walking_alternate_fire * OGRYN_ANIM_MULTIPLIER or footstep_intervals_templates.default.crouch_walking_alternate_fire
        end
        if footstep_intervals and footstep_intervals.crouch_walking then return breed == "ogryn" and footstep_intervals.crouch_walking * OGRYN_ANIM_MULTIPLIER or footstep_intervals.crouch_walking end
        return breed == "ogryn" and footstep_intervals_templates.default.crouch_walking * OGRYN_ANIM_MULTIPLIER or footstep_intervals_templates.default.crouch_walking
    else
        if self:is_alt_fire() then
            if footstep_intervals and footstep_intervals.walking_alternate_fire then return breed == "ogryn" and footstep_intervals.walking_alternate_fire * OGRYN_ANIM_MULTIPLIER or footstep_intervals.walking_alternate_fire end
            return breed == "ogryn" and footstep_intervals_templates.default.walking_alternate_fire * OGRYN_ANIM_MULTIPLIER or footstep_intervals_templates.default.walking_alternate_fire
        end
        if footstep_intervals and footstep_intervals.walking then return breed == "ogryn" and footstep_intervals.walking * OGRYN_ANIM_MULTIPLIER or footstep_intervals.walking end
        return breed == "ogryn" and footstep_intervals_templates.default.walking * OGRYN_ANIM_MULTIPLIER or footstep_intervals_templates.default.walking
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

VisibleEquipmentExtension.world = function(self)
    return self.world
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

VisibleEquipmentExtension.set_cutscene = function(self, is_cutscene)
    self.cut_scene = is_cutscene
    if self.initialized then
        self:update_equipment_visibility()
    end
end

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
    if not footstep_intervals_templates.unarmed_human_hub then
        footstep_intervals_templates.unarmed_human_hub = {
            crouch_walking = 0.61,
            walking = 0.37,
            sprinting = 0.33
        }
    end
    if not footstep_intervals_templates.unarmed_ogryn_hub then
        footstep_intervals_templates.unarmed_ogryn_hub = {
            crouch_walking = 0.70,
            walking = 0.60,
            sprinting = 0.54
        }
    end
end)

VisibleEquipmentExtension.set_weapon_size = function(self, slot)
    self.size[slot] = mod:weapon_size(self.dummy_units[slot].attachments)
    if DEBUG then mod:echo("Setting size for "..self.item_names[slot]..": "..self.size[slot]) end
end

VisibleEquipmentExtension.hide_bullets = function(self, slot)
    mod.gear_settings:hide_bullets(self.dummy_units[slot].attachments)
end

VisibleEquipmentExtension.trigger_step = function(self, optional_time_overwrite)
    self.trigger_wobble = true
    self.time_overwrite = optional_time_overwrite
    for slot_name, slot in pairs(self.equipment) do
        local step_animation = self.step_animation[slot]
        if step_animation then
            step_animation.time = self.time_overwrite or step_animation.time
            -- step_animation.time = self:get_breed() == "ogryn" and step_animation.time * 4 or step_animation.time
            step_animation.time_wobble = self.time_overwrite or step_animation.time_wobble
            -- step_animation.time_wobble = self:get_breed() == "ogryn" and step_animation.time_wobble * 4 or step_animation.time_wobble
            self.wobble[slot] = true
        end
    end
end

VisibleEquipmentExtension.link_equipment = function(self)

    if not self.player_unit or not unit_alive(self.player_unit) then
        return
    end

    -- Attach to node
    local node_index, attach_unit = unit_node(self.player_unit, self.back_node), self.player_unit
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        local slot_units = self.slot_units[slot]
        local gear_node = self.gear_nodes[slot]
        -- Check dummies
        if self.dummy_units[slot] and not self.is_linked[slot] then
            -- Data
            local data = self.equipment_data[slot]
            if data.attach_node and unit_has_node(self.player_unit, data.attach_node) then
                node_index, attach_unit = unit_node(self.player_unit, data.attach_node), self.player_unit
            end
            -- Get attach node
            if gear_node and self.helper_units and self.helper_units[gear_node] then
                node_index, attach_unit = 1, self.helper_units[gear_node]
            end
            -- Iterate units
            for i, unit in pairs(slot_units) do
                if unit and unit_alive(unit) then
                    local rotation = unit_local_rotation(unit, 1)
                    local mat = quaternion_matrix4x4(rotation)
                    -- Link unit to attachment node
                    world_unlink_unit(self.world, unit, true)
                    world_link_unit(self.world, unit, 1, attach_unit, node_index)
                end
            end
            -- Set linked
            self.is_linked[slot] = true
        end
    end
    -- Apply center mass
    self:apply_center_mass()
end

VisibleEquipmentExtension.apply_center_mass = function(self)
    -- local gear_settings = mod.gear_settings
    -- Iterate equipment
    for slot_name, slot in pairs(self.equipment) do
        local slot_units = self.slot_units[slot]
        local item_name = self.item_names[slot]
        local item_attachments = mod.attachment_models[item_name]
        local center_mass_units = self.center_mass_units[slot]
        -- Check dummies
        if self.dummy_units[slot] then
            -- Data
            local data = self.equipment_data[slot]
            -- Iterate units
            for i, unit in pairs(slot_units) do
                -- Apply center mass
                local children = center_mass_units[i]
                if children and #children > 0 and data.center_mass and data.center_mass[i] then
                    children[#children+1] = unit
                    local slot_info_id = mod.gear_settings:slot_info_id(slot.item)
                    for j, child in pairs(children) do
                        local attachment_name = mod.gear_settings:attachment_name(child)
                        if attachment_name then
                            -- mod:echo("apply_center_mass: "..tostring(attachment_name))
                            local attachment_data = attachment_name and item_attachments[attachment_name]
                            attachment_data = mod.gear_settings:apply_fixes(slot.item, child) or attachment_data
                            local default_position = attachment_data and attachment_data.position and vector3_unbox(attachment_data.position) or vector3(0, 0, 0)
                            -- if j == 1 or j == #children then
                            --     default_position = vector3(0, 0, 0)
                            -- end
                            local rotation = unit_local_rotation(child, 1)
                            local mat = quaternion_matrix4x4(rotation)
                            local rotated_pos = matrix4x4_transform(mat, vector3_unbox(data.center_mass[i]))
                            unit_set_local_position(child, 1, default_position + rotated_pos)
                            -- mod:unit_set_local_position_mesh(slot_info_id, child, default_position + rotated_pos)
                        end
                    end
                end
            end
        end
    end
end

-- VisibleEquipmentExtension.position_equipment = function(self)
--     -- Iterate equipment
--     for slot_name, slot in pairs(self.equipment) do
--         local position_overwrite = self.position_overwrite[slot]
--         local rotation_overwrite = self.rotation_overwrite[slot]
--         local scale_overwrite = self.scale_overwrite[slot]
--         local slot_units = self.slot_units[slot]
--         -- Check dummies
--         if self.dummy_units[slot] and self.is_linked[slot] then
--             -- Data
--             local data = self.equipment_data[slot]
--             -- Iterate units
--             for i, unit in pairs(slot_units) do
--                 if unit and unit_alive(unit) then
--                     local rot = vector3_unbox(data.rotation[i])
--                     local rotation = quaternion_from_vector(rot)
--                     -- Position equipment
--                     local position = vector3_unbox(data.position[i])
--                     if position_overwrite then
--                         position = vector3_unbox(position_overwrite)
--                     end
--                     -- Modding tools
--                     if unit_get_data(unit, "unit_manipulation_position_offset") then
--                         position = position + vector3_unbox(unit_get_data(unit, "unit_manipulation_position_offset"))
--                     end
--                     -- Set position
--                     unit_set_local_position(unit, 1, position)
--                     -- Rotate equipment
--                     if rotation_overwrite then
--                         rotation = quaternion_unbox(rotation_overwrite)
--                     end
--                     -- Modding tools
--                     if unit_get_data(unit, "unit_manipulation_rotation_offset") then
--                         rotation = Quaternion.multiply(rotation, quaternion_unbox(unit_get_data(unit, "unit_manipulation_rotation_offset")))
--                     end
--                     -- Set rotation
--                     unit_set_local_rotation(unit, 1, rotation)
--                     -- Scale equipment
--                     local scale = vector3_unbox(data.scale[i])
--                     if scale_overwrite then
--                         scale = vector3_unbox(scale_overwrite)
--                     end
--                     -- Modding tools
--                     if unit_get_data(unit, "unit_manipulation_scale_offset") then
--                         scale = scale + vector3_unbox(unit_get_data(unit, "unit_manipulation_scale_offset"))
--                     end
--                     -- Set scale
--                     unit_set_local_scale(unit, 1, scale)
--                 end
--             end
--         end
--     end
-- end
VisibleEquipmentExtension.position_equipment = function(self)
	local dummy_units = self.dummy_units
	local is_linked = self.is_linked
	local equipment = self.equipment
	local slot_units_all = self.slot_units
	local equipment_data_all = self.equipment_data
	local pos_overwrites = self.position_overwrite
	local rot_overwrites = self.rotation_overwrite
	local scale_overwrites = self.scale_overwrite

	for slot_name, slot in pairs(equipment) do
		if dummy_units[slot] and is_linked[slot] then
			local slot_units = slot_units_all[slot]
			local data = equipment_data_all[slot]
			local pos_overwrite = pos_overwrites[slot]
			local rot_overwrite = rot_overwrites[slot]
			local scale_overwrite = scale_overwrites[slot]

			local pos_override_vec = pos_overwrite and vector3_unbox(pos_overwrite)
			local rot_override_quat = rot_overwrite and quaternion_unbox(rot_overwrite)
			local scale_override_vec = scale_overwrite and vector3_unbox(scale_overwrite)

			for i, unit in pairs(slot_units) do
				if unit and unit_alive(unit) then
					-- Position
					local position = pos_override_vec or vector3_unbox(data.position[i])
					local pos_offset_data = unit_get_data(unit, "unit_manipulation_position_offset")
					if pos_offset_data then
						position = position + vector3_unbox(pos_offset_data)
					end
					unit_set_local_position(unit, 1, position)

					-- Rotation
					local rotation = rot_override_quat or quaternion_from_vector(vector3_unbox(data.rotation[i]))
					local rot_offset_data = unit_get_data(unit, "unit_manipulation_rotation_offset")
					if rot_offset_data then
						rotation = Quaternion.multiply(rotation, quaternion_unbox(rot_offset_data))
					end
					unit_set_local_rotation(unit, 1, rotation)

					-- Scale
					local scale = scale_override_vec or vector3_unbox(data.scale[i])
					local scale_offset_data = unit_get_data(unit, "unit_manipulation_scale_offset")
					if scale_offset_data then
						scale = scale + vector3_unbox(scale_offset_data)
					end
					unit_set_local_scale(unit, 1, scale)
				end
			end
		end
	end
end

VisibleEquipmentExtension.delete_slots = function(self)
    for slot_name, slot in pairs(self.equipment) do
        self:delete_slot(slot)
    end
end

VisibleEquipmentExtension.delete_slot = function(self, slot)
    local extension_manager = managers.state.extension
    local dummy_units = self.dummy_units[slot]
    -- Check base unit
    if dummy_units and dummy_units.base then
        -- Check attachment units
        if dummy_units.attachments then
            -- Iterate attachments
            for _, unit in pairs(dummy_units.attachments) do
                -- Check unit
                if unit and unit_alive(unit) then
                    if extension_manager then
                        extension_manager:unregister_unit(unit)
                    end
                    -- Unlink unit
                    world_unlink_unit(self.world, unit)
                end
            end
            for _, unit in pairs(dummy_units.attachments) do
                -- Check unit
                if unit and unit_alive(unit) then
                    -- Delete unit
                    world_destroy_unit(self.world, unit)
                end
            end
        end
        -- Base unit
        if dummy_units.base and unit_alive(dummy_units.base) then
            if extension_manager then
                extension_manager:unregister_unit(dummy_units.base)
            end
            -- Unlink unit
            world_unlink_unit(self.world, dummy_units.base)
            -- Delete unit
            world_destroy_unit(self.world, dummy_units.base)
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
    self.gear_nodes[slot] = nil
    self.size[slot] = nil
    self.weight[slot] = nil
    self.visible[slot] = nil
    self.position_overwrite[slot] = nil
    self.rotation_overwrite[slot] = nil
    self.scale_overwrite[slot] = nil
    self.slot_units[slot] = nil
end

VisibleEquipmentExtension.cb_on_unit_3p_streaming_complete = function(self, slot)
end

VisibleEquipmentExtension.is_ogryn = function(self)
    local player = self.player
    local profile = self.profile or player and player:profile()
    return profile and profile.archetype.name == "ogryn"
end

VisibleEquipmentExtension.get_breed = function(self)
    return self:is_ogryn() and "ogryn" or "human"
end

VisibleEquipmentExtension.is_gear_node_taken = function(self, slot)
    local slot_gear_node = self.gear_nodes[slot]
    for slot_name, this_slot in pairs(self.equipment) do
        if slot_name ~= slot.name and self.gear_nodes[this_slot] == slot_gear_node then return true end
    end
end

VisibleEquipmentExtension.correct_gear_node = function(self, slot)
    local gear_size_limits = gear_size_limits[self:get_breed()]
    local gear_node = self.gear_nodes[slot]
    local new_gear_node = gear_node
    local is_local_unit = self.is_local_unit
    local size = self.size[slot]

    if not is_local_unit and size >= gear_size_limits.huge then
        -- Huge weapons - get sanitized gear node
        new_gear_node = gear_node_correction.huge_weapons[gear_node] or new_gear_node
    elseif not is_local_unit and size >= gear_size_limits.medium then
        -- Medium Weapons - get sanitized gear node
        new_gear_node = gear_node_correction.medium_weapons[gear_node] or new_gear_node
    end

    if not is_local_unit and self:is_gear_node_taken(slot) then
        -- Gear node taken - get alternative gear node
        new_gear_node = gear_node_correction.alternative[gear_node] or new_gear_node
    end

    -- Backpack
    local has_backpack = self:has_backpack()
    if new_gear_node == "back_left" and has_backpack then new_gear_node = "backpack_left"
    elseif new_gear_node == "back_right" and has_backpack then new_gear_node = "backpack_right"
    elseif new_gear_node == "backpack_left" and not has_backpack then new_gear_node = "back_left"
    elseif new_gear_node == "backpack_right" and not has_backpack then new_gear_node = "back_right"
    end

    self.gear_nodes[slot] = new_gear_node
    if DEBUG and gear_node ~= new_gear_node then mod:echo("Gear node "..gear_node.." changed to "..new_gear_node.." for "..self.item_names[slot]) end

end

VisibleEquipmentExtension.check_attach_points = function(self, slot)
    for _, slot_name in pairs(mod.attachment_slots) do

        local ap_name = "ap_"..slot_name
        local rp_name = "rp_"..slot_name
        if (unit_has_node(self.dummy_units[slot].base, slot_name)) then
            mod:echo(slot_name.." = "..tostring(unit_node(self.dummy_units[slot].base, slot_name)).." in base")
        elseif (unit_has_node(self.dummy_units[slot].base, ap_name)) then
            mod:echo(ap_name.." = "..tostring(unit_node(self.dummy_units[slot].base, ap_name)).." in base")
        elseif (unit_has_node(self.dummy_units[slot].base, rp_name)) then
            mod:echo(rp_name.." = "..tostring(unit_node(self.dummy_units[slot].base, rp_name)).." in base")
        end
        for _, attachment_unit in pairs(self.dummy_units[slot].attachments) do
            if (unit_has_node(attachment_unit, slot_name)) then
                mod:echo(slot_name.." = "..tostring(unit_node(attachment_unit, slot_name)).." in attachment")
            elseif (unit_has_node(attachment_unit, ap_name)) then
                mod:echo(ap_name.." = "..tostring(unit_node(attachment_unit, ap_name)).." in attachment")
            elseif (unit_has_node(attachment_unit, rp_name)) then
                mod:echo(rp_name.." = "..tostring(unit_node(attachment_unit, rp_name)).." in attachment")
            end
        end
        local slot_name_ = slot_name.."_00"
        local ap_name_ = "ap_"..slot_name.."_00"
        local rp_name_ = "rp_"..slot_name.."_00"
        for i = 1, 9, 1 do
            slot_name_ = slot_name.."_0"..i
            ap_name_ = "ap_"..slot_name.."_0"..i
            rp_name_ = "rp_"..slot_name.."_0"..i
            -- mod:echo("checking "..ap_name)
            if (unit_has_node(self.dummy_units[slot].base, slot_name_)) then
                mod:echo(slot_name_.." = "..tostring(unit_node(self.dummy_units[slot].base, slot_name_)).." in base")
            elseif (unit_has_node(self.dummy_units[slot].base, ap_name_)) then
                mod:echo(ap_name_.." = "..tostring(unit_node(self.dummy_units[slot].base, ap_name_)).." in base")
            elseif (unit_has_node(self.dummy_units[slot].base, rp_name_)) then
                mod:echo(rp_name_.." = "..tostring(unit_node(self.dummy_units[slot].base, rp_name_)).." in base")
            end
            for _, attachment_unit in pairs(self.dummy_units[slot].attachments) do
                if (unit_has_node(attachment_unit, slot_name_)) then
                    mod:echo(slot_name_.." = "..tostring(unit_node(attachment_unit, slot_name_)).." in attachment")
                elseif (unit_has_node(attachment_unit, ap_name_)) then
                    mod:echo(ap_name_.." = "..tostring(unit_node(attachment_unit, ap_name_)).." in attachment")
                elseif (unit_has_node(attachment_unit, rp_name_)) then
                    mod:echo(rp_name_.." = "..tostring(unit_node(attachment_unit, rp_name_)).." in attachment")
                end
            end
        end
    end
end

VisibleEquipmentExtension.load_slot = function(self, slot)

    if self.slot_loaded[slot] or self.slot_is_loading[slot] or not self.initialized then
        return
    end

    -- Load
    -- if self.initialized and self:is_weapon_slot(slot) then
    local item = slot.item and slot.item.__master_item or slot.item
        -- if not self.slot_loaded[slot] and not self.slot_is_loading[slot] then
    local item_good = item and (item.item_type == WEAPON_MELEE or item.item_type == WEAPON_RANGED)
    local loaded = slot.item_loaded or slot.attachment_spawn_status == ATTACHMENT_SPAWN_STATUS.fully_spawned

    if not item_good or not loaded then
        return
    end

    -- if item_good and loaded then
    -- self:delete_slot(slot)

    self.slot_is_loading[slot] = true
    -- Item name
    self.item_names[slot] = mod.gear_settings:short_name(item.name)
    -- Item type
    self.item_types[slot] = item.item_type
    -- Animation
    self.step_animation[slot] = self.step_animation[slot] or {}
    -- get_mod("modding_tools"):inspect("step_animation", self.step_animation)
    self.step_animation[slot].time = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_MELEE or ANIM_TIME_RANGED
    self.step_animation[slot].time = self:get_breed() == "ogryn" and self.step_animation[slot].time * OGRYN_ANIM_MULTIPLIER or self.step_animation[slot].time
    self.step_animation[slot].time_wobble = self.time_overwrite or self.item_types[slot] == WEAPON_MELEE and ANIM_TIME_WOBBLE_MELEE or ANIM_TIME_WOBBLE_RANGED
    self.step_animation[slot].time_wobble = self:get_breed() == "ogryn" and self.step_animation[slot].time_wobble * OGRYN_ANIM_MULTIPLIER or self.step_animation[slot].time_wobble
    self.rotate_animation[slot] = vector3_box(vector3_zero())
    self.weapon_template[slot] = WeaponTemplate.weapon_template_from_item(slot.item)
    -- Attach settings
    local attach_settings = self.equipment_component:_attach_settings()
    self.equipment_component:_fill_attach_settings_3p(attach_settings, self.player_unit, slot)
    attach_settings.skip_link_children = true
    -- Spawn dummy weapon
    self.dummy_units[slot] = self.dummy_units[slot] or {}
    -- self.helper_units[slot] = {}
    if not self.dummy_units[slot].base then
        self.dummy_units[slot].base, self.dummy_units[slot].attachments = VisualLoadoutCustomization.spawn_item(slot.item, attach_settings, self.player_unit)
        self.dummy_units[slot].attachments = self.dummy_units[slot].attachments and self.dummy_units[slot].attachments[self.dummy_units[slot].base]
    end
    -- self:check_attach_points(slot)
    -- Get list of units ( Slab shield )
    if self.item_names[slot] == SLAB_SHIELD then
        self.slot_units[slot] = {self.dummy_units[slot].attachments[3], self.dummy_units[slot].attachments[1]}
    elseif self.item_names[slot] == PISTOL_SHIELD then
        self.slot_units[slot] = {self.dummy_units[slot].attachments[5], self.dummy_units[slot].attachments[1]}
    elseif self.item_names[slot] == MAUL_SHIELD then
        self.slot_units[slot] = {self.dummy_units[slot].attachments[5], self.dummy_units[slot].attachments[1]}
    elseif self.item_names[slot] == MAUL_SHIELD2 then
        self.slot_units[slot] = {self.dummy_units[slot].attachments[5], self.dummy_units[slot].attachments[1]}
    else
        self.slot_units[slot] = {self.dummy_units[slot].base}
    end

    self.center_mass_units[slot] = self.center_mass_units[slot] or {}
    for i, unit in pairs(self.slot_units[slot]) do
        self.center_mass_units[slot][i] = Unit.get_child_units(unit)
    end

    -- self.size[slot] = 0
    self:set_weapon_size(slot)

    if not table_contains(no_rnd_attach, self.item_names[slot]) then
        local gear_node = mod.gear_settings:get(slot.item, "gear_node") or not self.is_local_unit and rnd_attach[math_random(1, #rnd_attach)]
        self.gear_nodes[slot] = gear_node
    -- else
    --     self.gear_nodes[slot] = math_random(1) == 1 and "back_left" or "back_right"
    end

    -- Correct gear node
    self:correct_gear_node(slot)

    -- Set gear node
    if not self.is_local_unit and not mod.gear_settings:get(slot.item, "gear_node") then
        mod.gear_settings:set(slot.item, "gear_node", self.gear_nodes[slot])
    end

    -- Performance
    -- local callback = callback(self, "cb_on_unit_3p_streaming_complete", slot)
    -- unit_force_stream_meshes(self.dummy_units[slot].base, callback, true)
    -- if self.dummy_units[slot].attachments then
    --     for _, unit in pairs(self.dummy_units[slot].attachments) do
    --         unit_force_stream_meshes(unit, callback, true)
    --     end
    -- end

    -- Hide bullets
    -- mod.gear_settings:hide_bullets(slot)
    self:hide_bullets(slot)
    -- Equipment data
    local data, sounds_1, sounds_2 = self:equipment_data_by_slot(slot)
    local sounds_3 = SoundEventAliases.sfx_ads_up.events[self.item_names[slot]]
        or SoundEventAliases.sfx_ads_down.events[self.item_names[slot]]
        -- or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
        -- or SoundEventAliases.sfx_equip.events[self.item_names[slot]]
        or SoundEventAliases.sfx_weapon_foley_left_hand_01.events[self.item_names[slot]]
        or SoundEventAliases.sfx_equip.events.default
    local sounds_4 = SoundEventAliases.sfx_weapon_foley_left_hand_02.events[self.item_names[slot]]
        or SoundEventAliases.sfx_weapon_foley_left_hand_01.events[self.item_names[slot]]
        or SoundEventAliases.sfx_ads_down.events[self.item_names[slot]]
        -- or SoundEventAliases.sfx_grab_weapon.events[self.item_names[slot]]
        -- or SoundEventAliases.sfx_equip.events[self.item_names[slot]]
        or SoundEventAliases.sfx_ads_down.events.default
    self.equipment_data[slot] = data
    -- Load sound packages
    self.packages[slot] = self.packages[slot] or {}
    self:load_slot_packages(slot, table_icombine(
        sounds_1 or {},
        sounds_2 or {},
        {sounds_3},
        {sounds_4}
        -- self:get_dependencies(slot)
    ))
    -- Sounds
    self.sounds[slot] = {
        sounds_1,
        sounds_2,
        sounds_3,
        sounds_4,
    }
    -- Custom values
    local anchor = mod.gear_settings:apply_fixes(slot.item, "visible_equipment")
    if anchor then
        self.position_overwrite[slot] = anchor.position
        self.rotation_overwrite[slot] = anchor.rotation
        self.scale_overwrite[slot] = anchor.scale
    end
    -- Init function
    if self.equipment_data[slot].init then
        self.equipment_data[slot].init(self, slot)
    end
    -- Estimate values
    -- self:set_estimated_weapon_data(slot)
    -- self:set_weapon_size(slot)
    -- Trigger equipment animation
    -- self.trigger_wobble = true
    self:trigger_step()
    -- Position equipment
    self:link_equipment()
    self:position_equipment()
    -- Visibility
    self:update_equipment_visibility()
    -- Set flags
    self.slot_loaded[slot] = true
    -- Equipment data
    -- self:update_equipment_data()
    self.slot_is_loading[slot] = nil
    -- end
        -- end
    -- end
end

VisibleEquipmentExtension.play_equipment_sound = function(self, slot, index, allow_crouching, allow_wielded, no_husk)
    -- Play
    local wielded_slot_name = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
    local slot = slot or self.equipment[wielded_slot_name]
    local slot_sounds = slot and self.sounds[slot]
    local index = index or 1
    -- Play sound
    local sound = nil
    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
    local play_sound = (not self.is_local_unit and self.sound ~= OFF) or (self.is_local_unit and (not first_person or self.sound_fp) and self.sound == ALL)
    local slot_valid = slot and (slot.name ~= wielded_slot_name or allow_wielded)
    local allow_crouching = allow_crouching or true
    local crouching = not self:is_crouching() or allow_crouching
    local husk = (no_husk ~= nil and no_husk) or (not self.is_local_unit and not self.spectated)
    if play_sound and slot_valid and crouching and slot_sounds then
        local sounds = index == 1 and slot_sounds[1] or slot_sounds[2]
        local rnd = sounds and math_random(1, #sounds)
        sound = sounds and sounds[rnd] or slot_sounds[3]
        if not self:is_sprinting() then sound = slot_sounds[4] end
        if sound and self.fx_extension then
            self.fx_extension:trigger_wwise_event(sound, husk, true, self.player_unit, 1, "foley_speed", self.step_speed)
        end
    end
end

-- ##### ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐ #####################################################################################
-- ##### ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐ #####################################################################################
-- ##### ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘ #####################################################################################

VisibleEquipmentExtension.release_slot_packages = function(self, slot)
    -- Release
    local count = 0
    if self.packages[slot] then
        for package_name, package_id in pairs(self.packages[slot]) do
            -- Unload package
            managers.package:release(package_id)
            -- Remove package id
            self.packages[slot][package_name] = nil
            -- Count
            count = count + 1
        end
        table.clear(self.packages[slot])
    end
    if DEBUG and count > 0 then mod:console_print("Release "..tostring(count).." packages for "..tostring(self).." "..tostring(slot.name)) end
end

VisibleEquipmentExtension.load_slot_packages = function(self, slot, packages)
    -- Load
    local count = 0
    if type(packages) == "string" then packages = {packages} end
    for _, package_name in pairs(packages) do
        -- Check if loaded
        if not self.packages[slot][package_name] then
            -- Load package
            local ref = REFERENCE.."_"..tostring(self)
            mod:persistent_table(REFERENCE).loaded_packages.visible_equipment[package_name] = true
            self.packages[slot][package_name] = managers.package:load(package_name, ref)
            -- Count
            count = count + 1
        end
    end
    if DEBUG and count > 0 then mod:console_print("Load "..tostring(count).." packages for "..tostring(self).." "..tostring(slot.name)) end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

VisibleEquipmentExtension.on_equip_slot = function(self, slot)
    self:load_slot(slot)
    self:on_attach_point_changed()
end

VisibleEquipmentExtension.on_unequip_slot = function(self, slot)
    self:delete_slot(slot)
    self:on_attach_point_changed()
end

VisibleEquipmentExtension.on_wield_slot = function(self, slot)
    -- Set new wielded slot
    self.wielded_slot = slot
    -- Execute optional wield function
    if self.equipment_data[slot] and self.equipment_data[slot].wield then
        self.equipment_data[slot].wield(self, self.wielded_slot)
    end
    -- Set step interval
    self:set_foot_step_interval()
end

VisibleEquipmentExtension.unwield_slot_by_name = function(self, slot_name)
    for this_slot_name, slot in pairs(self.equipment) do
        if this_slot_name == slot_name then
            self:on_unwield_slot(slot)
            return
        end
    end
end

VisibleEquipmentExtension.on_unwield_slot = function(self, slot)
    -- Execute optional unwield function
    if self.equipment_data[slot] and self.equipment_data[slot].unwield then
        self.equipment_data[slot].unwield(self, self.wielded_slot)
    end
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

VisibleEquipmentExtension.on_attach_point_changed = function(self)
    for slot_name, slot in pairs(self.equipment) do
        if slot and slot.item and self.slot_loaded[slot] and (slot.item.item_type == WEAPON_MELEE or slot.item.item_type == WEAPON_RANGED) and not table_contains(no_rnd_attach, self.item_names[slot]) then
            self.gear_nodes[slot] = mod.gear_settings:get(slot.item, "gear_node")
            self:correct_gear_node(slot)
            self.equipment_data[slot] = self:equipment_data_by_slot(slot)
            self.slot_is_loading[slot] = true
            self.is_linked[slot] = nil
            self:load_slot(slot)
            for i, _ in pairs(self.slot_units[slot]) do
                self:play_equipment_sound(slot, i, true, true, true)
            end
        end
    end
    -- Equipment data
    -- self:update_equipment_data()
    self:link_equipment()
    self:position_equipment()
    -- self:delete_slots()
    -- self:load_slots()
    -- self.trigger_wobble = true
    self:trigger_step()
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

    if not self.initialized then
        return
    end

    -- Position
    self:position_equipment()
    -- Animation
    self:update_animation(dt, t)
    -- Visibility
    self:update_equipment_visibility()

    -- self:update_player_visibility()
end

-- VisibleEquipmentExtension.update_equipment_visibility = function(self)
--     local mod_attachment_slots_always_sheathed = mod.attachment_slots_always_sheathed
--     local mod_attachment_slots_always_unsheathed = mod.attachment_slots_always_unsheathed
--     -- Values
--     local wielded_slot = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
--     local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
--     local spectated = not self.is_local_unit and (not self.spectated or not first_person)
--     local player = self.is_local_unit and not first_person
--     local cutscene = self.ui_profile_spawner or not self.cut_scene
--     -- Iterate slots
--     for slot_name, slot in pairs(self.equipment) do
--         -- Values
--         local slot_not_wielded = slot_name ~= wielded_slot
--         local visible = slot_not_wielded and (player or spectated)
--         -- Check units
--         local dummy_units = self.dummy_units[slot]
--         if dummy_units then
--             local item = slot.item and slot.item.__master_item
--             -- Iterate dummy attachment units
--             for i, unit in pairs(dummy_units.attachments) do
--                 -- Check unit
--                 if unit and unit_alive(unit) then
--                     -- Set equipment visibility
--                     local attachment_slot = unit_get_data(unit, "attachment_slot")
--                     local visible = visible
--                     if table_contains(mod_attachment_slots_always_sheathed, attachment_slot) and not visible then
--                         visible = true
--                     end
--                     if (table_contains(mod_attachment_slots_always_unsheathed, attachment_slot) and visible) then
--                         visible = false
--                     end
--                     visible = (cutscene and visible) or false
--                     unit_set_unit_visibility(unit, visible, false)
--                 end
--             end
--             -- Iterate third person units
--             local attachments_3p = slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p]
--             if attachments_3p then
--                 for i, unit in pairs(attachments_3p) do
--             -- if slot.attachments_3p then
--             --     for i, unit in pairs(slot.attachments_3p) do
--                     -- Check unit
--                     if unit and unit_alive(unit) then
--                         -- Set equipment visibility
--                         local attachment_slot = unit_get_data(unit, "attachment_slot")
--                         if first_person or table_contains(mod_attachment_slots_always_sheathed, attachment_slot) then
--                             unit_set_unit_visibility(unit, false, false)
--                         elseif table_contains(mod_attachment_slots_always_unsheathed, attachment_slot) then
--                             local visible = (cutscene and true) or false
--                             unit_set_unit_visibility(unit, visible, false)
--                         end
--                     end
--                 end
--             end
--             -- Iterate first person units
--             local attachments_1p = slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p]
--             if attachments_1p then
--                 for i, unit in pairs(attachments_1p) do
--             -- if slot.attachments_1p then
--             --     for i, unit in pairs(slot.attachments_1p) do
--                     -- Check unit
--                     if unit and unit_alive(unit) then
--                         -- Set equipment visibility
--                         local attachment_slot = unit_get_data(unit, "attachment_slot")
--                         if not first_person or table_contains(mod_attachment_slots_always_sheathed, attachment_slot) then
--                             unit_set_unit_visibility(unit, false, false)
--                         elseif table_contains(mod_attachment_slots_always_unsheathed, attachment_slot) then
--                             local visible = (cutscene and true) or false
--                             unit_set_unit_visibility(unit, visible, false)
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end
VisibleEquipmentExtension.update_equipment_visibility = function(self)
    local always_sheathed = mod.attachment_slots_always_sheathed
    local always_unsheathed = mod.attachment_slots_always_unsheathed

    local wielded_slot_name = self.wielded_slot and self.wielded_slot.name or SLOT_UNARMED
    local first_person = self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
    local spectated = (not self.is_local_unit) and (not self.spectated or not first_person)
    local player = self.is_local_unit and not first_person
    local cutscene = self.ui_profile_spawner or (not self.cut_scene)

    for slot_name, slot in pairs(self.equipment) do
        local slot_not_wielded = slot_name ~= wielded_slot_name
        local base_visible = slot_not_wielded and (player or spectated)
        local dummy_units = self.dummy_units[slot]

        if dummy_units then
            local function set_unit_visibility(unit)
                if not unit or not unit_alive(unit) then return end

                local attachment_slot = unit_get_data(unit, "attachment_slot")
                local is_always_sheathed = table_contains(always_sheathed, attachment_slot)
                local is_always_unsheathed = table_contains(always_unsheathed, attachment_slot)

                -- Default visible value for dummy units
                local visible = base_visible
                if is_always_sheathed and not visible then
                    visible = true
                end
                if is_always_unsheathed and visible then
                    visible = false
                end
                visible = cutscene and visible or false

                unit_set_unit_visibility(unit, visible, false)
            end

            -- Update dummy attachment units visibility
            for _, unit in pairs(dummy_units.attachments) do
                set_unit_visibility(unit)
            end

            -- Helper for 3p and 1p attachments, since logic is very similar
            local function update_attachments(attachments, first_person_check)
                if not attachments then return end

                for _, unit in pairs(attachments) do
                    if not unit or not unit_alive(unit) then goto continue end

                    local attachment_slot = unit_get_data(unit, "attachment_slot")
                    local is_always_sheathed = table_contains(always_sheathed, attachment_slot)
                    local is_always_unsheathed = table_contains(always_unsheathed, attachment_slot)

                    if first_person_check then
                        -- For 3p units
                        if first_person or is_always_sheathed then
                            unit_set_unit_visibility(unit, false, false)
                        elseif is_always_unsheathed then
                            unit_set_unit_visibility(unit, cutscene, false)
                        end
                    else
                        -- For 1p units
                        if (not first_person) or is_always_sheathed then
                            unit_set_unit_visibility(unit, false, false)
                        elseif is_always_unsheathed then
                            unit_set_unit_visibility(unit, cutscene, false)
                        end
                    end
                    ::continue::
                end
            end

            update_attachments(slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p], true)
            update_attachments(slot.attachments_by_unit_1p and slot.attachments_by_unit_1p[slot.unit_1p], false)
        end
    end
end

-- VisibleEquipmentExtension.update_player_visibility = function(self)
--     if self.player_unit and unit_alive(self.player_unit) then
--         unit_set_unit_visibility(self.player_unit, true, true)
--         -- local equipment_component = mod:get_equipment_component(self.player_unit)
--         -- if equipment_component then
--         if self.wielded_slot then
--             self.equipment_component.update_item_visibility(self.equipment, self.wielded_slot.name, self.player_unit, self.first_person_unit, true)
--             self.equipment_component.update_item_visibility(self.equipment, self.wielded_slot.name, self.player_unit, nil, false)
--             -- unit_set_unit_visibility(self.player_unit, true, true)
--             -- Unit.set_visibility(self.player_unit, true)
--             -- Unit.flow_event(self.player_unit, "lua_visible")
--             -- Unit.set_shader_pass_flag_for_meshes_in_unit_and_childs(self.player_unit, "custom_fov", false)
--             -- if ScriptUnit.has_extension(self.wielded_slot.parent_unit_3p, "player_visibility_system") then
--             --     local player_visibility_extension = ScriptUnit.extension(self.wielded_slot.parent_unit_3p, "player_visibility_system")
--             --     if player_visibility_extension and not player_visibility_extension:visible() then
--             --         player_visibility_extension:show()
--             --     end
--             -- end
--         end
--         -- end
--     end
-- end

VisibleEquipmentExtension.get_vectors_almost_same = function(self, v1, v2, tolerance)
    local tolerance = tolerance or .5
    local v1 = v1 or vector3_zero()
    local v2 = v2 or vector3_zero()
    if math_abs(v1[1] - v2[1]) < tolerance and math_abs(v1[2] - v2[2]) < tolerance and math_abs(v1[3] - v2[3]) < tolerance then
        return true
    end
end

VisibleEquipmentExtension.update_animation = function(self, dt, t)
    local locomotion = (self.locomotion_ext and self.locomotion_ext:move_speed() or 0)
    self.step_speed = math.max(math.abs(locomotion), 1)
    local wobble_was_triggered = self.trigger_wobble
    self.trigger_wobble = nil
    local rotation_unit = not self.is_in_hub and self.first_person_unit or self.player_unit
    local parent_rotation = quaternion_to_vector(unit_world_rotation(rotation_unit, 1))
    local last_player_rotation = self.last_player_rotation and vector3_unbox(self.last_player_rotation) or parent_rotation
    local rotation_diff = last_player_rotation - parent_rotation
    self.last_player_rotation:store(parent_rotation)
    -- Process animation part step
    for slot_name, slot in pairs(self.equipment) do
        local slot_units = self.slot_units[slot]
        local slot_gear_node = self.gear_nodes[slot]
        -- Check slot
        if self.slot_loaded[slot] then
            -- Weight
            local weight = self.weight[slot]
            local weight_factor = weight and WEIGHT_FACTORS[weight] or .33
            -- Get data
            local data = self.equipment_data[slot]
            local step_animation = self.step_animation[slot]
            -- Animation
            if step_animation then
                -- Lengths
                step_animation.length = self:get_foot_step_interval()
                step_animation.step_length = step_animation.length * .4
                step_animation.back_length = step_animation.length * .6
                step_animation.wobble_length = step_animation.length * 6
                -- Trigger
                if self.wobble[slot] then
                    if locomotion <= 0 then
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    elseif step_animation.state ~= STEP_STATE and step_animation.state ~= STEP_STATE_BACK then
                        if slot.name == SLOT_SECONDARY then
                            step_animation.state = STEP_STATE
                            step_animation.end_time = t + step_animation.step_length * 1
                        else
                            step_animation.state = STEP_STATE
                            step_animation.end_time = t + step_animation.step_length * 2
                        end
                    end
                    self.wobble[slot] = nil
                end
                -- Values
                local get_values = function(i, speed)
                    local rotation = slot_units[i] and unit_local_rotation(slot_units[i], 1) or vector3_zero()
                    local mat = quaternion_matrix4x4(rotation)
                    -- local default_position = vector3_unbox(data.position[i])
                    -- local position_move = matrix4x4_transform(mat, vector3_unbox(data.step_move[i])) * (speed or self.step_speed) * (slot_gear_node and .5 or 1)
                    -- local default_rotation = vector3_unbox(data.rotation[i])
                    -- local rotation_move = matrix4x4_transform(mat, vector3_unbox(data.step_rotation[i])) * (speed or self.step_speed) * (slot_gear_node and .5 or 1)
                    -- return default_position, position_move, default_rotation, rotation_move
                    return vector3_unbox(data.position[i]), matrix4x4_transform(mat, vector3_unbox(data.step_move[i])) * (speed or self.step_speed) * (slot_gear_node and .5 or 1), vector3_unbox(data.rotation[i]), matrix4x4_transform(mat, vector3_unbox(data.step_rotation[i])) * (speed or self.step_speed) * (slot_gear_node and .5 or 1)
                end
                -- Start step animation
                if not step_animation.state then
                    if locomotion > 0 then
                        step_animation.state = STEP_STATE
                        step_animation.end_time = t + step_animation.step_length
                    elseif step_animation.end_time then
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    end
                    -- Set position
                    for i, unit in pairs(slot_units) do
                        -- Set default position
                        if unit and unit_alive(unit) then
                            -- Set position
                            -- local default_position = vector3_unbox(data.position[i])
                            -- unit_set_local_position(unit, 1, default_position)
                            unit_set_local_position(unit, 1, vector3_unbox(data.position[i]))
                            -- Set rotation
                            -- local rotation = quaternion_from_vector(vector3_unbox(data.rotation[i]))
                            -- unit_set_local_rotation(unit, 1, rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_unbox(data.rotation[i])))
                        end
                    end
                    
                -- STEP
                elseif step_animation.state == STEP_STATE and t < step_animation.end_time then
                    if locomotion == 0 then
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    end
                    -- Lerp values
                    for i, unit in pairs(slot_units) do
                        local progress = (step_animation.end_time - t) / step_animation.step_length
                        local anim_progress = math.ease_sine(1 - progress)
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- local lerp_position = vector3_lerp(default_position, default_position + position_move, anim_progress)
                            -- unit_set_local_position(unit, 1, lerp_position)
                            unit_set_local_position(unit, 1, vector3_lerp(default_position, default_position + position_move, anim_progress))
                            -- Set rotation
                            -- local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation, default_rotation + rotation_move, anim_progress))
                            -- unit_set_local_rotation(unit, 1, lerp_rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_lerp(default_rotation, default_rotation + rotation_move, anim_progress)))
                        end
                    end

                -- STEP end
                elseif step_animation.state == STEP_STATE and t >= step_animation.end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        step_animation.state = STEP_STATE_BACK
                        step_animation.end_time = t + step_animation.back_length
                    else
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    end
                    for i, unit in pairs(slot_units) do
                        -- Set move position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            unit_set_local_position(unit, 1, default_position + position_move)
                            -- Set rotation
                            -- local lerp_rotation = quaternion_from_vector(default_rotation + rotation_move)
                            -- unit_set_local_rotation(unit, 1, lerp_rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(default_rotation + rotation_move))
                            -- Play sound
                            if slot.name == SLOT_SECONDARY then
                                self:play_equipment_sound(slot, i)
                            end
                        end
                    end

                -- STEP BACK
                elseif step_animation.state == STEP_STATE_BACK and t < step_animation.end_time then
                    if locomotion == 0 then
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    end
                    -- Lerp values
                    for i, unit in pairs(slot_units) do
                        local progress = (step_animation.end_time - t) / step_animation.back_length
                        local anim_progress = math.ease_sine(1 - progress)
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- local lerp_position = vector3_lerp(default_position + position_move, default_position, anim_progress)
                            -- unit_set_local_position(unit, 1, lerp_position)
                            unit_set_local_position(unit, 1, vector3_lerp(default_position + position_move, default_position, anim_progress))
                            -- Set rotation
                            -- local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress))
                            -- unit_set_local_rotation(unit, 1, lerp_rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress)))
                        end
                    end

                -- STEP BACK end
                elseif step_animation.state == STEP_STATE_BACK and t >= step_animation.end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        step_animation.state = STEP_STATE
                        step_animation.end_time = t + step_animation.step_length
                    else
                        step_animation.state = STEP_WOBBLE
                        step_animation.end_time = t + step_animation.wobble_length
                    end
                    for i, unit in pairs(slot_units) do
                        -- Set move position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            -- local lerp_rotation = quaternion_from_vector(default_rotation)
                            -- unit_set_local_rotation(unit, 1, lerp_rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(default_rotation))
                            -- Play sound
                            if slot.name == SLOT_PRIMARY then
                                self:play_equipment_sound(slot, i)
                            end
                        end
                    end

                -- WOBBLE
                elseif step_animation.state == STEP_WOBBLE and t < step_animation.end_time then
                    -- Start part wobble
                    if locomotion > 0 then
                        if slot.name == SLOT_SECONDARY then
                            step_animation.state = STEP_STATE
                            step_animation.end_time = t + step_animation.step_length * 1
                        else
                            step_animation.state = STEP_STATE
                            step_animation.end_time = t + step_animation.step_length * 2
                        end
                    end
                    -- Lerp values
                    local progress = (step_animation.end_time - t) / step_animation.wobble_length
                    local anim_progress = math_ease_out_elastic(1 - progress)
                    for i, unit in pairs(slot_units) do
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            -- local lerp_position = vector3_lerp(default_position + position_move, default_position, anim_progress)
                            -- unit_set_local_position(unit, 1, lerp_position)
                            unit_set_local_position(unit, 1, vector3_lerp(default_position + position_move, default_position, anim_progress))
                            -- Set rotation
                            -- local lerp_rotation = quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress))
                            -- unit_set_local_rotation(unit, 1, lerp_rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_lerp(default_rotation + rotation_move, default_rotation, anim_progress)))
                        end
                    end

                -- WOBBLE end
                elseif step_animation.state == STEP_WOBBLE and t >= step_animation.end_time then
                    -- End animation
                    step_animation.state = nil
                    step_animation.end_time = nil
                    for i, unit in pairs(slot_units) do
                        -- Set default position and rotation
                        if unit and unit_alive(unit) then
                            local default_position, position_move, default_rotation, rotation_move = get_values(i)
                            -- Set position
                            unit_set_local_position(unit, 1, default_position)
                            -- Set rotation
                            -- local rotation = quaternion_from_vector(default_rotation)
                            -- unit_set_local_rotation(unit, 1, rotation)
                            unit_set_local_rotation(unit, 1, quaternion_from_vector(default_rotation))
                        end
                    end
                end
            end
            -- Rotation
            for i, unit in pairs(slot_units) do
                -- Set default position and rotation
                if unit and unit_alive(unit) then
                    -- Get angle difference
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
                    -- Calculate momentum_drag 
                    local momentum_drag = vector3(math.abs(angle) * .5, angle, -angle)
                    if slot.name == SLOT_SECONDARY then
                        momentum_drag = vector3(angle, -angle, -math.abs(angle) * .5)
                    end
                    -- Animate momentum drag
                    local saved_current = self.rotate_animation[slot]
                    local current_rotation = saved_current and vector3_unbox(saved_current)
                    local current = current_rotation or vector3_zero()
                    -- local mat = quaternion_matrix4x4(rotation)
                    -- local rotated_pos = matrix4x4_transform(mat, momentum_drag)
                    local rotated_pos = matrix4x4_transform(quaternion_matrix4x4(rotation), momentum_drag)
                    -- Check almost same
                    if not self:get_vectors_almost_same(rotated_pos, vector3_zero(), .1) then
                        current = current + rotated_pos
                    end
                    -- Accumilate
                    if slot.name == SLOT_SECONDARY then
                        current = current - current * (dt * 8)
                    else
                        current = current - current * (dt * 6)
                    end
                    -- Impose limits
                    for i = 1, 3 do
                        if slot.name == SLOT_SECONDARY then
                            current[i] = math.clamp(current[i], -15, 10)
                        else
                            current[i] = math.clamp(current[i], -10, 15)
                        end
                    end
                    -- Set weapon rotation
                    -- local new_euler_rotation = quaternion_from_vector(current)
                    -- local new_rotation = Quaternion.multiply(rotation, new_euler_rotation)
                    local new_rotation = Quaternion.multiply(rotation, quaternion_from_vector(current))
                    unit_set_local_rotation(unit, 1, new_rotation)
                    self.rotate_animation[slot]:store(current)
                end
            end
        end
    end
end
-- VisibleEquipmentExtension.update_animation = function(self, dt, t)
-- 	local locomotion = (self.locomotion_ext and self.locomotion_ext:move_speed() or 0)
-- 	self.step_speed = math.max(math.abs(locomotion), 1)

-- 	self.trigger_wobble = nil

-- 	local rotation_unit = not self.is_in_hub and self.first_person_unit or self.player_unit
-- 	local parent_rotation = quaternion_to_vector(unit_world_rotation(rotation_unit, 1))
-- 	local last_rotation = self.last_player_rotation and vector3_unbox(self.last_player_rotation) or parent_rotation
-- 	local rotation_diff = last_rotation - parent_rotation
-- 	self.last_player_rotation:store(parent_rotation)

-- 	local step_speed = self.step_speed
-- 	local math_abs, math_clamp = math.abs, math.clamp

-- 	for _, slot in pairs(self.equipment) do
-- 		if self.slot_loaded[slot] then
-- 			local slot_units = self.slot_units[slot]
-- 			local data = self.equipment_data[slot]
-- 			local step_anim = self.step_animation[slot]
-- 			local gear_node = self.gear_nodes[slot]
-- 			local weight = self.weight[slot]
-- 			local weight_factor = weight and WEIGHT_FACTORS[weight] or 0.33
-- 			local is_secondary = slot.name == SLOT_SECONDARY

-- 			if step_anim then
-- 				local length = self:get_foot_step_interval()
-- 				step_anim.length = length
-- 				step_anim.step_length = length * 0.4
-- 				step_anim.back_length = length * 0.6
-- 				step_anim.wobble_length = length * 6

-- 				if self.wobble[slot] then
-- 					if locomotion <= 0 then
-- 						step_anim.state = STEP_WOBBLE
-- 						step_anim.end_time = t + step_anim.wobble_length
-- 					elseif step_anim.state ~= STEP_STATE and step_anim.state ~= STEP_STATE_BACK then
-- 						step_anim.state = STEP_STATE
-- 						step_anim.end_time = t + step_anim.step_length * (is_secondary and 1 or 2)
-- 					end
-- 					self.wobble[slot] = nil
-- 				end

-- 				local function get_values(i)
-- 					local unit = slot_units[i]
-- 					if not unit then return vector3_zero(), vector3_zero(), vector3_zero(), vector3_zero() end

-- 					local rot = unit_local_rotation(unit, 1)
-- 					local mat = quaternion_matrix4x4(rot)

-- 					local base_pos = vector3_unbox(data.position[i])
-- 					local base_rot = vector3_unbox(data.rotation[i])
-- 					local move_factor = (gear_node and 0.5 or 1) * step_speed

-- 					local move_pos = matrix4x4_transform(mat, vector3_unbox(data.step_move[i])) * move_factor
-- 					local move_rot = matrix4x4_transform(mat, vector3_unbox(data.step_rotation[i])) * move_factor

-- 					return base_pos, move_pos, base_rot, move_rot
-- 				end

-- 				local function animate_units(anim_progress, lerp_from_fn, lerp_to_fn)
-- 					for i, unit in pairs(slot_units) do
-- 						if unit and unit_alive(unit) then
-- 							local base_pos, move_pos, base_rot, move_rot = get_values(i)
-- 							unit_set_local_position(unit, 1, vector3_lerp(lerp_from_fn(base_pos, move_pos), lerp_to_fn(base_pos, move_pos), anim_progress))
-- 							unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_lerp(lerp_from_fn(base_rot, move_rot), lerp_to_fn(base_rot, move_rot), anim_progress)))
-- 						end
-- 					end
-- 				end

-- 				if not step_anim.state then
-- 					step_anim.state = locomotion > 0 and STEP_STATE or STEP_WOBBLE
-- 					step_anim.end_time = t + (locomotion > 0 and step_anim.step_length or step_anim.wobble_length)

-- 					for i, unit in pairs(slot_units) do
-- 						if unit and unit_alive(unit) then
-- 							unit_set_local_position(unit, 1, vector3_unbox(data.position[i]))
-- 							unit_set_local_rotation(unit, 1, quaternion_from_vector(vector3_unbox(data.rotation[i])))
-- 						end
-- 					end
-- 				elseif step_anim.state == STEP_STATE and t < step_anim.end_time then
-- 					if locomotion == 0 then
-- 						step_anim.state = STEP_WOBBLE
-- 						step_anim.end_time = t + step_anim.wobble_length
-- 					end
-- 					local progress = (step_anim.end_time - t) / step_anim.step_length
-- 					animate_units(math.ease_sine(1 - progress), function(a, b) return a end, function(a, b) return a + b end)

-- 				elseif step_anim.state == STEP_STATE and t >= step_anim.end_time then
-- 					step_anim.state = locomotion > 0 and STEP_STATE_BACK or STEP_WOBBLE
-- 					step_anim.end_time = t + (locomotion > 0 and step_anim.back_length or step_anim.wobble_length)
-- 					for i, unit in pairs(slot_units) do
-- 						if unit and unit_alive(unit) then
-- 							local base_pos, move_pos, base_rot, move_rot = get_values(i)
-- 							unit_set_local_position(unit, 1, base_pos + move_pos)
-- 							unit_set_local_rotation(unit, 1, quaternion_from_vector(base_rot + move_rot))
-- 							if is_secondary then self:play_equipment_sound(slot, i) end
-- 						end
-- 					end

-- 				elseif step_anim.state == STEP_STATE_BACK and t < step_anim.end_time then
-- 					if locomotion == 0 then
-- 						step_anim.state = STEP_WOBBLE
-- 						step_anim.end_time = t + step_anim.wobble_length
-- 					end
-- 					local progress = (step_anim.end_time - t) / step_anim.back_length
-- 					animate_units(math.ease_sine(1 - progress), function(a, b) return a + b end, function(a, b) return a end)

-- 				elseif step_anim.state == STEP_STATE_BACK and t >= step_anim.end_time then
-- 					step_anim.state = locomotion > 0 and STEP_STATE or STEP_WOBBLE
-- 					step_anim.end_time = t + (locomotion > 0 and step_anim.step_length or step_anim.wobble_length)
-- 					for i, unit in pairs(slot_units) do
-- 						if unit and unit_alive(unit) then
-- 							local base_pos, _, base_rot = get_values(i)
-- 							unit_set_local_position(unit, 1, base_pos)
-- 							unit_set_local_rotation(unit, 1, quaternion_from_vector(base_rot))
-- 							if not is_secondary then self:play_equipment_sound(slot, i) end
-- 						end
-- 					end

-- 				elseif step_anim.state == STEP_WOBBLE and t < step_anim.end_time then
-- 					if locomotion > 0 then
-- 						step_anim.state = STEP_STATE
-- 						step_anim.end_time = t + step_anim.step_length * (is_secondary and 1 or 2)
-- 					end
-- 					local progress = (step_anim.end_time - t) / step_anim.wobble_length
-- 					animate_units(math_ease_out_elastic(1 - progress), function(a, b) return a + b end, function(a, b) return a end)

-- 				elseif step_anim.state == STEP_WOBBLE and t >= step_anim.end_time then
-- 					step_anim.state = nil
-- 					step_anim.end_time = nil
-- 					for i, unit in pairs(slot_units) do
-- 						if unit and unit_alive(unit) then
-- 							local base_pos, _, base_rot = get_values(i)
-- 							unit_set_local_position(unit, 1, base_pos)
-- 							unit_set_local_rotation(unit, 1, quaternion_from_vector(base_rot))
-- 						end
-- 					end
-- 				end
-- 			end

-- 			for i, unit in pairs(slot_units) do
-- 				if unit and unit_alive(unit) then
-- 					local rot = unit_local_rotation(unit, 1)
-- 					local angle = rotation_diff[3] % 360
-- 					angle = (angle + 360) % 360
-- 					if angle > 180 then angle = angle - 360 end
-- 					angle = -angle * weight_factor
-- 					local drag = is_secondary and vector3(angle, -angle, -math_abs(angle) * 0.5) or vector3(math_abs(angle) * 0.5, angle, -angle)

-- 					local current = self.rotate_animation[slot] and vector3_unbox(self.rotate_animation[slot]) or vector3_zero()
-- 					current = current + matrix4x4_transform(quaternion_matrix4x4(rot), drag)

-- 					current = current - current * (dt * (is_secondary and 8 or 6))
-- 					for j = 1, 3 do
-- 						current[j] = math_clamp(current[j], is_secondary and -15 or -10, is_secondary and 10 or 15)
-- 					end

-- 					unit_set_local_rotation(unit, 1, Quaternion.multiply(rot, quaternion_from_vector(current)))
-- 					self.rotate_animation[slot]:store(current)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

return VisibleEquipmentExtension
