local mod = get_mod("cancel_loading")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local UIWidget = mod:original_require("scripts/managers/ui/ui_widget")
local TextUtilities = mod:original_require("scripts/utilities/ui/text")
local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
local UIFontSettings = mod:original_require("scripts/managers/ui/ui_font_settings")
local ButtonPassTemplates = mod:original_require("scripts/ui/pass_templates/button_pass_templates")
local Definitions = mod:original_require("scripts/ui/views/mission_intro_view/mission_intro_view_definitions")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local CLASS = CLASS
local Color = Color
local managers = Managers
local callback = callback
local tostring = tostring
local utf8_upper = Utf8.upper
local table_size = table.size
local table_clone = table.clone
local table_clear = table.clear

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

mod.mission_intro_view = nil

-- ##### ┌┬┐┬┌─┐┌─┐┬┌─┐┌┐┌  ┬┌┐┌┌┬┐┬─┐┌─┐  ┬  ┬┬┌─┐┬ ┬  ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ###################################
-- ##### ││││└─┐└─┐││ ││││  ││││ │ ├┬┘│ │  └┐┌┘│├┤ │││   ││├┤ ├┤ │││││ │ ││ ││││└─┐ ###################################
-- ##### ┴ ┴┴└─┘└─┘┴└─┘┘└┘  ┴┘└┘ ┴ ┴└─└─┘   └┘ ┴└─┘└┴┘  ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ###################################

mod:hook_require("scripts/ui/views/mission_intro_view/mission_intro_view_definitions", function(instance)

    local equip_button_size = {374, 76}

    -- Create cancel button scenegraph
	instance.scenegraph_definition.cancel_button = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "center",
		size = equip_button_size,
		position = {0, -20, 1}
	}
	-- Create cancel button widget
	instance.widget_definitions.cancel_button = UIWidget.create_definition(table_clone(ButtonPassTemplates.default_button), "cancel_button", {
		gamepad_action = "confirm_pressed",
		text = utf8_upper(mod:localize("loc_cancel_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_skin_confirm
		}
	})
	instance.widget_definitions.cancel_button.content.original_text = utf8_upper(mod:localize("loc_cancel_button"))

    -- Create attachment info box widgets
	local sub_display_name_style = table_clone(UIFontSettings.header_1)
	sub_display_name_style.text_horizontal_alignment = "center"
	sub_display_name_style.text_vertical_alignment = "center"

    instance.scenegraph_definition.done_loading = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "center",
		size = {500, 50},
		position = {0, -equip_button_size[2]-30, 1}
	}
    instance.widget_definitions.done_loading = UIWidget.create_definition({{
        value = "",
        value_id = "text",
        pass_type = "text",
        style = sub_display_name_style
	}}, "done_loading")

end)

-- ##### ┌┬┐┬┌─┐┌─┐┬┌─┐┌┐┌  ┬┌┐┌┌┬┐┬─┐┌─┐  ┬  ┬┬┌─┐┬ ┬  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ###############################################
-- ##### ││││└─┐└─┐││ ││││  ││││ │ ├┬┘│ │  └┐┌┘│├┤ │││  ├─┤│ ││ │├┴┐└─┐ ###############################################
-- ##### ┴ ┴┴└─┘└─┘┴└─┘┘└┘  ┴┘└┘ ┴ ┴└─└─┘   └┘ ┴└─┘└┴┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ###############################################

mod:hook_require("scripts/ui/views/mission_intro_view/mission_intro_view", function(instance)

    instance.init_custom = function(self)
        self._widgets = self._widgets or {}
        self._widgets_by_name = self._widgets_by_name or {}
        self._pass_draw = true
        self._ui_manager = self._ui_manager or managers.ui
        self._party_immaterium = self._party_immaterium or managers.party_immaterium
    end

    instance.cb_on_cancel_pressed = function(self)
        managers.party_immaterium:leave_party()
        managers.multiplayer_session:leave("leave_to_hub")
    end

    instance.custom_enter = function(self)
        mod.mission_intro_view = self

        if self._widgets_by_name.display then
            self._widgets_by_name.display.visible = false
        end

        local widget = self:_create_widget("cancel_button", Definitions.widget_definitions.cancel_button)
        self._widgets_by_name.cancel_button = widget
        self._widgets[#self._widgets + 1] = widget
        widget.content.hotspot.pressed_callback = callback(self, "cb_on_cancel_pressed")
        widget = self:_create_widget("done_loading", Definitions.widget_definitions.done_loading)
        -- widget.content.text = TextUtilities.apply_color_to_text("Loading Finished!", Color.ui_red_light(255, true))
        widget.visible = false
        self._widgets_by_name.done_loading = widget
        self._widgets[#self._widgets + 1] = widget
    end

    instance.custom_exit = function(self)
        mod.mission_intro_view = nil
    end

    instance.update_custom = function(self, dt, t, input_service)
        local wait_reason, wait_time = self._ui_manager:current_wait_info()
        self._widgets_by_name.done_loading.content.text = tostring(wait_reason).." - "..tostring(wait_time)
    end

    instance.draw = function(self, ...)
        self.super.draw(self, ...)
    end

end)

mod:hook(CLASS.MissionIntroView, "init", function(func, self, settings, context, ...)
    -- Original function
    func(self, settings, context, ...)
    -- Custom
    self:init_custom()
end)

mod:hook(CLASS.MissionIntroView, "on_enter", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Custom
    self:custom_enter()
end)

mod:hook(CLASS.MissionIntroView, "on_exit", function(func, self, ...)
    -- Custom
    self:custom_exit()
    -- Original function
    func(self, ...)
end)

mod:hook(CLASS.MissionIntroView, "update", function(func, self, dt, t, input_service, ...)
    -- Original function
    func(self, dt, t, input_service, ...)
    -- Custom
    self:update_custom(dt, t, input_service)
end)