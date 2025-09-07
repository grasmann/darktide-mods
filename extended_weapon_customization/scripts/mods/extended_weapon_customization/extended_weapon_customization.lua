local mod = get_mod("extended_weapon_customization")

local table = table
local managers = Managers
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
    gear_id_relays = {},
})

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

-- mod.gear_id = function(self, item, fake_gear_id)
--     -- local item = item.__master_item or item
--     if not fake_gear_id then
--         return (item and item.__original_gear_id) or
--             (item and item.__is_ui_item_preview and item.__data and self:gear_id(item.__data)) or
--             (item and item.__gear_id or item.gear_id) or
--             (item.__master_item and (item.__master_item.__gear_id or item.__master_item.gear_id))
--     end
--     return item and item.__gear_id or item.gear_id
-- end

mod.gear_id = function(self, item, fake_gear_id)
    -- local item = item.__master_item or item
    local gear_id
    if not fake_gear_id then
        gear_id = (item and item.__original_gear_id) or
            (item and item.__is_ui_item_preview and item.__data and self:gear_id(item.__data)) or
            (item and item.__gear_id or item.gear_id) or
            (item.__master_item and (item.__master_item.__gear_id or item.__master_item.gear_id))
    else
        gear_id = item and item.__gear_id or item.gear_id
    end
    local pt = self:pt()
    gear_id = pt.gear_id_relays[gear_id] or gear_id
    return gear_id
end

mod.gear_id_relay = function(self, gear_id, real_gear_id)
    local pt = self:pt()
    pt.gear_id_relays[gear_id] = real_gear_id
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

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded = function()
    -- managers.event:register(mod, "grasmann_register_gear_id_relay", "gear_id_relay")
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("extended_weapon_customization_settings_changed")
end

mod.on_unload = function(exit_game)
    -- managers.event:unregister("grasmann_register_gear_id_relay")
end

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/patches/master_items")
