local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local CLASS = CLASS
    local pairs = pairs
    local tostring = tostring
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┬┌─┐┌─┐┌┐┌┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ###############################################################################
-- ##### ││  │ ││││└─┐  ├─┘├─┤ │ │  ├─┤ ###############################################################################
-- ##### ┴└─┘└─┘┘└┘└─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ###############################################################################

-- Update all requests that contain gear id
local update_requests = function(weapon_icon_ui, request_id, item, prioritized)
    if item and request_id then
        for size_key, requests in pairs(weapon_icon_ui._requests_by_size) do
            for _, request in pairs(requests) do
                local combined_id = tostring(request_id).."_"..tostring(size_key)
                if request.id == request_id or request.id == combined_id then
                    weapon_icon_ui:_update_request(request, item, prioritized)
                end
            end
        end
    end
end

mod:hook(CLASS.WeaponIconUI, "weapon_icon_updated", function(func, self, item, prioritized, ...)
    local request_id = item.gear_id or item.name
    update_requests(self, request_id, item, prioritized)
end)

-- mod:hook(CLASS.UIManager, "load_item_icon", function(func, self, real_item, cb, render_context, dummy_profile, prioritize, unload_cb, ...)
--     local item_name = real_item.name
-- 	local gear_id = real_item.gear_id or item_name
--     mod.persistent_table(REFERENCE).icon_cache = mod.persistent_table(REFERENCE).icon_cache or {}
--     if mod.persistent_table(REFERENCE).icon_cache[gear_id] then

--     else
--         mod.persistent_table(REFERENCE).icon_cache[gear_id] = {
--             item = real_item,
--             callback = cb,
--             widget = nil,

--         }
--         func(self, real_item, cb, render_context, dummy_profile, prioritize, unload_cb, ...)

--     end
-- end)