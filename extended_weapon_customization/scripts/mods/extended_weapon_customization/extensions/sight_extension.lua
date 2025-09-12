local mod = get_mod("extended_weapon_customization")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local class = class
    local CLASS = CLASS
    local world = World
    local pairs = pairs
    local vector3 = Vector3
    local tostring = tostring
    local unit_node = unit.node
    local script_unit = ScriptUnit
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local vector3_unbox = vector3_box.unbox
    local script_unit_extension = script_unit.extension
    local unit_set_local_position = unit.set_local_position
    local script_unit_add_extension = script_unit.add_extension
    local script_unit_remove_extension = script_unit.remove_extension
    local world_update_unit_and_children = world.update_unit_and_children
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local SLOT_SECONDARY = "slot_secondary"

-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #################################################################
-- ##### └─┐││ ┬├─┤ │ └─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #################################################################
-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #################################################################

local SightExtension = class("SightExtension")

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

SightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    self.unit = unit

    self.visual_loadout_extension = extension_init_data.visual_loadout_extension
    self.first_person_extension = script_unit_extension(self.unit, "first_person_system")
    self.unit_data_extension = script_unit_extension(unit, "unit_data_system")
    self.alternate_fire_component = self.unit_data_extension:read_component("alternate_fire")
    self.first_person_unit = self.first_person_extension:first_person_unit()

    self.weapon = self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    self.sight_name = mod:fetch_attachment(self.weapon.attachments, "sight")

    self.offset = {
        position = vector3_box(vector3_zero()),
        rotation = vector3_box(vector3_zero()),
    }
    self.current_offset = {
        position = vector3_box(vector3_zero()),
        rotation = vector3_box(vector3_zero()),
    }

    local sight_offset_fixes = mod:collect_fixes(self.weapon, "sight_offset")
    if sight_offset_fixes then
        for fix, attachment_slot in pairs(sight_offset_fixes) do
            self.sight_fix = fix
        end
    end

    if self.sight_fix then
        self.offset = self.sight_fix.offset
    end

end

SightExtension.delete = function(self)

end

SightExtension.on_equip_weapon = function(self)
    self.weapon = self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    self.sight_name = mod:fetch_attachment(self.weapon.attachments, "sight")
    -- mod:echo("Sight: "..tostring(self.sight_name))
end

SightExtension.update = function(self, dt, t)

    local current_position = vector3_unbox(self.current_offset.position) or vector3_zero()

    if self.first_person_extension:is_in_first_person_mode() and self.alternate_fire_component.is_active then
        local offset_position = vector3_unbox(self.offset.position)
        current_position = vector3_lerp(current_position, offset_position, dt * 10)
    else
        current_position = vector3_lerp(current_position, vector3_zero(), dt * 10)
    end

    self.current_offset.position:store(current_position)

    local node = unit_node(self.first_person_unit, "ap_aim")

    unit_set_local_position(self.first_person_unit, node, current_position)

end
