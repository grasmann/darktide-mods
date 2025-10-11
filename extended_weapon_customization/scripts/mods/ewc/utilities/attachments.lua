local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local type = type
    local pairs = pairs
    local table = table
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local vector3_one = vector3.one
    local table_clone = table.clone
    local vector3_zero = vector3.zero
    local table_clone_safe = table.clone_safe
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local pt = mod:pt()
local extract_flicker = {
    default = "default",
    led_flicker = "lasgun_p1",
    incandescent_flicker = "autogun_p1",
    worn_incandescent_flicker = "ogryn_heavy_stubber_p2",
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.update_lookup_tables = function(self, attachments, attachment_data_by_item_string, attachment_name_by_item_string, attachment_data_by_attachment_name, optional_mod_of_origin)

    local attachments = attachments or self.settings.attachments
    local attachment_data_by_item_string = attachment_data_by_item_string or self.settings.attachment_data_by_item_string
    local attachment_name_by_item_string = attachment_name_by_item_string or self.settings.attachment_name_by_item_string
    local attachment_data_by_attachment_name = attachment_data_by_attachment_name or self.settings.attachment_data_by_attachment_name
    local attachment_data_origin = pt.attachment_data_origin

    for weapon_template, weapon_attachments in pairs(attachments) do
        for attachment_slot, attachment_entires in pairs(weapon_attachments) do
            for attachment_name, attachment_data in pairs(attachment_entires) do
                
                attachment_data_by_item_string[attachment_data.replacement_path] = attachment_data
                
                attachment_name_by_item_string[attachment_data.replacement_path] = attachment_name
                
                attachment_data_by_attachment_name[attachment_name] = attachment_data

                if optional_mod_of_origin then
                    local attachment_data = self.settings.attachments[weapon_template][attachment_slot][attachment_name]
                    attachment_data_origin[attachment_data] = optional_mod_of_origin
                end

            end
        end
    end

end

mod.update_flashlight_templates = function(self, flashlight_templates)

    for name, template in pairs(flashlight_templates) do

        -- Copy template
        mod.settings.flashlight_templates[name] = table_clone(template)

        -- Check flicker
        if not template.flicker or type(template.flicker) == "string" then
            -- Flicker is not set or a string
            local flicker_name = template.flicker or "default"
            -- Get extract name
            local extract_name = flicker_name and extract_flicker[flicker_name] or extract_flicker.default
            -- Get flicker template from original
            local flicker = FlashlightTemplates[extract_name].flicker
            -- Set flicker template
            mod.settings.flashlight_templates[name].flicker = table_clone(flicker)
        end
    end

end

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local weapons_folder = "extended_weapon_customization/scripts/mods/ewc/weapons/"
local ogryn_powermaul_slabshield_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_powermaul_slabshield_p1_m1")
local ogryn_heavystubber_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_heavystubber_p1_m1")
local ogryn_heavystubber_p2_m1 = mod:io_dofile(weapons_folder.."ogryn_heavystubber_p2_m1")
local ogryn_combatblade_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_combatblade_p1_m1")
local shotpistol_shield_p1_m1 = mod:io_dofile(weapons_folder.."shotpistol_shield_p1_m1")
local ogryn_pickaxe_2h_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_pickaxe_2h_p1_m1")
local powermaul_shield_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_shield_p1_m1")
local thunderhammer_2h_p1_m1 = mod:io_dofile(weapons_folder.."thunderhammer_2h_p1_m1")
local ogryn_rippergun_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_rippergun_p1_m1")
local ogryn_powermaul_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_powermaul_p1_m1")
local ogryn_gauntlet_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_gauntlet_p1_m1")
local forcesword_2h_p1_m1 = mod:io_dofile(weapons_folder.."forcesword_2h_p1_m1")
local chainsword_2h_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_2h_p1_m1")
local ogryn_thumper_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_thumper_p1_m1")
local powersword_2h_p1_m1 = mod:io_dofile(weapons_folder.."powersword_2h_p1_m1")
local stubrevolver_p1_m1 = mod:io_dofile(weapons_folder.."stubrevolver_p1_m1")
local powermaul_2h_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_2h_p1_m1")
local combatsword_p1_m1 = mod:io_dofile(weapons_folder.."combatsword_p1_m1")
local combatsword_p2_m1 = mod:io_dofile(weapons_folder.."combatsword_p2_m1")
local combatsword_p3_m1 = mod:io_dofile(weapons_folder.."combatsword_p3_m1")
local combatknife_p1_m1 = mod:io_dofile(weapons_folder.."combatknife_p1_m1")
local powersword_p1_m1 = mod:io_dofile(weapons_folder.."powersword_p1_m1")
local powersword_p2_m1 = mod:io_dofile(weapons_folder.."powersword_p2_m1")
local ogryn_club_p2_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p2_m1")
local forcesword_p1_m1 = mod:io_dofile(weapons_folder.."forcesword_p1_m1")
local chainsword_p1_m1 = mod:io_dofile(weapons_folder.."chainsword_p1_m1")
local boltpistol_p1_m1 = mod:io_dofile(weapons_folder.."boltpistol_p1_m1")
local autopistol_p1_m1 = mod:io_dofile(weapons_folder.."autopistol_p1_m1")
local forcestaff_p1_m1 = mod:io_dofile(weapons_folder.."forcestaff_p1_m1")
local ogryn_club_p1_m1 = mod:io_dofile(weapons_folder.."ogryn_club_p1_m1")
local powermaul_p1_m1 = mod:io_dofile(weapons_folder.."powermaul_p1_m1")
local powermaul_p2_m1 = mod:io_dofile(weapons_folder.."powermaul_p2_m1")
local plasmagun_p1_m1 = mod:io_dofile(weapons_folder.."plasmagun_p1_m1")
local laspistol_p1_m1 = mod:io_dofile(weapons_folder.."laspistol_p1_m1")
local combataxe_p1_m1 = mod:io_dofile(weapons_folder.."combataxe_p1_m1")
local combataxe_p2_m1 = mod:io_dofile(weapons_folder.."combataxe_p2_m1")
local combataxe_p3_m1 = mod:io_dofile(weapons_folder.."combataxe_p3_m1")
local chainaxe_p1_m1 = mod:io_dofile(weapons_folder.."chainaxe_p1_m1")
local autogun_p1_m1 = mod:io_dofile(weapons_folder.."autogun_p1_m1")
local autogun_p2_m1 = mod:io_dofile(weapons_folder.."autogun_p2_m1")
local autogun_p3_m1 = mod:io_dofile(weapons_folder.."autogun_p3_m1")
local shotgun_p1_m1 = mod:io_dofile(weapons_folder.."shotgun_p1_m1")
local shotgun_p2_m1 = mod:io_dofile(weapons_folder.."shotgun_p2_m1")
local shotgun_p4_m1 = mod:io_dofile(weapons_folder.."shotgun_p4_m1")
local bolter_p1_m1 = mod:io_dofile(weapons_folder.."bolter_p1_m1")
local flamer_p1_m1 = mod:io_dofile(weapons_folder.."flamer_p1_m1")
local lasgun_p1_m1 = mod:io_dofile(weapons_folder.."lasgun_p1_m1")
local lasgun_p2_m1 = mod:io_dofile(weapons_folder.."lasgun_p2_m1")
local lasgun_p3_m1 = mod:io_dofile(weapons_folder.."lasgun_p3_m1")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local attachments = {
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.attachments,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.attachments,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.attachments,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.attachments,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.attachments,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.attachments,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.attachments,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.attachments,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.attachments,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.attachments,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.attachments,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.attachments,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.attachments,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.attachments,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.attachments,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.attachments,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.attachments,
    combatsword_p1_m1 = combatsword_p1_m1.attachments,
    combatsword_p2_m1 = combatsword_p2_m1.attachments,
    combatsword_p3_m1 = combatsword_p3_m1.attachments,
    combatknife_p1_m1 = combatknife_p1_m1.attachments,
    powersword_p1_m1 = powersword_p1_m1.attachments,
    powersword_p2_m1 = powersword_p2_m1.attachments,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.attachments,
    forcesword_p1_m1 = forcesword_p1_m1.attachments,
    chainsword_p1_m1 = chainsword_p1_m1.attachments,
    autopistol_p1_m1 = autopistol_p1_m1.attachments,
    boltpistol_p1_m1 = boltpistol_p1_m1.attachments,
    forcestaff_p1_m1 = forcestaff_p1_m1.attachments,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.attachments,
    powermaul_p1_m1 = powermaul_p1_m1.attachments,
    powermaul_p2_m1 = powermaul_p2_m1.attachments,
    plasmagun_p1_m1 = plasmagun_p1_m1.attachments,
    laspistol_p1_m1 = laspistol_p1_m1.attachments,
    combataxe_p1_m1 = combataxe_p1_m1.attachments,
    combataxe_p2_m1 = combataxe_p2_m1.attachments,
    combataxe_p3_m1 = combataxe_p3_m1.attachments,
    chainaxe_p1_m1 = chainaxe_p1_m1.attachments,
    autogun_p1_m1 = autogun_p1_m1.attachments,
    autogun_p2_m1 = autogun_p2_m1.attachments,
    autogun_p3_m1 = autogun_p3_m1.attachments,
    shotgun_p1_m1 = shotgun_p1_m1.attachments,
    shotgun_p2_m1 = shotgun_p2_m1.attachments,
    shotgun_p4_m1 = shotgun_p4_m1.attachments,
    bolter_p1_m1 = bolter_p1_m1.attachments,
    flamer_p1_m1 = flamer_p1_m1.attachments,
    lasgun_p1_m1 = lasgun_p1_m1.attachments,
    lasgun_p2_m1 = lasgun_p2_m1.attachments,
    lasgun_p3_m1 = lasgun_p3_m1.attachments,
}

--#region Copies
    --#region Ogryn melee
        attachments.ogryn_combatblade_p1_m2 = table_clone_safe(attachments.ogryn_combatblade_p1_m1)
        attachments.ogryn_combatblade_p1_m3 = table_clone_safe(attachments.ogryn_combatblade_p1_m1)
        attachments.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(attachments.ogryn_pickaxe_2h_p1_m1)
        attachments.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(attachments.ogryn_pickaxe_2h_p1_m1)
        attachments.ogryn_powermaul_p1_m2 = table_clone_safe(attachments.ogryn_powermaul_p1_m1)
		attachments.ogryn_powermaul_p1_m3 = table_clone_safe(attachments.ogryn_powermaul_p1_m1)
        attachments.ogryn_club_p2_m2 = table_clone_safe(attachments.ogryn_club_p2_m1)
		attachments.ogryn_club_p1_m3 = table_clone_safe(attachments.ogryn_club_p1_m1)
		attachments.ogryn_club_p2_m3 = table_clone_safe(attachments.ogryn_club_p2_m1)
        attachments.ogryn_club_p1_m2 = table_clone_safe(attachments.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        attachments.ogryn_heavystubber_p1_m2 = table_clone_safe(attachments.ogryn_heavystubber_p1_m1)
		attachments.ogryn_heavystubber_p1_m3 = table_clone_safe(attachments.ogryn_heavystubber_p1_m1)
        attachments.ogryn_heavystubber_p2_m2 = table_clone_safe(attachments.ogryn_heavystubber_p2_m1)
		attachments.ogryn_heavystubber_p2_m3 = table_clone_safe(attachments.ogryn_heavystubber_p2_m1)
        attachments.ogryn_rippergun_p1_m2 = table_clone_safe(attachments.ogryn_rippergun_p1_m1)
		attachments.ogryn_rippergun_p1_m3 = table_clone_safe(attachments.ogryn_rippergun_p1_m1)
        attachments.ogryn_thumper_p1_m2 = table_clone_safe(attachments.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        attachments.powermaul_shield_p1_m2 = table_clone_safe(attachments.powermaul_shield_p1_m1)
        attachments.thunderhammer_2h_p1_m2 = table_clone_safe(attachments.thunderhammer_2h_p1_m1)
        attachments.forcesword_2h_p1_m2 = table_clone_safe(attachments.forcesword_2h_p1_m1)
        attachments.chainsword_2h_p1_m2 = table_clone_safe(attachments.chainsword_2h_p1_m1)
        attachments.powersword_2h_p1_m2 = table_clone_safe(attachments.powersword_2h_p1_m1)
        attachments.combatknife_p1_m2 = table_clone_safe(attachments.combatknife_p1_m1)
        attachments.combatsword_p1_m2 = table_clone_safe(attachments.combatsword_p1_m1)
        attachments.combatsword_p2_m2 = table_clone_safe(attachments.combatsword_p2_m1)
        attachments.combatsword_p3_m2 = table_clone_safe(attachments.combatsword_p3_m1)
        attachments.combatsword_p1_m3 = table_clone_safe(attachments.combatsword_p1_m1)
		attachments.combatsword_p2_m3 = table_clone_safe(attachments.combatsword_p2_m1)
		attachments.combatsword_p3_m3 = table_clone_safe(attachments.combatsword_p3_m1)
		attachments.forcesword_p1_m3 = table_clone_safe(attachments.forcesword_p1_m1)
        attachments.powersword_p1_m3 = table_clone_safe(attachments.powersword_p1_m1)
        attachments.powersword_p1_m2 = table_clone_safe(attachments.powersword_p1_m1)
        attachments.powersword_p2_m2 = table_clone_safe(attachments.powersword_p2_m1)
        attachments.chainsword_p1_m2 = table_clone_safe(attachments.chainsword_p1_m1)
        attachments.forcesword_p1_m2 = table_clone_safe(attachments.forcesword_p1_m1)
        attachments.combataxe_p1_m2 = table_clone_safe(attachments.combataxe_p1_m1)
        attachments.combataxe_p1_m3 = table_clone_safe(attachments.combataxe_p1_m1)
        attachments.combataxe_p2_m2 = table_clone_safe(attachments.combataxe_p2_m1)
        attachments.combataxe_p2_m3 = table_clone_safe(attachments.combataxe_p2_m1)
        attachments.combataxe_p3_m2 = table_clone_safe(attachments.combataxe_p3_m1)
        attachments.combataxe_p3_m3 = table_clone_safe(attachments.combataxe_p3_m1)
        attachments.powermaul_p1_m2 = table_clone_safe(attachments.powermaul_p1_m1)
        attachments.chainaxe_p1_m2 = table_clone_safe(attachments.chainaxe_p1_m1)
            attachments.bot_combataxe_linesman = table_clone_safe(attachments.combataxe_p1_m1)
            attachments.bot_combatsword_linesman_p1 = table_clone_safe(attachments.combatsword_p1_m1)
            attachments.bot_combatsword_linesman_p2 = table_clone_safe(attachments.combatsword_p2_m1)
    --#endregion
    --#region Human ranged
        attachments.stubrevolver_p1_m3 = table_clone_safe(attachments.stubrevolver_p1_m1)
        attachments.stubrevolver_p1_m2 = table_clone_safe(attachments.stubrevolver_p1_m1)
        attachments.forcestaff_p2_m1 = table_clone_safe(attachments.forcestaff_p1_m1)
        attachments.forcestaff_p3_m1 = table_clone_safe(attachments.forcestaff_p1_m1)
        attachments.forcestaff_p4_m1 = table_clone_safe(attachments.forcestaff_p1_m1)
        attachments.boltpistol_p1_m2 = table_clone_safe(attachments.boltpistol_p1_m1)
        attachments.laspistol_p1_m2 = table_clone_safe(attachments.laspistol_p1_m1)
        attachments.laspistol_p1_m3 = table_clone_safe(attachments.laspistol_p1_m1)
        attachments.autogun_p1_m2 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p1_m3 = table_clone_safe(attachments.autogun_p1_m1)
        -- attachments.autogun_p2_m1 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p2_m2 = table_clone_safe(attachments.autogun_p2_m1)
        attachments.autogun_p2_m3 = table_clone_safe(attachments.autogun_p2_m1)
        -- attachments.autogun_p3_m1 = table_clone_safe(attachments.autogun_p1_m1)
        attachments.autogun_p3_m2 = table_clone_safe(attachments.autogun_p3_m1)
        attachments.autogun_p3_m3 = table_clone_safe(attachments.autogun_p3_m1)
        attachments.shotgun_p1_m2 = table_clone_safe(attachments.shotgun_p1_m1)
        attachments.shotgun_p1_m3 = table_clone_safe(attachments.shotgun_p1_m1)
        attachments.shotgun_p4_m2 = table_clone_safe(attachments.shotgun_p4_m1)
        attachments.shotgun_p4_m3 = table_clone_safe(attachments.shotgun_p4_m1)
        attachments.bolter_p1_m2 = table_clone_safe(attachments.bolter_p1_m1)
        attachments.bolter_p1_m3 = table_clone_safe(attachments.bolter_p1_m1)
        attachments.lasgun_p1_m2 = table_clone_safe(attachments.lasgun_p1_m1)
        attachments.lasgun_p1_m3 = table_clone_safe(attachments.lasgun_p1_m1)
        attachments.lasgun_p2_m2 = table_clone_safe(attachments.lasgun_p2_m1)
        attachments.lasgun_p2_m3 = table_clone_safe(attachments.lasgun_p2_m1)
        attachments.lasgun_p3_m2 = table_clone_safe(attachments.lasgun_p3_m1)
        attachments.lasgun_p3_m3 = table_clone_safe(attachments.lasgun_p3_m1)
            attachments.bot_laspistol_killshot = table_clone_safe(attachments.laspistol_p1_m1)
            attachments.bot_zola_laspistol = table_clone_safe(attachments.laspistol_p1_m1)
            attachments.high_bot_lasgun_killshot = table_clone_safe(attachments.lasgun_p1_m1)
            attachments.bot_lasgun_killshot = table_clone_safe(attachments.lasgun_p1_m1)
            attachments.high_bot_autogun_killshot = table_clone_safe(attachments.autogun_p3_m1)
            attachments.bot_autogun_killshot = table_clone_safe(attachments.autogun_p3_m1)
    --#endregion
--#endregion

local fixes = {
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.fixes,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.fixes,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.fixes,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.fixes,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.fixes,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.fixes,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.fixes,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.fixes,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.fixes,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.fixes,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.fixes,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.fixes,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.fixes,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.fixes,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.fixes,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.fixes,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.fixes,
    combatsword_p1_m1 = combatsword_p1_m1.fixes,
    combatsword_p2_m1 = combatsword_p2_m1.fixes,
    combatsword_p3_m1 = combatsword_p3_m1.fixes,
    combatknife_p1_m1 = combatknife_p1_m1.fixes,
    powersword_p1_m1 = powersword_p1_m1.fixes,
    powersword_p2_m1 = powersword_p2_m1.fixes,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.fixes,
    forcesword_p1_m1 = forcesword_p1_m1.fixes,
    chainsword_p1_m1 = chainsword_p1_m1.fixes,
    autopistol_p1_m1 = autopistol_p1_m1.fixes,
    boltpistol_p1_m1 = boltpistol_p1_m1.fixes,
    forcestaff_p1_m1 = forcestaff_p1_m1.fixes,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.fixes,
    powermaul_p1_m1 = powermaul_p1_m1.fixes,
    powermaul_p2_m1 = powermaul_p2_m1.fixes,
    plasmagun_p1_m1 = plasmagun_p1_m1.fixes,
    laspistol_p1_m1 = laspistol_p1_m1.fixes,
    combataxe_p1_m1 = combataxe_p1_m1.fixes,
    combataxe_p2_m1 = combataxe_p2_m1.fixes,
    combataxe_p3_m1 = combataxe_p3_m1.fixes,
    chainaxe_p1_m1 = chainaxe_p1_m1.fixes,
    autogun_p1_m1 = autogun_p1_m1.fixes,
    autogun_p2_m1 = autogun_p2_m1.fixes,
    autogun_p3_m1 = autogun_p3_m1.fixes,
    shotgun_p1_m1 = shotgun_p1_m1.fixes,
    shotgun_p2_m1 = shotgun_p2_m1.fixes,
    shotgun_p4_m1 = shotgun_p4_m1.fixes,
    bolter_p1_m1 = bolter_p1_m1.fixes,
    flamer_p1_m1 = flamer_p1_m1.fixes,
    lasgun_p1_m1 = lasgun_p1_m1.fixes,
    lasgun_p2_m1 = lasgun_p2_m1.fixes,
    lasgun_p3_m1 = lasgun_p3_m1.fixes,
}

--#region Copies
    --#region Ogryn melee
        fixes.ogryn_combatblade_p1_m2 = table_clone_safe(fixes.ogryn_combatblade_p1_m1)
        fixes.ogryn_combatblade_p1_m3 = table_clone_safe(fixes.ogryn_combatblade_p1_m1)
        fixes.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(fixes.ogryn_pickaxe_2h_p1_m1)
        fixes.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(fixes.ogryn_pickaxe_2h_p1_m1)
        fixes.ogryn_powermaul_p1_m2 = table_clone_safe(fixes.ogryn_powermaul_p1_m1)
		fixes.ogryn_powermaul_p1_m3 = table_clone_safe(fixes.ogryn_powermaul_p1_m1)
        fixes.ogryn_club_p2_m2 = table_clone_safe(fixes.ogryn_club_p2_m1)
		fixes.ogryn_club_p1_m3 = table_clone_safe(fixes.ogryn_club_p1_m1)
		fixes.ogryn_club_p2_m3 = table_clone_safe(fixes.ogryn_club_p2_m1)
        fixes.ogryn_club_p1_m2 = table_clone_safe(fixes.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        fixes.ogryn_heavystubber_p1_m2 = table_clone_safe(fixes.ogryn_heavystubber_p1_m1)
		fixes.ogryn_heavystubber_p1_m3 = table_clone_safe(fixes.ogryn_heavystubber_p1_m1)
        fixes.ogryn_heavystubber_p2_m2 = table_clone_safe(fixes.ogryn_heavystubber_p2_m1)
		fixes.ogryn_heavystubber_p2_m3 = table_clone_safe(fixes.ogryn_heavystubber_p2_m1)
        fixes.ogryn_rippergun_p1_m2 = table_clone_safe(fixes.ogryn_rippergun_p1_m1)
		fixes.ogryn_rippergun_p1_m3 = table_clone_safe(fixes.ogryn_rippergun_p1_m1)
        fixes.ogryn_thumper_p1_m2 = table_clone_safe(fixes.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        fixes.powermaul_shield_p1_m2 = table_clone_safe(fixes.powermaul_shield_p1_m1)
        fixes.thunderhammer_2h_p1_m2 = table_clone_safe(fixes.thunderhammer_2h_p1_m1)
        fixes.forcesword_2h_p1_m2 = table_clone_safe(fixes.forcesword_2h_p1_m1)
        fixes.chainsword_2h_p1_m2 = table_clone_safe(fixes.chainsword_2h_p1_m1)
        fixes.powersword_2h_p1_m2 = table_clone_safe(fixes.powersword_2h_p1_m1)
        fixes.combatknife_p1_m2 = table_clone_safe(fixes.combatknife_p1_m1)
        fixes.combatsword_p1_m2 = table_clone_safe(fixes.combatsword_p1_m1)
        fixes.combatsword_p2_m2 = table_clone_safe(fixes.combatsword_p2_m1)
        fixes.combatsword_p3_m2 = table_clone_safe(fixes.combatsword_p3_m1)
        fixes.combatsword_p1_m3 = table_clone_safe(fixes.combatsword_p1_m1)
		fixes.combatsword_p2_m3 = table_clone_safe(fixes.combatsword_p2_m1)
		fixes.combatsword_p3_m3 = table_clone_safe(fixes.combatsword_p3_m1)
		fixes.forcesword_p1_m3 = table_clone_safe(fixes.forcesword_p1_m1)
        fixes.powersword_p1_m3 = table_clone_safe(fixes.powersword_p1_m1)
        fixes.powersword_p1_m2 = table_clone_safe(fixes.powersword_p1_m1)
        fixes.powersword_p2_m2 = table_clone_safe(fixes.powersword_p2_m1)
        fixes.chainsword_p1_m2 = table_clone_safe(fixes.chainsword_p1_m1)
        fixes.forcesword_p1_m2 = table_clone_safe(fixes.forcesword_p1_m1)
        fixes.combataxe_p1_m2 = table_clone_safe(fixes.combataxe_p1_m1)
        fixes.combataxe_p1_m3 = table_clone_safe(fixes.combataxe_p1_m1)
        fixes.combataxe_p2_m2 = table_clone_safe(fixes.combataxe_p2_m1)
        fixes.combataxe_p2_m3 = table_clone_safe(fixes.combataxe_p2_m1)
        fixes.combataxe_p3_m2 = table_clone_safe(fixes.combataxe_p3_m1)
        fixes.combataxe_p3_m3 = table_clone_safe(fixes.combataxe_p3_m1)
        fixes.powermaul_p1_m2 = table_clone_safe(fixes.powermaul_p1_m1)
        fixes.chainaxe_p1_m2 = table_clone_safe(fixes.chainaxe_p1_m1)
            fixes.bot_combataxe_linesman = table_clone_safe(fixes.combataxe_p1_m1)
            fixes.bot_combatsword_linesman_p1 = table_clone_safe(fixes.combatsword_p1_m1)
            fixes.bot_combatsword_linesman_p2 = table_clone_safe(fixes.combatsword_p2_m1)
    --#endregion
    --#region Human ranged
        fixes.stubrevolver_p1_m3 = table_clone_safe(fixes.stubrevolver_p1_m1)
        fixes.stubrevolver_p1_m2 = table_clone_safe(fixes.stubrevolver_p1_m1)
        fixes.forcestaff_p2_m1 = table_clone_safe(fixes.forcestaff_p1_m1)
        fixes.forcestaff_p3_m1 = table_clone_safe(fixes.forcestaff_p1_m1)
        fixes.forcestaff_p4_m1 = table_clone_safe(fixes.forcestaff_p1_m1)
        fixes.boltpistol_p1_m2 = table_clone_safe(fixes.boltpistol_p1_m1)
        fixes.laspistol_p1_m2 = table_clone_safe(fixes.laspistol_p1_m1)
        fixes.laspistol_p1_m3 = table_clone_safe(fixes.laspistol_p1_m1)
        fixes.autogun_p1_m2 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p1_m3 = table_clone_safe(fixes.autogun_p1_m1)
        -- fixes.autogun_p2_m1 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p2_m2 = table_clone_safe(fixes.autogun_p2_m1)
        fixes.autogun_p2_m3 = table_clone_safe(fixes.autogun_p2_m1)
        -- fixes.autogun_p3_m1 = table_clone_safe(fixes.autogun_p1_m1)
        fixes.autogun_p3_m2 = table_clone_safe(fixes.autogun_p3_m1)
        fixes.autogun_p3_m3 = table_clone_safe(fixes.autogun_p3_m1)
        fixes.shotgun_p1_m2 = table_clone_safe(fixes.shotgun_p1_m1)
        fixes.shotgun_p1_m3 = table_clone_safe(fixes.shotgun_p1_m1)
        fixes.shotgun_p4_m2 = table_clone_safe(fixes.shotgun_p4_m1)
        fixes.shotgun_p4_m3 = table_clone_safe(fixes.shotgun_p4_m1)
        fixes.bolter_p1_m2 = table_clone_safe(fixes.bolter_p1_m1)
        fixes.bolter_p1_m3 = table_clone_safe(fixes.bolter_p1_m1)
        fixes.lasgun_p1_m2 = table_clone_safe(fixes.lasgun_p1_m1)
        fixes.lasgun_p2_m2 = table_clone_safe(fixes.lasgun_p2_m1)
        fixes.lasgun_p2_m3 = table_clone_safe(fixes.lasgun_p2_m1)
        fixes.lasgun_p3_m2 = table_clone_safe(fixes.lasgun_p3_m1)
        fixes.lasgun_p3_m3 = table_clone_safe(fixes.lasgun_p3_m1)
		fixes.lasgun_p1_m3 = table_clone_safe(fixes.lasgun_p1_m1)
            fixes.bot_laspistol_killshot = table_clone_safe(fixes.laspistol_p1_m1)
            fixes.bot_zola_laspistol = table_clone_safe(fixes.laspistol_p1_m1)
            fixes.high_bot_lasgun_killshot = table_clone_safe(fixes.lasgun_p1_m1)
            fixes.bot_lasgun_killshot = table_clone_safe(fixes.lasgun_p1_m1)
            fixes.high_bot_autogun_killshot = table_clone_safe(fixes.autogun_p3_m1)
            fixes.bot_autogun_killshot = table_clone_safe(fixes.autogun_p3_m1)
    --#endregion
--#endregion

local attachment_slots = {
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.attachment_slots,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.attachment_slots,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.attachment_slots,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.attachment_slots,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.attachment_slots,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.attachment_slots,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.attachment_slots,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.attachment_slots,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.attachment_slots,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.attachment_slots,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.attachment_slots,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.attachment_slots,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.attachment_slots,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.attachment_slots,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.attachment_slots,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.attachment_slots,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.attachment_slots,
    combatsword_p1_m1 = combatsword_p1_m1.attachment_slots,
    combatsword_p2_m1 = combatsword_p2_m1.attachment_slots,
    combatsword_p3_m1 = combatsword_p3_m1.attachment_slots,
    combatknife_p1_m1 = combatknife_p1_m1.attachment_slots,
    powersword_p1_m1 = powersword_p1_m1.attachment_slots,
    powersword_p2_m1 = powersword_p2_m1.attachment_slots,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.attachment_slots,
    forcesword_p1_m1 = forcesword_p1_m1.attachment_slots,
    chainsword_p1_m1 = chainsword_p1_m1.attachment_slots,
    autopistol_p1_m1 = autopistol_p1_m1.attachment_slots,
    boltpistol_p1_m1 = boltpistol_p1_m1.attachment_slots,
    forcestaff_p1_m1 = forcestaff_p1_m1.attachment_slots,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.attachment_slots,
    powermaul_p1_m1 = powermaul_p1_m1.attachment_slots,
    powermaul_p2_m1 = powermaul_p2_m1.attachment_slots,
    plasmagun_p1_m1 = plasmagun_p1_m1.attachment_slots,
    laspistol_p1_m1 = laspistol_p1_m1.attachment_slots,
    combataxe_p1_m1 = combataxe_p1_m1.attachment_slots,
    combataxe_p2_m1 = combataxe_p2_m1.attachment_slots,
    combataxe_p3_m1 = combataxe_p3_m1.attachment_slots,
    chainaxe_p1_m1 = chainaxe_p1_m1.attachment_slots,
    autogun_p1_m1 = autogun_p1_m1.attachment_slots,
    autogun_p2_m1 = autogun_p2_m1.attachment_slots,
    autogun_p3_m1 = autogun_p3_m1.attachment_slots,
    shotgun_p1_m1 = shotgun_p1_m1.attachment_slots,
    shotgun_p2_m1 = shotgun_p2_m1.attachment_slots,
    shotgun_p4_m1 = shotgun_p4_m1.attachment_slots,
    bolter_p1_m1 = bolter_p1_m1.attachment_slots,
    flamer_p1_m1 = flamer_p1_m1.attachment_slots,
    lasgun_p1_m1 = lasgun_p1_m1.attachment_slots,
    lasgun_p2_m1 = lasgun_p2_m1.attachment_slots,
    lasgun_p3_m1 = lasgun_p3_m1.attachment_slots,
}

--#region Copies
    --#region Ogryn melee
        attachment_slots.ogryn_combatblade_p1_m2 = table_clone_safe(attachment_slots.ogryn_combatblade_p1_m1)
        attachment_slots.ogryn_combatblade_p1_m3 = table_clone_safe(attachment_slots.ogryn_combatblade_p1_m1)
        attachment_slots.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(attachment_slots.ogryn_pickaxe_2h_p1_m1)
        attachment_slots.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(attachment_slots.ogryn_pickaxe_2h_p1_m1)
        attachment_slots.ogryn_powermaul_p1_m2 = table_clone_safe(attachment_slots.ogryn_powermaul_p1_m1)
		attachment_slots.ogryn_powermaul_p1_m3 = table_clone_safe(attachment_slots.ogryn_powermaul_p1_m1)
        attachment_slots.ogryn_club_p2_m2 = table_clone_safe(attachment_slots.ogryn_club_p2_m1)
		attachment_slots.ogryn_club_p1_m3 = table_clone_safe(attachment_slots.ogryn_club_p1_m1)
		attachment_slots.ogryn_club_p2_m3 = table_clone_safe(attachment_slots.ogryn_club_p2_m1)
        attachment_slots.ogryn_club_p1_m2 = table_clone_safe(attachment_slots.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        attachment_slots.ogryn_heavystubber_p1_m2 = table_clone_safe(attachment_slots.ogryn_heavystubber_p1_m1)
		attachment_slots.ogryn_heavystubber_p1_m3 = table_clone_safe(attachment_slots.ogryn_heavystubber_p1_m1)
        attachment_slots.ogryn_heavystubber_p2_m2 = table_clone_safe(attachment_slots.ogryn_heavystubber_p2_m1)
		attachment_slots.ogryn_heavystubber_p2_m3 = table_clone_safe(attachment_slots.ogryn_heavystubber_p2_m1)
        attachment_slots.ogryn_rippergun_p1_m2 = table_clone_safe(attachment_slots.ogryn_rippergun_p1_m1)
		attachment_slots.ogryn_rippergun_p1_m3 = table_clone_safe(attachment_slots.ogryn_rippergun_p1_m1)
        attachment_slots.ogryn_thumper_p1_m2 = table_clone_safe(attachment_slots.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        attachment_slots.powermaul_shield_p1_m2 = table_clone_safe(attachment_slots.powermaul_shield_p1_m1)
        attachment_slots.thunderhammer_2h_p1_m2 = table_clone_safe(attachment_slots.thunderhammer_2h_p1_m1)
        attachment_slots.forcesword_2h_p1_m2 = table_clone_safe(attachment_slots.forcesword_2h_p1_m1)
        attachment_slots.chainsword_2h_p1_m2 = table_clone_safe(attachment_slots.chainsword_2h_p1_m1)
        attachment_slots.powersword_2h_p1_m2 = table_clone_safe(attachment_slots.powersword_2h_p1_m1)
        attachment_slots.combatknife_p1_m2 = table_clone_safe(attachment_slots.combatknife_p1_m1)
        attachment_slots.combatsword_p1_m2 = table_clone_safe(attachment_slots.combatsword_p1_m1)
        attachment_slots.combatsword_p2_m2 = table_clone_safe(attachment_slots.combatsword_p2_m1)
        attachment_slots.combatsword_p3_m2 = table_clone_safe(attachment_slots.combatsword_p3_m1)
        attachment_slots.combatsword_p1_m3 = table_clone_safe(attachment_slots.combatsword_p1_m1)
		attachment_slots.combatsword_p2_m3 = table_clone_safe(attachment_slots.combatsword_p2_m1)
		attachment_slots.combatsword_p3_m3 = table_clone_safe(attachment_slots.combatsword_p3_m1)
		attachment_slots.forcesword_p1_m3 = table_clone_safe(attachment_slots.forcesword_p1_m1)
        attachment_slots.powersword_p1_m3 = table_clone_safe(attachment_slots.powersword_p1_m1)
        attachment_slots.powersword_p1_m2 = table_clone_safe(attachment_slots.powersword_p1_m1)
        attachment_slots.powersword_p2_m2 = table_clone_safe(attachment_slots.powersword_p2_m1)
        attachment_slots.chainsword_p1_m2 = table_clone_safe(attachment_slots.chainsword_p1_m1)
        attachment_slots.forcesword_p1_m2 = table_clone_safe(attachment_slots.forcesword_p1_m1)
        attachment_slots.combataxe_p1_m2 = table_clone_safe(attachment_slots.combataxe_p1_m1)
        attachment_slots.combataxe_p1_m3 = table_clone_safe(attachment_slots.combataxe_p1_m1)
        attachment_slots.combataxe_p2_m2 = table_clone_safe(attachment_slots.combataxe_p2_m1)
        attachment_slots.combataxe_p2_m3 = table_clone_safe(attachment_slots.combataxe_p2_m1)
        attachment_slots.combataxe_p3_m2 = table_clone_safe(attachment_slots.combataxe_p3_m1)
        attachment_slots.combataxe_p3_m3 = table_clone_safe(attachment_slots.combataxe_p3_m1)
        attachment_slots.powermaul_p1_m2 = table_clone_safe(attachment_slots.powermaul_p1_m1)
        attachment_slots.chainaxe_p1_m2 = table_clone_safe(attachment_slots.chainaxe_p1_m1)
            attachment_slots.bot_combataxe_linesman = table_clone_safe(attachment_slots.combataxe_p1_m1)
            attachment_slots.bot_combatsword_linesman_p1 = table_clone_safe(attachment_slots.combatsword_p1_m1)
            attachment_slots.bot_combatsword_linesman_p2 = table_clone_safe(attachment_slots.combatsword_p2_m1)
    --#endregion
    --#region Human ranged
        attachment_slots.stubrevolver_p1_m3 = table_clone_safe(attachment_slots.stubrevolver_p1_m1)
        attachment_slots.stubrevolver_p1_m2 = table_clone_safe(attachment_slots.stubrevolver_p1_m1)
        attachment_slots.forcestaff_p2_m1 = table_clone_safe(attachment_slots.forcestaff_p1_m1)
        attachment_slots.forcestaff_p3_m1 = table_clone_safe(attachment_slots.forcestaff_p1_m1)
        attachment_slots.forcestaff_p4_m1 = table_clone_safe(attachment_slots.forcestaff_p1_m1)
        attachment_slots.boltpistol_p1_m2 = table_clone_safe(attachment_slots.boltpistol_p1_m1)
        attachment_slots.laspistol_p1_m2 = table_clone_safe(attachment_slots.laspistol_p1_m1)
        attachment_slots.laspistol_p1_m3 = table_clone_safe(attachment_slots.laspistol_p1_m1)
        attachment_slots.autogun_p1_m2 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p1_m3 = table_clone_safe(attachment_slots.autogun_p1_m1)
        -- attachment_slots.autogun_p2_m1 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p2_m2 = table_clone_safe(attachment_slots.autogun_p2_m1)
        attachment_slots.autogun_p2_m3 = table_clone_safe(attachment_slots.autogun_p2_m1)
        -- attachment_slots.autogun_p3_m1 = table_clone_safe(attachment_slots.autogun_p1_m1)
        attachment_slots.autogun_p3_m2 = table_clone_safe(attachment_slots.autogun_p3_m1)
        attachment_slots.autogun_p3_m3 = table_clone_safe(attachment_slots.autogun_p3_m1)
        attachment_slots.shotgun_p1_m2 = table_clone_safe(attachment_slots.shotgun_p1_m1)
        attachment_slots.shotgun_p1_m3 = table_clone_safe(attachment_slots.shotgun_p1_m1)
        attachment_slots.shotgun_p4_m2 = table_clone_safe(attachment_slots.shotgun_p4_m1)
        attachment_slots.shotgun_p4_m3 = table_clone_safe(attachment_slots.shotgun_p4_m1)
        attachment_slots.bolter_p1_m2 = table_clone_safe(attachment_slots.bolter_p1_m1)
        attachment_slots.bolter_p1_m3 = table_clone_safe(attachment_slots.bolter_p1_m1)
        attachment_slots.lasgun_p1_m2 = table_clone_safe(attachment_slots.lasgun_p1_m1)
        attachment_slots.lasgun_p2_m2 = table_clone_safe(attachment_slots.lasgun_p2_m1)
        attachment_slots.lasgun_p2_m3 = table_clone_safe(attachment_slots.lasgun_p2_m1)
        attachment_slots.lasgun_p3_m2 = table_clone_safe(attachment_slots.lasgun_p3_m1)
        attachment_slots.lasgun_p3_m3 = table_clone_safe(attachment_slots.lasgun_p3_m1)
		attachment_slots.lasgun_p1_m3 = table_clone_safe(attachment_slots.lasgun_p1_m1)
            attachment_slots.bot_laspistol_killshot = table_clone_safe(attachment_slots.laspistol_p1_m1)
            attachment_slots.bot_zola_laspistol = table_clone_safe(attachment_slots.laspistol_p1_m1)
            attachment_slots.high_bot_lasgun_killshot = table_clone_safe(attachment_slots.lasgun_p1_m1)
            attachment_slots.bot_lasgun_killshot = table_clone_safe(attachment_slots.lasgun_p1_m1)
            attachment_slots.high_bot_autogun_killshot = table_clone_safe(attachment_slots.autogun_p3_m1)
            attachment_slots.bot_autogun_killshot = table_clone_safe(attachment_slots.autogun_p3_m1)
    --#endregion
--#endregion

local kitbashs = {
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.kitbashs,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.kitbashs,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.kitbashs,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.kitbashs,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.kitbashs,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.kitbashs,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.kitbashs,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.kitbashs,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.kitbashs,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.kitbashs,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.kitbashs,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.kitbashs,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.kitbashs,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.kitbashs,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.kitbashs,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.kitbashs,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.kitbashs,
    combatsword_p1_m1 = combatsword_p1_m1.kitbashs,
    combatsword_p2_m1 = combatsword_p2_m1.kitbashs,
    combatsword_p3_m1 = combatsword_p3_m1.kitbashs,
    combatknife_p1_m1 = combatknife_p1_m1.kitbashs,
    powersword_p1_m1 = powersword_p1_m1.kitbashs,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.kitbashs,
    forcesword_p1_m1 = forcesword_p1_m1.kitbashs,
    chainsword_p1_m1 = chainsword_p1_m1.kitbashs,
    autopistol_p1_m1 = autopistol_p1_m1.kitbashs,
    boltpistol_p1_m1 = boltpistol_p1_m1.kitbashs,
    forcestaff_p1_m1 = forcestaff_p1_m1.kitbashs,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.kitbashs,
    powermaul_p1_m1 = powermaul_p1_m1.kitbashs,
    powermaul_p2_m1 = powermaul_p2_m1.kitbashs,
    plasmagun_p1_m1 = plasmagun_p1_m1.kitbashs,
    laspistol_p1_m1 = laspistol_p1_m1.kitbashs,
    combataxe_p1_m1 = combataxe_p1_m1.kitbashs,
    combataxe_p2_m1 = combataxe_p2_m1.kitbashs,
    combataxe_p3_m1 = combataxe_p3_m1.kitbashs,
    chainaxe_p1_m1 = chainaxe_p1_m1.kitbashs,
    autogun_p1_m1 = autogun_p1_m1.kitbashs,
    autogun_p2_m1 = autogun_p2_m1.kitbashs,
    autogun_p3_m1 = autogun_p3_m1.kitbashs,
    shotgun_p1_m1 = shotgun_p1_m1.kitbashs,
    shotgun_p2_m1 = shotgun_p2_m1.kitbashs,
    shotgun_p4_m1 = shotgun_p4_m1.kitbashs,
    bolter_p1_m1 = bolter_p1_m1.kitbashs,
    flamer_p1_m1 = flamer_p1_m1.kitbashs,
    lasgun_p1_m1 = lasgun_p1_m1.kitbashs,
    lasgun_p2_m1 = lasgun_p2_m1.kitbashs,
    lasgun_p3_m1 = lasgun_p3_m1.kitbashs,
}

-- Load kitbashes
for weapon_template, weapon_kitbashs in pairs(kitbashs) do
    mod:load_kitbash_collection(weapon_kitbashs)
end

-- Create lookup tables for attachments
local attachment_data_by_item_string = {}
local attachment_name_by_item_string = {}
local attachment_data_by_attachment_name = {}

-- Update lookup tables
mod:update_lookup_tables(attachments, attachment_data_by_item_string, attachment_name_by_item_string, attachment_data_by_attachment_name)

-- Hide attachment slots
local hide_attachment_slots_in_menu = {}

local flashlight_templates = {
    ogryn_powermaul_slabshield_p1_m1 = ogryn_powermaul_slabshield_p1_m1.flashlight_templates,
    ogryn_heavystubber_p1_m1 = ogryn_heavystubber_p1_m1.flashlight_templates,
    ogryn_heavystubber_p2_m1 = ogryn_heavystubber_p2_m1.flashlight_templates,
    ogryn_combatblade_p1_m1 = ogryn_combatblade_p1_m1.flashlight_templates,
    shotpistol_shield_p1_m1 = shotpistol_shield_p1_m1.flashlight_templates,
    ogryn_pickaxe_2h_p1_m1 = ogryn_pickaxe_2h_p1_m1.flashlight_templates,
    powermaul_shield_p1_m1 = powermaul_shield_p1_m1.flashlight_templates,
    thunderhammer_2h_p1_m1 = thunderhammer_2h_p1_m1.flashlight_templates,
    ogryn_rippergun_p1_m1 = ogryn_rippergun_p1_m1.flashlight_templates,
    ogryn_powermaul_p1_m1 = ogryn_powermaul_p1_m1.flashlight_templates,
    ogryn_gauntlet_p1_m1 = ogryn_gauntlet_p1_m1.flashlight_templates,
    forcesword_2h_p1_m1 = forcesword_2h_p1_m1.flashlight_templates,
    chainsword_2h_p1_m1 = chainsword_2h_p1_m1.flashlight_templates,
    ogryn_thumper_p1_m1 = ogryn_thumper_p1_m1.flashlight_templates,
    powersword_2h_p1_m1 = powersword_2h_p1_m1.flashlight_templates,
    stubrevolver_p1_m1 = stubrevolver_p1_m1.flashlight_templates,
    powermaul_2h_p1_m1 = powermaul_2h_p1_m1.flashlight_templates,
    combatsword_p1_m1 = combatsword_p1_m1.flashlight_templates,
    combatsword_p2_m1 = combatsword_p2_m1.flashlight_templates,
    combatsword_p3_m1 = combatsword_p3_m1.flashlight_templates,
    combatknife_p1_m1 = combatknife_p1_m1.flashlight_templates,
    powersword_p1_m1 = powersword_p1_m1.flashlight_templates,
    powersword_p2_m1 = powersword_p2_m1.flashlight_templates,
    ogryn_club_p2_m1 = ogryn_club_p2_m1.flashlight_templates,
    forcesword_p1_m1 = forcesword_p1_m1.flashlight_templates,
    chainsword_p1_m1 = chainsword_p1_m1.flashlight_templates,
    autopistol_p1_m1 = autopistol_p1_m1.flashlight_templates,
    boltpistol_p1_m1 = boltpistol_p1_m1.flashlight_templates,
    forcestaff_p1_m1 = forcestaff_p1_m1.flashlight_templates,
    ogryn_club_p1_m1 = ogryn_club_p1_m1.flashlight_templates,
    powermaul_p1_m1 = powermaul_p1_m1.flashlight_templates,
    powermaul_p2_m1 = powermaul_p2_m1.flashlight_templates,
    plasmagun_p1_m1 = plasmagun_p1_m1.flashlight_templates,
    laspistol_p1_m1 = laspistol_p1_m1.flashlight_templates,
    combataxe_p1_m1 = combataxe_p1_m1.flashlight_templates,
    combataxe_p2_m1 = combataxe_p2_m1.flashlight_templates,
    combataxe_p3_m1 = combataxe_p3_m1.flashlight_templates,
    chainaxe_p1_m1 = chainaxe_p1_m1.flashlight_templates,
    autogun_p1_m1 = autogun_p1_m1.flashlight_templates,
    autogun_p2_m1 = autogun_p2_m1.flashlight_templates,
    autogun_p3_m1 = autogun_p3_m1.flashlight_templates,
    shotgun_p1_m1 = shotgun_p1_m1.flashlight_templates,
    shotgun_p2_m1 = shotgun_p2_m1.flashlight_templates,
    shotgun_p4_m1 = shotgun_p4_m1.flashlight_templates,
    bolter_p1_m1 = bolter_p1_m1.flashlight_templates,
    flamer_p1_m1 = flamer_p1_m1.flashlight_templates,
    lasgun_p1_m1 = lasgun_p1_m1.flashlight_templates,
    lasgun_p2_m1 = lasgun_p2_m1.flashlight_templates,
    lasgun_p3_m1 = lasgun_p3_m1.flashlight_templates,
}

--#region Copies
    --#region Ogryn melee
        flashlight_templates.ogryn_combatblade_p1_m2 = table_clone_safe(flashlight_templates.ogryn_combatblade_p1_m1)
        flashlight_templates.ogryn_combatblade_p1_m3 = table_clone_safe(flashlight_templates.ogryn_combatblade_p1_m1)
        flashlight_templates.ogryn_pickaxe_2h_p1_m2 = table_clone_safe(flashlight_templates.ogryn_pickaxe_2h_p1_m1)
        flashlight_templates.ogryn_pickaxe_2h_p1_m3 = table_clone_safe(flashlight_templates.ogryn_pickaxe_2h_p1_m1)
        flashlight_templates.ogryn_powermaul_p1_m2 = table_clone_safe(flashlight_templates.ogryn_powermaul_p1_m1)
		flashlight_templates.ogryn_powermaul_p1_m3 = table_clone_safe(flashlight_templates.ogryn_powermaul_p1_m1)
        flashlight_templates.ogryn_club_p2_m2 = table_clone_safe(flashlight_templates.ogryn_club_p2_m1)
		flashlight_templates.ogryn_club_p1_m3 = table_clone_safe(flashlight_templates.ogryn_club_p1_m1)
		flashlight_templates.ogryn_club_p2_m3 = table_clone_safe(flashlight_templates.ogryn_club_p2_m1)
        flashlight_templates.ogryn_club_p1_m2 = table_clone_safe(flashlight_templates.ogryn_club_p1_m1)
    --#endregion
    --#region Ogryn ranged
        flashlight_templates.ogryn_heavystubber_p1_m2 = table_clone_safe(flashlight_templates.ogryn_heavystubber_p1_m1)
		flashlight_templates.ogryn_heavystubber_p1_m3 = table_clone_safe(flashlight_templates.ogryn_heavystubber_p1_m1)
        flashlight_templates.ogryn_heavystubber_p2_m2 = table_clone_safe(flashlight_templates.ogryn_heavystubber_p2_m1)
		flashlight_templates.ogryn_heavystubber_p2_m3 = table_clone_safe(flashlight_templates.ogryn_heavystubber_p2_m1)
        flashlight_templates.ogryn_rippergun_p1_m2 = table_clone_safe(flashlight_templates.ogryn_rippergun_p1_m1)
		flashlight_templates.ogryn_rippergun_p1_m3 = table_clone_safe(flashlight_templates.ogryn_rippergun_p1_m1)
        flashlight_templates.ogryn_thumper_p1_m2 = table_clone_safe(flashlight_templates.ogryn_thumper_p1_m1)
    --#endregion
    --#region Human melee
        flashlight_templates.powermaul_shield_p1_m2 = table_clone_safe(flashlight_templates.powermaul_shield_p1_m1)
        flashlight_templates.thunderhammer_2h_p1_m2 = table_clone_safe(flashlight_templates.thunderhammer_2h_p1_m1)
        flashlight_templates.forcesword_2h_p1_m2 = table_clone_safe(flashlight_templates.forcesword_2h_p1_m1)
        flashlight_templates.chainsword_2h_p1_m2 = table_clone_safe(flashlight_templates.chainsword_2h_p1_m1)
        flashlight_templates.powersword_2h_p1_m2 = table_clone_safe(flashlight_templates.powersword_2h_p1_m1)
        flashlight_templates.combatknife_p1_m2 = table_clone_safe(flashlight_templates.combatknife_p1_m1)
        flashlight_templates.combatsword_p1_m2 = table_clone_safe(flashlight_templates.combatsword_p1_m1)
        flashlight_templates.combatsword_p2_m2 = table_clone_safe(flashlight_templates.combatsword_p2_m1)
        flashlight_templates.combatsword_p3_m2 = table_clone_safe(flashlight_templates.combatsword_p3_m1)
        flashlight_templates.combatsword_p1_m3 = table_clone_safe(flashlight_templates.combatsword_p1_m1)
		flashlight_templates.combatsword_p2_m3 = table_clone_safe(flashlight_templates.combatsword_p2_m1)
		flashlight_templates.combatsword_p3_m3 = table_clone_safe(flashlight_templates.combatsword_p3_m1)
		flashlight_templates.forcesword_p1_m3 = table_clone_safe(flashlight_templates.forcesword_p1_m1)
        flashlight_templates.powersword_p1_m3 = table_clone_safe(flashlight_templates.powersword_p1_m1)
        flashlight_templates.powersword_p1_m2 = table_clone_safe(flashlight_templates.powersword_p1_m1)
        flashlight_templates.powersword_p2_m2 = table_clone_safe(flashlight_templates.powersword_p2_m1)
        flashlight_templates.chainsword_p1_m2 = table_clone_safe(flashlight_templates.chainsword_p1_m1)
        flashlight_templates.forcesword_p1_m2 = table_clone_safe(flashlight_templates.forcesword_p1_m1)
        flashlight_templates.combataxe_p1_m2 = table_clone_safe(flashlight_templates.combataxe_p1_m1)
        flashlight_templates.combataxe_p1_m3 = table_clone_safe(flashlight_templates.combataxe_p1_m1)
        flashlight_templates.combataxe_p2_m2 = table_clone_safe(flashlight_templates.combataxe_p2_m1)
        flashlight_templates.combataxe_p2_m3 = table_clone_safe(flashlight_templates.combataxe_p2_m1)
        flashlight_templates.combataxe_p3_m2 = table_clone_safe(flashlight_templates.combataxe_p3_m1)
        flashlight_templates.combataxe_p3_m3 = table_clone_safe(flashlight_templates.combataxe_p3_m1)
        flashlight_templates.powermaul_p1_m2 = table_clone_safe(flashlight_templates.powermaul_p1_m1)
        flashlight_templates.chainaxe_p1_m2 = table_clone_safe(flashlight_templates.chainaxe_p1_m1)
            flashlight_templates.bot_combataxe_linesman = table_clone_safe(flashlight_templates.combataxe_p1_m1)
            flashlight_templates.bot_combatsword_linesman_p1 = table_clone_safe(flashlight_templates.combatsword_p1_m1)
            flashlight_templates.bot_combatsword_linesman_p2 = table_clone_safe(flashlight_templates.combatsword_p2_m1)
    --#endregion
    --#region Human ranged
        flashlight_templates.stubrevolver_p1_m3 = table_clone_safe(flashlight_templates.stubrevolver_p1_m1)
        flashlight_templates.stubrevolver_p1_m2 = table_clone_safe(flashlight_templates.stubrevolver_p1_m1)
        flashlight_templates.forcestaff_p2_m1 = table_clone_safe(flashlight_templates.forcestaff_p1_m1)
        flashlight_templates.forcestaff_p3_m1 = table_clone_safe(flashlight_templates.forcestaff_p1_m1)
        flashlight_templates.forcestaff_p4_m1 = table_clone_safe(flashlight_templates.forcestaff_p1_m1)
        flashlight_templates.boltpistol_p1_m2 = table_clone_safe(flashlight_templates.boltpistol_p1_m1)
        flashlight_templates.laspistol_p1_m2 = table_clone_safe(flashlight_templates.laspistol_p1_m1)
        flashlight_templates.laspistol_p1_m3 = table_clone_safe(flashlight_templates.laspistol_p1_m1)
        flashlight_templates.autogun_p1_m2 = table_clone_safe(flashlight_templates.autogun_p1_m1)
        flashlight_templates.autogun_p1_m3 = table_clone_safe(flashlight_templates.autogun_p1_m1)
        -- flashlight_templates.autogun_p2_m1 = table_clone_safe(flashlight_templates.autogun_p1_m1)
        flashlight_templates.autogun_p2_m2 = table_clone_safe(flashlight_templates.autogun_p2_m1)
        flashlight_templates.autogun_p2_m3 = table_clone_safe(flashlight_templates.autogun_p2_m1)
        -- flashlight_templates.autogun_p3_m1 = table_clone_safe(flashlight_templates.autogun_p1_m1)
        flashlight_templates.autogun_p3_m2 = table_clone_safe(flashlight_templates.autogun_p3_m1)
        flashlight_templates.autogun_p3_m3 = table_clone_safe(flashlight_templates.autogun_p3_m1)
        flashlight_templates.shotgun_p1_m2 = table_clone_safe(flashlight_templates.shotgun_p1_m1)
        flashlight_templates.shotgun_p1_m3 = table_clone_safe(flashlight_templates.shotgun_p1_m1)
        flashlight_templates.shotgun_p4_m2 = table_clone_safe(flashlight_templates.shotgun_p4_m1)
        flashlight_templates.shotgun_p4_m3 = table_clone_safe(flashlight_templates.shotgun_p4_m1)
        flashlight_templates.bolter_p1_m2 = table_clone_safe(flashlight_templates.bolter_p1_m1)
        flashlight_templates.bolter_p1_m3 = table_clone_safe(flashlight_templates.bolter_p1_m1)
        flashlight_templates.lasgun_p1_m2 = table_clone_safe(flashlight_templates.lasgun_p1_m1)
        flashlight_templates.lasgun_p2_m2 = table_clone_safe(flashlight_templates.lasgun_p2_m1)
        flashlight_templates.lasgun_p2_m3 = table_clone_safe(flashlight_templates.lasgun_p2_m1)
        flashlight_templates.lasgun_p3_m2 = table_clone_safe(flashlight_templates.lasgun_p3_m1)
        flashlight_templates.lasgun_p3_m3 = table_clone_safe(flashlight_templates.lasgun_p3_m1)
		flashlight_templates.lasgun_p1_m3 = table_clone_safe(flashlight_templates.lasgun_p1_m1)
            flashlight_templates.bot_laspistol_killshot = table_clone_safe(flashlight_templates.laspistol_p1_m1)
            flashlight_templates.bot_zola_laspistol = table_clone_safe(flashlight_templates.laspistol_p1_m1)
            flashlight_templates.high_bot_lasgun_killshot = table_clone_safe(flashlight_templates.lasgun_p1_m1)
            flashlight_templates.bot_lasgun_killshot = table_clone_safe(flashlight_templates.lasgun_p1_m1)
            flashlight_templates.high_bot_autogun_killshot = table_clone_safe(flashlight_templates.autogun_p3_m1)
            flashlight_templates.bot_autogun_killshot = table_clone_safe(flashlight_templates.autogun_p3_m1)
    --#endregion
--#endregion

return {
    fixes = fixes,
    attachments = attachments,
    attachment_slots = attachment_slots,
    hide_attachment_slots_in_menu = hide_attachment_slots_in_menu,
    kitbashs = kitbashs,
    flashlight_templates = flashlight_templates,
    attachment_data_by_item_string = attachment_data_by_item_string,
    attachment_name_by_item_string = attachment_name_by_item_string,
    attachment_data_by_attachment_name = attachment_data_by_attachment_name,
}
