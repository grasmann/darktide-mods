local mod = get_mod("modding_tools")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local pairs = pairs
    local string = string
    local managers = Managers
    local tostring = tostring
    local string_gsub = string.gsub
--#endregion

-- ##### ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐ ####################################################################################
-- ##### ││││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ####################################################################################
-- ##### ┴┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘ ####################################################################################

mod.forward_gui = function(self)
    -- Get active top view name
    local view_name = managers.ui and managers.ui:active_top_view()
    -- Get top view or hud
    local instance = view_name and managers.ui:view_instance(view_name) or managers.ui:get_hud()
    if instance then
        if instance._ui_forward_renderer then
            -- Return forward gui
            return instance._ui_forward_renderer.gui, instance._ui_forward_renderer.gui_retained
        else
            -- Inject forward gui
            self:inject_forward_gui(instance)
            -- Return forward gui
            if instance._modding_tools_ui_forward_renderer then
                return instance._modding_tools_ui_forward_renderer.gui, instance._modding_tools_ui_forward_renderer.gui_retained
            end
        end
    end
end

mod.inject_forward_gui = function(self, instance)
    local view_name = instance.view_name or "hud_view"
    -- Check if forward gui is already injected
    if not instance._modding_tools_hooked then
        mod:console_print("Injecting forward gui to "..view_name)
        -- Hook on enter
        if instance.on_enter then
            mod:hook(instance, "on_enter", function(func, self, ...)
                -- Original function
                local result = func(self, ...)
                -- Setup forward gui
                mod:inject_forward_gui_into_class(self)
                -- return result
                return result
            end)
        else
            instance.on_enter = function(self)
                -- Parent function
                instance.super.on_enter(self)
                -- Setup forward gui
                mod:inject_forward_gui_into_class(self)
            end 
        end
        -- Hook on exit
        if instance.on_exit then
            mod:hook(instance, "on_exit", function(func, self, ...)
                -- Destroy forward gui
                mod:destroy_forward_gui_in_class(self)
                -- Original function
                return func(self, ...)
            end)
        else
            instance.on_exit = function(self)
                -- Destroy forward gui
                mod:destroy_forward_gui_in_class(self)
                -- Parent function
                instance.super.on_exit(self)
            end
        end
        -- Setup forward gui
        self:inject_forward_gui_into_class(instance)
        -- Mark as injected
        instance._modding_tools_hooked = true
    end
end

mod.destroy_forward_guis = function(self)
    if managers.ui then
        -- Get all active views
        local views = managers.ui:active_views()
        if views then
            -- Iterate views
            for view_name, view in pairs(views) do
                -- Destroy forward gui
                self:echo("Destroying forward gui in "..tostring(view_name))
                self:destroy_forward_gui_in_class(view)
            end
        end
        -- Get hud
        local hud = managers.ui:get_hud()
        if hud then
            -- Destroy forward gui
            self:echo("Destroying forward gui in hud")
            self:destroy_forward_gui_in_class(hud)
        end
    end
end

-- ##### ┬┌┐┌ ┬┌─┐┌─┐┌┬┐  ┌─┐┌─┐┬─┐┬ ┬┌─┐┬─┐┌┬┐  ┌─┐┬ ┬┬ ##############################################################
-- ##### ││││ │├┤ │   │   ├┤ │ │├┬┘│││├─┤├┬┘ ││  │ ┬│ ││ ##############################################################
-- ##### ┴┘└┘└┘└─┘└─┘ ┴   └  └─┘┴└─└┴┘┴ ┴┴└──┴┘  └─┘└─┘┴ ##############################################################

mod.inject_forward_gui_into_class = function(self, instance)
    -- Check if forward gui is already injected
    local view_name = instance.view_name or "hud_view"
    if not instance._modding_tools_ui_forward_renderer_id then
        instance._modding_tools_unique_id = instance.__class_name.."_"..string_gsub(tostring(instance), "table: ", "").."_modding_tools"
        if view_name == "hud_view" then
            instance._modding_tools_ui_forward_renderer_id = instance._modding_tools_unique_id.."_forward_renderer"
            instance._modding_tools_ui_forward_renderer = managers.ui:create_renderer(instance._modding_tools_ui_forward_renderer_id)
        else
            instance._modding_tools_forward_world = managers.ui:create_world(instance._modding_tools_unique_id.."_ui_forward_world", 300, "ui", view_name)
            instance._modding_tools_forward_viewport_name = instance._modding_tools_unique_id.."_ui_forward_world_viewport"
            instance._modding_tools_forward_viewport = managers.ui:create_viewport(instance._modding_tools_forward_world, instance._modding_tools_forward_viewport_name, "default_with_alpha", 100)
            instance._modding_tools_ui_forward_renderer_id = instance._modding_tools_unique_id.."_forward_renderer"
            instance._modding_tools_ui_forward_renderer = managers.ui:create_renderer(instance._modding_tools_ui_forward_renderer_id, instance._modding_tools_forward_world)
        end
    end
end

mod.destroy_forward_gui_in_class = function(self, instance)
    -- Check if forward gui is injected
    if instance._modding_tools_ui_forward_renderer then
        instance._modding_tools_ui_forward_renderer = nil
        managers.ui:destroy_renderer(instance._modding_tools_ui_forward_renderer_id)
    end
    if instance._modding_tools_forward_viewport then
        ScriptWorld.destroy_viewport(instance._modding_tools_forward_world, instance._modding_tools_forward_viewport_name)
        instance._modding_tools_forward_viewport_name = nil
    end
    if instance._modding_tools_forward_world then
        managers.ui:destroy_world(instance._modding_tools_forward_world)
        instance._modding_tools_forward_world = nil
    end
end