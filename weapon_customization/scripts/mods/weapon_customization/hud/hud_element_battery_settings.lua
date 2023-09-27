
-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local hud_element_battery_settings = {
	max_glow_alpha = 130,
	center_offset = 210,
	spacing = 4,
	half_distance = 1,
	bar_size = {200, 9},
	area_size = {220, 40}
}

-- ##### ┬─┐┌─┐┌┬┐┬ ┬┬─┐┌┐┌ ###########################################################################################
-- ##### ├┬┘├┤  │ │ │├┬┘│││ ###########################################################################################
-- ##### ┴└─└─┘ ┴ └─┘┴└─┘└┘ ###########################################################################################

return settings("HudElementBatterySettings", hud_element_battery_settings)
