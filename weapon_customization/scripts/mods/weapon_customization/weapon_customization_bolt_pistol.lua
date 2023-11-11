local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local CLASS = CLASS
    local tostring = tostring
    local script_unit = ScriptUnit
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.bolt_pistol_reload = function(self, action_settings, t, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod.wielding_bolt_pistol then
        if mod.wielding_bolt_pistol == 2 then
            self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("bolter_p1_m1"), t)
        end
    end
end

mod.is_bolt_pistol = function(self, item)
    if item and item.__master_item and item.__master_item.attachments then
        if self:_recursive_find_attachment_name(item.__master_item.attachments, "receiver_06") then return true end
    end
end

-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐ ##############################################################################################
-- ##### ├─┤│ ││ │├┴┐└─┐ ##############################################################################################
-- ##### ┴ ┴└─┘└─┘┴ ┴└─┘ ##############################################################################################

mod:hook(CLASS.ActionReloadState, "_start_reload_state", function(func, self, reload_template, inventory_slot_component, action_reload_component, t, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) then
        self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("bolter_p1_m1"), t)
    end
    func(self, reload_template, inventory_slot_component, action_reload_component, t, ...)
end)

mod:hook(CLASS.ActionReloadState, "finish", function(func, self, reason, data, t, time_in_action, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) then
        self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("laspistol_p1_m1"), t)
    end
    func(self, reason, data, t, time_in_action, ...)
end)

mod:hook(CLASS.ActionRangedWield, "trigger_anim_event", function(func, self, anim_event, anim_event_3p, action_time_offset, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) and anim_event == "reload_end" and mod.wielding_bolt_pistol then
        self._animation_extension:anim_event_with_variable_floats_1p(anim_event, "attack_speed", .9, "action_time_offset", action_time_offset or 0, ...)
        if anim_event_3p then
            self._animation_extension:anim_event_with_variable_floats(anim_event_3p, "attack_speed", .9, "action_time_offset", action_time_offset or 0, ...)
        end
    else
        func(self, anim_event, anim_event_3p, action_time_offset, ...)
    end
end)

mod:hook(CLASS.ActionRangedWield, "running_action_state", function(func, self, t, time_in_action, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) and mod.wielding_bolt_pistol then
        if mod.wielding_bolt_pistol == 2 and time_in_action > .65 then
            self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("autopistol_p1_m1"), t)
            self:trigger_anim_event("reload_end", "reload_end")
            mod.wielding_bolt_pistol = 1
        elseif mod.wielding_bolt_pistol == 1 and time_in_action > 1.6 then
            self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("laspistol_p1_m1"), t)
            mod.wielding_bolt_pistol = nil
        end
    end
    func(self, t, time_in_action, ...)
end)

mod:hook(CLASS.ActionRangedWield, "start", function(func, self, action_settings, t, time_scale, action_start_params, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) then
        mod.wielding_bolt_pistol = 2
        self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("stubrevolver_p1_m1"), t)
    end
    func(self, action_settings, t, time_scale, action_start_params, ...)
end)

mod:hook(CLASS.ActionRangedWield, "finish", function(func, self, reason, data, t, time_in_action, ...)
    local template_name = self._weapon_template and self._weapon_template.name
    if template_name == "bolter_p1_m1" and mod:is_bolt_pistol(self._weapon.item) then
        self._animation_extension:inventory_slot_wielded(WeaponTemplate.weapon_template("laspistol_p1_m1"), t)
        mod.wielding_bolt_pistol = nil
    end
    func(self, reason, data, t, time_in_action, ...)
end)

-- mod:hook(CLASS.AuthoritativePlayerUnitAnimationExtension, "inventory_slot_wielded", function(func, self, weapon_template, ...)
    -- if weapon_template.name == "bolter_p1_m1" then
    --     weapon_template = WeaponTemplate.weapon_template("laspistol_p1_m1")
    -- else
    --     mod:echo(tostring(weapon_template.name))
    -- end
--     func(self, weapon_template, ...)
-- end)

-- mod:hook(CLASS.PlayerUnitAnimationExtension, "inventory_slot_wielded", function(func, self, weapon_template, t, ...)
--     if weapon_template.name == "bolter_p1_m1" then
--         weapon_template = WeaponTemplate.weapon_template("laspistol_p1_m1")
--     else
--         mod:echo(tostring(weapon_template.name))
--     end
--     func(self, weapon_template, t, ...)
-- end)

-- mod:hook(CLASS.PlayerUnitAnimationState, "set_anim_state_machine", function(func, player_unit, first_person_unit, weapon_template, is_local_unit, anim_variables_3p, anim_variables_1p)
    -- if weapon_template.name == "bolter_p1_m1" then
    --     weapon_template = WeaponTemplate.weapon_template("laspistol_p1_m1")
    -- else
    --     mod:echo(tostring(weapon_template.name))
    -- end
--     func(player_unit, first_person_unit, weapon_template, is_local_unit, anim_variables_3p, anim_variables_1p)
-- end)