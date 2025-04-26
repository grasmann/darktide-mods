local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local WeaponTemplates = mod:original_require("scripts/settings/equipment/weapon_templates/weapon_templates")
    local WeaponTemplate = mod:original_require("scripts/utilities/weapon/weapon_template")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local table = table
    local CLASS = CLASS
    local table_clone = table.clone
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local REFERENCE = "weapon_customization"
    local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
--#endregion

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬ ################################################
-- ##### │││├┤ ├─┤├─┘│ ││││   │ ├┤ │││├─┘│  ├─┤ │ ├┤   ├─┘├─┤ │ │  ├─┤ ################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘   ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘  ┴  ┴ ┴ ┴ └─┘┴ ┴ ################################################

mod.previewed_weapon = {
    flashlight = false,
    laser_pointer = false,
    item = false,
    active = false,
}

local present_hook = function(func, self, item, ...)
    local previewed_weapon = mod.previewed_weapon
    previewed_weapon.flashlight = mod:has_flashlight(item)
    previewed_weapon.laser_pointer = mod:has_laser_pointer(item)
    previewed_weapon.item = item
    previewed_weapon.active = true
	local ret = func(self, item, ...)
    previewed_weapon.active = false
    return ret
end

mod:hook(CLASS.ViewElementWeaponStats, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponActions, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponInfo, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponPatterns, "present_item", present_hook)
mod:hook(CLASS.ViewElementWeaponActionsExtended, "present_item", present_hook)
mod:hook(CLASS.ViewElementInventoryWeaponPreview, "present_item", present_hook)
mod:hook(CLASS.CraftingView, "start_present_item", present_hook)
mod:hook(CLASS.InventoryBackgroundView, "start_present_item", present_hook)
mod:hook(CLASS.StoreItemDetailView, "_present_item", present_hook)
mod:hook(CLASS.WeaponStats, "get_comparing_stats", function(func, self, ...)
    return present_hook(func, self, self._item, ...)
end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)

    instance.template_add_torch = function(self, orig_weapon_template)
        local previewed_weapon = mod.previewed_weapon
        local is_weapon = orig_weapon_template and (instance.is_ranged(orig_weapon_template) or instance.is_melee(orig_weapon_template))
        if is_weapon and previewed_weapon.active then
            local gear_id = mod.gear_settings:item_to_gear_id(previewed_weapon.item)
            local templates = mod:persistent_table(REFERENCE).weapon_templates
    
            if not templates[gear_id] then
                templates[gear_id] = table_clone(orig_weapon_template)
            end
            local weapon_template = templates[gear_id]
                
            if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
                weapon_template.displayed_weapon_stats_table.damage[3] = nil
            end
    
            if previewed_weapon.laser_pointer then
                weapon_template.displayed_attacks.special = {
                    type = "vent",
                    display_name = "loc_weapon_special_laser_pointer",
                    desc = "loc_stats_special_action_laser_pointer_desc",
                }
            elseif previewed_weapon.flashlight then
                weapon_template.displayed_attacks.special = {
                    desc = "loc_stats_special_action_flashlight_desc",
                    display_name = "loc_weapon_special_flashlight",
                    type = "flashlight",
                }
            else
                weapon_template.displayed_attacks.special = orig_weapon_template.displayed_attacks.special
                weapon_template.displayed_weapon_stats_table.damage[3] = orig_weapon_template.displayed_weapon_stats_table.damage[3]
            end
    
            return weapon_template
        end
        return orig_weapon_template
    end

    mod:hook(instance, "current_weapon_template", function(func, weapon_action_component, ...)
        return instance:template_add_torch(func(weapon_action_component, ...))
    end)

    mod:hook(instance, "weapon_template_from_item", function(func, weapon_item, ...)
        return instance:template_add_torch(func(weapon_item, ...))
    end)

end)