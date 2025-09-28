local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
-- local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
-- local ScriptCamera = require("scripts/foundation/utilities/script_camera")
    local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")
    local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local world = World
    local class = class
    local CLASS = CLASS
    local pairs = pairs
    local light = Light
    local string = string
    local vector3 = Vector3
    local managers = Managers
    local tostring = tostring
    local unit_alive = unit.alive
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local string_split = string.split
    local vector3_zero = vector3.zero
    local unit_get_data = unit.get_data
    local vector3_unbox = vector3_box.unbox
    local light_set_enabled = light.set_enabled
    local world_physics_world = world.physics_world
    local light_set_intensity = light.set_intensity
    local light_set_ies_profile = light.set_ies_profile
    local light_set_falloff_end = light.set_falloff_end
    local script_unit_extension = script_unit.extension
    local light_set_color_filter = light.set_color_filter
    local light_set_falloff_start = light.set_falloff_start
    local light_set_casts_shadows = light.set_casts_shadows
    local light_set_spot_angle_end = light.set_spot_angle_end
    local light_set_spot_reflector = light.set_spot_reflector
    local light_color_with_intensity = light.color_with_intensity
    local light_set_spot_angle_start = light.set_spot_angle_start
    local unit_set_vector3_for_materials = unit.set_vector3_for_materials
    local light_set_volumetric_intensity = light.set_volumetric_intensity
    local light_set_correlated_color_temperature = light.set_correlated_color_temperature
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"
local _item = "content/items/weapons/player"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local FlashlightExtension = class("FlashlightExtension")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

FlashlightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.unit = unit
    self.player = extension_init_data.player
    self.world = extension_init_context.world
    self.physics_world = world_physics_world(self.world)
    self.from_ui_profile_spawner = extension_init_data.from_ui_profile_spawner

    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    -- self.first_person_unit = self.first_person_extension:first_person_unit()
    self.fx_extension = script_unit_extension(unit, "fx_system")

    self.on = false

    self:fetch_flashlight()

    managers.event:register(self, "ewc_reloaded", "on_mod_reload")
    managers.event:register(self, "ewc_settings_changed", "on_settings_changed")

    self:on_settings_changed()

end

FlashlightExtension.delete = function(self)
    
    managers.event:unregister(self, "ewc_reloaded")
    managers.event:unregister(self, "ewc_settings_changed")

end

FlashlightExtension.on_settings_changed = function(self)
    self.flashlight_shadows = mod:get("mod_option_flashlight_shadows")
    self.interact_aim = mod:get("mod_toggle_flashlight_interact_aim")
    self.interact_double = mod:get("mod_toggle_flashlight_interact_double")
    self.modded_reminder = mod:get("mod_flashlight_input_reminder")
    self:init_light()
end

FlashlightExtension.input_settings = function(self)
    return self.interact_aim, self.interact_double
end

FlashlightExtension.is_active = function(self)
    return self.active
end

FlashlightExtension.is_modded = function(self)
    return not self.original_has_flashlight
end

FlashlightExtension.is_wielded = function(self)
    return self.wielded_slot == SLOT_SECONDARY
end

local unit_light = unit.light
local unit_num_lights = unit.num_lights

mod.find_in_units = function(self, attachment_units, target_attachment_slot)
    -- Check
    if attachment_units then
        -- Iterate through attachments
        for i = 1, #attachment_units do
            -- Get attachment unit
            local attachment_unit = attachment_units[i]
            -- Check attachment unit
            if attachment_unit and unit_alive(attachment_unit) then

                -- Get attachment slot
                local attachment_slot_string = unit_get_data(attachment_unit, "attachment_slot")
                -- Shorten to last part
                local attachment_slot_parts = string_split(attachment_slot_string, ".")
                local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]

                -- Check attachment slot and light in attachment unit
                if attachment_slot == target_attachment_slot then --and unit_num_lights(attachment_unit) > 0 then

                    return attachment_unit

                    -- -- Get flashlight name
                    -- local flashlight_name = unit_get_data(attachment_unit, "attachment_name")
                    -- -- local flashlight_unit = attachment_unit

                    -- -- Get attachment data
                    -- local flashlight_attachment_data = mod.settings.attachments[self.weapon.weapon_template][attachment_slot][flashlight_name]
                    -- -- Check attachment data
                    -- if flashlight_attachment_data then

                    --     local template_name = flashlight_attachment_data.flashlight_template or "default"
                    --     return attachment_unit, flashlight_name, template_name, flashlight_attachment_data

                    -- end

                end
            end
        end
    end
end

