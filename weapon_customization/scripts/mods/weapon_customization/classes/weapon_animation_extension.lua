local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local MasterItems = mod:original_require("scripts/backend/master_items")
local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local table = table
    local Color = Color
    local class = class
    local pairs = pairs
    local math_pi = math.pi
    local Camera = Camera
    local math_min = math.min
    local math_max = math.max
    local math_sin = math.sin
    local vector3 = Vector3
    local vector2 = Vector2
    local wc_perf = wc_perf
    local math_lerp = math.lerp
    local math_ceil = math.ceil
    local unit_box = Unit.box
    local managers = Managers
    local table_size = table.size
    local table_find = table.find
    local table_sort = table.sort
    local unit_alive = Unit.alive
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local table_insert = table.insert
    local table_remove = table.remove
    local table_reverse = table.reverse
    local unit_get_data = Unit.get_data
    local table_contains = table.contains
    local vector3_equal = vector3.equal
    local vector3_unbox = vector3_box.unbox
    local unit_num_meshes = Unit.num_meshes
    local unit_debug_name = Unit.debug_name
    local math_easeInCubic = math.easeInCubic
    local math_easeOutCubic = math.easeOutCubic
    local unit_local_position = Unit.local_position
    local unit_local_rotation = Unit.local_rotation
    local script_gui_hud_line = ScriptGui.hud_line
    local unit_set_local_scale = Unit.set_local_scale
    local unit_get_child_units = Unit.get_child_units
    local camera_world_rotation = Camera.world_rotation
    local math_ease_out_elastic = math.ease_out_elastic
    local camera_world_to_screen = Camera.world_to_screen
    local camera_world_position = Camera.world_position
    local matrix4x4_translation = Matrix4x4.translation
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_mesh_visibility = Unit.set_mesh_visibility
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local math_round_with_precision = math.round_with_precision
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local MOVE_RESET_TIME = 1
local MOVE_IN_DURATION = 1
local MOVE_OUT_DURATION = .5
local REFERENCE = "weapon_customization"

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ######################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├─┤│││││││├─┤ │ ││ ││││  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ######################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ######################################

