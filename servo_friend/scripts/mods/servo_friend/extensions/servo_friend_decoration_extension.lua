-- File: servo_friend/scripts/mods/servo_friend/extensions/servo_friend_decoration_extension.lua
local mod = get_mod("servo_friend")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local type = type
local unit = Unit
local table = table
local world = World
local class = class
local vector3 = Vector3
local quaternion = Quaternion
local unit_node = unit.node
local unit_alive = unit.alive
local unit_has_node = unit.has_node
local table_clear = table.clear
local world_link_unit = world.link_unit
local world_unlink_unit = world.unlink_unit
local world_spawn_unit_ex = world.spawn_unit_ex
local world_destroy_unit = world.destroy_unit
local unit_set_local_scale = unit.set_local_scale
local unit_set_unit_visibility = unit.set_unit_visibility
local unit_set_local_position = unit.set_local_position
local unit_set_local_rotation = unit.set_local_rotation
local quaternion_from_euler_angles_xyz = quaternion.from_euler_angles_xyz

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local function _vector3_from_table(values, default_x, default_y, default_z)
    if type(values) == "table" then
        return vector3(
            values[1] or values.x or default_x or 0,
            values[2] or values.y or default_y or 0,
            values[3] or values.z or default_z or 0
        )
    end

    return vector3(default_x or 0, default_y or 0, default_z or 0)
end

local function _rotation_from_table(values, fallback_z)
    if type(values) == "table" then
        return quaternion_from_euler_angles_xyz(
            values[1] or values.x or 0,
            values[2] or values.y or 0,
            values[3] or values.z or 0
        )
    end

    return quaternion_from_euler_angles_xyz(0, 0, fallback_z or 0)
end

local function _node_index(parent_unit, node)
    if type(node) == "number" then
        return node
    end

    if type(node) == "string" and unit_has_node(parent_unit, node) then
        return unit_node(parent_unit, node)
    end

    return 1
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendDecorationExtension = class("ServoFriendDecorationExtension", "ServoFriendBaseExtension")

mod:register_extension("ServoFriendDecorationExtension", "servo_friend_decoration_system")

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendDecorationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendDecorationExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.initialized = true
    self.show_decorations = false
    self.decorations_to_spawn = {}
    self.spawned_decorations = {}
    -- Debug
    self:print("ServoFriendDecorationExtension initialized")
    -- Settings
    self:on_settings_changed()
end

ServoFriendDecorationExtension.destroy = function(self)
    self.initialized = false
    -- Destroy
    self:destroy_decorations()
    -- Debug
    self:print("ServoFriendDecorationExtension destroyed")
    -- Base class
    ServoFriendDecorationExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendDecorationExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendDecorationExtension.super.update(self, dt, t)
end

ServoFriendDecorationExtension.appearance_definition = function(self)
    local extension = self:extension_valid(self.servo_friend_extension) and self.servo_friend_extension or nil
    local appearance_name = extension and extension.appearance or nil

    if type(appearance_name) ~= "string" or appearance_name == "" or appearance_name == "off" then
        return nil
    end

    return mod:servo_friend_get_appearance_definition(appearance_name)
end

ServoFriendDecorationExtension.refresh_decoration_definitions = function(self)
    local appearance_definition = self:appearance_definition()

    table_clear(self.decorations_to_spawn)

    if appearance_definition and type(appearance_definition.decorations) == "table" then
        local decorations = appearance_definition.decorations

        for i = 1, #decorations do
            local decoration = decorations[i]

            if type(decoration) == "table" and type(decoration.unit) == "string" and decoration.unit ~= "" then
                self.decorations_to_spawn[#self.decorations_to_spawn + 1] = decoration
            end
        end
    end

    self.show_decorations = #self.decorations_to_spawn > 0
end

ServoFriendDecorationExtension.respawn_decorations = function(self)
    self:destroy_decorations()
    self:spawn_decorations()
end

ServoFriendDecorationExtension.spawn_decorations = function(self)
    if not self:is_initialized()
        or not self.show_decorations
        or not self.decorations_to_spawn
        or #self.decorations_to_spawn <= 0
        or not self:player_unit_alive()
        or not self:servo_friend_alive()
    then
        return
    end

    if self.spawned_decorations and #self.spawned_decorations > 0 then
        return
    end

    for i = 1, #self.decorations_to_spawn do
        local decoration = self.decorations_to_spawn[i]
        local unit_name = decoration and decoration.unit or nil

        if type(unit_name) == "string" and unit_name ~= "" then
            local decoration_unit = world_spawn_unit_ex(self._world, unit_name)

            if decoration_unit and unit_alive(decoration_unit) then
                local parent_node_index = _node_index(self.servo_friend_unit, decoration.parent_node)
                local offset = _vector3_from_table(decoration.offset, 0, 0, 0)
                local rotation = _rotation_from_table(decoration.rotation, decoration.rotation_z)

                world_link_unit(self._world, decoration_unit, 1, self.servo_friend_unit, parent_node_index)
                unit_set_local_position(decoration_unit, 1, offset)
                unit_set_local_rotation(decoration_unit, 1, rotation)

                if decoration.scale then
                    unit_set_local_scale(decoration_unit, 1, _vector3_from_table(decoration.scale, 1, 1, 1))
                end

                unit_set_unit_visibility(decoration_unit, decoration.visible ~= false)

                self.spawned_decorations[#self.spawned_decorations + 1] = {
                    unit = decoration_unit,
                }
            end
        end
    end
end

ServoFriendDecorationExtension.destroy_decorations = function(self)
    if self.spawned_decorations and #self.spawned_decorations > 0 then
        for i = 1, #self.spawned_decorations do
            local decoration_data = self.spawned_decorations[i]
            local decoration_unit = decoration_data and decoration_data.unit or nil

            if decoration_unit and unit_alive(decoration_unit) then
                world_unlink_unit(self._world, decoration_unit)
                world_destroy_unit(self._world, decoration_unit)
            end
        end
    end

    table_clear(self.spawned_decorations)
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendDecorationExtension.on_settings_changed = function(self, setting_id)
    -- Base class
    ServoFriendDecorationExtension.super.on_settings_changed(self, setting_id)
    -- Decorations
    self:refresh_decoration_definitions()
    -- Respawn
    self:respawn_decorations()
end

ServoFriendDecorationExtension.on_servo_friend_spawned = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Base class
        ServoFriendDecorationExtension.super.on_servo_friend_spawned(self, servo_friend_unit, player_unit)
        -- Spawn
        self:spawn_decorations()
    end
end

ServoFriendDecorationExtension.on_servo_friend_destroyed = function(self, servo_friend_unit, player_unit)
    if self:is_me(servo_friend_unit) then
        -- Destroy
        self:destroy_decorations()
        -- Base class
        ServoFriendDecorationExtension.super.on_servo_friend_destroyed(self, servo_friend_unit, player_unit)
    end
end

return ServoFriendDecorationExtension
