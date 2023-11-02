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

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local COSMETIC_VIEW = "inventory_cosmetics_view"

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.find_attachment_entry_in_mod = function(self, name)
	for weapon_name, weapon_data in pairs(self.attachment_models) do
		for attachment_name, attachment_data in pairs(weapon_data) do
			if attachment_data.model == name then
				return true
			end
		end
	end
end

mod.attachment_entry_is_weapon = function(self, name)
	for weapon_name, weapon_data in pairs(self.attachment_models) do
		if string_find(name, weapon_name) then
			return true
		end
	end
end

mod.find_attachment_entries = function(self)
	self:setup_item_definitions()
	local ranged_definitions = {}
	local melee_definitions = {}
	local item_definitions = self:persistent_table(REFERENCE).item_definitions
	for name, data in pairs(item_definitions) do
		if not self:find_attachment_entry_in_mod(name) and not self:attachment_entry_is_weapon(name) then
			if string_find(name, _item_ranged) then
				ranged_definitions[name] = data
			elseif string_find(name, _item_melee) then
				melee_definitions[name] = data
			end
		end
	end
	self:dtf(ranged_definitions, "ranged_definitions", 15)
	self:dtf(melee_definitions, "melee_definitions", 15)
end

mod.release_non_essential_packages = function(self)
	-- Release all non-essential packages
	local unloaded_packages = {}
	local lists = {"visible_equipment", "view_weapon_sounds"}
	for _, list in pairs(lists) do
		for package_name, package_id in pairs(self:persistent_table(REFERENCE).loaded_packages[list]) do
			unloaded_packages[package_name] = package_id
			self:persistent_table(REFERENCE).used_packages[list][package_name] = nil
		end
		self:persistent_table(REFERENCE).loaded_packages[list] = {}
	end
	for package_name, package_id in pairs(unloaded_packages) do
		managers.package:release(package_id)
	end
end

mod.load_needed_packages = function(self)
    local _needed_packages = {
        "content/weapons/player/ranged/bolt_gun/attachments/sight_01/sight_01",
		"content/fx/particles/enemies/sniper_laser_sight",
		"content/fx/particles/enemies/red_glowing_eyes",
		"content/characters/player/human/third_person/animations/lasgun_pistol",
		"content/characters/player/human/first_person/animations/lasgun_pistol",
		"content/characters/player/human/third_person/animations/stubgun_pistol",
		"content/characters/player/human/first_person/animations/stubgun_pistol",
		"content/characters/player/human/third_person/animations/autogun_pistol",
		"content/characters/player/human/first_person/animations/autogun_pistol",
    }
    for _, package_name in pairs(_needed_packages) do
		if not self:persistent_table(REFERENCE).loaded_packages.needed[package_name] then
			self:persistent_table(REFERENCE).used_packages.needed[package_name] = true
            self:persistent_table(REFERENCE).loaded_packages.needed[package_name] = managers.package:load(package_name, REFERENCE)
        end
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

mod.wwise_world = function(self, world)
	local world = world or self:world()
	return wwise_wwise_world(world)
end

mod.get_cosmetic_view = function(self)
    return managers.ui:view_active(COSMETIC_VIEW) and managers.ui:view_instance(COSMETIC_VIEW) or nil
end
