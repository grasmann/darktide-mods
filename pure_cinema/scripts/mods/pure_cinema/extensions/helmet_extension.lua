--#region Old
    -- local mod = get_mod("pure_cinema")

    -- -- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
    -- -- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
    -- -- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

    -- local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
    -- local VisualLoadoutLodGroup = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_lod_group")
    -- local MinionVisualLoadout = mod:original_require("scripts/utilities/minion_visual_loadout")
    -- local AttackSettings = mod:original_require("scripts/settings/damage/attack_settings")
    -- local master_items = mod:original_require("scripts/backend/master_items")
    -- local Breed = mod:original_require("scripts/utilities/breed")

    -- -- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
    -- -- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
    -- -- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
    -- -- #region Performance
    --     local unit = Unit
    --     local math = math
    --     local CLASS = CLASS
    --     local class = class
    --     local world = World
    --     local actor = Actor
    --     local pairs = pairs
    --     local string = string
    --     local vector3 = Vector3
    --     local math_max = math.max
    --     local managers = Managers
    --     local actor_unit = actor.unit
    --     local unit_alive = unit.alive
    --     local quaternion = Quaternion
    --     local vector3_up = vector3.up
    --     local wwise_world = WwiseWorld
    --     local script_unit = ScriptUnit
    --     local string_find = string.find
    --     local math_random = math.random
    --     local physics_world = PhysicsWorld
    --     local world_link_unit = world.link_unit
    --     local DEDICATED_SERVER = DEDICATED_SERVER
    --     local quaternion_rotate = quaternion.rotate
    --     local unit_create_actor = unit.create_actor
    --     local world_unlink_unit = world.unlink_unit
    --     local actor_add_velocity = actor.add_velocity
    --     local world_destroy_unit = world.destroy_unit
    --     local unit_local_rotation = unit.local_rotation
    --     local unit_world_position = unit.world_position
    --     local unit_world_rotation = unit.world_rotation
    --     local world_spawn_unit_ex = world.spawn_unit_ex
    --     local script_unit_extension = script_unit.extension
    --     local unit_set_local_position = unit.set_local_position
    --     local unit_set_unit_visibility = unit.set_unit_visibility
    --     local script_unit_has_extension = script_unit.has_extension
    --     local actor_set_collision_filter = actor.set_collision_filter
    --     local actor_add_angular_velocity = actor.add_angular_velocity
    --     local wwise_world_make_auto_source = wwise_world.make_auto_source
    --     local physics_world_immediate_overlap = physics_world.immediate_overlap
    --     local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
    -- -- #endregion

    -- -- ##### ┬ ┬┌─┐┬  ┌┬┐┌─┐┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ###############################################################
    -- -- ##### ├─┤├┤ │  │││├┤  │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ###############################################################
    -- -- ##### ┴ ┴└─┘┴─┘┴ ┴└─┘ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ###############################################################

    -- local HelmetExtension = class("HelmetExtension")

    -- -- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
    -- -- #####  ││├─┤ │ ├─┤ #################################################################################################
    -- -- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

    -- local pt = mod:pt()

    -- local DROP_CHECK = .2
    -- local DROP_TIME = 1.2
    -- local DUMMY_UNIT = "content/weapons/enemy/ranged/chaos_traitor_guard_rusher_lasgun_01/chaos_traitor_guard_rusher_lasgun_01"
    -- local attack_results = AttackSettings.attack_results

    -- local _helmet_slot_names = {
    --     "slot_head_attachment",
    --     "slot_headgear",
    --     "slot_head",
    -- }

    -- local _helmet_words = {
    --     "helmet",
    --     -- "hat",
    --     "melee_hat",
    --     "mask",
    --     "hood",
    --     "ritualist",
    --     "melee_head_attachment",
    -- }

    -- local _helmet_nodes = {
    --     "j_spine2",
    --     "j_spine1",
    --     "j_spine",
    --     "j_neck",
    --     "j_head",
    --     "j_hips",
    --     "j_chest",
    --     "j_jaw",
    --     "j_chestplate",
    --     "j_leftshoulder",
    --     "j_rightshoulder",
    --     "j_backpackoffset",
    --     "j_wpnbackpack",
    -- }

    -- -- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
    -- -- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
    -- -- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

    -- HelmetExtension.init = function(self, extension_init_context, unit, extension_init_data)
    --     -- Data
    --     self.unit = unit
    --     self.world = extension_init_context.world
    --     self.wwise_world = mod:wwise_world(self.world)
    --     self.physics_world = mod:physics_world(self.world)
    --     self.init_data = extension_init_data
    --     self.game_session = extension_init_data.game_session or managers.state.game_session:game_session()
    --     -- Extensions
    --     self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    --     -- Settings
    --     self.state = "none"
    --     -- Register Events
    --     managers.event:register(self, "pure_cinema_settings_changed", "on_settings_changed")
    --     -- Set initial values
    --     self:on_settings_changed()
    -- end

    -- HelmetExtension.extensions_ready = function(self)
    --     -- Get extensions
    --     self.unit_data_extension = script_unit_extension(self.unit, "unit_data_system")
    --     -- Fetch data
    --     self:fetch_data()
    -- end

    -- HelmetExtension.delete = function(self)
    --     self:delete_units()
    --     -- Unregister Events
    --     managers.event:unregister(self, "pure_cinema_settings_changed")
    -- end

    -- -- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
    -- -- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
    -- -- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

    -- HelmetExtension.on_settings_changed = function(self)
    --     self.collision_check = mod:get("helmet_drop_collision_check")
    -- end

    -- -- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
    -- -- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
    -- -- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

    -- local _attach_settings = {
    -- 	attach_pose = nil,
    -- 	character_unit = nil,
    -- 	extension_manager = nil,
    -- 	from_script_component = false,
    -- 	from_ui_profile_spawner = false,
    -- 	is_minion = true,
    -- 	item_definitions = nil,
    -- 	lod_group = nil,
    -- 	lod_shadow_group = nil,
    -- 	spawn_with_extensions = nil,
    -- 	unit_spawner = nil,
    -- 	world = nil,
    -- }

    -- HelmetExtension.delete_units = function(self)

    --     if self.dummy_unit and unit_alive(self.dummy_unit) then
    --         world_destroy_unit(self.world, self.dummy_unit)
    --     end

    -- end

    -- HelmetExtension.drop_helmet = function(self)
        
    --     if self.state == "none" and self.helmet and unit_alive(self.helmet) then

    --         local node = unit.has_node(self.helmet, "j_head") and unit.node(self.helmet, "j_head") or 1
    --         local position = unit_world_position(self.helmet, node)
    --         local rotation = unit_world_rotation(self.helmet, node)

    --         self.dummy_unit = world_spawn_unit_ex(self.world, DUMMY_UNIT, nil, position, rotation)

    --         unit_set_unit_visibility(self.dummy_unit, false, false)

    --         local actor = unit_create_actor(self.dummy_unit, "dropped")
    --         local collision_filter = "filter_minion_shooting_no_friendly_fire"

    --         actor_set_collision_filter(actor, collision_filter)

    --         local random_radius = 0.25
    -- 		local x = math_random() * 2 - 1
    -- 		local y = math_random() * 2 - 1
    -- 		local random_offset = vector3(x * random_radius, y * random_radius, 0)
    -- 		local direction = vector3_up() + random_offset
    -- 		local speed = 5
    -- 		local velocity_vector = direction * speed

    -- 		actor_add_velocity(actor, velocity_vector)

    -- 		local rotation = unit_local_rotation(self.dummy_unit, 1)
    -- 		local min_angular_x, max_angular_x, max_angular_y, max_angular_z = 3, 6, 0.25, 0.25
    -- 		local torque_vector = vector3(math_max(math_random() * max_angular_x, min_angular_x), math_random() * max_angular_y, math_random() * max_angular_z)

    -- 		torque_vector = quaternion_rotate(rotation, torque_vector)

    -- 		actor_add_angular_velocity(actor, torque_vector)

    --         self:trigger_inventory_wwise_event("wwise/events/weapon/play_bullet_hits_gen_armored_death_husk")

    --         if not DEDICATED_SERVER then
    --             local has_outline_system = managers.state.extension:has_system("outline_system")

    --             if has_outline_system then
    --                 local outline_system = managers.state.extension:system("outline_system")

    --                 outline_system:dropping_loadout_unit(self.unit, self.helmet)
    --             end
    --         end

    --         world_unlink_unit(self.world, self.helmet)

    --         for _, node_name in pairs(_helmet_nodes) do

    --             local node = unit.has_node(self.helmet, node_name) and unit.node(self.helmet, node_name)
    --             if node then
    --                 world_link_unit(self.world, self.helmet, node, self.dummy_unit, 1)
    --             end

    --         end

    --         if self.head and unit_alive(self.head) then
    --             unit_set_unit_visibility(self.head, true)
    --         end

    --         self.state = "drop"

    --     end

    -- end

    -- -- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
    -- -- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
    -- -- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

    -- HelmetExtension.check_if_helmet_landed = function(self)
    --     -- local weapon_unit = self:wielded_weapon_unit()
    --     if self.helmet and unit_alive(self.helmet) then
    --         local position = unit_world_position(self.helmet, 1)
    --         local rotation = unit_world_rotation(self.helmet, 1)
    --         local size = vector3(0.35, .5, 0.35)
    --         local collision_filter = "filter_minion_shooting_no_friendly_fire"
    --         local _, num_hits = physics_world_immediate_overlap(self.physics_world, "shape", "capsule", "position", position, "rotation", rotation, "size", size, "collision_filter", collision_filter)
    --         if num_hits > 0 then
    --             return true
    --         end
    --     end
    -- end

    -- -- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
    -- -- ##### ├┤ ├┤ ├┤ ├┤ │   │ └─┐ ########################################################################################
    -- -- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

    -- HelmetExtension.trigger_inventory_wwise_event = function(self, event_name)

    --     if self.helmet and unit_alive(self.helmet) then

    --         local auto_source_id = wwise_world_make_auto_source(self.wwise_world, self.helmet, 1)

    --         wwise_world_trigger_resource_event(self.wwise_world, event_name, auto_source_id)

    --     end

    -- end

    -- -- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
    -- -- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
    -- -- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

    -- HelmetExtension.update = function(self, dt, t)

    --     if self.state == "none" then
    --         return

    --     elseif self.state == "finished" then
    --         return

    --     elseif self.state == "drop" then

    --         -- Wait for drop
    --         local drop_time = not self.collision_check and DROP_TIME or DROP_CHECK
    --         self.drop_time = self.drop_time or t

    --         if self.collision_check and t - self.drop_time >= drop_time then

    --             self.helmet_landed = self:check_if_helmet_landed()

    --         elseif t - self.drop_time >= drop_time then

    --             self.helmet_landed = true

    --         end

    --         if self.helmet_landed then

    --             self:trigger_inventory_wwise_event("wwise/events/weapon/play_bullet_hits_gen_armored_death_husk")

    --             self.state = "finished"

    --         end

    --     end

    -- end

    -- -- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
    -- -- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
    -- -- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

    -- mod:hook(CLASS.AttackReportManager, "add_attack_result", function(func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)

    --     local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
    --     local breed_or_nil = unit_data_extension and unit_data_extension:breed()
    --     local target_is_minion = breed_or_nil and Breed.is_minion(breed_or_nil)
    --     local player = mod:player_from_unit(attacking_unit)

    --     if target_is_minion and player then

    --         local player_unit_data_extension = script_unit_has_extension(attacking_unit, "unit_data_system")
    --         local critical_strike_component = player_unit_data_extension and player_unit_data_extension:read_component("critical_strike")
    --         local is_critical_strike = critical_strike_component and critical_strike_component.is_active

    --         if hit_weakspot and (is_critical_strike or attack_result == attack_results.died) then

    --             local helmet_extension = script_unit_extension(attacked_unit, "helmet_system")
    --             if helmet_extension then
    --                 helmet_extension:drop_helmet()
    --             end

    --         end

    --     end

    --     return func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)

    -- end)

    -- HelmetExtension.fetch_data = function(self)

    --     -- Get breed
    --     self.breed = self.unit_data_extension:breed()
    --     local breed_name = self.breed.name

    --     local inventory_slots = self.visual_loadout_extension._inventory.slots
    --     local visual_slots = self.visual_loadout_extension._slots

    --     if inventory_slots and breed_name ~= "chaos_ogryn_bulwark" and breed_name ~= "chaos_ogryn_executor" then

    --         for _, head_slot in pairs(_helmet_slot_names) do

    --             -- Get equipped item
    --             self.item = self.visual_loadout_extension:slot_item(head_slot)

    --             if self.item then

    --                 local item_name = self.item.item_data.name

    --                 local is_helmet = nil

    --                 for _, word in pairs(_helmet_words) do
    --                     if string_find(item_name, word) then
    --                         is_helmet = true
    --                         break
    --                     end
    --                 end

    --                 if is_helmet then

    --                     -- Get unit
    --                     self.helmet = visual_slots[head_slot] and visual_slots[head_slot].unit
    --                     self.head = visual_slots["slot_flesh"] and visual_slots["slot_flesh"].unit
    --                     if self.head == self.helmet then
    --                         self.head = nil
    --                     end

    --                     break

    --                 end

    --             end

    --         end

    --     end

    -- end
