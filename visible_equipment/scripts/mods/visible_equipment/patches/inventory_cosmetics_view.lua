local mod = get_mod("visible_equipment")

local CLASS = CLASS

mod:hook(CLASS.InventoryCosmeticsView, "_preview_element", function(func, self, element, ...)

    -- Original function
    func(self, element, ...)

    if self._profile_spawner and self._profile_spawner._character_spawn_data then
        local equipment_component = self._profile_spawner._character_spawn_data.equipment_component
        equipment_component:update_objects()
    end

end)

mod:hook(CLASS.InventoryCosmeticsView, "_stop_previewing", function(func, self, ...)

    -- Original function
    func(self, ...)

    if self._profile_spawner and self._profile_spawner._character_spawn_data then
        local equipment_component = self._profile_spawner._character_spawn_data.equipment_component
        equipment_component:update_objects()
    end

end)