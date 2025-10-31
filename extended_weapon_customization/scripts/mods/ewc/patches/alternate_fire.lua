local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local LookDeltaTemplates = mod:original_require("scripts/settings/equipment/look_delta_templates")
local PlayerUnitPeeking = mod:original_require("scripts/utilities/player_unit_peeking")
local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
local BuffSettings = mod:original_require("scripts/settings/buff/buff_settings")
local Spread = mod:original_require("scripts/utilities/spread")
local Sway = mod:original_require("scripts/utilities/sway")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local math = math
    local table = table
    local CLASS = CLASS
    local managers = Managers
    local tostring = tostring
    local script_unit = ScriptUnit
    local table_clear = table.clear
    local table_contains = table.contains
    local script_unit_extension = script_unit.extension
    local math_degrees_to_radians = math.degrees_to_radians
    local script_unit_has_extension = script_unit.has_extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local state_machine_unit = nil
local camera_variable_unit = nil
local player_unit_sight_attachment_map = {}
local proc_events = BuffSettings.proc_events
local SLOT_SECONDARY = "slot_secondary"
local alternate_fire_overrides = {
    ironsight = {
        look_delta_template = "default_aiming",
        aim_animation = "to_ironsight",
        aim_animation_3p = "to_ironsight",
        unaim_animation = "to_unaim_ironsight",
        unaim_animation_3p = "to_unaim_ironsight",
        camera = {
            custom_vertical_fov = 40,
            near_range = 0.025,
            vertical_fov = 54,
        },
        exclude_weapons = {
            "laspistol_p1_m1",
            "laspistol_p1_m2",
            "laspistol_p1_m3",
            "lasgun_p1_m1",
            "lasgun_p1_m2",
            "lasgun_p1_m3",
            "ogryn_gauntlet_p1_m1",
            "ogryn_heavystubber_p1_m1",
            "ogryn_heavystubber_p1_m2",
            "ogryn_heavystubber_p1_m3",
            "ogryn_heavystubber_p2_m1",
            "ogryn_heavystubber_p2_m2",
            "ogryn_heavystubber_p2_m3",
            "ogryn_rippergun_p1_m1",
            "ogryn_rippergun_p1_m2",
            "ogryn_rippergun_p1_m3",
            "ogryn_thumper_p1_m1",
            "ogryn_thumper_p1_m2",
        },
    },
    reflex = {
        look_delta_template = "default_aiming",
        aim_animation = "to_reflex",
        aim_animation_3p = "to_reflex",
        unaim_animation = "to_unaim_reflex",
        unaim_animation_3p = "to_unaim_reflex",
        camera = {
            custom_vertical_fov = 40,
            near_range = 0.025,
            vertical_fov = 54,
        },
        exclude_weapons = {
            "laspistol_p1_m1",
            "laspistol_p1_m2",
            "laspistol_p1_m3",
            "lasgun_p1_m1",
            "lasgun_p1_m2",
            "lasgun_p1_m3",
            "ogryn_gauntlet_p1_m1",
            "ogryn_heavystubber_p1_m1",
            "ogryn_heavystubber_p1_m2",
            "ogryn_heavystubber_p1_m3",
            "ogryn_heavystubber_p2_m1",
            "ogryn_heavystubber_p2_m2",
            "ogryn_heavystubber_p2_m3",
            "ogryn_rippergun_p1_m1",
            "ogryn_rippergun_p1_m2",
            "ogryn_rippergun_p1_m3",
            "ogryn_thumper_p1_m1",
            "ogryn_thumper_p1_m2",
        },
    },
    braced = {
        look_delta_template = nil,
        aim_animation = "to_braced",
        aim_animation_3p = "to_braced",
        unaim_animation = "to_unaim_braced",
        unaim_animation_3p = "to_unaim_braced",
        camera = false,
        exclude_weapons = {},
    }
}

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod.clear_all_alternate_fire_overrides = function(self)
    table_clear(player_unit_sight_attachment_map)
