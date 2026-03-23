local mod = get_mod("scoreboard")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local CLASS = CLASS
local pairs = pairs
local Color = Color
local Managers = Managers


local ScoreboardViewSettings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local base_z = 100
local base_x = 135

mod.tactical_overview = mod:get("tactical_overview")

-- Make tactical overlay available in meat grinder
mod:hook_require("scripts/ui/hud/hud_elements_player_onboarding", function(instance)
    local found = false
    -- Check if another mod already added tactical overlay
    for _, entry in pairs(instance) do
        if entry.class_name == "HudElementTacticalOverlay" then found = true end
    end
    if not found then
        -- Add tactical overlay
        instance[#instance+1] = {
            package = "packages/ui/hud/tactical_overlay/tactical_overlay",
            use_hud_scale = false,
            class_name = "HudElementTacticalOverlay",
            filename = "scripts/ui/hud/elements/tactical_overlay/hud_element_tactical_overlay",
            visibility_groups = {
                "tactical_overlay",
            }
        }
    end
end)

-- Add scoreboard scenegraph and widget to tactical overlay definitions
mod:hook_require("scripts/ui/hud/elements/tactical_overlay/hud_element_tactical_overlay_definitions", function(instance)
    instance.scenegraph_definition.scoreboard = {
        vertical_alignment = "center",
        parent = "screen",
        horizontal_alignment = "center",
        size = {ScoreboardViewSettings.scoreboard_size[1], ScoreboardViewSettings.scoreboard_size[2]},
        position = {mod:get("scoreboard_tactical_overlay_x"), mod:get("scoreboard_tactical_overlay_y"), base_z}
    }
    instance.scenegraph_definition.scoreboard_rows = {
        vertical_alignment = "top",
        parent = "scoreboard",
        horizontal_alignment = "center",
        size = {ScoreboardViewSettings.scoreboard_size[1], ScoreboardViewSettings.scoreboard_size[2] - 100},
        position = {base_x, 40, base_z - 1}
    }
    instance.widget_definitions.scoreboard = UIWidget.create_definition({
        {
            pass_type = "texture",
            value = "content/ui/materials/frames/dropshadow_heavy",
            style = {
                vertical_alignment = "center",
                scale_to_material = true,
                horizontal_alignment = "center",
                offset = {base_x, 0, base_z + 200},
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
                offset = {base_x, 0, base_z + 100},
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
                offset = {base_x, 0, base_z},
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
                offset = {base_x, -ScoreboardViewSettings.scoreboard_size[2] / 2, base_z + 200},
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
                offset = {base_x, ScoreboardViewSettings.scoreboard_size[2] / 2 - 50, base_z + 200},
                size = {ScoreboardViewSettings.scoreboard_size[1] + 50, 120},
                color = Color.gray(255, true),
                disabled_color = Color.gray(255, true),
                default_color = Color.gray(255, true),
                hover_color = Color.gray(255, true),
            }
        },
    }, "scoreboard")
end)


mod:hook(CLASS.HudElementTacticalOverlay, "_draw_widgets", function(func, self, dt, t, input_service, ui_renderer, render_settings, ...)
    -- UIRenderer.begin_pass(ui_renderer, self._ui_scenegraph, input_service, dt, render_settings)

    func(self, dt, t, input_service, ui_renderer, render_settings, ...)

    local scoreboard_widget = self._widgets_by_name["scoreboard"]
    if mod.tactical_overview then
        scoreboard_widget.alpha_multiplier = self._alpha_multiplier
    else
        scoreboard_widget.alpha_multiplier = 0
    end

    if self.row_widgets then
        for _, widget in pairs(self.row_widgets) do
            if mod.tactical_overview then
                widget.alpha_multiplier = self._alpha_multiplier
            else
                widget.alpha_multiplier = 0
            end
            UIWidget.draw(widget, ui_renderer)
        end
    end

    -- UIRenderer.end_pass(ui_renderer)
end)

local function _is_in_hub()
	local game_mode_name = Managers.state.game_mode:game_mode_name()
	local is_in_hub = game_mode_name == "hub"

	return is_in_hub
end

local function _is_in_prologue_hub()
	local game_mode_name = Managers.state.game_mode:game_mode_name()
	local is_in_hub = game_mode_name == "prologue_hub"

	return is_in_hub
end

--HudElementTacticalOverlay.update = function (self, dt, t, ui_renderer, render_settings, input_service)
mod:hook(CLASS.HudElementTacticalOverlay, "update", function(func, self, dt, t, ui_renderer, render_settings, input_service, ...)
    func(self, dt, t, ui_renderer, render_settings, input_service, ...)

    self.row_widgets = self.row_widgets or {}
    local scoreboard_widget = self._widgets_by_name["scoreboard"]

    local delete = false
    if self._active and not mod.hud_active then
        delete = true
    elseif not self._active and mod.hud_active then
        delete = true
    end

    -- Delete rows
    if delete then
        if self.row_widgets then
            for i = 1, #self.row_widgets do
                local widget = self.row_widgets[i]
                self._widgets_by_name[widget.name] = nil
                self:_unregister_widget_name(widget.name)
            end
            self.row_widgets = {}
        end
    end

    if self._active and not mod.hud_active then
        mod._widget_timers = {}
        mod._widget_times = {}
        mod._wait_timer = 0
        local groups = mod:get_scoreboard_groups(mod.registered_scoreboard_rows)
        local players = Managers.player:players()
        local row_widgets, total_height = mod:setup_row_widgets(mod.registered_scoreboard_rows, {}, self.row_widgets, self._widgets_by_name, nil, false, false, self, "_create_widget", ui_renderer)
        
        mod:adjust_size(total_height, scoreboard_widget, self._ui_scenegraph, self.row_widgets)

        -- local scoreboard_widget = self._widgets_by_name["scoreboard"]
        -- if scoreboard_widget then
        --     local height = total_height + 75
        --     height = math.min(height, mod:get("scoreboard_panel_height"))
        --     scoreboard_widget.style.style_id_1.size[2] = height - 3
        --     scoreboard_widget.style.style_id_2.size[2] = height - 28
        --     scoreboard_widget.style.style_id_3.size[2] = height - 3
        --     scoreboard_widget.style.style_id_4.offset[2] = -height / 2
        --     scoreboard_widget.style.style_id_5.offset[2] = height / 2 - 50

        --     local scoreboard_graph = self._ui_scenegraph.scoreboard
        --     scoreboard_graph.size[2] = height

        --     for _, row_widget in pairs(self.row_widgets) do
                
        --         if row_widget.offset[2] > total_height - 100 then
        --             local diff = math.abs((total_height - 100) - row_widget.offset[2]) / 2
        --             -- row_widget.content.text = tostring(diff)
        --             local offset_x = row_widget.style.style_id_1.offset[1]
        --             row_widget.style.style_id_1.offset[1] = offset_x + diff
        --         end

        --     end
        -- end

    end

    local in_hub = _is_in_hub()
    local in_prologue_hub = _is_in_prologue_hub()
    scoreboard_widget.visible = not in_hub and not in_prologue_hub
    for i = 1, #self.row_widgets do
        local widget = self.row_widgets[i]
        widget.visible = not in_hub and not in_prologue_hub
    end

    --mod.animate_rows = function(self, dt, widgets_by_name, widget_times)
    -- mod:animate_rows(dt, self._widgets_by_name, self.widget_times)

    mod.hud_active = self._active
end)
