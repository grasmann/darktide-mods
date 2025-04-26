local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local _g = _G
    local type = type
    local CLASS = CLASS
    local DMFMod = DMFMod
    local rawget = rawget
    local Localize = Localize
    local managers = Managers
    local tostring = tostring
    local tonumber = tonumber
    local Keyboard = Keyboard
    local application_time_since_query = Application.time_since_query
    local application_query_performance_counter = Application.query_performance_counter
--#endregion

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌┬┐  ┌┬┐┌┬┐┌─┐ ###############################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││ ││   │││││├┤  ###############################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘─┴┘  ─┴┘┴ ┴└   ###############################################################################

function DMFMod:localize_or_global(string_id)
	local localized_string = self:localize(string_id)
	if localized_string == "<"..tostring(string_id)..">" then localized_string = Localize(string_id) end
	return localized_string
end

function DMFMod:echot(...)
    local t = managers and managers.time and managers.time:time("main") or 0
    self._echot = self._echot or {}
    local echoTime = self._echot[...]
    if not echoTime or echoTime < t then
        self:echo(...)
        self._echot[...] = t + 2
    end
end

function DMFMod:push_or_pop_cursor(instance, reference)
    if instance.visible and not instance.cursor_pushed then
        managers.input:push_cursor(reference)
        instance.cursor_pushed = true
    elseif not instance.visible and instance.cursor_pushed then
        managers.input:pop_cursor(reference)
        instance.cursor_pushed = false
    end
end

function DMFMod:is_shift_held()
    if not Keyboard then
        Keyboard = rawget(_g, "Keyboard")
        if not Keyboard then return end
    end
    return Keyboard.button(Keyboard.button_index("left shift")) > 0.5
end

function DMFMod:is_ctrl_held()
    if not Keyboard then
        Keyboard = rawget(_g, "Keyboard")
        if not Keyboard then return end
    end
    return Keyboard.button(Keyboard.button_index("left ctrl")) > 0.5
end

-- ##### ┬─┐┌─┐┌┬┐┬┬─┐┌─┐┌─┐┌┬┐┌─┐ ####################################################################################
-- ##### ├┬┘├┤  │││├┬┘├┤ │   │ └─┐ ####################################################################################
-- ##### ┴└─└─┘─┴┘┴┴└─└─┘└─┘ ┴ └─┘ ####################################################################################

-- -- function DMFMod:hook(obj, method, handler)
-- --     return generic_hook(self, obj, method, handler, "hook")
-- -- end
-- mod:hook(CLASS.DMFMod, "hook", function(func, this_mod, obj, method, old_handler, ...)
--     local handler = function(...)
--         mod:set_mod(this_mod)
--         -- Performance counter
--         mod.performance[this_mod] = mod.performance[this_mod] or {
--             entries = {},
--         }
--         local entries = mod.performance[this_mod].entries
--         -- performance[this_mod].entries[mod.cycle]
--         local handle = application_query_performance_counter()
--         -- Call
--         local ret = old_handler(...)
--         -- Performance counter
--         -- local entries = performance[this_mod].entries[mod.cycle]
--         entries[mod.cycle] = entries[mod.cycle] or {}
--         local cycle_entries = entries[mod.cycle]
--         cycle_entries[#cycle_entries+1] = application_time_since_query(handle)
--         -- Return
--         return ret
--     end
--     return func(this_mod, obj, method, handler, ...)
-- end)
-- -- function DMFMod:hook_safe(obj, method, handler)
-- --     return generic_hook(self, obj, method, handler, "hook_safe")
-- -- end
-- mod:hook(CLASS.DMFMod, "hook_safe", function(func, this_mod, obj, method, old_handler, ...)
--     local handler = function(...)
--         mod:set_mod(this_mod)
--         return old_handler(...)
--     end
--     return func(this_mod, obj, method, handler, ...)
-- end)
-- -- function DMFMod:hook_origin(obj, method, handler)
-- --     return generic_hook(self, obj, method, handler, "hook_origin")
-- -- end
-- mod:hook(CLASS.DMFMod, "hook_origin", function(func, this_mod, obj, method, old_handler, ...)
--     local handler = function(...)
--         mod:set_mod(this_mod)
--         return old_handler(...)
--     end
--     return func(this_mod, obj, method, handler, ...)
-- end)
-- -- function DMFMod:hook_require(obj_str, callback_func)

-- --     -- Set up the tables for the file
-- --     local mod_name = self:get_name()
-- --     _file_hooks_by_file[obj_str]                   = _file_hooks_by_file[obj_str] or {}
-- --     _file_hooks_applied_to_file[obj_str]           = _file_hooks_applied_to_file[obj_str] or {}
-- --     _file_hooks_applied_to_file[obj_str][mod_name] = _file_hooks_applied_to_file[obj_str][mod_name] or {}

-- --     -- Store file hooks by mod name to prevent duplicates per mod
-- --     _file_hooks_by_file[obj_str][mod_name] = callback_func

-- --     -- Run the hook's callback on every instance of the file
-- --     local all_file_instances = self:get_require_store(obj_str)
-- --     if all_file_instances then
-- --         for i, instance in ipairs(all_file_instances) do
-- --             if instance and not _file_hooks_applied_to_file[obj_str][mod_name][i] then
-- --                 callback_func(instance)
-- --                 _file_hooks_applied_to_file[obj_str][mod_name][i] = true
-- --             end
-- --         end
-- --     end
-- -- end
-- -- mod:hook(CLASS.DMFMod, "hook_require", function(func, self, obj_str, old_callback_func, ...)
-- --     local callback_func = function()
-- --         mod:set_mod(self)
-- --         return old_callback_func()
-- --     end
-- --     return func(self, obj_str, callback_func, ...)
-- -- end)



mod:hook(CLASS.DMFMod, "dtf", function(func, self, obj, name, depth, ...)
    if mod:get("hook_dtf") then mod:inspect(name, obj)
    else return func(self, obj, name, depth, ...) end
end)

local print = function(printing_mod, ...)
    -- mod:console_set_mod(printing_mod)
    mod:console_print(...)
end

mod:hook(CLASS.DMFMod, "echo", function(func, self, ...)
    if mod:get("hook_echo") then
        mod:set_mod(self)
        print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "error", function(func, self, ...)
    if mod:get("hook_error") then
        mod:set_mod(self)
        print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "warning", function(func, self, ...)
    if mod:get("hook_warning") then
        mod:set_mod(self)
        print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "info", function(func, self, ...)
    if mod:get("hook_info") then
        mod:set_mod(self)
        print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "notify", function(func, self, ...)
    if mod:get("hook_notify") then
        mod:set_mod(self)
        print(self, ...)
    else return func(self, ...) end
end)