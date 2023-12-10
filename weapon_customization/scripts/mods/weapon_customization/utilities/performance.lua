local mod = get_mod("weapon_customization")
local DMF = get_mod("DMF")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _os = DMF:persistent_table("_os")
_os.initialized = _os.initialized or false
if not _os.initialized then _os = DMF.deepcopy(Mods.lua.os) end

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local math = math
    local math_round_with_precision = math.round_with_precision
    local tostring = tostring
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local start_performance_measure = function(name)
    local performance = mod:persistent_table(REFERENCE).performance
    local id = #performance.measurements + 1
    performance.measurements[id] = {name = name, start = _os.clock()}
    return id
end

local pause_performance_measure = function(id)
    local performance = mod:persistent_table(REFERENCE).performance
    if performance.measurements[id] then
        performance.measurements[id].pause = _os.clock()
    end
end

local resume_performance_measure = function(id)
    local performance = mod:persistent_table(REFERENCE).performance
    if performance.measurements[id] and performance.measurements[id].pause then
        local minus = performance.measurements[id].minus or 0
        minus = minus + (performance.measurements[id].pause - _os.clock())
        performance.measurements[id].minus = minus
    end
end

local stop_performance_measure = function(id, echo)
    local performance = mod:persistent_table(REFERENCE).performance
    if performance.measurements[id] then
        local time = _os.clock()
        local minus = performance.measurements[id].minus or 0
        local result = ((time - performance.measurements[id].start) - minus) * 1000
        -- Cache
        performance.result_cache[performance.measurements[id].name] = performance.result_cache[performance.measurements[id].name] or {}
        local c = performance.result_cache[performance.measurements[id].name]
        c[#c+1] = result
        -- Cache
        if echo then mod:echot(tostring(result)) end
        performance.measurements[id] = nil
        return result
    end
end

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

wc_perf = {
    start = start_performance_measure,
    pause = pause_performance_measure,
    resume = resume_performance_measure,
    stop = stop_performance_measure,
}
