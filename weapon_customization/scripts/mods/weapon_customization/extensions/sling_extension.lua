local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local footstep_intervals_templates = mod:original_require("scripts/settings/equipment/footstep/footstep_intervals_templates")
    local ScriptViewport = mod:original_require("scripts/foundation/utilities/script_viewport")
    local ScriptWorld = mod:original_require("scripts/foundation/utilities/script_world")
    local ScriptGui = mod:original_require("scripts/foundation/utilities/script_gui")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local type = type
    local math = math
    local table = table
    local World = World
    local class = class
    local pairs = pairs
    local Script = Script
    local vector3 = Vector3
    local get_mod = get_mod
    local managers = Managers
    local tostring = tostring
    local unit_node = Unit.node
    local math_lerp = math.lerp
    local unit_alive = Unit.alive
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local table_clear = table.clear
    local vector3_lerp = vector3.lerp
    local unit_get_data = Unit.get_data
    local quaternion_box = QuaternionBox
    local table_icombine = table.icombine
    local math_ease_sine = math.ease_sine
    local vector3_unbox = vector3_box.unbox
    local world_link_unit = World.link_unit
    local quaternion_look = Quaternion.look
    local quaternion_lerp = Quaternion.lerp
    local vector3_distance = vector3.distance
    local world_unlink_unit = World.unlink_unit
    local quaternion_unbox = quaternion_box.unbox
    local world_destroy_unit = World.destroy_unit
    local world_spawn_unit_ex = World.spawn_unit_ex
    local unit_local_rotation = Unit.local_rotation
    local unit_world_position = Unit.world_position
    local unit_world_rotation = Unit.world_rotation
    local matrix4x4_transform = Matrix4x4.transform
    local quaternion_multiply = Quaternion.multiply
    local table_clone_instance = table.clone_instance
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local unit_set_local_scale = Unit.set_local_scale
    local quaternion_to_vector = Quaternion.to_vector
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local unit_set_texture_for_materials = Unit.set_texture_for_materials
    local world_update_unit_and_children = World.update_unit_and_children
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
    local DEBUG = true
    local SLOT_SECONDARY = "slot_secondary"
    local SLOT_UNARMED = "slot_unarmed"
    local REFERENCE = "weapon_customization"
    local EMPTY_UNIT = "core/units/empty_root"
    local MATERIAL = "content/textures/colors/oxidation_color_black_01"
    local MODEL = "content/weapons/player/ranged/lasgun_rifle/attachments/rail_01/rail_01"
    -- local MODEL = "content/weapons/player/ranged/autogun_rifle/attachments/magazine_01/magazine_01"
    local TEXTURE_BC = "content/characters/tiling_materials/leather_coarse/leather_coarse_bc"
    local TEXTURE_NM = "content/characters/tiling_materials/leather_coarse/leather_coarse_nm"
	local TEXTURE_ORM = "content/characters/tiling_materials/leather_coarse/leather_coarse_orm"
    local WEAPON_MELEE = "WEAPON_MELEE"
    local WEAPON_RANGED = "WEAPON_RANGED"
    local GADGET = "GADGET"
    local no_sling = {
        "forcestaff_p1_m1",
        "forcestaff_p2_m1",
        "forcestaff_p3_m1",
        "forcestaff_p4_m1",
        "ogryn_powermaul_slabshield_p1_m1",
        "ogryn_pickaxe_2h_p1_m1",
        "ogryn_pickaxe_2h_p1_m2",
        "ogryn_pickaxe_2h_p1_m3",
    }
    local common_offsets = {
        human = {
            origin = {
                position = vector3_box(.025, .35, .075),
                -- position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, -45, 0),
            },
            origin__hips_left = {
                position = vector3_box(-.05, .05, 0),
                rotation = vector3_box(0, -90, 0),
            },
            hips_left = {
                position = {wielded = vector3_box(.05, .2, .05), unwielded = vector3_box(0, .15, 0)},
                rotation = vector3_box(0, -90, 0),
            },
            hips_left__chest = {
                position = vector3_box(0, .05, 0),
                rotation = vector3_box(0, -70, 0),
            },
            chest = {
                position = vector3_box(.05, -.02, .125),
                rotation = vector3_box(0, -40, 0),
            },
            chest__right_shoulder = {
                position = vector3_box(0, .015, -.025),
                rotation = vector3_box(0, -20, 0),
            },
            right_shoulder = {
                position = vector3_box(-.15, .05, -.15),
                -- rotation = vector3_box(0, -10, 0),
            },
            right_shoulder_02 = {
                position = vector3_box(-.15, -.05, -.15),
                -- rotation = vector3_box(0, -10, 0),
            },
            right_shoulder__back_right = {
                position = vector3_box(0, -.015, -.025),
                -- rotation = vector3_box(0, 0, 0),
            },
            back_right = {
                position = vector3_box(0, .02, .1),
                -- rotation = vector3_box(0, 80, 0),
            },
            back_right__endpoint = {
                position = {wielded = vector3_box(-.1, .1, 0), unwielded = vector3_box(0, 0, 0)},
                -- rotation = vector3_box(0, 90, 0),
            },
            endpoint = {
                position = vector3_box(.025, -.25, .025),
                -- position = vector3_box(0, 0, 0),
                rotation = vector3_box(0, 90, 0),
            },
        },
    }
    local sling_chains = {
        human = {
            hips_back = {
                {unit_name = "weapon", offset = common_offsets.human.origin},
                {fill = true, unit_name = "player", node_name = "j_hips", offset = common_offsets.human.origin__hips_left},
                {unit_name = "player", node_name = "j_hips", gear_node = "hips_left",  offset = common_offsets.human.hips_left},
                {fill = true, unit_name = "player", node_name = "j_hips", offset = common_offsets.human.hips_left__chest},
                {unit_name = "player", node_name = "j_spine2", gear_node = "chest", offset = common_offsets.human.chest},
                {fill = true, unit_name = "player", node_name = "j_rightshoulder", offset = common_offsets.human.chest__right_shoulder},
                {unit_name = "player", node_name = "j_rightshoulder", offset = common_offsets.human.right_shoulder},
                {unit_name = "player", node_name = "j_rightshoulder", offset = common_offsets.human.right_shoulder_02},
                {fill = true, unit_name = "player", node_name = "j_rightshoulder", offset = common_offsets.human.right_shoulder__back_right},
                {unit_name = "player", node_name = "j_spine", gear_node = "back_right", offset = common_offsets.human.back_right},
                {fill = true, unit_name = "player", node_name = "j_spine", offset = common_offsets.human.back_right__endpoint},
                {unit_name = "weapon", offset = common_offsets.human.endpoint},
            },
        },
        ogryn = {
            hips_back = {
                {unit_name = "weapon", offset = vector3_box(.025, 1.25, .045), rotation_offset = vector3_box(0, -45, 0)},
                {fill = true, unit_name = "player", node_name = "j_hips", offset = vector3_box(-.1, 0, .075), rotation_offset = vector3_box(0, -90, 0)},
                {unit_name = "player", node_name = "j_hips", gear_node = "hips_left",  offset = {
                    wielded = vector3_box(.05, .2, .05),
                    unwielded = vector3_box(.1, .35, .075)
                }, rotation_offset = vector3_box(0, -90, 0)},
                {fill = true, unit_name = "player", node_name = "j_hips", offset = vector3_box(0, .05, 0), rotation_offset = vector3_box(0, -90, 0)},
                {unit_name = "player", node_name = "j_spine2", gear_node = "chest", offset = vector3_box(.05, -.0125, .1), rotation_offset = vector3_box(0, -55, 0)},
                {fill = true, unit_name = "player", node_name = "j_rightshoulder", offset = vector3_box(-.1, .03, -.03), rotation_offset = vector3_box(0, -20, 0)},
                {unit_name = "player", node_name = "j_rightshoulder", offset = vector3_box(-.22, 0, -.4), rotation_offset = vector3_box(0, -10, 0)},
                {fill = true, unit_name = "player", node_name = "j_rightshoulder", offset = vector3_box(0, -.03, -.025), rotation_offset = vector3_box(0, 25, 0)},
                {unit_name = "player", node_name = "j_spine2", gear_node = "back_right", offset = vector3_box(.4, 0, -.1), rotation_offset = vector3_box(0, 55, 0)},
                {fill = true, unit_name = "player", node_name = "j_spine2", offset = {
                    wielded = vector3_box(-.1, .1, 0),
                    unwielded = vector3_box(.05, 0, 0)
                }, rotation_offset = vector3_box(0, 65, 0)},
                {unit_name = "weapon", offset = vector3_box(.025, -.05, .025), rotation_offset = vector3_box(0, 65, 0)},
            },
        },
    }
