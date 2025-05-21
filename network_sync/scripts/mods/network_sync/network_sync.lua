local mod = get_mod("network_sync")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local CLASS = CLASS
local tostring = tostring
local managers = Managers
local callback = callback

-- ##### ┌┬┐┌┬┐┌─┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ###############################################################################
-- #####  │││││├┤   ├┤ └┐┌┘├┤ │││ │ └─┐ ###############################################################################
-- ##### ─┴┘┴ ┴└    └─┘ └┘ └─┘┘└┘ ┴ └─┘ ###############################################################################

mod.on_all_mods_loaded = function()
    
end

mod.on_unload = function(exit_game)
    
end

mod.on_setting_changed = function(setting_id)
    
end

mod.on_game_state_changed = function(status, state_name)
    if status == "enter" then
        mod:init()
    elseif status == "exit" then
        mod:deinit()
    end
end

-- Get local player unit
mod.local_player_peer_id = function(self)
    -- Get local player
    local player = managers.player and managers.player:local_player_safe(1)
    -- Return player unit
    return player and player:peer_id()
end

local Promise = require("scripts/foundation/utilities/promise")
local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")

mod.url_command = function(self, command)
   
    -- http://darktidenetwork.byethost24.com/session/register_session.php?session_id=e29e25fc-366b-4500-96b2-c3db4e85d5c3&peer_id=79d8683ba72d9a54

    command = "register_session"

    local session_id = self.session_id
    local peer_id = self.peer_id

    if not session_id or not peer_id then return end

    -- local url = "http://darktidenetwork.byethost24.com/session/"..command..".php?session_id="..session_id.."&peer_id="..peer_id

    local url = BackendUtilities.url_builder("http://darktidenetwork.byethost24.com/session/register_session.php")
		:query("session_id", session_id)
		:query("peer_id", peer_id)
		:to_string()

    -- mod:dtf({url = url}, "url", 3)

    -- url = string.gsub(url, "%command%", command)
    -- url = string.gsub(url, "%session_id%", session_id)
    -- url = string.gsub(url, "%peer_id%", peer_id)

    -- local result = managers.url_loader:load_texture(url):catch(function(error)
		
	-- end)

    self:echo("URL: "..tostring(url))

    -- return managers.backend:url_request(url, {
	-- 	require_auth = false,
	-- }):next(callback(self, "on_url_request_success", url), callback(self, "on_url_request_error", url))

    -- local promise = Promise:new()
    -- local operation_identifier, error = managers.backend:url_request(url, {
    --     require_auth = false,
    --     -- method = "GET",
    -- })

    managers.backend:url_request(url, {
        method = "POST",
        headers = {
            ["Cookie"] = "__test=d05f9a8a3bf1eace152196add36e3cb6; max-age=21600; expires=Thu, 31-Dec-37 23:55:55 GMT; path=/",
        },
    })
    :next(function (v)
		-- _check_response_time(url, v)
        -- callback(self, "on_url_request_success", url, v)()
        mod:echo("Success - "..tostring(v))
	end):catch(function (e)
		-- _check_response_time(url, e)
        -- callback(self, "on_url_request_error", url, e)()
        mod:echo("Error - "..tostring(e))
	end)

    -- return promise

    -- return promise

    -- return managers.backend:url_request("http://darktidenetwork.byethost24.com/", {
	-- 	method = "GET",
	-- 	body = { command = "register_session?session_id="..session_id.."&peer_id="..peer_id },
	-- })
    -- :next(function(response)
    --     mod:echo("Success - "..tostring(response))
    -- end)
    -- :catch(function(error)
    --     mod:echo("Error - "..tostring(error))
    -- end)

    -- return managers.backend
	-- 	:url_request(url)
	-- 	:next(function(response)
	-- 		mod:echo("Success - "..tostring(response))
	-- 	end)
	-- 	:catch(function(error)
	-- 		mod:echo("Error - "..tostring(error))
	-- 	end)

    -- return managers.backend:url_request(run_endpoint, {
    --         method = "POST",
    --         body = { command = command },
    --     })
    --     :next(function(response)
	-- 		mod:echo("Success - "..tostring(response))
	-- 	end)
	-- 	:catch(function(error)
	-- 		mod:echo("Error - "..tostring(error))
	-- 	end)
    

end

-- mod:hook(CLASS.BackendManager, "url_request", function(func, self, url, options, ...)
--     mod:echo("URL: "..tostring(url))
--     return func(self, url, options, ...)
-- end)

mod.on_url_request_success = function(self, url, result_data)
    mod:echo("Success - "..tostring(result_data))
end

mod.on_url_request_error = function(self, url, result_data)
    mod:echo("Error - "..tostring(result_data))
end

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

mod.init = function(self)
    -- New session
    self.session_id = managers.connection:session_id()
    self:echo("Session ID: "..tostring(self.session_id))
    self.peer_id = self:local_player_peer_id()
    self:echo("Peer ID: "..tostring(self.peer_id))

    self:url_command("register_session")
end

mod.deinit = function(self)
    -- Destroy session
    self:url_command("destroy_session")
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod.update = function()
    -- local dt, t = mod:delta_time(), mod:time()
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.is_in_hub = function(self)
	local game_mode_name = managers.state.game_mode:game_mode_name()
	local is_in_hub = game_mode_name == "hub"
	return is_in_hub
end

-- ##### ┌┬┐┬┌┬┐┌─┐ ###################################################################################################
-- #####  │ ││││├┤  ###################################################################################################
-- #####  ┴ ┴┴ ┴└─┘ ###################################################################################################

mod.has_timer = function(self, timer)
    return self.time_manager and self.time_manager:has_timer(timer)
end

mod.main_time = function(self)
	return self.time_manager and self.time_manager:time("main")
end

mod.game_time = function(self)
	return self.time_manager and self:has_timer("gameplay") and self.time_manager:time("gameplay")
end

mod.time = function(self)
    return self:game_time() or self:main_time()
end

mod.main_delta_time = function(self)
    return self.time_manager and self.time_manager:delta_time("main")
end

mod.game_delta_time = function(self)
    return self.time_manager and self:has_timer("gameplay") and self.time_manager:delta_time("gameplay")
end

mod.delta_time = function(self)
    return self:game_delta_time() or self:main_delta_time()
end


mod:hook(CLASS.MultiplayerSession, "client_joined", function(func, self, channel_id, peer_id, player_sync_data, ...)
    -- Original function
    func(self, channel_id, peer_id, player_sync_data, ...)

    mod:echo("Client joined "..tostring(peer_id))
end)

mod:hook(CLASS.MultiplayerSession, "client_disconnected", function(func, self, channel_id, peer_id, game_reason, engine_reason, host_became_empty, ...)
    -- Original function
    func(self, channel_id, peer_id, game_reason, engine_reason, host_became_empty, ...)

    mod:echo("Client disconnected "..tostring(peer_id))
end)