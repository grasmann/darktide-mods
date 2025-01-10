local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local CLASS = CLASS
    local pairs = pairs
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
--#endregion

mod:hook(CLASS.PlayerUnitSpawnManager, "_despawn", function(func, self, player, ...)
    if player:unit_is_alive() then
        local player_unit = player.player_unit
        -- mod:remove_extension(player_unit, "visible_equipment_system")
        for _, system in pairs(mod.systems) do
            mod:execute_extension(player_unit, system, "delete")
            mod:remove_extension(player_unit, system)
        end
    end
    return func(self, player, ...)
end)
-- PlayerUnitSpawnManager._despawn = function (self, player)
-- 	if player:unit_is_alive() then
-- 		local player_unit = player.player_unit
-- 		local unit_spawner_manager = Managers.state.unit_spawner

-- 		Managers.state.out_of_bounds:unregister_soft_oob_unit(player_unit, self)
-- 		unit_spawner_manager:mark_for_deletion(player_unit)
-- 		Managers.event:trigger("player_unit_despawned", player)
-- 	end
-- end