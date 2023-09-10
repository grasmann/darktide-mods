local mod = get_mod("weapon_customization")

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")
local MasterItems = mod:original_require("scripts/backend/master_items")

local string_find = string.find
local table_contains = table.contains
local unit_debug_name = Unit.debug_name
local unit_set_local_position = Unit.set_local_position
local unit_local_position = Unit.local_position
local unit_world_position = Unit.world_position
local level_units = Level.units
local vector3 = Vector3
local vector3_box = Vector3Box
local pairs = pairs
local CLASS = CLASS
local Application = Application

mod:hook(CLASS.UIWorldSpawner, "_create_world", function(func, self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
    optional_flags = {
		Application.ENABLE_VOLUMETRICS,
        Application.ENABLE_RAY_TRACING,
    }
    return func(self, world_name, layer, timer_name, optional_view_name, optional_flags, ...)
end)

mod:hook(CLASS.UIWorldSpawner, "spawn_level", function(func, self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    func(self, level_name, included_object_sets, position, rotation, ignore_level_background, ...)
    if string_find(self._world_name, "ViewElementInventoryWeaponPreview") then
        local level_units = level_units(self._level, true)
        local unknown_units = {}
        if level_units then
            local move_units = {
                "#ID[7fb88579bf209537]", -- background
                "#ID[7c763e4de74815e3]", -- lights
            }
            local light_units = {
                "#ID[be13f33921de73ac]", -- lights
            }

            mod.preview_lights = {}

            for _, unit in pairs(level_units) do
                if table_contains(move_units, unit_debug_name(unit)) then
                    unit_set_local_position(unit, 1, unit_local_position(unit, 1) + vector3(0, 6, 0))
                end
                if table_contains(light_units, unit_debug_name(unit)) then
                    mod.preview_lights[#mod.preview_lights+1] = {
                        unit = unit,
                        position = vector3_box(unit_local_position(unit, 1)),
                    }
                end
            end
        end
    end
end)

mod:hook(CLASS.MispredictPackageHandler, "_unload_item_packages", function(func, self, item, ...)
end)

mod:hook(CLASS.MispredictPackageHandler, "destroy", function(func, self, ...)
    if mod.cosmetics_view then
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
