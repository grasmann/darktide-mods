local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

    local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local tostring = tostring
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod._set_template = function(self, flashlights, template)
	for ii = 1, #flashlights do
		local flashlight = flashlights[ii]

		flashlight.component:set_template(flashlight.unit, template)
	end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.Flashlight, "init", function(func, self, context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p, ...)

    -- Original function
    func(self, context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p, ...)

    local pt = mod:pt()
    -- Get attached flashlight item string
    local flashlight_item_string = mod:fetch_attachment(item.attachments, "flashlight")
    -- Get attachment data
    local flashlight_data = mod.settings.attachment_data_by_item_string[flashlight_item_string]
    -- Check attachment data
    if flashlight_data then
        -- Get custom flashlight template name
        local custom_flashlight_template = flashlight_data.flashlight_template
        mod:print("custom template "..tostring(custom_flashlight_template))
        -- Get custom flashlight template
        local flashlight_template = mod.settings.flashlight_templates[custom_flashlight_template] or FlashlightTemplates[custom_flashlight_template]
        -- Check flashlight template
        if flashlight_template then
            -- Set light settings
            self._light_settings = flashlight_template.light
            self._flicker_settings = flashlight_template.flicker
            -- Set light template
            mod:_set_template(self._flashlights_1p, flashlight_template.light.first_person)
            mod:_set_template(self._flashlights_3p, flashlight_template.light.third_person)

            mod:print("set custom template "..tostring(custom_flashlight_template).." for original weapon "..tostring(item.weapon_template))
        end
    end

end)

mod:hook(CLASS.Flashlight, "update", function(func, self, unit, dt, t, ...)
    -- Original function
    func(self, unit, dt, t, ...)
    -- Update flashlight
    local flashlight_extension = script_unit_extension(unit, "flashlight_system")
    if flashlight_extension then
        local is_special_active = self._inventory_slot_component.special_active

        if is_special_active and not flashlight_extension.on then
            flashlight_extension:set_light(true)
        elseif not is_special_active and flashlight_extension.on then
            flashlight_extension:set_light(false)
        end
    end
end)
