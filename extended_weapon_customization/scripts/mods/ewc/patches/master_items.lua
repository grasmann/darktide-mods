--#region Old
    -- local mod = get_mod("extended_weapon_customization")

    -- -- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
    -- -- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
    -- -- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
    -- -- #region Performance
    --     local log = Log
    --     local math = math
    --     local type = type
    --     local CLASS = CLASS
    --     local cjson = cjson
    --     local table = table
    --     local pairs = pairs
    --     local string = string
    --     local rawget = rawget
    --     local rawset = rawset
    --     local managers = Managers
    --     local tostring = tostring
    --     local math_uuid = math.uuid
    --     local log_error = log.error
    --     -- local string_find = string.find
    --     local table_clear = table.clear
    --     -- local string_gsub = string.gsub
    --     local json_encode = json_encode
    --     local table_clone = table.clone
    --     local log_warning = log.warning
    --     -- local string_split = string.split
    --     local cjson_encode = cjson.encode
    --     local setmetatable = setmetatable
    --     local string_format = string.format
    --     local table_clone_instance = table.clone_instance
    -- --#endregion

    -- -- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
    -- -- #####  ││├─┤ │ ├─┤ #################################################################################################
    -- -- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

    -- local WEAPON_RANGED = "WEAPON_RANGED"
    -- local WEAPON_MELEE = "WEAPON_MELEE"
    -- local VALID_ITEM_TYPES = {WEAPON_MELEE, WEAPON_RANGED}

    -- -- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
    -- -- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
    -- -- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

    -- local master_items = mod:original_require("scripts/backend/master_items")

    -- local pt = mod:pt()

    -- local debug_master_items = false
    -- local debug_modified_master_items = false

    -- if pt.game_initialized then
    --     if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
    -- end

    -- if not pt.master_item_listener then
    --     pt.master_item_listener = master_items.add_listener(function()
    --         pt.master_items_loaded = true
    --         mod:print("master items loaded")
    --         if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
    --         mod:try_kitbash_load()
    --         if debug_modified_master_items then mod:dtf(master_items.get_cached(), "modified_master_items", 20) end
    --         mod:find_missing_entries()
    --     end)
    -- end

    -- -- ##### ┌─┐┬┌┐┌┌┬┐  ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┐┌┌┬┐┬─┐┬┌─┐┌─┐ ##############################################
    -- -- ##### ├┤ ││││ ││  │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ├┤ │││ │ ├┬┘│├┤ └─┐ ##############################################
    -- -- ##### └  ┴┘└┘─┴┘  ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  └─┘┘└┘ ┴ ┴└─┴└─┘└─┘ ##############################################

    -- local _temp_names = {}

    -- mod.find_missing_entries = function(self)
    --     if self:get("debug_mode") then
    --         self:find_missing_items()
    --         self:find_missing_attachments()
    --     end
    -- end

    -- mod.find_missing_items = function(self)

    --     local items = self:find_master_item_entries({
    --         item_type = "WEAPON_MELEE|WEAPON_RANGED",
    --         item_list_faction = "Player",
    --         weapon_template = "!_nil|",
    --     })

    --     table_clear(_temp_names)

    --     for name, item in pairs(items) do

    --         local template_ok = item.weapon_template and item.weapon_template ~= ""

    --         local filter = {
    --             "bot",
    --             "npc",
    --         }

    --         local filter_ok = true

    --         for _, filter_name in pairs(filter) do
    --             -- if string_find(item.weapon_template, filter_name) then
    --             if self:cached_find(item.weapon_template, filter_name) then
    --                 filter_ok = false
    --                 break
    --             end
    --         end

    --         if template_ok and not self.settings.attachments[item.weapon_template] and filter_ok and not item.is_kitbash then

    --             _temp_names[#_temp_names+1] = item.weapon_template

    --         end

    --     end

    --     if #_temp_names > 0 then
    --         self:print("################## unsupported items ##################")
    --         for _, name in pairs(_temp_names) do
    --             self:print(name)
    --         end
    --         self:print("####################################################")
    --     end

    -- end

    -- mod.find_missing_attachments = function(self)

    --     local items = self:find_master_item_entries({
    --         attach_node = "!_nil|j_rightweaponattach|j_head|j_hips|j_spine1|j_spine2|root_point|1|j_leftleg|j_rightleg|j_backpackattach|j_backpackoffset|ap_anim_01|ap_anim_02|ap_anim_03|ap_anim_04|ap_anim_05|ap_anim_06",
    --         attachments = "!_nil",
    --         item_type = "!WEAPON_TRINKET",
    --         item_list_faction = "Player",
    --     })

    --     table_clear(_temp_names)

    --     for name, item in pairs(items) do

    --         -- local parts = string_split(name, "/")
    --         local parts = self:cached_split(name, "/")
    --         local item_name = parts[#parts]

    --         local attachment_found = false

    --         for weapon_template, weapon_attachments in pairs(self.settings.attachments) do
    --             for attachment_slot, attachments in pairs(weapon_attachments) do
    --                 for attachment_name, attachment_data in pairs(attachments) do
    --                     if name == attachment_data.replacement_path then
    --                         attachment_found = true
    --                         break
    --                     end
    --                 end
    --                 if attachment_found then break end
    --             end
    --             if attachment_found then break end
    --         end

    --         local filter = {
    --             "bot",
    --             "npc",
    --             "shell",
    --             "bullet",
    --             "trail",
    --             "casing",
    --         }

    --         local filter_ok = true

    --         for _, filter_name in pairs(filter) do
    --             -- if string_find(item_name, filter_name) then
    --             if self:cached_find(item_name, filter_name) then
    --                 filter_ok = false
    --                 break
    --             end
    --         end

    --         local search = nil --"rippergun_rifle"
    --         local search_ok = search and false or true

    --         if search then
    --             -- search_ok = string_find(item_name, search)
    --             search_ok = self:cached_find(item_name, search)
    --         end

    --         if search_ok and filter_ok and not attachment_found and not item.is_kitbash then

    --             _temp_names[#_temp_names+1] = item_name

    --         end

    --     end

    --     -- local skip_attachments = {
    --     --     "stub_pistol_receiver_01",
    --     --     "stub_pistol_receiver_02",
    --     --     "stub_pistol_receiver_ml01_ver01",
    --     --     "stub_pistol_receiver_ml01_ver02",
    --     --     "stub_pistol_receiver_deluxe_ver01",
    --     --     "stub_pistol_receiver_deluxe_ver02",
    --     --     "stub_pistol_magazine_01",
    --     --     "stub_pistol_addon_01",
    --     --     "stub_pistol_addon_02",
    --     --     "stub_pistol_addon_deluxe",
    --     --     "stub_pistol_addon_ml01_ver01",
    --     --     "stub_pistol_addon_ml01_ver02",
    --     --     "stub_pistol_grip_01",
    --     --     "stub_pistol_grip_ml01",
    --     --     "stub_pistol_grip_deluxe",
    --     -- }

    --     if #_temp_names > 0 then
    --         self:print("################## unsupported attachments ##################")
    --         for _, name in pairs(_temp_names) do
    --             -- if not self:cached_table_contains(skip_attachments, name) then
    --             self:print(name)
    --             -- end
    --         end
    --         self:print("##########################################################")
    --     end

    -- end

    -- local _temp_items = {}

    -- mod.find_master_item_entries = function(self, identifications)
    --     local master_items = master_items.get_cached()
    --     if master_items then

    --         table_clear(_temp_items)

    --         for item_name, item in pairs(master_items) do

    --             local identifications_valid = true

    --             for name, value in pairs(identifications) do

    --                 local identification_valid = true

    --                 -- local negative = string_find(name, "!")
    --                 local negative = self:cached_find(name, "!")
    --                 -- local name_str = string_gsub(name, "!", "")
    --                 local name_str = mod:cached_gsub(name, "!", "")
    --                 local table_value = item[name_str]

    --                 if type(value) == "table" and table_value and type(table_value) == "table" then

    --                     identification_valid = cjson_encode(table_value) == cjson_encode(value)

    --                 elseif type(value) == "string" then

    --                     -- local negative = string_find(value, "!")
    --                     local negative = self:cached_find(value, "!")
    --                     if not negative then
    --                         identification_valid = false
    --                     end
    --                     -- local parts_str = string_gsub(value, "!", "")
    --                     local parts_str = mod:cached_gsub(value, "!", "")
    --                     -- local parts = string_split(parts_str, "|")
    --                     local parts = self:cached_split(parts_str, "|")

    --                     for _, part in pairs(parts) do

    --                         if not negative then
    --                             if part ~= "_nil" and table_value == part then
    --                                 identification_valid = true
    --                                 break
    --                             elseif part == "_nil" and table_value == nil then
    --                                 identification_valid = true
    --                                 break
    --                             end
    --                         else
    --                             if part ~= "_nil" and table_value == part then
    --                                 identification_valid = false
    --                                 break
    --                             elseif part == "_nil" and table_value == nil then
    --                                 identification_valid = false
    --                                 break
    --                             end
    --                         end

    --                     end

    --                 end

    --                 identifications_valid = identification_valid
    --                 if not identifications_valid then
    --                     break
    --                 end

    --             end

    --             if identifications_valid then
    --                 _temp_items[item_name] = item
    --             end

    --         end

    --         return _temp_items

    --     end
    -- end

    -- mod.master_items_randomize_store = function(self, item, offer_id)
    --     return mod:handle_store_item(item, offer_id)
    -- end

    -- mod.master_items_randomize_reward = function(self, item, gear_id)
    --     return mod:handle_reward_item(item, gear_id)
    -- end

    -- -- Get cached player gear list from data service
    -- mod.player_gear_list = function(self)
    --     -- Get data service
    --     local data_service = managers and managers.data_service
    --     -- Get gear service
    --     local gear_data = data_service and data_service.gear
    --     -- Return gear list
    --     return gear_data and gear_data._cached_gear_list
    -- end

    -- mod.player_owns_item = function(self, item)
    --     local gear_id = mod:gear_id(item)
    --     local gear_list = self:player_gear_list()
    --     return gear_list and gear_list[gear_id]
    -- end

    -- -- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
    -- -- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
    -- -- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

    -- mod:hook_require("scripts/backend/master_items", function(instance)

    --     instance.overwrite_attachment = function(attachments, target_slot, replacement_path)
    --         mod:overwrite_attachment(attachments, target_slot, replacement_path)
    --     end

    --     mod:master_item_community_patch()

    --     if not mod.micp_missing then

    --         instance.item_plus_overrides = function(gear, gear_id, is_preview_item, ...)
    --             local new_gear_id = math_uuid()
    --             local item_instance = {
    --                 __gear = gear,
    --                 __gear_id = is_preview_item and new_gear_id or gear_id,
    --                 __original_gear_id = is_preview_item and gear_id,
    --                 __is_preview_item = is_preview_item and true or false
    --             }
    --             setmetatable(item_instance, {
    --                 __index = function (t, field_name)
    --                     local master_ver = rawget(item_instance, "__master_ver")
    --                     if master_ver ~= instance.get_cached_version() then
    --                         local success = instance.update_master_data(item_instance)
    --                         if not success then
    --                             log_error("MasterItems", "[_item_plus_overrides][1] could not update master data with %s", gear.masterDataInstance.id)
    --                             return nil
    --                         end
    --                     end
    --                     if field_name == "gear_id" then
    --                         return rawget(item_instance, "__gear_id")
    --                     end
    --                     if field_name == "gear" then
    --                         return rawget(item_instance, "__gear")
    --                     end
    --                     local master_item = rawget(item_instance, "__master_item")
    --                     if not master_item then
    --                         log_warning("MasterItemCache", string_format("No master data for item with id %s", gear.masterDataInstance.id))
    --                         return nil
    --                     end
    --                     local field_value = master_item[field_name]
    --                     if field_name == "rarity" and field_value == -1 then
    --                         return nil
    --                     end
    --                     return field_value
    --                 end,
    --                 __newindex = function (t, field_name, value)
    --                     rawset(t, field_name, value)
    --                 end,
    --                 __tostring = function (t)
    --                     local master_item = rawget(item_instance, "__master_item")
    --                     return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
    --                 end
    --             })
    --             local success = instance.update_master_data(item_instance)
    --             if not success then
    --                 log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s", gear.masterDataInstance.id)
    --                 return nil
    --             end
    --             return item_instance
    --         end

    --         instance.store_item_plus_overrides = function(data)
    --             local item_instance = {
    --                 __data = data,
    --                 __gear = {
    --                     masterDataInstance = {
    --                         id = data.id,
    --                         overrides = data.overrides,
    --                     },
    --                 },
    --                 __gear_id = data.gear_id or data.gearId,
    --             }
    --             setmetatable(item_instance, {
    --                 __index = function (t, field_name)
    --                     local master_ver = rawget(item_instance, "__master_ver")
    --                     if master_ver ~= instance.get_cached_version() then
    --                         local success = instance.update_master_data(item_instance)
    --                         if not success then
    --                             log_error("MasterItems", "[_store_item_plus_overrides][1] could not update master data with %s; %s", data.id, data.gear_id)
    --                             return nil
    --                         end
    --                     end
    --                     if field_name == "gear_id" then
    --                         return rawget(item_instance, "__gear_id")
    --                     end
    --                     if field_name == "gear" then
    --                         return rawget(item_instance, "__gear")
    --                     end
    --                     local master_item = rawget(item_instance, "__master_item")
    --                     if not master_item then
    --                         log_warning("MasterItemCache", string_format("No master data for item with id %s", item_instance.__asset_id))

    --                         return nil
    --                     end
    --                     local field_value = master_item[field_name]
    --                     if field_name == "rarity" and field_value == -1 then
    --                         return nil
    --                     end
    --                     return field_value
    --                 end,
    --                 __newindex = function (t, field_name, value)
    --                     rawset(t, field_name, value)
    --                 end,
    --                 __tostring = function (t)
    --                     local master_item = rawget(item_instance, "__master_item")

    --                     return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
    --                 end,
    --             })
    --             local success = instance.update_master_data(item_instance)
    --             if not success then
    --                 log_error("MasterItems", "[_store_item_plus_overrides][2] could not update master data with %s; %s", data.id, data.gear_id)
    --                 return nil
    --             end
    --             return item_instance
    --         end

    --         instance.get_ui_item_instance = function(item)
    --             local gear_override = item.gear and item.gear.masterDataInstance and item.gear.masterDataInstance.overrides
    --             local overrides = item.overrides or gear_override
    --             if overrides then
    --                 overrides = table_clone_instance(overrides)
    --             else
    --                 overrides = {}
    --             end
    --             if item.slot_weapon_skin then
    --                 overrides.slot_weapon_skin = type(item.slot_weapon_skin) == "table" and item.slot_weapon_skin.name or item.slot_weapon_skin
    --             end
    --             local item_instance = {
    --                 __is_ui_item_preview = true,
    --                 __data = item,
    --                 __gear = {
    --                     masterDataInstance = {
    --                         id = item.name,
    --                         overrides = overrides,
    --                     },
    --                 },
    --                 __gear_id = item.gear_id or math_uuid(),
    --             }
    --             setmetatable(item_instance, {
    --                 __index = function (t, field_name)
    --                     local master_ver = rawget(item_instance, "__master_ver")
    --                     if master_ver ~= instance.get_cached_version() then
    --                         local success = instance.update_master_data(item_instance)
    --                         if not success then
    --                             log_error("MasterItems", "[_store_item_plus_overrides][1] could not update master data with %s; %s", item.name, item.gear_id)
    --                             return nil
    --                         end
    --                     end
    --                     if field_name == "gear_id" then
    --                         return rawget(item_instance, "__gear_id")
    --                     end
    --                     if field_name == "gear" then
    --                         return rawget(item_instance, "__gear")
    --                     end
    --                     local master_item = rawget(item_instance, "__master_item")
    --                     if not master_item then
    --                         log_warning("MasterItemCache", string_format("UI - No master data for item with id %s", item.name))
    --                         return nil
    --                     end
    --                     local field_value = master_item[field_name]
    --                     if field_name == "rarity" and field_value == -1 then
    --                         return nil
    --                     end
    --                     return field_value
    --                 end,
    --                 __newindex = function (t, field_name, value)
    --                     rawset(t, field_name, value)
    --                 end,
    --                 __tostring = function (t)
    --                     local master_item = rawget(item_instance, "__master_item")
    --                     return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name), tostring(rawget(item_instance, "__gear_id")))
    --                 end,
    --             })
    --             local success = instance.update_master_data(item_instance)
    --             if not success then
    --                 log_error("MasterItems", "UI - [_store_item_plus_overrides][2] could not update master data with %s; %s", item.name, item.gear_id)
    --                 return nil
    --             end
    --             return item_instance
    --         end

    --         mod:hook(instance, "get_item_instance", function(func, gear, gear_id, ...)
    --             local item_instance = func(gear, gear_id, ...)
    --             return mod:gear_settings(gear_id) and (mod:husk_item(gear_id) or mod:mod_item(gear_id, item_instance)) or item_instance
    --         end)

    --         mod:hook(instance, "create_preview_item_instance", function(func, item, ...)
    --             -- Check item
    --             if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) then
    --                 -- Modify item
    --                 mod:modify_item(item)
    --                 -- Fixes
    --                 mod:apply_attachment_fixes(item)
    --             end

    --             -- ##### Original function ####################################################################################
    --             local item_instance
    --             local gear = table.clone_instance(item.__gear)
    --             local gear_id = item.__gear_id

    --             if not gear then
    --                 log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
    --                 return nil
    --             else
    --                 -- local allow_modifications = true
    --                 item_instance = instance.item_plus_overrides(gear, gear_id, true)
    --             end
    --             -- ##### Original function ####################################################################################

    --             -- Relay gear id
    --             mod:gear_id_relay(item_instance.gear_id, item.gear_id)
    --             -- Return
    --             return item_instance
    --         end)

    --         mod:hook(instance, "get_store_item_instance", function(func, description, ...)
    --             local item_instance = func(description, ...)
    --             local gear_id = mod:gear_id(item_instance)
    --             local offer_id = pt.gear_id_to_offer_id[gear_id]
    --             -- Return randomized
    --             return mod:master_items_randomize_store(item_instance, offer_id)
    --         end)

    --     end

    -- end)
