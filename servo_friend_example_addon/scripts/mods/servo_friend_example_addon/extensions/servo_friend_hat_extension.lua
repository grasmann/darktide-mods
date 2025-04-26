local mod = get_mod("servo_friend_example_addon")
local servo_friend = get_mod("servo_friend")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")
local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local unit = Unit
local pairs = pairs
local world = World
local class = class
local vector3 = Vector3
local managers = Managers
local unit_node = unit.node
local quaternion = Quaternion
local unit_alive = unit.alive
local script_unit = ScriptUnit
local vector3_zero = vector3.zero
local unit_has_node = unit.has_node
local world_link_unit = world.link_unit
local world_unlink_unit = world.unlink_unit
local world_destroy_unit = world.destroy_unit
local quaternion_identity = quaternion.identity
local script_unit_extension = script_unit.extension
local unit_set_local_position = unit.set_local_position
local unit_set_local_rotation = unit.set_local_rotation
local unit_set_unit_visibility = unit.set_unit_visibility
local script_unit_has_extension = script_unit.has_extension
local unit_set_scalar_for_materials = unit.set_scalar_for_materials
local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local hat_item = "content/items/characters/player/human/gear_head/zealot_career_02_lvl_05_headgear_set_03"
local packages_to_load = {
    "content/characters/tiling_materials/leather_03/leather_03_nm",
    "content/characters/tiling_materials/leather_03/leather_03_bc",
    "content/characters/tiling_materials/linnen_burlap_irregular/linnen_burlap_irregular_nm",
    "content/textures/colors/3_colour_forest_03",
    "content/characters/player/human/third_person/base_gear_rig",
    "content/characters/tiling_materials/linnen_burlap_irregular/linnen_burlap_irregular_orm",
    "content/textures/camo_patterns/camo_29",
    "content/characters/tiling_materials/linnen_burlap_irregular/linnen_burlap_irregular_bc",
    "content/characters/tiling_materials/leather_03/leather_03_orm",
    "content/characters/player/human/attachments_gear/headgear/necromunda_01/necromunda_01_a_goggles_bigger",
    "content/characters/player/human/attachments_gear/headgear/leather_face_cover_a/leather_face_cover_a_bigger",
    "content/characters/player/human/attachments_gear/headgear/necromunda_01/necromunda_01_a_mask_tight",
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendHatExtension = class("ServoFriendHatExtension", "ServoFriendBaseExtension")

servo_friend:register_extension("ServoFriendHatExtension", "servo_friend_hat_system")
servo_friend:register_packages(packages_to_load)

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendHatExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendHatExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.initialized = true
    self.event_manager = managers.event
    self.base_unit = nil
    self.attachment_units = nil
    -- Events
    self.event_manager:register(self, "servo_friend_settings_changed", "on_settings_changed")
    self.event_manager:register(self, "servo_friend_example_addon_settings_changed", "on_settings_changed")
    self.event_manager:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    self.event_manager:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Debug
    self:print("ServoFriendHatExtension initialized")
    -- Settings
    self:on_settings_changed()
end

ServoFriendHatExtension.destroy = function(self)
    self.initialized = false
    -- Events
    self.event_manager:unregister(self, "servo_friend_settings_changed")
    self.event_manager:unregister(self, "servo_friend_example_addon_settings_changed")
    self.event_manager:unregister(self, "servo_friend_spawned")
    self.event_manager:unregister(self, "servo_friend_destroyed")
    -- Destroy
    self:destroy_hat()
    -- Debug
    self:print("ServoFriendHatExtension destroyed")
    -- Base class
    ServoFriendHatExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendHatExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendHatExtension.super.update(self, dt, t)
end

ServoFriendHatExtension.respawn_hat = function(self)
    self:destroy_hat()
    self:spawn_hat()
end

ServoFriendHatExtension.spawn_hat = function(self)
    if self.initialized and self.show_hat and (not self.base_unit or not unit_alive(self.base_unit)) then
        local pt = self:pt()
        if pt.player_unit and unit_alive(pt.player_unit) and script_unit_has_extension(pt.player_unit, "visual_loadout_system") then
            -- Get visual loadout of player to have access to an equipment component
            local visual_loadout_extension = pt.player_unit and script_unit_extension(pt.player_unit, "visual_loadout_system")
            -- Check visual loadout extension
            if visual_loadout_extension and not visual_loadout_extension.__deleted then
                -- Get hat item from master item table
                local master_items = MasterItems.get_cached()
                local hat_item_data = master_items[hat_item]
                -- Check hat data
                if hat_item_data then
                    -- Get equipment component attach settings
                    local equipment_component = visual_loadout_extension._equipment_component
                    local attach_settings = equipment_component:_attach_settings()
                    equipment_component:_fill_attach_settings_1p(attach_settings, pt.servo_friend_unit, {})
                    attach_settings.skip_link_children = true
                    -- Spawn item
                    self.base_unit, self.attachment_units = VisualLoadoutCustomization.spawn_item(hat_item_data, attach_settings, pt.servo_friend_unit)
                    -- Link units
                    for _, unit in pairs(self.attachment_units) do
                        world_unlink_unit(self.world, unit)
                        world_link_unit(self.world, unit, 1, pt.servo_friend_unit, 1)
                        unit_set_local_position(unit, 1, vector3(0, -.05, -1.7))
                        unit_set_local_rotation(unit, 1, quaternion_identity())
                    end
                end
            end
        end
    end
end

ServoFriendHatExtension.destroy_hat = function(self)
    if self.attachment_units and #self.attachment_units > 0 then
        for _, unit in pairs(self.attachment_units) do
            if unit and unit_alive(unit) then
                world_unlink_unit(self.world, unit)
                world_destroy_unit(self.world, unit)
            end
        end
    end
    self.attachment_units = nil
    if self.base_unit and unit_alive(self.base_unit) then
        world_unlink_unit(self.world, self.base_unit)
        world_destroy_unit(self.world, self.base_unit)
    end
    self.base_unit = nil
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendHatExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendHatExtension.super.on_settings_changed(self)
    -- Settings
    self.show_hat = mod:get("mod_option_show_hat")
    -- Respawn
    self:respawn_hat()
end

ServoFriendHatExtension.on_servo_friend_spawned = function(self)
    -- Base class
    ServoFriendHatExtension.super.on_servo_friend_spawned(self)
    -- Spawn
    self:spawn_hat()
end

ServoFriendHatExtension.on_servo_friend_destroyed = function(self)
    -- Base class
    ServoFriendHatExtension.super.on_servo_friend_destroyed(self)
    -- Destroy
    self:destroy_hat()
end

return ServoFriendHatExtension