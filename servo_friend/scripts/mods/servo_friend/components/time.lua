local mod = get_mod("servo_friend")

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

mod.has_timer = function(self, timer)
    return self.time_manager and self.time_manager:has_timer(timer)
end

mod.main_time = function(self)
	return self.time_manager and self.time_manager:time("main")
end

mod.game_time = function(self)
	return self.time_manager and self:has_timer("gameplay") and self.time_manager:time("gameplay")
end

mod.time = function(self)
    return self:game_time() or self:main_time()
end

mod.main_delta_time = function(self)
    return self.time_manager and self.time_manager:delta_time("main")
end

mod.game_delta_time = function(self)
    return self.time_manager and self:has_timer("gameplay") and self.time_manager:delta_time("gameplay")
end

mod.delta_time = function(self)
    return self:game_delta_time() or self:main_delta_time()
end