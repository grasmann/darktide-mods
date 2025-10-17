local mod = get_mod("extended_weapon_customization_base_additions")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local autogun_infantry_group = {custom_selection_group = "autogun_infantry"}
local magazine_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_infantry")
local muzzle_autogun_infantry = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_infantry")
mod:merge_attachment_data(autogun_infantry_group, magazine_autogun_infantry, muzzle_autogun_infantry)

local autogun_braced_group = {custom_selection_group = "autogun_braced"}
local magazine_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_braced")
local muzzle_autogun_braced = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_braced")
mod:merge_attachment_data(autogun_braced_group, magazine_autogun_braced, muzzle_autogun_braced)

local autogun_headhunter_group = {custom_selection_group = "autogun_headhunter"}
local muzzle_autogun_headhunter = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/muzzle_autogun_headhunter")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local autopistol_group = {custom_selection_group = "autopistol"}
local magazine_autopistol = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol")
mod:merge_attachment_data(autopistol_group, magazine_autopistol)

local bayonet_group = {custom_selection_group = "rippergun"}
local bayonet_rippergun = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/bayonet_rippergun")
mod:merge_attachment_data(autogun_headhunter_group, muzzle_autogun_headhunter)

local magazine_autopistol_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autopistol_double")
local magazine_autogun_double = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/magazine_autogun_double")
local flashlight_human = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/flashlight_human")
local sight_reflex = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_reflex")
local sight_scope = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/sight_scope")
local grip_common = mod:io_dofile("extended_weapon_customization_base_additions/scripts/mods/ewc_ba/attachments/grip_common")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local table_merge_recursive = table.merge_recursive
    local table_merge_recursive_n = table.merge_recursive_n
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_empty_trinket = _item.."/trinkets/unused_trinket"

local rippergun_bayonets = "rippergun_rifle_bayonet_01|rippergun_rifle_bayonet_02|rippergun_rifle_bayonet_03|rippergun_rifle_bayonet_04|rippergun_rifle_bayonet_05|rippergun_rifle_bayonet_ml01"
local autopistol_magazines = "autogun_pistol_magazine_01|autogun_pistol_magazine_01_double"
local reflex_sights = "reflex_sight_01|reflex_sight_02|reflex_sight_03"
local scopes = "scope_01"

local attachments = {
    bolter_p1_m1 = {
        grip = grip_common,
        flashlight = flashlight_human,
        muzzle = table_merge_recursive_n(nil, muzzle_autogun_infantry, muzzle_autogun_braced, muzzle_autogun_headhunter),
        magazine = table_merge_recursive_n(nil, magazine_autopistol, magazine_autogun_double, magazine_autopistol_double, magazine_autogun_infantry, magazine_autogun_braced),
        sight = table_merge_recursive_n(nil, sight_reflex, sight_scope, {
            lasgun_rifle_sight_01 = {
                replacement_path = _item_ranged.."/sights/lasgun_rifle_sight_01",
                icon_render_unit_rotation_offset = {90, 0, -95},
                icon_render_camera_position_offset = {.035, -.1, .125},
            },
        }),
        bayonet = table_merge_recursive_n(nil, bayonet_rippergun),
    },
}

attachments.bolter_p1_m2 = table_clone(attachments.bolter_p1_m1)

local fixes = {
    bolter_p1_m1 = {
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, -.0095),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight_offset",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.05, -.034),
                    rotation = vector3_box(0, 0, 0),
                    custom_fov = 32.5,
                    aim_scale = .5,
                    fov = 25,
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = reflex_sights,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .1, -.01),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "sight",
            requirements = {
                sight = {
                    has = scopes,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, -.01, .01),
                    rotation = vector3_box(0, 0, 0),
                },
            },
        },
        {attachment_slot = "magazine",
            requirements = {
                magazine = {
                    has = autopistol_magazines,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1.8, 1),
                },
            },
        },
        {attachment_slot = "bayonet",
            requirements = {
                bayonet = {
                    has = rippergun_bayonets,
                },
            },
            fix = {
                offset = {
                    position = vector3_box(0, .28, .01),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(.4, .4, .4),
                    node = 1,
                },
            },
        },
    },
}

