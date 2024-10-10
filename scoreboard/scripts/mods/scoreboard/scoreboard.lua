local mod = get_mod("scoreboard")
mod.name = "scoreboard"

local DMF = get_mod("DMF")
local _os = DMF:persistent_table("_os")
_os.initialized = _os.initialized or false
if not _os.initialized then _os = DMF.deepcopy(Mods.lua.os) end

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local table = table
local pairs = pairs
local CLASS = CLASS
local string = string
local tonumber = tonumber
local managers = Managers
local table_clear = table.clear
local string_format = string.format

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local ScoreboardData = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_data")

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

function mod.on_game_state_changed(status, state_name)
	-- Clear row values on game state enter
	if state_name == "StateGameplay" and status == "enter" then mod:clear() end
end

function mod.on_all_mods_loaded()
	-- Load packages
	mod:load_package("packages/ui/views/end_player_view/end_player_view")
	mod:load_package("packages/ui/views/store_item_detail_view/store_item_detail_view")
	-- Collect scoreboard rows from mods
	mod:collect_scoreboard_rows()
end

function mod.reload_mods()
	-- Collect scoreboard rows from mods
    mod:collect_scoreboard_rows()
end

function mod.update(main_dt)
	-- mod:update_scoreboard_rows()
	mod:update_coherency(main_dt)
	mod:update_carrying(main_dt)
end

function mod.on_setting_changed(setting_id)
	mod.update_option(setting_id)
	mod.tactical_overview = mod:get("tactical_overview")
end

-- #####  ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗ #####################################################
-- ##### ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ #####################################################
-- ##### ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗ #####################################################
-- ##### ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║ #####################################################
-- ##### ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║ #####################################################
-- #####  ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ #####################################################

function mod.find_option_in_data(obj, setting_id)
	for _, option in pairs(obj) do
		if option.setting_id == setting_id then
			return option
		elseif option.sub_widgets and #option.sub_widgets > 0 then
			local sub = mod.find_option_in_data(option.sub_widgets, setting_id)
			if sub then return sub end
		end
	end
end

function mod.fetch_option_from_data(setting_id)
	local option = mod.find_option_in_data(ScoreboardData.options.widgets, setting_id)
	return option
end

function mod.fetch_option_from_view(setting_id)
	local options_view = mod.ui_manager:view_instance("dmf_options_view")
	if options_view then
		for mod_name, mod_group in pairs(options_view._settings_category_widgets) do
			for index, widget_data in pairs(mod_group) do
				if widget_data.widget and widget_data.widget.content and widget_data.widget.content.entry then
					if widget_data.widget.content.entry.display_name == mod:localize(setting_id) then
						-- mod:dtf(widget_data, "widget_data", 5)
						return widget_data
					end
				end
			end
		end
	end
end

function mod.update_option(setting_id)
	local options_view = mod.ui_manager:view_instance("dmf_options_view")
	if options_view then
		local data_option = mod.fetch_option_from_data(setting_id)
		if data_option.type == "checkbox" then
			local visible = mod:get(setting_id)
			if data_option.sub_widgets and #data_option.sub_widgets > 0 then
				for _, sub_widget in pairs(data_option.sub_widgets) do
					local option = mod.fetch_option_from_view(sub_widget.setting_id)
					option.widget.content.disabled = visible == false
					option.widget.content.hotspot.disabled = visible == false
				end
			end
		end
	end
end

function mod.update_options()
	for _, option in pairs(ScoreboardData.options.widgets) do
		mod.update_option(option.setting_id)
	end
end

function mod.open_scoreboard()
	if mod:scoreboard_opened() then
		mod:close_scoreboard_view()
	else
		if mod:get("dev_mode") then mod:show_scoreboard_view() end
	end
end

--BaseView.on_enter = function (self)
-- mod:hook(CLASS.BaseView, "on_enter", function(func, self, ...)
-- 	func(self, ...)
-- 	mod:echo(self.view_name)
-- end)

mod:hook(CLASS.BaseView, "_on_view_load_complete", function(func, self, loaded, ...)
	func(self, loaded, ...)
	if self.view_name == "dmf_options_view" then
		mod.update_options()
	end
end)

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

mod.initialize = function(self)
	if not self.initialized then
		self.definitions = self:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")
		self.ui_font_settings = self:original_require("scripts/managers/ui/ui_font_settings")
		self.ui_manager = managers.ui
		self.player_manager = managers.player
		self.package_manager = managers.package
	end
	self.initialized = true
end

mod.set_mission_name = function(self, mission_name)
	self.mission_name = mission_name
end
mod.set_mission_circumstance = function(self, mission_circumstance)
	self.mission_circumstance = mission_circumstance
end
mod.set_mission_challenge = function(self, mission_challenge)
	self.mission_challenge = mission_challenge
end
mod.set_victory_defeat = function(self, victory_defeat)
	self.victory_defeat = victory_defeat
end
mod.initialize_timer = function(self)
	self.timer = _os.time()
end

mod.load_package = function(self, package_name)
	local package_manager = self.package_manager
	if not package_manager:is_loading(package_name) and not package_manager:has_loaded(package_name) then
		return package_manager:load(package_name, "scoreboard", nil, true)
	end
end

mod.release_package = function(self, package_id)
	local package_manager = self.package_manager
	package_manager:release(package_id)
end

