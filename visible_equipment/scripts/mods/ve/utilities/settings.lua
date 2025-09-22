local mod = get_mod("visible_equipment")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

return {
    placement_camera = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/placement_cameras"),
    hide_attachments = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/hide_attachments"),
    animations = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/animations"),
    placements = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/placements"),
    backpacks = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/backpacks"),
    momentum = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/momentums"),
    offsets = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/offsets"),
    scripts = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/scripts"),
    sounds = mod:io_dofile("visible_equipment/scripts/mods/ve/utilities/sounds"),
}
