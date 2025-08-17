local mod = get_mod("visible_equipment")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local ItemPassTemplates = mod:original_require("scripts/ui/pass_templates/item_pass_templates")
local gear_icon_size = ItemPassTemplates.gear_icon_size

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local math = math
    local table = table
    local math_clamp = math.clamp
    local table_combine = table.combine
    local math_easeOutCubic = math.easeOutCubic
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook_require("scripts/ui/views/inventory_view/inventory_view_definitions", function(instance)

    -- Add new scenegraph definitions for placement slots primary and secondary
    instance.scenegraph_definition = table_combine(instance.scenegraph_definition, {
        slot_primary_placement = {
            horizontal_alignment = "center",
            parent = "canvas",
            vertical_alignment = "center",
            size = gear_icon_size,
            position = {
                -696,
                -12 + 117,
                9,
            },
        },
        slot_secondary_placement = {
            horizontal_alignment = "center",
            parent = "canvas",
            vertical_alignment = "center",
            size = gear_icon_size,
            position = {
                -696,
                228 + 117,
                9,
            },
        },
    })

    mod:hook(instance.animations.cosmetics_on_enter[2], "update", function(func, parent, ui_scenegraph, scenegraph_definition, widgets, progress, parent2, ...)

        -- Original function
        func(parent, ui_scenegraph, scenegraph_definition, widgets, progress, parent2, ...)
        
        -- Process animation for custom widgets
        local anim_progress = math_easeOutCubic(progress)

        local x_anim_distance_max = 50
        local x_anim_distance = x_anim_distance_max - x_anim_distance_max * anim_progress
        local extra_amount = math_clamp(15 - 15 * (anim_progress * 1.2), 0, 15)

        parent:_set_scenegraph_position("slot_primary_placement", scenegraph_definition.slot_primary_placement.position[1] - x_anim_distance - extra_amount)
        parent:_set_scenegraph_position("slot_secondary_placement", scenegraph_definition.slot_secondary_placement.position[1] - x_anim_distance - extra_amount * 3)

    end)

end)