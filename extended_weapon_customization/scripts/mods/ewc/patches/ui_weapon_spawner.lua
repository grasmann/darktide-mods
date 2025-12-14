local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local string = string
    local get_mod = get_mod
    local managers = Managers
    local tostring = tostring
    -- local string_gsub = string.gsub
    -- local string_split = string.split
    local unit_get_data = unit.get_data
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_weapon_spawner", function(instance)

    instance.unit_manipulation_busy = function(self)
        if self.modding_tools then
            return self.modding_tools:unit_manipulation_busy()
        end
    end

    instance.add_unit_manipulation = function(self, unit, name, slot)
        if self.modding_tools then
            local name = name or "unknown"
            local slot = slot or "unknown"
            self.modding_tools:unit_manipulation_add({unit = unit, camera = self._camera, world = self._world, gui = self._ui_forward_renderer.gui, name = name.."("..slot..")"})
        end
    end

    instance.remove_unit_manipulation = function(self, unit)
        if self.modding_tools then
            self.modding_tools:unit_manipulation_remove(unit)
        end
    end

    instance._setup_forward_gui = function (self)
        local ui_manager = managers.ui
        local timer_name = "ui"
        local world_layer = 110
        local world_name = self._unique_id .. "_ui_forward_world"
        local view_name = self.view_name

        self._forward_world = ui_manager:create_world(world_name, world_layer, timer_name, view_name)

        local viewport_name = self._unique_id .. "_ui_forward_world_viewport"
        local viewport_type = "default_with_alpha"
        local viewport_layer = 1

        self._forward_viewport = ui_manager:create_viewport(self._forward_world, viewport_name, viewport_type, viewport_layer)
        self._forward_viewport_name = viewport_name

        local renderer_name = self._unique_id .. "_forward_renderer"

        self._ui_forward_renderer = ui_manager:create_renderer(renderer_name, self._forward_world)
    end

    instance._destroy_forward_gui = function (self)
        if self._ui_forward_renderer then
            self._ui_forward_renderer = nil

            managers.ui:destroy_renderer(self._unique_id .. "_forward_renderer")

            local world = self._forward_world
            local viewport_name = self._forward_viewport_name

            ScriptWorld.destroy_viewport(world, viewport_name)
            managers.ui:destroy_world(world)

            self._forward_viewport_name = nil
            self._forward_world = nil
        end
    end

end)

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)
    -- Modding tools
    self.modding_tools = get_mod("modding_tools")
    if self.modding_tools then
        -- Forward Gui
        local class_name = self.__class_name
        -- self._unique_id = class_name .. "_" .. string_gsub(tostring(self), "table: ", "")
        self._unique_id = class_name .. "_" .. mod:cached_gsub(tostring(self), "table: ", "")
        self:_setup_forward_gui()
    end
    -- Original function
    func(self, reference_name, world, camera, unit_spawner, ...)
end)

mod:hook(CLASS.UIWeaponSpawner, "destroy", function(func, self, ...)
    if self.modding_tools then
        -- Destroy forward gui
        self:_destroy_forward_gui()
    end
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.UIWeaponSpawner, "_mouse_rotation_input", function(func, self, input_service, dt, ...)
    if self.modding_tools and self.modding_tools:unit_manipulation_busy() then
        return
    end
    -- Original function
    func(self, input_service, dt, ...)
end)

mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, timeout, ...)
    -- Original function
    func(self, item_unit_3p, nil, ...)
    -- Modding tools
    local weapon_spawn_data = self._weapon_spawn_data
    if weapon_spawn_data and weapon_spawn_data.streaming_complete and weapon_spawn_data.attachment_units_3p then
        
        for i, attachment_unit in pairs(weapon_spawn_data.attachment_units_3p[item_unit_3p]) do

            local add_manipulation = false

            local attachment_name = unit_get_data(attachment_unit, "attachment_name")
            local attachment_slot = unit_get_data(attachment_unit, "attachment_slot")

            -- local attachment_slot_parts = string_split(attachment_slot, ".")
            local attachment_slot_parts = mod:cached_split(attachment_slot, ".")
            local weapon_attachment_slot = attachment_slot_parts and attachment_slot_parts[1]

            local inventory_weapon_cosmetics_view = mod:get_view("inventory_weapon_cosmetics_view")
            if inventory_weapon_cosmetics_view then
                local selected_tab_index = inventory_weapon_cosmetics_view._selected_tab_index
                local content = selected_tab_index and inventory_weapon_cosmetics_view._tabs_content[selected_tab_index]
                local slot_name = content and content.slot_name

                add_manipulation = slot_name == weapon_attachment_slot
            end

            if add_manipulation then
                self:add_unit_manipulation(attachment_unit, attachment_name, attachment_slot)
            else
                self:remove_unit_manipulation(attachment_unit)
            end

        end

    end
end)
