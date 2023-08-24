local mod = get_mod("weapon_customization")

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")
local WeaponCustomizationData = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_customization_data")

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
	for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]

			self:_unload_item_packages(item)
		end
	end

	self._pending_unloads = nil
	self._loaded_packages = nil
end)

mod.attachment_package_snapshot = function(self, item, test_data)
    local packages = test_data or {}
    if not test_data then
        local attachments = item.__master_item.attachments
        ItemPackage._resolve_item_packages_recursive(attachments, MasterItems.get_cached(), packages)
    end
    if self.old_package_snapshot then
        self.new_package_snapshot = packages
        return self:attachment_package_resolve()
    else
        self.old_package_snapshot = packages
    end
end

mod.attachment_package_resolve = function(self)
    if self.old_package_snapshot and self.new_package_snapshot then
        local old_packages = {}
        for name, _ in pairs(self.old_package_snapshot) do
            if not self.new_package_snapshot[name] then
                old_packages[#old_packages+1] = name
            end
        end
        local new_packages = {}
        for name, _ in pairs(self.new_package_snapshot) do
            if not self.old_package_snapshot[name] then
                new_packages[#new_packages+1] = name
            end
        end
        self.old_package_snapshot = nil
        self.new_package_snapshot = nil
        return old_packages, new_packages
    end
end

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
	local options_view = Managers.ui:view_instance("dmf_options_view")
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
	local options_view = Managers.ui:view_instance("dmf_options_view")
	if options_view then
		local data_option = mod.fetch_option_from_data(setting_id)
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

function mod.update_options()
	for _, option in pairs(WeaponCustomizationData.options.widgets) do
		mod.update_option(option.setting_id)
	end
end

mod:hook(CLASS.BaseView, "_on_view_load_complete", function(func, self, loaded, ...)
	func(self, loaded, ...)
	if self.view_name == "dmf_options_view" then
		mod.update_options()
	end
end)