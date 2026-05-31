local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local light = Light
    local CLASS = CLASS
    local pairs = pairs
    local level = Level
    local tostring = tostring
    local unit_light = unit.light
    local level_units = level.units
    local unit_num_lights = unit.num_lights
    local light_set_intensity = light.set_intensity
    local light_set_ies_profile = light.set_ies_profile
    local light_set_falloff_end = light.set_falloff_end
    local light_set_falloff_start = light.set_falloff_start
    local light_set_spot_angle_end = light.set_spot_angle_end
    local light_set_spot_angle_start = light.set_spot_angle_start
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local WEAPON_RANGED = "WEAPON_RANGED"
local WEAPON_MELEE = "WEAPON_MELEE"
local VALID_ITEM_TYPES = {WEAPON_MELEE, WEAPON_RANGED}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

-- Update all requests that contain gear id
local weapon_icon_ui_update_requests = function(weapon_icon_ui, request_id, item, prioritized)
    -- Check item and request id
    if item and request_id then
        -- Iterate through request sizes
        for size_key, requests in pairs(weapon_icon_ui._requests_by_size) do
            -- Iterate through requests
            for _, request in pairs(requests) do
                -- Get combined id
                local combined_id = tostring(request_id).."_"..tostring(size_key)
                -- Check request id
                if request.id == request_id or request.id == combined_id then
                    -- Update request
                    weapon_icon_ui:_update_request(request, item, prioritized)
                end
            end
        end
    end
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.WeaponIconUI, "_spawn_weapon", function(func, self, item, render_context, ...)
    -- Original function
    func(self, item, render_context, ...)
    -- Update lights
    if self._world_spawner and self._world_spawner._level then
        -- Get level units
        local level_units = level_units(self._world_spawner._level, true)
        -- Check units
        if level_units then
            -- Iterate through level units
            for _, unit in pairs(level_units) do
                -- Get unit lights
                local num_lights = unit_num_lights(unit)
                -- Iterate through unit lights
                for i = 1, num_lights do
                    -- Get light
                    local light = unit_light(unit, i)
                    -- Update light
                    light_set_ies_profile(light, "content/environment/ies_profiles/narrow/narrow_04")
                    light_set_spot_angle_start(light, 0)
                    light_set_spot_angle_end(light, 3)
                    light_set_intensity(light, 8)
                    light_set_falloff_start(light, 0)
                    light_set_falloff_end(light, 500)
                end
            end
        end
    end
end)

mod:hook(CLASS.WeaponIconUI, "weapon_icon_updated", function(func, self, item, prioritized, ...)
    -- Get request id
    local request_id = item.gear_id or item.name
    -- Update requests
    weapon_icon_ui_update_requests(self, request_id, item, prioritized)
end)

