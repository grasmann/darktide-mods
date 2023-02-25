local mod = get_mod("animation_events")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.callbacks = {}

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

function mod.on_game_state_changed(status, state_name)
	if state_name == "StateGameplay" and status == "exit" then
		mod:clear_indices()
	end
end

function mod.reload_mods()
	mod:clear_indices()
	mod:echo("lol")
end

function mod.on_all_mods_loaded()
	-- for _, this_mod in pairs(DMF.mods) do
	-- 	if type(this_mod) == "table" then
	-- 		if this_mod.animation_events then
	-- 			for event_name, callback in pairs(this_mod.animation_events) do
	-- 				mod:register_callback(event_name, callback)
	-- 			end
	-- 		end
	-- 	end
	-- end
	mod:initialize()
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Get player from player_unit
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

mod.collect_mod_definitions = function(self)
	local mod_definitions = {}
	for _, this_mod in pairs(DMF.mods) do
		if type(this_mod) == "table" then
			if this_mod.animation_events then
				mod_definitions[#mod_definitions+1] = this_mod.animation_events
			end
		end
	end
	return mod_definitions
end

mod.initialize = function(self)
	local mod_definitions = self:collect_mod_definitions()
	for _, mod_definition in pairs(mod_definitions) do
		for event_name, callback in pairs(mod_definition) do
			self:register_callback(event_name, callback)
		end
	end
end

mod.register_callback = function(self, event_name, callback)
	self.callbacks[#self.callbacks+1] = {
		event_name = event_name,
		callback = callback,
	}
end

mod.handle_callbacks = function(self, event_name, event_index, unit, first_person, context)
	for _, callback in pairs(self.callbacks) do
		if callback.event_name == event_name or callback.event_name == "__all" then
			callback.callback(event_name, event_index, unit, first_person, context)
		end
	end
end

mod.clear_indices = function(self)
    self.minion_event_indices = {}
	self.rpc_event_indices = {}
end

-- ##### ██╗███╗   ██╗ ██████╗██╗     ██╗   ██╗██████╗ ███████╗███████╗ ###############################################
-- ##### ██║████╗  ██║██╔════╝██║     ██║   ██║██╔══██╗██╔════╝██╔════╝ ###############################################
-- ##### ██║██╔██╗ ██║██║     ██║     ██║   ██║██║  ██║█████╗  ███████╗ ###############################################
-- ##### ██║██║╚██╗██║██║     ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║ ###############################################
-- ##### ██║██║ ╚████║╚██████╗███████╗╚██████╔╝██████╔╝███████╗███████║ ###############################################
-- ##### ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ###############################################

Mods.file.dofile("animation_events/scripts/mods/animation_events/animation_events_player")
Mods.file.dofile("animation_events/scripts/mods/animation_events/animation_events_server")
Mods.file.dofile("animation_events/scripts/mods/animation_events/animation_events_rpc")
Mods.file.dofile("animation_events/scripts/mods/animation_events/animation_events_minion")
