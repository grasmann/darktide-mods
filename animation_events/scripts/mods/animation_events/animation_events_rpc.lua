local mod = get_mod("animation_events")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.debug = false
mod.event_indices = {}
mod.rpc_anim_events = {
	"equip_crate",
	"drop",
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

mod.log_to_file = function(self, name, obj)
	mdods(obj, name.."_"..tostring(os.time()), 5)
end

mod.clear_indices = function(self)
	self.event_indices = {}
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

-- Get event indices
mod.get_unit_indices = function(self, unit, wielded_slot)
    -- Initialize unit event list
    self.event_indices[unit] = self.event_indices[unit] or {}
	-- Initialize slot
	self.event_indices[unit][wielded_slot] = self.event_indices[unit][wielded_slot] or {}
    -- Check if unit has state machine
    if Unit.has_animation_state_machine(unit) then
        -- Iterate through animation events
        for _, event_name in pairs(self.rpc_anim_events) do
            -- Check if event is already set
            if not self.event_indices[unit][wielded_slot][event_name] then
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
						self.event_indices[unit][wielded_slot][event_name] = index
					else
						-- Write cache dummy to prevent redetection
						self.event_indices[unit][wielded_slot][event_name] = nil
					end
				else
					-- Write cache dummy to prevent redetection
					self.event_indices[unit][wielded_slot][event_name] = false
                end
            end
        end
    end
end

-- Find event name by index
mod.find_event_name = function(self, player_unit, wielded_slot, event_index, is_first_person)
	local index_unit = player_unit
	-- First person
	if is_first_person then
		-- First person unit
		local first_person_ext = ScriptUnit.extension(player_unit, "first_person_system")
		index_unit = first_person_ext:first_person_unit()
	end
	-- Get indices if neccessary
	self:get_unit_indices(index_unit, wielded_slot)
	-- Check if unit list exists
	if self.event_indices[index_unit][wielded_slot] then
		-- Iterate through unit event list
		for event_name, index in pairs(self.event_indices[index_unit][wielded_slot]) do
			-- Compare index
			if index == event_index then
				-- Return name
				return event_name
			end
		end
	end
end

mod.handle_event = function(self, event_index, unit_id, is_first_person)
	-- Get player unit
	local unit = Managers.state.unit_spawner:unit(unit_id)
	-- Get unit data system
	local unit_data_system = ScriptUnit.extension(unit, "unit_data_system")
	-- Check unit data system
	if unit_data_system then
		-- Get inventory component
		local inventory_component = unit_data_system:read_component("inventory")
		-- Check inventory component
		if inventory_component then
			-- Get wielded slot
			local wielded_slot = inventory_component.wielded_slot
			-- Check wielded slot
			if wielded_slot then
				-- Get event name
				local event_name = self:find_event_name(unit, wielded_slot, event_index, is_first_person)
				-- Check event name
				if event_name then
					-- Handle event callbacks
					self:handle_callbacks(event_name, event_index, unit, is_first_person, "rpc")
				end
			end
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event", function(func, self, channel_id, unit_id, event_index, is_first_person, ...)
	mod:handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_float", function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
	mod:handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_floats", function(func, self, channel_id, unit_id, event_index, variable_indexes, variable_values, is_first_person, ...)
	mod:handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_indexes, variable_values, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_int", function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
	mod:handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
end)