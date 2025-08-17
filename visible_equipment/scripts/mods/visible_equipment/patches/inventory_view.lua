local mod = get_mod("visible_equipment")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local unit = Unit
    local pairs = pairs
    local CLASS = CLASS
    local vector3 = Vector3
    local unit_alive = unit.alive
    local vector3_box = Vector3Box
    local vector3_zero = vector3.zero
    local vector3_unbox = vector3_box.unbox
    local unit_local_position = unit.local_position
    local unit_set_local_position = unit.set_local_position
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌  ┬ ┬┌─┐┌─┐┬┌─┌─┐ ######################################################################
-- ##### ├┤ │ │││││   │ ││ ││││  ├─┤│ ││ │├┴┐└─┐ ######################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘  ┴ ┴└─┘└─┘┴ ┴└─┘ ######################################################################

mod:hook(CLASS.InventoryView, "on_exit", function(func, self, ...)
    -- Original function
    func(self, ...)
    -- Update world equipment position
    local me = mod:me()
    if me and unit_alive(me) then
        local equipment_component = mod:equipment_component_from_unit(me)
        if equipment_component then
            equipment_component:position_objects()
        end
    end
    -- Update main menu background view equipment position
    local main_menu_background_view = mod:get_view("main_menu_background_view")
    if main_menu_background_view then
        main_menu_background_view:update_placements()
    end

end)

mod:hook(CLASS.InventoryView, "_switch_active_layout", function(func, self, tab_context, ...)

    local find_entry = function(name)
        for _, entry in pairs(tab_context.layout) do
            if entry.name == name or (entry.slot and entry.slot.name == name) then
                return entry
            end
        end
    end

    if find_entry("slot_gear_extra_cosmetic") then

        local add_entry = function(name, scenegraph_id, slot_name, item_type)
            tab_context.layout[#tab_context.layout+1] = {
                item_type = item_type,
                navigation_grid_indices = {3, 1},
                initial_rotation = 3.1415926535897931,
                default_icon = "content/ui/materials/icons/items/gears/legs/empty",
                slot = {
                    slot_type = "gear",
                    store_category = "outfits",
                    display_icon = "content/ui/materials/icons/cosmetics/categories/upper_body",
                    display_name = "loc_inventory_title_slot_gear_extra_cosmetic",
                    equipped_in_inventory = true,
                    name = slot_name,
                },
                widget_type = "gear_placement_slot",
                scenegraph_id = scenegraph_id, --"slot_primary_placement",
                slot_icon = "content/ui/materials/icons/item_types/beveled/accessories",
                slot_title = "loc_inventory_title_slot_gear_extra_cosmetic",
                loadout_slot = true,
                name = name,
            }
        end

        if not find_entry("slot_primary_placement") then
            add_entry("slot_primary_placement", "slot_primary_placement", "slot_primary", "WEAPON_MELEE")
        end

        if not find_entry("slot_secondary_placement") then
            add_entry("slot_secondary_placement", "slot_secondary_placement", "slot_secondary", "WEAPON_RANGED")
        end

    end

    -- Original function
    func(self, tab_context, ...)
end)
