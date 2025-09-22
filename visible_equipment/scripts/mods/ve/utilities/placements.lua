local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local placements = {
    POCKETABLE_SMALL = "POCKETABLE_SMALL",
    POCKETABLE = "POCKETABLE",
    hip_front = "hip_front",
    hip_right = "hip_right",
    leg_right = "leg_right",
    hip_back = "hip_back",
    hip_left = "hip_left",
    leg_left = "leg_left",
    default = "default",
    chest = "chest",
}

--#region Copies
    placements.backpack = placements.default
--#endregion

return placements