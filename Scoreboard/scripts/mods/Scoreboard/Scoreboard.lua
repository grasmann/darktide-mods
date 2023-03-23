local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

-- mod.initialized = mod.initialized or false
mod.debug_inventory = false
mod.debug_value = false
mod.initialized = false
mod.move_time = 0.75

local _io = DMF:persistent_table("_io")
_io.initialized = _io.initialized or false
if not _io.initialized then _io = DMF.deepcopy(Mods.lua.io) end
local _os = DMF:persistent_table("_os")
_os.initialized = _os.initialized or false
if not _os.initialized then _os = DMF.deepcopy(Mods.lua.os) end

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

-- On gameplay enter
function mod.on_game_state_changed(status, state_name)
	if state_name == "StateGameplay" and status == "enter" then
		-- Clear scores
		mod:clear()
	end
end

-- On all mods loaded
function mod.on_all_mods_loaded()
	mod:load_package("packages/ui/views/end_player_view/end_player_view")
	mod:load_package("packages/ui/views/store_item_detail_view/store_item_detail_view")
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Initialize Mod
mod.initialize = function(self)
	if not self.initialized then
		self.text = "Scoreboard"
		self.rows = {}
		self.widgets = {}
		self.widgets_by_name = {}
		self.definitions = Mods.file.exec_with_return("scoreboard/scripts/mods/scoreboard", "scoreboard_definitions")
		self.ui_font_settings = Mods.original_require("scripts/managers/ui/ui_font_settings")

		-- Collect scoreboard entries
		self:load_mod_scoreboards()

		-- Create widgets
		local widgets = self:create_ui_widgets()

		-- Create UI extension
		self:create_ui_extension(widgets)
	end

	self:add_require_path("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view")
	self:add_require_path("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_definitions")
	self:add_require_path("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view_settings")

	self:register_view({
		view_name = "scoreboard_history_view",
		view_settings = {
			init_view_function = function (ingame_ui_context)
				return true
			end,
			class = "ScoreboardHistoryView",
			disable_game_world = false,
			display_name = "loc_scoreboard_history_view_display_name",
			game_world_blur = 1.1,
			load_always = true,
			load_in_hub = true,
			package = "packages/ui/views/options_view/options_view",
			path = "scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view",
			state_bound = true,
			enter_sound_events = {
				"wwise/events/ui/play_ui_enter_short"
			},
			exit_sound_events = {
				"wwise/events/ui/play_ui_back_short"
			},
			wwise_states = {
				options = "ingame_menu"
			},
		},
		view_transitions = {},
		view_options = {
			close_all = false,
			close_previous = false,
			close_transition_time = nil,
			transition_time = nil
		}
	})

	self:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view")

	self.initialized = true
end

mod.create_ui_widgets = function(self)
	-- Create row definitions
	local row_definitions = self:create_row_definitions()
	-- Load widget definitions
	local widgets = self.definitions.widgets
	-- Assign rows
	for name, row in pairs(row_definitions) do
		widgets[name] = row
	end
	return widgets
end

mod.create_ui_extension = function(self, widgets)
	self.ui_injection = {
		end_view = {
			scenegraph = self.definitions.scenegraphs.end_view,
			widgets = widgets,
			on_widgets_loaded = function(widgets, widgets_by_name)
				self.widgets = widgets
				self.widgets_by_name = widgets_by_name
				self:fill_values()
			end,
			on_enter = function(view_name)
				self.players = Managers.player:players()
				self:fill_values()
			end,
			on_update = function(view_name, dt)
				self:update_scoreboard(dt)
				-- self:update_scoreboard_rows(dt)
			end,
			on_exit = function(view_name)
				-- for row_index, data in pairs(self.rows) do
				-- 	data.was_animated = nil
				-- end
			end
		},
		end_player_view = {
			scenegraph = self.definitions.scenegraphs.end_player_view,
			on_enter = function(view_name)
				--self:scoreboard_visible(false)
				self:move_scoreboard(0, -300)
			end,
			on_exit = function(view_name)
				--self:scoreboard_visible(true)
				self:move_scoreboard(-300, 0)
			end,
		},
	}
	self.hud_injection = {
		hud_element_tactical_overlay = {
			scenegraph = self.definitions.scenegraphs.end_view,
			widgets = widgets,
			on_widgets_loaded = function(widgets, widgets_by_name)
				self.widgets = widgets
				self.widgets_by_name = widgets_by_name
				self:fill_values()
			end,
			on_update = function(view_name, dt, t, hud_element)
				-- self.players = Managers.player:players()
				self:fill_values()
				hud_element:set_dirty()
			end
		},
	}
	if self.debug_inventory then
		self.ui_injection.inventory_view = table.clone(self.ui_injection.end_view)
		self.ui_injection.inventory_view.on_widgets_loaded = function(widgets, widgets_by_name)
			self.widgets = widgets
			self.widgets_by_name = widgets_by_name
			self:fill_values()
			self:move_scoreboard(0, -300, function()
				self:move_scoreboard(-300, 0)
			end)
		end
	end