FlashlightExtension.find_in_units = function(self, attachment_units)
    -- Check
    if attachment_units then
        -- Iterate through attachments
        for i = 1, #attachment_units do
            -- Get attachment unit
            local attachment_unit = attachment_units[i]
            -- Check attachment unit
            if attachment_unit and unit_alive(attachment_unit) then

                -- Get attachment slot
                local attachment_slot_string = unit_get_data(attachment_unit, "attachment_slot")
                -- Shorten to last part
                local attachment_slot_parts = string_split(attachment_slot_string, ".")
                local attachment_slot = attachment_slot_parts and attachment_slot_parts[#attachment_slot_parts]

                -- Check attachment slot and light in attachment unit
                if attachment_slot == "flashlight" and unit_num_lights(attachment_unit) > 0 then

                    -- Get flashlight name
                    local flashlight_name = unit_get_data(attachment_unit, "attachment_name")
                    -- local flashlight_unit = attachment_unit

                    -- Get attachment data
                    local flashlight_attachment_data = mod.settings.attachments[self.weapon.weapon_template][attachment_slot][flashlight_name]
                    -- Check attachment data
                    if flashlight_attachment_data then

                        local template_name = flashlight_attachment_data.flashlight_template or "default"
                        return attachment_unit, flashlight_name, template_name, flashlight_attachment_data

                    end

                end
            end
        end
    end
    -- return mod:find_in_units(attachment_units, "flashlight")
end

FlashlightExtension.current_flashlight_unit = function(self)
    return self.first_person_extension:is_in_first_person_mode() and self.flashlight_unit_1p or self.flashlight_unit_3p
end

FlashlightExtension.current_flashlight = function(self)
    return self.first_person_extension:is_in_first_person_mode() and self.flashlight_1p or self.flashlight_3p
end

FlashlightExtension.fetch_flashlight = function(self, item)

    -- Unset flashlight data
    self.on = false
    self.active = nil
    self.flashlight_name = nil
    self.flashlight_unit_1p = nil
    self.flashlight_unit_3p = nil
    self.flashlight_1p = nil
    self.flashlight_3p = nil
    self.flashlight_template = nil
    self.original_has_flashlight = nil
    self.attachment_data = nil

    -- Get item
    self.weapon = item or self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    -- Check item and attachments
    if self.weapon and self.weapon.attachments then

        -- Get units for attachment slot
        -- Search for the flashlight unit
        local unit_1p, unit_3p, attachments_by_unit_1p, attachments_by_unit_3p = self.visual_loadout_extension:unit_and_attachments_from_slot(SLOT_SECONDARY)
        local attachments_1p = attachments_by_unit_1p and attachments_by_unit_1p[unit_1p]
        local attachments_3p = attachments_by_unit_3p and attachments_by_unit_3p[unit_3p]

        local flashlight_template_name, flashlight_attachment_data
        self.flashlight_unit_1p, self.flashlight_name, flashlight_template_name, flashlight_attachment_data = self:find_in_units(attachments_1p)
        self.flashlight_unit_3p = self:find_in_units(attachments_3p)

        mod:print("flashlight unit 1p: "..tostring(self.flashlight_unit_1p))
        mod:print("flashlight unit 3p: "..tostring(self.flashlight_unit_3p))
        mod:print("flashlight name: "..tostring(self.flashlight_name))
        mod:print("flashlight template name: "..tostring(flashlight_template_name))

        if flashlight_template_name then
            -- Get flashlight template
            self.flashlight_template = mod.settings.flashlight_templates[flashlight_template_name] or FlashlightTemplates[flashlight_template_name] or FlashlightTemplates.default

            -- Get lights
            self.flashlight_1p = unit_light(self.flashlight_unit_1p, 1)
            self.flashlight_3p = unit_light(self.flashlight_unit_3p, 1)

            -- Check lights
            if self.flashlight_1p then
                -- Set active
                self.active = true

                -- Check original item for a flashlight
                local original_item = master_items.get_item(self.weapon.name)
                local original_flashlight = mod:fetch_attachment(original_item.attachments, "flashlight")

                -- Set original has flashlight
                self.original_has_flashlight = original_flashlight and original_flashlight ~= "" and original_flashlight ~= _item_empty_trinket

                if not self.original_has_flashlight then
                    if self.modded_reminder then
                        mod:echo(mod:localize("mod_flashlight_input_reminder_text"))
                    end
                end

                -- Init light
                self:init_light(self.flashlight_1p)
                self:init_light(self.flashlight_3p)

                -- Set attachment data
                self.attachment_data = flashlight_attachment_data

                if self.from_ui_profile_spawner then
                    self:set_light(true)
                end

            end
        
        end

    end

end

FlashlightExtension.on_wield = function(self, wielded_slot)
    self.wielded_slot = wielded_slot
end

FlashlightExtension.on_update_item_visibility = function(self, wielded_slot)
    if self.attachment_data and self.attachment_data.on_update_item_visibility then
        self.attachment_data.on_update_item_visibility(self, wielded_slot)
    end
end

FlashlightExtension.current_flashlight_unit = function(self)
    if self.first_person_extension:is_in_first_person_mode() then
        return self.flashlight_unit_1p
    else
        return self.flashlight_unit_3p
    end
end

FlashlightExtension.update = function(self, dt, t)

    local first_person = self.first_person_extension:is_in_first_person_mode()
    local perspective_change = first_person ~= self.last_first_person
    self.last_first_person = first_person

    -- self:update_laser(dt, t)
    if self.on and self.attachment_data then
        if perspective_change and self.attachment_data.on_perspective_change then
            self.attachment_data.on_perspective_change(self)
        end
        if self.attachment_data.on_flashlight_update then
            self.attachment_data.on_flashlight_update(self, dt, t)
        end
    end
end

FlashlightExtension.on_mod_reload = function(self)
    self:fetch_flashlight()
end

FlashlightExtension.on_equip_weapon = function(self, item)
    -- self:destroy_laser()
    self:fetch_flashlight(item)
end

FlashlightExtension.set_light = function(self, value)

    self.on = value or not self.on

    if self.attachment_data then
        if self.on and self.attachment_data.on_flashlight_on then
            self.attachment_data.on_flashlight_on(self)
        elseif not self.on and self.attachment_data.on_flashlight_off then
            self.attachment_data.on_flashlight_off(self)
        end
    end

    if not mod:is_in_hub() then

        if self.flashlight_1p then self:_set_light(self.flashlight_unit_1p, self.flashlight_1p, self.on) end
        if self.flashlight_3p then self:_set_light(self.flashlight_unit_3p, self.flashlight_3p, self.on) end

    end
end

mod.set_light_color_for_unit = function(self, light, flashlight_unit)
    -- Set attachment light color
    local color = light_color_with_intensity(light)
    unit_set_vector3_for_materials(flashlight_unit, "light_color", color)
    -- Set light
    light_set_enabled(light, self.on)
end

mod.set_light = function(self, light, value)
    -- Set light
    light_set_enabled(light, value)
end

FlashlightExtension._set_light = function(self, flashlight_unit, flashlight, value)

    if flashlight and flashlight_unit and unit_alive(flashlight_unit) then

        -- -- Set attachment light color
        -- local color = self.on and light_color_with_intensity(flashlight) or vector3_zero()
        -- unit_set_vector3_for_materials(flashlight_unit, "light_color", color)
        -- -- Set light
        -- light_set_enabled(flashlight, self.on)
        
        -- Set attachment light color
        mod:set_light_color_for_unit(flashlight, flashlight_unit)

        -- Set light
        mod:set_light(flashlight, self.on)

        -- Play sound
        if self:is_modded() then
            if self.fx_extension and self.on then
                -- Switch on
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.unit, 1)
            elseif self.fx_extension then
                -- Switch off
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.unit, 1)
            end
        end

    end
