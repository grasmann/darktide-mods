local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ImpactEffect = mod:original_require("scripts/utilities/attack/impact_effect")
local WeaponTemplates = mod:original_require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
    local unit_attachment_callback = unit.attachment_callback
    local unit_damage_type_callback = unit.damage_type_callback
--#endregion

local damage_type_active_setting = "damage_type_active"

local function _get_aiming(player_unit)
    -- local player_unit = action._player_unit
    local unit_data_extension = script_unit_extension(player_unit, "unit_data_system")
    local alternate_fire_component = unit_data_extension and unit_data_extension:read_component("alternate_fire")
    return alternate_fire_component and alternate_fire_component.is_active
end

local function _damage_type(player_unit, wielded_slot)
    -- local wielded_slot = action._inventory_component.wielded_slot
    return unit_damage_type_callback(player_unit, "damage_type", wielded_slot)
end

local function _damage_type_active(gear_id)
    -- local item = action._weapon.item
    -- local gear_id = item and mod:gear_id(item)
    local damage_type_active_list = mod:get(damage_type_active_setting)
    return damage_type_active_list and gear_id and damage_type_active_list[gear_id]
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.ProjectileFxExtension, "on_impact", function(func, self, hit_position, hit_unit, hit_direction, hit_normal, current_speed, ...)
    local effects = self._effects
    local impact_fx = effects and effects.impact
    local player_unit = self._owner_unit

    -- Get aiming
    local aiming = _get_aiming(player_unit)
    -- Get weapon item
    -- local item = self._weapon.item
    local visual_loadout_extension = script_unit_extension(player_unit, "visual_loadout_system")
    if visual_loadout_extension then

        local inventory_component =  visual_loadout_extension._inventory_component
        local wielded_slot = inventory_component and inventory_component.wielded_slot or visual_loadout_extension._wielded_slot

        local item = visual_loadout_extension and visual_loadout_extension:item_from_slot(wielded_slot)

        local gear_id = item and mod:gear_id(item)
        -- Check item and attachments
        if gear_id then
            -- Get weapon template
            local weapon_template = WeaponTemplates[item.weapon_template]
            if weapon_template then

                -- Get damage type
                local damage_type = _damage_type(player_unit, wielded_slot)
                local use_damage_type = _damage_type_active(self)
                -- Check damage type
                if use_damage_type and damage_type then

                    mod:clear_fx_override(gear_id, impact_fx)

                    if aiming and damage_type.impact_aiming then
                        mod:set_fx_override(gear_id, impact_fx, damage_type.impact_aiming)
                    elseif damage_type.impact then
                        mod:set_fx_override(gear_id, impact_fx, damage_type.impact)
                    end

                end
            end
        end
    end
    -- Original function
    func(self, hit_position, hit_unit, hit_direction, hit_normal, current_speed, ...)
end)

mod:hook(CLASS.FxSystem, "play_impact_fx", function(func, self, impact_fx, position, direction, source_parameters, attacking_unit, optional_target_unit, optional_node_index, optional_hit_normal, optional_will_be_predicted, local_only_or_nil, ...)

    -- impact_fx.name = ""
    -- impact_fx.decal = ""
    -- impact_fx.linked_decal = ""
    -- impact_fx.blood_ball = ""

    local visual_loadout_extension = script_unit_extension(attacking_unit, "visual_loadout_system")
    if visual_loadout_extension then
        local inventory_component = visual_loadout_extension._inventory_component
        local wielded_slot = inventory_component and inventory_component.wielded_slot or visual_loadout_extension._wielded_slot
        
        -- local unit_data_extension = self._unit_data_extension
        -- local inventory_component = unit_data_extension:read_component("inventory")
        -- local current_wielded_slot = inventory_component.wielded_slot
        local item = visual_loadout_extension:item_from_slot(wielded_slot)
        local gear_id = mod:gear_id(item)

        if gear_id and mod.fx_overrides[gear_id] and mod.fx_overrides[gear_id][impact_fx.name] then
            impact_fx.name = mod.fx_overrides[gear_id][impact_fx.name] or impact_fx.name
        end

    end

    -- Original function
    func(self, impact_fx, position, direction, source_parameters, attacking_unit, optional_target_unit, optional_node_index, optional_hit_normal, optional_will_be_predicted, local_only_or_nil, ...)

end)

mod:hook(CLASS.FxSystem, "play_surface_impact_fx", function(func, self, hit_position, hit_direction, source_parameters, attacking_unit, optional_hit_normal, damage_type, hit_type, optional_will_be_predicted, ...)

    local physics_world = self._physics_world
	local surface_impact_fx, hit_unit, hit_actor = ImpactEffect.surface_impact_fx(physics_world, attacking_unit, hit_position, optional_hit_normal, hit_direction, damage_type, hit_type)
    if surface_impact_fx then

        local visual_loadout_extension = script_unit_extension(attacking_unit, "visual_loadout_system")
        if visual_loadout_extension then
            local inventory_component = visual_loadout_extension._inventory_component
            local wielded_slot = inventory_component and inventory_component.wielded_slot or visual_loadout_extension._wielded_slot
            
        end

    end

    -- Original function
    func(self, hit_position, hit_direction, source_parameters, attacking_unit, optional_hit_normal, damage_type, hit_type, optional_will_be_predicted, ...)

end)

mod:hook(CLASS.FxSystem, "play_shotshell_surface_impact_fx", function(func, self, fire_position, hit_positions, hit_normals, source_parameters, attacking_unit, damage_type, hit_type, optional_will_be_predicted, ...)

    local physics_world = self._physics_world
	local surface_impact_fxs = ImpactEffect.shotshell_surface_impact_fx(physics_world, fire_position, attacking_unit, hit_positions, hit_normals, damage_type, hit_type)
    for ii = 1, #surface_impact_fxs, 7 do
		local surface_impact_fx = surface_impact_fxs[ii]
        if surface_impact_fx then

            local visual_loadout_extension = script_unit_extension(attacking_unit, "visual_loadout_system")
            if visual_loadout_extension then
                local inventory_component = visual_loadout_extension._inventory_component
                local wielded_slot = inventory_component and inventory_component.wielded_slot or visual_loadout_extension._wielded_slot
                
            end

        end
    end

    -- Original function
    func(self, fire_position, hit_positions, hit_normals, source_parameters, attacking_unit, damage_type, hit_type, optional_will_be_predicted, ...)

end)
