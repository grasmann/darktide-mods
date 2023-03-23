local mod = get_mod("animation_events")

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Find event name by index
mod.rpc_find_event_name = function(self, player_unit, wielded_slot, event_index, is_first_person)
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
	if self.event_indices[wielded_slot][index_unit] then
		-- Iterate through unit event list
		for event_name, index in pairs(self.event_indices[wielded_slot][index_unit]) do
			-- Compare index
			if index == event_index then
				-- Return name
				return event_name
			end
		end
	end
end

-- Handle animation event
mod.rpc_handle_event = function(self, event_index, unit_id, is_first_person)
	-- Get player unit
	local unit = Managers.state.unit_spawner:unit(unit_id)
	-- Get unit data system
	local unit_data_system = ScriptUnit.extension(unit, "unit_data_system")
	if unit_data_system then
		-- Get inventory component
		local inventory_component = unit_data_system:read_component("inventory")
		if inventory_component then
			-- Get wielded slot
			local wielded_slot = inventory_component.wielded_slot
			if wielded_slot then
				-- Get event name
				local event_name = self:rpc_find_event_name(unit, wielded_slot, event_index, is_first_person)
				if event_name and self.all_events[event_name] then
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

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event",
function(func, self, channel_id, unit_id, event_index, is_first_person, ...)
	mod:rpc_handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_float",
function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
	mod:rpc_handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_floats",
function(func, self, channel_id, unit_id, event_index, variable_indexes, variable_values, is_first_person, ...)
	mod:rpc_handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_indexes, variable_values, is_first_person, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_player_anim_event_variable_int",
function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
	mod:rpc_handle_event(event_index, unit_id, is_first_person)
	return func(self, channel_id, unit_id, event_index, variable_index, variable_value, is_first_person, ...)
end)