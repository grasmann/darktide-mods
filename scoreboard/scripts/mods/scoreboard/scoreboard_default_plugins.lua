local mod = get_mod("scoreboard")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local InteractionSettings = mod:original_require("scripts/settings/interaction/interaction_settings")
local interaction_results = InteractionSettings.results
local DamageProfileTemplates = mod:original_require("scripts/settings/damage/damage_profile_templates")
local TextUtilities = mod:original_require("scripts/utilities/ui/text")
local UISettings = mod:original_require("scripts/settings/ui/ui_settings")
local Breed = mod:original_require("scripts/utilities/breed")
local WalletSettings = mod:original_require("scripts/settings/wallet_settings")

-- #####  █████╗ ███╗   ██╗██╗███╗   ███╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #####################
-- ##### ██╔══██╗████╗  ██║██║████╗ ████║    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #####################
-- ##### ███████║██╔██╗ ██║██║██╔████╔██║    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #####################
-- ##### ██╔══██║██║╚██╗██║██║██║╚██╔╝██║    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #####################
-- ##### ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #####################
-- ##### ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #####################

mod.animation_events_add_packs = {
	enemy_stagger = {
		"stagger_fwd",
		"stagger_fwd_2",
		"stagger_fwd_3",
		"stagger_fwd_4",
		"stagger_fwd_light",
		"stagger_fwd_light_2",
		"stagger_fwd_light_3",
		"stagger_fwd_light_4",
		"stagger_fwd_light_5",
		"stagger_fwd_light_6",
		"stagger_fwd_killshot_1",
		"stagger_fwd_killshot_2",

		"stagger_bwd",
		"stagger_bwd_2",
		"stagger_bwd_3",
		"stagger_bwd_4",
		"stagger_bwd_5",
		"stagger_bwd_6",
		"stagger_bwd_light",
		"stagger_bwd_light_2",
		"stagger_bwd_light_3",
		"stagger_bwd_light_4",
		"stagger_bwd_light_5",
		"stagger_bwd_light_6",
		"stagger_bwd_light_7",
		"stagger_bwd_light_8",
		"stagger_bwd_sticky",
		"stagger_bwd_sticky_2",
		"stagger_bwd_sticky_3",
		"stagger_bwd_killshot_1",
		"stagger_bwd_killshot_2",

		"stagger_left",
		"stagger_left_2",
		"stagger_left_3",
		"stagger_left_4",
		"stagger_left_5",
		"stagger_left_6",
		"stagger_left_7",
		"stagger_left_8",
		"stagger_left_light",
		"stagger_left_light_2",
		"stagger_left_light_3",
		"stagger_left_light_4",
		"stagger_left_sticky",
		"stagger_left_sticky_2",
		"stagger_left_sticky_3",
		"stagger_left_killshot_1",
		"stagger_left_killshot_2",
		"run_stagger_left",

		"stagger_right",
		"stagger_right_2",
		"stagger_right_3",
		"stagger_right_4",
		"stagger_right_5",
		"stagger_right_6",
		"stagger_right_7",
		"stagger_right_light",
		"stagger_right_light_2",
		"stagger_right_light_3",
		"stagger_right_light_4",
		"stagger_right_sticky",
		"stagger_right_sticky_2",
		"stagger_right_sticky_3",
		"run_stagger_right",

		"shotgun_run_stagger_01",
		"shotgun_run_stagger_02",
		"shotgun_run_stagger_03",
		"shotgun_run_stagger_04",

		"stun_down",
    	"stagger_downward",

		"stagger_shield_block_01",
		"stagger_shield_block_02",
		"stagger_shield_block_03",
		"stagger_shield_block_04",
		"stagger_shield_block_05",

		"stagger_shield_block_right",
		"stagger_shield_block_left",
	},
	enemy_stagger_heavy = {
		"stagger_fwd_heavy",
		"stagger_fwd_heavy_2",
		"stagger_fwd_heavy_3",
		"stagger_fwd_heavy_4",
		"stagger_fwd_heavy_5",
		"stagger_fwd_heavy_6",

		"stagger_bwd_heavy",
		"stagger_bwd_heavy_2",
		"stagger_bwd_heavy_3",
		"stagger_bwd_heavy_4",
		"stagger_bwd_heavy_5",
		"stagger_bwd_heavy_6",
		"stagger_bwd_heavy_7",
		"stagger_bwd_heavy_8",
		"stagger_bwd_heavy_9",

		"stagger_left_heavy",
		"stagger_left_heavy_2",
		"stagger_left_heavy_3",
		"stagger_left_heavy_4",
		"stagger_left_heavy_5",
		"stagger_left_heavy_6",

		"stagger_right_heavy",
		"stagger_right_heavy_2",
		"stagger_right_heavy_3",
		"stagger_right_heavy_4",
		"stagger_right_heavy_5",
		"stagger_right_heavy_6",

		"stagger_up_heavy",
		"stagger_up_heavy_2",
		"stagger_up_heavy_3",

		"stagger_down_heavy",

		"stagger_explosion_front",
		"stagger_explosion_front_2",
		"stagger_explosion_back",
		"stagger_explosion_left",
		"stagger_explosion_right",
		"stagger_expl_fwd_01",
		"stagger_expl_bwd_01",
		"stagger_expl_left_01",
		"stagger_expl_right_01",
		"stagger_expl_bwd_01",

		"hit_reaction_forward",
		"hit_reaction_backward",
		"hit_reaction_left",
		"hit_reaction_right",

		"flinch_reaction_down",
		"flinch_reaction_right",
		"flinch_reaction_left",

		"stagger_shield_damage_01",
		"stagger_shield_damage_02",
		"stagger_shield_damage_03",
		"stagger_shield_damage_04",
	},
}
mod.animation_events_add_callbacks = {
	enemy_stagger = function(event_name, event_index, unit, first_person, context)
		mod:enemy_stagger(event_name, event_index, unit, first_person, context)
	end,
	enemy_stagger_heavy = function(event_name, event_index, unit, first_person, context)
		mod:enemy_heavy_stagger(event_name, event_index, unit, first_person, context)
	end,
	equip_crate = function(event_name, event_index, unit, first_person, context)
        mod:equip_crate(event_name, event_index, unit, first_person, context)
    end,
	drop = function(event_name, event_index, unit, first_person, context)
        mod:drop_crate(event_name, event_index, unit, first_person, context)
    end,
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Player from player_unit
mod.player_from_unit = function(self, unit)
	if unit then
		local player_manager = Managers.player
		for _, player in pairs(player_manager:players()) do
			if player.player_unit == unit then
				return player
			end
		end
	end
	return nil
end

-- Extract file name from path
mod.file_name = function(self, url)   
    local str = url
	local temp = ""
	local result = ""

	-- Get file name + extension until first forward slash (/) and then break
	for i = str:len(), 1, -1 do
		if str:sub(i,i) ~= "/" then
		temp = temp..str:sub(i,i)
		else
		break
		end
	end

	-- Reverse order of full file name
	for j = temp:len(), 1, -1 do
		result = result..temp:sub(j,j)
	end

	return result
end

-- ##### ┌─┐┌─┐┬ ┬┌─┐┬─┐┌─┐┌┐┌┌─┐┬ ┬ ##################################################################################
-- ##### │  │ │├─┤├┤ ├┬┘├┤ ││││  └┬┘ ##################################################################################
-- ##### └─┘└─┘┴ ┴└─┘┴└─└─┘┘└┘└─┘ ┴  ##################################################################################

mod.coherency_frequency = 10
mod.coherency_timer = mod.coherency_frequency

mod.update_coherency = function(self, dt)
	if self.player_manager and self.coherency_timer then
        if self.coherency_timer <= 0 then
            local players = self.player_manager:players()
            for _, player in pairs(players) do
                local unit = player.player_unit
                if unit then
                    local coherency_extension = ScriptUnit.has_extension(unit, "coherency_system")
                    if coherency_extension then
                        local num_units_in_coherency = coherency_extension:num_units_in_coherency()
                        local account_id = player:account_id() or player:name()
                        self:update_stat("coherency_efficiency", account_id, num_units_in_coherency)
                    end
                end
            end
            self.coherency_timer = self.coherency_frequency
        else
            self.coherency_timer = self.coherency_timer - dt
        end
	end
end

-- ##### ┌─┐┌─┐┬─┐┬─┐┬ ┬┬┌┐┌┌─┐  ┌─┐┌┐  ┬┌─┐┌─┐┌┬┐┌─┐ #################################################################
-- ##### │  ├─┤├┬┘├┬┘└┬┘│││││ ┬  │ │├┴┐ │├┤ │   │ └─┐ #################################################################
-- ##### └─┘┴ ┴┴└─┴└─ ┴ ┴┘└┘└─┘  └─┘└─┘└┘└─┘└─┘ ┴ └─┘ #################################################################

mod.carrying = {}

mod.carrying_units = function(self)
	local num = 0
	for unit, pickups in pairs(self.carrying) do
		num = num + 1
	end
	return num
end

mod.update_carrying = function(self, dt)
	if Managers and Managers.player then
		local num_carrying = self:carrying_units()
		if num_carrying > 0 then
			for unit, pickups in pairs(self.carrying) do
				for _, name in pairs(pickups) do
					local carrying = nil
					if name == "scripture_pocketable" then
						carrying = "tomes"
					elseif name == "grimoire_pocketable" then
						carrying = "grims"
					else
						carrying = "other"
					end
					if carrying then
						local player = self:player_from_unit(unit)
						if player then
							local account_id = player:account_id() or player:name()
							mod:update_stat("carrying_"..carrying, account_id, dt)
						end
					end
				end
			end
		end
	end
end

-- ##### ┌─┐┌┐┌┌─┐┌┬┐┬ ┬  ┌─┐┌┬┐┌─┐┌─┐┌─┐┌─┐┬─┐ #######################################################################
-- ##### ├┤ │││├┤ │││└┬┘  └─┐ │ ├─┤│ ┬│ ┬├┤ ├┬┘ #######################################################################
-- ##### └─┘┘└┘└─┘┴ ┴ ┴   └─┘ ┴ ┴ ┴└─┘└─┘└─┘┴└─ #######################################################################

mod.enemy_stagger = function(self, event_name, event_index, unit, first_person, context)
	if mod.last_enemy_interaction[unit] then
		local player_unit = mod.last_enemy_interaction[unit]
		local player = mod:player_from_unit(player_unit)
		if player then
			local account_id = player:account_id() or player:name()
			-- Update scoreboard
			mod:update_stat("enemies_staggerd", account_id, 1)
		end
	end
end

mod.enemy_heavy_stagger = function(self, event_name, event_index, unit, first_person, context)
	if mod.last_enemy_interaction[unit] then
		local player_unit = mod.last_enemy_interaction[unit]
		local player = mod:player_from_unit(player_unit)
		if player then
			local account_id = player:account_id() or player:name()
			-- Update scoreboard
			mod:update_stat("enemies_staggerd", account_id, 2)
		end
	end
end

-- ##### ┌─┐┌─┐ ┬ ┬┬┌─┐  ┌─┐┌┐┌┌┬┐  ┌┬┐┬─┐┌─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐ #####################################################
-- ##### ├┤ │─┼┐│ ││├─┘  ├─┤│││ ││   ││├┬┘│ │├─┘  │  ├┬┘├─┤ │ ├┤  #####################################################
-- ##### └─┘└─┘└└─┘┴┴    ┴ ┴┘└┘─┴┘  ─┴┘┴└─└─┘┴    └─┘┴└─┴ ┴ ┴ └─┘ #####################################################

mod.crates_equiped = {}

mod.equip_crate = function(self, event_name, event_index, unit, first_person, context)
	local player = mod:player_from_unit(unit)
	if player and not first_person then
		local account_id = player:account_id() or player:name()
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local inventory_component = unit_data_extension:read_component("inventory")
		local held_pocketable = inventory_component.slot_pocketable
		local name = mod:file_name(held_pocketable)
		-- local crate = mod.crates[name] or name
		mod.crates_equiped[unit] = name
	end
end

mod.drop_crate = function(self, event_name, event_index, unit, first_person, context)
	local player = mod:player_from_unit(unit)
	if player and not first_person then
		local account_id = player:account_id() or player:name()
		if mod.crates_equiped[unit] then
			local crate = mod.crates_equiped[unit]
			local text = Localize(mod.pickups_text[crate])
			if crate == "med_crate_pocketable" then
				-- Message
				if mod:get("message_health_placed") then
					local color = Color.light_blue(255, true)
					-- local message = " deployed "..TextUtilities.apply_color_to_text(text, color)
					local message = mod:localize("message_health_placed_text")
					message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(text, color))
					-- local character_name = player:name()
					-- mod:echo(character_name..message)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("health_placed", account_id, 1)

			elseif crate == "ammo_cache_pocketable" then
				-- Message
				if mod:get("message_ammo_placed") then
					local color = Color.gray(255, true)
					-- local message = " deployed "..TextUtilities.apply_color_to_text(text, color)
					local message = mod:localize("message_health_placed_text")
					message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(text, color))
					-- local character_name = player:name()
					-- mod:echo(character_name..message)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("ammo_placed", account_id, 1)
			end
			-- Reset carrying crate
			mod.carrying[unit] = mod.carrying[unit] or {}
			mod.carrying[unit][crate] = nil
			-- Reset equiped crate
			mod.crates_equiped[unit] = nil
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- ##### ┌┐ ┌─┐┌─┐┬┌─┐  ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ##############################################################
-- ##### ├┴┐├─┤└─┐││    ││││ │ ├┤ ├┬┘├─┤│   │ ││ ││││└─┐ ##############################################################
-- ##### └─┘┴ ┴└─┘┴└─┘  ┴┘└┘ ┴ └─┘┴└─┴ ┴└─┘ ┴ ┴└─┘┘└┘└─┘ ##############################################################

