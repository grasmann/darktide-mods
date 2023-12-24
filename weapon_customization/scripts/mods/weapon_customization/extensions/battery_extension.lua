local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local class = class
    local math = math
    local math_clamp = math.clamp
    local script_unit = ScriptUnit
    local script_unit_has_extension = script_unit.has_extension
    local script_unit_extension = script_unit.extension
    local wc_perf = wc_perf
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌┐ ┌─┐┌┬┐┌┬┐┌─┐┬─┐┬ ┬  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ############################################################
-- ##### ├┴┐├─┤ │  │ ├┤ ├┬┘└┬┘  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ############################################################
-- ##### └─┘┴ ┴ ┴  ┴ └─┘┴└─ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ############################################################

local BatteryExtension = class("BatteryExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

-- Initialize
BatteryExtension.init = function(self, extension_init_context, unit, extension_init_data)
    BatteryExtension.super.init(self, extension_init_context, unit, extension_init_data)
    
    self.consumer_template = extension_init_data.consumer_template
    self.consumer = extension_init_data.consumer
    self.battery_template = extension_init_data.battery_template
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
    -- Current battery charge or max
    local current = self.current_charge or self.battery_template.max
    -- Max battery charge
    local max = self.battery_template.max
    -- Fraction
    return current / max
end

BatteryExtension.is_wielded = function(self)
    return self.wielded
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
        self.timer = self.timer or 0
        if t > self.timer then
            -- Check if consumer is switched on
            if self.on and self:is_wielded() then
                -- Drain battery
                local drain = self.battery_template.drain
                self.current_charge = math_clamp(self.current_charge - drain, 0, self.battery_template.max)
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
    if mod.player_unit and script_unit_has_extension(mod.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(mod.player_unit, "battery_system")
        return battery_extension and battery_extension:charge()
    end
    return 0
end

-- Get maximum battery charge
mod.get_battery_max = function(self)
    if mod.player_unit and script_unit_has_extension(mod.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(mod.player_unit, "battery_system")
        return battery_extension and battery_extension:max()
    end
	return 0
end

-- Get battery charge fraction
mod.get_battery_fraction = function(self)
    if mod.player_unit and script_unit_has_extension(mod.player_unit, "battery_system") then
        local battery_extension = script_unit_extension(mod.player_unit, "battery_system")
        return battery_extension and battery_extension:fraction()
    end
	return 0
end

return BatteryExtension