end

mod.load_package = function(self, package_name)
	local package_manager = Managers.package
	if not package_manager:is_loading(package_name) and not package_manager:has_loaded(package_name) then
		package_manager:load(package_name, "scoreboard", nil, true)
	end
end

mod.update_scoreboard = function(self, dt)
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
			local percentage = self.scoreboard_move_timer / self.move_time
			-- mod:echo(percetage)
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

mod.move_scoreboard = function(self, from_offset_x, to_offset_x, callback)
	self.scoreboard_move_timer = self.move_time
	self.scoreboard_move_from_offset = from_offset_x
	self.scoreboard_move_to_offset = to_offset_x
	-- self.scoreboard_offset = from_offset_x
	self.scoreboard_move_callback = callback
end

mod.update_scoreboard_offset = function(self)
	for _, widget in pairs(self.widgets) do
		if widget then
			for _, style in pairs(widget.style) do
				-- style.visible = visible
				local offset = style.original_offset or style.offset or {0, 0, 101}
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

mod.scoreboard_visible = function(self, visible)
	for _, widget in pairs(self.widgets) do
		if widget then
			for _, style in pairs(widget.style) do
				-- style.visible = visible
				local offset = style.original_offset or style.offset or {0, 0, 1}
				if not style.original_offset then
					style.original_offset = table.clone(offset)
				end
				local x = not visible and style.original_offset[1] - 300 or style.original_offset[1]
				local new_offset = {x, style.original_offset[2], style.original_offset[3]}
				style.offset = new_offset
			end
		end
	end
end

-- Clear collected data
mod.clear = function(self)
	for row_index, data in pairs(self.rows) do
		data.data = {}
	end
end

