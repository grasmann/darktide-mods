local mod = get_mod("weapon_customization")

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")

mod:hook(CLASS.UIWorldSpawner, "_create_world", function(func, self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
    optional_flags = {
		Application.ENABLE_VOLUMETRICS,
        Application.ENABLE_RAY_TRACING,
    }
    return func(self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
end)

mod:hook(CLASS.UIWorldSpawner, "spawn_level", function(func, self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    func(self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    if string.find(self._world_name, "ViewElementInventoryWeaponPreview") then
        local level_units = Level.units(self._level, true)
        if level_units then
            local move_units = {
                "#ID[7fb88579bf209537]",
                "#ID[7c763e4de74815e3]",
            }
            for _, unit in pairs(level_units) do
                if table.contains(move_units, Unit.debug_name(unit)) then
                    Unit.set_local_position(unit, 1, Unit.local_position(unit, 1) + Vector3(0, 6, 0))
                end
            end
        end
    end
end)

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
    if mod.cosmetics_view_open then
        return
    end
	for fixed_frame, items in pairs(self._pending_unloads) do
		for i = 1, #items do
			local item = items[i]

			self:_unload_item_packages(item)
		end
	end

	self._pending_unloads = nil
	self._loaded_packages = nil
end)

-- mod:hook(CLASS.PackageManager, "release", function(func, self, id, ...)
--     if mod.cosmetics_view_open then
--         return
--     end
--     func(self, id, ...)
-- end)

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
