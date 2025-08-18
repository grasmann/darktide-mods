local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/ui/views/main_menu_background_view/main_menu_background_view", function(instance)

    instance.update_placements = function(self)
		local profile_spawner = self._profile_spawner
        if profile_spawner and profile_spawner._character_spawn_data then
            local character_spawn_data = profile_spawner._character_spawn_data
            local equipment_component = character_spawn_data.equipment_component
            if equipment_component then
                equipment_component:position_objects()
                equipment_component:animate_equipment()
            end
        end
	end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.MainMenuBackgroundView, "_spawn_profile", function(func, self, profile, ...)
    -- Load gear placements for profile from file
    local primary_item = profile.loadout.slot_primary
    local secondary_item = profile.loadout.slot_secondary
    local primary_gear_id = primary_item and primary_item.__gear_id or primary_item.gear_id
    local secondary_gear_id = secondary_item and secondary_item.__gear_id or secondary_item.gear_id
    mod:gear_placement(primary_gear_id, nil, true)
    mod:gear_placement(secondary_gear_id, nil, true)
    -- Original function
    func(self, profile, ...)
end)
