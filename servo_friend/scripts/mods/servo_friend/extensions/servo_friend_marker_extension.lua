local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local class = class
local CLASS = CLASS
local tostring = tostring
local managers = Managers
local math_random = math.random

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendMarkerExtension = class("ServoFriendMarkerExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendMarkerExtension", "servo_friend_marker_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendMarkerExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendMarkerExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.event_manager = managers.event
    -- Events
    self.event_manager:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    self.event_manager:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    self.event_manager:register(self, "servo_friend_world_marker_created", "on_servo_friend_world_marker_created")
    self.event_manager:register(self, "servo_friend_world_marker_destroyed", "on_servo_friend_world_marker_destroyed")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendMarkerExtension initialized")
end

ServoFriendMarkerExtension.destroy = function(self)
    -- Events
    self.event_manager:unregister(self, "servo_friend_spawned")
    self.event_manager:unregister(self, "servo_friend_destroyed")
    self.event_manager:unregister(self, "servo_friend_world_marker_created")
    self.event_manager:unregister(self, "servo_friend_world_marker_destroyed")
    -- Debug
    self:print("ServoFriendMarkerExtension destroyed")
    -- Base class
    ServoFriendMarkerExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendMarkerExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendMarkerExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendMarkerExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendMarkerExtension.super.on_settings_changed(self)
    -- Settings
    self.focus_world_markers = self.servo_friend_extension.focus_world_markers
    self.only_own_tags       = self.servo_friend_extension.only_own_tags
end

ServoFriendMarkerExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendMarkerExtension.super.on_servo_friend_spawned(self)
    end
end

ServoFriendMarkerExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendMarkerExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

ServoFriendMarkerExtension.on_servo_friend_world_marker_created = function(self, marker)
    local own = not self.only_own_tags or self:is_owned(marker)
    if self.focus_world_markers and own then
        self.event_manager:trigger("servo_friend_point_of_interest_created", marker, "marker")
    end
end

ServoFriendMarkerExtension.on_servo_friend_world_marker_destroyed = function(self, marker)
    self.event_manager:trigger("servo_friend_point_of_interest_removed", marker)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendMarkerExtension.is_owned = function(self, marker)
    return marker and marker.data and marker.data.is_my_tag
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.HudElementWorldMarkers, "event_add_world_marker_position", function(func, self, marker_type, world_position, callback, data, ...)
    -- Original function
    func(self, marker_type, world_position, callback, data, ...)
    -- Marker
    local marker = self._markers[#self._markers]
    if marker then
        mod:print("add marker "..tostring(marker.id))
        managers.event:trigger("servo_friend_world_marker_created", marker, "marker")
    end
end)

mod:hook(CLASS.HudElementWorldMarkers, "event_remove_world_marker", function(func, self, id, ...)
    -- Marker
    local marker = self._markers_by_id[id]
    if marker then
        mod:print("remove marker "..tostring(id))
        managers.event:trigger("servo_friend_world_marker_destroyed", marker)
    end
    -- Original function
    func(self, id, ...)
end)

return ServoFriendMarkerExtension