--#endregion

local mod = get_mod("pure_cinema")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local VisualLoadoutCustomization = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_customization")
local VisualLoadoutLodGroup = mod:original_require("scripts/extension_systems/visual_loadout/utilities/visual_loadout_lod_group")
local MinionVisualLoadout = mod:original_require("scripts/utilities/minion_visual_loadout")
local AttackSettings = mod:original_require("scripts/settings/damage/attack_settings")
local master_items = mod:original_require("scripts/backend/master_items")
local Breed = mod:original_require("scripts/utilities/breed")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local math = math
    local CLASS = CLASS
    local class = class
    local world = World
    local actor = Actor
    local pairs = pairs
    local string = string
    local vector3 = Vector3
    local math_max = math.max
    local managers = Managers
    local actor_unit = actor.unit
    local unit_alive = unit.alive
    local quaternion = Quaternion
    local vector3_up = vector3.up
    local wwise_world = WwiseWorld
    local script_unit = ScriptUnit
    local string_find = string.find
    local math_random = math.random
    local physics_world = PhysicsWorld
    local world_link_unit = world.link_unit
    local DEDICATED_SERVER = DEDICATED_SERVER
    local quaternion_rotate = quaternion.rotate
    local unit_create_actor = unit.create_actor
    local world_unlink_unit = world.unlink_unit
    local actor_add_velocity = actor.add_velocity
    local world_destroy_unit = world.destroy_unit
    local unit_local_rotation = unit.local_rotation
    local unit_world_position = unit.world_position
    local unit_world_rotation = unit.world_rotation
    local world_spawn_unit_ex = world.spawn_unit_ex
    local script_unit_extension = script_unit.extension
    local unit_set_local_position = unit.set_local_position
    local unit_set_unit_visibility = unit.set_unit_visibility
    local script_unit_has_extension = script_unit.has_extension
    local actor_set_collision_filter = actor.set_collision_filter
    local actor_add_angular_velocity = actor.add_angular_velocity
    local wwise_world_make_auto_source = wwise_world.make_auto_source
    local physics_world_immediate_overlap = physics_world.immediate_overlap
    local wwise_world_trigger_resource_event = wwise_world.trigger_resource_event
    local ipairs = ipairs
    local unit_has_node = unit.has_node
    local unit_node = unit.node
    local breed_is_minion = Breed.is_minion
