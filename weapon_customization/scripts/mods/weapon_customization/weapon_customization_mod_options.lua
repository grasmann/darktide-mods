local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local WeaponCustomizationData = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_data")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
	local pairs = pairs
	local CLASS = CLASS
	local tostring = tostring
	local managers = Managers
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

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
	return mod.find_option_in_data(WeaponCustomizationData.options.widgets, setting_id)
end

function mod.fetch_option_from_view(setting_id)
	local options_view = managers.ui:view_instance("dmf_options_view")
	if options_view then
		for mod_name, mod_group in pairs(options_view._settings_category_widgets) do
			for index, widget_data in pairs(mod_group) do
				if widget_data.widget and widget_data.widget.content then
					local content = widget_data.widget.content
					local entry = content.entry
					if entry and entry.display_name == mod:localize_or_global(setting_id) then
						return widget_data
					end
				end
			end
		end
	end
end

function mod.fetch_sub_widgets_recursively(data_option, sub_widgets_out)
	if data_option.sub_widgets then
		for _, sub_widget in pairs(data_option.sub_widgets) do
			sub_widgets_out[#sub_widgets_out+1] = sub_widget.setting_id
			mod.fetch_sub_widgets_recursively(sub_widget, sub_widgets_out)
		end
	end
end

function mod.update_option(setting_id, visible)
	local options_view = managers.ui:view_instance("dmf_options_view")
	if options_view then
		local data_option = mod.fetch_option_from_data(setting_id)
		if data_option then
			if data_option.type == "checkbox" then
				local visible = visible ~= nil and visible or mod:get(setting_id)
				local sub_widgets = {}
				mod.fetch_sub_widgets_recursively(data_option, sub_widgets)
				for _, sub_widget_setting_id in pairs(sub_widgets) do
					local option = mod.fetch_option_from_view(sub_widget_setting_id)
					if option then option.widget.visible = visible end
				end
			end
		end
	end
end

function mod.update_options(obj, visible)
	local obj = obj or WeaponCustomizationData.options.widgets
	for _, option in pairs(obj) do
		local visible = visible ~= nil and visible or mod:get(option.setting_id)
		mod.update_option(option.setting_id, visible)
	end
	for _, option in pairs(obj) do
		if option.sub_widgets then
			local visible = visible ~= nil and visible or mod:get(option.setting_id)
			mod.update_options(option.sub_widgets, visible)
		end
	end
end