--#endregion

local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
local log = Log
local math = math
local type = type
local CLASS = CLASS
local cjson = cjson
local table = table
local pairs = pairs
local string = string
local rawget = rawget
local rawset = rawset
local managers = Managers
local tostring = tostring
local math_uuid = math.uuid
local log_error = log.error
-- local string_find = string.find
local table_clear = table.clear
-- local string_gsub = string.gsub
local json_encode = json_encode
local table_clone = table.clone
local log_warning = log.warning
-- local string_split = string.split
local cjson_encode = cjson.encode
local setmetatable = setmetatable
local string_format = string.format
local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local VALID_ITEM_TYPES = { WEAPON_MELEE, WEAPON_RANGED }

-- Hoisted out of the hot loops below so they aren't reallocated on every item/iteration
local MISSING_ITEMS_FILTER = { "bot", "npc" }
local MISSING_ATTACHMENTS_FILTER = { "bot", "npc", "shell", "bullet", "trail", "casing" }

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

local pt = mod:pt()

local debug_master_items = false
local debug_modified_master_items = false

if pt.game_initialized then
    if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
end

if not pt.master_item_listener then
    pt.master_item_listener = master_items.add_listener(function()
        pt.master_items_loaded = true
        mod:print("master items loaded")
        if debug_master_items then mod:dtf(master_items.get_cached(), "master_items", 20) end
        mod:try_kitbash_load()
        if debug_modified_master_items then mod:dtf(master_items.get_cached(), "modified_master_items", 20) end
        mod:find_missing_entries()
    end)
