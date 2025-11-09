local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ImpactEffect = mod:original_require("scripts/utilities/attack/impact_effect")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local unit_attachment_callback = unit.attachment_callback
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.FxSystem, "play_impact_fx", function(func, self, impact_fx, position, direction, source_parameters, attacking_unit, optional_target_unit, optional_node_index, optional_hit_normal, optional_will_be_predicted, local_only_or_nil, ...)

    impact_fx.name = ""
    impact_fx.decal = ""
    impact_fx.linked_decal = ""
    impact_fx.blood_ball = ""

    -- Original function
    func(self, impact_fx, position, direction, source_parameters, attacking_unit, optional_target_unit, optional_node_index, optional_hit_normal, optional_will_be_predicted, local_only_or_nil, ...)

end)

mod:hook(CLASS.FxSystem, "play_surface_impact_fx", function(func, self, hit_position, hit_direction, source_parameters, attacking_unit, optional_hit_normal, damage_type, hit_type, optional_will_be_predicted, ...)

    local physics_world = self._physics_world
	local surface_impact_fx, hit_unit, hit_actor = ImpactEffect.surface_impact_fx(physics_world, attacking_unit, hit_position, optional_hit_normal, hit_direction, damage_type, hit_type)

    -- Original function
    func(self, hit_position, hit_direction, source_parameters, attacking_unit, optional_hit_normal, damage_type, hit_type, optional_will_be_predicted, ...)

end)

mod:hook(CLASS.FxSystem, "play_shotshell_surface_impact_fx", function(func, self, fire_position, hit_positions, hit_normals, source_parameters, attacking_unit, damage_type, hit_type, optional_will_be_predicted, ...)

    local physics_world = self._physics_world
	local surface_impact_fxs = ImpactEffect.shotshell_surface_impact_fx(physics_world, fire_position, attacking_unit, hit_positions, hit_normals, damage_type, hit_type)
    for ii = 1, #surface_impact_fxs, 7 do
		local surface_impact_fx = surface_impact_fxs[ii]

    end

    -- Original function
    func(self, fire_position, hit_positions, hit_normals, source_parameters, attacking_unit, damage_type, hit_type, optional_will_be_predicted, ...)

end)
