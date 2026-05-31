local mod = get_mod("pure_cinema")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MinionDifficultySettings = mod:original_require("scripts/settings/difficulty/minion_difficulty_settings")
local MinionVisualLoadout = mod:original_require("scripts/utilities/minion_visual_loadout")
local Effect = mod:original_require("scripts/extension_systems/fx/utilities/effect")
local MinionPerception = mod:original_require("scripts/utilities/minion_perception")
local LineEffects = mod:original_require("scripts/settings/effects/line_effects")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local unit = Unit
    local math = math
	local world = World
	local vector3 = Vector3
	local Managers = Managers
	local matrix4x4 = Matrix4x4
    local math_clamp = math.clamp
    local quaternion = Quaternion
	local script_unit = ScriptUnit
	local wwise_world = WwiseWorld
	local vector3_zero = vector3.zero
	local matrix4x4_identity = matrix4x4.identity
	local quaternion_forward = quaternion.forward
	local unit_world_position = unit.world_position
	local unit_world_rotation = unit.world_rotation
	local unit_animation_event = unit.animation_event
	local world_link_particles = world.link_particles
	local script_unit_extension = script_unit.extension
	local world_create_particles = world.create_particles
	local world_destroy_particles = world.destroy_particles
	local script_unit_has_extension = script_unit.has_extension
	local world_stop_spawning_particles = world.stop_spawning_particles
	local wwise_world_make_manual_source = wwise_world.make_manual_source
	local wwise_world_set_source_parameter = wwise_world.set_source_parameter
	local wwise_world_destroy_manual_source = wwise_world.destroy_manual_source
	local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local Effect = require("scripts/extension_systems/fx/utilities/effect")
local MinionPerception = require("scripts/utilities/minion_perception")
local INTERPOLATION_INCREASE_SPEED = 2
local INTERPOLATION_DECREASE_SPEED = -4
local MIN_WEAPON_INTENSITY = .8
local MAX_WEAPON_INTENSITY = 1
local START_SOUND_EVENT = "wwise/events/weapon/play_combat_weapon_chainaxe_chaos"
local STOP_SOUND_EVENT = "wwise/events/weapon/stop_combat_weapon_chainaxe_chaos"
local resources = {
	start_sound_event = START_SOUND_EVENT,
	stop_sound_event = STOP_SOUND_EVENT,
}

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

local effect_template = {
	name = "chainaxe",
	resources = resources,
	start = function (template_data, template_context)
		local wwise_world = template_context.wwise_world
		local unit = template_data.unit
		local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
		local inventory_unit = visual_loadout_extension:slot_unit("slot_melee_weapon")
		local source_id = wwise_world_make_manual_source(wwise_world, inventory_unit)

		wwise_world_trigger_resource_event(wwise_world, START_SOUND_EVENT, source_id)

		local game_session = Managers.state.game_session:game_session()
		local game_object_id = Managers.state.unit_spawner:game_object_id(unit)
		local weapon_intensity = .9

		wwise_world_set_source_parameter(wwise_world, source_id, "combat_chainsword_throttle", weapon_intensity)

		template_data.source_id = source_id
		template_data.game_session, template_data.game_object_id = game_session, game_object_id
		template_data.weapon_intensity = weapon_intensity
	end,
	update = function (template_data, template_context, dt, t)
		local game_session, game_object_id = template_data.game_session, template_data.game_object_id
		local wanted_weapon_intensity = 1
		local weapon_intensity, interpolation_speed = template_data.weapon_intensity, nil

		if weapon_intensity < wanted_weapon_intensity then
			interpolation_speed = INTERPOLATION_INCREASE_SPEED
		elseif wanted_weapon_intensity < weapon_intensity then
			interpolation_speed = INTERPOLATION_DECREASE_SPEED
		end

		local wwise_world, source_id = template_context.wwise_world, template_data.source_id

		if interpolation_speed then
			local new_weapon_intensity = math_clamp(weapon_intensity + interpolation_speed * dt, MIN_WEAPON_INTENSITY, MAX_WEAPON_INTENSITY)

			wwise_world_set_source_parameter(wwise_world, source_id, "combat_chainsword_throttle", new_weapon_intensity)

			template_data.weapon_intensity = new_weapon_intensity
		end

		local target_unit = MinionPerception.target_unit(game_session, game_object_id)
		local was_camera_following_target = template_data.was_camera_following_target
		local is_camera_following_target = Effect.update_targeted_in_melee_wwise_parameters(target_unit, wwise_world, source_id, was_camera_following_target)

		template_data.was_camera_following_target = is_camera_following_target
	end,
	stop = function (template_data, template_context)
		local wwise_world = template_context.wwise_world
		local source_id = template_data.source_id
		if source_id then
			wwise_world_trigger_resource_event(wwise_world, STOP_SOUND_EVENT, source_id)
			wwise_world_destroy_manual_source(wwise_world, source_id)
			template_data.source_id = nil
		end
	end,
}

return effect_template