mod.pickups = {
	loc_pickup_pocketable_medical_crate_01 = "med_crate_pocketable",
	loc_pickup_pocketable_ammo_crate_01 = "ammo_cache_pocketable",
	loc_pickup_side_mission_pocketable_01 = "grimoire_pocketable",
	loc_pickup_side_mission_pocketable_02 = "scripture_pocketable",
}
mod.pickups_text = {
	med_crate_pocketable = "loc_pickup_pocketable_medical_crate_01",
	ammo_cache_pocketable = "loc_pickup_pocketable_ammo_crate_01",
	grimoire_pocketable = "loc_pickup_side_mission_pocketable_01",
	scripture_pocketable = "loc_pickup_side_mission_pocketable_02",
}
mod.forge_material = {
	loc_pickup_small_metal = "small_metal",
	loc_pickup_large_metal = "large_metal",
	loc_pickup_small_platinum = "small_platinum",
	loc_pickup_large_platinum = "large_platinum",
}
mod.forge_material_count = {
	small_metal = 10,
	large_metal = 25,
	small_platinum = 10,
	large_platinum = 25,
}
mod.ammunition = {
	loc_pickup_consumable_small_clip_01 = "small_clip",
	loc_pickup_consumable_large_clip_01 = "large_clip",
	loc_pickup_deployable_ammo_crate_01 = "crate",
}
mod.ammunition_percentage = {
	small_clip = 0.15,
	large_clip = 0.5,
}
mod.current_ammo = {}
mod.interaction_units = {}

