local mod = get_mod("ewc_example_plugin")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local managers = Managers
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _empty_item = "content/items/weapons/player/trinkets/unused_trinket"

-- Plugin definition
-- The extended weapon customization main mod will search for this table
mod.extended_weapon_customization_plugin = {
    -- Attachment table
    attachments = {
        -- Weapon
        bolter_p1_m1 = {
            -- Slot name
            flashlight = {
                -- Attachment definition
                blue_flashlight_01 = {
                    -- This is the name of the attachment in the master items list
                    replacement_path = _item_ranged.."/flashlights/blue_flashlight_01",
                    -- This is the offset used in the icon for the attachment selection
                    icon_render_unit_rotation_offset = {90, 0, 90 + 30},
                    icon_render_camera_position_offset = {-.125, -1.25, .2},
                    -- This is an option that must return true for the attachment to be used in randomized weapons
                    randomization_requirement = "mod_option_blue_flashlight_randomization",
                    -- This creates a custom group in the attachment selection
                    custom_selection_group = "blue_flashlights",
                    -- This assigns a custom flashlight template
                    flashlight_template = "blue_flashlight_01",
                    -- This defines the attachment slot of the flashlight unit
                    flashlight_attachment_slot = "flashlight_light",
                },
            },
        },
    },
    -- Attachment slots table
    attachment_slots = {
        -- Weapon
        bolter_p1_m1 = {
            -- Slot name
            flashlight = {
                -- Parent slot - offset will be local to this slots unit
                parent_slot = "receiver",
                -- Default path - default item when nothing is equipped.
                default_path = _empty_item,
                -- Intergrated fix - this fix applies to all attachments in the slot
                -- But it can be overwritten by individual fixes
                fix = {
                    -- Fix offset component
                    offset = {
                        position = vector3_box(.05, .24, .1),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                        node = 1,
                    },
                },
            },
        },
    },
    kitbashs = {
        -- A kitbash is an item entry how it would be in the master items list.
        -- The master items list contains all weapons, attachments, trinkets, armors, etc.
        -- It's a good idea to search for the kind of attachment you want to kitbash.
        -- and basically copy paste the values you find into the kitbash.
        [_item_ranged.."/flashlights/blue_flashlight_01"] = {
            -- Fallback item - not tested might be interesting for custom slots
            is_fallback_item = false,
            -- Show in first person / only in first person
            show_in_1p = true,
            only_show_in_1p = false,
            -- Item list faction - Who can use the item?
            item_list_faction = "Player",
            -- Base unit that is loaded for the attachment
            -- Here it is the empty item, so it's kind of a dummy and only the attachments show.
            base_unit = "content/characters/empty_item/empty_item",
            -- Unknown
            tags = {},
            workflow_state = "RELEASABLE",
            feature_flags = {"FEATURE_item_retained"},
            -- Attach node in the unit - can be removed, in which case it will probably use node 1 of the parent slot unit
            attach_node = "ap_flashlight_01",
            -- Resource packages to load - I recommend adding all resources needed by the different attachments
            resource_dependencies = {
                ["content/characters/empty_item/empty_item"] = true,
                ["content/weapons/player/attachments/flashlights/flashlight_01/flashlight_01"] = true,
            },
            attachments = {
                zzz_shared_material_overrides = {
                    item = "",
                    children = {},
                },
                flashlight_light = {
                    item = _item_ranged.."/flashlights/flashlight_01",
                    fix = {
                        offset = {
                            scale = vector3_box(1, 2, 1),
                        },
                    },
                    children = {},
                },
            },
            workflow_checklist = {
            },
            -- Name - This needs to be set - should be the same as the key in master item table
            name = _item_ranged.."/flashlights/blue_flashlight_01",
            -- Display name - Attachment names can be localized
            -- The localizations must be global - see the localization file.
            display_name = "loc_blue_flashlight_01",
            -- This tells the main mod it is a complete item.
            is_full_item = true,
        },
    },
    flashlight_templates = {
        -- A flashlight template is a light description in the form of a table.
        -- The original flashlight templates can be found in the original game file:
        -- scripts/settings/equipment/flashlight_templates
        -- 'flicker' can be a text in the mod context
        -- The mod will try to pull the original flicker setting with that name
        blue_flashlight_01 = {
            light = {
                first_person = {
                    cast_shadows = true,
                    color_temperature = 7300,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 8,
                    spot_reflector = false,
                    volumetric_intensity = 0.1,
                    color_filter = vector3_box(0, 0, 1),
                    spot_angle = {
                        max = 1.3,
                        min = 0,
                    },
                    falloff = {
                        far = 70,
                        near = 0,
                    },
                },
                third_person = {
                    cast_shadows = true,
                    color_temperature = 7000,
                    ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_01",
                    intensity = 8,
                    spot_reflector = false,
                    volumetric_intensity = 0.6,
                    color_filter = vector3_box(0, 0, 1),
                    spot_angle = {
                        max = 0.9,
                        min = 0,
                    },
                    falloff = {
                        far = 30,
                        near = 0,
                    },
                },
            },
            flicker = "led_flicker",
        },
    },
}
