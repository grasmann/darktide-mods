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
    local managers = Managers
    local string_format = string.format
    local table_is_empty = table.is_empty
    local table_clone_instance = table.clone_instance
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

local vector3_unbox = Vector3Box.unbox
local vector3_zero = Vector3.zero
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

    if render_context and render_context.custom_slot_name == "slot_primary_placement" then
        render_context = render_context or {}

		local player = managers.player:local_player(1)
		local profile = dummy_profile or player:profile()
		local gender_name = profile.gender
		local breed_name = profile.archetype.breed
		local archetype = profile.archetype
		local archetype_name = archetype and archetype.name

		dummy_profile = Items.create_mannequin_profile_by_item(real_item, gender_name, archetype_name, breed_name)
        dummy_profile.placement_name = render_context.placement_name
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
    elseif render_context and render_context.custom_slot_name == "slot_secondary_placement" then
        render_context = render_context or {}

		local player = managers.player:local_player(1)
		local profile = dummy_profile or player:profile()
		local gender_name = profile.gender
		local breed_name = profile.archetype.breed
		local archetype = profile.archetype
		local archetype_name = archetype and archetype.name

		dummy_profile = Items.create_mannequin_profile_by_item(real_item, gender_name, archetype_name, breed_name)
        dummy_profile.placement_name = render_context.placement_name
        dummy_profile.loadout.slot_gear_extra_cosmetic = profile.loadout.slot_gear_extra_cosmetic
        -- dummy_profile.loadout.slot_animation_end_of_round = profile.loadout.slot_animation_end_of_round
        local camera = mod.settings.placement_camera[render_context.placement_name]
        if camera then
            local position = camera.position and vector3_unbox(camera.position) or vector3_zero()
            render_context.icon_render_camera_position_offset = {position[1], position[2], position[3]}
        end

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