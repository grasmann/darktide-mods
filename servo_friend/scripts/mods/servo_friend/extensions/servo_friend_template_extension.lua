local mod = get_mod("servo_friend")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local managers = Managers

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendTemplateExtension = class("ServoFriendTemplateExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendTemplateExtension", "servo_friend_template_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendTemplateExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendTemplateExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Events
    managers.event:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    managers.event:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Settings
    self:on_settings_changed()
end

ServoFriendTemplateExtension.destroy = function(self)
    -- Events
    managers.event:unregister(self, "servo_friend_spawned")
    managers.event:unregister(self, "servo_friend_destroyed")
    -- Base class
    ServoFriendTemplateExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendTemplateExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendTemplateExtension.super.update(self, dt, t)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendTemplateExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendTemplateExtension.super.on_settings_changed(self)
end

ServoFriendTemplateExtension.on_servo_friend_spawned = function(self)
    -- Base class
    ServoFriendTemplateExtension.super.on_servo_friend_spawned(self)
end

ServoFriendTemplateExtension.on_servo_friend_destroyed = function(self)
    -- Base class
    ServoFriendTemplateExtension.super.on_servo_friend_destroyed(self)
end

return ServoFriendTemplateExtension