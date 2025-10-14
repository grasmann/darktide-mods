local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local CLASS = CLASS
    local tostring = tostring
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.link_offer_id_to_gear_id = function(self, offer_id, gear_id)
    mod:print("offer id "..tostring(offer_id).." linked to gear id "..tostring(gear_id))
    pt.gear_id_to_offer_id[gear_id] = offer_id
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.StoreService, "get_credits_store", function(func, self, ignore_event_trigger, ...)
    local promise = func(self, ignore_event_trigger, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            mod:link_offer_id_to_gear_id(item_offer.offerId, item_offer.description.gear_id)
        end
    end)
    return promise
end)

mod:hook(CLASS.StoreService, "get_marks_store", function(func, self, ignore_event_trigger, ...)
    local promise = func(self, ignore_event_trigger, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            mod:link_offer_id_to_gear_id(item_offer.offerId, item_offer.description.gear_id)
        end
    end)
    return promise
end)

mod:hook(CLASS.StoreService, "get_marks_store_temporary", function(func, self, ignore_event_trigger, ...)
    local promise = func(self, ignore_event_trigger, ...)
    promise:next(function(store_catalogue)
        for _, item_offer in pairs(store_catalogue.offers) do
            mod:link_offer_id_to_gear_id(item_offer.offerId, item_offer.description.gear_id)
        end
    end)
    return promise
end)

mod:hook(CLASS.StoreService, "purchase_item", function(func, self, offer, ...)
    -- Save offer id
    mod.offer_id = offer.offerId
    mod:print("purchased offer id "..tostring(mod.offer_id))
    -- Original function
    return func(self, offer, ...)
end)
