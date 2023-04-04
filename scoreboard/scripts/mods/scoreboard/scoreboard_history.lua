local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

-- local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")

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
-- ##### ┌┬┐┬┬─┐┌─┐┌─┐┌┬┐┌─┐┬─┐┬ ┬ ####################################################################################
-- #####  │││├┬┘├┤ │   │ │ │├┬┘└┬┘ ####################################################################################
-- ##### ─┴┘┴┴└─└─┘└─┘ ┴ └─┘┴└─ ┴  ####################################################################################

-- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = _os.rename(file, file)
	if not ok then
	   if code == 13 then
		  -- Permission denied, but it exists
		  return true
	   end
	end
	return ok, err
end

-- Check if a directory exists in this path
local function isdir(path)
	-- "/" works on both Unix and Windows
	return exists(path.."/")
end

-- Check if file exists
local function file_exists(name)
	local f = _io.open(name, "r")
	if f ~= nil then _io.close(f) return true else return false end
end

mod.appdata_path = function(self)
	local appdata = _os.getenv('APPDATA')
	return appdata.."/Fatshark/Darktide/scoreboard_history/"
end

mod.create_scoreboard_history_directory = function(self)
	local path = self:appdata_path()
	if not isdir(path) then
		_os.execute('mkdir '..path) -- ?
		_os.execute("mkdir '"..path.."'") -- ?
		_os.execute('mkdir "'..path..'"') -- Windows
	end
end

mod.create_scoreboard_history_entry_path = function(self)
	-- local date = _os.time(_os.date("!*t"))
	local file_name = tostring(self:current_date())..".lua"
	return self:appdata_path()..file_name, file_name
end

