local mod = get_mod("extended_weapon_customization")

local table = table
local table_contains = table.contains

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.save_lua = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/save")

local REFERENCE = "extended_weapon_customization"

mod:persistent_table(REFERENCE, {
    gear_files = mod:get("gear_files") or {},
    gear_settings = {},
    cached_items = {},
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

mod.gear_id = function(self, item)
    -- local item = item.__master_item or item
    return item and item.gear_id or item.__gear_id
end

mod.gear_settings = function(self, gear_id, settings, file)
    local pt = self:pt()
    if settings and gear_id then
        pt.gear_settings[gear_id] = pt.gear_settings[gear_id] or {}
        local data = pt.gear_settings[gear_id]

        if file then
            mod.save_lua:save_entry(gear_id, data)
        end

        data = settings
    elseif gear_id then
        local data = pt.gear_settings[gear_id]

        if (not data or file) and table_contains(pt.gear_files, gear_id..".lua") then
            pt.gear_settings[gear_id] = mod.save_lua:load_entry(gear_id)
            data = pt.gear_settings[gear_id]
        end

        return data
    end
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/master_items")
