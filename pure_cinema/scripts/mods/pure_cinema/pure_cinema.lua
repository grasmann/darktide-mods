local mod = get_mod("pure_cinema")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local managers = Managers
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "pure_cinema"
local base_path = "pure_cinema/scripts/mods/pure_cinema/"

mod:persistent_table(REFERENCE, {
    visual_loadout_extensions = {},
    loaded_packages = {},
})

mod.settings = mod:io_dofile("pure_cinema/scripts/mods/pure_cinema/settings/settings")

mod.pt = function(self)
    return self:persistent_table(REFERENCE)
end

local pt = mod:pt()

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod._update = function(self, dt)
    self:safety_update_discharge_sounds()
end

mod._on_setting_changed = function(self, setting_id)
    -- Trigger settings changed event
    managers.event:trigger("pure_cinema_settings_changed")
end

mod._on_all_mods_loaded = function(self)
    -- Load packages
    self:load_packages()
    -- Inject items
    if pt.master_items_loaded then
        self:inject_master_items()
    end
end

mod._on_unload = function(self, exit_game)
    if exit_game then
        -- Release packages
        self:release_packages()
    end
end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

mod.on_all_mods_loaded =    function() mod:_on_all_mods_loaded() end
mod.on_setting_changed =    function(setting_id) mod:_on_setting_changed(setting_id) end
mod.update =                function(dt) mod:_update(dt) end

-- ##### ┬ ┬┌┬┐┬┬  ┬┌┬┐┬┌─┐┌─┐ ########################################################################################
-- ##### │ │ │ ││  │ │ │├┤ └─┐ ########################################################################################
-- ##### └─┘ ┴ ┴┴─┘┴ ┴ ┴└─┘└─┘ ########################################################################################

local utility_path = base_path.."utilities/"
mod:io_dofile(utility_path.."master_items")
mod:io_dofile(utility_path.."packages")
mod:io_dofile(utility_path.."debug")
mod:io_dofile(utility_path.."data")
mod:io_dofile(utility_path.."game")

-- ##### ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐ ########################################################################################
-- ##### ├─┘├─┤ │ │  ├─┤├┤ └─┐ ########################################################################################
-- ##### ┴  ┴ ┴ ┴ └─┘┴ ┴└─┘└─┘ ########################################################################################

local patches_path = base_path.."patches/"
mod:io_dofile(patches_path.."minion_visual_loadout_extension")
mod:io_dofile(patches_path.."visual_loadout_customization")
mod:io_dofile(patches_path.."minion_perception")
mod:io_dofile(patches_path.."minion_ragdoll")

-- ##### ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌┌─┐ ################################################################################
-- ##### ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││└─┐ ################################################################################
-- ##### └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘└─┘ ################################################################################

local extension_path = base_path.."extensions/"
mod:io_dofile(extension_path.."discharge_extension")
mod:io_dofile(extension_path.."helmet_extension")
mod:io_dofile(extension_path.."common")
