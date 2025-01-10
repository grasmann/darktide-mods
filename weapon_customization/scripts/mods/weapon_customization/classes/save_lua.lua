local mod = get_mod("weapon_customization")
local DMF = get_mod("DMF")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
	local Mods = Mods
	local _io = DMF:persistent_table("_io")
	_io.initialized = _io.initialized or false
	if not _io.initialized then _io = DMF.deepcopy(Mods.lua.io) end

	local _os = DMF:persistent_table("_os")
	_os.initialized = _os.initialized or false
	if not _os.initialized then _os = DMF.deepcopy(Mods.lua.os) end

	local _loadstring = Mods.lua.loadstring
	local _loadfile = Mods.lua.loadfile
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local type = type
	local Unit = Unit
	local table = table
	local pairs = pairs
	local class = class
	local string = string
	local assert = assert
	local tostring = tostring
	local unit_alive = Unit.alive
	local table_clear = table.clear
	local table_contains = table.contains
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local REFERENCE = "weapon_customization"
	local DEBUG = false
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local SaveLua = class("SaveLua")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

SaveLua.init = function(self, gear_settings)
	self.gear_settings = gear_settings
end

SaveLua.debug = function(self, file_name, message)
    -- Print message to console
    if DEBUG then mod:echo(tostring(message)..tostring(file_name)) end
end

-- ##### ┬┌┐┌┌─┐┌─┐ ###################################################################################################
-- ##### ││││├┤ │ │ ###################################################################################################
-- ##### ┴┘└┘└  └─┘ ###################################################################################################

-- Check if a file or directory exists in this path
SaveLua._exists = function(self, file)
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
SaveLua._isdir = function(self, path)
	-- "/" works on both Unix and Windows
	return self:_exists(path.."/")
end

-- Check if file exists
SaveLua._file_exists = function(self, name)
	local f = _io.open(name, "r")
	if f ~= nil then _io.close(f) return true else return false end
end

-- ##### ┌┬┐┬┬─┐┌─┐┌─┐┌┬┐┌─┐┬─┐┬ ┬ ####################################################################################
-- #####  │││├┬┘├┤ │   │ │ │├┬┘└┬┘ ####################################################################################
-- ##### ─┴┘┴┴└─└─┘└─┘ ┴ └─┘┴└─ ┴  ####################################################################################

-- Lua implementation of PHP scandir function
SaveLua._scan_dir = function(self, directory)
	local i, t, popen = 0, {}, _io.popen
	local pfile = popen('dir "'..directory..'" /b')
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end
	pfile:close()
	local text = mod:localize("weapon_customization_cached")
	mod:echo(text)
	return t
end

-- Get appdata path
SaveLua._appdata_path = function(self)
	local appdata = _os.getenv('APPDATA')
	return appdata.."/Fatshark/Darktide/weapon_customization/"
end

SaveLua._create_directory = function(self)
	local path = self:_appdata_path()
	if not self:_isdir(path) then
		_os.execute('mkdir '..path) -- ?
		_os.execute("mkdir '"..path.."'") -- ?
		_os.execute('mkdir "'..path..'"') -- Windows
	end
end

SaveLua._create_entry_path = function(self, data)
	local gear_id = self.gear_settings:item_to_gear_id(data.item)
	local file_name = tostring(gear_id)..".lua"
	return self:_appdata_path()..file_name, file_name
end

-- ##### ┌─┐┌─┐┌─┐┬ ┬┌─┐ ##############################################################################################
-- ##### │  ├─┤│  ├─┤├┤  ##############################################################################################
-- ##### └─┘┴ ┴└─┘┴ ┴└─┘ ##############################################################################################

