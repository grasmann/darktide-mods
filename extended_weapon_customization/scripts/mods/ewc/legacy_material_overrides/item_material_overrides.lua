local mod = get_mod("extended_weapon_customization")

local ItemPackage = mod:original_require("scripts/foundation/managers/package/utilities/item_package")

local item_material_overrides_name = "ItemMaterialOverrides"
local item_material_overrides = {}

local function _include_material_override_definition(file_name)
	local definition = mod:io_dofile(file_name)

	for override_name, entry_data in pairs(definition) do
		entry_data.name = override_name
		entry_data.resource_dependencies = {}

		ItemPackage.compile_resource_dependencies(entry_data, entry_data.resource_dependencies)

		local entry = entry_data

		item_material_overrides[override_name] = entry
	end
end

-- _include_material_override_definition("scripts/settings/equipment/item_material_overrides/item_material_overrides_ammo")
_include_material_override_definition("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_colors")
_include_material_override_definition("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_materials")
_include_material_override_definition("extended_weapon_customization/scripts/mods/ewc/legacy_material_overrides/item_material_overrides_gear_patterns")

return settings(item_material_overrides_name, item_material_overrides)