end

mod.clear_alternate_fire_override = function(self, player_unit)
    player_unit_sight_attachment_map[player_unit] = nil
end

mod.alternate_fire_find_sight_attachment = function(self, player_unit)

    if player_unit_sight_attachment_map[player_unit] == false then
        return
    end

    if player_unit_sight_attachment_map[player_unit] then
        return player_unit_sight_attachment_map[player_unit]
    end

    local visual_loadout_extension = script_unit_extension(player_unit, "visual_loadout_system")
    if visual_loadout_extension then
        local item = visual_loadout_extension:item_from_slot("slot_secondary")
        if item then
            local sight_attachment_path = self:fetch_attachment(item.attachments, "sight")
            local sight_attachment = sight_attachment_path and self.settings.attachment_data_by_item_string[sight_attachment_path]
            if sight_attachment then
                player_unit_sight_attachment_map[player_unit] = sight_attachment
                return sight_attachment
            else
                player_unit_sight_attachment_map[player_unit] = false
            end
        end
    end
end

mod.alternate_fire_override = function(self, unit, value_name)
    local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
    if visual_loadout_extension then
        local sight_attachment = mod:alternate_fire_find_sight_attachment(unit)
        if sight_attachment then
            local alternate_fire_override = sight_attachment and sight_attachment.alternate_fire_override and alternate_fire_overrides[sight_attachment.alternate_fire_override]
            if alternate_fire_override and alternate_fire_override[value_name] then
                local item = visual_loadout_extension:item_from_slot("slot_secondary")
                if item and not table_contains(alternate_fire_override.exclude_weapons, item.weapon_template) then
                    return alternate_fire_override[value_name]
                end
            end
        end
    end
end

mod.alternate_fire_wielded_slot = function(self, unit)
    local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
    return visual_loadout_extension and (visual_loadout_extension._inventory_component and visual_loadout_extension._inventory_component.wielded_slot or visual_loadout_extension._wielded_slot) or "slot_unarmed"
end

mod.alternate_fire_wielded_item = function(self, unit)
    local visual_loadout_extension = script_unit_extension(unit, "visual_loadout_system")
    return visual_loadout_extension and visual_loadout_extension:item_from_slot(mod:alternate_fire_wielded_slot(unit))
end

mod:hook_require("scripts/utilities/look_delta", function(instance)

    instance.look_delta_template = function (weapon_action_component, alternate_fire_component, unit)
        local look_delta_template_name
        local weapon_template = WeaponTemplate.current_weapon_template(weapon_action_component)
        local alternate_fire_settings = weapon_template and weapon_template.alternate_fire_settings

        -- ##### Sight extension ######################################################################################
        local item = mod:alternate_fire_wielded_item(unit)
        local gear_id = mod:gear_id(item)
        local alternate_fire_list = mod:get("alternate_fire")
        local use_alternate_fire = alternate_fire_list and alternate_fire_list[gear_id]
        if use_alternate_fire == nil then use_alternate_fire = true end

        if mod:alternate_fire_wielded_slot(unit) == SLOT_SECONDARY and use_alternate_fire then
            
            local override = mod:alternate_fire_override(unit, "look_delta_template")
            if override then return LookDeltaTemplates[override] end
            
        end
        -- ##### Sight extension ######################################################################################

        if alternate_fire_component.is_active then
            look_delta_template_name = alternate_fire_settings and alternate_fire_settings.look_delta_template or "default_aiming"
        else
            look_delta_template_name = weapon_template and weapon_template.look_delta_template or "default"
        end

        return LookDeltaTemplates[look_delta_template_name]
    end

end)

mod:hook_require("scripts/utilities/first_person_animation_variables", function(instance)

    if not instance._update then
        instance._update = instance.update
        instance.update = function (dt, t, first_person_unit, unit_data_extension, weapon_extension, lerp_values)

            camera_variable_unit = unit_data_extension._unit

            instance._update(dt, t, first_person_unit, unit_data_extension, weapon_extension, lerp_values)

            camera_variable_unit = nil
        end
    end

end)

