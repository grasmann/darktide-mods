local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local class = class
local managers = Managers
local math_random = math.random

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendTagExtension = class("ServoFriendTagExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendTagExtension", "servo_friend_tag_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendTagExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendTagExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Events
    managers.event:register(self, "event_smart_tag_created", "event_smart_tag_created")
    managers.event:register(self, "event_smart_tag_removed", "event_smart_tag_removed")
    -- managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    -- managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Settings
    self:on_settings_changed()
    -- Debug
    self:print("ServoFriendTagExtension initialized")
end

ServoFriendTagExtension.destroy = function(self)
    -- Events
    managers.event:unregister(self, "event_smart_tag_created")
    managers.event:unregister(self, "event_smart_tag_removed")
    -- managers.event:unregister(self, "servo_friend_spawned")
    -- managers.event:unregister(self, "servo_friend_destroyed")
    -- Debug
    self:print("ServoFriendTagExtension destroyed")
    -- Base class
    ServoFriendTagExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendTagExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendTagExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendTagExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendTagExtension.super.on_settings_changed(self)
    -- Settings
    self.focus_tagged_enemies = self.servo_friend_extension.focus_tagged_enemies
    self.focus_tagged_items   = self.servo_friend_extension.focus_tagged_items
    self.only_own_tags        = self.servo_friend_extension.only_own_tags
end

ServoFriendTagExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendTagExtension.super.on_servo_friend_spawned(self)
    end
end

ServoFriendTagExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendTagExtension.super.on_servo_friend_destroyed(self)
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

ServoFriendTagExtension.event_smart_tag_created = function(self, tag)
    self:print("Smart tag created")
    local enemy = self.focus_tagged_enemies and self:is_enemy(tag)
    local item = self.focus_tagged_items and self:is_item(tag)
    local own = not self.only_own_tags or self:is_owned(tag)
    local daemonhost = not self:is_daemonhost(tag)
    if own and (enemy or item) and daemonhost then
        local tag_type = self:type(tag)
        managers.event:trigger("servo_friend_point_of_interest_created", tag, tag_type)
    end
end

ServoFriendTagExtension.event_smart_tag_removed = function(self, tag)
    self:print("Smart tag removed")
    managers.event:trigger("servo_friend_point_of_interest_removed", tag)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

ServoFriendTagExtension.type = function(self, tag)
    if self:is_enemy(tag) then return "tag_enemy" end
    return "tag"
end

ServoFriendTagExtension.is_daemonhost = function(self, tag)
    return tag and tag._breed and tag._breed.name == "chaos_daemonhost"
end

ServoFriendTagExtension.is_enemy = function(self, tag)
    return tag and tag._breed
end

ServoFriendTagExtension.is_item = function(self, tag)
    return tag and not tag._breed
end

ServoFriendTagExtension.is_owned = function(self, tag)
    return self.player_unit and tag and tag._tagger_unit == self.player_unit
end

return ServoFriendTagExtension