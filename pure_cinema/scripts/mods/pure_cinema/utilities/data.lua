local mod = get_mod("pure_cinema")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local pairs = pairs
    local table_clone = table.clone
    local table_clear = table.clear
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _default_count = 2000

mod.data_next_id = {}
mod.data_counts = {}
mod.data_tables = {}
mod.data_register = {}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local next_id = mod.data_next_id
local counts = mod.data_counts
local tables = mod.data_tables
local register = mod.data_register

mod.register_data = function(self, name, optional_count, optional_template)
	local count = optional_count or _default_count
    next_id[name] = 1
    counts[name] = count
	tables[name] = {}
	register[name] = {}
	for i = 1, count do
		tables[name][i] = optional_template and table_clone(optional_template) or {}
	end
end

mod.request_data = function(self, name)
    local id = next_id[name]
    local data = tables[name][id]
    register[name][data] = id
    id = id + 1
    if id > counts[name] then id = 1 end
    next_id[name] = id
    return data
end

mod.data_table = function(self, name)
    return tables[name]
end

mod.data_by_id = function(self, name, id)
    local data_register = register[name]
    for data, i in pairs(data_register) do
        if i == id then
            return data
        end
    end
end

mod.data_id = function(self, name, data)
    return register[name][data]
end

mod.release_data = function(self, name, data)
	table_clear(data)
	register[name][data] = nil
end
