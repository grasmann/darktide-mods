local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
	local table = table
	local CLASS = CLASS
	local ipairs = ipairs
	local managers = Managers
	local table_sort = table.sort
	local table_insert = table.insert
	local table_find_by_key = table.find_by_key
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local SLOT_SECONDARY = "slot_secondary"
	local hud_element_script = "weapon_customization/scripts/mods/weapon_customization/hud/hud_element_battery"
	local hud_element_class = "HudElementBattery"
--#endregion

-- ##### ┬ ┬┬ ┬┌┬┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###################################################################################
-- ##### ├─┤│ │ ││  ├─┘├─┤ │ │  ├─┤ ###################################################################################
-- ##### ┴ ┴└─┘─┴┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###################################################################################

-- Add hud element to hud
mod:add_require_path(hud_element_script)
mod:hook(CLASS.UIHud, "init", function(func, self, elements, visibility_groups, params, ...)
	if not table_find_by_key(elements, "class_name", hud_element_class) then
		table_insert(elements, {
			filename = hud_element_script,
			class_name = hud_element_class,
			visibility_groups = {
				"alive",
				"tactical_overlay",
				"in_view",
			},
		})
	end
	func(self, elements, visibility_groups, params, ...)
end)