local mod = get_mod("scoreboard")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local TextUtilities = mod:original_require("scripts/utilities/ui/text")
local UIFonts = mod:original_require("scripts/managers/ui/ui_fonts")
local UIRenderer = mod:original_require("scripts/managers/ui/ui_renderer")
local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local ViewElementInputLegend = mod:original_require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local USE_EXAMPLE_DATA = true
local DEBUG = false
local base_z = 100

local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")

local ScoreboardView = class("ScoreboardView", "BaseView")

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################

ScoreboardView.init = function(self, settings, context)
    self._player_manager = Managers.player
    self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_definitions")
    self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_blueprints")
    self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
    -- self._context = context
    self.end_view = context and context.end_view
    self.is_history = context and context.scoreboard_history or false
    self.rows = context and context.rows or {}
    self.loaded_players = context and context.players or nil
    self.loaded_rows = context and context.rows and mod:collect_scoreboard_rows(context.rows) or mod.registered_scoreboard_rows
    -- mod:dtf(self.loaded_players, "self.loaded_players", 5)
    -- mod:dtf(self.loaded_rows, "self.loaded_rows", 5)
    ScoreboardView.super.init(self, self._definitions, settings)
    self._pass_draw = true
    self._pass_input = true
    self._widget_timers = {}
    self._widget_times = {}
    self._wait_timer = 0
    -- self:_setup_offscreen_gui()
end

ScoreboardView.on_enter = function(self)
    self._definitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_definitions")
    self._blueprints = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_blueprints")
    self._settings = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
    self._wait_timer = 0
    -- if not self._scorebaord_history_entries then
    -- 	self._scorebaord_history_entries = {
    -- 	  data = {},
    -- 	  entries = {},
    -- 	}
    -- 	-- dmf:create_mod_options_settings(self._options_templates)
    -- end
    ScoreboardView.super.on_enter(self)

    -- self._default_category = nil
    -- self._using_cursor_navigation = Managers.ui:using_cursor_navigation()
    self.scoreboard_widget = self._widgets_by_name["scoreboard"]
    self.scoreboard_widget.alpha_multiplier = 0
    if self.is_history then
        self.scoreboard_widget.offset = {300, 0, base_z}
    elseif not self.end_view then
        self.scoreboard_widget.offset = {0, 0, base_z}
    else
        self.scoreboard_widget.offset = {0, -100, base_z}
    end
    self._widget_times["scoreboard"] = 0

    -- self:_setup_category_config()
    self:setup_row_widgets()
    if not self.is_history then
        self:_setup_input_legend()
    end
    -- self:_enable_settings_overlay(false)
    -- self:_update_grid_navigation_selection()
    
    if self.end_view and mod:get("save_all_scoreboards") then
        local sorted_rows = self.sorted_rows or {}
        mod:save_scoreboard_history_entry(sorted_rows)
        if DEBUG then mod:echo("Scoreboard saved") end
    end
end

ScoreboardView._setup_input_legend = function(self)
    self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
    local legend_inputs = self._definitions.legend_inputs
    for i = 1, #legend_inputs do
        local legend_input = legend_inputs[i]
        local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)
    
        self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, 
            legend_input.visibility_function, on_pressed_callback, legend_input.alignment)
    end
end

-- ##### ███████╗███╗   ██╗████████╗███████╗██████╗  ##################################################################
-- ##### ██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔══██╗ ##################################################################
-- ##### █████╗  ██╔██╗ ██║   ██║   █████╗  ██████╔╝ ##################################################################
-- ##### ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗ ##################################################################
-- ##### ███████╗██║ ╚████║   ██║   ███████╗██║  ██║ ##################################################################
-- ##### ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ##################################################################

ScoreboardView.delete_row_widgets = function(self)
    if self.row_widgets then
        for i = 1, #self.row_widgets do
            local widget = self.row_widgets[i]
            self._widgets_by_name[widget.name] = nil
            self:_unregister_widget_name(widget.name)
        end
        self.row_widgets = {}
    end
end

