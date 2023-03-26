local mod = get_mod("scoreboard")

local UIWorkspaceSettings = mod:original_require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ScoreboardViewSettings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")

-- local settings_ = {
--     width = 1000,
--     height = 580,
--     header_row = 50,
--     header_column = 300,
--     column = 170,
-- }

local scenegraph_definition = {
    screen = UIWorkspaceSettings.screen,
    scoreboard = {
        vertical_alignment = "center",
        parent = "screen",
        horizontal_alignment = "center",
        size = {ScoreboardViewSettings.scoreboard_size[1], ScoreboardViewSettings.scoreboard_size[2]},
        position = {0, -105, 0}
    },
    scoreboard_rows = {
        vertical_alignment = "top",
        parent = "scoreboard",
        horizontal_alignment = "center",
        size = {ScoreboardViewSettings.scoreboard_size[1], ScoreboardViewSettings.scoreboard_size[2] - 100},
        position = {0, 150, 1}
    },
}

local widget_definitions = {
    scoreboard = UIWidget.create_definition({
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/dropshadow_heavy",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {0, 0, 1},
                size = {ScoreboardViewSettings.scoreboard_size[1] - 4, ScoreboardViewSettings.scoreboard_size[2] - 3},
                color = Color.black(255, true),
                disabled_color = Color.black(255, true),
                default_color = Color.black(255, true),
                hover_color = Color.black(255, true),
            }
        },
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/inner_shadow_medium",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {0, 0, 1},
                size = {ScoreboardViewSettings.scoreboard_size[1] - 24, ScoreboardViewSettings.scoreboard_size[2] - 28},
                color = Color.terminal_grid_background(255, true),
                disabled_color = Color.terminal_grid_background(255, true),
                default_color = Color.terminal_grid_background(255, true),
                hover_color = Color.terminal_grid_background(255, true),
            }
        },
        {
            value = "content/ui/materials/backgrounds/terminal_basic",
            pass_type = "texture",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {0, 0, 0},
                size = {ScoreboardViewSettings.scoreboard_size[1] - 4, ScoreboardViewSettings.scoreboard_size[2]},
                color = Color.terminal_grid_background(255, true),
                disabled_color = Color.terminal_grid_background(255, true),
                default_color = Color.terminal_grid_background(255, true),
                hover_color = Color.terminal_grid_background(255, true),
            }
        },
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/premium_store/details_upper",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {0, -ScoreboardViewSettings.scoreboard_size[2] / 2, 2},
                size = {ScoreboardViewSettings.scoreboard_size[1], 80},
                color = Color.gray(255, true),
                disabled_color = Color.gray(255, true),
                default_color = Color.gray(255, true),
                hover_color = Color.gray(255, true),
            }
        },
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/premium_store/details_lower_basic",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {0, ScoreboardViewSettings.scoreboard_size[2] / 2 - 50, 2},
                size = {ScoreboardViewSettings.scoreboard_size[1] + 50, 120},
                color = Color.gray(255, true),
                disabled_color = Color.gray(255, true),
                default_color = Color.gray(255, true),
                hover_color = Color.gray(255, true),
            }
        },
    }, "screen"),
}

local legend_inputs = {
    {
        input_action = "hotkey_menu_special_1",
        on_pressed_callback = "cb_on_save_pressed",
        display_name = "loc_scoreboard_save",
        alignment = "left_alignment"
    },
}

local ScoreboardViewDefinitions = {
    legend_inputs = legend_inputs,
    widget_definitions = widget_definitions,
    scenegraph_definition = scenegraph_definition
}

return settings("ScoreboardViewDefinitions", ScoreboardViewDefinitions)