mod.register_scoreboard_view = function(self)
	self:add_require_path("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view")
	self:add_require_path("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_definitions")
	self:add_require_path("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view_settings")
	self:register_view({
		view_name = "scoreboard_view",
		view_settings = {
			init_view_function = function (ingame_ui_context)
				return true
			end,
			class = "ScoreboardView",
			disable_game_world = false,
			display_name = "loc_scoreboard_view_display_name",
			game_world_blur = 0,
			load_always = true,
			load_in_hub = true,
			package = "packages/ui/views/options_view/options_view",
			path = "scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view",
			state_bound = false,
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
	self:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard/scoreboard_view")
end

mod.register_scoreboard_history_view = function(self)
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
			close_all = true,
			close_previous = true,
			close_transition_time = nil,
			transition_time = nil
		}
	})
	self:io_dofile("scoreboard/scripts/mods/scoreboard/history/scoreboard_history_view")
end

-- ##### ┌─┐┌─┐┌─┐┬─┐┌─┐┌┐ ┌─┐┌─┐┬─┐┌┬┐ ###############################################################################
-- ##### └─┐│  │ │├┬┘├┤ ├┴┐│ │├─┤├┬┘ ││ ###############################################################################
-- ##### └─┘└─┘└─┘┴└─└─┘└─┘└─┘┴ ┴┴└──┴┘ ###############################################################################

mod.show_scoreboard_view = function(self, context)
	self:close_scoreboard_view()
    self.ui_manager:open_view("scoreboard_view", nil, false, false, nil, context or {}, {use_transition_ui = false})
end

mod.scoreboard_opened = function(self)
	return self.ui_manager:view_active("scoreboard_view") and not self.ui_manager:is_view_closing("scoreboard_view")
end

mod.close_scoreboard_view = function(self)
	if self.ui_manager:view_active("scoreboard_view") and not self.ui_manager:is_view_closing("scoreboard_view") then
        self.ui_manager:close_view("scoreboard_view", true)
    end
end

-- ##### ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ##########################################################################################
-- ##### └┐┌┘├─┤│  │ │├┤ └─┐ ##########################################################################################
-- #####  └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ##########################################################################################

mod.clear = function(self)
	for row_index, data in pairs(self.registered_scoreboard_rows) do
		if data.data then table_clear(data.data)
		else data.data = {} end
	end
end

mod.update_stat = function(self, name, account_id, value)
	self:update_row_value(name, account_id, value)
end

mod.shorten_value = function(self, value, decimals)
	if value >= 1000 then return string_format("%.1fK", value / 1000) end
	return string_format("%."..(decimals or 0).."f", value)
end

mod.shorten_time = function(self, time, decimals)
	if time >= 60 then return string_format("%.1f", time / 60).."m" end
	return string_format("%."..(decimals or 0).."f", time).."s"
end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod.me = function(self)
	return self.player_manager:local_player(1):account_id()
end

mod.is_me = function(self, account_id)
	return account_id == mod:me()
end

mod.is_numeric = function(self, x)
    if tonumber(x) ~= nil then return true end
    return false
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- Get mission name
mod:hook(CLASS.StateGameplay, "on_enter", function(func, self, parent, params, creation_context, ...)
	func(self, parent, params, creation_context, ...)
	mod:set_mission_name(params.mission_name)
	mod:set_mission_circumstance(params.mechanism_data.circumstance_name)
	mod:set_mission_challenge(params.mechanism_data.challenge)
	mod:initialize_timer()
end)

mod:hook(CLASS.GameModeManager, "_set_end_conditions_met", function(func, self, outcome, ...)
	func(self, outcome,...)
	mod:set_victory_defeat(outcome)
end)

mod:hook(CLASS.EndView, "on_enter", function(func, self, ...)
	func(self, ...)
	mod:show_scoreboard_view({end_view = true})
end)

mod:hook(CLASS.EndView, "on_exit", function(func, self, ...)
	func(self, ...)
	mod:close_scoreboard_view()
end)

mod:hook_require("scripts/ui/views/end_player_view/end_player_view_definitions", function(instance)
	local card_carousel = instance.scenegraph_definition.card_carousel
	if card_carousel then
		card_carousel.horizontal_alignment = "right"
		card_carousel.position = {-130, 350, 0}
	end
end)

mod:hook(CLASS.EndPlayerView, "on_enter", function(func, self, ...)
	func(self, ...)
	local view = mod.ui_manager:view_instance("scoreboard_view")
	if view then view:move_scoreboard(0, -300) end
end)

-- EndPlayerView._update_carousel = function (self, dt, t, input_service)
-- mod:hook(CLASS.EndPlayerView, "on_exit", function(func, self, dt, t, input_service, ...)
-- 	func(self, dt, t, input_service, ...)
-- end)

mod:hook(CLASS.EndPlayerView, "on_exit", function(func, self, ...)
	func(self, ...)
	local view = mod.ui_manager:view_instance("scoreboard_view")
	if view then view:move_scoreboard(-300, 0) end
end)

-- ##### ██╗███╗   ██╗ ██████╗██╗     ██╗   ██╗██████╗ ███████╗███████╗ ###############################################
-- ##### ██║████╗  ██║██╔════╝██║     ██║   ██║██╔══██╗██╔════╝██╔════╝ ###############################################
-- ##### ██║██╔██╗ ██║██║     ██║     ██║   ██║██║  ██║█████╗  ███████╗ ###############################################
-- ##### ██║██║╚██╗██║██║     ██║     ██║   ██║██║  ██║██╔══╝  ╚════██║ ###############################################
-- ##### ██║██║ ╚████║╚██████╗███████╗╚██████╔╝██████╔╝███████╗███████║ ###############################################
-- ##### ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ###############################################

-- Load scoreboard view
mod:register_scoreboard_view()

-- Load scoreboard history view
mod:register_scoreboard_history_view()

-- Load scoreboard components
mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_rows")
mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_history")
mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_default_plugins")
mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_hud")

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################

mod:initialize()