end

-- ##### ┌─┐┬┌┐┌┌┬┐  ┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐  ┬┌┬┐┌─┐┌┬┐  ┌─┐┌┐┌┌┬┐┬─┐┬┌─┐┌─┐ ##############################################
-- ##### ├┤ ││││ ││  │││├─┤└─┐ │ ├┤ ├┬┘  │ │ ├┤ │││  ├┤ │││ │ ├┬┘│├┤ └─┐ ##############################################
-- ##### └  ┴┘└┘─┴┘  ┴ ┴┴ ┴└─┘ ┴ └─┘┴└─  ┴ ┴ └─┘┴ ┴  └─┘┘└┘ ┴ ┴└─┴└─┘└─┘ ##############################################

local _temp_names = {}

mod.find_missing_entries = function(self)
    if self:get("debug_mode") then
        self:find_missing_items()
        self:find_missing_attachments()
    end
end

mod.find_missing_items = function(self)
    local items = self:find_master_item_entries({
        item_type = "WEAPON_MELEE|WEAPON_RANGED",
        item_list_faction = "Player",
        weapon_template = "!_nil|",
    })

    table_clear(_temp_names)

    for name, item in pairs(items) do
        local template_ok = item.weapon_template and item.weapon_template ~= ""

        local filter_ok = true

        for i = 1, #MISSING_ITEMS_FILTER do
            -- if string_find(item.weapon_template, filter_name) then
            if self:cached_find(item.weapon_template, MISSING_ITEMS_FILTER[i]) then
                filter_ok = false
                break
            end
        end

        if template_ok and not self.settings.attachments[item.weapon_template] and filter_ok and not item.is_kitbash then
            _temp_names[#_temp_names + 1] = item.weapon_template
        end
    end

    if #_temp_names > 0 then
        self:print("################## unsupported items ##################")
        for _, name in pairs(_temp_names) do
            self:print(name)
        end
        self:print("####################################################")
    end
end

mod.find_missing_attachments = function(self)
    local items = self:find_master_item_entries({
        attach_node =
        "!_nil|j_rightweaponattach|j_head|j_hips|j_spine1|j_spine2|root_point|1|j_leftleg|j_rightleg|j_backpackattach|j_backpackoffset|ap_anim_01|ap_anim_02|ap_anim_03|ap_anim_04|ap_anim_05|ap_anim_06",
        attachments = "!_nil",
        item_type = "!WEAPON_TRINKET",
        item_list_faction = "Player",
    })

    table_clear(_temp_names)

    -- Build a lookup of every configured replacement path once, instead of re-scanning
    -- the full attachments table (weapon_template -> slot -> attachment) for every single item.
    local replacement_paths = {}
    for weapon_template, weapon_attachments in pairs(self.settings.attachments) do
        for attachment_slot, attachments in pairs(weapon_attachments) do
            for attachment_name, attachment_data in pairs(attachments) do
                if attachment_data.replacement_path then
                    replacement_paths[attachment_data.replacement_path] = true
                end
            end
        end
    end

    for name, item in pairs(items) do
        -- local parts = string_split(name, "/")
        local parts = self:cached_split(name, "/")
        local item_name = parts[#parts]

        local attachment_found = replacement_paths[name] or false

        local filter_ok = true

        for i = 1, #MISSING_ATTACHMENTS_FILTER do
            -- if string_find(item_name, filter_name) then
            if self:cached_find(item_name, MISSING_ATTACHMENTS_FILTER[i]) then
                filter_ok = false
                break
            end
        end

        local search = nil --"rippergun_rifle"
        local search_ok = search and false or true

        if search then
            -- search_ok = string_find(item_name, search)
            search_ok = self:cached_find(item_name, search)
        end

        if search_ok and filter_ok and not attachment_found and not item.is_kitbash then
            _temp_names[#_temp_names + 1] = item_name
        end
    end

    -- local skip_attachments = {
    --     "stub_pistol_receiver_01",
    --     "stub_pistol_receiver_02",
    --     "stub_pistol_receiver_ml01_ver01",
    --     "stub_pistol_receiver_ml01_ver02",
    --     "stub_pistol_receiver_deluxe_ver01",
    --     "stub_pistol_receiver_deluxe_ver02",
    --     "stub_pistol_magazine_01",
    --     "stub_pistol_addon_01",
    --     "stub_pistol_addon_02",
    --     "stub_pistol_addon_deluxe",
    --     "stub_pistol_addon_ml01_ver01",
    --     "stub_pistol_addon_ml01_ver02",
    --     "stub_pistol_grip_01",
    --     "stub_pistol_grip_ml01",
    --     "stub_pistol_grip_deluxe",
    -- }

    if #_temp_names > 0 then
        self:print("################## unsupported attachments ##################")
        for _, name in pairs(_temp_names) do
            -- if not self:cached_table_contains(skip_attachments, name) then
            self:print(name)
            -- end
        end
        self:print("##########################################################")
    end
end

local _temp_items = {}

mod.find_master_item_entries = function(self, identifications)
    local master_items = master_items.get_cached()
    if master_items then
        -- The identification criteria themselves never change while scanning the cache,
        -- so parse/split/encode each one exactly once instead of redoing it for every item.
        local criteria = {}
        local criteria_count = 0

        for name, value in pairs(identifications) do
            criteria_count = criteria_count + 1

            local value_type = type(value)
            -- local name_str = string_gsub(name, "!", "")
            local entry = {
                name_str = mod:cached_gsub(name, "!", ""),
                value_type = value_type,
            }

            if value_type == "table" then
                entry.value_json = cjson_encode(value)
            elseif value_type == "string" then
                -- local negative = string_find(value, "!")
                entry.negative = self:cached_find(value, "!")
                -- local parts_str = string_gsub(value, "!", "")
                local parts_str = mod:cached_gsub(value, "!", "")
                -- local parts = string_split(parts_str, "|")
                entry.parts = self:cached_split(parts_str, "|")
            end

            criteria[criteria_count] = entry
        end

        table_clear(_temp_items)

        for item_name, item in pairs(master_items) do
            local identifications_valid = true

            for i = 1, criteria_count do
                local criterion = criteria[i]
                local table_value = item[criterion.name_str]
                local identification_valid = true

                if criterion.value_type == "table" and table_value and type(table_value) == "table" then
                    identification_valid = cjson_encode(table_value) == criterion.value_json
                elseif criterion.value_type == "string" then
                    local negative = criterion.negative
                    if not negative then
                        identification_valid = false
                    end
                    local parts = criterion.parts

                    for j = 1, #parts do
                        local part = parts[j]

                        if not negative then
                            if part ~= "_nil" and table_value == part then
                                identification_valid = true
                                break
                            elseif part == "_nil" and table_value == nil then
                                identification_valid = true
                                break
                            end
                        else
                            if part ~= "_nil" and table_value == part then
                                identification_valid = false
                                break
                            elseif part == "_nil" and table_value == nil then
                                identification_valid = false
                                break
                            end
                        end
                    end
                end

                identifications_valid = identification_valid
                if not identifications_valid then
                    break
                end
            end

            if identifications_valid then
                _temp_items[item_name] = item
            end
        end

        return _temp_items
    end
end

mod.master_items_randomize_store = function(self, item, offer_id)
    return mod:handle_store_item(item, offer_id)
end

mod.master_items_randomize_reward = function(self, item, gear_id)
    return mod:handle_reward_item(item, gear_id)
end

-- Get cached player gear list from data service
mod.player_gear_list = function(self)
    -- Get data service
    local data_service = managers and managers.data_service
    -- Get gear service
    local gear_data = data_service and data_service.gear
    -- Return gear list
    return gear_data and gear_data._cached_gear_list
end

mod.player_owns_item = function(self, item)
    local gear_id = mod:gear_id(item)
    local gear_list = self:player_gear_list()
    return gear_list and gear_list[gear_id]
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/backend/master_items", function(instance)
    instance.overwrite_attachment = function(attachments, target_slot, replacement_path)
        mod:overwrite_attachment(attachments, target_slot, replacement_path)
    end

    mod:master_item_community_patch()

    if not mod.micp_missing then
        -- Shared metatable: built once instead of allocating a fresh table + 3 fresh
        -- closures on every single item_plus_overrides() call. 't' is always the
        -- item_instance being indexed, so it replaces the old 'item_instance'/'gear' upvalues.
        local item_plus_overrides_mt = {
            __index = function(t, field_name)
                local master_ver = rawget(t, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(t)
                    if not success then
                        log_error("MasterItems", "[_item_plus_overrides][1] could not update master data with %s",
                            rawget(t, "__gear").masterDataInstance.id)
                        return nil
                    end
                end
                if field_name == "gear_id" then
                    return rawget(t, "__gear_id")
                end
                if field_name == "gear" then
                    return rawget(t, "__gear")
                end
                if field_name == "overrides" then
                    local gear = rawget(t, "__gear")
                    return gear and gear.masterDataInstance and gear.masterDataInstance.overrides
                end
                local master_item = rawget(t, "__master_item")
                if not master_item then
                    log_warning("MasterItemCache",
                        string_format("No master data for item with id %s", rawget(t, "__gear").masterDataInstance.id))
                    return nil
                end
                local field_value = master_item[field_name]
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
                return field_value
            end,
            __newindex = function(t, field_name, value)
                rawset(t, field_name, value)
            end,
            __tostring = function(t)
                local master_item = rawget(t, "__master_item")
                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name),
                    tostring(rawget(t, "__gear_id")))
            end
        }

        instance.item_plus_overrides = function(gear, gear_id, is_preview_item, ...)
            local new_gear_id = math_uuid()
            local item_instance = {
                __gear = gear,
                __gear_id = is_preview_item and new_gear_id or gear_id,
                __original_gear_id = is_preview_item and gear_id,
                __is_preview_item = is_preview_item and true or false
            }
            setmetatable(item_instance, item_plus_overrides_mt)
            local success = instance.update_master_data(item_instance)
            if not success then
                log_error("MasterItems", "[_item_plus_overrides][2] could not update master data with %s",
                    gear.masterDataInstance.id)
                return nil
            end
            return item_instance
        end

        local store_item_plus_overrides_mt = {
            __index = function(t, field_name)
                local master_ver = rawget(t, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(t)
                    if not success then
                        local data = rawget(t, "__data")
                        log_error("MasterItems",
                            "[_store_item_plus_overrides][1] could not update master data with %s; %s", data.id,
                            data.gear_id)
                        return nil
                    end
                end
                if field_name == "gear_id" then
                    return rawget(t, "__gear_id")
                end
                if field_name == "gear" then
                    return rawget(t, "__gear")
                end
                if field_name == "overrides" then
                    local gear = rawget(t, "__gear")
                    return gear and gear.masterDataInstance and gear.masterDataInstance.overrides
                end
                local master_item = rawget(t, "__master_item")
                if not master_item then
                    log_warning("MasterItemCache", string_format("No master data for item with id %s", t.__asset_id))

                    return nil
                end
                local field_value = master_item[field_name]
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
                return field_value
            end,
            __newindex = function(t, field_name, value)
                rawset(t, field_name, value)
            end,
            __tostring = function(t)
                local master_item = rawget(t, "__master_item")

                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name),
                    tostring(rawget(t, "__gear_id")))
            end,
        }

        instance.store_item_plus_overrides = function(data)
            local item_instance = {
                __data = data,
                __gear = {
                    masterDataInstance = {
                        id = data.id,
                        overrides = data.overrides,
                    },
                },
                __gear_id = data.gear_id or data.gearId,
            }
            setmetatable(item_instance, store_item_plus_overrides_mt)
            local success = instance.update_master_data(item_instance)
            if not success then
                log_error("MasterItems", "[_store_item_plus_overrides][2] could not update master data with %s; %s",
                    data.id, data.gear_id)
                return nil
            end
            return item_instance
        end

        local get_ui_item_instance_mt = {
            __index = function(t, field_name)
                local master_ver = rawget(t, "__master_ver")
                if master_ver ~= instance.get_cached_version() then
                    local success = instance.update_master_data(t)
                    if not success then
                        local item = rawget(t, "__data")
                        log_error("MasterItems",
                            "[_store_item_plus_overrides][1] could not update master data with %s; %s", item.name,
                            item.gear_id)
                        return nil
                    end
                end
                if field_name == "gear_id" then
                    return rawget(t, "__gear_id")
                end
                if field_name == "gear" then
                    return rawget(t, "__gear")
                end
                if field_name == "overrides" then
                    local gear = rawget(t, "__gear")
                    return gear and gear.masterDataInstance and gear.masterDataInstance.overrides
                end
                local master_item = rawget(t, "__master_item")
                if not master_item then
                    log_warning("MasterItemCache",
                        string_format("UI - No master data for item with id %s", rawget(t, "__data").name))
                    return nil
                end
                local field_value = master_item[field_name]
                if field_name == "rarity" and field_value == -1 then
                    return nil
                end
                return field_value
            end,
            __newindex = function(t, field_name, value)
                rawset(t, field_name, value)
            end,
            __tostring = function(t)
                local master_item = rawget(t, "__master_item")
                return string_format("master_item: [%s] gear_id: [%s]", tostring(master_item and master_item.name),
                    tostring(rawget(t, "__gear_id")))
            end,
        }

        instance.get_ui_item_instance = function(item)
            local gear_override = item.gear and item.gear.masterDataInstance and item.gear.masterDataInstance.overrides
            local overrides = item.overrides or gear_override
            if overrides then
                overrides = table_clone_instance(overrides)
            else
                overrides = {}
            end
            if item.slot_weapon_skin then
                overrides.slot_weapon_skin = type(item.slot_weapon_skin) == "table" and item.slot_weapon_skin.name or
                    item.slot_weapon_skin
            end
            local item_instance = {
                __is_ui_item_preview = true,
                __data = item,
                __gear = {
                    masterDataInstance = {
                        id = item.name,
                        overrides = overrides,
                    },
                },
                __gear_id = item.gear_id or math_uuid(),
            }
            setmetatable(item_instance, get_ui_item_instance_mt)
            local success = instance.update_master_data(item_instance)
            if not success then
                log_error("MasterItems", "UI - [_store_item_plus_overrides][2] could not update master data with %s; %s",
                    item.name, item.gear_id)
                return nil
            end
            return item_instance
        end

        mod:hook(instance, "get_item_instance", function(func, gear, gear_id, ...)
            local item_instance = func(gear, gear_id, ...)
            return mod:gear_settings(gear_id) and (mod:husk_item(gear_id) or mod:mod_item(gear_id, item_instance)) or
                item_instance
        end)

        mod:hook(instance, "create_preview_item_instance", function(func, item, ...)
            -- Check item
            if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) then
                -- Modify item
                mod:modify_item(item)
                -- Fixes
                mod:apply_attachment_fixes(item)
            end

            -- ##### Original function ####################################################################################
            local item_instance
            local gear = table_clone_instance(item.__gear)
            local gear_id = item.__gear_id

            if not gear then
                log_warning("MasterItemCache", string_format("Gear list missing gear with id %s", gear_id))
                return nil
            else
                -- local allow_modifications = true
                item_instance = instance.item_plus_overrides(gear, gear_id, true)
            end
            -- ##### Original function ####################################################################################

            -- Relay gear id
            mod:gear_id_relay(item_instance.gear_id, item.gear_id)
            -- Return
            return item_instance
        end)

        mod:hook(instance, "get_store_item_instance", function(func, description, ...)
            local item_instance = func(description, ...)
            local gear_id = mod:gear_id(item_instance)
            local offer_id = pt.gear_id_to_offer_id[gear_id]
            -- Return randomized
            return mod:master_items_randomize_store(item_instance, offer_id)
        end)
    end
end)
