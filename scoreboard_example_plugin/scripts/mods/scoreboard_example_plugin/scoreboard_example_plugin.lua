local mod = get_mod("scoreboard_example_plugin")
local scoreboard = get_mod("scoreboard")
local DMF = get_mod("DMF")

mod:hook(CLASS.PlayerCharacterStateJumping, "on_enter", function(func, self, unit, ...)
    func(self, unit, ...)
    if scoreboard then
        local player = scoreboard:player_from_unit(unit)
        if player then
            scoreboard:update_stat("scoreboard_example", player:account_id(), 1)
        end
    end
end)

--DMFOptionsView.cb_on_category_pressed = function (self, widget, entry)
mod:hook(CLASS.DMFOptionsView, "on_enter", function(func, self, ...)
    func(self, ...)
    mod:echo("lol")
end)

mod.scoreboard_rows = {
    {name = "scoreboard_example",
		text = "row_scoreboard_example",
		validation = "ASC",
		iteration = "ADD",
		group = "example",
		setting = "show_row",
	},
}
