local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.EndPlayerView, "_get_item", function(func, self, card_reward, ...)
    local item, item_group, rarity, item_level = func(self, card_reward, ...)
    if item and card_reward.gear_id and mod:get("mod_option_randomize_reward") then
        -- Save gear id
        item.gear_id = card_reward.gear_id
        -- Randomize item
        item = mod:master_items_randomize_store(item, card_reward.gear_id)
        -- Get attachments
        local random_attachments = mod:gear_settings(card_reward.gear_id)

        mod:sweep_gear_id(card_reward.gear_id)
        -- Save to file
        mod:gear_settings(card_reward.gear_id, random_attachments, true)
    end
    return item, item_group, rarity, item_level
end)
