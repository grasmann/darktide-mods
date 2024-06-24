local mod = get_mod("modding_tools")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local type = type
    local CLASS = CLASS
    local DMFMod = DMFMod
    local Localize = Localize
    local managers = Managers
    local tostring = tostring
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
    elseif not instance.visible then
        managers.input:pop_cursor(reference)
        instance.cursor_pushed = false
    end
end

-- ##### ┬─┐┌─┐┌┬┐┬┬─┐┌─┐┌─┐┌┬┐┌─┐ ####################################################################################
-- ##### ├┬┘├┤  │││├┬┘├┤ │   │ └─┐ ####################################################################################
-- ##### ┴└─└─┘─┴┘┴┴└─└─┘└─┘ ┴ └─┘ ####################################################################################

mod:hook(CLASS.DMFMod, "dtf", function(func, self, obj, name, depth, ...)
    if mod:get("hook_dtf") then mod:inspect(name, obj)
    else return func(self, obj, name, depth, ...) end
end)

local print = function(printing_mod, ...)
    mod:console_set_mod(printing_mod)
    mod:console_print(...)
end

mod:hook(CLASS.DMFMod, "echo", function(func, self, ...)
    if mod:get("hook_echo") then print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "error", function(func, self, ...)
    if mod:get("hook_error") then print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "warning", function(func, self, ...)
    if mod:get("hook_warning") then print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "info", function(func, self, ...)
    if mod:get("hook_info") then print(self, ...)
    else return func(self, ...) end
end)

mod:hook(CLASS.DMFMod, "notify", function(func, self, ...)
    if mod:get("hook_notify") then print(self, ...)
    else return func(self, ...) end
end)