local WeaponAnimationExtension = class("WeaponAnimationExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

WeaponAnimationExtension.init = function(self, extension_init_context, unit, extension_init_data)
    WeaponAnimationExtension.super.init(self, extension_init_context, unit, extension_init_data)

    mod:echo("WeaponAnimationExtension.Init")
    -- Units
    self.ui_weapon_spawner = extension_init_data.ui_weapon_spawner
    self.camera = self.ui_weapon_spawner._camera
    self.weapon_spawn_data = self.ui_weapon_spawner._weapon_spawn_data
    self.weapon_unit = self.weapon_spawn_data.item_unit_3p
    self.attachment_units = self.weapon_spawn_data.attachment_units_3p
    self.link_unit = self.weapon_spawn_data.link_unit
    -- self:set_units()
    self.link_unit_position = self.link_unit and vector3_box(unit_local_position(self.link_unit, 1))
    self.link_unit_base_position = self.link_unit_position
    -- Values
    self.animations = {}
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Settings
    self:on_settings_changed()
    -- Init
    self.initialized = true
end

WeaponAnimationExtension.delete = function(self)
    mod:echo("WeaponAnimationExtension.delete")

    managers.event:unregister(self, "weapon_customization_settings_changed")
    self.initialized = false

    mod:echo("Delete WeaponAnimationExtension")

    WeaponAnimationExtension.super.delete(self)
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

WeaponAnimationExtension.on_settings_changed = function(self)
    mod:echo("WeaponAnimationExtension.on_settings_changed")
    self.carousel = mod:get("mod_option_carousel")
    self.camera_zoom = mod:get("mod_option_camera_zoom")
end

-- WeaponAnimationExtension.on_spawn_item = function(self)

-- end

-- WeaponAnimationExtension.on_despawn_item = function(self)

-- end

-- WeaponAnimationExtension.on_streaming_complete = function(self)

-- end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

WeaponAnimationExtension.is_animated = function(self, attachment_slot)
	for _, animation in pairs(self.animations) do
		if animation.slot == attachment_slot then
			return animation
		end
	end
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

-- WeaponAnimationExtension.set_units = function(self)
--     local weapon_spawn_data = self:weapon_spawn_data()
--     if weapon_spawn_data then
--         self.weapon_unit = weapon_spawn_data.item_unit_3p
--         self.attachment_units = weapon_spawn_data.attachment_units_3p
--         self.link_unit = weapon_spawn_data.link_unit
--     end
-- end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

WeaponAnimationExtension.unit_from_slot = function(self, attachment_slot)
    for _, unit in pairs(self.attachment_units) do
        if unit_get_data(unit, "attachment_slot") == attachment_slot then
            return unit
        end
    end
end

WeaponAnimationExtension.focus = function(self, attachment_slot, optional_reset)
    mod:echo("WeaponAnimationExtension.focus: "..tostring(attachment_slot))
    local focus_unit = self:unit_from_slot(attachment_slot)
    local position = unit_local_position(focus_unit, 1)
    position = vector3(position[1], 0, position[3])
    self:move(position, optional_reset)
end

WeaponAnimationExtension.move = function(self, position, optional_reset)
    mod:echot("start move "..tostring(position))
    self.do_move = true
    self.do_reset = optional_reset
    if position then
		self.position = position
	else
		self.position = vector3_box(vector3_zero())
	end
end

--#region Old
    -- mod.remove_weapon_part_animation = function(self, attachment_slot)
    -- 	for index, animation in pairs(self.animations) do
    -- 		if animation.slot == attachment_slot then
    -- 			table_remove(self.animations, index)
    -- 			break
    -- 		end
    -- 	end
    -- end

    -- local _children_sort_function = function(entry_1, entry_2)
    -- 	local distance_1 = entry_1.children or (entry_1.slot == "rail" and 1) or 0
    -- 	local distance_2 = entry_2.children or (entry_1.slot == "rail" and 1) or 0

    -- 	return distance_1 < distance_2
    -- end

    -- mod.do_weapon_part_animation = function(self, item, attachment_slot, attachment_type, new_attachment, no_children, speed, hide_ui, callback)
    -- 	local hide_ui = hide_ui == nil and true or hide_ui
    -- 	local existing_animation = self:weapon_part_animation_exists(attachment_slot)
    -- 	if not existing_animation then
    -- 		local modified_attachment_slot = self:_recursive_find_attachment(item.attachments, attachment_slot)
    -- 		-- Main animation
    -- 		local detach_only = attachment_type == "detach_only"
    -- 		local attach_only = attachment_type == "attach"
    -- 		-- attachment_type = attachment_type == "detach_only" and "detach" or attachment_type
    -- 		local real_type = attachment_type == "detach_only" and "detach" or attachment_type
    -- 		self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
    -- 			slot = attachment_slot,
    -- 			type = real_type,
    -- 			new = new_attachment,
    -- 			old = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot, item),
    -- 			children = modified_attachment_slot and modified_attachment_slot.children and #modified_attachment_slot.children or 0,
    -- 			speed = speed,
    -- 			detach_only = detach_only,
    -- 			attach_only = attach_only,
    -- 			hide = detach_only,
    -- 			callback = callback,
    -- 		}
    -- 		if hide_ui == true and mod:get("mod_option_camera_hide_ui") then
    -- 			self.cosmetics_view._visibility_toggled_on =  true
    -- 			self.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
    -- 		end
    -- 		-- Get auto equipy
    -- 		-- local auto_equips = self:get_auto_equips(item, attachment_slot, new_attachment)
    -- 		-- Get modified attachment slot
    -- 		local children = {}

    -- 		-- Trigger move
    -- 		local item_name = self.cosmetics_view._item_name
    -- 		local attachment_data = self.attachment_models[item_name][new_attachment]
    -- 		local trigger_move = attachment_data and attachment_data.trigger_move
    -- 		attachment_data = self:_apply_anchor_fixes(item, attachment_slot) or attachment_data
    -- 		trigger_move = attachment_data and attachment_data.trigger_move or trigger_move
    -- 		if trigger_move then
    -- 			for _, trigger_attachment_slot in pairs(trigger_move) do
    -- 				children[#children+1] = {slot = trigger_attachment_slot}
    -- 			end
    -- 		end

    -- 		if modified_attachment_slot and (modified_attachment_slot.children or #children > 0) and not no_children then
    -- 			-- Find attached children
    -- 			if modified_attachment_slot and modified_attachment_slot.children then
    -- 				self:_recursive_get_attachments(modified_attachment_slot.children, children)
    -- 			end
    -- 			-- Has children?
    -- 			if children and #children > 0 then
    -- 				-- Iterate children
    -- 				for i, child in pairs(children) do
    -- 					if not self:weapon_part_animation_exists(child.slot) then
    -- 						local new_child_attachment = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item)
    -- 						-- local old_child_attachment = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item)
                            
    -- 						self:do_weapon_part_animation(item, child.slot, attachment_type, new_child_attachment, no_children, speed, hide_ui) --, callback)
    -- 					-- 	local modified_child_attachment_slot = self:_recursive_find_attachment(item.attachments, child.slot)
    -- 					-- 	mod:echo("trigger: "..tostring(child.slot))
    -- 					-- 	self.weapon_part_animation_entries[#self.weapon_part_animation_entries+1] = {
    -- 					-- 		slot = child.slot,
    -- 					-- 		type = attachment_type,
    -- 					-- 		new = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot),
    -- 					-- 		old = self:get_gear_setting(self.cosmetics_view._gear_id, child.slot, item),
    -- 					-- 		children = modified_child_attachment_slot and modified_child_attachment_slot.children and #modified_child_attachment_slot.children or 0,
    -- 					-- 		speed = speed,
    -- 					-- 		detach_only = detach_only,
    -- 					-- 		hide = false,
    -- 					-- 	}
    -- 					end
    -- 				end
    -- 			end
    -- 		end
    -- 	elseif existing_animation and existing_animation.new == existing_animation.old and new_attachment ~= existing_animation.new then
    -- 		existing_animation.new = new_attachment
    -- 	end
    -- 	-- Attachment order
    -- 	table_sort(self.weapon_part_animation_entries, _children_sort_function)
    -- 	-- if #self.weapon_part_animation_entries > 0 then
    -- 	-- 	for i, entry in pairs(self.weapon_part_animation_entries) do
    -- 	-- 		local modified_attachment_slot = self:_recursive_find_attachment(item.attachments, entry.slot)
    -- 	-- 		if (modified_attachment_slot.children and #modified_attachment_slot.children > 0) or entry.slot == "rail" then
    -- 	-- 			table_remove(self.weapon_part_animation_entries, i)
    -- 	-- 			table_insert(self.weapon_part_animation_entries, 1, entry)
    -- 	-- 		end
    -- 	-- 	end
    -- 	-- end
    -- end

    -- mod.detach_attachment = function(self, item, attachment_slot, attachment, new_attachment, no_children, speed, hide_ui, attachment_type, callback)
    -- 	local item_name = self.cosmetics_view._item_name
    -- 	local attachment_type = attachment_type or "detach"
    -- 	self:do_weapon_part_animation(item, attachment_slot, attachment_type, new_attachment, no_children, speed, hide_ui, callback)
    -- 	local attachment_data = self.attachment_models[item_name][new_attachment]
    -- 	if attachment then
    -- 		attachment_data = self.attachment_models[item_name][attachment] or attachment_data
    -- 	end
    -- 	local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
    -- 	-- if not self:vector3_equal(movement, vector3_zero()) and attachment_type ~= "attach" then
    -- 	-- 	self:play_attachment_sound(item, attachment_slot, attachment, attachment_type)
    -- 	-- end
    -- end

    -- mod.load_new_attachment = function(self, item, attachment_slot, attachment, no_update)
    -- 	if self.cosmetics_view._gear_id then
    -- 		if attachment_slot and attachment then
    -- 			if not self.original_weapon_settings[attachment_slot] and not table_contains(self.automatic_slots, attachment_slot) then
    -- 				if not self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot) then
    -- 					self.original_weapon_settings[attachment_slot] = "default"
    -- 				else
    -- 					self.original_weapon_settings[attachment_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, attachment_slot)
    -- 				end
    -- 			end

    -- 			self:set_gear_setting(self.cosmetics_view._gear_id, attachment_slot, attachment)

    -- 			-- self:get_attachment_weapon_name(item, attachment_slot, attachment)

    -- 			self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
    -- 			self:resolve_auto_equips(self.cosmetics_view._presentation_item)
    -- 			-- local attachment_data = self.attachment_models[self.cosmetics_view._item_name][attachment]
    -- 			-- if attachment_data and attachment_data.special_resolve then
    -- 			-- 	local special_changes = attachment_data.special_resolve(self.cosmetics_view._gear_id, self.cosmetics_view._presentation_item, attachment)
    -- 			-- 	if special_changes then
    -- 			-- 		for special_slot, special_attachment in pairs(special_changes) do

    -- 			-- 			if not self.original_weapon_settings[special_slot] and not table_contains(self.automatic_slots, special_slot) then
    -- 			-- 				if not self:get_gear_setting(self.cosmetics_view._gear_id, special_slot) then
    -- 			-- 					self.original_weapon_settings[special_slot] = "default"
    -- 			-- 				else
    -- 			-- 					self.original_weapon_settings[special_slot] = self:get_gear_setting(self.cosmetics_view._gear_id, special_slot)
    -- 			-- 				end
    -- 			-- 			end

    -- 			-- 			self:set_gear_setting(self.cosmetics_view._gear_id, special_slot, special_attachment)
    -- 			-- 		end
    -- 			-- 	end
    -- 			-- end
    -- 		end

    -- 		if not no_update then
    -- 			self:resolve_special_changes(self.cosmetics_view._presentation_item, attachment)
    -- 			self:resolve_auto_equips(self.cosmetics_view._presentation_item)

    -- 			self.cosmetics_view._presentation_item = MasterItems.create_preview_item_instance(self.cosmetics_view._selected_item)

    -- 			-- if self.cosmetics_view._previewed_element then
    -- 			-- 	self.cosmetics_view:_preview_element(self.cosmetics_view._previewed_element)
    -- 			-- else
    -- 			self.cosmetics_view:_preview_item(self.cosmetics_view._presentation_item)
    -- 			-- end

    -- 			self:resolve_no_support(self.cosmetics_view._presentation_item)

    -- 			self.cosmetics_view._slot_info_id = self:get_slot_info_id(self.cosmetics_view._presentation_item)

    -- 			self:get_changed_weapon_settings()
    -- 		end
    -- 	end
    -- end