--#endregion

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐ ##############################################################################################
-- ##### │  │  ├─┤└─┐└─┐ ##############################################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘ ##############################################################################################

local WeaponSlingExtension = class("WeaponSlingExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

WeaponSlingExtension.init = function(self, extension_init_context, unit, extension_init_data)
    WeaponSlingExtension.super.init(self, extension_init_context, unit, extension_init_data)
    -- Attributes
    self.profile = extension_init_data.profile
    self.equipment = extension_init_data.equipment
    self.wielded_slot = extension_init_data.wielded_slot
    self.camera = extension_init_data.camera
    self.gear_node_units = self:visible_equipment__gear_node_units()
    self.slot_loaded = {}
    self.gear_node = {}
    self.items = {}
    self.sling_units = {}
    self.dummy_units = {}
    self.sling_data = {}
    self.sling_chain = {}
    self.linked = {}
    self.size = {}
    self.cached = {}
    self.is_gadget = {}
    self.weapon_units = {}
    -- Events
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    managers.event:register(self, "weapon_customization_attach_point_changed", "on_attach_point_changed")
    managers.event:register(self, "weapon_customization_unload", "on_unload")
    -- Set values
    self:on_settings_changed()
    -- Set initialized
    self.initialized = not self:is_ogryn()
end

WeaponSlingExtension.delete = function(self)
    -- Delete sling units
    self:delete_sling_units()
    -- Events
    managers.event:unregister(self, "weapon_customization_attach_point_changed")
    managers.event:unregister(self, "weapon_customization_settings_changed")
    managers.event:unregister(self, "weapon_customization_unload")
    -- Set uninitialized
    self.initialized = false
    -- Delete
    WeaponSlingExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

WeaponSlingExtension.help_units = function(self)
    return self.sling_units[self.equipment[SLOT_SECONDARY]]
end

WeaponSlingExtension.is_ogryn = function(self)
    return self.profile.archetype.name == "ogryn"
end

WeaponSlingExtension.get_breed = function(self)
    return self:is_ogryn() and "ogryn" or "human"
end

WeaponSlingExtension.is_wielded = function(self, slot)
    return self.wielded_slot and self.wielded_slot.name == slot.name
end

WeaponSlingExtension.visible_equipment__gear_node_units = function(self)
    return mod:execute_extension(self.player_unit, "visible_equipment_system", "gear_node_units")
end

WeaponSlingExtension.visible_equipment__weapon_unit = function(self, slot_name)
    return mod:execute_extension(self.player_unit, "visible_equipment_system", "weapon_unit", slot_name)
end

WeaponSlingExtension.visible_equipment__weapon_size = function(self, slot_name)
    return mod:execute_extension(self.player_unit, "visible_equipment_system", "weapon_size", slot_name)
end

-- ##### ┌┬┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │││├┤  │ ├─┤│ │ ││└─┐ ########################################################################################
-- ##### ┴ ┴└─┘ ┴ ┴ ┴└─┘─┴┘└─┘ ########################################################################################

WeaponSlingExtension.spawn_sling_unit = function(self)
    local sling_unit = world_spawn_unit_ex(self.world, MODEL)
    unit_set_texture_for_materials(sling_unit, "base_bc", TEXTURE_BC, true)
    unit_set_texture_for_materials(sling_unit, "base_nm", TEXTURE_NM, true)
    unit_set_texture_for_materials(sling_unit, "base_orm", TEXTURE_ORM, true)
    return sling_unit
end

WeaponSlingExtension.spawn_sling_units = function(self, slot)
    local sling_chain = self.sling_chain[slot]
    local sling_units = {}
    if sling_chain then
        for i = 1, #sling_chain, 1 do
            sling_units[i] = self:spawn_sling_unit()
        end
    end
    return sling_units
end

WeaponSlingExtension.delete_sling_units = function(self, slot)
    local sling_units = self.sling_units[slot]
    if sling_units then
        for i = 1, #sling_units, 1 do
            world_unlink_unit(self.world, sling_units[i])
            world_destroy_unit(self.world, sling_units[i])
        end
    end
end


WeaponSlingExtension.load_slots = function(self)
    if self.initialized then
        -- Iterate slots
        for slot_name, slot in pairs(self.equipment) do
            -- Load
            self:load_slot(slot)
        end
    end
end

WeaponSlingExtension.load_slot = function(self, slot)
    if not self.slot_loaded[slot] then
        local slot_item = slot and slot.item
        if slot_item and (slot_item.item_type == WEAPON_RANGED or slot_item.item_type == WEAPON_MELEE) then
            local Item_name = slot_item and mod.gear_settings:short_name(slot_item.name)
            if Item_name and not table.contains(no_sling, Item_name) then
                local weapon_size = self:visible_equipment__weapon_size(slot.name) or .5
                if weapon_size and weapon_size > .9 then --or slot_item.item_type == WEAPON_MELEE then
                    self.gear_node[slot] = mod.gear_settings:get(slot_item, "gear_node") or "back_right"
                    local breed_chain = sling_chains[self:get_breed()]
                    self.sling_chain[slot] = breed_chain[self.gear_node[slot]]
                    self.items[slot] = slot_item
                    self.sling_data[slot] = {}
                    self.sling_units[slot] = self:spawn_sling_units(slot)
                    self.dummy_units[slot] = self:visible_equipment__weapon_unit(slot.name)
                    self.cached[slot] = {}
                    self.is_gadget[slot] = slot_item.item_type == GADGET
                    self.slot_loaded[slot] = true
                end
            end
        end
    end
end

WeaponSlingExtension.delete_slots = function(self)
    for slot_name, slot in pairs(self.equipment) do
        self:delete_slot(slot)
    end
end

WeaponSlingExtension.delete_slot = function(self, slot)
    if self.slot_loaded[slot] then
        self:delete_sling_units(slot)
        self.slot_loaded[slot] = false
    end
end
 
-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

WeaponSlingExtension.on_equip_slot = function(self, slot)
    self:load_slot(slot)
    self:on_attach_point_changed()
end

WeaponSlingExtension.on_unequip_slot = function(self, slot)
    self:delete_slot(slot)
    self:on_attach_point_changed()
end

WeaponSlingExtension.on_attach_point_changed = function(self)
    for slot_name, slot in pairs(self.equipment) do
        local slot_item = slot and slot.item
        if slot_item and self.slot_loaded[slot] and (slot_item.item_type == WEAPON_MELEE or slot_item.item_type == WEAPON_RANGED) then
            self.gear_node[slot] = mod.gear_settings:get(slot_item, "gear_node")
        end
    end
end

WeaponSlingExtension.on_unload = function(self)
    for slot_name, slot in pairs(self.equipment) do
        self:delete_slot(slot)
    end
end

WeaponSlingExtension.on_wield_slot = function(self, slot)
    self.wielded_slot = slot
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

WeaponSlingExtension.update_sling_visibility = function(self, slot)
    local sling_units = self.sling_units[slot]
    if sling_units then
        for i = 1, #sling_units, 1 do
            unit_set_unit_visibility(sling_units[i], not self.first_person)
        end
        unit_set_unit_visibility(sling_units[#sling_units], false)
    end
end

WeaponSlingExtension.prev_chain_link = function(self, slot, chain_link_index, offset_type)
    -- local slot_cache = self.cached[slot]
    local sling_chain = self.sling_chain[slot]
    local sling_data = self.sling_data[slot]
    for i = chain_link_index, 1, -1 do
        local chain_link = sling_chain[i]
        local fill = not sling_chain[i].fill or offset_type
        local offset = not offset_type or (chain_link.offset and chain_link.offset[offset_type])
        if fill and offset then
            return sling_data[i], i
        end
    end
end

WeaponSlingExtension.next_chain_link = function(self, slot, chain_link_index, offset_type)
    -- local slot_cache = self.cached[slot]
    local sling_chain = self.sling_chain[slot]
    local sling_data = self.sling_data[slot]
    
    for i = chain_link_index, #sling_chain, 1 do
        local chain_link = sling_chain[i]
        local fill = not sling_chain[i].fill or offset_type
        local offset = not offset_type or (chain_link.offset and chain_link.offset[offset_type])
        if fill and offset then
            return sling_data[i], i
        end
    end
end

WeaponSlingExtension.weapon_unit = function(self, slot)
    if not self.weapon_units[slot] then
        if self:is_wielded(slot) then
            if self:get_first_person() then
                self.weapon_units[slot] = slot.unit_1p
            else
                self.weapon_units[slot] = slot.unit_3p
            end
        else
            self.weapon_units[slot] = self.dummy_units[slot]
        end
    end
end

WeaponSlingExtension.chain_unit = function(self, slot, chain_link_index)
    local slot_cache = self.cached[slot]
    local cached = slot_cache[chain_link_index]
    if not cached.unit then
        local sling_chain = self.sling_chain[slot]
        local chain_link = sling_chain[chain_link_index]
        local chain_unit = self.weapon_units[slot]
        local chain_node = 1
        if chain_link.gear_node then
            chain_unit = self.gear_node_units[chain_link.gear_node]
        elseif chain_link.unit_name == "player" then
            chain_unit = self.player_unit
            if chain_link.node_name then
                chain_node = unit_node(self.player_unit, chain_link.node_name)
            end
        end
        cached.unit = {  
            chain_unit = chain_unit,
            chain_node = chain_node,
        }
    end
end

WeaponSlingExtension.chain_offset = function(self, slot, chain_link_index, offset_type)
    local slot_cache = self.cached[slot]
    local cached = slot_cache[chain_link_index]
    if not cached[offset_type.."_offset"] then
        local sling_chain = self.sling_chain[slot]
        local chain_link = sling_chain[chain_link_index]
        -- local offset = chain_link.offset
        local offset = chain_link.offset and chain_link.offset[offset_type]
        if offset and type(offset) == "table" then
            -- offset = self:is_wielded(slot) and offset.wielded or offset.unwielded
            cached[offset_type.."_offset"] = offset.unwielded --and vector3_box(offset.unwielded) or false
            cached[offset_type.."_offset_wielded"] = offset.wielded --and vector3_box(offset.wielded) or false
        else
            cached[offset_type.."_offset"] = offset --and vector3_box(offset) or false
        end
        -- wielded = offset and vector3_unbox(offset)
        -- cached[offset_type.."_offset"] = offset and vector3_box(offset) or false
    end
end

WeaponSlingExtension.update = function(self, dt, t)
    if self.initialized then

        self.first_person = self:get_first_person()

        for slot_name, slot in pairs(self.equipment) do
            local sling_units = self.sling_units[slot]
            local sling_data = self.sling_data[slot]
            local sling_chain = self.sling_chain[slot]
            local wielded = self:is_wielded(slot)
            local gadget = self.is_gadget[slot]
            local slot_cache = self.cached[slot]

            if self.slot_loaded[slot] and sling_chain then

                self:weapon_unit(slot)
                local weapon_unit = self.weapon_units[slot]

                if weapon_unit and unit_alive(weapon_unit) then

                    -- Link
                    -- if not self.linked[slot] then
                    --     for i = 1, #sling_chain, 1 do
                    --         slot_cache[i] = slot_cache[i] or {}
                    --         local cached = slot_cache[i]
                    --         if cached.rotation_offset then
                    --             -- local position = unit_world_position(cached.unit.chain_unit, cached.unit.chain_node)
                    --             local rotation = unit_world_rotation(cached.unit.chain_unit, cached.unit.chain_node)
                    --             local mat = quaternion_matrix4x4(rotation)
                    --             local p_offset = cached.position_offset and vector3_unbox(cached.position_offset) or vector3(0, 0, 0)
                    --             local chain_position = matrix4x4_transform(mat, p_offset)
                    --             world_link_unit(self.world, sling_units[i], 1, cached.unit.chain_unit, cached.unit.chain_node)
                    --             -- unit_set_local_position(sling_units[i], 1, chain_position)
                    --         end
                    --     end
                    --     -- self.linked[slot] = true
                    -- end

                    -- Set key chain positions
                    for i = 1, #sling_chain, 1 do
                        local chain_link = sling_chain[i]

                        if not chain_link.fill and not gadget then

                            slot_cache[i] = slot_cache[i] or {}
                            local cached = slot_cache[i]

                            self:chain_unit(slot, i)

                            local position = unit_world_position(cached.unit.chain_unit, cached.unit.chain_node)
                            local rotation = unit_world_rotation(cached.unit.chain_unit, cached.unit.chain_node)
                            local mat = quaternion_matrix4x4(rotation)

                            self:chain_offset(slot, i, "position")

                            local offset = wielded and cached.position_offset_wielded or cached.position_offset
                            local p_offset = offset and vector3_unbox(offset) or vector3(0, 0, 0)
                            local chain_position = position + matrix4x4_transform(mat, p_offset)
                            -- Modding tools
                            if unit_get_data(sling_units[i], "unit_manipulation_position_offset") then
                                chain_position = chain_position + vector3_unbox(unit_get_data(sling_units[i], "unit_manipulation_position_offset"))
                            end

                            sling_data[i] = sling_data[i] or {
                                position = vector3_box(chain_position),
                            }
                            sling_data[i].position:store(chain_position)
                            
                            unit_set_local_position(sling_units[i], 1, chain_position)

                        end
                    end

                    -- Set fill chain positions
                    for i = 1, #sling_chain, 1 do
                        local chain_link = sling_chain[i]

                        if chain_link.fill and not gadget then

                            slot_cache[i] = slot_cache[i] or {}
                            local cached = slot_cache[i]

                            local prev_chain_link = self:prev_chain_link(slot, i)
                            local prev_chain_position = prev_chain_link and prev_chain_link.position and vector3_unbox(prev_chain_link.position)

                            local next_chain_link = self:next_chain_link(slot, i)
                            local next_chain_position = next_chain_link and next_chain_link.position and vector3_unbox(next_chain_link.position)

                            if prev_chain_position and next_chain_position then

                                local progress = math_ease_sine(.5)

                                self:chain_unit(slot, i)

                                local position = unit_world_position(cached.unit.chain_unit, cached.unit.chain_node)
                                local rotation = unit_world_rotation(cached.unit.chain_unit, cached.unit.chain_node)
                                local mat = quaternion_matrix4x4(rotation)

                                self:chain_offset(slot, i, "position")

                                local offset = wielded and cached.position_offset_wielded or cached.position_offset
                                local p_offset = offset and vector3_unbox(offset) or vector3(0, 0, 0)
                                -- local p_offset = cached.position_offset and vector3_unbox(cached.position_offset) or vector3(0, 0, 0)
                                local chain_position = vector3_lerp(prev_chain_position, next_chain_position, progress) + matrix4x4_transform(mat, p_offset)
                                -- Modding tools
                                if unit_get_data(sling_units[i], "unit_manipulation_position_offset") then
                                    chain_position = chain_position + vector3_unbox(unit_get_data(sling_units[i], "unit_manipulation_position_offset"))
                                end

                                sling_data[i] = sling_data[i] or {
                                    position = vector3_box(chain_position),
                                }
                                sling_data[i].position:store(chain_position)

                                unit_set_local_position(sling_units[i], 1, chain_position)

                            end
                        end
                    end

                    -- Set chain rotations
                    for i = 1, #sling_chain, 1 do
                        local chain_link = sling_chain[i]

                        if not gadget then
                            slot_cache[i] = slot_cache[i] or {}
                            local cached = slot_cache[i]

                            local next_chain_link = sling_data[i+1]
                            local next_chain_position = next_chain_link and next_chain_link.position and vector3_unbox(next_chain_link.position)

                            local prev_chain_link = sling_data[i-1]
                            local prev_chain_position = prev_chain_link and prev_chain_link.position and vector3_unbox(prev_chain_link.position)

                            local chain_position = sling_data[i] and sling_data[i].position and vector3_unbox(sling_data[i].position) or vector3(0, 0, 0)
                            -- Modding tools
                            if unit_get_data(sling_units[i], "unit_manipulation_position_offset") then
                                chain_position = chain_position + vector3_unbox(unit_get_data(sling_units[i], "unit_manipulation_position_offset"))
                            end

                            self:chain_offset(slot, i, "rotation")

                            local other_chain_position = next_chain_position or prev_chain_position or vector3(0, 0, 0)

                            -- if not cached.rotation_offset then
                                local r_offset = cached.rotation_offset and vector3_unbox(cached.rotation_offset) or vector3(0, 0, 0)
                                local progress = math_ease_sine(.5)
                                local unit_rotate = quaternion_from_vector(vector3(180, 0, 0) + r_offset)
                                -- local direction = chain_position - other_chain_position
                                local chain_look = quaternion_look(chain_position - other_chain_position)
                                -- local chain_look = quaternion_look(vector3(direction[1], direction[2], direction[3]))
                                unit_set_local_rotation(sling_units[i], 1, quaternion_multiply(chain_look, unit_rotate))
                                -- unit_set_local_rotation(sling_units[i], 1, chain_look)
                            -- else
                            --     local r_offset = cached.rotation_offset and vector3_unbox(cached.rotation_offset) or vector3(0, 0, 0)
                            --     local unit_rotate = quaternion_from_vector(vector3(180, 0, 0) + r_offset)
                            --     unit_set_local_rotation(sling_units[i], 1, unit_rotate)
                            -- end
                            --     local prev_chain_link, prev_chain_link_index = self:prev_chain_link(slot, i, "rotation")
                            --     local prev_chain_rotation_v = prev_chain_link and prev_chain_link.rotation and vector3_unbox(prev_chain_link.rotation)
                            --     local prev_chain_rotation = quaternion_from_vector(prev_chain_rotation_v)

                            --     local next_chain_link, next_chain_link_index = self:next_chain_link(slot, i, "rotation")
                            --     local next_chain_rotation_v = next_chain_link and next_chain_link.rotation and vector3_unbox(next_chain_link.rotation)
                            --     local next_chain_rotation = quaternion_from_vector(next_chain_rotation_v)

                            --     local count = next_chain_link_index - prev_chain_link_index
                            --     local local_index = i - prev_chain_link_index
                            --     local progress = math_ease_sine(local_index / count)
                            --     quaternion_lerp(prev_chain_rotation, next_chain_rotation, progress)
                            -- end

                            local multi = 4
                            local x, z = 2.5, .5
                            unit_set_local_scale(sling_units[i], 1, vector3(x, vector3_distance(chain_position, other_chain_position) * multi, z))

                            -- world_update_unit_and_children(self.world, sling_units[i])
                        else

                        end
                    end

                    -- Link
                    -- self.linked[slot] = true
                    -- if not self.linked[slot] then
                    --     -- for i = 1, #sling_chain, 1 do
                    --     --     slot_cache[i] = slot_cache[i] or {}
                    --     --     local cached = slot_cache[i]
                    --     --     if cached.rotation_offset then
                    --     --         -- local position = unit_world_position(cached.unit.chain_unit, cached.unit.chain_node)
                    --     --         local rotation = unit_world_rotation(cached.unit.chain_unit, cached.unit.chain_node)
                    --     --         local mat = quaternion_matrix4x4(rotation)
                    --     --         local p_offset = cached.position_offset and vector3_unbox(cached.position_offset) or vector3(0, 0, 0)
                    --     --         local chain_position = matrix4x4_transform(mat, p_offset)
                    --     --         world_link_unit(self.world, sling_units[i], 1, cached.unit.chain_unit, cached.unit.chain_node)
                    --     --         -- unit_set_local_position(sling_units[i], 1, chain_position)
                    --     --     end
                    --     -- end
                    --     self.linked[slot] = true
                    -- end

                    -- -- Set chain rotations
                    -- for i = 1, #sling_chain, 1 do
                    --     local chain_link = sling_chain[i]

                    --     if not gadget then
                    --         slot_cache[i] = slot_cache[i] or {}
                    --         local cached = slot_cache[i]

                    --         local next_chain_link = sling_data[i+1]
                    --         local next_chain_position = next_chain_link and next_chain_link.position and vector3_unbox(next_chain_link.position)

                    --         local prev_chain_link = sling_data[i-1]
                    --         local prev_chain_position = prev_chain_link and prev_chain_link.position and vector3_unbox(prev_chain_link.position)

                    --         local chain_position = sling_data[i] and sling_data[i].position and vector3_unbox(sling_data[i].position) or vector3(0, 0, 0)
                    --         -- Modding tools
                    --         if unit_get_data(sling_units[i], "unit_manipulation_position_offset") then
                    --             chain_position = chain_position + vector3_unbox(unit_get_data(sling_units[i], "unit_manipulation_position_offset"))
                    --         end

                    --         -- self:chain_offset(slot, i, "rotation")

                    --         local other_chain_position = next_chain_position or prev_chain_position or vector3(0, 0, 0)

                    --         if not cached.rotation_offset then
                    --         --     local r_offset = vector3_unbox(cached.rotation_offset)
                    --         --     local progress = math_ease_sine(.5)
                    --         --     local unit_rotate = quaternion_from_vector(vector3(180, 0, 0) + r_offset)
                    --         --     local direction = chain_position - other_chain_position
                    --         --     -- local chain_look = quaternion_look(chain_position - other_chain_position)
                    --         --     local chain_look = quaternion_look(vector3(direction[1], direction[2], direction[3]))
                    --         --     unit_set_local_rotation(sling_units[i], 1, quaternion_multiply(chain_look, unit_rotate))
                    --         --     -- unit_set_local_rotation(sling_units[i], 1, chain_look)
                    --         -- else
                    --             -- local prev_chain_link, prev_chain_link_index = self:prev_chain_link(slot, i, "rotation")
                    --             -- local prev_chain_rotation_v = prev_chain_link and prev_chain_link.rotation and vector3_unbox(prev_chain_link.rotation) or vector3(0, 0, 0)
                    --             -- local prev_chain_rotation = quaternion_from_vector(prev_chain_rotation_v)
                    --             -- local prev_unit = sling_units[prev_chain_link_index]

                    --             -- local next_chain_link, next_chain_link_index = self:next_chain_link(slot, i, "rotation")
                    --             -- local next_chain_rotation_v = next_chain_link and next_chain_link.rotation and vector3_unbox(next_chain_link.rotation) or vector3(0, 0, 0)
                    --             -- local next_chain_rotation = quaternion_from_vector(next_chain_rotation_v)
                    --             -- local next_unit = sling_units[next_chain_link_index]
                    --             if not cached.prev then
                    --                 local prev_chain_link, prev_chain_link_index = self:prev_chain_link(slot, i, "rotation")
                    --                 cached.prev = {
                    --                     chain_link = prev_chain_link,
                    --                     chain_index = prev_chain_link_index,
                    --                 }
                    --             end
                    --             if not cached.next then
                    --                 local next_chain_link, next_chain_link_index = self:next_chain_link(slot, i, "rotation")
                    --                 cached.next = {
                    --                     chain_link = next_chain_link,
                    --                     chain_index = next_chain_link_index,
                    --                 }
                    --             end

                    --             -- local prev_chain_rotation_v = cached.prev.chain_link and cached.prev.chain_link.rotation and vector3_unbox(cached.prev.chain_link.rotation) or vector3(0, 0, 0)
                    --             -- local prev_chain_rotation = quaternion_from_vector(prev_chain_rotation_v)
                    --             local prev_unit = sling_units[cached.prev.chain_index]
                    --             local prev_chain_rotation = unit_world_rotation(prev_unit, 1)

                    --             -- local next_chain_rotation_v = cached.next.chain_link and cached.next.chain_link.rotation and vector3_unbox(cached.next.chain_link.rotation) or vector3(0, 0, 0)
                    --             -- local next_chain_rotation = quaternion_from_vector(next_chain_rotation_v)
                    --             local next_unit = sling_units[cached.next.chain_index]
                    --             local next_chain_rotation = unit_world_rotation(next_unit, 1)

                    --             -- local rotation = quaternion_to_vector(unit_world_rotation(sling_units[i], 1))
                    --             local unit_rotate = quaternion_from_vector(vector3(180, 0, 0))
                    --             -- local chain_look = quaternion_look(chain_position - other_chain_position)
                    --             -- unit_set_local_rotation(sling_units[i], 1, quaternion_multiply(chain_look, unit_rotate))

                    --             -- local prev_rotation = unit_world_rotation(prev_unit, 1)
                    --             -- local prev_rot = quaternion_to_vector(prev_rotation)
                    --             -- local next_rotation = unit_world_rotation(next_unit, 1)
                    --             -- local next_rot = quaternion_to_vector(next_rotation)
                    --             -- local this_rotation = unit_world_rotation(sling_units[i], 1)
                    --             -- local this_rot = quaternion_to_vector(this_rotation)

                    --             local count = cached.next.chain_index - cached.prev.chain_index
                    --             local local_index = i - cached.prev.chain_index
                    --             local progress = math_ease_sine(local_index / count)
                    --             local stage = quaternion_lerp(prev_chain_rotation, next_chain_rotation, progress)
                    --             -- local stage_rot = quaternion_to_vector(stage)
                    --             -- local rotation = quaternion_from_vector(vector3(this_rot[1], stage_rot[2], this_rot[3]))
                    --             -- unit_set_local_rotation(sling_units[i], 1, rotation)
                    --             local chain_look = quaternion_multiply(quaternion_look(chain_position - other_chain_position), unit_rotate)
                    --             -- local chain_look = quaternion_look(vector3(direction[1], direction[2], direction[3]))
                    --             local mix = quaternion_lerp(chain_look, stage, .2)
                    --             unit_set_local_rotation(sling_units[i], 1, mix)
                    --         end

                    --         -- local multi = 4
                    --         -- local x, z = 2.5, .5
                    --         -- unit_set_local_scale(sling_units[i], 1, vector3(x, vector3_distance(chain_position, other_chain_position) * multi, z))

                    --         world_update_unit_and_children(self.world, sling_units[i])
                    --     else

                    --     end
                    -- end

                end

                self:update_sling_visibility(slot)

            end
        end
    end
end

-- WeaponSlingExtension.set_foot_step_interval = function(self)
--     if self.initialized then
--         local wielded_slot = self.wielded_slot
--         if wielded_slot and self.slot_loaded[wielded_slot] then
--             local item = wielded_slot and wielded_slot.item
--             local weapon_template = self.weapon_template[wielded_slot]
--             self.footstep_intervals = weapon_template and weapon_template.footstep_intervals
--         elseif not wielded_slot or wielded_slot.name == SLOT_UNARMED then
--             local breed = self:get_breed()
--             local hub = self.is_in_hub and "_hub" or ""
--             local name = "unarmed_"..tostring(breed)..tostring(hub)
--             if footstep_intervals_templates[name] then
--                 self.footstep_intervals = footstep_intervals_templates[name]
--             end
--         end
--     end
-- end

WeaponSlingExtension.on_settings_changed = function(self)

end