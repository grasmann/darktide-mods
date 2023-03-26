local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local _io = DMF:persistent_table("_io")
_io.initialized = _io.initialized or false
if not _io.initialized then _io = DMF.deepcopy(Mods.lua.io) end

local _os = DMF:persistent_table("_os")
_os.initialized = _os.initialized or false
if not _os.initialized then _os = DMF.deepcopy(Mods.lua.os) end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

mod.appdata_path = function(self)
	local appdata = _os.getenv('APPDATA')
	return appdata.."/Fatshark/Darktide/scoreboard_history/"
end

mod.create_scoreboard_history_directory = function(self)
	_os.execute('mkdir '..self:appdata_path()) -- ?
	_os.execute("mkdir '"..self:appdata_path().."'") -- ?
	_os.execute('mkdir "'..self:appdata_path()..'"') -- Windows
end

mod.current_date = function(self)
    return _os.time(_os.date("!*t"))
end

mod.create_scoreboard_history_entry_path = function(self)
	-- local date = _os.time(_os.date("!*t"))
	return self:appdata_path()..tostring(self:current_date())..".lua"
end

mod.get_scoreboard_history_entries = function(self, scan_dir)

	-- Lua implementation of PHP scandir function
	local function scandir(directory)
		local i, t, popen = 0, {}, _io.popen
		local pfile = popen('dir "'..directory..'" /b')
		for filename in pfile:lines() do
			i = i + 1
			t[i] = filename
		end
		pfile:close()
		return t
	end

	local entries = {}
	local appdata = self:appdata_path()
    local cache = self:get_scoreboard_history_entries_cache()
	local files = scan_dir and scandir(appdata) or cache
    if scan_dir then self:set_scoreboard_history_entries_cache(files) end
	for _, file in pairs(files) do
		local file_path = appdata..file
		local entry = self:load_scoreboard_history_entry(file_path, file, true)
		entries[#entries+1] = entry
	end

	return entries
end

mod.get_scoreboard_history_entries_cache = function(self)
    return self:get("scoreboard_history_entries")
end

mod.set_scoreboard_history_entries_cache = function(self, entries)
    self:set("scoreboard_history_entries", entries)
    self:echo("Scoreboard History Cached")
end

mod.update_scoreboard_history_entries = function(self)

end

mod.save_scoreboard_history_entry = function(self)
	-- Create appdata folder
	self:create_scoreboard_history_directory()


	local path = self:create_scoreboard_history_entry_path()
	-- Open file
	local file = assert(_io.open(path, "w+"))
	-- Players
	local players = self.player_manager:players()
	if self.debug_value then
		players = {
			{
				account_id = function()
					return mod:me()
				end,
				name = function()
					return "Rudge"
				end,
			},
			{
				account_id = function()
					return "lol"
				end,
				name = function()
					return "lol"
				end,
			},
			{
				account_id = function()
					return "rofl"
				end,
				name = function()
					return "rofl"
				end,
			},
			{
				account_id = function()
					return "omg"
				end,
				name = function()
					return "omg"
				end,
			},
		}
	end
	local count = math.min(#players, 4)
	file:write("#players;"..tostring(count).."\n")
	for p = 1, 4, 1 do
		local player = players[p]
		if player then
			local account_id = player:account_id() or player:name()
			file:write(p..";"..player:account_id()..";"..player:name().."\n")
		end
	end
	-- Rows
	for _, row in pairs(self.rows) do
		-- local id = _..row.name
		-- local val_count = row.data and #row.data or 0
		local val_count = 0
		if row.data and type(row.data) == "table" then
			for k,v in pairs(row.data) do
				val_count = val_count + 1
			end
		end
		file:write("#row;"..row.name..";".._..";"..val_count.."\n")
		for account_id, data in pairs(row.data) do
			file:write(account_id..";"..data.score..";"..(data.is_best and "1" or "0")..";"..(data.is_worst and "1" or "0").."\n")
		end
	end
	-- Close file
	file:close()
end

mod.load_scoreboard_history_entry = function(self, path, date, only_head)
	local entry = {
		name = date,
		-- date = nil,
		-- players = {},
		-- rows = {},
	}

	-- split("a,b,c", ",") => {"a", "b", "c"}
	local function split(s, sep)
		local fields = {}
		local sep = sep or " "
		local pattern = string.format("([^%s]+)", sep)
		string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
		return fields
	end

	local function entry_player_id(account_id)
		for id, data in pairs(entry.players) do
			if data.account_id == account_id then
				return id
			end
		end
	end

	-- Open file
	-- local file = assert(_io.open(path, "r"))
	local reading = ""
	local count = 0
	local row_index = 0
	for line in _io.lines(path) do
		-- self:echo(line)
		-- Players
		local player_match = line:match("#players")
		local row_match = line:match("#row")
		if player_match or reading == "players" then
			if player_match then
				reading = "players"
				count = tonumber(split(line, ";")[2])
				entry.date = _os.date(_, tonumber(date))
				-- self:echo(entry.date)
			elseif reading == "players" and count > 0 then
				local player_info = split(line, ";")
                entry.players = entry.players or {}
				entry.players[player_info[1]] = {
					account_id = player_info[2],
					name = player_info[3],
				}
				count = count - 1
				if count <= 0 then reading = "" end
			end
		elseif (row_match or reading == "row") and not only_head then
			if row_match then
                entry.rows = entry.rows or {}
				local info = split(line, ";")
				reading = "row"
				row_index = tonumber(info[3])
				count = tonumber(info[4])
				entry.rows[row_index] = {
					name = info[2],
					data = {},
				}
			elseif reading == "row" and count > 0 and row_index > 0 then
				local val_info = split(line, ";")
				local score = tonumber(val_info[2])
				entry.rows[row_index].data[val_info[1]] = {
					score = score,
					value = score,
					is_best = val_info[3] == "1" and true or false,
					is_worst = val_info[4]  == "1" and true or false,
				}
				count = count - 1
				if count <= 0 then
					reading = ""
					row_index = 0
				end
			end
		end
	end
	-- Players

	-- self:dtf(entry, "scoreboard_entry", 8)
	return entry
end