-- #endregion

-- ##### ┬ ┬┌─┐┬  ┌┬┐┌─┐┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ###############################################################
-- ##### ├─┤├┤ │  │││├┤  │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ###############################################################
-- ##### ┴ ┴└─┘┴─┘┴ ┴└─┘ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ###############################################################

local HelmetExtension = class("HelmetExtension")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()

local DROP_CHECK = .2
local DROP_TIME = 1.2
local DUMMY_UNIT = "content/weapons/enemy/ranged/chaos_traitor_guard_rusher_lasgun_01/chaos_traitor_guard_rusher_lasgun_01"
local attack_results = AttackSettings.attack_results

local _helmet_slot_names = {
    "slot_head_attachment",
    "slot_headgear",
    "slot_head",
}

local _helmet_words = {
    "helmet",
    -- "hat",
    "melee_hat",
    "mask",
    "hood",
    "ritualist",
    "melee_head_attachment",
}

local _helmet_nodes = {
    "j_spine2",
    "j_spine1",
    "j_spine",
    "j_neck",
    "j_head",
    "j_hips",
    "j_chest",
    "j_jaw",
    "j_chestplate",
    "j_leftshoulder",
    "j_rightshoulder",
    "j_backpackoffset",
    "j_wpnbackpack",
}

-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐┌┬┐┬┌─┐┌┐┌ #############################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├─┤ │ ││ ││││ #############################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘┴ ┴ ┴ ┴└─┘┘└┘ #############################################################################