ScoreboardView.get_scoreboard_groups = function(self)
    local groups = {}
    local group_mods = {}
    groups[#groups+1] = "none"
    for _, row in pairs(self.loaded_rows) do
        if row.group and not table.contains(groups, row.group) then
            groups[#groups+1] = row.group
            group_mods[row.group] = row.mod
        end
    end
    -- mod:dtf(groups, "groups", 5)
    return groups, group_mods
end

ScoreboardView.get_rows_in_groups = function(self)
    --self.loaded_rows
    local groups, group_mods = self:get_scoreboard_groups()
    local sorted = {}
    local score_rows = {}
    sorted[#sorted+1] = {{
        mod = mod,
        name = "header",
        text = "",
        validation = ScoreboardDefinitions.validation_types.ASC,
        validation_type = "ASC",
    }}
    for _, group in pairs(groups) do
        sorted[#sorted+1] = {}
        local this_group = sorted[#sorted]
        local rows = {}
        for _, row in pairs(self.loaded_rows) do
            local valid = true
            if row.setting then
                local str = string.split(row.setting, " ")
                if str and #str > 1 then
                    local val = row.mod:get(str[1])
                    local num = tonumber(str[3])
                    if str[2] == "=" then
                        valid = val == num
                    elseif str[2] == "<" then
                        valid = val < num
                    elseif str[2] == ">" then
                        valid = val > num
                    end
                else
                    valid = row.setting and row.mod:get(row.setting)
                end
            end
            -- mod:echo("valid = '"..tostring(valid).."'")
            if row.group == group and valid then
                this_group[#this_group+1] = row
                rows[#rows+1] = row.name
            end

            -- if row.score then
            --     score_rows[#score_rows+1] = row
            -- end
        end
        if group ~= "none" and group ~= "bottom" and #rows > 0 then
            local new_row = {
                mod = group_mods[group],
                name = "row_"..group.."_score",
                text = "row_"..group.."_score",
                validation = ScoreboardDefinitions.validation_types.ASC,
                validation_type = "ASC",
                summary = rows,
                score = true,
            }
            -- for _, row in pairs(rows) do
            --     score_rows[#score_rows+1] = row
            -- end
            this_group[#this_group+1] = new_row
            score_rows[#score_rows+1] = new_row.name
        end
    end
    sorted[#sorted+1] = {{
        mod = mod,
        name = "score",
        text = "row_score",
        validation = ScoreboardDefinitions.validation_types.ASC,
        validation_type = "ASC",
        big = true,
        score = true,
        summary = score_rows,
    }}
    -- mod:echo("bla")
    local this_group = sorted[1]
    for _, row in pairs(self.loaded_rows) do
        if not row.group then this_group[#this_group+1] = row end
    end
    -- mod:dtf(sorted, "sorted", 5)
    return sorted
end

-- ##### ██████╗  ██████╗ ██╗    ██╗███████╗ ##########################################################################
-- ##### ██╔══██╗██╔═══██╗██║    ██║██╔════╝ ##########################################################################
-- ##### ██████╔╝██║   ██║██║ █╗ ██║███████╗ ##########################################################################
-- ##### ██╔══██╗██║   ██║██║███╗██║╚════██║ ##########################################################################
-- ##### ██║  ██║╚██████╔╝╚███╔███╔╝███████║ ##########################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚══════╝ ##########################################################################

ScoreboardView.create_row_widget = function(self, index, current_offset, visible_rows, this_row)
    local widget = nil
    local template = table.clone(self._blueprints["scoreboard_row"])
    local size = template.size
    local pass_template = template.pass_template
    local name = "scoreboard_row_"..this_row.name
    local header = this_row.name == "header"
    local header_height = self._settings.scoreboard_row_header_height
    local row_height = this_row.name == "score" and 35
        or header and header_height
        or this_row.score and self._settings.scoreboard_row_big_height
        or 18
    local font_size = this_row.big and 30
        or header and 20
        or this_row.score and 24
        or 16

    -- Vertical offset
    if this_row.parent then
        local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
        if parent then
            current_offset = parent.offset[2]
            row_height = parent.style.style_id_1.size[2]
        end
    end

    local player_pass_map = {3, 5, 7, 9}
    local players = self.loaded_players or self._player_manager:players()

    -- Header
    if header then
        pass_template[1].value = ""
        pass_template[1].style.font_size = font_size
        local num_players = 0
        for i = 1, 4, 1 do
            pass_template[player_pass_map[i]].value = ""
        end
        for _, player in pairs(players) do
            num_players = num_players + 1
            if num_players <= 4 then
                if player.name then
                    pass_template[player_pass_map[num_players]].value = player:name()
                end
            end
        end
    end

    -- Localize row name
    local this_text = this_row.mod:localize(this_row.text) or this_row.text
    if self.is_history and not this_row.score then
        this_text = this_row.text
    end
    local this_setting = this_row.setting
    if this_setting then
        local str = string.split(this_setting, " ")
        if str and #str > 1 then
            this_setting = str[1]
        end
        this_setting = tostring(this_row.mod:get(this_setting))
        if this_setting then
            local that_text = this_row.mod:localize(this_row.text.."_"..this_setting)
            if that_text ~= "<>" and that_text ~= "<"..this_row.text.."_"..this_setting..">" then
                this_text = that_text
            end
        end
    end

    -- Set styles
    pass_template[1].style.font_size = (header or this_row.big or this_row.score) and font_size or 14
    pass_template[1].style.size[2] = row_height
    for _, i in pairs(player_pass_map) do
        pass_template[i].style.font_size = font_size
        pass_template[i].style.size[2] = row_height
    end
    if current_offset > 450 then
        pass_template[1].style.offset[1] = pass_template[1].style.offset[1] + 30
    elseif current_offset > 420 then
        pass_template[1].style.offset[1] = pass_template[1].style.offset[1] + 10
    end

    -- Unset child row headers
    local children = self:get_row_children(this_row.name)
    if #children > 0 then
        for _, i in pairs(player_pass_map) do
            pass_template[i].value = ""
        end
    end

    -- Set offsets / sizes / header text
    if this_row.parent then

        local children, val_index = self:get_row_children(this_row.parent, this_row.name)
        if #children > 1 then
            for _, i in pairs(player_pass_map) do
                local this_size = {self._settings.scoreboard_column_width / #children, pass_template[i].style.size[2]}
                local offset = this_size[1] * (val_index - 1)
                pass_template[i].style.offset[1] = pass_template[i].style.offset[1] + offset
                pass_template[i].style.size[1] = this_size[1]
            end
        end

        pass_template[1].value = ""
    elseif index > 1 then
        pass_template[1].value = this_text
    end

    -- Calculate row values
    if not header then
        for i = 1, 2, 1 do
            local player_num = 1
            for _, player in pairs(players) do
                if player_num < 5 then
                    local account_id = player:account_id() or player:name()
                    local rows = {}
                    if this_row.summary then
                        for _, group in pairs(self.sorted_rows) do
                            for _, row in pairs(group) do
                                if table.contains(this_row.summary, row.name) then
                                    rows[#rows+1] = row
                                end
                            end
                        end
                    else
                        rows[#rows+1] = this_row
                    end

                    local score = 0
                    for _, row in pairs(rows) do
                        local row_data = row.data and row.data[account_id]
                        score = score + (row_data and row_data.score or 0)
                    end
                    -- score = score == 0 and math.random(1, 100) or score

                    this_row.data = this_row.data or {}
                    this_row.data[account_id] = this_row.data[account_id] or {}
                    -- mod:echo(score)
                    this_row.data[account_id].score = score --/ #rows
                end
                player_num = player_num + 1
            end
        end
    end
    
    -- Normalize score row values
    if this_row.score then
        self:normalize_values(players, this_row)
    end

    -- Best / worst
    local validation = this_row.validation
    if this_row.data and validation then
        for account_id, row_data in pairs(this_row.data) do
            row_data.is_best = validation.is_best(this_row.data, account_id)
            row_data.is_worst = validation.is_worst(this_row.data, account_id)
        end
    end

    local zero_setting = mod:get("zero_values")
    local worst_setting = mod:get("worst_values")
    -- Set row texts
    if not header and #children == 0 then
        local player_num = 1
        for i = 1, 4, 1 do
            local pass_index = player_pass_map[i]
            pass_template[pass_index].value = ""
        end
        for _, player in pairs(players) do
            if player_num < 5 then
                local account_id = player:account_id() or player:name()
                local pass_index = player_pass_map[player_num]

                -- Prepare score text
                local row_data = this_row.data and this_row.data[account_id]
                local score = row_data and row_data.score or 0
                local decimals = this_row.decimals or 0
                decimals = this_row.is_time and 1 or decimals
                score = this_row.is_time and mod:shorten_time(score, decimals) or mod:shorten_value(score, decimals)

                -- Colors
                local color = nil
                local num_score = score
                num_score = string.gsub(num_score, "s", "")
                -- num_score = string.gsub(num_score, "s", "")
                num_score = tonumber(num_score)
                if num_score and num_score == 0 and zero_setting > 1 then
                    -- Zero values
                    if zero_setting == 2 then
                        pass_template[player_pass_map[player_num]].style.visible = false
                    elseif zero_setting == 3 then
                        color = Color.ui_grey_light(255, true)
                    end
                else
                    if row_data and row_data.is_best then
                        color = Color.ui_orange_light(255, true)
                    elseif row_data and row_data.is_worst then
                        if worst_setting == 2 then
                            color = Color.ui_grey_light(255, true)
                        end
                    end
                end

                if color then
                    score = TextUtilities.apply_color_to_text(tostring(score), color)
                    if mod:is_me(account_id) and this_row.parent then
                        -- Replace text with colored text in parent widget
                        local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
                        if parent then
                            local parent_text = parent.content.text
                            local s, e = string.find(parent_text, this_text)
                            if s then
                                local colored = TextUtilities.apply_color_to_text(this_text, color)
                                parent.content.text = parent_text:gsub(this_text, colored)
                            end
                        end
                    elseif mod:is_me(account_id) then
                        -- Replace header text with colored text
                        pass_template[1].value = TextUtilities.apply_color_to_text(tostring(pass_template[1].value), color)
                    end
                end

                -- Set score text
                pass_template[pass_index].value = score
            end
            player_num = player_num + 1
        end
    end

    -- Alternate row
    local alternate_row = visible_rows % 2 == 0
    if alternate_row and not this_row.parent then
        pass_template[#pass_template].style.size[2] = row_height
    else
        pass_template[#pass_template] = nil
    end

    -- Create widget
    local widget_definition = UIWidget.create_definition(pass_template, "scoreboard_rows", nil, size)

    if widget_definition then
        widget = self:_create_widget(name, widget_definition)

        widget.alpha_multiplier = 0
        
        -- widget.offset = {self.is_history and 300 or 0, current_offset, 0}
        if self.is_history then
            widget.offset = {300, current_offset, base_z + 1}
        elseif not self.end_view then
            widget.offset = {0, current_offset, base_z + 1}
        else
            local offset_y = current_offset - 100
            -- widget.offset = {-300, current_offset - y, 0}
            -- Vertical offset
            if this_row.parent then
                local parent = self._widgets_by_name["scoreboard_row_"..this_row.parent]
                if parent then offset_y = parent.offset[2] end
            end
            widget.offset = {0, offset_y, base_z + 1}
        end

        -- Header; Attempt to lower font size of long names
        if header then
            widget.content.text = ""
            widget.style.style_id_1.font_size = font_size
            -- local players = self._player_manager:players()
            local num_players = 0
            for _, player in pairs(players) do
                num_players = num_players + 1
                if num_players <= 4 then
                    if player.name then
                        local name = player:name()
                        -- pass_template[player_pass_map[num_players]].value = name
                        widget.content["text_"..tostring(player_pass_map[num_players])] = name

                        local width = self._settings.scoreboard_column_width + 10
                        local fsize = font_size + 1
                        while width > self._settings.scoreboard_column_width - 10 do
                            fsize = fsize - 1
                            -- pass_template[player_pass_map[num_players]].style.font_size = fsize
                            widget.style["style_id_"..player_pass_map[num_players]].font_size = fsize
                            -- Calculate parent text width
                            -- local font_style = pass_template[player_pass_map[num_players]].style
                            local font_style = widget.style["style_id_"..player_pass_map[num_players]]
                            local font_type = font_style.font_type
                            -- local font_size = font_style.font_size
                            local scale = self._ui_renderer.scale or 1
                            local scaled_font_size = UIFonts.scaled_size(fsize, scale)
                            local sender_font_options = UIFonts.get_font_options_by_style(font_style)
                            width = UIRenderer.text_size(self._ui_renderer, name, font_type, scaled_font_size)
                        end
                    end
                end
            end
        end

        self._widget_times[widget.name] = current_offset / 1000

        return widget, row_height
    end
end

local average = function(data, players)
    local average = 0
    local num_player = 0
    for _, player in pairs(players) do
        if player then
            num_player = num_player + 1
            if num_player < 5 then
                local account_id = player:account_id() or player:name()
                local value = data[account_id] and data[account_id].score or 0
                average = average + value
            end
        end
    end
    local num = math.min(num_player, 4)
    local average = average or 0
    return average / num
end

ScoreboardView.normalize_values = function(self, players, this_row)
    -- Adjust values
	local target_average = 100
	-- for row_index, data in pairs(self.rows) do
	-- 	if data.score_row then
    if this_row.data then
        local av = average(this_row.data, players)
        if av ~= 0 then
            if av > target_average then
                local start_av = av
                local safety = 10000
                while av > target_average and safety > 0 do
                    for account_id, values in pairs(this_row.data) do
                        values.score = values.score * 0.9
                        -- values.end_score = values.score
                    end
                    av = average(this_row.data, players)
                    safety = safety - 1
                end
                -- mod:echo(this_row.name.." - "..start_av.." > "..av.." - "..(10000 - safety).." rounds")
            elseif av < target_average then
                local start_av = av
                local safety = 10000
                while av < target_average and safety > 0 do
                    for account_id, values in pairs(this_row.data) do
                        values.score = values.score * 1.1
                        -- values.end_score = values.score
                    end
                    av = average(this_row.data, players)
                    safety = safety - 1
                end
                -- mod:echo(this_row.name.." - "..start_av.." > "..av.." - "..(10000 - safety).." rounds")
            end
        end
        -- 	end
        -- end
    end
end

ScoreboardView.get_row_children = function(self, parent, row_name)
    local children = {}
    local index = 0
    local this_index = 0
    -- mod:echo("searching children for "..parent)
    for _, group in pairs(self.sorted_rows) do
        for _, row in pairs(group) do
            if row.parent then
                -- mod:echo("check "..parent.." = "..tostring(row.parent))
                if parent == row.parent then
                    index = index + 1
                    if row.name == row_name then
                        this_index = index
                    end
                    children[#children+1] = row
                end
            end
        end
    end
    return children, this_index
end

ScoreboardView.setup_row_widgets = function(self)
    self:delete_row_widgets()

    self._widget_times = self._widget_times or {}
    self.row_offsets = {}

    local widget_definitions = {}
    local current_offset = 0
    local visible_rows = 0

    self.sorted_rows = self:get_rows_in_groups()
    -- mod:echo(#self.sorted_rows)
    -- for group, rows in pairs(self.sorted_rows) do
    local index = 1
    for g = 1, #self.sorted_rows, 1 do
        local rows = self.sorted_rows[g]
        -- mod:echo("group")
        for i = 1, #rows, 1 do
            local this_row = rows[i]
            if this_row.visible ~= false then
                local name = "scoreboard_row_"..this_row.name
                if not this_row.parent then
                    visible_rows = visible_rows + 1
                end
                local widget, row_height = self:create_row_widget(index, current_offset, visible_rows, this_row)

                if widget then
                    self.row_widgets = self.row_widgets or {}
                    self.row_widgets[#self.row_widgets+1] = widget
                    self._widgets_by_name = self._widgets_by_name or {}
                    self._widgets_by_name[name] = widget
                    if not this_row.parent then
                        current_offset = current_offset + row_height
                    end
                end
            end
            index = index + 1
        end
    end

    -- self:move_scoreboard(0, -300, function()
    --     self:move_scoreboard(-300, 0)
    -- end)
end

-- ##### ███████╗██╗  ██╗██╗████████╗ #################################################################################
-- ##### ██╔════╝╚██╗██╔╝██║╚══██╔══╝ #################################################################################
-- ##### █████╗   ╚███╔╝ ██║   ██║    #################################################################################
-- ##### ██╔══╝   ██╔██╗ ██║   ██║    #################################################################################
-- ##### ███████╗██╔╝ ██╗██║   ██║    #################################################################################
-- ##### ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝    #################################################################################

ScoreboardView.remove_input_legend = function(self)
    if self._input_legend_element then
        self._input_legend_element = nil
        self:_remove_element("input_legend")
    end
end

ScoreboardView.on_exit = function(self)
    -- Remove legend
    self:remove_input_legend()
    ScoreboardView.super.on_exit(self)
end

-- #####  ██████╗ █████╗ ██╗     ██╗     ██████╗  █████╗  ██████╗██╗  ██╗███████╗ #####################################
-- ##### ██╔════╝██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝ #####################################
-- ##### ██║     ███████║██║     ██║     ██████╔╝███████║██║     █████╔╝ ███████╗ #####################################
-- ##### ██║     ██╔══██║██║     ██║     ██╔══██╗██╔══██║██║     ██╔═██╗ ╚════██║ #####################################
-- ##### ╚██████╗██║  ██║███████╗███████╗██████╔╝██║  ██║╚██████╗██║  ██╗███████║ #####################################
-- #####  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝ #####################################

ScoreboardView.cb_on_save_pressed = function(self)
    -- Remove legend
    self:remove_input_legend()
    local sorted_rows = self.sorted_rows or {}
    mod:save_scoreboard_history_entry(sorted_rows)
    if DEBUG then mod:echo("Scoreboard saved") end
end

-- ##### ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗ ###########################################################
-- ##### ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝ ###########################################################
-- ##### ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗   ###########################################################
-- ##### ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝   ###########################################################
-- ##### ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗ ###########################################################
-- #####  ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝ ###########################################################

ScoreboardView.update_scoreboard_offset = function(self)
    local widgets = self._widgets_by_name
	for _, widget in pairs(widgets) do
		if widget then
			for _, style in pairs(widget.style) do
				-- style.visible = visible
				local offset = style.original_offset or style.offset or {0, 0, 0}
				if not style.original_offset then
					style.original_offset = table.clone(offset)
				end
				-- local from_offset = self.scoreboard_move_from_offset and style.original_offset[1] + self.scoreboard_move_from_offset or style.original_offset[1]
				-- local to_offset = self.scoreboard_move_to_offset and style.original_offset[1] + self.scoreboard_move_to_offset or style.original_offset[1]
				-- local x = self.scoreboard_move_to_offset and from_offset + self.scoreboard_move_to_offset or from_offset
				local x = self.scoreboard_offset and style.original_offset[1] + self.scoreboard_offset or style.original_offset[1]

				local new_offset = {x, style.original_offset[2], style.original_offset[3]}
				style.offset = new_offset
			end
		end
	end
end

ScoreboardView.update_scoreboard = function(self, dt)
	if self.scoreboard_move_timer then
		if self.scoreboard_move_timer <= 0 then
			-- self.scoreboard_offset = nil
			self:update_scoreboard_offset()
			self.scoreboard_move_timer = nil
			if self.scoreboard_move_callback then
				self.scoreboard_move_callback()
				self.scoreboard_move_callback = nil
			end
		else
			local percentage = self.scoreboard_move_timer / 0.75
			-- mod:echo(percentage)
			local range = math.abs(self.scoreboard_move_to_offset) + math.abs(self.scoreboard_move_from_offset)
			-- local done = range * percentage
			local t_ease = math.ease_sine(percentage)
			local done = math.lerp(0, range, t_ease)
			if self.scoreboard_move_to_offset > self.scoreboard_move_from_offset then
				self.scoreboard_offset = self.scoreboard_move_to_offset - done
			else
				self.scoreboard_offset = self.scoreboard_move_to_offset + done
			end
			
			-- self.scoreboard_offset = ((self.scoreboard_move_to_offset + self.scoreboard_move_from_offset) * percentage)
			self:update_scoreboard_offset()
			self.scoreboard_move_timer = self.scoreboard_move_timer - dt
		end
	end
end

ScoreboardView.move_scoreboard = function(self, from_offset_x, to_offset_x, callback)
	self.scoreboard_move_timer = 0.75
	self.scoreboard_move_from_offset = from_offset_x
	self.scoreboard_move_to_offset = to_offset_x
	-- self.scoreboard_offset = from_offset_x
	self.scoreboard_move_callback = callback
end

ScoreboardView.update = function(self, dt, t, input_service, view_data)
    local drawing_view = view_data and view_data.drawing_view
    local using_cursor_navigation = Managers.ui:using_cursor_navigation()

    if self._tooltip_data and self._tooltip_data.widget and not self._tooltip_data.widget.content.hotspot.is_hover then
        self._tooltip_data = {}
        self._widgets_by_name.tooltip.content.visible = false
    end

    self:update_scoreboard(dt)

    return ScoreboardView.super.update(self, dt, t, input_service)
end

ScoreboardView.animate_rows = function(self, dt)
    self._widget_timers = self._widget_timers or {}
    self._wait_timer = self._wait_timer or 0
    -- Iterate through all rows
    for name, widget in pairs(self._widgets_by_name) do
        -- Check state
        if widget.alpha_multiplier == 0 and not self._widget_timers[widget.name] then
            -- Alpha = 0 and timer not yet started
            if self._wait_timer and self._wait_timer >= self._widget_times[widget.name] then
                -- Start timer
                self._widget_timers[widget.name] = self._settings.scoreboard_fade_length
            end

        elseif self._widget_timers[widget.name] and self._widget_timers[widget.name] > 0 then
            -- Timer was started; Calculate alpha
            local percentage = self._widget_timers[widget.name] / self._settings.scoreboard_fade_length
            widget.alpha_multiplier = 1 - percentage
            self._widget_timers[widget.name] = self._widget_timers[widget.name] - dt

        elseif self._widget_timers[widget.name] and self._widget_timers[widget.name] <= 0 then
            -- Timer finished; Set alpha = 1
            widget.alpha_multiplier = 1
            self._widget_timers[widget.name] = nil

        end
    end
    self._wait_timer = self._wait_timer + dt
end

-- ##### ██████╗ ██████╗  █████╗ ██╗    ██╗ ###########################################################################
-- ##### ██╔══██╗██╔══██╗██╔══██╗██║    ██║ ###########################################################################
-- ##### ██║  ██║██████╔╝███████║██║ █╗ ██║ ###########################################################################
-- ##### ██║  ██║██╔══██╗██╔══██║██║███╗██║ ###########################################################################
-- ##### ██████╔╝██║  ██║██║  ██║╚███╔███╔╝ ###########################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝  ###########################################################################

ScoreboardView.draw = function(self, dt, t, input_service, layer)
    self:_draw_elements(dt, t, self._ui_renderer, self._render_settings, input_service)
    self:_draw_widgets(dt, input_service)
end

ScoreboardView._draw_elements = function(self, dt, t, ui_renderer, render_settings, input_service)
    ScoreboardView.super._draw_elements(self, dt, t, ui_renderer, render_settings, input_service)
end

ScoreboardView._draw_widgets = function(self, dt, input_service)
    UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, input_service, dt, self._render_settings)
    self:animate_rows(dt)
    for name, widget in pairs(self._widgets_by_name) do
        UIWidget.draw(widget, self._ui_renderer)
    end
    UIRenderer.end_pass(self._ui_renderer)
end

return ScoreboardView