mod:hook(CLASS.InteracteeExtension, "stopped", function(func, self, result, ...)
	-- Check if interactiong successful
	if result == interaction_results.success then
		local type = self:interaction_type() or ""
		local unit = self._interactor_unit
		if unit then
			local weapon_extension = ScriptUnit.extension(unit, "weapon_system")
			local player = mod:player_from_unit(unit)
			local profile = player:profile()
			if player then
				local account_id = player:account_id() or player:name()
				-- Check type
				if type == "default" or type == "moveable_platform" or type == "scripted_scenario" or type == "luggable_socket" or (type == "door_control_panel" and self._override_contexts.door_control_panel.description ~= "loc_interactable_door") then
					-- Message
					if mod:get("message_default") then
						local color = Color.light_green(255, true)
						-- local message = " operated "..TextUtilities.apply_color_to_text("Machinery", color)
						local message = mod:localize("message_default_text")
						local subject = mod:localize("message_default_machinery")
						message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("machinery_operated", account_id, 1)

				elseif type == "pocketable" then
					local name = self._override_contexts.pocketable.description
					local pickup = mod.pickups[name] or name
					local option = ""
					local color = nil
					-- Set carrying
					mod.carrying[unit] = mod.carrying[unit] or {}
					local num_carrying = #mod.carrying[unit]
					mod.carrying[unit][pickup] = pickup
					-- Check pickup
					if pickup == "med_crate_pocketable" then
						option = "message_ammo_health_pickup"
						color = Color.light_blue(255, true)
					elseif pickup == "ammo_cache_pocketable" then
						option = "message_ammo_health_pickup"
						color = Color.gray(255, true)
					elseif pickup == "grimoire_pocketable" then
						option = "scripture_grimoire_pickup"
						color = Color.citadel_dawnstone(255, true)
					elseif pickup == "scripture_pocketable" then
						option = "scripture_grimoire_pickup"
						color = Color.citadel_dawnstone(255, true)
					end
					-- Message
					if mod:get(option) then
						local text = Localize(name)
						-- local character_name = player:name()
						-- local message = " picked up "..TextUtilities.apply_color_to_text(text, color)
						local message = mod:localize("message_ammo_health_pickup_text")
						-- local subject = mod:localize("message_default_machinery")
						message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(text, color))
						-- mod:echo(character_name..message)
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("machinery_operated", account_id, 1)

				elseif type == "health_station" then
					-- Message
					if mod:get("message_health_station") then
						local color = Color.light_blue(255, true)
						-- local message = " used "..TextUtilities.apply_color_to_text("Health Station", color)
						local message = mod:localize("message_health_station_text")
						local subject = mod:localize("message_health_station_health_station")
						message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("heal_station_used", account_id, 1)

				elseif type == "servo_skull" or type == "servo_skull_activator" then
					mod.interaction_units[self._unit] = unit
					-- Message
					if mod:get("message_decoded") then
						local color = Color.light_green(255, true)
						-- local message = " operated "..TextUtilities.apply_color_to_text("Servoskull", color)
						local message = mod:localize("message_decoded_text")
						local subject = mod:localize("message_decoded_skull")
						message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("gadget_operated", account_id, 1)

				elseif type == "decoding" or type == "setup_decoding" then
					mod.interaction_units[self._unit] = unit

				elseif type == "forge_material" then
					local material = mod.forge_material[self._override_contexts.forge_material.description]
					local count = mod.forge_material_count[material]
					-- Message
					if mod:get("message_forge_material") then
						local color = Color.orange(255, true)
						local text = Localize(self._override_contexts.forge_material.description)
						local message = mod:localize("message_forge_material_text")
						message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(text.." ("..count..")", color))
						-- local message = " picked up "..TextUtilities.apply_color_to_text(text.." ("..count..")", color)
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat(material, account_id, count)

				elseif type == "ammunition" then
					-- Get pick up data
					local ammo = mod.ammunition[self._override_contexts.ammunition.description]
					-- Get components
					local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
					local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
					local wieldable_component = unit_data_extension:read_component("slot_secondary")
					-- Get ammo numbers
					local ammo_clip = wieldable_component.current_ammunition_clip
					local max_ammo_clip = wieldable_component.max_ammunition_clip
					local max_ammo_reserve = wieldable_component.max_ammunition_reserve
					local current_ammo_reserve = mod.current_ammo[unit]
					local max_ammo = max_ammo_reserve + max_ammo_clip
					local current_ammo = current_ammo_reserve + ammo_clip
					local max_take = max_ammo - current_ammo
					if ammo == "small_clip" then
						mod:update_stat("ammo_small_picked_up", account_id, 1)
					elseif ammo == "large_clip" then
						mod:update_stat("ammo_large_picked_up", account_id, 1)
					elseif ammo == "crate" then
						mod:update_stat("ammo_crate_picked_up", account_id, 1)
					end
					if ammo == "small_clip" or ammo == "large_clip" then
						-- Calculate ammo
						local pecentage = mod.ammunition_percentage[ammo] or 0
						local amount = max_ammo_reserve * pecentage
						local wasted = math.max(amount - max_take, 0)
						local picked = math.min(amount, max_take)
						-- Message
						if mod:get("message_ammo") then
							local color = Color.gray(255, true)
							-- local message = " picked up "..TextUtilities.apply_color_to_text(string.format("%.0f", picked).." ammo ", color).." wasted "..TextUtilities.apply_color_to_text(string.format("%.0f", wasted), color)
							local message = mod:localize("message_ammo_text")
							local subject = mod:localize("message_ammo_ammo")
							message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
							message = string.gsub(message, ":count:", TextUtilities.apply_color_to_text(string.format("%.0f", picked), color))
							message = string.gsub(message, ":count2:", TextUtilities.apply_color_to_text(string.format("%.0f", wasted), color))
							Managers.event:trigger("event_combat_feed_kill", unit, message)
						end
						-- Update Scoreboard
						mod:update_stat("ammo_picked_up", account_id, picked)
						mod:update_stat("ammo_wasted", account_id, wasted)
					elseif ammo == "crate" then
						-- Calculate ammo
						local picked = max_take
						-- Message
						if mod:get("message_ammo") then
							local color = Color.gray(255, true)
							-- local message = " picked up "..TextUtilities.apply_color_to_text(string.format("%.0f", picked).." ammo ", color)
							local message = mod:localize("message_ammo_crate_text")
							local subject = mod:localize("message_ammo_ammo")
							message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
							message = string.gsub(message, ":count:", TextUtilities.apply_color_to_text(string.format("%.0f", picked), color))
							Managers.event:trigger("event_combat_feed_kill", unit, message)
						end
						-- Update Scoreboard
						mod:update_stat("ammo_picked_up", account_id, picked)
					end
				else
					mod.interaction_units[self._unit] = unit
					-- mod:log_to_file(type, self)
					-- if mod.debug_ then mod:echo("interact end "..type) end
				end
			end
		end
	end
	func(self, result, ...)
