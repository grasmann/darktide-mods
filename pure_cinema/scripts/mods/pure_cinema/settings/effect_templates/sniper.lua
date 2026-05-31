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
	local world = World
	local vector3 = Vector3
	local Managers = Managers
	local matrix4x4 = Matrix4x4
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

local shooting_difficulty_settings = MinionDifficultySettings.shooting.renegade_gunner
local WWISE_GUN_START = "wwise/events/weapon/play_weapon_longlas_minion"
local SHOOT_VFX = "content/fx/particles/enemies/renegade_sniper/renegade_sniper_muzzle_flash"
local LINE_EFFECT = LineEffects.renegade_gunner_lasbeam
local FIRE_RATE_PARAMETER_NAME = "wpn_fire_interval"
local STIMMED_PARAMETER_NAME = "minion_stimmed"
local resources = {
	shoot_vfx = SHOOT_VFX,
	wwise_gun_start = WWISE_GUN_START,
}
local FX_MUZZLE_SOURCE_NAME = "muzzle"
local ORPHANED_POLICY = "stop"

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

local effect_template = {
	name = "sniper",
	resources = resources,
	start = function (template_data, template_context)
		local unit = template_data.unit
		local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
		local weapon_unit = visual_loadout_extension:unit_3p_from_slot("slot_ranged_weapon")
		local inventory_item = visual_loadout_extension:slot_item("slot_ranged_weapon")
		local attachment_unit, fx_muzzle_node_index = MinionVisualLoadout.attachment_unit_and_node_from_node_name(inventory_item, FX_MUZZLE_SOURCE_NAME)
		local wwise_world = template_context.wwise_world
		local source_id = wwise_world_make_manual_source(wwise_world, attachment_unit, fx_muzzle_node_index)

		template_data.attachment_unit = attachment_unit
		template_data.fx_muzzle_node_index = fx_muzzle_node_index
		template_data.visual_loadout_extension = visual_loadout_extension
		template_data.weapon_unit = weapon_unit

		wwise_world_trigger_resource_event(wwise_world, WWISE_GUN_START, source_id)

		template_data.source_id = source_id

		local game_session, game_object_id = template_context.game_session, Managers.state.unit_spawner:game_object_id(unit)
		local target_unit = MinionPerception.target_unit(game_session, game_object_id)

		template_data.target_unit = target_unit
		template_data.was_camera_following_target = Effect.update_targeted_by_ranged_minion_wwise_parameters(target_unit, wwise_world, source_id, nil)

		local buff_extension = script_unit_has_extension(unit, "buff_system")
		local fire_rate_modifier = 1

		if buff_extension then
			local stat_buffs = buff_extension:stat_buffs()

			if stat_buffs.ranged_attack_speed then
				fire_rate_modifier = stat_buffs.ranged_attack_speed
			end

			if buff_extension:has_keyword("stimmed") then
				wwise_world_set_source_parameter(wwise_world, source_id, STIMMED_PARAMETER_NAME, 1)
			end
		end

		local time_per_shot = shooting_difficulty_settings.time_per_shot
		local diff_time_per_shot = Managers.state.difficulty:get_table_entry_by_challenge(time_per_shot)
		local parameter_value = diff_time_per_shot[1]

		wwise_world_set_source_parameter(wwise_world, source_id, FIRE_RATE_PARAMETER_NAME, parameter_value / fire_rate_modifier)
	end,
	update = function (template_data, template_context, dt, t)
		local wwise_world = template_context.wwise_world
		local target_unit, source_id = template_data.target_unit, template_data.source_id
		local was_camera_following_target = template_data.was_camera_following_target
		local is_camera_following_target = Effect.update_targeted_by_ranged_minion_wwise_parameters(target_unit, wwise_world, source_id, was_camera_following_target)

		template_data.was_camera_following_target = is_camera_following_target

		local world, position, pose = template_context.world, vector3_zero(), matrix4x4_identity()
		local visual_loadout_extension = template_data.visual_loadout_extension
		local attachment_unit, fx_muzzle_node_index = template_data.attachment_unit, template_data.fx_muzzle_node_index

        if not template_data.muzzle_particle_id then

            local muzzle_particle_id = world_create_particles(world, SHOOT_VFX, position, nil, nil, template_data.particle_group)

            world_link_particles(world, muzzle_particle_id, attachment_unit, fx_muzzle_node_index, pose, ORPHANED_POLICY)

			-- local weapon_unit = template_data.weapon_unit
            -- local end_position = unit_world_position(weapon_unit, 1) + quaternion_forward(unit_world_rotation(weapon_unit, 1)) * 100
            -- visual_loadout_extension:_trigger_unit_line_fx(LINE_EFFECT, "slot_ranged_weapon", FX_MUZZLE_SOURCE_NAME, end_position)

            template_data.muzzle_particle_id = muzzle_particle_id
            template_data.muzzle_time = t

        elseif template_data.muzzle_particle_id and t - template_data.muzzle_time >= 1 then

            local muzzle_particle_id = template_data.muzzle_particle_id

		    world_stop_spawning_particles(world, muzzle_particle_id)

            world_destroy_particles(world, muzzle_particle_id)

            template_data.muzzle_particle_id = nil

        end

	end,
	stop = function (template_data, template_context)
		local wwise_world = template_context.wwise_world
		local source_id = template_data.source_id
		if source_id then
			wwise_world_destroy_manual_source(wwise_world, source_id)
			template_data.source_id = nil
		end

		local world = template_context.world
		local muzzle_particle_id = template_data.muzzle_particle_id
		if muzzle_particle_id then
			world_stop_spawning_particles(world, muzzle_particle_id)
			template_data.muzzle_particle_id = nil
		end

		-- local unit = template_data.unit

		-- unit_animation_event(unit, "shoot_finished")
	end,
}

return effect_template
