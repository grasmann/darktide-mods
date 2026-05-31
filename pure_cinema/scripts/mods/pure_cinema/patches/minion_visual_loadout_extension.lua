local mod = get_mod("pure_cinema")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
	local CLASS = CLASS
	local managers = Managers
	local script_unit = ScriptUnit
	local script_unit_extension = script_unit.extension
	local script_unit_add_extension = script_unit.add_extension
	local script_unit_remove_extension = script_unit.remove_extension
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "pure_cinema"

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod:hook_require("scripts/extension_systems/visual_loadout/minion_visual_loadout_extension", function(instance)


	instance._trigger_unit_line_fx = function(self, line_effect, inventory_slot_name, fx_source_name, end_position)

		local discharge_extension = script_unit_extension(self._unit, "discharge_system")
		if discharge_extension then
			discharge_extension:trigger_unit_line_fx(line_effect, inventory_slot_name, fx_source_name, end_position)
		end

	end

	instance.update = function(self, unit, dt, t)

		local discharge_extension = script_unit_extension(self._unit, "discharge_system")
		if discharge_extension then
			discharge_extension:update(dt, t)
		end

		local helmet_extension = script_unit_extension(self._unit, "helmet_system")
		if helmet_extension then
			helmet_extension:update(dt, t)
		end

	end

	instance.on_settings_changed = function(self)
		self.weapon_discharge = mod:get("weapon_discharge")
		self.helmet_drop = mod:get("helmet_drop")
	end

	instance.destroy_extensions = function(self)

		if script_unit_extension(self._unit, "discharge_system") then
			script_unit_remove_extension(self._unit, "discharge_system")
		end

		if script_unit_extension(self._unit, "helmet_system") then
			script_unit_remove_extension(self._unit, "helmet_system")
		end

	end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.MinionVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id, ...)

	func(self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id, ...)

	-- Register Events
	managers.event:register(self, "pure_cinema_settings_changed", "on_settings_changed")
	
	-- Set initial values
	self:on_settings_changed()

	if self.weapon_discharge and not script_unit_extension(unit, "discharge_system") then
		script_unit_add_extension(
			{
				world = self._world
			},
			self._unit,
			"DischargeExtension",
			"discharge_system",
			{
				visual_loadout_extension = self,
				wielded_slot_name = self._wielded_slot_name,
			}
		)
	end

	if self.helmet_drop and not script_unit_extension(unit, "helmet_system") then
		script_unit_add_extension(
			{
				world = self._world
			},
			self._unit,
			"HelmetExtension",
			"helmet_system",
			{
				visual_loadout_extension = self,
			}
		)
	end

end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "_wield_slot", function(func, self, slot_name, ...)

	func(self, slot_name, ...)

	local discharge_extension = script_unit_extension(self._unit, "discharge_system")
	if discharge_extension then
		discharge_extension:on_wield(self._wielded_slot_name)
	end

end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "extensions_ready", function(func, self, world, unit, ...)

	-- Original function
	func(self, world, unit, ...)

	-- Add to persistent table
	pt.visual_loadout_extensions[self._unit] = self

	local discharge_extension = script_unit_extension(self._unit, "discharge_system")
	if discharge_extension then
		discharge_extension:extensions_ready()
	end

	local helmet_extension = script_unit_extension(self._unit, "helmet_system")
	if helmet_extension then
		helmet_extension:extensions_ready()
	end

end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "destroy", function(func, self, ...)

	-- Remove from persistent table
	pt.visual_loadout_extensions[self._unit] = nil

	-- Unregister Events
	managers.event:unregister(self, "pure_cinema_settings_changed")

	self:destroy_extensions()

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "_unequip_slot", function(func, self, slot_name, ...)

	self:destroy_extensions()

	return func(self, slot_name, ...)

end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "_send_on_death_event", function(func, self, ...)

	local discharge_extension = script_unit_extension(self._unit, "discharge_system")
	if discharge_extension and discharge_extension:will_discharge() and  discharge_extension:trigger_name() == "death" then
		return
	end

	return func(self, ...)
end)

mod:hook(CLASS.MinionVisualLoadoutExtension, "_drop_slot", function(func, self, slot_name, ...)

	local discharge_extension = script_unit_extension(self._unit, "discharge_system")
	if discharge_extension then
		return discharge_extension:on_drop_slot(slot_name)
	else
		return func(self, slot_name, ...)
	end

end)
