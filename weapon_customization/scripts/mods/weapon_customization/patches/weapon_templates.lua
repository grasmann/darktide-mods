local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local WeaponTemplates = mod:original_require("scripts/settings/equipment/weapon_templates/weapon_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table = table
    local table_clone = table.clone
    local CLASS = CLASS
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ################################################
-- ##### │││├┤ ├─┤├─┘│ ││││   │ ├┤ │││├─┘│  ├─┤ │ ├┤   ├─┘├─┤ │ │  ├─┤ ################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘   ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ################################################

local present_hook = function(func, self, item, ...)
    mod.previewed_weapon = {f = mod:has_flashlight(item), l = mod:has_laser_pointer(item)}
	local ret = func(self, item, ...)
    mod.previewed_weapon = nil
    return ret
end

mod:hook(CLASS.ViewElementWeaponStats, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponActions, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponInfo, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponPatterns, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponActionsExtended, "present_item", present_hook)
mod:hook(CLASS.WeaponStats, "get_compairing_stats", function(func, self, ...)
    return present_hook(func, self, self._item, ...)
end)

mod.template_add_torch = function(self, orig_weapon_template)
    if self.previewed_weapon and orig_weapon_template then
        local templates = self:persistent_table(REFERENCE).weapon_templates
        if not templates[orig_weapon_template.name] then
            templates[orig_weapon_template.name] = table_clone(orig_weapon_template)
        end
        local weapon_template = templates[orig_weapon_template.name]
            
        if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
            weapon_template.displayed_weapon_stats_table.damage[3] = nil
        end

        if self.previewed_weapon.l then
            weapon_template.displayed_attacks.special = {
                type = "vent",
                display_name = "loc_weapon_special_laser_pointer",
                desc = "loc_stats_special_action_laser_pointer_desc",
            }
        elseif self.previewed_weapon.f then
            weapon_template.displayed_attacks.special = {
                desc = "loc_stats_special_action_flashlight_desc",
                display_name = "loc_weapon_special_flashlight",
                type = "flashlight",
            }
        end

        return weapon_template
    end
	return orig_weapon_template
end

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)

    -- mod:hook(instance, "weapon_template", function(func, template_name, ...)
    --     local weapon_template = func(template_name, ...)
    --     -- local weapon_template = mod:template_set_bolt_pistol(weapon_template)
	-- 	return mod:template_add_torch(weapon_template)
    -- end)

    -- current_weapon_template = function (weapon_action_component)
	-- 	return WeaponTemplates[weapon_action_component.template_name]
	-- end
    mod:hook(instance, "current_weapon_template", function(func, weapon_action_component, ...)
        return mod:template_add_torch(func(weapon_action_component, ...))
    end)

    -- WeaponTemplate.weapon_template_from_item = function (weapon_item)
    --     if not weapon_item then
    --         return nil
    --     end
    
    --     local weapon_template_name = weapon_item.weapon_template
    --     local weapon_progression_template_name = weapon_item.weapon_progression_template
    
    --     if weapon_progression_template_name then
    --         return WeaponTemplates[weapon_progression_template_name]
    --     end
    
    --     return WeaponTemplates[weapon_template_name]
    -- end
    mod:hook(instance, "weapon_template_from_item", function(func, weapon_item, ...)
        return mod:template_add_torch(func(weapon_item, ...))
    end)

	-- if not instance._weapon_template then instance._weapon_template = instance.weapon_template end
	-- instance.weapon_template = function(template_name)
	-- 	local weapon_template = instance._weapon_template(template_name)
    --     -- local weapon_template = mod:template_set_bolt_pistol(weapon_template)
	-- 	return mod:template_add_torch(weapon_template)
	-- end
end)