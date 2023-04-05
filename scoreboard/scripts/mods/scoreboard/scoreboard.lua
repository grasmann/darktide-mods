local mod = get_mod("scoreboard")
mod.name = "scoreboard"

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
	if state_name == "StateGameplay" and status == "enter" then
		mod:clear()
		mod:set_mission_name()
	end
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
	mod:set_mission_name()
end

function mod.update(main_dt)
	-- mod:update_scoreboard_rows()
	mod:update_coherency(main_dt)
	mod:update_carrying(main_dt)
end

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
		self.ui_manager = Managers.ui
		self.player_manager = Managers.player
		self.package_manager = Managers.package
		self.mission_state_manager = Managers.state.mission
		self:set_mission_name()
	end
	self.initialized = true
end

mod.set_mission_name = function(self)
	self.mission_name = self.mission_state_manager and self.mission_state_manager:mission_name()
end

mod.load_package = function(self, package_name)
	local package_manager = self.package_manager
	if not package_manager:is_loading(package_name) and not package_manager:has_loaded(package_name) then
		package_manager:load(package_name, "scoreboard", nil, true)
	end
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
		data.data = {}
	end
end

mod.update_stat = function(self, name, account_id, value)
	self:update_row_value(name, account_id, value)
end

mod.shorten_value = function(self, value, decimals)
	if value >= 1000 then return string.format("%.1fK", value / 1000) end
	local decimals = decimals or 0
	return string.format("%."..decimals.."f", value)
end

mod.shorten_time = function(self, time, decimals)
	if time >= 60 then return string.format("%.1f", time / 60).."m" end
	local decimals = decimals or 0
	return string.format("%."..decimals.."f", time).."s"
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

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

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

-- ##### ██╗███╗   ██╗██╗████████╗ ####################################################################################
-- ##### ██║████╗  ██║██║╚══██╔══╝ ####################################################################################
-- ##### ██║██╔██╗ ██║██║   ██║    ####################################################################################
-- ##### ██║██║╚██╗██║██║   ██║    ####################################################################################
-- ##### ██║██║ ╚████║██║   ██║    ####################################################################################
-- ##### ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝    ####################################################################################

mod:initialize()
