local mod = get_mod("weapon_customization")
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

local _loadstring = Mods.lua.loadstring
local _loadfile = Mods.lua.loadfile

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

mod.appdata_path = function(self, data)
	local appdata = _os.getenv('APPDATA')
	local type = data.type or "visible_equipment"
	return appdata.."/Fatshark/Darktide/weapon_customization/"..type.."/"
end

mod.create_weapon_customization_directory = function(self, data)
	local path = self:appdata_path(data)
	if not isdir(path) then
		_os.execute('mkdir '..path) -- ?
		_os.execute("mkdir '"..path.."'") -- ?
		_os.execute('mkdir "'..path..'"') -- Windows
	end
end

mod.create_weapon_customization_entry_path = function(self, data)
	-- local date = _os.time(_os.date("!*t"))
	local weapon_name = mod:item_name_from_content_string(data.item.name)
	-- local character_name = data.player:profile().name
	local file_name = tostring(weapon_name)..".lua"
	return self:appdata_path(data)..file_name, file_name
end

-- ##### ┌─┐┌┐┌┌┬┐┬─┐┬┌─┐┌─┐ ##########################################################################################
-- ##### ├┤ │││ │ ├┬┘│├┤ └─┐ ##########################################################################################
-- ##### └─┘┘└┘ ┴ ┴└─┴└─┘└─┘ ##########################################################################################

mod.get_weapon_customization_entries = function(self, data, scan_dir)

	-- Lua implementation of PHP scandir function
	local function scandir(directory)
		local i, t, popen = 0, {}, _io.popen
		local pfile = popen('dir "'..directory..'" /b')
		for filename in pfile:lines() do
			i = i + 1
			t[i] = filename
		end
		pfile:close()
		local text = self:localize("weapon_customization_cached")
    	self:echo(text)
		return t
	end

	local entries = {}
	local appdata = self:appdata_path(data)
    local cache = self:get_weapon_customization_entries_cache(data)
	local files = cache
	if scan_dir or not cache then
		files = scandir(appdata)
		self:set_weapon_customization_entries_cache(data, files)
	end
	local missing_file = false
	for _, file in pairs(files) do
		local file_path = appdata..file
		if file_exists(file_path) then
			-- local date_str = string.sub(file, 1, string.len(file) - 4)
			local entry = self:load_weapon_customization_entry(file_path)
			entry.file = file
			entry.file_path = file_path
			-- entry.date = _os.date("%Y-%m-%d %H:%M:%S", tonumber(date_str))
			entries[#entries+1] = entry
		else
			missing_file = true
		end
	end

	if missing_file then
		entries = self:get_weapon_customization_entries(data, true)
	end

	return entries
end

mod.get_weapon_customization_entries_cache = function(self, data)
	local type = data.type or "visible_equipment"
    return self:get("weapon_customization_"..type.."_entries")
end

mod.set_weapon_customization_entries_cache = function(self, data, entries)
	local type = data.type or "visible_equipment"
    self:set("weapon_customization_"..type.."_entries", entries)
end

-- ##### ┌─┐┌─┐┬  ┬┌─┐  ┬  ┌─┐┌─┐┌┬┐  ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ ##############################################################
-- ##### └─┐├─┤└┐┌┘├┤───│  │ │├─┤ ││───││├┤ │  ├┤  │ ├┤  ##############################################################
-- ##### └─┘┴ ┴ └┘ └─┘  ┴─┘└─┘┴ ┴─┴┘  ─┴┘└─┘┴─┘└─┘ ┴ └─┘ ##############################################################

mod.delete_weapon_customization_entry = function(self, data, file_name)
	local file_path = self:appdata_path(data)..file_name
	if file_exists(file_path) then
		-- self:echo(file_path)
		if _os.remove(file_path) then
			-- Remove from cache
			local cache = mod:get_weapon_customization_entries_cache(data)
			local new_cache = {}
			for _, c in pairs(cache) do
				if c ~= file_name then
					new_cache[#new_cache+1] = c
				end
			end
			mod:set_weapon_customization_entries_cache(data, new_cache)
			return true
		end
	end
end

mod.save_weapon_customization_entry = function(self, data)
	
	-- Create appdata folder
	self:create_weapon_customization_directory(data)


	local path, file_name = self:create_weapon_customization_entry_path(data)

	-- Open file
	local file = assert(_io.open(path, "w+"))

	-- Offset
	local position_offset = Unit.get_data(data.unit, "unit_manipulation_position_offset")
	position_offset = position_offset and Vector3Box.unbox(position_offset) or Unit.local_position(data.unit, data.node or 1)
	local rotation_offset = Unit.get_data(data.unit, "unit_manipulation_rotation_offset")
	rotation_offset = rotation_offset and QuaternionBox.unbox(rotation_offset) or Unit.local_rotation(data.unit, data.node or 1)
	local scale_offset = Unit.get_data(data.unit, "unit_manipulation_scale_offset")
	scale_offset = scale_offset and Vector3Box.unbox(scale_offset) or Unit.local_scale(data.unit, data.node or 1)

	-- Write lines
	file:write("return {\n")
	file:write("position_offset = "..tostring(position_offset)..",\n")
	file:write("rotation_offset = "..tostring(rotation_offset)..",\n")
	file:write("scale_offset = "..tostring(scale_offset)..",\n")
	file:write("node = "..tostring(data.node or 1)..",\n")
	file:write("}\n")

	-- Close file
	file:close()

	self:load_weapon_customization_entry(path)

	-- -- Add to cache
	-- local cache = mod:get_weapon_customization_entries_cache(data)
	-- if not cache or type(cache) ~= "table" then cache = {} end
	-- cache[#cache+1] = file_name
	-- mod:set_weapon_customization_entries_cache(data, cache)
end

mod.load_weapon_customization_entry = function(self, path)

	local function read_file(path)
		local file = assert(_io.open(path, "rb"))
		if not file then return nil end
		local content = file:read("*all")
		file:close()
		return content
	end

	local file_string = read_file(path)
	file_string = file_string and string.gsub(file_string, "Vector3", "Vector3Box")
	file_string = file_string and string.gsub(file_string, "Vector4", "QuaternionBox")
	local loaded_function = file_string and _loadstring(file_string)
	local result = loaded_function and loaded_function()
	if result then
		mod:dtf(result, "result", 10)
	end
end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod.current_date = function(self)
    return _os.time(_os.date("*t"))
end
