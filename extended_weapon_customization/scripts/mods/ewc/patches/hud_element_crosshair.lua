local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"
local OVERRIDABLE_CROSSHAIRS = {
	assault = true,
	bfg = true,
	cross = true,
	flamer = true,
	projectile_drop = true,
	shotgun = true,
	spray_n_pray = true,
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.HudElementCrosshair, "_get_current_crosshair_type", function(func, self, crosshair_settings, ...)
    -- Original function
    local crosshair_type = func(self, crosshair_settings, ...)

    local parent = self._parent
    local player_extensions = parent:player_extensions()

	if player_extensions then
        local unit_data_extension = player_extensions.unit_data
        local inventory_component = unit_data_extension and unit_data_extension:read_component("inventory")
        local wielded_slot = inventory_component and inventory_component.wielded_slot
        if wielded_slot == SLOT_SECONDARY then
            local visual_loadout_extension = player_extensions.visual_loadout
            local item = visual_loadout_extension and visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
            if item and item.attachments then
                -- Get attachment item string
                local attachment_item_string = mod:fetch_attachment(item.attachments, "sight")
                -- Get attachment data
                local attachment_data = mod.settings.attachment_data_by_item_string[attachment_item_string]
                -- Check attachment data and crosshair type
                if attachment_data and attachment_data.crosshair_type then
                    -- Check if can be overwritten
                    if OVERRIDABLE_CROSSHAIRS[crosshair_type] then
                        -- Overwrite crosshair type
                        crosshair_type = attachment_data.crosshair_type
                    end
                end
                -- Get attachment item string
                local attachment_item_string = mod:fetch_attachment(item.attachments, "flashlight")
                -- Get attachment data
                local attachment_data = mod.settings.attachment_data_by_item_string[attachment_item_string]
                -- Check attachment data and crosshair type
                if attachment_data and attachment_data.crosshair_type then
                    -- Check if can be overwritten
                    if OVERRIDABLE_CROSSHAIRS[crosshair_type] then
                        -- Overwrite crosshair type
                        crosshair_type = attachment_data.crosshair_type
                    end
                end
            end
        end
    end
    return crosshair_type
end)
