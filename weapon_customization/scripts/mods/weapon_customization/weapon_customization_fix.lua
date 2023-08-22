local mod = get_mod("weapon_customization")

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
    if self._loaded_packages then
        local mission = self._mission
        local dependencies = ItemPackage.compile_item_instance_dependencies(item, self._item_definitions, nil, mission)

        for package_name, _ in pairs(dependencies) do
            if self._loaded_packages[package_name] then
                local loaded_packages = self._loaded_packages[package_name]
                if not table.contains(mod.packages, package_name) then
                    local load_id = table.remove(loaded_packages, #loaded_packages)

                    Managers.package:release(load_id)
                end
                if table.is_empty(loaded_packages) then
                    self._loaded_packages[package_name] = nil
                end
            end
        end
    end
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