end

FlashlightExtension.init_light = function(self, light)

    if not mod:is_in_hub() then

        if self.flashlight_1p then self:_init_light(self.flashlight_1p) end
        if self.flashlight_3p then self:_init_light(self.flashlight_3p) end
        
    end
end

mod.set_template_for_light = function(self, light, template)
    light_set_ies_profile(light, template.ies_profile)
    light_set_correlated_color_temperature(light, template.color_temperature)
    light_set_intensity(light, template.intensity)
    light_set_volumetric_intensity(light, template.volumetric_intensity)
    light_set_casts_shadows(light, self.flashlight_shadows)
    light_set_spot_angle_start(light, template.spot_angle.min)
    light_set_spot_angle_end(light, template.spot_angle.max)
    light_set_spot_reflector(light, template.spot_reflector)
    light_set_falloff_start(light, template.falloff.near)
    light_set_falloff_end(light, template.falloff.far)
    if template.color_filter then
        local color_filter = vector3_unbox(template.color_filter)
        light_set_color_filter(light, color_filter)
    end
end

FlashlightExtension._init_light = function(self, light)

    if self.flashlight_template and light then
        local template = self.flashlight_template.light.third_person
        if self.first_person_extension:is_in_first_person_mode() then
            template = self.flashlight_template.light.first_person
        end
        mod:set_template_for_light(light, template)
    --     local template = self.flashlight_template.light.first_person
    --     light_set_ies_profile(light, template.ies_profile)
    --     light_set_correlated_color_temperature(light, template.color_temperature)
    --     light_set_intensity(light, template.intensity)
    --     light_set_volumetric_intensity(light, template.volumetric_intensity)
    --     light_set_casts_shadows(light, self.flashlight_shadows)
    --     light_set_spot_angle_start(light, template.spot_angle.min)
    --     light_set_spot_angle_end(light, template.spot_angle.max)
    --     light_set_spot_reflector(light, template.spot_reflector)
    --     light_set_falloff_start(light, template.falloff.near)
    --     light_set_falloff_end(light, template.falloff.far)
    --     if template.color_filter then
    --         local color_filter = vector3_unbox(template.color_filter)
    --         light_set_color_filter(light, color_filter)
    --     end
    end

end