end)

mod:hook(CLASS.InteracteeExtension, "started", function(func, self, interactor_unit, ...)

	mod.interaction_units[self._unit] = interactor_unit

	-- Ammunition
	local unit_data_extension = ScriptUnit.extension(interactor_unit, "unit_data_system")
	local wieldable_component = unit_data_extension:read_component("slot_secondary")
	mod.current_ammo[interactor_unit] = wieldable_component.current_ammunition_reserve

	func(self, interactor_unit, ...)
end)

-- ##### ┬─┐┌─┐┬  ┬┬┬  ┬┌─┐   ┬   ┬─┐┌─┐┌─┐┌─┐┬ ┬┌─┐ ##################################################################
-- ##### ├┬┘├┤ └┐┌┘│└┐┌┘├┤   ┌┼─  ├┬┘├┤ └─┐│  │ │├┤  ##################################################################
-- ##### ┴└─└─┘ └┘ ┴ └┘ └─┘  └┘   ┴└─└─┘└─┘└─┘└─┘└─┘ ##################################################################

mod._get_player_presentation_name = function (self, unit)
	local player_default_color = Color.ui_hud_green_light(255, true)
	local player_unit_spawn_manager = Managers.state.player_unit_spawn
	local player = unit and player_unit_spawn_manager:owner(unit)

	if player then
		local player_name = player:name()
		local player_slot = player:slot()
		local player_slot_color = UISettings.player_slot_colors[player_slot] or player_default_color

		return TextUtilities.apply_color_to_text(player_name, player_slot_color)
	end