fixes.bolter_p1_m2 = table_clone(fixes.bolter_p1_m1)

local attachment_slots = {
    bolter_p1_m1 = {
        flashlight = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(.05, .24, .1),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1, 1, 1),
                    node = 1,
                },
            },
        },
        muzzle = {
            parent_slot = "barrel",
            default_path = _item_empty_trinket,
            fix = {
                offset = {
                    position = vector3_box(0, .13, 0),
                    rotation = vector3_box(0, 0, 0),
                    scale = vector3_box(1.75, 1.75, 1.75),
                    node = 1,
                },
            },
        },
        bayonet = {
            parent_slot = "receiver",
            default_path = _item_empty_trinket,
            -- fix = {
            --     offset = {
            --         position = vector3_box(0, .13, 0),
            --         rotation = vector3_box(0, 0, 0),
            --         scale = vector3_box(1.75, 1.75, 1.75),
            --         node = 1,
            --     },
            -- },
        },
    },
}

attachment_slots.bolter_p1_m2 = table_clone(attachment_slots.bolter_p1_m1)

local kitbashs = {
    [_item_ranged.."/magazines/boltgun_rifle_magazine_01_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/boltgun_rifle_magazine_01",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                    },
                },
                children = {
                    double_magazine_clip = {
                        item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(.0325, -.01, -.15),
                                rotation = vector3_box(0, 90, 0),
                                scale = vector3_box(1, .8, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/boltgun_rifle_magazine_01",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
                                        scale = vector3_box(1.3, 1.3, 1),
                                    },
                                },
                                children = {},
                            },
                        },
                    },
                },
            },
        },
        display_name = "loc_boltgun_rifle_magazine_01_double",
        description = "loc_description_boltgun_rifle_magazine_01_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_boltgun_rifle_magazine_01_double",
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
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/ranged/bolt_gun/attachments/magazine_01/magazine_01"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/boltgun_rifle_magazine_01_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
    [_item_ranged.."/magazines/boltgun_rifle_magazine_02_double"] = {
        attachments = {
            zzz_shared_material_overrides = {
                item = "",
                children = {},
            },
            double_magazine_1 = {
                item = _item_ranged.."/magazines/boltgun_rifle_magazine_02",
                fix = {
                    offset = {
                        node = 1,
                        position = vector3_box(0, 0, 0),
                        rotation = vector3_box(0, 0, 0),
                        scale = vector3_box(1, 1, 1),
                    },
                },
                children = {
                    double_magazine_clip = {
                        item = _item_ranged.."/magazines/lasgun_rifle_magazine_01",
                        fix = {
                            offset = {
                                node = 1,
                                position = vector3_box(.0325, -.01, -.15),
                                rotation = vector3_box(0, 90, 0),
                                scale = vector3_box(1, .8, .75),
                            },
                        },
                        children = {
                            double_magazine_2 = {
                                item = _item_ranged.."/magazines/boltgun_rifle_magazine_02",
                                fix = {
                                    offset = {
                                        node = 1,
                                        position = vector3_box(.15, .005, -.125),
                                        rotation = vector3_box(0, 90, 0),
                                        scale = vector3_box(1.3, 1.3, 1),
                                    },
                                },
                                children = {},
                            },
                        },
                    },
                },
            },
        },
        display_name = "loc_boltgun_rifle_magazine_02_double",
        description = "loc_description_boltgun_rifle_magazine_02_double",
        attach_node = "ap_magazine_01",
        dev_name = "loc_boltgun_rifle_magazine_02_double",
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
        resource_dependencies = {
            ["content/characters/empty_item/empty_item"] = true,
            ["content/weapons/player/ranged/bolt_gun/attachments/magazine_02/magazine_02"] = true,
            ["content/weapons/player/ranged/lasgun_rifle/attachments/magazine_01/magazine_01"] = true,
        },
        workflow_checklist = {
        },
        name = _item_ranged.."/magazines/boltgun_rifle_magazine_02_double",
        workflow_state = "RELEASABLE",
        is_full_item = true,
        disable_vfx_spawner_exclusion = true,
    },
}

return {
    attachments = attachments,
    attachment_slots = attachment_slots,
    fixes = fixes,
    kitbashs = kitbashs,
}
