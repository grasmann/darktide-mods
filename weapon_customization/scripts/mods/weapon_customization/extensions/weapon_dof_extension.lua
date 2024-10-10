local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local math = math
    local table = table
    local pairs = pairs
    local class = class
    local managers = Managers
    local tostring = tostring
    local Viewport = Viewport
    local math_lerp = math.lerp
    local Application = Application
    local math_clamp01 = math.clamp01
    local math_ease_sine = math.ease_sine
    local table_contains = table.contains
    local ShadingEnvironment = ShadingEnvironment
    local application_user_setting = Application.user_setting
    local shading_environment_scalar = ShadingEnvironment.scalar
    local shading_environment_set_scalar = ShadingEnvironment.set_scalar
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local SLOT_PRIMARY = "slot_primary"
    local SLOT_SECONDARY = "slot_secondary"
    local SLOT_UNARMED = "slot_unarmed"
    local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local WeaponDOFExtension = class("WeaponDOFExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

WeaponDOFExtension.init = function(self, extension_init_context, unit, extension_init_data)
    WeaponDOFExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Attributes
    self.wielded_slot = extension_init_data.wielded_slot or SLOT_UNARMED
    self.ranged_weapon = extension_init_data.ranged_weapon
    self.dof_near_scale = 0
    self.last_target = 0
    self.target = 0
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Set values
    self:on_settings_changed()
    self:set_weapon_values()
    -- Set initialized
    self.initialized = true
end

WeaponDOFExtension.delete = function(self)
    managers.event:unregister(self, "weapon_customization_settings_changed")
    -- Set uninitialized
    self.initialized = false
    -- Delete
    WeaponDOFExtension.super.delete(self)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

WeaponDOFExtension.set_weapon_values = function(self)
    local gear_settings = mod.gear_settings
    self.sights = {
        gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight"),
        gear_settings:_recursive_find_attachment(self.ranged_weapon.item.attachments, "sight_2"),
    }
    self.sight = self.sights[2] or self.sights[1]
    self.sight_name = self.sights[1] and mod.gear_settings:short_name(self.sights[1].item)
    local actions = self.ranged_weapon.weapon_template.actions
    self.start_time = actions.action_zoom and actions.action_zoom.total_time or actions.action_wield.total_time
    self.reset_time = actions.action_unzoom and actions.action_unzoom.total_time or actions.action_wield.total_time
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

WeaponDOFExtension.on_aim_start = function(self, t)
    self._is_aiming = true
end

-- WeaponDOFExtension.on_equip_slot = function(self, slot)
--     self._is_aiming = nil
--     self._is_scope = nil
--     self._is_sniper = nil
--     self._is_braced = nil
--     self.dirty = true
-- end

WeaponDOFExtension.on_wield_slot = function(self, slot)
    self._is_scope = nil
    self._is_sniper = nil
    self._is_braced = nil
    self.wielded_slot = slot
    self.dirty = true
end

WeaponDOFExtension.on_aim_stop = function(self, t)
    self._is_aiming = nil
end

WeaponDOFExtension.on_unaim_start = function(self, t)
    self._is_aiming = nil
end

WeaponDOFExtension.on_settings_changed = function(self)
    -- self.value = mod:get("mod_option_misc_weapon_dof")
    self.no_aim = mod:get("mod_option_misc_weapon_dof_no_aim")
    self.no_aim_strength = 5 * mod:get("mod_option_misc_weapon_dof_strength_no_aim")
    self.scope = mod:get("mod_option_misc_weapon_dof_scope")
    self.scope_strength = 5 * mod:get("mod_option_misc_weapon_dof_strength_scope")
    self.sight = mod:get("mod_option_misc_weapon_dof_sight")
    self.sight_strength = 5 * mod:get("mod_option_misc_weapon_dof_strength_sight")
    self.dirty = true
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

WeaponDOFExtension.is_braced = function(self)
    -- Check cache
    if self._is_braced == nil then
        -- Get value
        local template = self.ranged_weapon.weapon_template
        local alt_fire = template and template.alternate_fire_settings
        self._is_braced = alt_fire and alt_fire.start_anim_event == "to_braced"
    end
    -- Return cache
    return self._is_braced
end

WeaponDOFExtension.is_scope = function(self)
    -- Check cache
    if self._is_scope == nil then
        -- Get value
        self._is_scope = table_contains(mod.reflex_sights, self.sight_name)
    end
    -- Return cache
    return self._is_scope
end

WeaponDOFExtension.is_aiming = function(self)
    return self.alternate_fire_component and self.alternate_fire_component.is_active
end

WeaponDOFExtension.is_sight = function(self)
    return not self:is_scope() and not self:is_sniper()
end

WeaponDOFExtension.is_sniper = function(self)
    -- Check cache
    if self._is_sniper == nil then
        -- Get value
        self._is_sniper = table_contains(mod.scopes, self.sight_name) and not self:is_braced()
    end
    -- Return cache
    return self._is_sniper
end

WeaponDOFExtension.is_sniper_or_scope = function(self)
    return self:is_scope() or self:is_sniper()
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

WeaponDOFExtension.update = function(self, dt, t)
    local is_aiming = self:is_aiming()
    local no_aim = not is_aiming and self.no_aim
    local scope = is_aiming and self:is_sniper_or_scope() and self.scope
    local sight = is_aiming and self:is_sight() and self.sight
    local slot = self.wielded_slot and (self.wielded_slot.name == SLOT_SECONDARY or self.wielded_slot.name == SLOT_PRIMARY)

    if slot and (self._is_aiming ~= self.last_aiming or self.dirty) then
        local target = 0

        if self._is_aiming then
            if scope then
                target = self.scope_strength
            elseif sight then
                target = self.sight_strength
            end

        elseif no_aim then
            target = self.no_aim_strength
        end

        self.do_lerp = self.target ~= target
        self.last_target = self.target
        self.target = target or 0
        self.last_aiming = self._is_aiming
        self.dirty = nil
    elseif not slot and self.target ~= 0 then
        self.do_lerp = true
        self.last_target = self.target
        self.target = 0
        self.dirty = nil
    end

    local start_time = self.start_time
    local timer = self.lerp_timer

    if self.do_lerp then
        local time = is_aiming and start_time or self.reset_time
        self.lerp_timer = t + time
        self.do_lerp = nil
    elseif timer and t < timer then
        local time_in_action = math_clamp01(start_time - (timer - t))
        local progress = time_in_action / start_time
        local anim_progress = math_ease_sine(progress)
        self.dof_near_scale = math_lerp(self.last_target, self.target, anim_progress)
    elseif timer and t >= timer then
        self.dof_near_scale = self.target
        self.lerp_timer = nil
    end

end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

WeaponDOFExtension.apply_weapon_dof = function(self, shading_env)
    -- Set depth of field
    shading_environment_set_scalar(shading_env, "dof_enabled", 1)
    shading_environment_set_scalar(shading_env, "dof_focal_distance", .5)
    shading_environment_set_scalar(shading_env, "dof_focal_region", 50)
    shading_environment_set_scalar(shading_env, "dof_focal_region_start", -1)
    shading_environment_set_scalar(shading_env, "dof_focal_region_end", 49)
    shading_environment_set_scalar(shading_env, "dof_focal_near_scale", self.dof_near_scale)
    shading_environment_set_scalar(shading_env, "dof_focal_far_scale", .5)
end

return WeaponDOFExtension