-- ##### ┌─┐┌┐┌┌┬┐┬─┐┬┌─┐┌─┐ ##########################################################################################
-- ##### ├┤ │││ │ ├┬┘│├┤ └─┐ ##########################################################################################
-- ##### └─┘┘└┘ ┴ ┴└─┴└─┘└─┘ ##########################################################################################

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
		local text = self:localize("scoreboard_history_cached")
    	self:echo(text)
		return t
	end

	local entries = {}
	local appdata = self:appdata_path()
    local cache = self:get_scoreboard_history_entries_cache()
	local files = cache
	if scan_dir or not cache then
		files = scandir(appdata)
		self:set_scoreboard_history_entries_cache(files)
	end
	local missing_file = false
	for _, file in pairs(files) do
		local file_path = appdata..file
		if file_exists(file_path) then
			local entry = self:load_scoreboard_history_entry(file_path, file, true)
			entry.file = file
			entry.file_path = file_path
			local date_str = string.sub(file, 1, string.len(file) - 4)
			entry.date = _os.date("%Y-%m-%d %H:%M:%S", tonumber(date_str))
			entries[#entries+1] = entry
		else
			missing_file = true
		end
	end

	if missing_file then
		entries = self:get_scoreboard_history_entries(true)
	end

	return entries
end

mod.get_scoreboard_history_entries_cache = function(self)
    return self:get("scoreboard_history_entries")
end

mod.set_scoreboard_history_entries_cache = function(self, entries)
    self:set("scoreboard_history_entries", entries)
end

-- ##### ┌─┐┌─┐┬  ┬┌─┐  ┬  ┌─┐┌─┐┌┬┐  ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ ##############################################################
-- ##### └─┐├─┤└┐┌┘├┤───│  │ │├─┤ ││───││├┤ │  ├┤  │ ├┤  ##############################################################
-- ##### └─┘┴ ┴ └┘ └─┘  ┴─┘└─┘┴ ┴─┴┘  ─┴┘└─┘┴─┘└─┘ ┴ └─┘ ##############################################################

mod.delete_scoreboard_history_entry = function(self, file_name)
	local file_path = self:appdata_path()..file_name
	if file_exists(file_path) then
		-- self:echo(file_path)
		if _os.remove(file_path) then
			-- Remove from cache
			local cache = mod:get_scoreboard_history_entries_cache()
			local new_cache = {}
			for _, c in pairs(cache) do
				if c ~= file_name then
					new_cache[#new_cache+1] = c
				end
			end
			mod:set_scoreboard_history_entries_cache(new_cache)
			return true
		end
	end
end

mod.save_scoreboard_history_entry = function(self, sorted_rows)
	
	-- Create appdata folder
	self:create_scoreboard_history_directory()


	local path, file_name = self:create_scoreboard_history_entry_path()
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
	local count = 0
	for _, player in pairs(players) do
		count = count + 1
	end
	count = math.min(count, 4)
	file:write("#players;"..tostring(count).."\n")
	local num_players = 0
	-- for p = 1, 4, 1 do
	for _, player in pairs(players) do
		-- local player = players[p]
		num_players = num_players + 1
		if num_players < 5 then
			local account_id = player:account_id() or player:name()
			file:write(num_players..";"..account_id..";"..player:name().."\n")
		end
	end
	-- Rows
	local index = 1
	for g = 1, #sorted_rows, 1 do
        local rows = sorted_rows[g]
        -- mod:echo("group")
        for i = 1, #rows, 1 do
            local this_row = rows[i]
			if this_row.name ~= "header" and not this_row.score then

				-- for _, row in pairs(group) do
				-- local id = _..row.name
				-- local val_count = row.data and #row.data or 0
				local val_count = 0
				if this_row.data and type(this_row.data) == "table" then
					for k,v in pairs(this_row.data) do
						val_count = val_count + 1
					end
				end
				local name = this_row.name
				-- local text = this_row.mod:localize(this_row.text)
				local text = this_row.mod:localize(this_row.text) or this_row.text
				local this_setting = this_row.setting
				if this_setting then
					local str = string.split(this_setting, " ")
					if str and #str > 1 then
						this_setting = str[1]
					end
					this_setting = tostring(this_row.mod:get(this_setting))
					if this_setting then
						local that_text = this_row.mod:localize(this_row.text.."_"..this_setting)
						if that_text ~= "<>" and that_text ~= "<"..this_row.text.."_"..this_setting..">" then
							text = that_text
						end
					end
				end


				local validation = this_row.validation_type
				local iteration = tostring(this_row.iteration_type)
				local visible = tostring(this_row.visible) --this_row.visible == true and "1" or "0"
				local group = tostring(this_row.group) --~= "" and this_row.group or "none"
				local setting = tostring(this_row.setting) --~= "" and this_row.setting or "none"
				local parent = tostring(this_row.parent) --~= "" and this_row.parent or "none"
				local is_time = tostring(this_row.is_time) --== true and "1" or "0"
				local summary = this_row.summary and table.concat(this_row.summary, ":") or ""
				file:write("#row;"..name..";"..index..";"..val_count..";"..text..";"..validation..";"..iteration..";"..visible..";"..group..";"..setting..";"..parent..";"..is_time..";"..summary.."\n")
				if this_row.data and type(this_row.data) == "table" then
					for account_id, data in pairs(this_row.data) do
						file:write(account_id..";"..data.score..";"..(data.is_best and "1" or "0")..";"..(data.is_worst and "1" or "0").."\n")
					end
				end
				index = index + 1
				-- end
			end
		end
	end
	-- Close file
	file:close()
	-- Add to cache
	local cache = mod:get_scoreboard_history_entries_cache()
	if not cache then cache = {} end
	cache[#cache+1] = file_name
	mod:set_scoreboard_history_entries_cache(cache)
end

mod.load_scoreboard_history_entry = function(self, path, date, only_head)
	local entry = {
		name = date,
		-- date = nil,
		-- players = {},
		-- rows = {},
	}

	-- split("a,b,c", ",") => {"a", "b", "c"}
	-- local function split(s, sep)
	-- 	local fields = {}
	-- 	local sep = sep or " "
	-- 	local pattern = string.format("([^%s]+)", sep)
	-- 	string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
	-- 	return fields
	-- end
	local function split(str, sep)
		local result = {}
		local regex = ("([^%s]+)"):format(sep)
		for each in str:gmatch(regex) do
		   table.insert(result, #result+1, each)
		end
		return result
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
	local row_index = {}
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

				local name = info[2]
				-- mod:echo("name '"..tostring(name).."'")
				local index = info[3]
				-- mod:echo("index '"..tostring(index).."'")
				local val_count = info[4]
				-- mod:echo("valcount '"..tostring(val_count).."'")

				local text = tostring(info[5])
				-- if tostring(info[5]) == "" or tostring(info[5]) == "nil" then text = name end
				-- mod:echo("text '"..tostring(text).."'")
				local validation = info[6]
				-- mod:echo("validation '"..tostring(validation).."'")
				local iteration = info[7]
				-- mod:echo("iteration '"..tostring(iteration).."'")

				local visible = nil 
				if tostring(info[8]) == "false" then visible = false end
				if tostring(info[8]) == "nil" then visible = nil end
				-- mod:echo("visible '"..tostring(visible).."' '"..info[8].."'")
				-- if info[8] == "false" then visible = false end
				-- visible = info[8] == "1" and nil or visible
				local group = tostring(info[9])
				if tostring(info[9]) == "nil" then group = nil end
				-- mod:echo("group '"..tostring(group).."'")
				local setting = tostring(info[10]) ~= "nil" and info[10] or nil
				if tostring(info[10]) == "nil" then setting = nil end
				-- mod:echo("setting '"..tostring(setting).."'")

				local parent = tostring(info[11])
				if tostring(info[11]) == "nil" then parent = nil end
				-- mod:echo("parent '"..tostring(parent).."'")
				local is_time = nil
				if tostring(info[12]) == "true" then is_time = true end
				if tostring(info[12]) == "nil" then is_time = nil end
				-- mod:echo("is_time '"..tostring(is_time).."'")
				local summary = info[13] and split(info[13], ":") or nil
				-- mod:echo("is_time '"..tostring(is_time).."'")

				reading = "row"
				row_index = #entry.rows + 1
				count = tonumber(val_count)
				local new_row = {
					name = name,
					text = text,
					validation = validation,
					-- validation = ScoreboardDefinitions.validation_types[validation],
					validation_type = validation,
					iteration = iteration,
					-- iteration = ScoreboardDefinitions.iteration_types[iteration],
					iteration_type = iteration,
					group = group,
					-- setting = setting,
					parent = parent,
					is_time = is_time,
					summary = summary,
					data = {},
				}
				if visible ~= nil then new_row.visible = visible end
				entry.rows[row_index] = new_row
			elseif reading == "row" and count > 0 and row_index > 0 then
				local val_info = split(line, ";")
				local score = tostring(val_info[2])
				-- if score ~= "0" then mod:echo("score '"..score.."'") end
				entry.rows[row_index].data[val_info[1]] = {
					score = tonumber(score),
					value = tonumber(score),
					-- is_best = val_info[3] == "1" and true or false,
					-- is_worst = val_info[4]  == "1" and true or false,
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

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod.current_date = function(self)
    return _os.time(_os.date("*t"))
end