--#endregion

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

WeaponAnimationExtension.fix_stream = function(self)
    -- local weapon_spawn_data = self._weapon_spawn_data
	-- if weapon_spawn_data then
    if not self.weapon_spawn_data.visible then
        -- mod.weapon_spawning = nil
        -- weapon_spawn_data.streaming_complete = true
        self:cb_on_unit_3p_streaming_complete(self.weapon_unit)
    end
	-- end
end

WeaponAnimationExtension.update = function(self, dt, t)
    local perf = wc_perf.start("WeaponAnimationExtension.update", 2)
    if self.initialized then
        self:fix_stream()
        self:update_move(dt, t)
        self:update_rotation(dt, t)
        self:update_lights(dt, t)
        self:draw_equipment_lines(dt, t)
    end
    wc_perf.stop(perf)
end

WeaponAnimationExtension.update_reset = function(self, dt, t)

end

WeaponAnimationExtension.update_move = function(self, dt, t)
    
    local position = vector3_unbox(self.link_unit_position)

    -- Camera movement
    if self.do_move and self.camera_zoom then
        self.do_move = nil
        self.reset_start = nil
        -- Start move animation
        if self.position and not self.move_end then
            mod:echot("start move animation")
            local last_position = self.last_position and vector3_unbox(self.last_position) or vector3_zero()
            local move_position = vector3_unbox(self.position)
            if not vector3_equal(last_position, move_position) then
                self.new_position = vector3_box(vector3_unbox(self.link_unit_base_position) + move_position)
                self.move_end = t + MOVE_IN_DURATION
                self.move_duration = MOVE_IN_DURATION
                self.last_position = self.position
                mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
            else
                mod:echot("skip move animation")
            end
            self.position = nil

        -- Start reset animation 
        elseif self.link_unit_base_position then
            mod:echot("start reset animation")
            local last_position = vector3_unbox(self.link_unit_position)
            local base_position = vector3_unbox(self.link_unit_base_position)
            if not vector3_equal(base_position, last_position) then
                self.new_position = self.link_unit_base_position
                self.move_end = t + MOVE_OUT_DURATION
                self.move_duration = MOVE_OUT_DURATION
                self.last_position = vector3_zero()
                mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
            else
                mod:echot("skip reset animation")
            end
        end

    -- Move animation runnint
    elseif self.move_end and t < self.move_end then
        local progress = (self.move_end - t) / self.move_duration
        local anim_progress = math_easeInCubic(1 - progress)
        local lerp_position = vector3_lerp(position, vector3_unbox(self.new_position), anim_progress)
        if self.link_unit and unit_alive(self.link_unit) then
            -- mod:info("mod.set_light_positions: "..tostring(self.link_unit))
            unit_set_local_position(self.link_unit, 1, lerp_position)
        end
        self.link_unit_position = vector3_box(lerp_position)

    -- Move animation finished
    elseif self.move_end and t >= self.move_end then
        mod:echot("finish move animation")
        self.move_end = nil
        if self.link_unit and unit_alive(self.link_unit) then
            -- mod:info("mod.set_light_positions: "..tostring(self.link_unit))
            unit_set_local_position(self.link_unit, 1, vector3_unbox(self.new_position))
            self.link_unit_position = vector3_box(unit_local_position(self.link_unit, 1))
        end
        if self.do_reset then
            self.do_reset = nil
            self.reset_start = t + MOVE_RESET_TIME
        end

    -- Move animation reset
    elseif self.reset_start and t >= self.reset_start then
        mod:echot("Start reset")
        self.reset_start = nil
        self:move(nil, false)

    end
