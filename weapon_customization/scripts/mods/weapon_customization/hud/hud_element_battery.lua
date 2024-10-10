local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Definitions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/hud/hud_element_battery_definitions")
local HudElementBatterySettings = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/hud/hud_element_battery_settings")

local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local UIHudSettings = mod:original_require("scripts/settings/ui/ui_hud_settings")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local Color = Color
	local math_max = math.max
	local math_abs = math.abs
	local math_min = math.min
	local math_ceil = math.ceil
	local math_round = math.round
	local math_clamp = math.clamp
	local string_format = string.format
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local STAMINA_STATE_COLORS = {
	empty = UIHudSettings.color_tint_alert_2,
	half = UIHudSettings.player_status_colors.consumed,
	full = Color.ui_hud_green_light(255, true),
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local HudElementBattery = class("HudElementBattery", "HudElementBase")

HudElementBattery.init = function (self, parent, draw_layer, start_scale)
	HudElementBattery.super.init(self, parent, draw_layer, start_scale, Definitions)
	self._charges = {}
	self._charge_width = 0
	self._charge_widget = self:_create_widget("charge", Definitions.charge_definition)
end

HudElementBattery.destroy = function (self)
	HudElementBattery.super.destroy(self)
end

HudElementBattery._add_charge = function (self)
	self._charges[#self._charges + 1] = true
end

HudElementBattery._remove_charge = function (self)
	self._charges[#self._charges] = nil
end

HudElementBattery.update = function (self, dt, t, ui_renderer, render_settings, input_service)
	HudElementBattery.super.update(self, dt, t, ui_renderer, render_settings, input_service)
	self:_update_charge_amount()
	self:_update_visibility(dt)
end

HudElementBattery._update_charge_amount = function (self)
	local current = mod:get_battery_charge()
	local max = mod:get_battery_max()
	local charge_amount = current or 0
	local charge_amount_ceiled = current and math_ceil(current) or 0

	if charge_amount_ceiled ~= self._charge_amount then
		local amount_difference = (self._charge_amount or 0) - charge_amount_ceiled
		self._charge_amount = charge_amount_ceiled
		local bar_size = HudElementBatterySettings.bar_size
		local segment_spacing = HudElementBatterySettings.spacing
		local total_segment_spacing = segment_spacing * math_max(charge_amount_ceiled - 1, 0)
		local total_bar_length = bar_size[1] - total_segment_spacing
		self._charge_width = math_round(charge_amount_ceiled > 0 and total_bar_length / charge_amount_ceiled or total_bar_length)
		local widget = self._charge_widget

		self:_set_scenegraph_size("charge", self._charge_width)

		local add_charges = amount_difference < 0

		for i = 1, math_abs(amount_difference) do
			if add_charges then
				self:_add_charge()
			else
				self:_remove_charge()
			end
		end

		self._start_on_half_bar = charge_amount ~= charge_amount_ceiled
	end
end

HudElementBattery.on_resolution_modified = function (self)
	HudElementBattery.super.on_resolution_modified(self)
end

HudElementBattery._update_visibility = function (self, dt)
	local max = mod:get_battery_max()
	local charge_fraction = mod:get_battery_fraction() or 1
	local draw = mod:get("mod_option_battery_show") and charge_fraction < mod:get("mod_option_battery_show_threshold") and max and max > 0

	local alpha_speed = 3
	local alpha_multiplier = self._alpha_multiplier or 0

	if draw then
		alpha_multiplier = math_min(alpha_multiplier + dt * alpha_speed, 1)
	else
		alpha_multiplier = math_max(alpha_multiplier - dt * alpha_speed, 0)
	end

	self._alpha_multiplier = alpha_multiplier
end

HudElementBattery._draw_widgets = function (self, dt, t, input_service, ui_renderer, render_settings)
	if self._alpha_multiplier ~= 0 then
		local previous_alpha_multiplier = render_settings.alpha_multiplier
		render_settings.alpha_multiplier = self._alpha_multiplier

		HudElementBattery.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)
		self:_draw_charges(dt, t, ui_renderer)

		render_settings.alpha_multiplier = previous_alpha_multiplier
	end
end

HudElementBattery._draw_charges = function (self, dt, t, ui_renderer)
	local num_charges = self._charge_amount

	if num_charges < 1 then
		return
	end

	local widget = self._charge_widget
	local widget_offset = widget.offset
	local charge_width = self._charge_width
	local bar_size = HudElementBatterySettings.bar_size
	local max_glow_alpha = HudElementBatterySettings.max_glow_alpha
	local half_distance = HudElementBatterySettings.half_distance

	local charge_fraction = mod:get_battery_fraction() or 1

	local gauge_widget = self._widgets_by_name.gauge
	gauge_widget.content.value_text = string_format("%.0f%%", math_clamp(charge_fraction, 0, 1) * 100)
	local step_fraction = 1 / num_charges

	if self._start_on_half_bar then
		charge_fraction = charge_fraction - step_fraction * 0.51
	end

	local spacing = HudElementBatterySettings.spacing
	local x_offset = (charge_width + spacing) * (num_charges - 1) * 0.5
	local charges = self._charges

	for i = num_charges, 1, -1 do
		local charge = charges[i]

		if not charge then
			return
		end

		local end_value = i * step_fraction
		local start_value = end_value - step_fraction
		local is_full, is_half, is_empty = nil, nil, nil

		if charge_fraction >= start_value + step_fraction * 0.5 then
			is_full = true
		elseif start_value < charge_fraction then
			is_half = true
		else
			is_empty = true
		end

		local active_color = nil

		if is_empty then
			active_color = STAMINA_STATE_COLORS.empty
		elseif is_full then
			active_color = STAMINA_STATE_COLORS.full
		elseif is_half then
			active_color = STAMINA_STATE_COLORS.half
		end

		local widget_style = widget.style
		local widget_color = widget_style.full.color
		widget_color[1] = active_color[1]
		widget_color[2] = active_color[2]
		widget_color[3] = active_color[3]
		widget_color[4] = active_color[4]
		widget_offset[1] = x_offset

		UIWidget.draw(widget, ui_renderer)

		x_offset = x_offset - charge_width - spacing
	end
end

return HudElementBattery