end

mod:hook(CLASS.PlayerInteracteeExtension, "stopped", function(func, self, result, ...)
	local type = self:interaction_type() or ""
	if result == interaction_results.success then
		local unit = self._interactor_unit
		if unit then
			local player = mod:player_from_unit(unit)
			if player then
				local account_id = player:account_id() or player:name()
				if type == "pull_up" or type == "revive" or type == "remove_net" then
					-- Message
					if mod:get("message_revived_rescued") then
						local color = Color.orange(255, true)
						-- local text = Localize(self._override_contexts.forge_material.description)
						local message = mod:localize("message_rescued_text")

						local color_name = mod:_get_player_presentation_name(self._unit)
						message = string.gsub(message, ":subject:", color_name)
						
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("rescued_operative", account_id, 1)
				elseif type == "rescue" then
					-- Message
					if mod:get("message_revived_rescued") then
						local color = Color.orange(255, true)
						-- local text = Localize(self._override_contexts.forge_material.description)
						local message = mod:localize("message_revived_text")

						local color_name = mod:_get_player_presentation_name(self._unit)
						message = string.gsub(message, ":subject:", color_name)
						
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update scoreboard
					mod:update_stat("revived_operative", account_id, 1)
				end
			end
		end
	end
	func(self, result, ...)
end)

