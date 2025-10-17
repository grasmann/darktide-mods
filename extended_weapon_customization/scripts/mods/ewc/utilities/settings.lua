local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attachments = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/attachments")

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"

local kitbashs = {
    [_item_ranged.."/emblems/emblemleft_invisible"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_emblem_left",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
        },
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item_ranged.."/emblems/emblemleft_invisible",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
    [_item_ranged.."/emblems/emblemright_invisible"] = {
        is_fallback_item = false,
        show_in_1p = true,
        base_unit = "content/characters/empty_item/empty_item",
        item_list_faction = "Player",
        tags = {
        },
        only_show_in_1p = false,
        feature_flags = {
            "FEATURE_item_retained",
        },
        attach_node = "ap_emblem_right",
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
        },
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
        },
        workflow_checklist = {
        },
        display_name = "n/a",
        name = _item_ranged.."/emblems/emblemright_invisible",
        workflow_state = "RELEASABLE",
        is_full_item = true,
    },
}

mod:load_kitbash_collection(kitbashs)

return {
    fixes = attachments.fixes,
    attachments = attachments.attachments,
    attachment_slots = attachments.attachment_slots,
    kitbashs = attachments.kitbashs,
    flashlight_templates = attachments.flashlight_templates,
    attachment_data_by_item_string = attachments.attachment_data_by_item_string,
    attachment_name_by_item_string = attachments.attachment_name_by_item_string,
    attachment_data_by_attachment_name = attachments.attachment_data_by_attachment_name,
    hide_attachment_slots_in_menu = attachments.hide_attachment_slots_in_menu,
    packages_to_load = {
        ["content/levels/ui/inventory/inventory"] = true,
    },
}
