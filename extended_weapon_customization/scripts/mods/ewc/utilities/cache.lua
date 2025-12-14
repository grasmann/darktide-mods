local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local string = string
    local string_find = string.find
    local string_gsub = string.gsub
    local string_split = string.split
    local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local split_cache = {}
local find_cache = {}
local gsub_cache = {}
local table_contains_cache = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.cached_split = function(self, query, optional_seperator)
    local cache = split_cache[query]
    local seperator = optional_seperator or "|"
    local result = cache or string_split(query, seperator)
    if not split_cache[query] then split_cache[query] = result end
    return result
end

mod.cached_find = function(self, query, term)
    local cache = find_cache[query]
    local result = cache or string_find(query, term)
    if not find_cache[query] then find_cache[query] = result end
    return result
end

mod.cached_gsub = function(self, query, term, replacement)
    local cache = gsub_cache[query] and gsub_cache[query][term] and gsub_cache[query][term][replacement]
    local result = cache or string_gsub(query, term, replacement)
    if not gsub_cache[query] then gsub_cache[query] = {} end
    if not gsub_cache[query][term] then gsub_cache[query][term] = {} end
    if not gsub_cache[query][term][replacement] then gsub_cache[query][term][replacement] = result end
    return result
end

mod.cached_table_contains = function(self, t, v)
    local cache = table_contains_cache[t]
    local result = cache or table_contains(t, v)
    if not table_contains_cache[t] then table_contains_cache[t] = result end
    return result
end