local entries = {}
SaveLua.get_entries = function(self, data, scan_dir)
	-- local entries = {}
	table_clear(entries)
	local appdata = self:_appdata_path()
    local cache = self:_get_entries_cache()
	local files = cache
	if scan_dir or not cache then
		files = self:_scan_dir(appdata)
		self:_set_cache(data, files)
	end
	local missing_file = false
	for _, file in pairs(files) do
		local file_path = appdata..file
		if self:_file_exists(file_path) then
			local entry = self:_load_entry(file_path)
			entry.file = file
			entry.file_path = file_path
			entries[#entries+1] = entry
		else
			missing_file = true
		end
	end

	if missing_file then
		entries = self:get_entries(data, true)
	end

	return entries
end

SaveLua._get_entries_cache = function(self)
    return mod:get("weapon_customization_entries")
end

SaveLua._set_cache = function(self, entries)
    mod:set("weapon_customization_entries", entries)
end

SaveLua._read_file = function(self, path)
	local file = assert(_io.open(path, "r"))
	if not file then return nil end
	local content = file:read("*all")
	file:close()
	return content
end

-- ##### ┬  ┌─┐┌─┐┌┬┐ #################################################################################################
-- ##### │  │ │├─┤ ││ #################################################################################################
-- ##### ┴─┘└─┘┴ ┴─┴┘ #################################################################################################

SaveLua._load_entry = function(self, path)
	local file_string = self:_read_file(path)
	local loaded_function = file_string and _loadstring(file_string)
	-- Debug
	self:debug(path, "File loaded: ")
	return loaded_function and type(loaded_function) == "function" and loaded_function()
end

-- ##### ┌─┐┌─┐┬  ┬┌─┐ ################################################################################################
-- ##### └─┐├─┤└┐┌┘├┤  ################################################################################################
-- ##### └─┘┴ ┴ └┘ └─┘ ################################################################################################

SaveLua._save_entry = function(self, data)

	-- Infos
	local unit_good = data.unit and unit_alive(data.unit)
	local node = data.node or 1
	local previous = nil

	-- Create appdata folder
	self:_create_directory()

	-- Create entry path
	local path, file_name = self:_create_entry_path(data)
	
	-- Load previous entry
	if self:_file_exists(path) then
		previous = self.gear_settings:get_cache(data.item) or self:_load_entry(path)
	end

	-- Open file
	local file = assert(_io.open(path, "w+"))

	-- Stuff
	local tt = "	"
	local ttt = tt..tt

	-- Write lines
	file:write("return {\n")
	if data.item then
		-- Attachments
		local gear_settings = self.gear_settings
		local attachments = data.attachments or gear_settings:attachments(data.item)
		if attachments then
			file:write(tt.."attachments = {\n")
			for attachment_slot, attachment_name in pairs(attachments) do
				file:write(ttt..tostring(attachment_slot).." = '"..tostring(attachment_name).."',\n")
			end
			local gear_node = data.gear_node or gear_settings:get(data.item, "gear_node")
			gear_node = gear_node and "'"..tostring(gear_node).."'"
			file:write(ttt.."gear_node = "..tostring(gear_node or "nil")..",\n")
			file:write(tt.."},\n")
		end
	end
	file:write("}")

	-- Close file
	file:close()

	-- Load new entry
	local new_entry = self:_load_entry(path)

	-- Add to cache
	local cache = self:_get_entries_cache()
	if not cache or type(cache) ~= "table" then cache = {} end
	if not table_contains(cache, file_name) then
		cache[#cache+1] = file_name
		self:_set_cache(cache)
	end

	-- Debug
	self:debug(file_name, "File saved: ")

	-- Save user settings
    Application.save_user_settings()

	-- Return
	return new_entry

end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

SaveLua._cast_vector3_to_string = function(self, vector)
	local str = tostring(vector)
	if not mod:cached_find(str, "Vector3Box") then
		str = mod:cached_gsub(str, "Vector3", "Vector3Box")
	end
	return str
end

SaveLua._cast_quaternion_to_string = function(self, quaternion)
	return mod:cached_gsub(tostring(quaternion), "Vector4", "QuaternionBox")
end

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

SaveLua.save_entry = function(self, data)
	if data and data.item then
		return self:_save_entry(data)
	end
end

SaveLua.delete_entry = function(self, data)
	local path, file_name = self:_create_entry_path(data)
	if self:_file_exists(path) then
		if _os.remove(path) then
			-- Remove from cache
			local cache = self:_get_entries_cache()
			local new_cache = {}
			for _, c in pairs(cache) do
				if c ~= file_name then
					new_cache[#new_cache+1] = c
				end
			end
			self:_set_cache(new_cache)
			return true
		end
	end
end

SaveLua.load_entry = function(self, gear_id)
	if gear_id then
		-- Load file
		local path = self:_appdata_path()..tostring(gear_id)..".lua"
		if self:_file_exists(path) then
			return self:_load_entry(path)
		end
	end
end

return SaveLua