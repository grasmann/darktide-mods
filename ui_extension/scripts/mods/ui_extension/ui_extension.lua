local mod = get_mod("ui_extension")
local DMF = get_mod("DMF")

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

mod.debug = true
mod.extensions = mod.extensions or {}
mod.widgets = mod.widgets or {}
mod.view_hooks = mod.view_hooks or {}

local UIWidget = Mods.original_require("scripts/managers/ui/ui_widget")

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

function mod.reload_mods()
    mod.extensions = {}
    mod.widgets = {}
	mod.view_hooks = {}
end

function mod.on_all_mods_loaded()
    mod.extensions = {}
    -- mod:echo("load ui extensions")
    -- Iterate through mods
    for _, this_mod in pairs(DMF.mods) do
        -- Make sure it's a table
        if type(this_mod) == "table" then
            -- Check ui table
            if this_mod.ui then
                -- Iterate through ui extensions
                for view_name, data in pairs(this_mod.ui) do
                    -- mod:echo("ui detected for '"..view_name.."'")
                    -- Add extension
                    mod.extensions[#mod.extensions+1] = {
                        view_name = view_name,
                        widgets = data.widgets,
                        scenegraph = data.scenegraph,
                        callback = data.on_widgets_loaded,
                        on_enter = data.on_enter,
                        on_exit = data.on_exit,
                        update = data.on_update,
                        mod = this_mod,
                    }
                    -- if data.on_enter then mod:hook_view_(view_name, "on_enter", this_mod) end
                    -- if data.on_exit then mod:hook_view_(view_name, "on_exit", this_mod) end
                    -- if data.update then mod:hook_view_(view_name, "update", this_mod) end
                end
            end
        end
    end
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Extend scenegraph
mod.extend_scenegraph = function(self, extension, scenegraph_definition)
    local scenegraph = scenegraph_definition
    for name, scenegraph_extension in pairs(extension.scenegraph) do
        if not scenegraph[name] then
            scenegraph[name] = scenegraph_extension
        else
            for value_name, value in pairs(scenegraph_extension) do
                scenegraph[name][value_name] = value
            end
        end
    end
    return scenegraph
end

-- Extend widgets
mod.extend_widgets = function(self, extension, widget_definitions)
    local widgets = widget_definitions
    for name, widget_extension in pairs(extension.widgets) do
        -- Copy scenegraph id
        local scenegraph_id = ""..widget_extension.scenegraph_id..""
        -- Set scenegraph id to nil
        -- The scenegraph id is saved inside the widget definition
        widget_extension.scenegraph_id = nil
        -- Create widget definition
        widgets[name] = UIWidget.create_definition(widget_extension, scenegraph_id)
        -- Reset scenegraph id
        widget_extension.scenegraph_id = ""..scenegraph_id..""
    end
    return widgets
end

-- Find widget by name in a view
mod.find_widget = function(self, name, view)
    for _, widget in pairs(view._widgets) do
        if widget.name == name then
            return widget
        end
    end
end

mod.split = function(self, s, sep)
    local fields = {}
    
    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
    
    return fields
end

mod.class_name = function(self, view_name)
    local class = ""
    -- Split string
    local parts = self:split(view_name, "_")
    -- Combine with first letter capitalized
    for _, part in pairs(parts) do
        class = class..part:gsub("^%l", string.upper)
    end
    -- Class name
    return class
end

-- Hook views
mod.hook_view = function(self, view_name, func_name)
    -- Generate path to view file
    local view_file = "scripts/ui/views/"..view_name.."/"..view_name
    -- Test if file exists
    local test = Mods.original_require(view_file)
    if test then
        -- Generate class name for view
        local class = self:class_name(view_name)
        -- local this_func_name = "Mods.require_store['scripts/ui/views/"..view_name.."/"..view_name.."'][1]['"..func_name.."']"
        if self.debug then self:echo("Class name: '"..class.."'") end
        -- Generate hook id
        local hook_id = view_name.."_"..func_name
        -- Check if class exists
        if CLASS[class] then
            -- Check if hook exists
            if not self.view_hooks[hook_id] then
                -- Create hook
                if self.debug then self:echo("Hook '"..hook_id.."' created") end
                -- Create hook
                self:hook(CLASS[class], func_name, function(func, self, a, b, ...)
                    if not self._destroyed then
                        for _, extension in pairs(mod.extensions) do
                            if extension.view_name == view_name and extension[func_name] then
                                extension[func_name](view_name, a, b)
                            end
                        end
                    end
                    return func(self, a, b, ...)
                end)
                -- Set hook id
                self.view_hooks[hook_id] = true
            else
                if self.debug then self:echo("Hook '"..hook_id.."' already exists") end
            end
        else
            if self.debug then self:echo("Class '"..class.."' doesn't exist") end
        end
    else
        if self.debug then self:echo("File '"..view_file.."' doesn't exist") end
    end
