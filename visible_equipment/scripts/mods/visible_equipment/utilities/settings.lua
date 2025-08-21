local mod = get_mod("visible_equipment")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

return {
    sounds = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/sounds"),
    offsets = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/offsets"),
    animations = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/animations"),
    backpacks = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/backpacks"),
    momentum = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/momentums"),
    placements = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/placements"),
    placement_camera = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/placement_cameras"),
}
