local mod = get_mod("weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local table = table
    local class = class
    local pairs = pairs
    local vector3 = Vector3
    local managers = Managers
    local table_sort = table.sort
    local unit_alive = Unit.alive
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local table_remove = table.remove
    local vector3_unbox = vector3_box.unbox
    local math_ease_in_exp = math.ease_in_exp
    local unit_local_position = Unit.local_position
    local math_ease_out_elastic = math.ease_out_elastic
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local MOVE_RESET_TIME = 1
    local MOVE_IN_DURATION = 1
    local MOVE_OUT_DURATION = .5
    local REFERENCE = "weapon_customization"
--#endregion

-- ##### ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┌┐ ┬ ┬┬┬  ┌┬┐  ┌─┐┌┐┌┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌ ###################################################
-- ##### │││├┤ ├─┤├─┘│ ││││  ├┴┐│ │││   ││  ├─┤│││││││├─┤ │ ││ ││││ ###################################################
-- ##### └┴┘└─┘┴ ┴┴  └─┘┘└┘  └─┘└─┘┴┴─┘─┴┘  ┴ ┴┘└┘┴┴ ┴┴ ┴ ┴ ┴└─┘┘└┘ ###################################################

local WeaponBuildAnimation = class("WeaponBuildAnimation")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

WeaponBuildAnimation.init = function(self)
    -- Data
    self.animations = {}
	self.animation_time = .75
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Settings
    self:on_settings_changed()
end

WeaponBuildAnimation.set = function(self, data, active)
    if data and data ~= false then
        self.ui_weapon_spawner = data.ui_weapon_spawner
        self.world = data.world
        self.item = data.item
        self.gear_id = mod:get_gear_id(data.item)
        self.slot_info_id = mod:get_slot_info_id(data.item)
        self.item_name = mod:item_name_from_content_string(data.item.name)
    end
    -- Init
    self.initialized = active or data
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

WeaponBuildAnimation.on_settings_changed = function(self)
    self.animation_speed = mod:get("mod_option_weapon_build_animation_speed")
	self.wobble = mod:get("mod_option_weapon_build_animation_wobble")
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

WeaponBuildAnimation.animation_exists = function(self, attachment_slot)
    for _, animation in pairs(self.animations) do
        if animation.slot == attachment_slot then
            return animation
        end
    end
end

WeaponBuildAnimation.is_busy = function(self)
	return #self.animations > 0
end

WeaponBuildAnimation.is_attach_finished = function(self)
    for _, entry in pairs(self.animations) do
        if entry.type == "attach" and not entry.attach_done then
            return false
        end
    end
    return true
end

WeaponBuildAnimation.is_detach_finished = function(self)
    for _, entry in pairs(self.animations) do
        if entry.type == "detach" and not entry.detach_done then
            return false
        end
    end
    return true
end

WeaponBuildAnimation.is_all_finished = function(self)
    for _, entry in pairs(self.animations) do
        if not entry.finished then
            return false
        end
    end
    return true
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

WeaponBuildAnimation.update = function(self, dt, t)
    local index = 1
    -- Data
    local ui_weapon_spawner = self.ui_weapon_spawner
    local weapon_spawn_data = ui_weapon_spawner and ui_weapon_spawner._weapon_spawn_data
    local world = ui_weapon_spawner and ui_weapon_spawner._world
    -- Check data
    if weapon_spawn_data and world and #self.animations > 0 then

        -- local slot_info_id = mod.cosmetics_view._slot_info_id
        local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
        local gear_info = slot_infos[self.slot_info_id]

        for _, entry in pairs(self.animations) do
            local attachment = mod:get_gear_setting(self.gear_id, entry.slot, self.item)
            local attachment_data = attachment and mod.attachment_models[self.item_name][attachment]
            local movement = attachment_data and attachment_data.remove and vector3_unbox(attachment_data.remove) or vector3_zero()
            local animation_wait_attach = attachment_data and attachment_data.animation_wait_attach
            local animation_wait_detach = attachment_data and attachment_data.animation_wait_detach
            -- local parent = attachment_data and attachment_data.parent and attachment_data.parent
            -- local root_movement = attachment_data and attachment_data.move_root
            -- local root_unit = gear_info.attachment_slot_to_unit["root"]
            -- local root_default = gear_info.unit_default_position[root_unit]
            -- local root_default_position = root_default and vector3_unbox(root_default) or vector3_zero()
            local unit = mod:get_attachment_slot_in_attachments(weapon_spawn_data.attachment_units_3p, entry.slot)
            local unit_good = unit and unit_alive(unit)
            -- local environment_extension = nil
            -- local wobble = mod:get("mod_option_weapon_build_animation_wobble")

            local anchor = mod.anchors[self.item_name] and mod.anchors[self.item_name][attachment]
            anchor = mod:_apply_anchor_fixes(self.item, unit) or anchor

            -- if unit_good and Unit.has_data(unit, "anchor") then
            -- 	anchor = Unit.get_data(unit, "anchor") or anchor
            -- end

            animation_wait_attach = anchor and anchor.animation_wait_attach or animation_wait_attach
            animation_wait_detach = anchor and anchor.animation_wait_detach or animation_wait_detach
            local default_position0 = unit and vector3_unbox(gear_info.unit_default_position[unit])
            local default_position1 = unit_good and unit_local_position(unit, 1)
            local default_position = anchor and anchor.position and vector3_unbox(anchor.position) or default_position0 or default_position1 or vector3_zero()

            local mesh_move = gear_info and gear_info.unit_mesh_move[unit]
            if not mesh_move then
                movement = default_position + movement
            end

            if entry.type == "attach" and unit_good then
                mod:unit_set_local_position_mesh(self.slot_info_id, unit, movement)
            end

            local process = true
            if animation_wait_attach and entry.type == "attach" then
                if not entry.attach_done then
                    for _, wait_for_slot in pairs(animation_wait_attach) do
                        local animation = mod.build_animation:animation_exists(wait_for_slot)
                        local wait_slot_unit = gear_info.attachment_slot_to_unit[wait_for_slot]
                        if wait_slot_unit and animation and not animation.attach_done then
                            process = false
                            if entry.end_time then entry.end_time = entry.end_time + dt end
                            break
                        end
                    end
                end
            elseif animation_wait_detach and entry.type == "detach" then
                if not entry.detach_done then
                    for _, wait_for_slot in pairs(animation_wait_detach) do
                        local animation = mod.build_animation:animation_exists(wait_for_slot)
                        local wait_slot_unit = gear_info.attachment_slot_to_unit[wait_for_slot]
                        if wait_slot_unit and animation and not animation.detach_done then
                            process = false
                            if entry.end_time then entry.end_time = entry.end_time + dt end
                            break
                        end
                    end
                end
            end

            -- local animation_speed = mod:get("mod_option_weapon_build_animation_speed")
            -- local animation_time = mod.weapon_part_animation_time

            if process then
                if not mod.weapon_spawning then
                    local this_animation_speed = entry.speed or self.animation_speed or .1
                    -- No timer yet - start new state
                    if not entry.end_time then
                        if attachment then
                            local attachment = entry.old == "default" and mod:get_actual_default_attachment(self.item, entry.slot) or entry.old
                            local attachment_data = mod.attachment_models[self.item_name][attachment]
                            local no_animation = attachment_data and attachment_data.no_animation
                            entry.no_detach_animation = no_animation
                            entry.end_time = t + (self.animation_time / this_animation_speed)
                        else
                            entry.end_time = t
                        end
                    end

                    -- Run animation
                    if entry.end_time and entry.end_time >= t then

                        -- When detaching
                        if entry.type == "detach" then
                            -- Play sound
                            if not entry.detach_started then
                                mod:play_attachment_sound(self.item, entry.slot, entry.new, "detach")
                                entry.detach_started = true
                            end
                            if entry.no_detach_animation or not unit_good then
                                -- Not processed
                                entry.end_time = t
                                if entry.detach_only and not self.wobble then entry.finished = true end
                            elseif not entry.no_detach_animation then
                                mod:preview_flashlight(false, world, unit, attachment, true)
                                local progress = (entry.end_time - t) / (self.animation_time / this_animation_speed)
                                local anim_progress = math_ease_in_exp(1 - progress)
                                local lerp_position = vector3_lerp(default_position, movement, anim_progress)
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, lerp_position)
                            end

                        -- When attaching
                        elseif entry.type == "attach" then
                            if not entry.attach_only_load and entry.attach_only then
                                entry.attach_only_load = true
                            elseif entry.no_attach_animation or not unit_good then
                                -- Not processed
                                entry.attach_done = true
                                entry.end_time = t
                                if not self.wobble then entry.finished = true end
                            else
                                mod:preview_flashlight(false, world, unit, attachment, true)
                                local progress = (entry.end_time - t) / (self.animation_time / this_animation_speed)
                                local anim_progress = math_ease_in_exp(1 - progress)
                                local lerp_position = vector3_lerp(movement, default_position, anim_progress)
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, lerp_position)
                            end

                        -- When wobble
                        elseif entry.type == "wobble" then
                            if not unit_good then
                                -- Not processed
                                entry.finished = true
                                entry.end_time = t
                            else
                                local progress = (entry.end_time - t) / (self.animation_time / this_animation_speed)
                                local anim_progress = math_ease_out_elastic(1 - progress)
                                local lerp_position = vector3_lerp(movement, default_position, anim_progress)
                                lerp_position = lerp_position - default_position
                                lerp_position = lerp_position * 0.1
                                lerp_position = lerp_position + default_position
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, lerp_position)
                            end

                        -- When wobble alt
                        elseif entry.type == "wobble_detach" then
                            if not unit_good then
                                entry.finished = true
                                entry.end_time = t
                            else
                                local progress = (entry.end_time - t) / (self.animation_time / this_animation_speed)
                                local anim_progress = math_ease_out_elastic(1 - progress)
                                local lerp_position = vector3_lerp(default_position, movement, anim_progress)
                                lerp_position = lerp_position - movement
                                lerp_position = lerp_position * 0.1
                                lerp_position = lerp_position + movement
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, lerp_position)
                            end

                        end

                    -- Change animation state
                    elseif entry.end_time and entry.end_time < t then
                        -- When detaching
                        if entry.type == "detach" then
                            if unit_good then
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, movement)
                            end

                            -- if not entry.detach_done then
                            -- 	mod:play_attachment_sound(mod.cosmetics_view._selected_item, entry.slot, entry.new, "detach")
                            entry.detach_done = true
                            -- end

                            local attachment = entry.new == "default" and mod:get_actual_default_attachment(self.item, entry.slot) or entry.new
                            local attachment_data = mod.attachment_models[self.item_name][attachment]
                            local no_animation = attachment_data and attachment_data.no_animation

                            if entry.detach_only then
                                if self.wobble then
                                    entry.end_time = t + (self.animation_time / this_animation_speed)
                                    entry.type = "wobble_detach"
                                else entry.finished = true end

                            elseif self:is_detach_finished() and not no_animation then
                                entry.end_time = t + (self.animation_time / this_animation_speed)
                                entry.type = "attach"

                            elseif self:is_detach_finished() then
                                if self.wobble then
                                    entry.end_time = t + (self.animation_time / this_animation_speed)
                                    entry.type = "wobble"
                                else entry.finished = true end
                            end

                        -- When attaching
                        elseif entry.type == "attach" then
                            if unit_good then
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, default_position)
                            end

                            if not entry.attach_done then
                                if unit_good then
                                    mod:preview_flashlight(true, world, unit, attachment, true)
                                end
                                mod:play_attachment_sound(self.item, entry.slot, entry.new, "attach")
                                entry.attach_done = true
                            end

                            if self.wobble then
                                entry.end_time = t + (self.animation_time / this_animation_speed)
                                entry.type = "wobble"
                            else entry.finished = true end

                        -- When wobble
                        elseif entry.type == "wobble" then
                            entry.finished = true

                            if unit_good then
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, default_position)
                            end

                        -- When wobble alt
                        elseif entry.type == "wobble_detach" then
                            entry.finished = true

                            if unit_good then
                                mod:unit_set_local_position_mesh(self.slot_info_id, unit, movement)
                            end

                        end
                    end
                else
                    if mod.weapon_spawning then
                        if unit_good then
                            mod:unit_set_local_position_mesh(self.slot_info_id, unit, movement)
                        end
                        if entry.end_time then entry.end_time = entry.end_time + dt end
                    end
                end
            end
            index = index + 1
        end

        for i, entry in pairs(self.animations) do
            if entry.detach_done then
                if entry.callback then entry.callback() end
            end
            if entry.type == "attach" and not entry.attach_load then
                mod:load_new_attachment(self.item, entry.slot, entry.new)
                entry.attach_load = true
            end
        end

        if self:is_detach_finished() and mod.weapon_part_animation_update then
            mod:load_new_attachment(weapon_spawn_data.item)
            mod.weapon_part_animation_update = nil
        end

        if self:is_all_finished() then
            mod.build_animation:clear()
            managers.event:trigger("weapon_customization_hide_ui", false)
            -- mod.cosmetics_view._visibility_toggled_on = false
            -- mod.cosmetics_view:_cb_on_ui_visibility_toggled("entry_"..tostring(3))
            -- if self.hide_ui then
            -- 	managers.event:trigger("weapon_customization_hide_ui", false)
            -- end
        end

    end
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

