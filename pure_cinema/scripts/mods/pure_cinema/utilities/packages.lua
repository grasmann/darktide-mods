local mod = get_mod("pure_cinema")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local pairs = pairs
    local Managers = Managers
-- #endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "pure_cinema"
local pt = mod:pt()
local _packages = {
    "content/fx/particles/weapons/rifles/ogryn_heavystubber/ogryn_heavystubber_muzzle",
    "content/fx/particles/enemies/renegade_plasma_trooper/renegade_plasma_flash",
    "content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_enemy_rifleman",
    "content/fx/particles/weapons/rifles/plasma_gun/plasma_muzzle_captain",
    "content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian",
    "content/fx/particles/weapons/rifles/shotgun/shotgun_rifle_muzzle",
    "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_3p",
    "content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle",
    "content/fx/particles/weapons/rifles/gunner/gunner_muzzle",
    "content/fx/particles/enemies/netgunner_net_projectile",

    "wwise/events/weapon/play_combat_weapon_heavy_stubber_auto_chaos",
    "wwise/events/weapon/stop_combat_weapon_heavy_stubber_auto_chaos",
    "wwise/events/weapon/play_weapon_autogun_renegade_auto_chaos",
    "wwise/events/weapon/stop_weapon_autogun_renegade_auto_chaos",
    "wwise/events/weapon/play_weapon_lasgun_smg_auto_minion",
    "wwise/events/weapon/stop_weapon_lasgun_smg_auto_minion",
    "wwise/events/weapon/play_minion_hellgun_fire",
    "wwise/events/weapon/stop_minion_hellgun_fire",

    "wwise/events/weapon/play_minion_special_plasmapistol_flash",
    "wwise/events/weapon/play_minion_plasmapistol_charge_02",
    "wwise/events/weapon/stop_minion_plasmapistol_charge_02",
    "wwise/events/weapon/play_bullet_hits_gen_armored_husk",
    "wwise/events/weapon/play_bullet_hits_gen_armored_death_husk",
    "wwise/events/weapon/play_enemy_netgunner_net_shot",
    "wwise/events/weapon/stop_enemy_netgunner_net_shot",
    "wwise/events/weapon/play_minion_plasmapistol",
    "wwise/events/weapon/play_weapon_shotgun_chaos",

    "wwise/events/weapon/play_combat_weapon_chainaxe_chaos",
    "wwise/events/weapon/stop_combat_weapon_chainaxe_chaos",
    "wwise/events/weapon/play_chainaxe_stuck_loop_husk",
    "wwise/events/weapon/stop_chainaxe_stuck_loop_husk",

    "content/characters/enemy/chaos_traitor_guard/third_person/animations/chaos_traitor_guard_captain",
    "content/weapons/enemy/ranged/chaos_traitor_guard_rusher_lasgun_01/chaos_traitor_guard_rusher_lasgun_01",
    
    "wwise/events/minions/play_plague_ogryn_footsteps_land",
    "wwise/events/minions/play_chaos_spawn_leap_land",
    "wwise/events/minions/play_chaos_hound_armoured_footsteps_land",
    "wwise/events/minions/play_enemy_character_foley_plague_ogryn_stomp_metal",

}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.load_packages = function(self, optional_resource_packages)

    if optional_resource_packages then

        for package_name, _ in pairs(optional_resource_packages) do
            local function callback(package_id)
                pt.loaded_packages[package_name] = package_id
            end
            Managers.package:load(package_name, REFERENCE, callback)
        end

    else

        for _, package_name in pairs(_packages) do
            local function callback(package_id)
                pt.loaded_packages[package_name] = package_id
            end
            Managers.package:load(package_name, REFERENCE, callback)
        end

    end

end

mod.release_packages = function(self)
    for package_name, package_id in pairs(pt.loaded_packages) do
        Managers.package:release(package_id, REFERENCE)
    end
end
