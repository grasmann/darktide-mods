local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local Items = mod:original_require("scripts/utilities/items")
local MasterItems = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local table = table
    local string = string
	local vector3 = Vector3
    local managers = Managers
	local table_clone = table.clone
	local vector3_box = Vector3Box
	local vector3_zero = vector3.zero
    local string_format = string.format
    local table_is_empty = table.is_empty
	local vector3_unbox = vector3_box.unbox
    local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.UIManager, "load_item_icon", function(func, self, real_item, cb, render_context, dummy_profile, prioritize, unload_cb, ...)

    local item_name = real_item.name
	local gear_id = real_item.gear_id or item_name
	local item

	if real_item.gear then
		item = MasterItems.create_preview_item_instance(real_item)
	else
		item = table_clone_instance(real_item)
	end

	item.gear_id = gear_id

	local slots = item.slots or {}
	local item_type = item.item_type

    if render_context and render_context.custom_slot_name then

        render_context = render_context or {}

		local player = managers.player:local_player(1)
		local profile = dummy_profile or player:profile()
		local gender_name = profile.gender
		local breed_name = profile.archetype.breed
		local archetype = profile.archetype
		local archetype_name = archetype and archetype.name

		dummy_profile = Items.create_mannequin_profile_by_item(real_item, gender_name, archetype_name, breed_name)
        
		-- dummy_profile.loadout.slot_primary = profile.loadout.slot_primary
		-- dummy_profile.loadout.slot_secondary = profile.loadout.slot_secondary
		-- Copy profile loadout
		dummy_profile.loadout.slot_body_face_tattoo = profile.loadout.slot_body_face_tattoo
		dummy_profile.loadout.slot_body_hair_color = profile.loadout.slot_body_hair_color
		dummy_profile.loadout.slot_body_eye_color = profile.loadout.slot_body_eye_color
		dummy_profile.loadout.slot_body_face = profile.loadout.slot_body_face
		dummy_profile.loadout.slot_body_tattoo = profile.loadout.slot_body_tattoo
		dummy_profile.loadout.slot_body_legs = profile.loadout.slot_body_legs
		dummy_profile.loadout.slot_body_face_hair = profile.loadout.slot_body_face_hair
		dummy_profile.loadout.slot_body_torso = profile.loadout.slot_body_torso
		dummy_profile.loadout.slot_body_skin_color = profile.loadout.slot_body_skin_color
		dummy_profile.loadout.slot_body_face_scar = profile.loadout.slot_body_face_scar
		dummy_profile.loadout.slot_body_arms = profile.loadout.slot_body_arms
		dummy_profile.loadout.slot_body_hair = profile.loadout.slot_body_hair
		-- Copy profile loadout
		dummy_profile.loadout.slot_gear_head = profile.loadout.slot_gear_head
		dummy_profile.loadout.slot_gear_lowerbody = profile.loadout.slot_gear_lowerbody
		dummy_profile.loadout.slot_gear_upperbody = profile.loadout.slot_gear_upperbody
		dummy_profile.loadout.slot_gear_extra_cosmetic = profile.loadout.slot_gear_extra_cosmetic

		local item_slot_name

		if real_item.slots and not table_is_empty(item.slots) then
			dummy_profile.loadout[item.slots[1]] = real_item
		end

		local prop_item_key = item.prop_item
		local prop_item = prop_item_key and prop_item_key ~= "" and MasterItems.get_item(prop_item_key)

		if prop_item then
			local prop_item_slot = prop_item.slots[1]

			dummy_profile.loadout[prop_item_slot] = prop_item
			render_context.wield_slot = prop_item_slot
		end

		local icon_camera_position_offset = item.icon_camera_position_offset
        icon_camera_position_offset = {1, 1, 1}

		if icon_camera_position_offset then
			render_context.icon_camera_position_offset = icon_camera_position_offset
		else
			render_context.icon_camera_position_offset = nil
		end

		local icon_camera_rotation_offset = item.icon_camera_rotation_offset

		if icon_camera_rotation_offset then
			render_context.icon_camera_rotation_offset = icon_camera_rotation_offset
		else
			render_context.icon_camera_rotation_offset = nil
		end

		render_context.ignore_companion = not render_context.companion_state_machine and (real_item.companion_state_machine == "" or real_item.companion_state_machine == nil)
		dummy_profile.character_id = string_format("%s_%s_%s", gear_id, dummy_profile.breed, dummy_profile.gender)

		local instance = self._back_buffer_render_handlers.cosmetics

		return instance:load_profile_portrait(dummy_profile, cb, render_context, prioritize, unload_cb)

    else
        -- Original function
        return func(self, real_item, cb, render_context, dummy_profile, prioritize, unload_cb, ...)
    end
end)