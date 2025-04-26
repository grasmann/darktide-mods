local mod = get_mod("servo_friend_tag_cannon")
local servo_friend = get_mod("servo_friend")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")
local ImpactEffect = mod:original_require("scripts/utilities/attack/impact_effect")
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
local matrix4x4 = Matrix4x4
local unit_node = unit.node
local quaternion = Quaternion
local unit_alive = unit.alive
local wwise_world = WwiseWorld
local vector3_box = Vector3Box
local script_unit = ScriptUnit
local vector3_zero = vector3.zero
local unit_has_node = unit.has_node
local world_link_unit = world.link_unit
local vector3_unbox = vector3_box.unbox
local world_unlink_unit = world.unlink_unit
local matrix4x4_identity = matrix4x4.identity
local quaternion_forward = quaternion.forward
local world_destroy_unit = world.destroy_unit
local matrix4x4_set_scale = matrix4x4.set_scale
local unit_world_position = unit.world_position
local unit_local_rotation = unit.local_rotation
local unit_local_position = unit.local_position
local quaternion_identity = quaternion.identity
local world_link_particles = world.link_particles
local unit_set_local_scale = unit.set_local_scale
local script_unit_extension = script_unit.extension
local world_create_particles = world.create_particles
local unit_set_local_position = unit.set_local_position
local unit_set_local_rotation = unit.set_local_rotation
local unit_set_unit_visibility = unit.set_unit_visibility
local script_unit_has_extension = script_unit.has_extension
local matrix4x4_set_translation = matrix4x4.set_translation
local wwise_world_make_auto_source = wwise_world.make_auto_source
local unit_set_scalar_for_materials = unit.set_scalar_for_materials
local wwise_world_make_manual_source = wwise_world.make_manual_source
local wwise_world_set_source_position = wwise_world.set_source_position
local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
local unit_set_shader_pass_flag_for_meshes = unit.set_shader_pass_flag_for_meshes

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local cannon_item = "content/items/weapons/player/ranged/ogryn_heavystubber_p1_m2"
local muzzle_flash_effect = "content/fx/particles/weapons/rifles/ogryn_heavystubber/ogryn_heavystubber_muzzle"
local shell_casing_effect = "content/fx/particles/weapons/shells/shell_casing_heavystubber_01"
local flyby_sound_effect = "wwise/events/weapon/play_shared_combat_weapon_bullet_flyby_small"
local packages_to_load = {
    flyby_sound_effect,
    "wwise/events/weapon/play_psyker_throwing_knife_hit_death_husk",
    "wwise/events/weapon/melee_hits_blunt_gen_husk",
    "content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail_3p",
    "wwise/events/weapon/play_bullet_hits_throwing_knife_negate_husk",
    "wwise/events/weapon/play_bullet_hits_throwing_knife_negate",
    "wwise/events/weapon/play_bullet_hits_throwing_knife",
    "content/fx/particles/impacts/surfaces/impact_sand",
    "content/fx/particles/impacts/covers/cover_generic_penetration_01",
    "content/fx/particles/weapons/grenades/grenade_trail",
    "content/fx/particles/impacts/damage_blocked",
    "content/fx/units/weapons/small_caliber_concrete_medium_01",
    "content/fx/particles/impacts/flesh/poxwalker_maggots_small_01",
    "wwise/events/weapon/play_bullet_hits_large_death",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored",
    "wwise/events/weapon/play_bullet_hits_throwing_knife_armored",
    "wwise/events/weapon/melee_hits_blunt_shield",
    "content/fx/particles/impacts/armor_ricochet",
    "wwise/events/weapon/play_material_hit_ice",
    "content/fx/particles/impacts/flesh/blood_splatter_01",
    "wwise/events/weapon/play_melee_hits_axe_armor_husk",
    "content/fx/particles/impacts/flesh/gib_flesh_bits_01",
    "wwise/events/weapon/play_bullet_hits_gen",
    "content/fx/particles/impacts/surfaces/impact_mud",
    "wwise/events/weapon/play_bullet_hits_gen_damage_negated_husk",
    "wwise/events/weapon/play_bullet_hits_gen_armored_large_husk",
    "content/fx/particles/impacts/surfaces/impact_metal_06",
    "wwise/events/weapon/play_bullet_hits_gen_armored_large",
    "wwise/events/weapon/melee_hits_blunt_shield_husk",
    "wwise/events/weapon/play_melee_hits_axe_armor",
    "wwise/events/weapon/play_player_push_resilient",
    "wwise/events/weapon/play_material_hit_ice_husk",
    "wwise/events/weapon/melee_hits_blunt_armor_break_husk",
    "content/fx/particles/impacts/surfaces/impact_concrete_02",
    "content/decals/blood_ball/blood_ball",
    "wwise/events/weapon/play_combat_weapon_hit_addon_bone",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored_large",
    "content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_tracer_trail",
    "content/fx/units/weapons/small_caliber_wood_large_01",
    "content/fx/particles/impacts/surfaces/impact_concrete",
    "content/fx/particles/impacts/surfaces/impact_snow_01",
    "content/fx/units/weapons/small_caliber_cloth_large_01",
    "content/fx/particles/impacts/flesh/poxwalker_blood_splatter_reduced_damage_01",
    "content/decals/blood_ball/blood_ball_poxwalker",
    "content/fx/particles/impacts/surfaces/impact_brick_01",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored_large_husk",
    "wwise/events/weapon/play_bullet_hits_gen_armored_death",
    "wwise/events/weapon/melee_hits_blunt_heavy_husk",
    "content/fx/particles/weapons/swords/chainsword/impact_metal_slash_01",
    "content/fx/units/weapons/small_caliber_glass_medium_01",
    "wwise/events/weapon/play_melee_hits_axe_light",
    "wwise/events/weapon/play_indicator_weakspot",
    "wwise/events/weapon/play_psyker_throwing_knife_hit",
    "wwise/events/weapon/play_hit_indicator_melee_super_armor_no_damage",
    "content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_impact_01",
    "wwise/events/weapon/play_player_push_armored_husk",
    "content/weapons/player/ranged/stubgun_heavy_ogryn/wpn_stubgun_heavy_ogryn_chained_rig",
    "content/fx/particles/weapons/rifles/autogun/autogun_smoke_trail",
    "content/fx/units/weapons/small_caliber_concrete_large_01",
    "wwise/events/weapon/play_zealot_throw_knife_loop",
    "content/fx/particles/impacts/impact_sweat_01",
    "wwise/events/weapon/play_player_push_unarmored",
    "content/fx/particles/impacts/surfaces/impact_wood",
    "content/characters/player/ogryn/first_person/animations/heavy_stubber_twin_linked",
    "content/fx/particles/impacts/flesh/poxwalker_blood_splatter_small_01",
    "content/fx/particles/impacts/surfaces/impact_concrete_03",
    "wwise/events/weapon/play_bullet_hits_gen_armored_husk",
    "wwise/events/weapon/melee_hits_blunt_no_damage_husk",
    "wwise/events/weapon/melee_hits_blunt_armor",
    "wwise/events/weapon/play_player_push_super_armor",
    "content/fx/particles/impacts/surfaces/impact_glass",
    "content/fx/particles/impacts/generic_dust_unarmored",
    "content/fx/particles/impacts/flesh/blood_splatter_weakspot_ranged_01",
    "content/fx/particles/impacts/weapons/thunder_hammer/impact_blunt_metal_01",
    "wwise/events/weapon/play_psyker_throwing_knife_hit_husk",
    "content/fx/particles/impacts/surfaces/impact_metal",
    "content/fx/particles/abilities/psyker_shield_block",
    "wwise/events/weapon/melee_hits_blunt_armor_husk",
    "wwise/events/weapon/melee_hits_blunt_reduced_damage",
    "wwise/events/weapon/play_bullet_hits_sharp_object",
    "content/fx/particles/impacts/flesh/poxwalker_blood_splatter_weakspot_ranged_01",
    "content/fx/units/weapons/small_caliber_wood_small_01",
    "content/fx/particles/impacts/flesh/poxwalker_blood_splatter_01",
    "wwise/events/weapon/play_bullet_hits_gen_damage_negated_large_husk",
    "wwise/events/weapon/melee_hits_blunt_reduced_damage_husk",
    "content/fx/particles/impacts/surfaces/impact_water",
    "wwise/events/weapon/play_player_push_resilient_husk",
    "wwise/events/weapon/play_psyker_throwing_knife_hit_death",
    "wwise/events/weapon/play_melee_hits_axe_light_husk",
    "wwise/events/weapon/play_bullet_hits_gen_damage_negated_large",
    "wwise/events/weapon/play_player_push_armored",
    "wwise/events/weapon/play_player_push_super_armor_husk",
    "wwise/events/weapon/melee_hits_blunt_resilient_husk",
    "content/fx/particles/impacts/surfaces/impact_generic",
    "content/fx/particles/impacts/enemies/renegade_captain/renegade_captain_shield_impact",
    "content/fx/particles/weapons/rifles/autogun/autogun_impact_armored",
    "wwise/events/weapon/play_indicator_weakspot_armored",
    "wwise/events/weapon/play_bullet_hits_gen_large",
    "content/fx/units/weapons/small_caliber_metal_small_01",
    "wwise/events/weapon/melee_hits_blunt_heavy",
    "content/fx/particles/impacts/weapons/autogun/autogun_impact_02",
    "content/fx/units/weapons/small_caliber_glass_small_01",
    "content/fx/particles/impacts/abilities/gunslinger_knife_impact",
    "content/characters/player/ogryn/third_person/animations/heavy_stubber_twin_linked",
    "content/fx/particles/weapons/shells/shell_casing_heavystubber_01",
    "content/fx/units/weapons/small_caliber_metal_large_01",
    "wwise/events/weapon/play_hit_indicator_death_knife",
    "wwise/events/weapon/melee_hits_blunt_armor_break",
    "content/fx/units/weapons/small_caliber_cloth_small_01",
    "wwise/events/weapon/play_projectile_cover_penetration_in",
    "wwise/events/weapon/melee_hits_blunt_resilient",
    "wwise/events/weapon/play_player_push_unarmored_husk",
    "wwise/events/weapon/stop_zealot_throw_knife_loop",
    "wwise/events/weapon/play_bullet_hits_gen_husk",
    "wwise/events/weapon/play_hit_indicator_death_knife_husk",
    "content/fx/particles/impacts/surfaces/impact_brick_02",
    "wwise/events/weapon/play_hit_indicator_weakspot_melee_sharp",
    "wwise/events/weapon/play_cogitator_impact_husk",
    "content/ui/materials/icons/weapons/hud/ogryn_heavystubber_p1_m2",
    "content/fx/particles/impacts/surfaces/impact_gravel",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored_death_husk",
    "wwise/events/weapon/play_combat_weapon_hit_addon_bone_husk",
    "wwise/events/weapon/play_hit_indicator_melee_super_armor_no_damage_husk",
    "content/fx/particles/impacts/surfaces/impact_ice_01",
    "content/fx/particles/impacts/flesh/blood_splatter_small_01",
    "content/fx/particles/impacts/surfaces/impact_super_armor",
    "content/fx/units/weapons/small_caliber_wood_medium_01",
    "content/fx/particles/impacts/flesh/poxwalker_blood_splatter_weakspot_melee_01",
    "content/fx/units/weapons/small_caliber_glass_large_01",
    "content/fx/units/weapons/small_caliber_cloth_medium_01",
    "wwise/events/weapon/play_bullet_hits_gen_large_husk",
    "content/fx/particles/impacts/armor_penetrate",
    "wwise/events/weapon/melee_hits_blunt_no_damage",
    "content/fx/particles/impacts/flesh/blood_splatter_reduced_damage_01",
    "wwise/events/weapon/play_cogitator_impact",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored_death",
    "content/fx/particles/impacts/flesh/blood_splatter_weakspot_01",
    "wwise/events/weapon/play_bullet_hits_gen_armored",
    "content/fx/particles/weapons/rifles/ogryn_heavystubber/heavystubber_impact_armored",
    "content/fx/particles/impacts/surfaces/impact_metal_05",
    "wwise/events/weapon/play_bullet_hits_gen_damage_negated",
    "wwise/events/weapon/play_bullet_hits_gen_armored_death_husk",
    "content/fx/units/weapons/small_caliber_concrete_small_01",
    "content/fx/particles/impacts/weapons/autogun/autogun_impact_wall",
    "wwise/events/weapon/melee_hits_blunt_gen",
    "content/fx/particles/weapons/rifles/ogryn_heavystubber/ogryn_heavystubber_muzzle",
    "wwise/events/weapon/play_bullet_hits_gen_unarmored_husk",
    "content/fx/units/weapons/small_caliber_metal_medium_01",
    "wwise/events/weapon/play_hit_indicator_weakspot_melee_blunt",
    "content/weapons/player/ranged/stubgun_heavy_ogryn/attachments/receiver_02/receiver_02",
    "content/weapons/player/ranged/stubgun_heavy_ogryn/attachments/barrel_02/barrel_02",
    "content/weapons/player/ranged/stubgun_heavy_ogryn/attachments/magazine_02/magazine_02",
    "content/weapons/player/ranged/stubgun_heavy_ogryn/attachments/grip_02/grip_02",
    "content/weapons/player/attachments/flashlights/flashlight_05/flashlight_05",
    "content/weapons/player/attachments/emblems/emblem_05/emblem_05",
    "wwise/events/weapon/play_heavy_stubber_p1_m2_auto",
    "wwise/events/weapon/stop_heavy_stubber_p1_m2_auto",
    "content/weapons/player/attachments/trinket_hooks/trinket_hook_empty",
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local ServoFriendTagCannonExtension = class("ServoFriendTagCannonExtension", "ServoFriendBaseExtension")

servo_friend:register_extension("ServoFriendTagCannonExtension", "servo_friend_tag_cannon_system")
servo_friend:register_packages(packages_to_load)
servo_friend:register_sounds({
    start_stubber = "wwise/events/weapon/play_heavy_stubber_p1_m2_auto",
    stop_stubber  = "wwise/events/weapon/stop_heavy_stubber_p1_m2_auto",
})

-- ##### ┬┌┐┌┬┌┬┐       ┌┬┐┌─┐┌─┐┌┬┐┬─┐┌─┐┬ ┬ #########################################################################
-- ##### │││││ │   ───   ││├┤ └─┐ │ ├┬┘│ │└┬┘ #########################################################################
-- ##### ┴┘└┘┴ ┴        ─┴┘└─┘└─┘ ┴ ┴└─└─┘ ┴  #########################################################################

ServoFriendTagCannonExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Base class
    ServoFriendTagCannonExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.initialized = true
    self.event_manager = managers.event
    self.base_unit = nil
    self.attachment_units = nil
    self.shoot_timer = 0
    self.shoot_time = .2
    self.barrel = false
    -- Events
    self.event_manager:register(self, "servo_friend_settings_changed", "on_settings_changed")
    self.event_manager:register(self, "servo_friend_tag_cannon_settings_changed", "on_settings_changed")
    self.event_manager:register(self, "servo_friend_spawned", "on_servo_friend_spawned")
    self.event_manager:register(self, "servo_friend_destroyed", "on_servo_friend_destroyed")
    -- Debug
    self:print("ServoFriendTagCannonExtension initialized")
    -- Settings
    self:on_settings_changed()
end

ServoFriendTagCannonExtension.destroy = function(self)
    self.initialized = false
    -- Events
    self.event_manager:unregister(self, "servo_friend_settings_changed")
    self.event_manager:unregister(self, "servo_friend_tag_cannon_settings_changed")
    self.event_manager:unregister(self, "servo_friend_spawned")
    self.event_manager:unregister(self, "servo_friend_destroyed")
    -- Destroy
    self:destroy_cannon()
    -- Debug
    self:print("ServoFriendTagCannonExtension destroyed")
    -- Base class
    ServoFriendTagCannonExtension.super.destroy(self)
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

ServoFriendTagCannonExtension.first_person_unit = function(self)
    return servo_friend.first_person_unit
end

ServoFriendTagCannonExtension.first_person_position = function(self)
    local first_person_unit = self:first_person_unit()
    return first_person_unit and unit_world_position(first_person_unit, 1)
end

ServoFriendTagCannonExtension.update = function(self, dt, t)
    -- Base class
    ServoFriendTagCannonExtension.super.update(self, dt, t)
    -- Shoot
    self:shoot(dt, t)
end

ServoFriendTagCannonExtension.respawn_cannon = function(self)
    self:destroy_cannon()
    self:spawn_cannon()
end

ServoFriendTagCannonExtension.spawn_cannon = function(self)
    if self.initialized and self.use_cannon and (not self.base_unit or not unit_alive(self.base_unit)) and servo_friend.all_packages_loaded then
        local pt = self:pt()
        if pt.player_unit and unit_alive(pt.player_unit) and script_unit_has_extension(pt.player_unit, "visual_loadout_system") then
            -- Get visual loadout of player to have access to an equipment component
            local visual_loadout_extension = pt.player_unit and script_unit_extension(pt.player_unit, "visual_loadout_system")
            -- Check visual loadout extension
            if visual_loadout_extension and not visual_loadout_extension.__deleted then
                -- Get hat item from master item table
                local master_items = MasterItems.get_cached()
                local cannon_item_data = master_items[cannon_item]
                -- Check hat data
                if cannon_item_data then
                    -- Get equipment component attach settings
                    local equipment_component = visual_loadout_extension._equipment_component
                    local attach_settings = equipment_component:_attach_settings()
                    equipment_component:_fill_attach_settings_1p(attach_settings, pt.servo_friend_unit, {})
                    attach_settings.skip_link_children = false
                    -- Spawn item
                    self.base_unit, self.attachment_units = VisualLoadoutCustomization.spawn_item(cannon_item_data, attach_settings, pt.servo_friend_unit)
                    -- Link unit
                    world_unlink_unit(self.world, self.base_unit)
                    world_link_unit(self.world, self.base_unit, 1, pt.servo_friend_unit, 1)
                    unit_set_local_scale(self.base_unit, 1, vector3(.25, .25, .25))
                    unit_set_local_position(self.base_unit, 1, vector3(-.1, -.2, 0))
                    unit_set_local_rotation(self.base_unit, 1, quaternion_identity())
                end
            end
        end
    end
end

ServoFriendTagCannonExtension.destroy_cannon = function(self)
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

ServoFriendTagCannonExtension.cannon_is_alive = function(self)
    return self.base_unit and unit_alive(self.base_unit)
end

mod.test_index = 1
mod.inc_test_index = function()
    mod.test_index = mod.test_index + 1
    mod:echo("test index: "..tostring(mod.test_index))
end

local SurfaceMaterialSettings = mod:original_require("scripts/settings/surface_material_settings")
local EMPTY_TABLE = {}
local surface_hit_types = SurfaceMaterialSettings.hit_types
ServoFriendTagCannonExtension.shoot = function(self, dt, t)

    if self:cannon_is_alive() and t > self.shoot_timer then

        if servo_friend.found_something_valid then
            
            -- mod:echo("shoot!")

            self:spawn_muzzle_flash()
            self:spawn_casing_effect()
            self:spawn_shoot_sound()

            local pt = servo_friend:pt()
            local player_position = servo_friend:player_position()
            local from = unit_local_position(pt.servo_friend_unit, 1)
            -- local to = servo_friend:aim_target(nil, pt.servo_friend_unit)
            local to, hit_unit, hit_distance, hit_normal = self:aim_target()
            local rotation = unit_local_rotation(pt.servo_friend_unit, 1)
            local direction = quaternion_forward(rotation)
            if servo_friend:is_point_in_cone(player_position, from, direction, 15, 10) then
                -- mod:echo("in cone!")
                local fx_extension = script_unit_has_extension(pt.player_unit, "fx_system")
                if fx_extension then
                    mod:echo("in cone!")
                    -- fx_extension:trigger_looping_wwise_event(flyby_sound_effect, nil, "start_stubber")
                    fx_extension:_trigger_wwise_event_on_line(flyby_sound_effect, from, to)

                    -- fx_extension:trigger_wwise_event(flyby_sound_effect, true, from, rotation)
                    -- fx_extension:trigger_gear_wwise_event("flyby")
                else
                    mod:echo("no fx extension")
                end
                self:spawn_flyby_sound()
            end

            -- ImpactEffect.play_surface_effect(self.physics_world, pt.player_unit, to, hit_normal, direction, "auto_bullet", surface_hit_types.stop, EMPTY_TABLE)

        end

        self.barrel = not self.barrel
        self.shoot_timer = t + self.shoot_time
        return true
    end

    self:destroy_shoot_sound()
    return false
end

ServoFriendTagCannonExtension.muzzle_position = function(self)
    local current_position = vector3_unbox(self.current_position)
    local node, offset = 6, vector3(.5, 0, -.1)
    if self.barrel then
        node, offset = 6, vector3(.1, 0, .3)
    end
    return unit_world_position(self.attachment_units[2], node) + offset
end

local actor = Actor
local physics_world = PhysicsWorld
local actor_unit = actor.unit
local vector3_normalize = vector3.normalize
local physics_world_raycast = physics_world.raycast
ServoFriendTagCannonExtension.aim_target = function(self)
    local pt = self:pt()
    -- optional_offset = optional_offset or vector3_zero()
    -- optional_unit = optional_unit  or self.first_person_unit
    -- optional_length = optional_length or 1000
    -- optional_collision_filter = optional_collision_filter or "filter_player_character_shooting_projectile"
    -- local from = unit_world_position(optional_unit, 1) + optional_offset
    local from = self:muzzle_position()
    local forward = quaternion_forward(unit_local_rotation(pt.servo_friend_unit, 1))
    local to = from + forward * 1000
	local to_target = to - from
	local direction = vector3_normalize(to_target)
	local hit, hit_position, hit_distance, hit_normal, hit_actor = physics_world_raycast(pt.physics_world, from, direction, 1000, "closest", "types", "both", "collision_filter", "filter_player_character_shooting_projectile")
    local hit_unit = hit_actor and actor_unit(hit_actor)
    return hit_position, hit_unit, hit_distance, hit_normal
end

ServoFriendTagCannonExtension.spawn_flyby_sound = function(self)
    local event_id = wwise_world_trigger_resource_event(self.wwise_world, flyby_sound_effect)
    -- WwiseWorld.stop_event(self.wwise_world, event_id)
end

ServoFriendTagCannonExtension.spawn_shoot_sound = function(self)
    if not self.shoot_source_id then
        self.shoot_source_id = self:play_sound("start_stubber")
    end
end

ServoFriendTagCannonExtension.destroy_shoot_sound = function(self)
    if self.shoot_source_id then
        self:play_sound("stop_stubber", self.shoot_source_id)
    end
    self.shoot_source_id = nil
end

ServoFriendTagCannonExtension.spawn_muzzle_flash = function(self)
    local pt = self:pt()
    -- if not pt.hover_particle_effect_id then
    -- local player_position = mod:player_position()
    local current_position = vector3_unbox(self.current_position)
    local unit_world_pose = matrix4x4_identity()
    local rotation = quaternion_identity() -- quaternion_from_euler_angles_xyz(-90, 0, 180)
    local muzzle_id = world_create_particles(self.world, muzzle_flash_effect, current_position, rotation)
    -- matrix4x4_set_scale(unit_world_pose, vector3(.1, .1, .1))
    local node, offset = 6, vector3(.5, 0, -.1)
    if self.barrel then
        node, offset = 6, vector3(.1, 0, .3)
    end
    matrix4x4_set_translation(unit_world_pose, offset)
    world_link_particles(self.world, muzzle_id, self.attachment_units[2], node, unit_world_pose, "destroy")
    -- end
end

ServoFriendTagCannonExtension.spawn_casing_effect = function(self)
    local pt = self:pt()
    -- if not pt.hover_particle_effect_id then
    -- local player_position = mod:player_position()
    local current_position = vector3_unbox(self.current_position)
    local unit_world_pose = matrix4x4_identity()
    local rotation = quaternion_identity() -- quaternion_from_euler_angles_xyz(-90, 0, 180)
    local muzzle_id = world_create_particles(self.world, shell_casing_effect, current_position, rotation)
    -- matrix4x4_set_scale(unit_world_pose, vector3(.1, .1, .1))
    -- local node, offset = 6, vector3(.5, 0, -.1)
    -- if self.barrel then
    --     node, offset = 6, vector3(.1, 0, .3)
    -- end
    matrix4x4_set_translation(unit_world_pose, vector3(0, 0, 0))
    world_link_particles(self.world, muzzle_id, self.attachment_units[2], mod.test_index, unit_world_pose, "destroy")
    -- end
end

-- ##### ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌─┐┬─┐┬┌─┐┌┐┌┌┬┐  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ######################################################
-- ##### └─┐├┤ ├┬┘└┐┌┘│ │  ├┤ ├┬┘│├┤ │││ ││  ├┤ └┐┌┘├┤ │││ │ └─┐ ######################################################
-- ##### └─┘└─┘┴└─ └┘ └─┘  └  ┴└─┴└─┘┘└┘─┴┘  └─┘ └┘ └─┘┘└┘ ┴ └─┘ ######################################################

ServoFriendTagCannonExtension.on_settings_changed = function(self)
    -- Base class
    ServoFriendTagCannonExtension.super.on_settings_changed(self)
    -- Settings
    self.use_cannon = mod:get("mod_option_use_cannon")
    -- Respawn
    self:respawn_cannon()
end

ServoFriendTagCannonExtension.on_servo_friend_spawned = function(self)
    -- Base class
    ServoFriendTagCannonExtension.super.on_servo_friend_spawned(self)
    -- Spawn
    self:spawn_cannon()
end

ServoFriendTagCannonExtension.on_servo_friend_destroyed = function(self)
    -- Base class
    ServoFriendTagCannonExtension.super.on_servo_friend_destroyed(self)
    -- Destroy
    self:destroy_cannon()
end

return ServoFriendTagCannonExtension