-- ##### ┌┐ ┬  ┌─┐┌─┐┬┌─┌─┐┌┬┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬┌─┌─┐ #################################################################
-- ##### ├┴┐│  │ ││  ├┴┐├┤  ││  ├─┤ │  │ ├─┤│  ├┴┐└─┐ #################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴└─┘─┴┘  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴└─┘ #################################################################

mod:hook(CLASS.WeaponSystem, "rpc_player_blocked_attack",
function(func, self, channel_id, unit_id, attacking_unit_id, hit_world_position, block_broken, weapon_template_id, attack_type_id, ...)
	local player_unit = Managers.state.unit_spawner:unit(unit_id)
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		-- Update Scoreboard
		mod:update_stat("attacks_blocked", account_id, 1)
	end
	func(self, channel_id, unit_id, attacking_unit_id, hit_world_position, block_broken, weapon_template_id, attack_type_id, ...)
end)

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐  ┌─┐┌┐┌┌┬┐  ┬┌─┬┬  ┬  ┌─┐ #################################################################
-- #####  ││├─┤│││├─┤│ ┬├┤   ├─┤│││ ││  ├┴┐││  │  └─┐ #################################################################
-- ##### ─┴┘┴ ┴┴ ┴┴ ┴└─┘└─┘  ┴ ┴┘└┘─┴┘  ┴ ┴┴┴─┘┴─┘└─┘ #################################################################

