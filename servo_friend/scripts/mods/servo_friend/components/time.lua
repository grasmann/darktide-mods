local mod = get_mod("servo_friend")

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

local managers = Managers

mod.time_manager_ref = function(self)
    return self.time_manager or managers and managers.time
end

mod.has_timer = function(self, timer)
    local time_manager = self:time_manager_ref()
    return time_manager and timer and time_manager:has_timer(timer) or false
end

mod.main_time = function(self)
    local time_manager = self:time_manager_ref()
    return time_manager and time_manager:time("main") or 0
end

mod.game_time = function(self)
    local time_manager = self:time_manager_ref()
    if time_manager and self:has_timer("gameplay") then
        return time_manager:time("gameplay")
    end
end

mod.time = function(self)
    return self:game_time() or self:main_time() or 0
end

mod.main_delta_time = function(self)
    local time_manager = self:time_manager_ref()
    return time_manager and time_manager:delta_time("main") or 0
end

mod.game_delta_time = function(self)
    local time_manager = self:time_manager_ref()
    if time_manager and self:has_timer("gameplay") then
        return time_manager:delta_time("gameplay")
    end
end

mod.delta_time = function(self)
    return self:game_delta_time() or self:main_delta_time() or 0
end
