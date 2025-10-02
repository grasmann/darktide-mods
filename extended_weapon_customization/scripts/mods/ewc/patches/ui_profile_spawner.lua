local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local master_items = mod:original_require("scripts/backend/master_items")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local table = table
    local string = string
    local tostring = tostring
    local table_size = table.size
    local unit_alive = unit.alive
    local table_clear = table.clear
    local string_find = string.find
    local unit_set_data = unit.set_data
    local table_contains = table.contains
    local table_set_readonly = table.set_readonly
    local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.UIProfileSpawner, "wield_slot", function(func, self, slot_id, ...)

    local world = self._world
	local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

        local wielded_slot = character_spawn_data.wielded_slot
	    local slot_id = wielded_slot and wielded_slot.name
	    local slot = slot_id and character_spawn_data.slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items and equipped_items[slot_id]

        if slot and slot.unit_3p and slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p] then
            mod:execute_attachment_callbacks_in_item(slot_item, world, slot.attachments_by_unit_3p[slot.unit_3p], "ui_item_deinit")
        end

    end

    -- Original function
    func(self, slot_id, ...)

    local character_spawn_data = self._character_spawn_data
    if character_spawn_data then

	    local slot = slot_id and character_spawn_data.slots[slot_id]
        local equipped_items = character_spawn_data.equipped_items
        local slot_item = equipped_items and equipped_items[slot_id]

        if slot and slot.unit_3p and slot.attachments_by_unit_3p and slot.attachments_by_unit_3p[slot.unit_3p] then
            mod:execute_attachment_callbacks_in_item(slot_item, world, slot.attachments_by_unit_3p[slot.unit_3p], "ui_item_init")
        end

    end

end)
