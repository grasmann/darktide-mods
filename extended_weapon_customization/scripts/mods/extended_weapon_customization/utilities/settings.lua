local mod = get_mod("extended_weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attachments = mod:io_dofile("extended_weapon_customization/scripts/mods/extended_weapon_customization/utilities/attachments")

return {
    fixes = attachments.fixes,
    attachments = attachments.attachments,
    attachment_data_by_item_string = attachments.attachment_data_by_item_string,
    attachment_name_by_item_string = attachments.attachment_name_by_item_string,
    attachment_data_by_attachment_name = attachments.attachment_data_by_attachment_name,
}