-- Create row styles
mod.create_row_styles = function(self, index)
	local row_styles = {}
	-- Get definition settings
	local header_column = self.definitions.settings.header_column
	local column = self.definitions.settings.column
	local width = self.definitions.settings.width
	-- Row template
	local row = self.rows[index - 1] or {}
	-- Data
	local header = index == 1
	local row_height = row.height or header and 55 or 26
	local font_size = row.font_size or header and 26 or 16
	local visible = row.visible or font_size > 0
	-- Iterate columns
	for col = 1, 5, 1 do
		local row_header = col == 1
		local base_offset = {row.offset and row.offset[1] or 0, row.offset and row.offset[2] or 0, row.offset and row.offset[3] or 2}
		local offset = {
			(row_header and 30 or header_column + (col - 2) * column) + base_offset[1],
			(self.base_y + 15) + base_offset[2],
			base_offset[3] or 2
		}
		local base_size = {
			row_header and header_column or column,
			row_height
		}
		local horizontal = row_header and "left" or "center"
		local vertical = header and "bottom" or "center"
		local color = Color.white(200, true)
		local indentation = row_header and row.indentation or 0
		row_styles[#row_styles+1] = table.clone(self.ui_font_settings.header_3)
		row_styles[#row_styles].offset = {offset[1] + indentation, offset[2], offset[3]}
		row_styles[#row_styles].size = {base_size[1], base_size[2]}
		row_styles[#row_styles].font_size = font_size
		row_styles[#row_styles].text_horizontal_alignment = horizontal
		row_styles[#row_styles].text_vertical_alignment = vertical
		row_styles[#row_styles].text_color = Color.terminal_text_header(255, true)
		row_styles[#row_styles].color = color
		row_styles[#row_styles].default_color = color
		row_styles[#row_styles].hover_color = color
		row_styles[#row_styles].disabled_color = color
		row_styles[#row_styles].visible = font_size > 0
	end
	-- Save info if visible
	if visible then
		if not row.empty and row_height > 0 and not row.offset and index > 1 then
			self.visible_rows = self.visible_rows + 1
		end
		if not row.offset then
			self.base_y = self.base_y + row_height
		end
	end
	-- Return
	return row_styles, row_height
end

mod.alternate_row_background = function(self, row, row_height, base_y)
	local bg_pass = nil
	local alternate_row = self.visible_rows % 2 == 0
	if alternate_row and not row.offset and not row.empty then
		bg_pass = table.clone(self.definitions.alternate_row_style)
		bg_pass.style.size[2] = row_height
		bg_pass.style.offset[2] = base_y + 15
	end
	return bg_pass
end

mod.row_icons = function(self, row, row_height, base_y)
	local header_column = self.definitions.settings.header_column
	local column = self.definitions.settings.column
	local icons = {}
	if row.icon then
		for i = 1, 4, 1 do
			local offset = {row.offset and row.offset[1] or 0, row.offset and row.offset[2] or 1}
			local width = row_height - 5
			local height = width * 0.8
			icons[#icons+1] = {
				value = row.icon,
				pass_type = "texture",
				style = {
					horizontal_alignment = "left",
					size = {width, height},
					offset = {header_column + column * (i - 1) + (offset[1] + 40) - 2, base_y + 15 + offset[2] + 6, 103},
					color = Color.white(255, true),
					disabled_color = Color.white(255, true),
					default_color = Color.white(255, true),
					hover_color = Color.white(255, true),
				},
				custom = true,
			}
		end
	else
		for i = 1, 4, 1 do
			icons[#icons+1] = {
				value = "",
				pass_type = "text",
				style = {
					visible = false,
				},
				custom = true,
			}
		end
	end
	return icons
end

-- Create row definition
mod.create_row_definition = function(self, index)
	-- Row
	local row = self.rows[index - 1] or {}
	-- Get data
	local header_column = self.definitions.settings.header_column
	local column = self.definitions.settings.column
	local width = self.definitions.settings.width
	local base_y = self.base_y

	-- Row styles
	local row_styles, row_height = self:create_row_styles(index)

	-- Background on alternate row
	local bg_pass = mod:alternate_row_background(row, row_height, base_y)

	-- Create icons
	local icons = mod:row_icons(row, row_height, base_y)

	return {
		scenegraph_id = "scoreboard_rows",
		{
			value_id = "text",
			value = "",
			pass_type = "text",
			style = row_styles[1],
			custom = true,
		},
		icons[1],
		{
			value_id = row.empty and "" or "text1",
			value = "",
			pass_type = "text",
			style = row_styles[2],
			custom = true,
		},
		icons[2],
		{
			value_id = row.empty and "" or "text2",
			value = "",
			pass_type = "text",
			style = row_styles[3],
			custom = true,
		},
		icons[3],
		{
			value_id = row.empty and "" or "text3",
			value = "",
			pass_type = "text",
			style = row_styles[4],
			custom = true,
		},
		icons[4],
		{
			value_id = row.empty and "" or "text4",
			value = "",
			pass_type = "text",
			style = row_styles[5],
			custom = true,
		},
		bg_pass,
	}
end

mod.load_mod_scoreboards = function(self)
	for _, this_mod in pairs(DMF.mods) do
		if type(this_mod) == "table" and this_mod.scoreboard then
			for _, template in pairs(this_mod.scoreboard) do
				mod:register_row(template)
			end
		end
	end
	-- for _, template in pairs(mod.scoreboard) do
	-- 	mod:register_row(template)
	-- end
end

mod.create_row_definitions = function(self)
	local row_definitions = {}
	-- Reset help values
	self.base_y = 0
	self.visible_rows = 0
	self.row_count = #self.rows+1
	-- Iterate rows
	for row_index = 1, self.row_count, 1 do
		-- Create row definition
		row_definitions["scoreboard_row_"..row_index] = mod:create_row_definition(row_index)
	end
	return row_definitions
end

-- Register new row
mod.register_row = function(self, template, index)
	-- local font_size = template.font_size or template.parent ~= nil and 16 or 20
	local new_index = index or #self.rows + 1
	table.insert(self.rows, new_index, {
		-- font_size = font_size,
		name = template.name,
		text = template.text,
		iteration = template.iteration,
		validation = template.validation,
		height = template.row_height,
		font_size = template.font_size,
		score_summary = template.score_summary,
		score_multiplier = template.score_multiplier,
		multiplier = template.multiplier,
		divider = template.divider,
		decimals = template.decimals,
		score_addition = template.score_addition,
		is_time = template.is_time,
		score_row = template.score_row,
		offset = template.offset,
		icon = template.icon,
		empty = template.empty,
		visible = template.visible,
		indentation = template.indentation,
		value = template.value,
		data = {},
	})
end

-- Get row from name
mod.get_row = function(self, name)
	-- Iterate rows
	for _, row in pairs(self.rows) do
		-- Compare name
		if row.name == name then
			return row
		end
	end
	return nil
end

-- Get row index from name
mod.row_index = function(self, name)
	-- Iterate rows
	for index, row in pairs(self.rows) do
		-- Compare name
		if row.name == name then
			return index
		end
	end
	return nil
end

-- Update character specific row data
mod.update_stat = function(self, name, account_id, value)
	-- Normalize value
	local value = value and math.max(0, value) or 0
	-- Get row
	local row = self:get_row(name)
	if row then
		-- mod:echo("joo")
		local character_data = row.data[account_id]
		-- Iteration
		local iteration = row.iteration
		local old_value = character_data and character_data.value or 0
		local new_value, add_score = iteration.value(value, old_value)
		-- New score
		local old_score = character_data and character_data.score or 0
		local new_score = old_score + add_score
		-- Update row
		local validation = row.validation
		row.data[account_id] = {
			value = value,
			score = new_score,
			end_score = new_score,
		}
		for char_name, data in pairs(row.data) do
			data.is_best = validation.is_best(row.data, char_name)
			data.is_worst = validation.is_worst(row.data, char_name)
		end
	end
end

-- Get my own character name
mod.me = function(self)
	local player_manager = Managers.player
	return player_manager:local_player(1):account_id()
end

-- Is character name me?
mod.is_me = function(self, account_id)
	return account_id == mod:me()
end

mod.shorten_value = function(self, value, decimals)
	if value >= 1000 then
		return string.format("%.1fK", value / 1000)
	end
	local decimals = decimals or 0
	return string.format("%."..decimals.."f", value)
end

mod.shorten_time = function(self, time, decimals)
	if time >= 60 then
		return string.format("%.1f", time / 60).."m"
	end
	local decimals = decimals or 0
	return string.format("%."..decimals.."f", time).."s"
end

mod.log_to_file = function(self, name, obj)
	self:dtf(obj, name.."_"..tostring(os.time()), 5)
end

mod.fill_values = function(self)
	-- Playerlist
	-- local player_manager = Managers.player
	-- self.players = self.players or {}

	-- self:dtf(self.rows, "self.rows", 5)

	self.players = Managers.player:players()
	local players = {}
	for _, player in pairs(self.players) do
		players[#players+1] = player
	end
	-- local players = self.players
	-- mod:echo("debug = '"..tostring(self.debug_inventory).."'")
	if self.debug_value then
		players = {
			{
				account_id = function()
					return mod:me()
				end,
				name = function()
					return "Rudge"
				end,
			},
			{
				account_id = function()
					return "lol"
				end,
				name = function()
					return "lol"
				end,
			},
			{
				account_id = function()
					return "rofl"
				end,
				name = function()
					return "rofl"
				end,
			},
			{
				account_id = function()
					return "omg"
				end,
				name = function()
					return "omg"
				end,
			},
		}
	end
	
	-- Header text
	local col = 0
	for _, player in pairs(players) do
		col = col + 1
		if col < 5 then
			local account_id = player:account_id() or player:name()
			-- local header = mod:header(self)
			local header = self.widgets_by_name["scoreboard_row_1"]
			if header then
				local character_name = player:name()
				header.content["text"..col] = character_name
				local text_color = Color.white(255, true)
				if mod:is_me(account_id) then text_color = Color.ui_orange_light(255, true) end
				local widget_col = col + col + 1
				header.style["style_id_"..widget_col].text_color = text_color
			end
		end
	end

	-- mod:dtf(self.rows, "self.rows2", 5)

	-- Test values
	if self.debug_value then
		for row_index, data in pairs(self.rows) do
			if not data.score_summary then
				local col = 0
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						local value = nil --math.random(1, 4)
						-- if data.name == "tomes" or data.name == "grims" then
						-- 	value = math.random(0, 1)
						-- end
						if data.name == "heal_station_used" then
							value = math.random(0, 3)
						end
						if data.name == "damage_taken" then
							value = math.random(100, 1000)
						end

						if data.name == "health_placed" or data.name == "ammo_placed" then
							value = math.random(0, 3)
						end
						if data.name == "carrying_other" or data.name == "carrying_grims" or data.name == "carrying_tomes" then
							value = math.random(0, 4)
						end
						if data.name == "machinery_operated" or data.name == "gadget_operated" then
							value = math.random(0, 10)
						end
						if data.name == "ammo_wasted" then
							value = math.random(0, 300)
						end
						if data.name == "ammo_picked_up" then
							value = math.random(500, 1500)
						end

						if data.name == "enemies_staggerd" or data.name == "attacks_blocked" or data.name == "coherency_efficiency" then
							value = math.random(0, 1000)
						end
						if data.name == "actual_damage_dealt" then
							value = math.random(5000, 50000)
						end
						if data.name == "overkill_damage_dealt" or data.name == "boss_damage_dealt" then
							value = math.random(6000, 60000)
						end
						if data.name == "chaos_beast_of_nurgle" or data.name == "chaos_daemonhost" or data.name == "chaos_plague_ogryn" or data.name == "chaos_plague_ogryn_sprayer" or data.name == "renegade_captain" then
							value = math.random(0, 1)
						end
						if data.name == "chaos_newly_infected" or data.name == "renegade_berzerker" then
							value = math.random(0, 10)
						end
						if data.name == "small_metal" or data.name == "large_metal" then
							value = math.random(0, 200)
						end
						if data.name == "small_platinum" or data.name == "large_platinum" then
							value = math.random(0, 100)
						end

						if data.name == "carrying_tomes" or data.name == "carrying_grims" or data.name == "carrying_other" then
							local rnd = math.random(0, 2)
							if rnd == 0 then
								value = math.random(3000, 8000) / 10
							end
						end
						
						if value then
							data.data[account_id] = {
								value = value,
								score = value,
								end_score = value,
							}
						end
					end
				end
			end
		end
	end

	-- 0 Values if non-existent
	for row_index, data in pairs(self.rows) do
		if not data.score_summary then
			local col = 0
			for _, player in pairs(players) do
				col = col + 1
				if col < 5 then
					local account_id = player:account_id() or player:name()
					if not data.data[account_id] then
						data.data[account_id] = {
							value = 0,
							score = 0,
							end_score = 0,
						}
					end
				end
			end
		end
	end
	
	-- Row values
	for row_index, data in pairs(self.rows) do
		-- local row = mod:row(row_index + 1, self)
		local row = self.widgets_by_name["scoreboard_row_"..(row_index + 1)]
		if row then
			local name = data.text
			row.content["text"] = name or ""
			for col = 1, 4, 1 do
				row.content["text"..col] = ""
			end
			if not data.score_summary then
				local col = 0
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						local score = data.data[account_id] and data.data[account_id].score or 0
						-- local multiplier = data.multiplier or 1
						local divider = data.divider or 1
						local decimals = data.decimals or 0
						-- local score_addition = data.score_addition or ""
						-- score = score * multiplier
						score = score / divider
						local text = data.value or data.is_time and mod:shorten_time(score, decimals) or mod:shorten_value(score, decimals)
						-- text = text..score_addition
						row.content["text"..col] = text
					end
				end
			end
		end
	end

	-- mod:dtf(self.rows, "self.rows3", 5)

	-- Summaries
	local score_row_names = {}
	for _, data in pairs(self.rows) do
		if data.score_summary then
			score_row_names[#score_row_names+1] = data.name
		end
	end

	-- local temp_scores_done = {}
	local num_score_rows = #score_row_names
	while num_score_rows > 0 do
		for row_index, score_row_name in pairs(score_row_names) do

			local data = self:get_row(score_row_name)

			local rows_ready = true
			for _, row_name in pairs(data.score_summary) do
				if table.array_contains(score_row_names, row_name) then
					rows_ready = false
					break
				end
			end

			if rows_ready then
				local col = 0
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						local score = 0
						for _, row_name in pairs(data.score_summary) do
							local row = mod:get_row(row_name)
							local validation = row.validation
							local value = row.data[account_id] and validation:score(row.data, account_id) or 0
							local multiplier = row.multiplier or 1
							local divider = row.divider or 1
							value = value * multiplier
							value = value / divider
							score = score + value
						end
						data.data[account_id] = {
							value = score,
							score = score,
							end_score = score,
						}
					end
				end

				table.remove(score_row_names, row_index)
				num_score_rows = #score_row_names
			end

		end
	end

	local average = function(data)
		local average = 0
		local col = 0
		for _, player in pairs(players) do
			col = col + 1
			if col < 5 then
				local account_id = player:account_id() or player:name()
				local value = data[account_id] and data[account_id].score or 0
				average = average + value
			end
		end
		local num = math.min(#players, 4)
		local average = average or 0
		return average / num
	end

	-- mod:dtf(self.rows, "self.rows4", 5)

	-- Adjust values
	local target_average = 100
	for row_index, data in pairs(self.rows) do
		if data.score_row then
			local av = average(data.data)
			if av ~= 0 then
				if av > target_average then
					local start_av = av
					local safety = 10000
					while av > target_average and safety > 0 do
						for account_id, values in pairs(data.data) do
							values.score = values.score * 0.9
							values.end_score = values.score
						end
						av = average(data.data)
						safety = safety - 1
					end
					-- mod:echo(data.name.." - "..start_av.." > "..av.." - "..(10000 - safety).." rounds")
				elseif av < target_average then
					local start_av = av
					local safety = 10000
					while av < target_average and safety > 0 do
						for account_id, values in pairs(data.data) do
							values.score = values.score * 1.1
							values.end_score = values.score
						end
						av = average(data.data)
						safety = safety - 1
					end
					-- mod:echo(data.name.." - "..start_av.." > "..av.." - "..(10000 - safety).." rounds")
				end
			end
		end
	end

	-- Widgets
	for row_index, data in pairs(self.rows) do
		if data.score_summary then
			local row = self.widgets_by_name["scoreboard_row_"..(row_index + 1)]
			if row then
				local col = 0
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						local value = data.data[account_id] and data.data[account_id].score or 0
						-- local multiplier = data.multiplier or 1
						local decimals = data.decimals or 0
						-- local score_addition = data.score_addition or ""
						local text = data.value or data.is_time and mod:shorten_time(value, decimals) or mod:shorten_value(value, decimals)
						-- text = text..score_addition
						row.content["text"..col] = text
					end
				end
			end
		end
	end

	-- Best / worst
	for row_index, data in pairs(self.rows) do
		local validation = data.validation
		for char_name, row_data in pairs(data.data) do
			row_data.is_best = validation.is_best(data.data, char_name)
			row_data.is_worst = validation.is_worst(data.data, char_name)
		end
	end

	-- Style
	for row_index, data in pairs(self.rows) do
		local row = self.widgets_by_name["scoreboard_row_"..(row_index + 1)]
		if row then
			local col = 0
			for _, player in pairs(players) do
				col = col + 1
				if col < 5 then
					local account_id = player:account_id() or player:name()
					local text_color = Color.white(255, true)
					if data.data[account_id] then
						if data.data[account_id].is_best then text_color = Color.ui_orange_light(255, true) end
						if account_id == mod:me() and not data.value and data.data[account_id].is_best then
							row.style["style_id_1"].text_color = text_color
						end
					end
					if not data.value then
						local widget_col = col + col + 1
						row.style["style_id_"..widget_col].text_color = text_color
					end
				end
			end
		end
	end

	-- local date = os.time(os.date("!*t"))
	-- mod:dtf(self.rows, "scoreboard_history_"..tostring(date), 5)
	-- mod:save_scoreboard_history_entry()
	-- mod:get_scoreboard_history_entries()
end

mod.appdata_path = function(self)
	local appdata = _os.getenv('APPDATA')
	return appdata.."/Fatshark/Darktide/scoreboard_history/"
end

mod.create_scoreboard_history_directory = function(self)
	_os.execute('mkdir '..self:appdata_path()) -- ?
	_os.execute("mkdir '"..self:appdata_path().."'") -- ?
	_os.execute('mkdir "'..self:appdata_path()..'"') -- Windows
end

mod.create_scoreboard_history_entry_path = function(self)
	local date = _os.time(_os.date("!*t"))
	return self:appdata_path()..tostring(date)..".lua"
end

mod.get_scoreboard_history_entries = function(self, callback)

	-- Lua implementation of PHP scandir function
	local function scandir(directory)
		local i, t, popen = 0, {}, _io.popen
		local pfile = popen('dir "'..directory..'" /b')
		for filename in pfile:lines() do
			i = i + 1
			t[i] = filename
		end
		pfile:close()
		return t
	end

	local entries = {}
	local appdata = self:appdata_path()
	local files = scandir(appdata)
	for _, file in pairs(files) do
		local file_path = appdata..file
		local entry = self:load_scoreboard_history_entry(file_path, file, true)
		entries[#entries+1] = entry
	end

	return entries
end

mod.update_scoreboard_history_entries = function(self)

end

mod.save_scoreboard_history_entry = function(self)
	-- Create appdata folder
	self:create_scoreboard_history_directory()


	local path = self:create_scoreboard_history_entry_path()
	-- Open file
	local file = assert(_io.open(path, "w+"))
	-- Players
	local players = Managers.player:players()
	if self.debug_value then
		players = {
			{
				account_id = function()
					return mod:me()
				end,
				name = function()
					return "Rudge"
				end,
			},
			{
				account_id = function()
					return "lol"
				end,
				name = function()
					return "lol"
				end,
			},
			{
				account_id = function()
					return "rofl"
				end,
				name = function()
					return "rofl"
				end,
			},
			{
				account_id = function()
					return "omg"
				end,
				name = function()
					return "omg"
				end,
			},
		}
	end
	local count = math.min(#players, 4)
	file:write("#players;"..tostring(count).."\n")
	for p = 1, 4, 1 do
		local player = players[p]
		if player then
			local account_id = player:account_id() or player:name()
			file:write(p..";"..player:account_id()..";"..player:name().."\n")
		end
	end
	-- Rows
	for _, row in pairs(self.rows) do
		-- local id = _..row.name
		-- local val_count = row.data and #row.data or 0
		local val_count = 0
		if row.data and type(row.data) == "table" then
			for k,v in pairs(row.data) do
				val_count = val_count + 1
			end
		end
		file:write("#row;"..row.name..";".._..";"..val_count.."\n")
		for account_id, data in pairs(row.data) do
			file:write(account_id..";"..data.score..";"..(data.is_best and "1" or "0")..";"..(data.is_worst and "1" or "0").."\n")
		end
	end
	-- Close file
	file:close()
end

mod.load_scoreboard_history_entry = function(self, path, date, only_head)
	local entry = {
		date = nil,
		players = {},
		rows = {},
	}

	-- split("a,b,c", ",") => {"a", "b", "c"}
	local function split(s, sep)
		local fields = {}
		local sep = sep or " "
		local pattern = string.format("([^%s]+)", sep)
		string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
		return fields
	end

	local function entry_player_id(account_id)
		for id, data in pairs(entry.players) do
			if data.account_id == account_id then
				return id
			end
		end
	end

	-- Open file
	-- local file = assert(_io.open(path, "r"))
	local reading = ""
	local count = 0
	local row_index = 0
	for line in _io.lines(path) do
		-- self:echo(line)
		-- Players
		local player_match = line:match("#players")
		local row_match = line:match("#row")
		if player_match or reading == "players" then
			if player_match then
				reading = "players"
				count = tonumber(split(line, ";")[2])
				entry.date = _os.date(_, tonumber(date))
				-- self:echo(entry.date)
			elseif reading == "players" and count > 0 then
				local player_info = split(line, ";")
				entry.players[player_info[1]] = {
					account_id = player_info[2],
					name = player_info[3],
				}
				count = count - 1
				if count <= 0 then reading = "" end
			end
		elseif (row_match or reading == "row") and not only_head then
			if row_match then
				local info = split(line, ";")
				reading = "row"
				row_index = tonumber(info[3])
				count = tonumber(info[4])
				entry.rows[row_index] = {
					name = info[2],
					data = {},
				}
			elseif reading == "row" and count > 0 and row_index > 0 then
				local val_info = split(line, ";")
				local score = tonumber(val_info[2])
				entry.rows[row_index].data[val_info[1]] = {
					score = score,
					value = score,
					is_best = val_info[3] == "1" and true or false,
					is_worst = val_info[4]  == "1" and true or false,
				}
				count = count - 1
				if count <= 0 then
					reading = ""
					row_index = 0
				end
			end
		end
	end
	-- Players

	-- self:dtf(entry, "scoreboard_entry", 8)
	return entry
end

-- mod.save_scoreboard_history_entry = function(self)
	

-- 	-- local appdata = _os.getenv('APPDATA')
-- 	-- local date = _os.time(_os.date("!*t"))
-- 	-- local path = appdata.."/Fatshark/Darktide/scoreboard_history/"..tostring(date)..".lua"

-- 	self:save_scoreboard_history_entry()
-- 	-- self:echo(path)
-- 	-- table.save(self.rows, path)
-- 	-- self:echo("table.save")
-- 	-- local file = assert(_io.open(path, "w+"))
-- 	-- file:write(tostring(self.rows))
-- 	-- file:close()
-- end


local count_time = 0.1
local animating_row = nil
mod.row_to_animate = function(self)
	for row_index, data in pairs(self.rows) do
		local row = self.widgets_by_name["scoreboard_row_"..(row_index + 1)]
		if not data.was_animated and row and data.empty ~= true and data.visible ~= false then
			-- animating_row = row_index
			self.row_timer = count_time
			local col = 0
			-- for index, data in pairs(data.data) do
			for _, player in pairs(self.players) do
				col = col + 1
				if col < 5 then
					local account_id = player:account_id() or player:name()
					if data.data[account_id] then
						data.data[account_id].end_score = data.data[account_id].score
						data.data[account_id].score = 0
						row.content["text"..col] = data.data[account_id].score
					end
				end
			end
			data.was_animated = true
			self:echo("animating row '"..row_index.."'")
			return row_index
		end
	end
end

mod.update_scoreboard_rows = function(self, dt)
	-- self:echo("test")
	if not animating_row then
		animating_row = self:row_to_animate()
	end
	if animating_row then
		local row = self.widgets_by_name["scoreboard_row_"..(animating_row + 1)]
		if row then
			local players = {}
			for _, player in pairs(self.players) do
				players[#players+1] = player
			end
			local data = self.rows[animating_row]
			if self.row_timer <= 0 then
				local decimals = data.decimals or 0
				local col = 0
				-- for index, data in pairs(data_row.data) do
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						if data.data[account_id] then
							data.data[account_id].score = data.data[account_id].end_score
							local text = data.is_time and mod:shorten_time(data.data[account_id].score, decimals) or 
								mod:shorten_value(data.data[account_id].score, decimals)
							row.content["text"..col] = text
						end
					end
				end
				-- data_row.was_animated = false
				animating_row = nil
			else
				local percentage = self.row_timer / count_time
				local decimals = data.decimals or 0
				local col = 0
				-- for index, data in pairs(data_row.data) do
				for _, player in pairs(players) do
					col = col + 1
					if col < 5 then
						local account_id = player:account_id() or player:name()
						if data.data[account_id] then
							data.data[account_id].score = data.data[account_id].end_score - data.data[account_id].end_score * percentage
							local text = data.is_time and mod:shorten_time(data.data[account_id].score, decimals) or 
								mod:shorten_value(data.data[account_id].score, decimals)
							row.content["text"..col] = text
						end
					end
				end
				self.row_timer = self.row_timer - dt
			end
		end
	end
end

-- ##### ██╗███╗   ██╗ ██████╗██╗     ██╗   ██╗██████╗ ███████╗███████╗ ###############################################
-- ##### ██║████╗  ██║██╔════╝██║     ██║   ██║██╔══██╗██╔════╝██╔════╝ ###############################################
-- ##### ██║██╔██╗ ██║██║     ██║     ██║   ██║██║  ██║█████╗  ███████╗ ###############################################
-- ##### ██║██║╚██╗██║██║     ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║ ###############################################
-- ##### ██║██║ ╚████║╚██████╗███████╗╚██████╔╝██████╔╝███████╗███████║ ###############################################
-- ##### ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ###############################################

Mods.file.dofile("scoreboard/scripts/mods/scoreboard/scoreboard_default_plugins")

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################

mod:initialize()
mod:fill_values()