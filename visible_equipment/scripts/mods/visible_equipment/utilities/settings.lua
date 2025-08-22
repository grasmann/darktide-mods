local mod = get_mod("visible_equipment")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

return {
    placement_camera = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/placement_cameras"),
    animations = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/animations"),
    placements = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/placements"),
    backpacks = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/backpacks"),
    momentum = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/momentums"),
    offsets = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/offsets"),
    scripts = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/scripts"),
    sounds = mod:io_dofile("visible_equipment/scripts/mods/visible_equipment/utilities/sounds"),
}