HelmetExtension.init = function(self, extension_init_context, unit, extension_init_data)
    -- Data
    self.unit = unit
    self.world = extension_init_context.world
    self.wwise_world = mod:wwise_world(self.world)
    self.physics_world = mod:physics_world(self.world)
    self.init_data = extension_init_data
    self.game_session = extension_init_data.game_session or managers.state.game_session:game_session()
    -- Extensions
    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    -- Settings
    self.state = "none"
    -- Register Events
    managers.event:register(self, "pure_cinema_settings_changed", "on_settings_changed")
    -- Set initial values
    self:on_settings_changed()
end

HelmetExtension.extensions_ready = function(self)
    -- Get extensions
    self.unit_data_extension = script_unit_extension(self.unit, "unit_data_system")
    -- Fetch data
    self:fetch_data()
end

HelmetExtension.delete = function(self)
    self:delete_units()
    -- Unregister Events
    managers.event:unregister(self, "pure_cinema_settings_changed")
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

HelmetExtension.on_settings_changed = function(self)
    self.collision_check = mod:get("helmet_drop_collision_check")
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

local _attach_settings = {
	attach_pose = nil,
	character_unit = nil,
	extension_manager = nil,
	from_script_component = false,
	from_ui_profile_spawner = false,
	is_minion = true,
	item_definitions = nil,
	lod_group = nil,
	lod_shadow_group = nil,
	spawn_with_extensions = nil,
	unit_spawner = nil,
	world = nil,
}

