local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local tostring = tostring
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- mod.end_view_randomize = function(self, item)
--     return mod:handle_husk_item(item)
-- end

-- mod.end_view_change_item = function(self, profile, slot_name)
--     local loadout_item = profile.loadout and profile.loadout[slot_name]
--     local visual_item = profile.visual_loadout and profile.visual_loadout[slot_name]
--     if (not loadout_item or not loadout_item.__master_item) and visual_item then
--         mod:print("end_view change item "..tostring(visual_item))
--         profile.loadout[slot_name] = visual_item
--     else
--         mod:print("end_view item "..tostring(loadout_item).." visual item "..tostring(visual_item).." slot "..tostring(slot_name))
--     end
-- end

-- mod.end_view_change_equipment = function(self, profile)
--     self:end_view_change_item(profile, SLOT_SECONDARY)
--     self:end_view_change_item(profile, SLOT_PRIMARY)
-- end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

-- mod:hook(CLASS.EndView, "_assign_player_to_slot", function(func, self, player, slot, more_than_one_party, ...)
--     -- if player ~= mod:player() then
--     local profile = player:profile()
--     -- Replace equipment
--     mod:end_view_change_equipment(profile)

--     --     mod:end_view_randomize(profile.loadout[SLOT_PRIMARY])
--     --     mod:end_view_randomize(profile.loadout[SLOT_SECONDARY])

--     --     mod:print("reevaluate_packages "..tostring(player))
--     mod:reevaluate_packages(player)
--     -- end
--     -- Original function
--     func(self, player, slot, more_than_one_party, ...)
-- end)