mod:hook_require("scripts/utilities/alternate_fire", function(instance)

    instance.camera_variables = function (weapon_template, camera_follow_unit)
        if not weapon_template then
            return nil, nil, nil
        end

        local alternate_fire_settings = weapon_template.alternate_fire_settings

        if not alternate_fire_settings then
            return nil, nil, nil
        end

        local camera_settings

        camera_settings = alternate_fire_settings.camera

        -- ##### Sight extension ######################################################################################
        local item = mod:alternate_fire_wielded_item(camera_variable_unit)
        local gear_id = mod:gear_id(item)
        local alternate_fire_list = mod:get("alternate_fire")
        local use_alternate_fire = alternate_fire_list and alternate_fire_list[gear_id]
        if use_alternate_fire == nil then use_alternate_fire = true end

        if mod:alternate_fire_wielded_slot(camera_variable_unit) == SLOT_SECONDARY and use_alternate_fire then
            
            if camera_variable_unit then
                local override = mod:alternate_fire_override(camera_variable_unit, "camera")
                if override == false then return nil, nil, nil
                elseif override then camera_settings = override end
            end
            
        end
        -- ##### Sight extension ######################################################################################

        if not camera_settings then
            return nil, nil, nil
        end

        local vertical_fov = math_degrees_to_radians(camera_settings.vertical_fov)
        local custom_vertical_fov = math_degrees_to_radians(camera_settings.custom_vertical_fov)
        local near_range = camera_settings.near_range

        return vertical_fov, custom_vertical_fov, near_range
    end

    instance.start = function (alternate_fire_component, weapon_tweak_templates_component, spread_control_component, sway_control_component, sway_component, movement_state_component, peeking_component, first_person_extension, animation_extension, weapon_extension, weapon_template, player_unit, t)
        local alternate_fire_settings = weapon_template.alternate_fire_settings
        local spread_template_name, recoil_template_name, sway_template_name, suppression_template_name, toughness_template_name

        spread_template_name = alternate_fire_settings.spread_template or weapon_template.spread_template or "none"
        recoil_template_name = alternate_fire_settings.recoil_template or weapon_template.recoil_template or "none"
        sway_template_name = alternate_fire_settings.sway_template or weapon_template.sway_template or "none"
        suppression_template_name = alternate_fire_settings.suppression_template or weapon_template.suppression_template or "none"
        toughness_template_name = alternate_fire_settings.toughness_template or weapon_template.toughness_template or "none"
        alternate_fire_component.is_active = true
        alternate_fire_component.start_t = t
        weapon_tweak_templates_component.spread_template_name = spread_template_name
        weapon_tweak_templates_component.recoil_template_name = recoil_template_name
        weapon_tweak_templates_component.sway_template_name = sway_template_name
        weapon_tweak_templates_component.suppression_template_name = suppression_template_name
        weapon_tweak_templates_component.toughness_template_name = toughness_template_name

        local start_anim_event, start_anim_event_3p

        start_anim_event = alternate_fire_settings.start_anim_event
        start_anim_event_3p = alternate_fire_settings.start_anime_event_3p or start_anim_event

        -- ##### Sight extension ######################################################################################
        local item = mod:alternate_fire_wielded_item(player_unit)
        local gear_id = mod:gear_id(item)
        local alternate_fire_list = mod:get("alternate_fire")
        local use_alternate_fire = alternate_fire_list and alternate_fire_list[gear_id]
        if use_alternate_fire == nil then use_alternate_fire = true end

        if mod:alternate_fire_wielded_slot(player_unit) == SLOT_SECONDARY and use_alternate_fire then

            local override = mod:alternate_fire_override(player_unit, "aim_animation")
            if override then start_anim_event = override end
            local override = mod:alternate_fire_override(player_unit, "aim_animation_3p")
            if override then start_anim_event_3p = override end
            
        end
        -- ##### Sight extension ######################################################################################

        if start_anim_event and start_anim_event_3p then
            animation_extension:anim_event_1p(start_anim_event)
            animation_extension:anim_event(start_anim_event_3p)
        end

        local spread_template = weapon_extension:spread_template()
        local sway_template = weapon_extension:sway_template()

        Sway.add_immediate_sway(sway_template, sway_control_component, sway_component, movement_state_component, "alternate_fire_start")
        Spread.add_immediate_spread(t, spread_template, spread_control_component, movement_state_component, "alternate_fire_start")

        local player = managers.state.player_unit_spawn:owner(player_unit)

        if player.aim_assist_data then
            player.aim_assist_data.wants_lock_on = true
        end

        if alternate_fire_settings.peeking_mechanics and peeking_component.peeking_is_possible then
            PlayerUnitPeeking.start(peeking_component, t)
        end

        local buff_extension = script_unit_extension(player_unit, "buff_system")
        local param_table = buff_extension:request_proc_event_param_table()

        if param_table then
            param_table.unit = player_unit

            buff_extension:add_proc_event(proc_events.on_alternative_fire_start, param_table)
        end

        managers.stats:record_private("hook_alternate_fire_start", player)
    end

    instance.stop = function (alternate_fire_component, peeking_component, first_person_extension, weapon_tweak_templates_component, animation_extension, weapon_template, player_unit, from_action_input)
        alternate_fire_component.is_active = false

        local spread_template_name = weapon_template.spread_template or "none"
        local recoil_template_name = weapon_template.recoil_template or "none"
        local sway_template_name = weapon_template.sway_template or "none"
        local suppression_template_name = weapon_template.suppression_template or "none"
        local toughness_template_name = weapon_template.toughness_template or "none"

        weapon_tweak_templates_component.spread_template_name = spread_template_name
        weapon_tweak_templates_component.recoil_template_name = recoil_template_name
        weapon_tweak_templates_component.sway_template_name = sway_template_name
        weapon_tweak_templates_component.suppression_template_name = suppression_template_name
        weapon_tweak_templates_component.toughness_template_name = toughness_template_name

        if peeking_component.is_peeking then
            PlayerUnitPeeking.stop(peeking_component, first_person_extension)
        end

        local alternate_fire_settings = weapon_template.alternate_fire_settings
        local stop_anim_event, stop_anim_event_3p

        stop_anim_event = alternate_fire_settings.stop_anim_event
        stop_anim_event_3p = alternate_fire_settings.stop_anim_event_3p or stop_anim_event

        -- ##### Sight extension ######################################################################################
        local item = mod:alternate_fire_wielded_item(player_unit)
        local gear_id = mod:gear_id(item)
        local alternate_fire_list = mod:get("alternate_fire")
        local use_alternate_fire = alternate_fire_list and alternate_fire_list[gear_id]
        if use_alternate_fire == nil then use_alternate_fire = true end

        if mod:alternate_fire_wielded_slot(player_unit) == SLOT_SECONDARY and use_alternate_fire then
            
            local override = mod:alternate_fire_override(player_unit, "unaim_animation")
            if override then stop_anim_event = override end
            local override = mod:alternate_fire_override(player_unit, "unaim_animation_3p")
            if override then stop_anim_event_3p = override end
            
        end
        -- ##### Sight extension ######################################################################################

        if stop_anim_event and stop_anim_event_3p then
            animation_extension:anim_event_1p(stop_anim_event)
            animation_extension:anim_event(stop_anim_event_3p)
        end

        if not from_action_input then
            local action_input_extension = script_unit_extension(player_unit, "action_input_system")

            action_input_extension:clear_input_queue_and_sequences("weapon_action")
        end

        local player = managers.state.player_unit_spawn:owner(player_unit)

        managers.stats:record_private("hook_alternate_fire_stop", player)
    end

end)
