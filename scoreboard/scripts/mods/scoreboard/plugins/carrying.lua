local mod = get_mod("scoreboard")

local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")

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

-- mod.scoreboard_rows = table.merge(table.shallow_copy(mod.scoreboard_rows), {
--     {
--         name = "carrying",
--         text = "Carried Scripture / Grimoire / Other",
--         value = "/          /",
--         validation = ScoreboardDefinitions.validation_types.ASC,
--         iteration = ScoreboardDefinitions.iteration_types.ADD,
--         -- row_height = mod.medium_row.height,
--         -- font_size = mod.medium_row.font,
--         -- indentation = 15 + mod.base_indentation,
--         -- score_multiplier = true,
--         score_summary = {
--             "carrying_tomes",
--             "carrying_grims",
--             "carrying_other",
--         },
--         empty = true,
--     },
--     {
-- 		name = "carrying_tomes",
--         text = "Scripture",
-- 		validation = ScoreboardDefinitions.validation_types.ASC,
-- 		iteration = ScoreboardDefinitions.iteration_types.ADD,
-- 		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
-- 		-- offset = {-40, -mod.medium_row.height, 3},
-- 		-- indentation = 98 + mod.base_indentation,
-- 		-- divider = 5,
-- 		-- decimals = 1,
-- 		-- score_addition = "s",
-- 		is_time = true,
-- 	},
-- 	{
-- 		name = "carrying_grims",
--         text = "Grimoire",
-- 		validation = ScoreboardDefinitions.validation_types.ASC,
-- 		iteration = ScoreboardDefinitions.iteration_types.ADD,
-- 		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
-- 		-- offset = {0, -mod.medium_row.height, 3},
-- 		-- indentation = 118 + mod.base_indentation,
-- 		-- divider = 5,
-- 		-- decimals = 1,
-- 		-- score_addition = "s",
-- 		is_time = true,
-- 	},
-- 	{
-- 		name = "carrying_other",
--         text = "Other",
-- 		validation = ScoreboardDefinitions.validation_types.ASC,
-- 		iteration = ScoreboardDefinitions.iteration_types.ADD,
-- 		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
-- 		-- offset = {40, -mod.medium_row.height, 3},
-- 		-- indentation = 135 + mod.base_indentation,
-- 		-- divider = 5,
-- 		-- decimals = 1,
-- 		-- score_addition = "s",
-- 		is_time = true,
-- 	},
-- })
