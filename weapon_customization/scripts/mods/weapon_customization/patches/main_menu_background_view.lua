local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
	local CLASS = CLASS
	local managers = Managers
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local OPTION_VISIBLE_EQUIPMENT_NO_HUB = "mod_option_visible_equipment_disable_in_hub"
	local OPTION_VISIBLE_EQUIPMENT = "mod_option_visible_equipment"
	local WEAPON_CUSTOMIZATION_TAB = "tab_weapon_customization"
	local SLOT_SECONDARY = "slot_secondary"
	local SLOT_PRIMARY = "slot_primary"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/ui/views/main_menu_background_view/main_menu_background_view", function(instance)

	instance.custom_enter = function(self)
		managers.event:register(self, "weapon_customization_weapon_changed", "on_weapon_changed")
	end

	instance.custom_exit = function(self)
		managers.event:unregister(self, "weapon_customization_weapon_changed")
	end

	instance.respawn_profile = function(self)
		self:_spawn_profile(self._spawned_profile)
	end

	instance.on_weapon_changed = function(self)
		self:respawn_profile()
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.MainMenuBackgroundView, "on_enter", function(func, self, ...)

	-- Original function
	func(self, ...)

	-- Custom initialization
	self:custom_enter()

end)

mod:hook(CLASS.MainMenuBackgroundView, "on_exit", function(func, self, ...)

	-- Original function
	func(self, ...)

	-- Custom initialization
	self:custom_exit()

end)