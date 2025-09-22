local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    -- local unit = Unit
    local pairs = pairs
    local table = table
    local vector3_box = Vector3Box
    local table_clone = table.clone
--#endregion

local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local extended_weapon_customization_plugin = {
    attachments = {
        combatsword_p1_m1 = {
            scabbard = {
                scabbard_01 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_01",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -2.25, .7},
                },
                scabbard_02 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_02",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -2.25, .7},
                },
                scabbard_03 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_03",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -2.25, .7},
                },
            },
        },
        forcesword_2h_p1_m1 = {
            scabbard = {
                scabbard_big_01 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_big_01",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -4, .95},
                },
                scabbard_big_02 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_big_02",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -4, .95},
                },
                scabbard_big_03 = {
                    replacement_path = _item_melee.."/scabbards/scabbard_big_03",
                    icon_render_unit_rotation_offset = {90, -30, 0},
                    icon_render_camera_position_offset = {0, -4, .95},
                },
            },
        },
    },
    attachment_slots = {
        combatsword_p1_m1 = {
            scabbard = {
                parent_slot = "grip",
                default_path = _item_empty_trinket,
            },
        },
        forcesword_2h_p1_m1 = {
            scabbard = {
                parent_slot = "grip",
                default_path = _item_empty_trinket,
            },
        },
    },
    fixes = {
        forcesword_2h_p1_m1 = {
            {attachment_slot = "scabbard",
                fix = {
                    only_in_ui = true,
                    active_function = function(item, is_ui_item_preview, is_preview_item, is_attachment_customization, attachment_customization_slot_name)
                        if is_attachment_customization then return attachment_customization_slot_name ~= "scabbard" end
                        return is_preview_item or is_ui_item_preview
                    end,
                    offset = {
                        position = vector3_box(0, .2, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                        node = 1,
                    },
                },
            },
        },
        combatsword_p1_m1 = {
            {attachment_slot = "scabbard",
                fix = {
                    only_in_ui = true,
                    active_function = function(item, is_ui_item_preview, is_preview_item, is_attachment_customization, attachment_customization_slot_name)
                        if is_attachment_customization then return attachment_customization_slot_name ~= "scabbard" end
                        return is_preview_item or is_ui_item_preview
                    end,
                    offset = {
                        position = vector3_box(0, .2, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                        node = 1,
                    },
                },
            },
        },
    },
    kitbashs = {
        ["content/items/weapons/player/melee/scabbards/scabbard_01"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/chain_sword_full_01",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_01",
            description = "loc_description_scabbard_01",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_01",
        },
        ["content/items/weapons/player/melee/scabbards/scabbard_02"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/chain_sword_full_02",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_02",
            description = "loc_description_scabbard_02",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_02",
        },
        ["content/items/weapons/player/melee/scabbards/scabbard_03"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/chain_sword_full_03",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_03",
            description = "loc_description_scabbard_03",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_03",
        },
        ["content/items/weapons/player/melee/scabbards/scabbard_big_01"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/2h_chain_sword_body_01",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_big_01",
            description = "loc_description_scabbard_big_01",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_big_01",
        },
        ["content/items/weapons/player/melee/scabbards/scabbard_big_02"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/2h_chain_sword_body_02",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_big_02",
            description = "loc_description_scabbard_big_02",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_big_02",
        },
        ["content/items/weapons/player/melee/scabbards/scabbard_big_03"] = {
            attachments = {
                scabbard = {
                    item = _item_melee.."/full/2h_chain_sword_body_03",
                    fix = {
                        disable_in_ui = true,
                        hide = {
                            node = 1,
                        },
                    },
                    children = {},
                },
            },
            display_name = "loc_scabbard_big_03",
            description = "loc_description_scabbard_big_03",
            attach_node = "ap_blade_01",
            dev_name = "loc_scabbard_big_03",
        },
    },
}

local copy_names = {
    "combatsword_p1_m2",
    "combatsword_p1_m3",
    "combatsword_p2_m1",
    "combatsword_p2_m2",
    "combatsword_p2_m3",
    "combatsword_p3_m1",
    "combatsword_p3_m2",
    "combatsword_p3_m3",
    "forcesword_p1_m1",
    "forcesword_p1_m2",
    "forcesword_p1_m3",
    "powersword_p1_m1",
    "powersword_p1_m2",
}

local copy_names_2 = {
    "forcesword_2h_p1_m2",
    "powersword_2h_p1_m1",
    "powersword_2h_p1_m2",
}

for _, name in pairs(copy_names) do
    extended_weapon_customization_plugin.attachments[name] = table_clone(extended_weapon_customization_plugin.attachments.combatsword_p1_m1)
    extended_weapon_customization_plugin.attachment_slots[name] = table_clone(extended_weapon_customization_plugin.attachment_slots.combatsword_p1_m1)
    extended_weapon_customization_plugin.fixes[name] = table_clone(extended_weapon_customization_plugin.fixes.combatsword_p1_m1)
end

for _, name in pairs(copy_names_2) do
    extended_weapon_customization_plugin.attachments[name] = table_clone(extended_weapon_customization_plugin.attachments.forcesword_2h_p1_m1)
    extended_weapon_customization_plugin.attachment_slots[name] = table_clone(extended_weapon_customization_plugin.attachment_slots.forcesword_2h_p1_m1)
    extended_weapon_customization_plugin.fixes[name] = table_clone(extended_weapon_customization_plugin.fixes.forcesword_2h_p1_m1)
end

mod.extended_weapon_customization_plugin = extended_weapon_customization_plugin