HelmetExtension.delete_units = function(self)

    if self.dummy_unit and unit_alive(self.dummy_unit) then
        world_destroy_unit(self.world, self.dummy_unit)
    end

end

HelmetExtension.drop_helmet = function(self)
    
    if self.state == "none" and self.helmet and unit_alive(self.helmet) then

        local node = unit_has_node(self.helmet, "j_head") and unit_node(self.helmet, "j_head") or 1
        local position = unit_world_position(self.helmet, node)
        local rotation = unit_world_rotation(self.helmet, node)

        self.dummy_unit = world_spawn_unit_ex(self.world, DUMMY_UNIT, nil, position, rotation)

        unit_set_unit_visibility(self.dummy_unit, false, false)

        local actor = unit_create_actor(self.dummy_unit, "dropped")
        local collision_filter = "filter_minion_shooting_no_friendly_fire"

        actor_set_collision_filter(actor, collision_filter)

        local random_radius = 0.25
		local x = math_random() * 2 - 1
		local y = math_random() * 2 - 1
		local random_offset = vector3(x * random_radius, y * random_radius, 0)
		local direction = vector3_up() + random_offset
		local speed = 5
		local velocity_vector = direction * speed

		actor_add_velocity(actor, velocity_vector)

		local rotation = unit_local_rotation(self.dummy_unit, 1)
		local min_angular_x, max_angular_x, max_angular_y, max_angular_z = 3, 6, 0.25, 0.25
		local torque_vector = vector3(math_max(math_random() * max_angular_x, min_angular_x), math_random() * max_angular_y, math_random() * max_angular_z)

		torque_vector = quaternion_rotate(rotation, torque_vector)

		actor_add_angular_velocity(actor, torque_vector)

        self:trigger_inventory_wwise_event("wwise/events/weapon/play_bullet_hits_gen_armored_death_husk")

        if not DEDICATED_SERVER then
            local has_outline_system = managers.state.extension:has_system("outline_system")

            if has_outline_system then
                local outline_system = managers.state.extension:system("outline_system")

                outline_system:dropping_loadout_unit(self.unit, self.helmet)
            end
        end

        world_unlink_unit(self.world, self.helmet)

        for i = 1, #_helmet_nodes do
            local node_name = _helmet_nodes[i]
            local node = unit_has_node(self.helmet, node_name) and unit_node(self.helmet, node_name)
            if node then
                world_link_unit(self.world, self.helmet, node, self.dummy_unit, 1)
            end

        end

        if self.head and unit_alive(self.head) then
            unit_set_unit_visibility(self.head, true)
        end

        self.state = "drop"

    end

end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

