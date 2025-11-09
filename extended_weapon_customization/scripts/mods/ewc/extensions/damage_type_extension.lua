local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local pairs = pairs
    local class = class
    local table = table
    local tostring = tostring
    local managers = Managers
    local math_lerp = math.lerp
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local script_unit_extension = script_unit.extension
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local DamageTypeExtension = class("DamageTypeExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local PROCESS_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}
local PRIORITY_SLOTS = {"magazine", "barrel", "muzzle", "head", "blade"}
local TEMP_WAS_MERGED = {}

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

DamageTypeExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.unit = unit
    self.player = extension_init_data.player
    -- Extensions
    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.movement_state_component = self.unit_data_extension:read_component("movement_state")
    self.weapon_action_component = self.unit_data_extension:read_component("weapon_action")
    self.block_component = self.unit_data_extension:read_component("block")
    -- Settings
    self.damage_types = {}
    self.merged_damage_types = {}
    self.wielded_slot = extension_init_data.wielded_slot
    -- Register Events
    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")
    managers.event:register(self, "ewc_cutscene", "on_cutscene")
    -- Set initial values
    self:on_settings_changed()
end

DamageTypeExtension.delete = function(self)
    -- Unregister Events
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")
    managers.event:unregister(self, "ewc_cutscene")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

DamageTypeExtension.on_settings_changed = function(self)
    -- self.shield_transparency = mod:get("mod_option_shield_transparency")
end

DamageTypeExtension.on_cutscene = function(self, cutscene_playing)
    if not cutscene_playing then
        -- Execute "on_wield" for attachments
        self:on_wield(self.wielded_slot)
    end
end

DamageTypeExtension.on_wield = function(self, wielded_slot)
    self.wielded_slot = wielded_slot
end

DamageTypeExtension.on_mod_reload = function(self)
    self:fetch_damage_types()
end

DamageTypeExtension.on_equip_weapon = function(self)
    self:fetch_damage_types()
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

DamageTypeExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

DamageTypeExtension.is_blocking = function(self)
    return self.block_component and self.block_component.is_blocking
end

DamageTypeExtension.is_in_first_person_mode = function(self)
    return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
end

DamageTypeExtension.update = function(self, dt, t)
end

DamageTypeExtension.damage_types = function(self, slot_name)
    return self.damage_types[slot_name]
end

DamageTypeExtension.damage_type = function(self, slot_name)
    return self.merged_damage_types[slot_name]
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

DamageTypeExtension.fetch_damage_types = function(self)

    table_clear(self.damage_types)
    table_clear(self.merged_damage_types)

    for _, slot_name in pairs(PROCESS_SLOTS) do

        self.damage_types[slot_name] = {}
        self.merged_damage_types[slot_name] = {}
        
        local weapon = self.visual_loadout_extension:item_from_slot(slot_name)

        if weapon and weapon.attachments then

            local attachment_slots = mod:fetch_attachment_slots(weapon.attachments)

            if attachment_slots then

                for attachment_slot, data in pairs(attachment_slots) do

                    local attachment_data = mod.settings.attachment_data_by_item_string[data.item]

                    if attachment_data and attachment_data.damage_type and mod.damage_types[attachment_data.damage_type] then

                        self.damage_types[slot_name][attachment_slot] = self.damage_types[slot_name][attachment_slot] or {}
                        self.damage_types[slot_name][attachment_slot] = mod.damage_types[attachment_data.damage_type]

                    end
                end

                table_clear(TEMP_WAS_MERGED)

                for i = 1, #PRIORITY_SLOTS do
                    local attachment_slot = PRIORITY_SLOTS[i]

                    if self.damage_types[slot_name][attachment_slot] then

                        self.merged_damage_types[slot_name] = table_merge_recursive_n(nil, self.merged_damage_types[slot_name], self.damage_types[slot_name][attachment_slot])

                        TEMP_WAS_MERGED[attachment_slot] = true

                    end

                end

                for attachment_slot, data in pairs(attachment_slots) do

                    if not TEMP_WAS_MERGED[attachment_slot] and self.damage_types[slot_name][attachment_slot] then

                        self.merged_damage_types[slot_name] = table_merge_recursive_n(nil, self.merged_damage_types[slot_name], self.damage_types[slot_name][attachment_slot])

                    end

                end

            end

        end

    end

end
