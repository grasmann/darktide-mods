local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local tostring = tostring

--#region Local functions
    local math = math
    local class = class
    local math_clamp = math.clamp
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local script_unit_has_extension = script_unit.has_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local SLOT_SECONDARY = "slot_secondary"
    local REFERENCE = "weapon_customization"
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
    self.initialized = true
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Recharge battery instantly
BatteryExtension.recharge_battery = function(self)
	self.current_charge = self.battery_template.max
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
    return (self.current_charge or self.battery_template.max) / self.battery_template.max
end

BatteryExtension.is_wielded = function(self)
    return self.wielded
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

-- Update battery
BatteryExtension.update = function(self, dt, t)
    -- Check battery template
    if self.battery_template then
        -- Battery interval
        if t > self.timer then
            -- Check if consumer is switched on
            if self.on and self:is_wielded() then
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
end

BatteryExtension.on_wield_slot = function(self, slot)
    self.wielded = slot.name == SLOT_SECONDARY
end

BatteryExtension.on_unwield_slot = function(self, slot)
    if slot.name == SLOT_SECONDARY then
        self.wielded = false
    end
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

-- Set battery enabled / disabled
BatteryExtension.set_enabled = function(self, value)
    self.on = value
end

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

-- Get current battery charge
mod.get_battery_charge = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(self.player_unit, "battery_system")
        return battery_extension and battery_extension:charge()
    end
    return 0
end

-- Get maximum battery charge
mod.get_battery_max = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(self.player_unit, "battery_system")
        return battery_extension and battery_extension:max()
    end
	return 0
end

-- Get battery charge fraction
mod.get_battery_fraction = function(self)
    if self.player_unit and script_unit_has_extension(self.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(self.player_unit, "battery_system")
        return battery_extension and battery_extension:fraction()
    end
	return 0
end

return BatteryExtension