end

WeaponAnimationExtension.update_rotation = function(self, dt, t)

end

WeaponAnimationExtension.update_lights = function(self, dt, t)
	if mod.preview_lights and self.link_unit_base_position and self.link_unit_position then
		for _, unit_data in pairs(mod.preview_lights) do
			-- Get default position
			local default_position = vector3_unbox(unit_data.position)
			-- Get difference to link unit position
			local link_difference = vector3_unbox(self.link_unit_base_position) - vector3_unbox(self.link_unit_position)
			-- Position with offset
			local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
            -- mod:info("mod.set_light_positions: "..tostring(unit_data.unit))
			unit_set_local_position(unit_data.unit, 1, light_position)
		end
	end
end

WeaponAnimationExtension.draw_equipment_lines = function(self, dt, t)
	local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
	if mod.cosmetics_view and slot_infos and not mod.dropdown_open then
        local cosmetics_view = mod.cosmetics_view
		local gear_id = cosmetics_view._gear_id
		local slot_info_id = cosmetics_view._slot_info_id
		local item = cosmetics_view._selected_item
		local gui = cosmetics_view._ui_forward_renderer.gui
		-- local camera = self.ui_weapon_spawner._camera
		local attachments = item.attachments

		if attachments and #self.animations == 0 and slot_infos[slot_info_id] then
			local found_attachment_slots = mod:get_item_attachment_slots(item)

			if #found_attachment_slots > 0 then

				for _, attachment_slot in pairs(found_attachment_slots) do
					local unit = slot_infos[slot_info_id].attachment_slot_to_unit[attachment_slot]

					if unit and unit_alive(unit) then
						local box = Unit.box(unit, false)
						local center_position = matrix4x4_translation(box)
						local world_to_screen, distance = camera_world_to_screen(self.camera, center_position)
						local saved_origin = mod.dropdown_positions[attachment_slot]

						if saved_origin and saved_origin[3] and saved_origin[3] == true then
							local origin = vector2(saved_origin[1], saved_origin[2])
							local color = Color(255, 49, 62, 45)
							script_gui_hud_line(gui, origin, world_to_screen, 20, 4, Color(255, 106, 121, 100))
							script_gui_hud_line(gui, origin, world_to_screen, 20, 2, Color(255, 49, 62, 45))
							break
						end
					end
				end

			end
		end
	end
end

return WeaponAnimationExtension