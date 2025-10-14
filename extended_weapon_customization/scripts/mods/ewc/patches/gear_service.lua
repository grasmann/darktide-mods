local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local tostring = tostring
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.GearService, "on_gear_created", function(func, self, gear_id, gear, ...)
    local gear_settings = nil
    -- Get created id
    local create_id = mod.offer_id or gear_id
    mod:print("created gear for offer id "..tostring(create_id).." and gear id "..tostring(gear_id))
    -- Get temp settings
    if create_id and mod:gear_settings(create_id) then
        -- Get clone of temp settings
        gear_settings = mod:gear_settings(create_id)
        mod:print("gear settings for offer id "..tostring(create_id).." found")
    end
    -- Check attachments
    if gear_settings then
        -- Save gear settings
        mod:print("gear settings for offer id "..tostring(create_id).." saving")
        mod:gear_settings(gear_id, gear_settings, true)
    end
    -- Reset offer id
    mod.offer_id = nil
    -- Original function
    func(self, gear_id, gear, ...)
end)
