local mod = get_mod("scoreboard_example_plugin")
-- Get scoreboard reference
local scoreboard = get_mod("scoreboard")

-- Hook jumping state
mod:hook(CLASS.PlayerCharacterStateJumping, "on_enter", function(func, self, unit, ...)
    func(self, unit, ...)
    -- Check scoreboard; could not be installed
    if scoreboard then
        local player = scoreboard:player_from_unit(unit)
        if player then
            -- Get account id from player
            -- Bots don't have account ids; use name instead
            local account_id = player:account_id() or player:name()
            -- Update stat
            scoreboard:update_stat("scoreboard_example", account_id, 1)
        end
    end
end)

-- Define rows
mod.scoreboard_rows = {
    {name = "scoreboard_example",
		text = "row_scoreboard_example",
		validation = "ASC",
		iteration = "ADD",
		group = "example",
		setting = "show_row",
	},
}
