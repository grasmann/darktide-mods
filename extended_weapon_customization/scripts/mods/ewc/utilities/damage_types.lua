local mod = get_mod("extended_weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local GibbingSettings = mod:original_require("scripts/settings/gibbing/gibbing_settings")
local LineEffects = mod:original_require("scripts/settings/effects/line_effects")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################
-- #region Performance
    local table = table
    local table_size = table.size
    local script_unit = ScriptUnit
    local script_unit_extension = script_unit.extension
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local damage_type_setting = "damage_type"
local damage_type_active_setting = "damage_type_active"
local gibbing_types = GibbingSettings.gibbing_types
local gibbing_power = GibbingSettings.gibbing_power

mod.fx_overrides = {}
mod.enemy_unit_damage_type_override = {}
mod.damage_types = {
    default = {
        game_damage_type = "default",
        gibbing_type = gibbing_types.default,
        gibbing_power = gibbing_power.light,
    },
    metal_slashing_light = {
        game_damage_type = "metal_slashing_light",
        gibbing_type = gibbing_types.sawing,
        gibbing_power = gibbing_power.medium,
    },
    metal_slashing_medium = {
        game_damage_type = "metal_slashing_medium",
        gibbing_type = gibbing_types.sawing,
        gibbing_power = gibbing_power.heavy,
    },
    metal_slashing_heavy = {
        game_damage_type = "metal_slashing_heavy",
        gibbing_type = gibbing_types.sawing,
        gibbing_power = gibbing_power.infinite,
    },
    metal_crushing_light = {
        game_damage_type = "metal_crushing_light",
        gibbing_type = gibbing_types.crushing,
        gibbing_power = gibbing_power.medium,
    },
    metal_crushing_medium = {
        game_damage_type = "metal_crushing_medium",
        gibbing_type = gibbing_types.crushing,
        gibbing_power = gibbing_power.heavy,
    },
    metal_crushing_heavy = {
        game_damage_type = "metal_crushing_heavy",
        gibbing_type = gibbing_types.crushing,
        gibbing_power = gibbing_power.infinite,
    },
    laser = {
        game_damage_type = "laser",
        -- Gibbing settings
        gibbing_type = gibbing_types.laser,
        gibbing_power = gibbing_power.infinite,
        -- Line effect
        line_effect = LineEffects.lasbeam_pistol,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_lasgun_p3_m2_fire_auto",
        stop_ranged_shooting = "wwise/events/weapon/stop_lasgun_p3_m2_fire_auto",
        ranged_pre_loop_shot = "wwise/events/weapon/play_lasgun_p3_m3_fire_single",
        ranged_single_shot = "wwise/events/weapon/play_lasgun_p3_m3_fire_single",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/lasgun/lasgun_muzzle_elysian",
    },
    suppressed = {
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_weapon_silence",
        stop_ranged_shooting = "wwise/events/weapon/stop_weapon_silence",
        ranged_pre_loop_shot = "wwise/events/weapon/play_heavy_swing_hit",
        ranged_single_shot = "wwise/events/weapon/play_heavy_swing_hit",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary",
    },
    plasma = {
        game_damage_type = "plasma",
        -- Gibbing settings
        gibbing_type = gibbing_types.plasma,
        gibbing_power = gibbing_power.infinite,
        -- Line effect
        line_effect = LineEffects.plasma_beam,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_weapon_silence",
        stop_ranged_shooting = "wwise/events/weapon/stop_weapon_silence",
        ranged_pre_loop_shot = "wwise/events/weapon/play_weapon_plasmagun",
        ranged_single_shot = "wwise/events/weapon/play_weapon_plasmagun",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/plasma_gun/plasma_muzzle_ks",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/plasma_gun/plasma_muzzle_bfg",
    },
    boltshell = {
        game_damage_type = "boltshell",
        -- Gibbing settings
        gibbing_type = gibbing_types.boltshell,
        gibbing_power = gibbing_power.infinite,
        -- Line effect
        line_effect = LineEffects.boltshell,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_weapon_silence",
        stop_ranged_shooting = "wwise/events/weapon/stop_weapon_silence",
        ranged_pre_loop_shot = "wwise/events/weapon/play_weapon_bolter",
        ranged_single_shot = "wwise/events/weapon/play_weapon_bolter",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/bolter/bolter_muzzle_ignite",
        muzzle_flash_secondary = "content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/bolter/bolter_muzzle_secondary",
    },
    auto_bullet_infantry = {
        game_damage_type = "auto_bullet",
        -- Gibbing settings
        gibbing_type = gibbing_types.ballistic,
        gibbing_power = gibbing_power.always,
        -- Line effect
        line_effect = LineEffects.autogun_bullet,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_autogun_p1_m1_auto",
        stop_ranged_shooting = "wwise/events/weapon/stop_autogun_p1_m1_auto",
        ranged_pre_loop_shot = "wwise/events/weapon/play_autogun_p1_m1_first",
        ranged_single_shot = "wwise/events/weapon/play_autogun_p1_m1_first",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit",
    },
    auto_bullet_braced = {
        game_damage_type = "auto_bullet",
        -- Gibbing settings
        gibbing_type = gibbing_types.ballistic,
        gibbing_power = gibbing_power.always,
        -- Line effect
        line_effect = LineEffects.autogun_bullet,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_autogun_p2_m1_auto",
        stop_ranged_shooting = "wwise/events/weapon/stop_autogun_p2_m1_auto",
        ranged_pre_loop_shot = "wwise/events/weapon/play_autogun_p2_m1_first",
        ranged_single_shot = "wwise/events/weapon/play_autogun_p2_m1_first",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_02",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_crit",
    },
    auto_bullet_headhunter = {
        game_damage_type = "auto_bullet",
        -- Gibbing settings
        gibbing_type = gibbing_types.ballistic,
        gibbing_power = gibbing_power.always,
        -- Line effect
        line_effect = LineEffects.autogun_bullet,
        -- Sounds
        play_ranged_shooting = "wwise/events/weapon/play_autogun_p2_m1_auto",
        stop_ranged_shooting = "wwise/events/weapon/stop_autogun_p2_m1_auto",
        ranged_single_shot = "wwise/events/weapon/play_autogun_p3_m1_single",
        ranged_pre_loop_shot = "wwise/events/weapon/play_autogun_p3_m1_single",
        -- Muzzle flash
        muzzle_flash = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_03",
        muzzle_flash_crit = "content/fx/particles/weapons/rifles/autogun/autogun_muzzle_03_crit",
    },
}

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

mod.set_fx_override = function(self, gear_id, sound_alias, override)
    if sound_alias and override then
        self.fx_overrides[gear_id] = self.fx_overrides[gear_id] or {}
        self.fx_overrides[gear_id][sound_alias] = override
    end
end

mod.clear_fx_overrides = function(self, gear_id)
    if self.fx_overrides[gear_id] then
        self.fx_overrides[gear_id] = nil
    end
end

mod.clear_fx_override = function(self, gear_id, sound_alias)
	if sound_alias and self.fx_overrides[gear_id] then
		self.fx_overrides[gear_id][sound_alias] = nil
	end
	if self.fx_overrides[gear_id] and table_size(self.fx_overrides[gear_id]) == 0 then
		self.fx_overrides[gear_id] = nil
	end
end

mod.damage_type = function(self, gear_id, save_damage_type)
    if save_damage_type ~= nil then
        local damage_type_list = mod:get(damage_type_setting) or {}
        if save_damage_type ~= false then
            -- Save new value
            damage_type_list[gear_id] = save_damage_type
        else
            -- Delete value
            damage_type_list[gear_id] = nil
        end
        mod:set(damage_type_setting, damage_type_list)
    else
        -- Get damage type
        local damage_type_list = mod:get("damage_type")
        return damage_type_list and damage_type_list[gear_id]
    end
end
