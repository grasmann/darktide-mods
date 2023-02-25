local mod = get_mod("animation_events")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.minion_anim_events = {
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
    "stagger_fwd_heavy",
    "stagger_fwd_heavy_2",
    "stagger_fwd_heavy_3",
    "stagger_fwd_heavy_4",
    "stagger_fwd_heavy_5",
    "stagger_fwd_heavy_6",
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
    "stagger_bwd_heavy",
    "stagger_bwd_heavy_2",
    "stagger_bwd_heavy_3",
    "stagger_bwd_heavy_4",
    "stagger_bwd_heavy_5",
    "stagger_bwd_heavy_6",
    "stagger_bwd_heavy_7",
    "stagger_bwd_heavy_8",
    "stagger_bwd_heavy_9",
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
    "stagger_left_heavy",
    "stagger_left_heavy_2",
    "stagger_left_heavy_3",
    "stagger_left_heavy_4",
    "stagger_left_heavy_5",
    "stagger_left_heavy_6",
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
    "stagger_right_heavy",
    "stagger_right_heavy_2",
    "stagger_right_heavy_3",
    "stagger_right_heavy_4",
    "stagger_right_heavy_5",
    "stagger_right_heavy_6",
    "stagger_right_sticky",
    "stagger_right_sticky_2",
    "stagger_right_sticky_3",
    "run_stagger_right",

    "shotgun_run_stagger_01",
    "shotgun_run_stagger_02",
    "shotgun_run_stagger_03",
    "shotgun_run_stagger_04",

    "stagger_up_heavy",
    "stagger_up_heavy_2",
    "stagger_up_heavy_3",
    
    "stun_down",
    "stagger_downward",
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

    "stagger_shield_block_01",
    "stagger_shield_block_02",
    "stagger_shield_block_03",
    "stagger_shield_block_04",
    "stagger_shield_block_05",

    "stagger_shield_block_right",
    "stagger_shield_block_left",
}
mod.more_points = {
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
    
}
mod.minion_event_indices = {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

mod.clear_indices = function(self)
    self.minion_event_indices = {}
end

-- Get event indices
mod.get_unit_indices = function(self, unit)
    -- Initialize unit event list
    self.minion_event_indices[unit] = self.minion_event_indices[unit] or {}
    -- Check if unit has state machine
    if Unit.has_animation_state_machine(unit) then
        -- Iterate through animation events
        for _, event_name in pairs(self.minion_anim_events) do
            -- Check if event is already set
            if not self.minion_event_indices[unit][event_name] then
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
                        self.minion_event_indices[unit][event_name] = index
                    else
                        -- Write cache dummy to prevent redetection
                        self.minion_event_indices[unit][event_name] = nil
                    end
                else
                    -- Write cache dummy to prevent redetection
                    self.minion_event_indices[unit][event_name] = false
                end
            end
        end
    end
end

-- Find event name by index
mod.find_event_name = function(self, unit, event_index)
    -- Get indices if neccessary
    self:get_unit_indices(unit)
    -- Check if unit list exists
    if self.minion_event_indices[unit] then
        -- Iterate through unit event list
        for event_name, index in pairs(self.minion_event_indices[unit]) do
            -- Compare index
            if index == event_index then
                -- Return name
                return event_name
            end
        end
    end
end

-- Check for heavy stagger
mod.is_heavy_stagger = function(self, event_name)
    return table.contains(self.more_points, event_name)
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook(CLASS.AnimationSystem, "rpc_minion_anim_event", function(func, self, channel_id, unit_id, event_index, ...)
    local unit = Managers.state.unit_spawner:unit(unit_id)
    -- Find event
    local event_name = mod:find_event_name(unit, event_index)
    if event_name then
        -- Normal or heavy
        local event = mod:is_heavy_stagger(event_name) and "enemy_stagger_heavy" or "enemy_stagger"
        -- Handle event
        mod:handle_callbacks(event, event_index, unit, false, "minion")
    end
    -- Original function
    return func(self, channel_id, unit_id, event_index, ...)
end)

mod:hook(CLASS.AnimationSystem, "rpc_minion_anim_event_variable_float", function(func, self, channel_id, unit_id, event_index, variable_index, variable_value, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id)
    -- Find event
    local event_name = mod:find_event_name(unit, event_index)
    if event_name then
        -- Normal or heavy
        local event = mod:is_heavy_stagger(event_name) and "enemy_stagger_heavy" or "enemy_stagger"
        -- Handle event
        mod:handle_callbacks(event, event_index, unit, false, "minion")
    end
    -- Original function
    return func(self, channel_id, unit_id, event_index, variable_index, variable_value, ...)
end)

mod:hook(CLASS.MinionAnimationExtension, "anim_event", function(func, self, event_name, optional_except_channel_id, ...)
    -- Check for event name
    if table.contains(mod.minion_anim_events, event_name) then
        -- Normal or heavy
        local event = mod:is_heavy_stagger(event_name) and "enemy_stagger_heavy" or "enemy_stagger"
        -- Handle event
        mod:handle_callbacks(event, nil, self._unit, false, "minion")
    else
        -- mod:echo(event_name)
    end
    -- Original function
    return func(self, event_name, optional_except_channel_id, ...)
end)

mod:hook(CLASS.MinionAnimationExtension, "anim_event_with_variable_float", function(func, self, event_name, variable_name, variable_value, ...)
    -- Check for event name
    if table.contains(mod.minion_anim_events, event_name) then
        -- Normal or heavy
        local event = mod:is_heavy_stagger(event_name) and "enemy_stagger_heavy" or "enemy_stagger"
        -- Handle event
        mod:handle_callbacks(event, nil, self._unit, false, "minion")
    else
        -- mod:echo(event_name)
    end
    -- Original function
    return func(self, event_name, variable_name, variable_value, ...)
end)
