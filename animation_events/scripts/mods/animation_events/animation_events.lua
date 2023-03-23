local mod = get_mod("animation_events")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.events = {}
mod.all_events = {}
mod.packs = {}
mod.callbacks = {}
mod.event_indices = {}

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
	mod:initialize()
end

function mod.on_all_mods_loaded()
	mod:initialize()
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Get event indices
mod.get_unit_indices = function(self, unit, context)
    -- Initialize unit event list
	self.event_indices[context] = self.event_indices[context] or {}
    self.event_indices[context][unit] = self.event_indices[context][unit] or {}
    -- Check if unit has state machine
    if Unit.has_animation_state_machine(unit) then
        -- Iterate through animation events
        for event_name, _ in pairs(self.all_events) do
            -- Check if event is already set
            if not self.event_indices[context][unit][event_name] then
                local index = nil
                -- Check if unit has animation event
                -- index = Unit.has_animation_event(unit, event_name)
                if Unit.has_animation_event(unit, event_name) then
                    -- Get animation state
                    local animation_state = Unit.animation_get_state(unit)
                    -- Play animation to get index
                    index = Unit.animation_event(unit, event_name)
                    -- Reset animation state
                    Unit.animation_set_state(unit, unpack(animation_state))
                    -- Check index
                    if index then
                        -- Write to cache
                        self.event_indices[context][unit][event_name] = index
                    else
                        -- Write cache dummy to prevent redetection
                        self.event_indices[context][unit][event_name] = nil
                    end
                else
                    -- Write cache dummy to prevent redetection
                    self.event_indices[context][unit][event_name] = false
                end
            end
        end
    end
end

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
	for _, this_mod in pairs(DMF.mods) do
		if type(this_mod) == "table" then
			-- Animation packs
			if this_mod.animation_events_add_packs then
				self.packs[#self.packs+1] = this_mod.animation_events_add_packs
				for event, pack in pairs(this_mod.animation_events_add_packs) do
					for _, event_name in pairs(pack) do
						self.all_events[event_name] = true
					end
				end
			end
			-- Animation events
			if this_mod.animation_events_add_callbacks then
				self.events[#self.events+1] = this_mod.animation_events_add_callbacks
				for event_name, _ in pairs(this_mod.animation_events_add_callbacks) do
					self.all_events[event_name] = true
				end
			end
		end
	end
end

mod.initialize = function(self)
	self:collect_mod_definitions()
	for _, event in pairs(self.events) do
		for event_name, callback in pairs(event) do
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

mod.find_pack_entries = function(self, event_name)
	local relevant_events = {}
	-- Iterate mod packs
	for _, mod_pack in pairs(self.packs) do
		-- Iterate packs
		for event, event_pack in pairs (mod_pack) do
			if table.array_contains(event_pack, event_name) then
				relevant_events[#relevant_events+1] = event
			end
		end
	end
	return relevant_events
end

mod.handle_callbacks = function(self, event_name, event_index, unit, first_person, context)
	for _, callback in pairs(self.callbacks) do
		if callback.event_name == event_name or callback.event_name == "__all" then
			callback.callback(event_name, event_index, unit, first_person, context)
		end
		local pack_events = self:find_pack_entries(event_name)
		if #pack_events > 0 then
			for _, event in pairs(pack_events) do
				callback.callback(event, event_index, unit, first_person, context)
			end
		end
	end
end

mod.clear_indices = function(self)
	self.event_indices = {}
end

-- ##### ██╗███╗   ██╗ ██████╗██╗     ██╗   ██╗██████╗ ███████╗███████╗ ###############################################
-- ##### ██║████╗  ██║██╔════╝██║     ██║   ██║██╔══██╗██╔════╝██╔════╝ ###############################################
-- ##### ██║██╔██╗ ██║██║     ██║     ██║   ██║██║  ██║█████╗  ███████╗ ###############################################
-- ##### ██║██║╚██╗██║██║     ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║ ###############################################
-- ##### ██║██║ ╚████║╚██████╗███████╗╚██████╔╝██████╔╝███████╗███████║ ###############################################
-- ##### ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ###############################################

mod:io_dofile("animation_events/scripts/mods/animation_events/animation_events_player")
mod:io_dofile("animation_events/scripts/mods/animation_events/animation_events_server")
mod:io_dofile("animation_events/scripts/mods/animation_events/animation_events_rpc")
mod:io_dofile("animation_events/scripts/mods/animation_events/animation_events_minion")