HelmetExtension.check_if_helmet_landed = function(self)
    -- local weapon_unit = self:wielded_weapon_unit()
    if self.helmet and unit_alive(self.helmet) then
        local position = unit_world_position(self.helmet, 1)
        local rotation = unit_world_rotation(self.helmet, 1)
        local size = vector3(0.35, .5, 0.35)
        local collision_filter = "filter_minion_shooting_no_friendly_fire"
        local _, num_hits = physics_world_immediate_overlap(self.physics_world, "shape", "capsule", "position", position, "rotation", rotation, "size", size, "collision_filter", collision_filter)
        if num_hits > 0 then
            return true
        end
    end
end

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### ├┤ ├┤ ├┤ ├┤ │   │ └─┐ ########################################################################################
-- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

HelmetExtension.trigger_inventory_wwise_event = function(self, event_name)

    if self.helmet and unit_alive(self.helmet) then

        local auto_source_id = wwise_world_make_auto_source(self.wwise_world, self.helmet, 1)

        wwise_world_trigger_resource_event(self.wwise_world, event_name, auto_source_id)

    end

end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

HelmetExtension.update = function(self, dt, t)

    if self.state == "none" then
        return

    elseif self.state == "finished" then
        return

    elseif self.state == "drop" then

        -- Wait for drop
        local drop_time = not self.collision_check and DROP_TIME or DROP_CHECK
        self.drop_time = self.drop_time or t

        if self.collision_check and t - self.drop_time >= drop_time then

            self.helmet_landed = self:check_if_helmet_landed()

        elseif t - self.drop_time >= drop_time then

            self.helmet_landed = true

        end

        if self.helmet_landed then

            self:trigger_inventory_wwise_event("wwise/events/weapon/play_bullet_hits_gen_armored_death_husk")

            self.state = "finished"

        end

    end

end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

mod:hook(CLASS.AttackReportManager, "add_attack_result", function(func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)

    -- hit_weakspot is a plain boolean parameter (no lookups needed), so check it
    -- first to skip all extension/breed/player lookups on the common case where
    -- a hit isn't a weakspot hit at all. Logic and end result are unchanged.
    if hit_weakspot then

        local unit_data_extension = script_unit_has_extension(attacked_unit, "unit_data_system")
        local breed_or_nil = unit_data_extension and unit_data_extension:breed()
        local target_is_minion = breed_or_nil and breed_is_minion(breed_or_nil)

        if target_is_minion then

            local player = mod:player_from_unit(attacking_unit)

            if player then

                local player_unit_data_extension = script_unit_has_extension(attacking_unit, "unit_data_system")
                local critical_strike_component = player_unit_data_extension and player_unit_data_extension:read_component("critical_strike")
                local is_critical_strike = critical_strike_component and critical_strike_component.is_active

                if is_critical_strike or attack_result == attack_results.died then

                    local helmet_extension = script_unit_extension(attacked_unit, "helmet_system")
                    if helmet_extension then
                        helmet_extension:drop_helmet()
                    end

                end

            end

        end

    end

    return func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)

end)

HelmetExtension.fetch_data = function(self)

    -- Get breed
    self.breed = self.unit_data_extension:breed()
    local breed_name = self.breed.name

    local inventory_slots = self.visual_loadout_extension._inventory.slots
    local visual_slots = self.visual_loadout_extension._slots

    if inventory_slots and breed_name ~= "chaos_ogryn_bulwark" and breed_name ~= "chaos_ogryn_executor" then

        for i = 1, #_helmet_slot_names do
            local head_slot = _helmet_slot_names[i]

            -- Get equipped item
            self.item = self.visual_loadout_extension:slot_item(head_slot)

            if self.item then

                local item_name = self.item.item_data.name

                local is_helmet = nil

                for j = 1, #_helmet_words do
                    -- plain=true: these are literal substrings, skip the pattern-matching engine
                    if string_find(item_name, _helmet_words[j], 1, true) then
                        is_helmet = true
                        break
                    end
                end

                if is_helmet then

                    -- Get unit
                    self.helmet = visual_slots[head_slot] and visual_slots[head_slot].unit
                    self.head = visual_slots["slot_flesh"] and visual_slots["slot_flesh"].unit
                    if self.head == self.helmet then
                        self.head = nil
                    end

                    break

                end

            end

        end

    end

end
