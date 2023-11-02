local mod = get_mod("scoreboard")

local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")

local iteration_types = {
    ADD = {
        value = function(add_value, old_value)
            return old_value + add_value, add_value
        end,
    },
    DIFF = {
        value = function(new_value, old_value)
            return new_value, math.max(new_value - old_value, 0)
        end,
    },
    ADD_IF_ZERO = {
        value = function(add_value, old_value)
            if old_value == 0 then
                return old_value + add_value, add_value
            else
                return old_value, 0
            end
        end,
    },
}
local base_validation_types = {
    highest = function(data, account_id)
        local best = account_id
        if data[account_id] then
            local score = data[account_id].score or 0
            for name, values in pairs(data) do
                if values.score > score then
                    best = name
                    score = values.score
                end
            end
        end
        return best == account_id, best
    end,
    lowest = function(data, account_id)
        local worst = account_id
        if data[account_id] then
            local score = data[account_id].score or 0
            for name, values in pairs(data) do
                if values.score < score then
                    worst = name
                    score = values.score
                end
            end
        end
        return worst == account_id, worst
    end,
}
local validation_types = {
    ASC = {
        is_best = base_validation_types.highest,
        is_worst = base_validation_types.lowest,
        score = function(self, data, account_id)
            local score = data[account_id].score or 0
            return score
        end,
    },
    DESC = {
        is_best = base_validation_types.lowest,
        is_worst = base_validation_types.highest,
        score = function(self, data, account_id)
            local _, worst = self.is_worst(data, account_id)
            local worst_value = data[worst].score or 0
            local _, best = self.is_best(data, account_id)
            local best_value = data[best].score or 0
            local score = data[account_id].score or 0
            return (best_value - score) + worst_value
        end,
    },
    BLANK = {
        is_best = base_validation_types.highest,
        is_worst = base_validation_types.lowest,
        score = function(self, data, account_id)
            local score = data[account_id].score or 0
            return score
        end,
    },
}
if 1 == 2 then
    -- local settings = {
    --     width = 1000,
    --     height = 580,
    --     header_row = 50,
    --     header_column = 300,
    --     column = 170,
    -- }
    -- local scenegraphs = {
    --     end_view = {
    --         scoreboard = {
    --             vertical_alignment = "center",
    --             parent = "screen",
    --             horizontal_alignment = "center",
    --             size = {settings.width, settings.height},
    --             position = {0, -105, 100}
    --         },
    --         scoreboard_rows = {
    --             vertical_alignment = "top",
    --             parent = "scoreboard",
    --             horizontal_alignment = "center",
    --             size = {settings.width, settings.height},
    --             position = {0, 0, 101}
    --         },
    --     },
    --     end_player_view = {
    --         card_carousel = {
    --             horizontal_alignment = "right",
    --             position = {
    --                 -130,
    --                 350,
    --                 0
    --             }
    --         },
    --     },
    -- }
    -- local widgets = {
    --     scoreboard = {
    --         scenegraph_id = "scoreboard",
    --         {
    --             pass_type = "texture",
    --             value = "content/ui/materials/frames/dropshadow_heavy",
    --             style = {
    --                 vertical_alignment = "center",
    --                 scale_to_material = true,
    --                 horizontal_alignment = "center",
    --                 offset = {0, 0, 103},
    --                 size = {settings.width - 4, settings.height - 3},
    --                 color = Color.black(255, true),
    --                 disabled_color = Color.black(255, true),
    --                 default_color = Color.black(255, true),
    --                 hover_color = Color.black(255, true),
    --             }
    --         },
    --         {
    --             pass_type = "texture",
    --             value = "content/ui/materials/frames/inner_shadow_medium",
    --             style = {
    --                 vertical_alignment = "center",
    --                 scale_to_material = true,
    --                 horizontal_alignment = "center",
    --                 offset = {0, 0, 103},
    --                 size = {settings.width - 24, settings.height - 28},
    --                 color = Color.terminal_grid_background(255, true),
    --                 disabled_color = Color.terminal_grid_background(255, true),
    --                 default_color = Color.terminal_grid_background(255, true),
    --                 hover_color = Color.terminal_grid_background(255, true),
    --             }
    --         },
    --         {
    --             value = "content/ui/materials/backgrounds/terminal_basic",
    --             pass_type = "texture",
    --             style = {
    --                 vertical_alignment = "center",
    --                 scale_to_material = true,
    --                 horizontal_alignment = "center",
    --                 offset = {0, 0, 102},
    --                 color = Color.terminal_grid_background(255, true),
    --                 disabled_color = Color.terminal_grid_background(255, true),
    --                 default_color = Color.terminal_grid_background(255, true),
    --                 hover_color = Color.terminal_grid_background(255, true),
    --                 size = {settings.width - 4, settings.height},
    --             }
    --         },
    --         {
    --             pass_type = "texture",
    --             value = "content/ui/materials/frames/premium_store/details_upper",
    --             style = {
    --                 vertical_alignment = "center",
    --                 scale_to_material = true,
    --                 horizontal_alignment = "center",
    --                 offset = {0, -settings.height / 2, 104},
    --                 size = {settings.width, 80},
    --                 color = Color.gray(255, true),
    --                 disabled_color = Color.gray(255, true),
    --                 default_color = Color.gray(255, true),
    --                 hover_color = Color.gray(255, true),
    --             }
    --         },
    --         {
    --             pass_type = "texture",
    --             value = "content/ui/materials/frames/premium_store/details_lower_basic",
    --             style = {
    --                 vertical_alignment = "center",
    --                 scale_to_material = true,
    --                 horizontal_alignment = "center",
    --                 offset = {0, settings.height / 2 - 50, 104},
    --                 size = {settings.width + 50, 120},
    --                 color = Color.gray(255, true),
    --                 disabled_color = Color.gray(255, true),
    --                 default_color = Color.gray(255, true),
    --                 hover_color = Color.gray(255, true),
    --             }
    --         },
    --     },
    -- }
    -- local alternate_row_style = {
    --     value = "",
    --     pass_type = "texture",
    --     style = {
    --         horizontal_alignment = "left",
    --         color = Color.terminal_frame(200, true),
    --         disabled_color = Color.terminal_frame(200, true),
    --         default_color = Color.terminal_frame(200, true),
    --         hover_color = Color.terminal_frame(200, true),
    --         size = {settings.width - 30, 0},
    --         offset = {16, 0, 0},
    --     }
    -- }
end
return {
    validation_types = validation_types,
    iteration_types = iteration_types,
    -- settings = settings,
    -- scenegraphs = scenegraphs,
    -- widgets = widgets,
    -- alternate_row_style = alternate_row_style,
}