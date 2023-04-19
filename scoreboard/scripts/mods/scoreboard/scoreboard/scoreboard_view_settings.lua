local mod = get_mod("scoreboard")

local scoreboard_view_settings = {
    shading_environment = "content/shading_environments/ui/system_menu",
    scoreboard_size = {1000, mod:get("scoreboard_panel_height")},
    scoreboard_row_height = 20,
    scoreboard_row_header_height = 30,
    scoreboard_row_big_height = 36,
    scoreboard_row_score_height = 36,
    scoreboard_column_width = 170,
    scoreboard_column_header_width = 300,
    scoreboard_fade_length = 0.1,
}
return settings("ScoreboardViewSettings", scoreboard_view_settings)  