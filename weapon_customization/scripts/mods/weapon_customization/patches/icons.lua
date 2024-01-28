local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local CLASS = CLASS
local pairs = pairs
local tostring = tostring

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

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