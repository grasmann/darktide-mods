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
    local managers = Managers
    local math_lerp = math.lerp
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local script_unit_extension = script_unit.extension
--#endregion

local string = string
local tostring = tostring
local string_split = string.split
local unit_get_data = unit.get_data
local unit_set_scalar_for_materials = unit.set_scalar_for_materials
local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local ShieldTransparencyExtension = class("ShieldTransparencyExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local SLOT_PRIMARY = "slot_primary"
local SLOT_SECONDARY = "slot_secondary"
local PROCESS_SLOTS = {SLOT_PRIMARY, SLOT_SECONDARY}

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

ShieldTransparencyExtension.init = function(self, extension_init_context, unit, extension_init_data)
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
    self.shield_units = {}
    self.wielded_slot = extension_init_data.wielded_slot
    self.transparency = 0
    -- Register Events
    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")
    managers.event:register(self, "ewc_cutscene", "on_cutscene")
    -- Set initial values
    self:on_settings_changed()
end

ShieldTransparencyExtension.delete = function(self)
    -- Unregister Events
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")
    managers.event:unregister(self, "ewc_cutscene")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

ShieldTransparencyExtension.on_settings_changed = function(self)
    self.shield_transparency = mod:get("mod_option_shield_transparency")
end

ShieldTransparencyExtension.on_cutscene = function(self, cutscene_playing)
    if not cutscene_playing then
        -- Execute "on_wield" for attachments
        self:on_wield(self.wielded_slot)
    end
end

ShieldTransparencyExtension.on_wield = function(self, wielded_slot)
    self.wielded_slot = wielded_slot
end

ShieldTransparencyExtension.on_mod_reload = function(self)
    self:fetch_shield_units()
end

ShieldTransparencyExtension.on_equip_weapon = function(self, item)
    self:fetch_shield_units()
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ShieldTransparencyExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

ShieldTransparencyExtension.is_blocking = function(self)
    return self.block_component and self.block_component.is_blocking
end

ShieldTransparencyExtension.is_in_first_person_mode = function(self)
    return self.first_person_extension and self.first_person_extension:is_in_first_person_mode()
end

ShieldTransparencyExtension.update = function(self, dt, t)

    if (self:is_aiming() or self:is_blocking()) and self:is_in_first_person_mode() then
        self.transparency = math_lerp(self.transparency, self.shield_transparency, dt * 10)
    else
        self.transparency = math_lerp(self.transparency, 0, dt * 10)
    end

    for slot_name, shield_unit in pairs(self.shield_units) do

        if shield_unit and unit_alive(shield_unit) then
            if slot_name == self.wielded_slot then
                unit_set_scalar_for_materials(shield_unit, "inv_jitter_alpha", self.transparency, true)
            else
                unit_set_scalar_for_materials(shield_unit, "inv_jitter_alpha", 0, true)
            end
        end

    end

end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

ShieldTransparencyExtension.fetch_shield_units = function(self)

    table_clear(self.shield_units)

    for _, slot_name in pairs(PROCESS_SLOTS) do
        
        local weapon = self.visual_loadout_extension:item_from_slot(slot_name)
        if weapon and weapon.attachments then
            local shield_name = mod:fetch_attachment(weapon.attachments, "left")
            mod:print("shield name: "..tostring(shield_name))

            local unit_1p, unit_3p, attachments_by_unit_1p, attachments_by_unit_3p = self.visual_loadout_extension:unit_and_attachments_from_slot(slot_name)
            local attachments_1p = attachments_by_unit_1p and attachments_by_unit_1p[unit_1p]
            if attachments_1p then
                for i = 1, #attachments_1p do
                    local attachment_unit = attachments_1p[i]
                    if attachment_unit and unit_alive(attachment_unit) then
                        local attachment_slot_string = unit_get_data(attachment_unit, "attachment_slot")
                        local attachment_slot_parts = string_split(attachment_slot_string, ".")
                        local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]

                        if attachment_slot == "left" then
                            self.shield_units[slot_name] = attachment_unit
                            unit_set_shader_pass_flag_for_meshes(attachment_unit, "one_bit_alpha", true, true)
                            mod:print("shield unit: "..tostring(attachment_unit))
                        end
                    end
                end
            end
        end

    end

end
