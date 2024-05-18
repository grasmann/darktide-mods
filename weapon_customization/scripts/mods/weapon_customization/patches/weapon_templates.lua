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

local present_hook = function(func, self, item, ...)
    mod.previewed_weapon = {
        flashlight = mod:has_flashlight(item),
        laser_pointer = mod:has_laser_pointer(item),
        item = item
    }
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

--#region ToDo
    -- mod.special_template_changes = {
    --     shotgun_p1_m1 = function(gear_id, item, weapon_template)
    --         local muzzle = mod:get_gear_setting(gear_id, "muzzle", item)
    --         if muzzle then
    --             weapon_template.actions.action_shoot_hip.fx.
    --         end
    --     end,
    -- }

    -- mod.apply_special_templates = function(self, item)
        -- if item.item_type == WEAPON_RANGED or item.item_type == WEAPON_MELEE then
        --     local gear_id = self:get_gear_id(item)
        --     local templates = self:persistent_table(REFERENCE).weapon_templates
        --     local orig_weapon_template = WeaponTemplate.weapon_template_from_item(item)
        --     -- if not mod.test74326587435 then
        --     --     mod:dtf(orig_weapon_template, "orig_weapon_template", 10)
        --     --     mod.test74326587435 = true
        --     -- end
        --     if not templates[gear_id] and orig_weapon_template then
        --         templates[gear_id] = table_clone(orig_weapon_template)
        --     end
        --     local weapon_template = templates[gear_id]
        --     if mod.special_template_changes[weapon_template.name] then
        --         mod.special_template_changes[weapon_template.name](gear_id, item, weapon_template)
        --     end
        -- end
    -- end

    -- mod.template_add_torch = function(self, orig_weapon_template)
    --     if self.previewed_weapon and orig_weapon_template then
    --         local gear_id = self:get_gear_id(self.previewed_weapon.item)
    --         local templates = self:persistent_table(REFERENCE).weapon_templates

    --         if not templates[gear_id] then
    --             templates[gear_id] = table_clone(orig_weapon_template)
    --         end
    --         local weapon_template = templates[gear_id]
                
    --         if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
    --             weapon_template.displayed_weapon_stats_table.damage[3] = nil
    --         end

    --         if self.previewed_weapon.laser_pointer then
    --             weapon_template.displayed_attacks.special = {
    --                 type = "vent",
    --                 display_name = "loc_weapon_special_laser_pointer",
    --                 desc = "loc_stats_special_action_laser_pointer_desc",
    --             }
    --         elseif self.previewed_weapon.flashlight then
    --             weapon_template.displayed_attacks.special = {
    --                 desc = "loc_stats_special_action_flashlight_desc",
    --                 display_name = "loc_weapon_special_flashlight",
    --                 type = "flashlight",
    --             }
    --         end

    --         return weapon_template
    --     end
    -- 	return orig_weapon_template
    -- end
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/utilities/weapon/weapon_template", function(instance)

    instance.template_add_torch = function(self, orig_weapon_template)
        if mod.previewed_weapon and orig_weapon_template then
            local gear_id = mod:get_gear_id(mod.previewed_weapon.item)
            local templates = mod:persistent_table(REFERENCE).weapon_templates
    
            if not templates[gear_id] then
                templates[gear_id] = table_clone(orig_weapon_template)
            end
            local weapon_template = templates[gear_id]
                
            if weapon_template.displayed_weapon_stats_table and weapon_template.displayed_weapon_stats_table.damage[3] then
                weapon_template.displayed_weapon_stats_table.damage[3] = nil
            end
    
            if mod.previewed_weapon.laser_pointer then
                weapon_template.displayed_attacks.special = {
                    type = "vent",
                    display_name = "loc_weapon_special_laser_pointer",
                    desc = "loc_stats_special_action_laser_pointer_desc",
                }
            elseif mod.previewed_weapon.flashlight then
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

    mod:hook(instance, "current_weapon_template", function(func, weapon_action_component, ...)
        return instance:template_add_torch(func(weapon_action_component, ...))
    end)

    mod:hook(instance, "weapon_template_from_item", function(func, weapon_item, ...)
        return instance:template_add_torch(func(weapon_item, ...))
    end)

end)