local _children_sort_function = function(entry_1, entry_2)
	local distance_1 = entry_1.children or (entry_1.slot == "rail" and 1) or 0
	local distance_2 = entry_2.children or (entry_1.slot == "rail" and 1) or 0

	return distance_1 < distance_2
end

WeaponBuildAnimation.animate = function(self, item, attachment_slot, attachment, new_attachment, no_children, speed, hide_ui, attachment_type, callback)
    local existing_animation = self:animation_exists(attachment_slot)
    if not existing_animation then
        local attachment_type = attachment_type or "detach"
        local hide_ui = hide_ui == nil and true or hide_ui
        -- Slot
        local slot = mod:_recursive_find_attachment(item.attachments, attachment_slot)
        -- Type
        local detach_only = attachment_type == "detach_only"
        local attach_only = attachment_type == "attach"
        local real_type = attachment_type == "detach_only" and "detach" or attachment_type
        -- Create
        self.animations[#self.animations+1] = {
            slot = attachment_slot,
            type = real_type,
            new = new_attachment,
            old = mod:get_gear_setting(self.gear_id, attachment_slot, item),
            children = slot and slot.children and #slot.children or 0,
            speed = speed,
            detach_only = detach_only,
            attach_only = attach_only,
            hide = detach_only,
            callback = callback,
        }
        -- Hide UI
        if not detach_only and not attach_only then
            managers.event:trigger("weapon_customization_hide_ui", true)
        end
        -- Chilrden
        local children = {}
        -- Trigger move
        local attachment_data = mod.attachment_models[self.item_name][new_attachment]
        local trigger_move = attachment_data and attachment_data.trigger_move
        attachment_data = mod:_apply_anchor_fixes(item, attachment_slot) or attachment_data
        trigger_move = attachment_data and attachment_data.trigger_move or trigger_move
        if trigger_move then
            for _, trigger_attachment_slot in pairs(trigger_move) do
                children[#children+1] = {slot = trigger_attachment_slot}
            end
        end
        -- Find attached children
        if slot and slot.children then
            mod:_recursive_get_attachments(slot.children, children)
        end
        if #children > 0 and not no_children then
            -- Iterate children
            for i, child in pairs(children) do
                if not self:animation_exists(child.slot) then
                    local new_child_attachment = mod:get_gear_setting(self.gear_id, child.slot, item)
                    local old_child_attachment = mod:get_gear_setting(self.gear_id, child.slot, item)
                    self:animate(item, child.slot, nil, new_child_attachment, no_children, speed, hide_ui, attachment_type)
                end
            end
        end
    elseif existing_animation and existing_animation.new == existing_animation.old and new_attachment ~= existing_animation.new then
        existing_animation.new = new_attachment
    end
    -- Attachment order
    table_sort(self.animations, _children_sort_function)
end

WeaponBuildAnimation.remove_animation = function(self, attachment_slot)
    for index, animation in pairs(self.animations) do
        if animation.slot == attachment_slot then
            table_remove(self.animations, index)
            break
        end
    end
end

WeaponBuildAnimation.clear = function(self)
    self.animations = {}
end

return WeaponBuildAnimation