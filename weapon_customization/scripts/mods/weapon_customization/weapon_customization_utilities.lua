local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local wwise_wwise_world = Wwise.wwise_world
    local world_physics_world = World.physics_world
	local string = string
    local string_gsub = string.gsub
    local string_find = string.find
    local math_floor = math.floor
    local tostring = tostring
    local pairs = pairs
    local game_parameters = GameParameters
    local script_unit = ScriptUnit
    local managers = Managers
    local CLASS = CLASS
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_needed_packages = function(self)
    local needed_packages = {
        "content/weapons/player/ranged/bolt_gun/attachments/sight_01/sight_01",
    }
	local packages = self:persistent_table("weapon_customization").loaded_packages
	local used = self:persistent_table("weapon_customization").used_packages
    for _, package_name in pairs(needed_packages) do
        if not managers.package:has_loaded(package_name) and not managers.package:is_loading(package_name) then
			packages.needed = packages.needed or {}
            packages.needed[package_name] = managers.package:load(package_name, "weapon_customization")
        end
        used[package_name] = true
    end
end

-- Extract item name from model string
mod.item_name_from_content_string = function(self, content_string)
	return string_gsub(content_string, '.*[%/%\\]', '')
end

-- Get currently wielded weapon
mod.get_wielded_weapon = function(self)
	local inventory_component = self.weapon_extension._inventory_component
	local weapons = self.weapon_extension._weapons
	return self.weapon_extension:_wielded_weapon(inventory_component, weapons)
end

-- Get wielded slot
mod.get_wielded_slot = function(self)
	local inventory_component = self.weapon_extension._inventory_component
	return inventory_component.wielded_slot
end

-- Get wielded 3p unit
mod.get_wielded_weapon_3p = function(self)
	return self.visual_loadout_extension:unit_3p_from_slot("slot_secondary")
end

-- Get equipped weapon from gear id
mod.get_weapon_from_gear_id = function(self, from_gear_id)
	if self.weapon_extension and self.weapon_extension._weapons then
		-- Iterate equipped itemslots
		for slot_name, weapon in pairs(self.weapon_extension._weapons) do
			-- Check gear id
			local gear_id = mod:get_gear_id(weapon.item)
			if from_gear_id == gear_id then
				-- Check weapon unit
				if weapon.weapon_unit then
					return slot_name, weapon
				end
			end
		end
	end
end

-- Check cached third person
mod.is_in_third_person = function(self)
	local is_third_person = self:_is_in_third_person()
	local changed = false
	if self.was_third_person == nil then self.was_third_person = is_third_person end
	if self.was_third_person ~= is_third_person then
		changed = true
	end
    return is_third_person, changed
end

-- Check third person
mod._is_in_third_person = function(self)
	local first_person_extension = script_unit.extension(self.player_unit, "first_person_system")
	local first_person = first_person_extension and first_person_extension:is_in_first_person_mode()
	return not first_person
end

-- Check cached character state
mod.character_state_changed = function(self)
	local changed = false
	local character_state = self:_character_state()
	if character_state ~= self.last_character_state then
		changed = true
	end
	return changed
end

-- Check character state
mod._character_state = function(self)
	return self.character_state_machine_extension:current_state()
end

mod.world = function(self)
    return managers.world:world("level_world")
end

mod.physics_world = function(self)
    return world_physics_world(self:world())
end

mod.wwise_world = function(self)
	return wwise_wwise_world(self:world())
end