end

mod.hook_view_ = function(self, view_name, func_name, this_mod)
    local class = self:class_name(view_name)
    local hook_id = view_name.."_"..func_name
    -- if CLASS[class] and not self.view_hooks[hook_id] then
    if CLASS[class] then
        this_mod:hook(CLASS[class], func_name, function(func, self, a, b, ...)
            if not self._destroyed then
                for _, extension in pairs(mod.extensions) do
                    if extension.view_name == view_name and extension[func_name] then
                        extension[func_name](view_name, a, b)
                    end
                end
            end
            return func(self, a, b, ...)
        end)
        -- self.view_hooks[hook_id] = true
    end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

mod:hook(CLASS.BaseView, "_on_view_load_complete", function(func, self, loaded, ...)
    -- Check if current active file
    if loaded and not self._destroyed then
        local relevant_extensions = {}
        -- mod:echo(self.view_name..' loaded')
        -- Iterate through registered extensions
        -- Gather relevant entries for this view
        for _, extension in pairs(mod.extensions) do
            -- mod:echo("extension = '"..extension.view_name.."'")
            if extension.view_name == self.view_name then
                -- mod:echo(extension.view_name.." == "..self.view_name)
                relevant_extensions[#relevant_extensions+1] = extension
            else
                -- mod:echo(extension.view_name.." != "..self.view_name)
            end
        end

        -- Extend view
        if #relevant_extensions > 0 then
            -- Definitions path
            local definition_path = "scripts/ui/views/"..self.view_name.."/"..self.view_name.."_definitions"
            if mod.debug then mod:echo("Path '"..definition_path.."'") end
            -- Load original definitions
            local definitions = Mods.original_require(definition_path)
            -- Check definitions
            if definitions then

                -- Get scenegraph definition
                local scenegraph_definition = definitions.scenegraph_definition
                -- Check scenegraph definition
                if scenegraph_definition then
                    local scenegraph = table.clone(scenegraph_definition)

                    -- Iterate through relevant extensions
                    for _, extension in pairs(relevant_extensions) do
                        -- Check for scenegraph extension
                        if extension.scenegraph then
                            scenegraph = mod:extend_scenegraph(extension, scenegraph)
                        end
                    end
                    -- Set view scenegraph definition
                    self._definitions.scenegraph_definition = scenegraph
                else
                    if mod.debug then mod:echo("No scenegraph found for '"..self.view_name.."'") end
                end

                -- Get widget definitions
                local widget_definitions = definitions.widget_definitions
                -- Check widget definitions
                if widget_definitions then
                    local widgets = table.clone(widget_definitions)

                    -- Iterate through relevant extensions
                    for _, extension in pairs(relevant_extensions) do
                        -- Check for scenegraph extension
                        if extension.widgets then
                            mod.widgets[self.view_name] = mod.widgets[self.view_name] or {}
                            widgets = mod:extend_widgets(extension, widgets)
                        end
                    end
                    -- Set view widget definitions
                    self._definitions.widget_definitions = widgets
                else
                    if mod.debug then mod:echo("No widgets found for '"..self.view_name.."'") end
                end

                -- On open / close
                for _, extension in pairs(mod.extensions) do
                    -- if extension.on_enter then mod:hook_view(self.view_name, "on_enter") end
                    -- if extension.on_exit then mod:hook_view(self.view_name, "on_exit") end
                    -- if extension.update then mod:hook_view(self.view_name, "update") end
                    if extension.on_enter then mod:hook_view_(self.view_name, "on_enter", extension.mod) end
                    if extension.on_exit then mod:hook_view_(self.view_name, "on_exit", extension.mod) end
                    if extension.update then mod:hook_view_(self.view_name, "update", extension.mod) end
                end

                -- Original function
                func(self, loaded, ...)

                -- If widgets were created
                if mod.widgets[self.view_name] then
                    -- Iterate through relevant extensions
                    -- Execute widget callback
                    for _, extension in pairs(relevant_extensions) do
                        -- Check for scenegraph extension
                        if extension.callback then
                            local widgets = {}
                            local widgets_by_name = {}
                            -- Get widget instances
                            for name, _ in pairs(extension.widgets) do
                                -- Get widget
                                local widget = mod:find_widget(name, self)
                                -- Set in mod list
                                mod.widgets[self.view_name][name] = widget
                                -- Collect
                                widgets[#widgets+1] = widget
                                widgets_by_name[name] = widget
                            end

                            extension.callback(widgets, widgets_by_name)
                        end
                    end
                end

                return
            else
                if mod.debug then mod:echo("No definitions for '"..self.view_name.."'") end
            end

        else
            if mod.debug then mod:echo("No extensions for '"..self.view_name.."'") end
        end

    end
    func(self, loaded, ...)
end)