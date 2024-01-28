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
				if widget_data.widget and widget_data.widget.content and widget_data.widget.content.entry then
					if widget_data.widget.content.entry.display_name == mod:localize(setting_id) then
						return widget_data
					end
				end
			end
		end
	end
end

function mod.update_option(setting_id)
	local options_view = managers.ui:view_instance("dmf_options_view")
	if options_view then
		local data_option = mod.fetch_option_from_data(setting_id)
		if data_option then
			if data_option.type == "checkbox" then
				local visible = mod:get(setting_id)
				if data_option.sub_widgets and #data_option.sub_widgets > 0 then
					for _, sub_widget in pairs(data_option.sub_widgets) do
						local option = mod.fetch_option_from_view(sub_widget.setting_id)
						option.widget.visible = visible
					end
				end
			end
		end
	end
end

function mod.update_options(obj)
	local obj = obj or WeaponCustomizationData.options.widgets
	for _, option in pairs(obj) do
		mod.update_option(option.setting_id)
		if option.sub_widgets then
			mod.update_options(option.sub_widgets)
		end
	end
end