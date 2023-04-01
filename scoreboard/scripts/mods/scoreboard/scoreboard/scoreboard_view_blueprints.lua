local mod = get_mod("scoreboard")

local OptionsViewSettings = mod:original_require("scripts/ui/views/options_view/options_view_settings")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local ScoreboardViewSettings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")

local grid_size = OptionsViewSettings.grid_size
local grid_width = grid_size[1]
local settings_grid_width = 1000
local settings_value_width = 500
local settings_value_height = 64
local base_z = 0

local settings_ = {
    width = 1000,
    height = 580,
    header_row = 50,
    header_column = 300,
    column = 170,
}

local blueprints = {
    scoreboard_row = {
        size = {
			grid_width,
			ScoreboardViewSettings.scoreboard_row_height,
		},
		pass_template = {
            -- scenegraph_id = "scoreboard_rows",
            {
                value_id = "text",
                value = "text",
                pass_type = "text",
                style = {
		            offset = {30, 0, base_z + 1},
		            size = {ScoreboardViewSettings.scoreboard_column_header_width - 30, ScoreboardViewSettings.scoreboard_row_height},
		            font_size = 16,
		            text_horizontal_alignment = "left",
		            text_vertical_alignment = "center",
		            text_color = Color.terminal_text_header(255, true),
		            color = Color.white(200, true),
		            default_color = Color.white(200, true),
		            hover_color = Color.white(200, true),
		            disabled_color = Color.white(200, true),
		            visible = true
                },
                custom = true,
            },
            {
                value = "",
				pass_type = "text",
				style = {
					visible = false,
				},
				custom = true,
            },
            {
                value_id = "text1",
                value = "text1",
                pass_type = "text",
                style = {
		            offset = {ScoreboardViewSettings.scoreboard_column_header_width, 0, base_z + 1},
		            size = {ScoreboardViewSettings.scoreboard_column_width, ScoreboardViewSettings.scoreboard_row_height},
		            font_size = 16,
		            text_horizontal_alignment = "center",
		            text_vertical_alignment = "center",
		            text_color = Color.terminal_text_header(255, true),
		            color = Color.white(200, true),
		            default_color = Color.white(200, true),
		            hover_color = Color.white(200, true),
		            disabled_color = Color.white(200, true),
		            visible = true
                },
                custom = true,
            },
            {
                value = "",
				pass_type = "text",
				style = {
					visible = false,
				},
				custom = true,
            },
            {
                value_id = "text2",
                value = "text2",
                pass_type = "text",
                style = {
		            offset = {ScoreboardViewSettings.scoreboard_column_header_width + ScoreboardViewSettings.scoreboard_column_width, 0, base_z + 1},
		            size = {ScoreboardViewSettings.scoreboard_column_width, ScoreboardViewSettings.scoreboard_row_height},
		            font_size = 16,
		            text_horizontal_alignment = "center",
		            text_vertical_alignment = "center",
		            text_color = Color.terminal_text_header(255, true),
		            color = Color.white(200, true),
		            default_color = Color.white(200, true),
		            hover_color = Color.white(200, true),
		            disabled_color = Color.white(200, true),
		            visible = true
                },
                custom = true,
            },
            {
                value = "",
				pass_type = "text",
				style = {
					visible = false,
				},
				custom = true,
            },
            {
                value_id = "text3",
                value = "text3",
                pass_type = "text",
                style = {
		            offset = {ScoreboardViewSettings.scoreboard_column_header_width + ScoreboardViewSettings.scoreboard_column_width*2, 0, base_z + 1},
		            size = {ScoreboardViewSettings.scoreboard_column_width, ScoreboardViewSettings.scoreboard_row_height},
		            font_size = 16,
		            text_horizontal_alignment = "center",
		            text_vertical_alignment = "center",
		            text_color = Color.terminal_text_header(255, true),
		            color = Color.white(200, true),
		            default_color = Color.white(200, true),
		            hover_color = Color.white(200, true),
		            disabled_color = Color.white(200, true),
		            visible = true
                },
                custom = true,
            },
            {
                value = "",
				pass_type = "text",
				style = {
					visible = false,
				},
				custom = true,
            },
            {
                value_id = "text4",
                value = "text4",
                pass_type = "text",
                style = {
		            offset = {ScoreboardViewSettings.scoreboard_column_header_width + ScoreboardViewSettings.scoreboard_column_width*3, 0, base_z + 1},
		            size = {ScoreboardViewSettings.scoreboard_column_width, ScoreboardViewSettings.scoreboard_row_height},
		            font_size = 16,
		            text_horizontal_alignment = "center",
		            text_vertical_alignment = "center",
		            text_color = Color.terminal_text_header(255, true),
		            color = Color.white(200, true),
		            default_color = Color.white(200, true),
		            hover_color = Color.white(200, true),
		            disabled_color = Color.white(200, true),
		            visible = true
                },
                custom = true,
            },
            {
                value = "",
                pass_type = "texture",
                style = {
                    horizontal_alignment = "left",
                    color = Color.terminal_frame(200, true),
                    disabled_color = Color.terminal_frame(200, true),
                    default_color = Color.terminal_frame(200, true),
                    hover_color = Color.terminal_frame(200, true),
                    size = {settings_.width - 32, 0},
                    offset = {16, 0, base_z},
                }
            },
        }
    },
	settings_button = {
		size = {
			grid_width,
			settings_value_height
		},
		pass_template = ButtonPassTemplates.list_button_with_icon,
		init = function (parent, widget, entry, callback_name)
			local content = widget.content
			local hotspot = content.hotspot

			hotspot.pressed_callback = function ()
				local is_disabled = entry.disabled or false

				if is_disabled then
					return
				end

				callback(parent, callback_name, widget, entry)()
			end

			local display_name = entry.display_name
			content.text = Managers.localization:localize(display_name)
			content.icon = entry.icon
			content.entry = entry
		end
	},
}

return settings("OptionsViewContentBlueprints", blueprints)