mod.bosses = {
	"chaos_beast_of_nurgle",
	"chaos_daemonhost",
	"chaos_spawn",
	"chaos_plague_ogryn",
	"chaos_plague_ogryn_sprayer",
	"renegade_captain",
	"renegade_twin_captain",
	"renegade_twin_captain_two",
}
mod.current_health = {}
mod.last_enemy_interaction = {}

mod:hook(CLASS.AttackReportManager, "add_attack_result",
function(func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage,
	attack_result, attack_type, damage_efficiency, ...)
	local player = mod:player_from_unit(attacking_unit)
	if player then
		local account_id = player:account_id() or player:name()
		local unit_data_extension = ScriptUnit.has_extension(attacked_unit, "unit_data_system")
		local breed_or_nil = unit_data_extension and unit_data_extension:breed()
		local target_is_minion = breed_or_nil and Breed.is_minion(breed_or_nil)
		local actual_damage = damage
		local overkill_damage = 0

		-- ##### ┌─┐┬─┐┬┌┬┐┬┌─┐┌─┐┬    ┬ ┬┬┌┬┐┌─┐ #####################################################################
		-- ##### │  ├┬┘│ │ ││  ├─┤│    ├─┤│ │ └─┐ #####################################################################
		-- ##### └─┘┴└─┴ ┴ ┴└─┘┴ ┴┴─┘  ┴ ┴┴ ┴ └─┘ #####################################################################
		local player_unit_data_extension = ScriptUnit.has_extension(attacking_unit, "unit_data_system")
		local critical_strike_component = player_unit_data_extension:read_component("critical_strike")
		local is_critical_strike = critical_strike_component.is_active
		if is_critical_strike then
			mod:update_stat("critical_hits", account_id, 1)
		end

		-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌┬┐  ┬ ┬┬┌┬┐┌─┐ #################################################################
		-- ##### │││├┤ ├─┤├┴┐└─┐├─┘│ │ │   ├─┤│ │ └─┐ #################################################################
		-- ##### └┴┘└─┘┴ ┴┴ ┴└─┘┴  └─┘ ┴   ┴ ┴┴ ┴ └─┘ #################################################################
		if hit_weakspot then
			mod:update_stat("weakspot_hits", account_id, 1)
		end

		if target_is_minion then
			-- Set last interacting player_unit
			mod.last_enemy_interaction[attacked_unit] = attacking_unit

			-- Get health extension
			local current_health = mod.current_health[attacked_unit]
			local unit_health_extension = ScriptUnit.has_extension(attacked_unit, "health_system")
			local new_health = unit_health_extension and unit_health_extension:current_health()

			-- Attack result
			if attack_result == "damaged" then
				-- Current health
				if not current_health then
					current_health = new_health + damage
				end
				-- Actual damage
				actual_damage = math.min(damage, current_health)
				-- Update health
				mod.current_health[attacked_unit] = new_health

			elseif attack_result == "died" then
				-- Current health
				if not current_health then
					current_health = damage
				end
				-- Actual damage
				actual_damage = current_health
				-- Overkill damage
				overkill_damage = damage - actual_damage
				-- Update health
				mod.current_health[attacked_unit] = nil
				-- Update scoreboard
				-- mod:echo(breed_or_nil.name)
				mod:update_stat(breed_or_nil.name, account_id, 1)
			end
			
			-- Check for boss
			if table.array_contains(mod.bosses, breed_or_nil.name) then
				-- Enemy is boss
				mod:update_stat("boss_damage_dealt", account_id, actual_damage)
				mod:update_stat("overkill_damage_dealt", account_id, overkill_damage)
			else
				-- Enemy is normal
				mod:update_stat("actual_damage_dealt", account_id, actual_damage)
				mod:update_stat("overkill_damage_dealt", account_id, overkill_damage)
			end
		end
	end
	-- Original function
	return func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)
end)

