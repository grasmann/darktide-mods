local mod = get_mod("extended_weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attachments = mod:io_dofile("extended_weapon_customization/scripts/mods/ewc/utilities/attachments")

return {
    fixes = attachments.fixes,
    attachments = attachments.attachments,
    attachment_slots = attachments.attachment_slots,
    kitbashs = attachments.kitbashs,
    attachment_data_by_item_string = attachments.attachment_data_by_item_string,
    attachment_name_by_item_string = attachments.attachment_name_by_item_string,
    attachment_data_by_attachment_name = attachments.attachment_data_by_attachment_name,
    hide_attachment_slots_in_menu = attachments.hide_attachment_slots_in_menu,
}
