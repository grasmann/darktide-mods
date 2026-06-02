local mod = get_mod("pure_cinema")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local SurfaceMaterialSettings = mod:original_require("scripts/settings/surface_material_settings")
local BreedShootTemplates = mod:original_require("scripts/settings/breed/breed_shoot_templates")
local BreedCombatRanges = mod:original_require("scripts/settings/breed/breed_combat_ranges")
local MinionVisualLoadout = mod:original_require("scripts/utilities/minion_visual_loadout")
local EffectTemplates = mod:original_require("scripts/settings/fx/effect_templates")
local ImpactEffect = mod:original_require("scripts/utilities/attack/impact_effect")
local LineEffects = mod:original_require("scripts/settings/effects/line_effects")
local HitScan = mod:original_require("scripts/utilities/attack/hit_scan")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local unit = Unit
	local math = math
	local type = type
	local pairs = pairs
	local actor = Actor
	local CLASS = CLASS
	local class = class
	local world = World
	local table = table
	local vector3 = Vector3
	local tostring = tostring
	local managers = Managers
	local math_pow = math.pow
	local geometry = Geometry
	local math_max = math.max
	local matrix4x4 = Matrix4x4
	local actor_unit = actor.unit
	local vector3_up = vector3.up
	local table_size = table.size
	local unit_light = unit.light
	local quaternion = Quaternion
	local unit_actor = unit.actor
	local unit_alive = unit.alive
	local vector3_box = Vector3Box
	local script_unit = ScriptUnit
	local wwise_world = WwiseWorld
	local table_clone = table.clone
	local math_random = math.random
	local table_clear = table.clear
	local application = Application
	local physics_world = PhysicsWorld
	local vector3_right = vector3.right
	local table_contains = table.contains
	local vector3_length = vector3.length
	local vector3_unbox = Vector3Box.unbox
	local unit_num_lights = unit.num_lights
	local unit_world_pose = unit.world_pose
	local quaternion_look = quaternion.look
	local unit_num_meshes = unit.num_meshes
	local vector3_forward = vector3.forward
	local unit_flow_event = unit.flow_event
	local DEDICATED_SERVER = DEDICATED_SERVER
	local vector3_normalize = vector3.normalize
	local world_unlink_unit = world.unlink_unit
	local unit_create_actor = unit.create_actor
	local quaternion_rotate = quaternion.rotate
	local quaternion_forward = quaternion.forward
	local actor_add_velocity = actor.add_velocity
	local quaternion_multiply = quaternion.multiply
	local unit_world_position = unit.world_position
	local unit_world_rotation = unit.world_rotation
	local unit_local_rotation = unit.local_rotation
	local unit_animation_event = unit.animation_event
	local unit_set_local_scale = unit.set_local_scale
	local table_clone_instance = table.clone_instance
	local unit_get_child_units = unit.get_child_units
	local script_unit_extension = script_unit.extension
	local matrix4x4_translation = matrix4x4.translation
	local world_create_particles = world.create_particles
	local unit_set_local_rotation = unit.set_local_rotation
	local unit_set_local_position = unit.set_local_position
	local unit_set_unit_visibility = unit.set_unit_visibility
	local unit_set_mesh_visibility = unit.set_mesh_visibility
	local script_unit_add_extension = script_unit.add_extension
	local script_unit_has_extension = script_unit.has_extension
	local actor_set_collision_filter = actor.set_collision_filter
	local actor_add_angular_velocity = actor.add_angular_velocity
	local application_time_since_query = application.time_since_query
	local script_unit_remove_extension = script_unit.remove_extension
	local world_set_particles_variable = world.set_particles_variable
	local wwise_world_make_auto_source = wwise_world.make_auto_source
	local world_find_particles_variable = world.find_particles_variable
	local geometry_closest_point_on_line = geometry.closest_point_on_line
	local physics_world_immediate_overlap = physics_world.immediate_overlap
	local unit_set_animation_state_machine = unit.set_animation_state_machine
	local wwise_world_destroy_manual_source = wwise_world.destroy_manual_source
	local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
	local application_query_performance_counter = application.query_performance_counter
-- #endregion

-- ##### ┌┬┐┬┌─┐┌─┐┬ ┬┌─┐┬─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ########################################################
-- #####  │││└─┐│  ├─┤├─┤├┬┘│ ┬├┤   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ########################################################
-- ##### ─┴┘┴└─┘└─┘┴ ┴┴ ┴┴└─└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ########################################################

