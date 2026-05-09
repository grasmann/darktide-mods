local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local type = type
local table = table
local pairs = pairs
local vector3 = Vector3
local managers = Managers
local script_unit = ScriptUnit
local table_clear = table.clear
local vector3_zero = vector3.zero
local unit_world_position = unit.world_position
local script_unit_has_extension = script_unit.has_extension
local script_unit_add_extension = script_unit.add_extension
local script_unit_remove_extension = script_unit.remove_extension

-- ##### ┌─┐─┐ ┬┬┌─┐┌┬┐┬┌┐┌┌─┐  ┌─┐┬  ┌─┐┬ ┬┌─┐┬─┐┌─┐ #################################################################
-- ##### ├┤ ┌┴┬┘│└─┐ │ │││││ ┬  ├─┘│  ├─┤└┬┘├┤ ├┬┘└─┐ #################################################################
-- ##### └─┘┴ └─┴└─┘ ┴ ┴┘└┘└─┘  ┴  ┴─┘┴ ┴ ┴ └─┘┴└─└─┘ #################################################################

mod.player_unit_from_player = function(self, player)
    return player and self:is_unit_alive(player.player_unit) and player.player_unit
end

-- Get local player unit
mod.local_player_unit = function(self)
    -- Get local player
    local player = managers.player and managers.player:local_player_safe(1)
    -- Return player unit
    return self:player_unit_from_player(player)
end

mod.local_player_position = function(self)
    -- Get local player
    local player_unit = self:local_player_unit()
    -- Return player position
    return player_unit and unit_world_position(player_unit, 1) or vector3_zero()
end

-- Wrap unit to first person extension
mod.unit_to_first_person_extension_wrapper = function(self, unit_or_extension)
    -- Check if unit
    if type(unit_or_extension) == "userdata" and self:is_unit_alive(unit_or_extension) then
        -- Get and return first person extension
        return script_unit_has_extension(unit_or_extension, "first_person_system")
    end
    -- Return original
    return unit_or_extension
end

-- Initialize player unit
mod.initialize_player_unit = function(self, first_person_extension)
    local pt = self:pt()
    self:print("Initialize player unit")
    -- Get first person extension
    first_person_extension = self:unit_to_first_person_extension_wrapper(first_person_extension)
    -- Check if first person extension is valid and unit is not already initialized
    if self:extension_valid(first_person_extension) and
        not pt.player_unit_extensions[first_person_extension._unit] and
        not script_unit_has_extension(first_person_extension._unit, "player_unit_servo_friend_system") then
        -- Check if distribution is satisfied
        if self:distribution_satisfied(first_person_extension._unit) then
            -- Add player unit extension
            pt.player_unit_extensions[first_person_extension._unit] = script_unit_add_extension({},
                first_person_extension._unit, "PlayerUnitServoFriendExtension", "player_unit_servo_friend_system", {
                    is_local_unit = first_person_extension._is_local_unit,
                })
            -- Return player unit extension
            return pt.player_unit_extensions[first_person_extension._unit]
        end
    end
end

-- Destroy player unit
mod.destroy_player_unit = function(self, unit)
    local pt = self:pt()
    -- Check if first person extension is valid and unit is initialized
    if pt.player_unit_extensions[unit] then
        -- Destroy player unit extension
        if self:extension_valid(pt.player_unit_extensions[unit]) then
            pt.player_unit_extensions[unit]:destroy()
        end

        if type(unit) == "userdata" then
            script_unit_remove_extension(unit, "player_unit_servo_friend_system")
        end

        -- Remove player unit extension
        pt.player_unit_extensions[unit] = nil
    end
end

-- Update player unit
mod.update_player_unit = function(self, first_person_extension, dt, t)
    local pt = self:pt()
    -- Get first person extension
    first_person_extension = self:unit_to_first_person_extension_wrapper(first_person_extension)
    -- Check if first person extension is valid and unit is initialized
    if self:extension_valid(first_person_extension) and pt.player_unit_extensions[first_person_extension._unit] then
        -- Update player unit extension
        pt.player_unit_extensions[first_person_extension._unit]:update(dt, t)
    end
end

-- Check servo_friend distribution
mod.distribution_satisfied = function(self, player_unit)
    local me = player_unit == self:local_player_unit()
    local everyone = self.distribution == "everyone"
    local one_more = self.distribution == "one" and self:existing_other_players_count() < 1
    local two_more = self.distribution == "two" and self:existing_other_players_count() < 2

    return me or everyone or one_more or two_more
end

-- Count of existing players who have a servo_friend
mod.existing_other_players_count = function(self)
    local count = 0
    local pt = self:pt()
    local local_player_unit = self:local_player_unit()

    -- Iterate existing players who have a servo_friend
    for unit, extension in pairs(pt.player_unit_extensions) do
        -- Check player unit and not local player
        if self:is_unit_alive(unit) and unit ~= local_player_unit then
            count = count + 1
        end
    end

    return count
end

-- Get real players
mod.real_players = function(self)
    local player_manager = managers.player

    if not player_manager then
        return {}
    end

    local players = player_manager:players()

    if players then
        for _, player in pairs(players) do
            if player then
                return players
            end
        end
    end

    local local_player = player_manager:local_player_safe(1)

    return local_player and { local_player } or {}
end

-- Initialize existing real players
mod.initialize_existing_players = function(self)
    -- Get real players
    local players = self:real_players()

    -- Iterate players and initialize
    for _, player in pairs(players) do
        local player_unit = self:player_unit_from_player(player)

        if player_unit then
            self:initialize_player_unit(player_unit)
        end
    end
end

-- Destroy existing players who have a servo_friend
mod.destroy_existing_players = function(self)
    local pt = self:pt()
    local units_to_destroy = {}

    -- Collect first so we do not mutate while iterating
    for unit, extension in pairs(pt.player_unit_extensions) do
        units_to_destroy[#units_to_destroy + 1] = unit
    end

    for i = 1, #units_to_destroy do
        self:destroy_player_unit(units_to_destroy[i])
    end

    table_clear(pt.player_unit_extensions)
end

-- Relay settings changed to existing players who have a servo_friend
mod.settings_changed_existing_players = function(self, setting_id)
    local pt = self:pt()
    -- Iterate existing players who have a servo_friend
    for unit, extension in pairs(pt.player_unit_extensions) do
        if self:extension_valid(extension) then
            extension:on_settings_changed(setting_id)
        end
    end
end