mod:hook(CLASS.HuskHealthExtension, "init",
function(func, self, extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id, ...)
	-- Original function
	func(self, extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id, ...)
	-- Set health
	mod.current_health[unit] = self:max_health()
end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐┌─┐┬─┐┬  ┬┌─┐┌─┐┬┌─┬ ┬┬  ┬   #############################################################
-- ##### ├─┘│  ├─┤│  ├┤   └─┐├┤ ├┬┘└┐┌┘│ │└─┐├┴┐│ ││  │   #############################################################
-- ##### ┴  ┴─┘┴ ┴└─┘└─┘  └─┘└─┘┴└─ └┘ └─┘└─┘┴ ┴└─┘┴─┘┴─┘ #############################################################

mod:hook(CLASS.DecoderDeviceSystem, "rpc_decoder_device_place_unit", function(func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			-- local message = " operated "..TextUtilities.apply_color_to_text("Servoskull", color)
			local message = mod:localize("message_decoded_text")
			local subject = mod:localize("message_decoded_skull")
			message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	end
	func(self, channel_id, unit_id, ...)
end)

-- ##### ┌┬┐┌─┐┌─┐┌─┐┌┬┐┬┌┐┌┌─┐ #######################################################################################
-- #####  ││├┤ │  │ │ │││││││ ┬ #######################################################################################
-- ##### ─┴┘└─┘└─┘└─┘─┴┘┴┘└┘└─┘ #######################################################################################
	
mod:hook(CLASS.DecoderDeviceSystem, "rpc_decoder_device_finished", function(func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			-- local message = " used "..TextUtilities.apply_color_to_text("Scanner", color)
			local message = mod:localize("message_decoded_text")
			local subject = mod:localize("message_decoded_scanner")
			message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	else
		-- mod:echo("Someone used Scanner")
	end
	func(self, channel_id, unit_id, ...)
end)

mod:hook(CLASS.MinigameSystem, "rpc_minigame_sync_completed", function(func, self, channel_id, unit_id, is_level_unit, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		-- Message
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			-- local message = " used "..TextUtilities.apply_color_to_text("Scanner", color)
			local message = mod:localize("message_decoded_text")
			local subject = mod:localize("message_decoded_scanner")
			message = string.gsub(message, ":subject:", TextUtilities.apply_color_to_text(subject, color))
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	else
		-- mod:echo("Someone minigame complete")
	end
	func(self, channel_id, unit_id, is_level_unit, ...)
end)

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐  ┌┬┐┌─┐┬┌─┌─┐┌┐┌ ##########################################################################
-- #####  ││├─┤│││├─┤│ ┬├┤    │ ├─┤├┴┐├┤ │││ ##########################################################################
-- ##### ─┴┘┴ ┴┴ ┴┴ ┴└─┘└─┘   ┴ ┴ ┴┴ ┴└─┘┘└┘ ##########################################################################

mod:hook(CLASS.PlayerHuskHealthExtension, "fixed_update", function(func, self, unit, dt, t, ...)
	if unit then
		local player = mod:player_from_unit(unit)
		if player and self._damage and self._damage > 0 then
			local account_id = player:account_id() or player:name()
			mod:update_stat("damage_taken", account_id, self._damage)
		end
	end
	func(self, unit, dt, t, ...)
end)

-- ##### ┌─┐┬ ┬┌─┐┌┬┐┌─┐┌┬┐  ┬┌─┬┬  ┬    ┌─┐┌─┐┌─┐┌┬┐ #################################################################
-- ##### │  │ │└─┐ │ │ ││││  ├┴┐││  │    ├┤ ├┤ ├┤  ││ #################################################################
-- ##### └─┘└─┘└─┘ ┴ └─┘┴ ┴  ┴ ┴┴┴─┘┴─┘  └  └─┘└─┘─┴┘ #################################################################

mod:hook(CLASS.HudElementCombatFeed, "event_combat_feed_kill", function(func, self, attacking_unit, attacked_unit, ...)
	if type(attacked_unit) == "string" then
		local message = attacked_unit
		local color_name = self:_get_unit_presentation_name(attacking_unit) or "NONE"
		self:_add_combat_feed_message(color_name..message)
		return
	end
	return func(self, attacking_unit, attacked_unit, ...)
end)

-- ##### ████████╗███████╗███████╗████████╗ ###########################################################################
-- ##### ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝ ###########################################################################
-- #####    ██║   █████╗  ███████╗   ██║    ###########################################################################
-- #####    ██║   ██╔══╝  ╚════██║   ██║    ###########################################################################
-- #####    ██║   ███████╗███████║   ██║    ###########################################################################
-- #####    ╚═╝   ╚══════╝╚══════╝   ╚═╝    ###########################################################################
mod:hook(CLASS.ScanningEventSystem, "rpc_scanning_device_finished", function(func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local character_name = player:name()
		-- mod:echo(character_name.." scanned")
	else
		-- mod:echo("Someone scanned")
	end
	func(self, channel_id, unit_id, ...)
end)
-- ScanningDeviceExtension.finished_event = function (self)
mod:hook(CLASS.ScanningDeviceExtension, "finished_event", function(func, self, ...)
	-- local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[self._unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local character_name = player:name()
		-- mod:echo(character_name.." scanned")
	else
		-- mod:echo("Someone scanned")
	end
	func(self, ...)
end)
