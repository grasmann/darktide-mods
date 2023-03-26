local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")

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

-- mod.scoreboard_rows = table.merge(table.shallow_copy(mod.scoreboard_rows), {
--     {
--         mod = mod,
-- 		name = "coherency_efficiency",
--         text = "Coherency Efficiency",
-- 		validation = ScoreboardDefinitions.validation_types.ASC,
-- 		iteration = ScoreboardDefinitions.iteration_types.ADD,
--         example = {80, 100},
--         group = "defense",
--         normalize = true,
--         update = mod.update_coherency,

-- 		-- row_height = mod.medium_row.height,
--         -- font_size = mod.medium_row.font,
-- 		-- indentation = 15 + mod.base_indentation,
-- 		-- score_multiplier = true,
-- 		-- score_row = true,
-- 	},
-- })