mod:hook(CLASS.WeaponIconUI, "load_weapon_icon", function(func, self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
    -- Check item
    if item and mod:cached_table_contains(VALID_ITEM_TYPES, item.item_type) then
        -- Modify item
        mod:modify_item(item)
        -- Fixes
        mod:apply_attachment_fixes(item)
    end
    -- Original function
    return func(self, item, on_load_callback, optional_render_context, prioritized, on_unload_callback, ...)
end)

-- local MinionAttack = mod:original_require("scripts/utilities/minion_attack")
-- local LineEffects = mod:original_require("scripts/settings/effects/line_effects")
-- local BreedShootTemplates = mod:original_require("scripts/settings/breed/breed_shoot_templates")
-- local EffectTemplates = mod:original_require("scripts/settings/fx/effect_templates")

-- local WEAPON_DISCHARGES = {}
-- local WEAPON_DISCHARGE_INFO = {}
-- local DISCHARGE_TEMPLATE = {
--     {
--         name = "none",
--         trigger = "none",
--         ammo = 0,
--         max_shots = 0,
--         shot_interval = 0,
--     },
--     {
--         name = "single",
--         trigger = "death",
--         ammo = 1,
--         max_shots = 1,
--         shot_interval = 0.1,
--     },
--     {
--         name = "burst",
--         trigger = "death",
--         ammo = 3,
--         max_shots = 3,
--         shot_interval = 0.1,
--     },
--     {
--         name = "automatic",
--         trigger = "death",
--         ammo = 30,
--         max_shots = math.huge,
--         shot_interval = 0.1,
--     },
--     {
--         name = "drop_single",
--         trigger = "drop",
--         ammo = 1,
--         max_shots = 1,
--         shot_interval = 0.1,
--     },
--     {
--         name = "drop_burst",
--         trigger = "drop",
--         ammo = 3,
--         max_shots = 3,
--         shot_interval = 0.1,
--     },
--     {
--         name = "drop_automatic",
--         trigger = "drop",
--         ammo = 30,
--         max_shots = math.huge,
--         shot_interval = 0.1,
--     },
--     {
--         name = "land_single",
--         trigger = "land",
--         ammo = 1,
--         max_shots = 1,
--         shot_interval = 0.1,
--     },
--     {
--         name = "land_burst",
--         trigger = "land",
--         ammo = 3,
--         max_shots = 3,
--         shot_interval = 0.1,
--     },
--     {
--         name = "land_automatic",
--         trigger = "land",
--         ammo = 30,
--         max_shots = math.huge,
--         shot_interval = 0.1,
--     },
-- }

-- mod:hook(CLASS.MinionVisualLoadoutExtension, "init", function(func, self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id, ...)
--     -- Original function
--     func(self, extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id, ...)
--     -- Set up discharge template
--     self._discharge_template = DISCHARGE_TEMPLATE[math.random(1, #DISCHARGE_TEMPLATE)]
--     self._discharge_counter = 0
--     self._discharge_last_shot_time = 0
-- end)

-- mod:hook(CLASS.MinionVisualLoadoutExtension, "_drop_slot", function(func, self, slot_name, ...)

--     -- local rnd_drop = math.random(0, 1)

--     if self._discharge_template and self._discharge_template.trigger == "death" then
--         mod:echo("no drop")
--         mod:trigger_enemy_shot(self._unit, self._discharge_template)
--         return
--     end

-- 	local slots = self._slots
-- 	local slot_data = slots[slot_name]
-- 	local slot_state = slot_data.state

-- 	if self._wielded_slot_name == slot_name then
-- 		self._wielded_slot_name = nil
-- 	end

-- 	if not DEDICATED_SERVER then
-- 		local has_outline_system = Managers.state.extension:has_system("outline_system")

-- 		if has_outline_system then
-- 			local outline_system = Managers.state.extension:system("outline_system")

-- 			outline_system:dropping_loadout_unit(self._unit, slot_data.unit)
-- 		end
-- 	end

-- 	local world = self._world
-- 	local item_unit = slot_data.unit
-- 	local item_data = slot_data.item_data
-- 	local reset_scene_graph = item_data.reset_scene_graph_on_unlink

-- 	World.unlink_unit(world, item_unit, reset_scene_graph)

-- 	local actor = Unit.create_actor(item_unit, "dropped")
-- 	local collision_filter = "filter_minion_shooting_no_friendly_fire"

-- 	Actor.set_collision_filter(actor, collision_filter)

-- 	slot_data.state = "dropped"

--     -- local rnd_drop_velocity = math.random(0, 1)

--     if self._discharge_template and self._discharge_template.trigger == "drop" then
--         mod:echo("no drop velocity")
--         mod:trigger_enemy_shot(self._unit, self._discharge_template)
--         return
--     end

-- 	if slot_state == "wielded" then
-- 		local random_radius = 0.25
-- 		local x = math.random() * 2 - 1
-- 		local y = math.random() * 2 - 1
-- 		local random_offset = Vector3(x * random_radius, y * random_radius, 0)
-- 		local direction = Vector3.up() + random_offset
-- 		local speed = 5
-- 		local velocity_vector = direction * speed

-- 		Actor.add_velocity(actor, velocity_vector)

-- 		local rotation = Unit.local_rotation(item_unit, 1)
-- 		local min_angular_x, max_angular_x, max_angular_y, max_angular_z = 3, 6, 0.25, 0.25
-- 		local torque_vector = Vector3(math.max(math.random() * max_angular_x, min_angular_x), math.random() * max_angular_y, math.random() * max_angular_z)

-- 		torque_vector = Quaternion.rotate(rotation, torque_vector)

-- 		Actor.add_angular_velocity(actor, torque_vector)
-- 	end
-- end)

-- mod.trigger_enemy_shot = function(self, unit, template)
--     -- self.enemy_shots = self.enemy_shots or {}
--     -- self.enemy_shots[unit] = template
--     -- ENEMY_SHOTS[unit] = template
--     -- ENEMY_SHOT_INFO[unit] = ENEMY_SHOT_INFO[unit] or {}

--     -- self.enemy_shot_info = self.enemy_info[unit] or {}
--     -- self.enemy_shot_info[unit] = self.enemy_shot_info[unit] or {}

--     local fx_extension = ScriptUnit.extension(unit, "fx_system")
--     local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
    
--     if visual_loadout_extension then
--         local slot_name = visual_loadout_extension:wielded_slot_name()
--         -- mod:echo("shot triggered for unit "..tostring(unit).." slot "..tostring(slot_name))
--         if slot_name and visual_loadout_extension:is_inventory_slot_ranged(slot_name) then
--             local weapon_unit = visual_loadout_extension and visual_loadout_extension:unit_3p_from_slot(slot_name)
--             local weapon_item = visual_loadout_extension and visual_loadout_extension:slot_item(slot_name)
--             if weapon_item and weapon_item.item_data.fx_sources then
--                 local inventory = visual_loadout_extension and visual_loadout_extension:inventory()
--                 mod:echo("shot triggered for weapon unit "..tostring(weapon_unit))

--                 -- if not mod.lol then
--                 --     mod:dtf(inventory, "inventory", 10)
--                 --     mod.lol = true
--                 -- end

--                 local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
--                 local breed = unit_data_extension and unit_data_extension:breed()
--                 -- if breed then
--                 --     mod:echo("breed "..tostring(breed.name))
--                 -- end
--                 local shoot_template = breed and BreedShootTemplates[breed.name.."_default"] or BreedShootTemplates.default
--                 local effect_template = shoot_template and shoot_template.effect_template_name and EffectTemplates[shoot_template.effect_template_name]
--                 if effect_template and not mod.lol then
--                     mod:dtf(effect_template, "effect_template", 10)
--                     mod.lol = true
--                 end


--                 local line_effect = shoot_template and shoot_template.line_effect
--                 local fx_source_name = nil
--                 for name, node in pairs(weapon_item.item_data.fx_sources) do
--                     fx_source_name = name
--                     break
--                 end
--                 local optional_end_position = Unit.world_position(weapon_unit, 1) + Quaternion.forward(Unit.world_rotation(weapon_unit, 1)) * 10

--                 if fx_extension and fx_source_name then
--                     if line_effect then
--                         fx_extension:_trigger_unit_line_fx(line_effect, slot_name, fx_source_name, optional_end_position)
--                     end

--                     fx_extension:trigger_inventory_wwise_event(shoot_event_name, slot_name, fx_source_name, target_unit, is_ranged_attack)
--                 else
--                     mod:echo("no fx extension for unit "..tostring(unit))
--                 end
--             end

--         -- else
--         --     mod:echo("slot name "..tostring(slot_name).." is not ranged weapon")
--         end
--     -- else
--     --     mod:echo("no visual loadout extension for unit "..tostring(unit))
--     end
--     -- local inventory_slot_name = "slot_ranged"
--     -- local fx_source_name = "fx_shoot"
--     -- local line_effect = "content/fx/particles/weapons/rifle/rifle_shoot_01"
--     -- fx_extension:trigger_unit_line_fx(line_effect, inventory_slot_name, fx_source_name, optional_end_position)

-- end

-- mod.update_enemy_shots = function(self, dt)
--     if self.enemy_shots then
--         for _, shot in pairs(self.enemy_shots) do
--             -- local unit = shot.unit
--             -- local fx_extension = ScriptUnit.extension(unit, "fx_system")

--             -- if fx_extension then
--             --     fx_extension:trigger_vfx("content/fx/particles/weapons/rifle/rifle_shoot_01", Vector3.zero(), Quaternion.identity())
--             -- end
--         end
--     end
-- end

-- MinionAttack.trigger_shoot_sfx_and_vfx = function (unit, scratchpad, action_data, optional_end_position)
-- 	local fx_extension = scratchpad.fx_extension
-- 	local inventory_slot_name = action_data.inventory_slot
-- 	local fx_source_name = action_data.fx_source_name
-- 	local shoot_template = action_data.shoot_template
-- 	local line_effect = shoot_template.line_effect

-- 	if line_effect and optional_end_position then
-- 		fx_extension:trigger_unit_line_fx(line_effect, inventory_slot_name, fx_source_name, optional_end_position)
-- 	end

-- 	local trigger_shoot_sound_event_once = action_data.trigger_shoot_sound_event_once

-- 	if trigger_shoot_sound_event_once and scratchpad.sound_event_triggered then
-- 		return
-- 	end

-- 	local shoot_event_name = shoot_template.shoot_sound_event

-- 	if shoot_event_name then
-- 		if type(shoot_event_name) == "table" then
-- 			shoot_event_name = shoot_event_name[math.random(1, #shoot_event_name)]
-- 		end

-- 		local target_unit = scratchpad.perception_component.target_unit
-- 		local is_ranged_attack = true

-- 		fx_extension:trigger_inventory_wwise_event(shoot_event_name, inventory_slot_name, fx_source_name, target_unit, is_ranged_attack)
-- 	end

-- 	local shoot_vfx_name = shoot_template.shoot_vfx_name

-- 	if shoot_vfx_name then
-- 		fx_extension:trigger_inventory_vfx(shoot_vfx_name, inventory_slot_name, fx_source_name)
-- 	end

-- 	local current_aim_anim_event = scratchpad.current_aim_anim_event
-- 	local aim_stance = scratchpad.aim_stance or action_data.aim_stances and action_data.aim_stances[current_aim_anim_event]

-- 	if aim_stance then
-- 		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
-- 		local breed = unit_data_extension:breed()
-- 		local shoot_offset_anim_event = breed.shoot_offset_anim_event
-- 		local offset_anim_event = shoot_offset_anim_event and shoot_offset_anim_event[aim_stance]

-- 		if offset_anim_event then
-- 			scratchpad.animation_extension:anim_event(offset_anim_event)
-- 		end
-- 	end

-- 	if trigger_shoot_sound_event_once then
-- 		scratchpad.sound_event_triggered = true
-- 	end
-- end

-- mod:hook(CLASS.MinionVisualLoadoutExtension, "drop_slot", function(func, self, slot_name, ...)
-- 	self:_drop_slot(slot_name)

-- 	local game_object_id = self._game_object_id
-- 	local slot_id = NetworkLookup.minion_inventory_slot_names[slot_name]

-- 	Managers.state.game_session:send_rpc_clients("rpc_minion_drop_slot", game_object_id, slot_id)
-- end)

-- mod:hook(CLASS.MinionVisualLoadoutExtension, "rpc_minion_drop_slot", function(func, self, channel_id, go_id, slot_id, ...)
-- 	local slot_name = NetworkLookup.minion_inventory_slot_names[slot_id]

-- 	self:_drop_slot(slot_name)
-- end)