local DischargeExtension = class("DischargeExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local SLOT_MELEE_WEAPON = "slot_melee_weapon"
local SLOT_RANGED_WEAPON = "slot_ranged_weapon"
local PROCESS_SLOTS = {SLOT_MELEE_WEAPON, SLOT_RANGED_WEAPON}

local REFERENCE = "pure_cinema"
local ORPHANED_POLICY = "stop"
local MAX_EMITTERS = 100
local DROP_CHECK = .2
local DROP_TIME = 1.2
local DROP_DELAY = 1
local DISCHARGE_FREQUENCY = .2
local MAX_SUPPRESS_VALUE_SPREAD = 60
local SAFETY_SOUND_LENGTH = 20

local _process_hits = {}
local INDEX_POSITION = 1
local INDEX_DISTANCE = 2
local INDEX_NORMAL = 3
local INDEX_ACTOR = 4
local surface_hit_types = SurfaceMaterialSettings.hit_types

local pt = mod:pt()

local _effect_templates = {
	-- Small
	renegade_rifleman = mod.settings.effect_templates.laser_gunner,
	renegade_assault = mod.settings.effect_templates.laser_gunner,
	cultist_assault = mod.settings.effect_templates.gunner,
	-- Gunner
	cultist_gunner = mod.settings.effect_templates.gunner,
	renegade_gunner = mod.settings.effect_templates.laser_gunner,
	renegade_plasma_gunner = mod.settings.effect_templates.plasma,
	-- Shotgun
	cultist_shocktrooper = mod.settings.effect_templates.shotgun,
	renegade_shocktrooper = mod.settings.effect_templates.shotgun,
	-- Flamer
	renegade_flamer = mod.settings.effect_templates.renegade_flamer,
	cultist_flamer = mod.settings.effect_templates.cultist_flamer,
	-- Sniper
	renegade_sniper = mod.settings.effect_templates.sniper,
	-- Melee
	renegade_executor = mod.settings.effect_templates.chainaxe,
	-- Ogryn
	chaos_ogryn_gunner = mod.settings.effect_templates.heavy_stubber,
	-- Weapons
	-- ["content/items/weapons/minions/ranged/chaos_cultist_heavy_stubber_02_custom"] = mod.settings.effect_templates.heavy_stubber,
}

local _shoot_templates = {
	-- Gunner
	cultist_gunner = BreedShootTemplates.cultist_gunner_shoot_spray_n_pray,
}

local _time_multiplier = {
	renegade_gunner = 3,
	cultist_gunner = 3,
	chaos_ogryn_gunner = 3,
	renegade_executor = 5,
}

local _data_template = {
	unit = nil,
	target_unit = nil,
}

local IMPACT_FX_DATA = {
	will_be_predicted = false,
	source_parameters = {},
}

local _line_effects = {
	-- Small
	renegade_rifleman = LineEffects.renegade_lasbeam,
	renegade_assault = LineEffects.renegade_assault_lasbeam,
	cultist_assault = LineEffects.cultist_autogun_bullet,
	-- Gunner
	cultist_gunner = LineEffects.cultist_autogun_bullet,
	renegade_gunner = LineEffects.renegade_gunner_lasbeam,
	renegade_plasma_gunner = LineEffects.renegade_captain_plasma_beam,
	-- Shotgun
	cultist_shocktrooper = LineEffects.renegade_pellet,
	renegade_shocktrooper = LineEffects.renegade_pellet,
	-- Sniper
	renegade_sniper = LineEffects.renegade_sniper_lasbeam,
	-- Ogryn
	chaos_ogryn_gunner = LineEffects.renegade_heavy_stubber_bullet,
}

mod:register_data("discharge_weapon_units")
mod:register_data("discharge_weapons")
mod:register_data("discharge_sounds", 4000, {
	unit = nil,
	source_id = nil,
	wwise_world = nil,
	time = nil,
})
mod:register_data("discharge_items")
mod:register_data("discharge_data")

mod.safety_update_discharge_sounds = function(self)

	local data = self:data_table("discharge_sounds")
	
	local t = mod:time()

	for _, sound_data in pairs(data) do

		if sound_data.unit and (not unit_alive(sound_data.unit) or t - sound_data.time > SAFETY_SOUND_LENGTH) then
			
			if sound_data.stop_sound then
				wwise_world_trigger_resource_event(sound_data.wwise_world, sound_data.stop_sound, sound_data.source_id)
			end

			wwise_world_destroy_manual_source(sound_data.wwise_world, sound_data.source_id)
			
			self:release_data("discharge_sounds", sound_data)

		end

	end

end

mod.register_discharge_sound = function(self, unit, source_id, wwise_world, stop_sound, time)

	local new_data = self:request_data("discharge_sounds")

	new_data.unit = unit
	new_data.source_id = source_id
	new_data.wwise_world = wwise_world
	new_data.stop_sound = stop_sound
	new_data.time = time

end

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

DischargeExtension.init = function(self, extension_init_context, unit, extension_init_data)
	-- Finish
	self:finish_discharge()
	-- Data
	self.unit = unit
	self.world = extension_init_context.world
	self.wwise_world = mod:wwise_world(self.world)
	self.physics_world = mod:physics_world(self.world)
	self.init_data = extension_init_data
	self.game_session = extension_init_data.game_session or managers.state.game_session:game_session()
	-- Extensions
	self.visual_loadout_extension = extension_init_data.visual_loadout_extension
	-- Settings
	self.wielded_slot_name = extension_init_data.wielded_slot_name
	self.state = "none"
	-- local t1 = application_query_performance_counter()
	-- for i = 1, 1000 do
	-- 	self.weapon_units = nil
	-- 	self.weapons = nil
	-- 	self.items = nil
	-- 	self.data = nil
	-- 	self.weapon_units = {}
	-- 	self.weapons = {}
	-- 	self.items = {}
	-- 	self.data = {}
	-- end
	-- local time1 = application_time_since_query(t1)
	-- local t2 = application_query_performance_counter()
	-- for i = 1, 1000 do
	self.weapon_units = mod:request_data("discharge_weapon_units")
	self.weapons = mod:request_data("discharge_weapons")
	self.items = mod:request_data("discharge_items")
	self.data = mod:request_data("discharge_data")
	-- 	-- Release data
	-- 	mod:release_data("discharge_weapon_units", self._weapon_units)
	-- 	mod:release_data("discharge_weapons", self._weapons)
	-- 	mod:release_data("discharge_items", self._items)
	-- 	mod:release_data("discharge_data", self._data)
	-- end
	-- local time2 = application_time_since_query(t2)
	-- mod:print("################################")
	-- mod:print("create tables: "..tostring(time1))
	-- mod:print("request data: "..tostring(time2))
	-- Register Events
	managers.event:register(self, "pure_cinema_settings_changed", "on_settings_changed")
	-- Set initial values
	self:on_settings_changed()
end

DischargeExtension.extensions_ready = function(self)
	-- Finish
	self:finish_discharge()
	-- Get extensions
	self.unit_data_extension = script_unit_extension(self.unit, "unit_data_system")
	-- Fetch data
	self:fetch_data()
end

DischargeExtension.delete = function(self)
	-- Finish
	self:finish_discharge()
	-- Delete tables
	-- local t1 = application_query_performance_counter()
	-- self.weapon_units = nil
	-- self.weapons = nil
	-- self.items = nil
	-- self.data = nil
	-- local time1 = application_time_since_query(t1)
	-- local t2 = application_query_performance_counter()
	-- Release data
	mod:release_data("discharge_weapon_units", self.weapon_units)
	mod:release_data("discharge_weapons", self.weapons)
	mod:release_data("discharge_items", self.items)
	mod:release_data("discharge_data", self.data)
	-- local time2 = application_time_since_query(t2)
	-- mod:print("################################")
	-- mod:print("deleting tables: "..tostring(time1))
	-- mod:print("release data: "..tostring(time2))
	-- Unregister Events
	managers.event:unregister(self, "pure_cinema_settings_changed")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

DischargeExtension.on_settings_changed = function(self)
	self.collision_check = mod:get("weapon_discharge_collision_check")
	self.discharge_chance = mod:get("discharge_on_death_chance")
end

DischargeExtension.on_wield = function(self, wielded_slot_name)

	self.wielded_slot_name = wielded_slot_name

	local slot_weapon = self.weapons[wielded_slot_name]

	if slot_weapon then

		-- if slot_weapon.state_machine then
		--     unit_set_animation_state_machine(self._unit, slot_weapon.state_machine)
		-- end

		-- if slot_weapon.animation_events and slot_weapon.animation_events.default then
		--     unit_animation_event(self._unit, slot_weapon.animation_events.default)
		-- end

	end

end

DischargeExtension.on_drop_slot = function(self, slot_name)

	local slots = self.visual_loadout_extension._slots
	local slot_data = slots[slot_name]
	local slot_state = slot_data.state

	local wielded_slot_name = self:wielded_slot()
	local valid_slot = table_contains(PROCESS_SLOTS, slot_name) and slot_state == "wielded"

	if valid_slot and self:trigger_name() == "death" then
		self:start_discharge()
		self.drop_weapon_delayed = true
		return
	end

	self:drop_weapon(slot_name)

	if valid_slot and self:trigger_name() == "drop" then
		self:start_discharge()
		return
	end

	self:apply_drop_push(slot_name)

	if valid_slot and self:trigger_name() == "land" then
		self.state = "drop"
	end

end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

DischargeExtension.apply_drop_push = function(self, optional_slot_name, optional_multiplier)

	local multiplier = optional_multiplier or 1
	local slot_name = optional_slot_name or self:wielded_slot()

	local slots = self.visual_loadout_extension._slots
	local slot_data = slots[slot_name]
	local slot_state = slot_data.state

	local item_unit = slot_data.unit

	if slot_state == "wielded" then
		local random_radius = 0.25
		local x = math_random() * 2 - 1
		local y = math_random() * 2 - 1
		local random_offset = vector3(x * random_radius, y * random_radius, 0)
		local direction = vector3_up() + random_offset
		local speed = 5
		local velocity_vector = direction * speed

		actor_add_velocity(actor, velocity_vector)

		local rotation = unit_local_rotation(item_unit, 1)
		local min_angular_x, max_angular_x, max_angular_y, max_angular_z = 3, 6, 0.25, 0.25
		local torque_vector = vector3(math_max(math_random() * max_angular_x, min_angular_x), math_random() * max_angular_y, math_random() * max_angular_z) * multiplier

		torque_vector = quaternion_rotate(rotation, torque_vector)

		actor_add_angular_velocity(actor, torque_vector)
	end

end

DischargeExtension.death_event = function(self)

	for slot_name, slot_data in pairs(self.visual_loadout_extension._slots) do
		local item_unit = slot_data.unit

		if item_unit then
			unit_flow_event(item_unit, "on_death")
		end

		if slot_data.attachments then
			for _, attachment in pairs(slot_data.attachments) do
				unit_flow_event(attachment, "on_death")
			end
		end
	end

end

DischargeExtension.drop_weapon = function(self, optional_slot_name)

	local slot_name = optional_slot_name or self:wielded_slot()

	local slots = self.visual_loadout_extension._slots
	local slot_data = slots[slot_name]
	local slot_state = slot_data.state

	if self.visual_loadout_extension._wielded_slot_name == slot_name then
		self.visual_loadout_extension._wielded_slot_name = nil
	end

	if not DEDICATED_SERVER then
		local has_outline_system = managers.state.extension:has_system("outline_system")

		if has_outline_system then
			local outline_system = managers.state.extension:system("outline_system")

			outline_system:dropping_loadout_unit(self.unit, slot_data.unit)
		end
	end

	local world = self.world
	local item_unit = slot_data.unit
	local item_data = slot_data.item_data
	local reset_scene_graph = item_data.reset_scene_graph_on_unlink

	world_unlink_unit(world, item_unit, reset_scene_graph)

	local actor = unit_create_actor(item_unit, "dropped")
	-- local collision_filter = "filter_minion_shooting_no_friendly_fire"
	local collision_filter = "filter_dynamic"

	actor_set_collision_filter(actor, collision_filter)

	slot_data.state = "dropped"

	self:death_event()

end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

DischargeExtension.fx_source_name = function(self, optional_slot_name)
	local slot_name = optional_slot_name or self.wielded_slot_name or self.visual_loadout_extension._wielded_slot_name
	return self.weapons[slot_name] and self.weapons[slot_name].fx_source_name or "muzzle"
end

DischargeExtension.wielded_weapon_unit = function(self, optional_slot_name)
	local slot_name = optional_slot_name or self.wielded_slot_name or self.visual_loadout_extension._wielded_slot_name
	return self.visual_loadout_extension:unit_3p_from_slot(slot_name)
end

DischargeExtension.check_if_weapon_landed = function(self)
	local weapon_unit = self:wielded_weapon_unit()
	if weapon_unit and unit_alive(weapon_unit) then
		local position = unit_world_position(weapon_unit, 1)
		local rotation = unit_world_rotation(weapon_unit, 1)
		local size = vector3(0.25, 1, 0.25)
		local collision_filter = "filter_minion_shooting_no_friendly_fire"
		local _, num_hits = physics_world_immediate_overlap(self.physics_world, "shape", "capsule", "position", position, "rotation", rotation, "size", size, "collision_filter", collision_filter)
		if num_hits > 0 then
			return true
		end
	end
end

DischargeExtension.will_discharge = function(self)
	return self.do_discharge
end

DischargeExtension.trigger_name = function(self)
	return self.template.trigger
end

DischargeExtension.wielded_slot = function(self)
	return self.wielded_slot_name or self.visual_loadout_extension._wielded_slot_name
end

DischargeExtension.delayed_drop = function(self)
	return self.drop_weapon_delayed
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

DischargeExtension.update = function(self, dt, t)

	if self.state == "none" then
		return

	elseif self.state == "finished" then
		return

	elseif self.state == "drop" then

		-- Wait for drop
		local drop_time = not self.collision_check and DROP_TIME or DROP_CHECK
		self.drop_time = self.drop_time or t

		if self.collision_check and t - self.drop_time >= drop_time then

			self.weapon_landed = self:check_if_weapon_landed()

		elseif t - self.drop_time >= drop_time then

			self.weapon_landed = true

		end

		if self.weapon_landed then

			self:trigger_inventory_wwise_event("wwise/events/weapon/play_bullet_hits_gen_armored_death_husk")

			self:start_discharge()

			if not self.discharge_was_started then
				self.state = "finished"
			end

		end

	elseif self.state == "discharge" then

		-- Update discharge
		self.shot_time = self.shot_time or t
		self.effect_time = self.effect_time or t

		-- if self.effect_template and self.effect_template.update then
		--     mod.override_target_unit = true
		--     local slot_name = self:wielded_slot()
		--     if self.data[slot_name] then
		--         self.effect_template.update(self.data[slot_name], self, dt, t)
		--     end
		--     mod.override_target_unit = false
		-- end
		self:update_discharge(dt, t)

		if t - self.effect_time >= DISCHARGE_FREQUENCY then

			self:trigger_discharge()

			self.effect_time = t

		end

		local drop_weapon = false

		if t - self.shot_time >= self.length then

			if self.drop_weapon_delayed then

				drop_weapon = true

			end

			self:finish_discharge()

		end

		if self.drop_weapon_delayed then
			
			self.drop_delay_time = self.drop_delay_time or t

			if t - self.drop_delay_time >= DROP_DELAY then

				drop_weapon = true

			end

		end

		if drop_weapon then
			
			self:drop_weapon()

			self:apply_drop_push(nil, .25)

			self.drop_weapon_delayed = false

		end

	elseif self.state == "explode" then

	end

end

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### ├┤ ├┤ ├┤ ├┤ │   │ └─┐ ########################################################################################
-- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

DischargeExtension.closest_point_on_line = function(self, player_position, start_position, end_position)
	local closest_point = geometry_closest_point_on_line(player_position, start_position, end_position)
	return closest_point
end

DischargeExtension.trigger_wwise_event_on_line = function(self, event_name, start_position, end_position, append_husk_to_event_name)
	local player = managers.player:local_player(1)

	if player then
		local camera_position = managers.state.camera:camera_position(player.viewport_name)
		local sound_position = self:closest_point_on_line(camera_position, start_position, end_position)
		local rotation = quaternion_look(end_position - start_position)

		wwise_world_trigger_resource_event(self.wwise_world, event_name, sound_position, rotation)
	end

end

DischargeExtension.trigger_inventory_wwise_event = function(self, event_name, inventory_slot_name, fx_source_name)

	local inventory_slot_name = inventory_slot_name or self:wielded_slot()
	local inventory_item = self.visual_loadout_extension:slot_item(inventory_slot_name)

	if not inventory_item then return end

	local fx_source_name = fx_source_name or self:fx_source_name()
	local attachment_unit, node = nil, nil
	if inventory_slot_name == "slot_melee_weapon" then
		attachment_unit, node = self:wielded_weapon_unit(), 1
	else
		attachment_unit, node = MinionVisualLoadout.attachment_unit_and_node_from_node_name(inventory_item, fx_source_name)
	end
	local auto_source_id = wwise_world_make_auto_source(self.wwise_world, attachment_unit, node)

	wwise_world_trigger_resource_event(self.wwise_world, event_name, auto_source_id)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

DischargeExtension.hide_original_weapon = function(self, slot_name)
	local weapon_unit = self.weapon_units[slot_name]
	if weapon_unit and unit_alive(weapon_unit) then
		local num_meshes = unit_num_meshes(weapon_unit)
		for i = 1, num_meshes do
			unit_set_mesh_visibility(weapon_unit, i, false)
		end
	end
end

DischargeExtension.apply_physical_push = function(self)

	local weapon_unit = self:wielded_weapon_unit()

	if weapon_unit and unit_alive(weapon_unit) then

		local actor = unit_actor(weapon_unit, "dropped")

		if actor then

			local rotation = unit_local_rotation(weapon_unit, 1)
			local recoil_vector = quaternion_forward(rotation) * -2.5

			actor_add_velocity(actor, recoil_vector)

			local torque_vector = vector3(math_random() * 6, math_random() * .25, math_random() * .25)
			
			torque_vector = quaternion_rotate(rotation, torque_vector)

			actor_add_angular_velocity(actor, torque_vector)

		end

	end

end

DischargeExtension.fetch_data = function(self)

	-- Get breed
	self.breed = self.unit_data_extension:breed()
	local breed_name = self.breed.name

	-- Get discharge template
	local discharge_templates = mod.settings.discharge_templates
	self.template = discharge_templates[math_random(1, #discharge_templates)]

	-- Shoot template
	self.shoot_template = _shoot_templates[breed_name] or BreedShootTemplates[breed_name] or BreedShootTemplates[breed_name.."_default"] --or BreedShootTemplates.default
	local shoot_effect_template = self.shoot_template and self.shoot_template.effect_template_name and EffectTemplates[self.shoot_template.effect_template_name]
	self.effect_template = _effect_templates[breed_name] or shoot_effect_template

	-- Discharge length
	local time_multiplier = _time_multiplier[breed_name] or 1
	self.length = (self.template.time or .3) * time_multiplier

	-- Roll chance
	self.chance = math_random(1, 100)
	self.do_discharge = self.chance <= self.discharge_chance

	local inventory_slots = self.visual_loadout_extension._inventory.slots
	local visual_slots = self.visual_loadout_extension._slots
	local breed_weapons = mod.settings.enemy_weapons[breed_name]

	local wielded_slot_name = self:wielded_slot()

	if inventory_slots then
		for slot_name, slot_data in pairs(inventory_slots) do

			if slot_data.is_weapon then

				-- Create template data
				self.data[slot_name] = table_clone(_data_template)
				local template_data = self.data[slot_name]
				template_data.unit = self.unit
				template_data.target_unit = self.unit

				-- Get equipped item
				self.items[slot_name] = self.visual_loadout_extension:slot_item(slot_name)
				-- Get unit
				self.weapon_units[slot_name] = visual_slots[slot_name].unit
				local weapon_unit = self.weapon_units[slot_name]

				-- Find mod replacement weapon
				local slot_weapons = breed_weapons and breed_weapons[slot_name]
				if slot_weapons then
					for _, weapon in pairs(slot_weapons) do

						if self.items[slot_name].item_data.name == weapon.name then

							if _effect_templates[weapon.name] then
								self.effect_template = _effect_templates[weapon.name] or self.effect_template
								-- mod:echo("weapon "..tostring(weapon.name).." effect_template "..tostring(self.effect_template.name))
							end

							self.weapons[slot_name] = weapon

							local children = unit_get_child_units(weapon_unit)

							if weapon.size then
								local size = vector3_unbox(weapon.size)
								for _, child in pairs(children) do
									unit_set_local_scale(child, 1, size)
								end
							end

							if weapon.position then
								local position = vector3_unbox(weapon.position)
								for _, child in pairs(children) do
									unit_set_local_position(child, 1, position)
								end
							end

							if weapon.rotation then
								local rotation = vector3_unbox(weapon.rotation)
								for _, child in pairs(children) do
									local current = unit_local_rotation(child, 1)
									unit_set_local_rotation(child, 1, quaternion.from_vector(rotation))
								end
							end
							
							self:hide_original_weapon(slot_name)
							
							-- break
						end

					end
				end

			end

		end
	end

end

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #################################################################
-- ##### ├┤ ├┤ ├┤ ├┤ │   │    │ ├┤ │││├─┘│  ├─┤ │ ├┤  #################################################################
-- ##### └─┘└  └  └─┘└─┘ ┴    ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #################################################################

DischargeExtension.trigger_discharge = function(self)

	self.ricochet_depth = 0

	self:apply_physical_push()
	
	self:hit_scan()

end

DischargeExtension.start_discharge = function(self)

	if not self.discharge_was_started and self:will_discharge() then

		self.state = "discharge"

		local t = mod:time()

		if self.effect_template and self.effect_template.start then

			mod.override_target_unit = true

			local slot_name = self:wielded_slot()

			if self.data[slot_name] then
				self.effect_template.start(self.data[slot_name], self)
				if self.data[slot_name].source_id then
					mod:register_discharge_sound(self.unit, self.data[slot_name].source_id, self.wwise_world, self.data[slot_name].stop_sound, t)
				end
			end

			mod.override_target_unit = false

		end

		self.discharge_was_started = true

	end

end

DischargeExtension.update_discharge = function(self, dt, t)

	if self.discharge_was_started then

		if self.effect_template and self.effect_template.update then

			mod.override_target_unit = true

			local slot_name = self:wielded_slot()
			if self.data[slot_name] then
				self.effect_template.update(self.data[slot_name], self, dt, t)
			end

			mod.override_target_unit = false

		end

	end

end

DischargeExtension.finish_discharge = function(self)
		
	if self.discharge_was_started then

		self.state = "finished"
		
		if self.effect_template and self.effect_template.stop then

			mod.override_target_unit = true

			local slot_name = self:wielded_slot()

			if self.data[slot_name] then
				self.effect_template.stop(self.data[slot_name], self)
			end

			mod.override_target_unit = false

		end

		self.discharge_was_started = nil

	end

end

-- ##### ┌─┐┬ ┬┌─┐┌─┐┌┬┐  ┬  ┬┌┐┌┌─┐  ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐ ##############################################################
-- ##### └─┐├─┤│ ││ │ │   │  ││││├┤   ├┤ ├┤ ├┤ ├┤ │   │  ##############################################################
-- ##### └─┘┴ ┴└─┘└─┘ ┴   ┴─┘┴┘└┘└─┘  └─┘└  └  └─┘└─┘ ┴  ##############################################################

DischargeExtension.trigger_unit_line_fx = function(self, line_effect, inventory_slot_name, fx_source_name, end_position)
	
	local inventory_slot_name = inventory_slot_name or self:wielded_slot()
	local inventory_item = self.visual_loadout_extension:slot_item(inventory_slot_name)

	if not inventory_item then return end

	local fx_source_name = fx_source_name or self:fx_source_name()
	local attachment_unit, node = MinionVisualLoadout.attachment_unit_and_node_from_node_name(inventory_item, fx_source_name)
	local spawner_pose = unit_world_pose(attachment_unit, node)
	local spawner_position = matrix4x4_translation(spawner_pose)
	local line = end_position - spawner_position
	local line_direction = vector3_normalize(line)
	local line_rotation = quaternion_look(line_direction)
	local line_length = vector3_length(line)
	local vfx = line_effect.vfx

	if vfx then
		local particle_id = world_create_particles(self.world, vfx, spawner_position, line_rotation)
		local variable_index = world_find_particles_variable(self.world, vfx, "hit_distance")

		world_set_particles_variable(self.world, particle_id, variable_index, vector3(0.1, line_length, line_length))
	end

	local emitters = line_effect.emitters

	if emitters then
		local emitter_effect_name = emitters.vfx.default
		local start_emitter_effect_name = emitters.vfx.start or emitter_effect_name
		local interval = emitters.interval
		local distance = interval.distance
		local increase = interval.increase
		local emitter_distance = 0
		local num_emitters = 0
		local spawn_emitters = true

		while spawn_emitters do
			local new_emitter_distance = emitter_distance + distance * math_pow(1 + increase, num_emitters)

			if line_length < new_emitter_distance + 1 or num_emitters >= MAX_EMITTERS then
				spawn_emitters = false
			else
				local spawn_pos = spawner_position + line_direction * new_emitter_distance
				local chosen_effect_name = num_emitters == 0 and start_emitter_effect_name or emitter_effect_name

				world_create_particles(self.world, chosen_effect_name, spawn_pos, line_rotation)

				emitter_distance = new_emitter_distance
				num_emitters = num_emitters + 1
			end
		end
	end

	local sfx = line_effect.sfx

	if sfx then
		self:trigger_wwise_event_on_line(sfx, spawner_position, end_position)
	end
end

DischargeExtension.line_effect = function(self, optional_slot_name, optional_fx_source_name, end_position, hit_normal)
	
	-- local weapon_unit = template_data.weapon_unit
	local slot_name = optional_slot_name or self:wielded_slot()
	local fx_source_name = optional_fx_source_name or self:fx_source_name(slot_name)

	local weapon_unit = self:wielded_weapon_unit(slot_name)
	end_position = end_position or unit_world_position(weapon_unit, 1) + quaternion_forward(unit_world_rotation(weapon_unit, 1)) * 100

	local line_effect = _line_effects[self.breed.name]
	if line_effect and slot_name and fx_source_name then
		self:trigger_unit_line_fx(line_effect, slot_name, fx_source_name, end_position)

		-- local rnd = math_random(0, 1) == 1
		-- if rnd then
			-- self:trigger_wwise_event_on_line(line_effect.sfx, unit_world_position(weapon_unit, 1), end_position)
		-- if self.ricochet_depth < 1 then

		-- 	self.ricochet_depth = self.ricochet_depth + 1

		-- 	self:hit_scan(end_position, hit_normal)
		-- end
		-- end
	end

end

-- ##### ┌─┐┬ ┬┌─┐┌─┐┌┬┐  ┬ ┬┬┌┬┐┌─┐┌─┐┌─┐┌┐┌ #########################################################################
-- ##### └─┐├─┤│ ││ │ │   ├─┤│ │ └─┐│  ├─┤│││ #########################################################################
-- ##### └─┘┴ ┴└─┘└─┘ ┴   ┴ ┴┴ ┴ └─┘└─┘┴ ┴┘└┘ #########################################################################

DischargeExtension.spread_direction = function(self, target_unit, minion_unit, shoot_direction, spread, optional_spread_multiplier)
	local spread_multiplier = optional_spread_multiplier or 1
	local spread_angle = math_random() * spread * spread_multiplier
	local buff_extension = script_unit_has_extension(target_unit, "buff_system")

	if buff_extension then
		local stat_buffs = buff_extension:stat_buffs()

		if stat_buffs and stat_buffs.elusiveness_modifier then
			spread_angle = spread_angle * stat_buffs.elusiveness_modifier
		end
	end

	local minion_buff_extension = script_unit_has_extension(minion_unit, "buff_system")

	if minion_buff_extension then
		local stat_buffs = minion_buff_extension:stat_buffs()

		if stat_buffs and stat_buffs.minion_accuracy_modifier then
			spread_angle = spread_angle * stat_buffs.minion_accuracy_modifier
		end
	end

	local suppression_extension = script_unit_has_extension(minion_unit, "suppression_system")

	if suppression_extension and suppression_extension.suppress_value then
		local suppress_value = suppression_extension:suppress_value()

		if suppress_value > 1 then
			spread_angle = spread_angle * math.min(suppress_value * 3, MAX_SUPPRESS_VALUE_SPREAD)
		end
	end

	local direction_rotation = quaternion_look(shoot_direction, vector3_up())
	local pitch = quaternion(vector3_right(), spread_angle)
	local roll = quaternion(vector3_forward(), math.random() * math.two_pi)
	local spread_rotation = quaternion_multiply(quaternion_multiply(direction_rotation, roll), pitch)
	local spread_direction = quaternion_forward(spread_rotation)

	return spread_direction
end

DischargeExtension.fetch_damage_type = function(self, fire_configuration, is_critical_strike, charge_level)
	local damage_type_non_explode = is_critical_strike and fire_configuration.damage_type_critical_strike or fire_configuration.damage_type
	local damage_type_explode = is_critical_strike and fire_configuration.damage_type_explode_critical_strike or fire_configuration.damage_type_explode
	local is_charge_dependant = damage_type_non_explode and type(damage_type_non_explode) == "table"

	if is_charge_dependant then
		local damage_type_table = damage_type_non_explode

		damage_type_non_explode = nil

		for i = 1, #damage_type_table do
			local entry = damage_type_table[i]
			local required_charge = entry.charge_level
			local damage_type = entry.damage_type

			if required_charge <= charge_level then
				damage_type_non_explode = damage_type
			end
		end
	end

	return damage_type_non_explode, damage_type_explode
end

DischargeExtension.hit_scan = function(self, optional_from_position, optional_shoot_direction)

	if not self.shoot_template then
		return
	end

	local inventory_slot_name = self:wielded_slot()
	if inventory_slot_name ~= SLOT_RANGED_WEAPON then
		return
	end

	local inventory_item = self.visual_loadout_extension:slot_item(inventory_slot_name)
	if not inventory_item then
		return
	end

	local fx_source_name = self:fx_source_name()
	local weapon_unit = self:wielded_weapon_unit()
	local attachment_unit, node = nil, nil
	if inventory_item.item_data.fx_sources then
		attachment_unit, node = MinionVisualLoadout.attachment_unit_and_node_from_node_name(inventory_item, fx_source_name)
	else
		attachment_unit, node = weapon_unit, 1
	end
	
	local breed = self.unit_data_extension:breed()
	local shoot_template = self.shoot_template
	local from_position = optional_from_position or unit_world_position(attachment_unit, node)
	local rotation = unit_world_rotation(weapon_unit, 1)
	local shoot_direction = optional_shoot_direction or quaternion_forward(rotation)
	local spread = shoot_template.spread or math.degrees_to_radians(5)
	local spread_direction = self:spread_direction(self.unit, self.unit, shoot_direction, spread)
	local power_level = managers.state.difficulty:get_minion_attack_power_level(breed, "ranged")
	local charge_level = 1
	local range = 1000

	local hits = HitScan.raycast(self.physics_world, from_position, spread_direction, range, nil, "filter_player_character_shooting_raycast_dynamics")

	if hits then
		local num_hit_results = #hits

		for i = 1, num_hit_results do

			local hit = hits[i]
			if hit then
				local hit_position = hit.position or hit[INDEX_POSITION]
				local hit_normal = hit.normal or hit[INDEX_NORMAL]
				local hit_distance = hit.distance or hit[INDEX_DISTANCE]
				local hit_actor = hit.actor or hit[INDEX_ACTOR]
				local hit_unit = actor_unit(hit_actor)

				local hit_scan_template = shoot_template.hit_scan_template
				local damage_config = hit_scan_template.damage
				local explosion_arming_distance = damage_config.explosion_arming_distance or 0

				local optional_is_critical_strike = false
				local damage_type_non_explode, damage_type_explode = self:fetch_damage_type(shoot_template, optional_is_critical_strike, charge_level)
				local can_explode = explosion_arming_distance <= hit_distance
				local damage_type = can_explode and damage_type_explode or damage_type_non_explode

				local fx_system = managers.state.extension:system("fx_system")
				local is_server = fx_system._is_server
				fx_system._is_server = false
				fx_system:play_surface_impact_fx(hit_position, spread_direction, IMPACT_FX_DATA.source_parameters, weapon_unit, hit_normal, damage_type, surface_hit_types.stop, true)
				fx_system._is_server = is_server

				self:line_effect(inventory_slot_name, fx_source_name, hit_position, hit_normal)
			end

		end

	end

end
