local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local math = math
    local class = class
    local wc_perf = wc_perf
    local math_clamp = math.clamp
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
--#endregion

-- ##### ┌┐ ┌─┐┌┬┐┌┬┐┌─┐┬─┐┬ ┬  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ############################################################
-- ##### ├┴┐├─┤ │  │ ├┤ ├┬┘└┬┘  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ############################################################
-- ##### └─┘┴ ┴ ┴  ┴ └─┘┴└─ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ############################################################

local BatteryExtension = class("BatteryExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize
BatteryExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Initialize parent
    BatteryExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Attributes
    self.consumer_template = extension_init_data.consumer_template
    self.consumer = extension_init_data.consumer
    self.battery_template = extension_init_data.battery_template
    -- Values
    self.current_charge = self.battery_template.max
    self.timer = 0
    self.on = extension_init_data.on or self.is_local_unit and mod:flashlight_active() or false
    -- Init
    self.initialized = true
end

BatteryExtension.delete = function(self)
    -- Deinit
    self.initialized = false
    -- Delete parent
    BatteryExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Recharge battery instantly
BatteryExtension.recharge_battery = function(self)
	self.current_charge = self.battery_template.max
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

-- Set battery enabled / disabled
BatteryExtension.set_enabled = function(self, value)
    self.on = value
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

-- Get current battery charge
BatteryExtension.charge = function(self)
	return self.current_charge
end

-- Get max battery charge
BatteryExtension.max = function(self)
    return self.battery_template.max
end

-- Get battery charge fraction
BatteryExtension.fraction = function(self)
    -- Current battery charge or max
    local current = self.current_charge or self.battery_template.max
    -- Max battery charge
    local max = self.battery_template.max
    -- Fraction
    return current / max
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

-- Update battery
BatteryExtension.update = function(self, dt, t)
    local perf = wc_perf.start("BatteryExtension.update", 2)
    -- Check battery template
    if self.battery_template then
        -- Battery interval
        if t > self.timer then
            -- Check if consumer is switched on
            if self.on and self.wielded then
                -- Drain battery
                self.current_charge = math_clamp(self.current_charge - self.battery_template.drain, 0, self.battery_template.max)
            else
                -- Charge battery
                self.current_charge = math_clamp(self.current_charge + self.battery_template.charge, 0, self.battery_template.max)
            end
            -- Set battery time
            self.timer = t + self.battery_template.interval
        end
    end
    wc_perf.stop(perf)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

BatteryExtension.on_wield_slot = function(self, slot)
    self.wielded = slot.name == mod.SLOT_SECONDARY
end

BatteryExtension.on_unwield_slot = function(self, slot)
    if slot.name == mod.SLOT_SECONDARY then self.wielded = false end
end

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

-- Get current battery charge
mod.get_battery_charge = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, mod.SYSTEM_BATTERY) then
        -- local battery_extension = script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY)
        return script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY):charge()
    end
    return 0
end

-- Get maximum battery charge
mod.get_battery_max = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, mod.SYSTEM_BATTERY) then
        -- local battery_extension = script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY)
        return script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY):max()
    end
	return 0
end

-- Get battery charge fraction
mod.get_battery_fraction = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, mod.SYSTEM_BATTERY) then
        -- local battery_extension = script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY)
        return script_unit_extension(self.player_unit, mod.SYSTEM_BATTERY):fraction()
    end
	return 0
end

return BatteryExtension
