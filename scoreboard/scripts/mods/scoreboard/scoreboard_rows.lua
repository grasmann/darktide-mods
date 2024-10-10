local mod = get_mod("scoreboard")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

local math = math
local type = type
local pairs = pairs
local get_mod = get_mod
local math_max = math.max
local table_insert = table.insert

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")
local WalletSettings = mod:original_require("scripts/settings/wallet_settings")
local DEBUG = false

mod.registered_scoreboard_rows = {}
mod.scoreboard_rows = {
	-- Materials
	{name = "forge_material",
		text = "row_forge_material",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"metal",
			"platinum",
		},
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "small_metal",
		text = "small_metal",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "large_metal",
		text = "large_metal",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "metal",
		text = "row_forge_material_metal",
		icon = WalletSettings.plasteel.icon_texture_small,
		icon_package = "packages/ui/views/store_item_detail_view/store_item_detail_view",
		icon_width = 20,
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"small_metal",
			"large_metal",
		},
		parent = "forge_material",
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "small_platinum",
		text = "small_platinum",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "large_platinum",
		text = "large_platinum",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "team",
		setting = "plugin_forge_material",
	},
	{name = "platinum",
		text = "row_forge_material_platinum",
		icon = WalletSettings.diamantine.icon_texture_small,
		icon_package = "packages/ui/views/store_item_detail_view/store_item_detail_view",
		icon_width = 20,
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"small_platinum",
			"large_platinum",
		},
		parent = "forge_material",
		group = "team",
		setting = "plugin_forge_material",
	},
	-- Damage taken / Heal station
	{name = "damage_taken_heal_station_used",
		text = "row_damage_taken_heal_station_used",
		validation = "DESC",
		iteration = "ADD",
		group = "defense",
		setting = "plugin_damage_taken_heal_station_used",
	},
	{name = "damage_taken",
		text = "row_damage_taken",
		validation = "DESC",
		iteration = "DIFF",
		group = "defense",
		parent = "damage_taken_heal_station_used",
		setting = "plugin_damage_taken_heal_station_used",
	},
	{name = "heal_station_used",
		text = "row_heal_station_used",
		validation = "DESC",
		iteration = "ADD",
		group = "defense",
		parent = "damage_taken_heal_station_used",
		setting = "plugin_damage_taken_heal_station_used",
	},
	-- Enemies staggered
	{name = "enemies_staggerd",
		text = "row_enemies_staggerd",
		validation = "ASC",
		iteration = "ADD",
		group = "defense",
		setting = "plugin_enemies_staggerd",
	},
	{name = "attacks_blocked",
		text = "row_attacks_blocked",
		validation = "ASC",
		iteration = "ADD",
		group = "defense",
		setting = "plugin_attacks_blocked",
	},
	-- Coherency
	{name = "coherency_efficiency",
		text = "row_coherency_efficiency",
		validation = "ASC",
		iteration = "ADD",
		update = mod.update_coherency,
		group = "defense",
		setting = "plugin_coherency_efficiency",
		normalize = true,
	},
	-- Carrying
	{name = "carrying",
		text = "row_carrying",
		validation = "ASC",
		iteration = "ADD",
		update = mod.update_coherency,
		summary = {
			"carrying_tomes",
			"carrying_grims",
			"carrying_other",
		},
		group = "team",
		setting = "plugin_carrying",
	},
	{name = "carrying_tomes",
		text = "row_carrying_scripture",
		validation = "ASC",
		iteration = "ADD",
		parent = "carrying",
		is_time = true,
		group = "team",
		setting = "plugin_carrying",
	},
	{name = "carrying_grims",
		text = "row_carrying_grimoire",
		validation = "ASC",
		iteration = "ADD",
		parent = "carrying",
		is_time = true,
		group = "team",
		setting = "plugin_carrying",
	},
	{name = "carrying_other",
		text = "row_carrying_other",
		validation = "ASC",
		iteration = "ADD",
		parent = "carrying",
		is_time = true,
		group = "team",
		setting = "plugin_carrying",
	},
	-- Operated
	{name = "operated",
		text = "row_operated",
		validation = "ASC",
		iteration = "ADD",
		group = "team",
		summary = {
			"machinery_operated",
			"gadget_operated",
		},
		setting = "plugin_machinery_gadget_operated",
	},
	{name = "machinery_operated",
		text = "row_machinery_operated",
		validation = "ASC",
		iteration = "ADD",
		group = "team",
		parent = "operated",
		setting = "plugin_machinery_gadget_operated",
	},
	{name = "gadget_operated",
		text = "row_gadget_operated",
		validation = "ASC",
		iteration = "ADD",
		group = "team",
		parent = "operated",
		setting = "plugin_machinery_gadget_operated",
	},
	-- Ammo
	{name = "ammo",
		text = "row_ammo",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		summary = {
			"ammo_picked_up",
			"ammo_wasted",
		},
		setting = "plugin_ammo = 1",
	},
	{name = "ammo_picked_up",
		text = "row_ammo_picked_up",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		parent = "ammo",
		setting = "plugin_ammo = 1",
	},
	{name = "ammo_wasted",
		text = "row_ammo_wasted",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		parent = "ammo",
		setting = "plugin_ammo = 1",
	},
	{name = "ammo_clip_crate_picked_up",
		text = "row_ammo_clip_crate_picked_up",
		validation = "DESC",
		iteration = "ADD",
		summary = {
			"ammo_small_picked_up",
			"ammo_large_picked_up",
			"ammo_crate_picked_up",
		},
		group = "team",
		setting = "plugin_ammo = 2",
	},
	{name = "ammo_small_picked_up",
		text = "row_ammo_small_picked_up",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		parent = "ammo_clip_crate_picked_up",
		setting = "plugin_ammo = 2",
	},
	{name = "ammo_large_picked_up",
		text = "row_ammo_large_picked_up",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		parent = "ammo_clip_crate_picked_up",
		setting = "plugin_ammo = 2",
	},
	{name = "ammo_crate_picked_up",
		text = "row_ammo_crate_picked_up",
		validation = "DESC",
		iteration = "ADD",
		group = "team",
		parent = "ammo_clip_crate_picked_up",
		setting = "plugin_ammo = 2",
	},
	-- Deploy
	{name = "health_ammo_placed",
	    text = "row_health_ammo_placed",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"health_placed",
			"ammo_placed",
		},
	    group = "team",
		setting = "plugin_health_ammo_placed",
	},
	{name = "health_placed",
	    text = "row_health_placed",
		validation = "ASC",
		iteration = "ADD",
	    group = "team",
	    parent = "health_ammo_placed",
		setting = "plugin_health_ammo_placed",
	},
	{name = "ammo_placed",
	    text = "row_ammo_placed",
		validation = "ASC",
		iteration = "ADD",
	    group = "team",
	    parent = "health_ammo_placed",
		setting = "plugin_health_ammo_placed",
	},
	{name = "revived_rescued",
		text = "row_revived_rescued",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"revived_operative",
			"rescued_operative",
		},
		group = "team",
		setting = "plugin_revived_rescued",
	},
	{name = "revived_operative",
		text = "row_revived_operative",
		validation = "ASC",
		iteration = "ADD",
		group = "team",
		parent = "revived_rescued",
		setting = "plugin_revived_rescued",
	},
	{name = "rescued_operative",
		text = "row_rescued_operative",
		validation = "ASC",
		iteration = "ADD",
		group = "team",
		parent = "revived_rescued",
		setting = "plugin_revived_rescued",
	},
	-- Damage dealt
	{name = "damage_dealt",
		text = "row_damage_dealt",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"actual_damage_dealt",
			"overkill_damage_dealt",
		},
		group = "offense",
		setting = "plugin_damage_dealt < 3",
	},
	{name = "actual_damage_dealt",
		text = "row_actual_damage_dealt",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		parent = "damage_dealt",
		setting = "plugin_damage_dealt < 3",
	},
	{name = "overkill_damage_dealt",
		text = "row_overkill_damage_dealt",
		validation = "DESC",
		iteration = "ADD",
		group = "offense",
		parent = "damage_dealt",
		setting = "plugin_damage_dealt < 2",
	},
	-- Boss damage
	{name = "boss_damage_dealt",
		text = "row_boss_damage_dealt",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_boss_damage_dealt",
	},
	-- Special hits
	{name = "special_hits",
		text = "row_special_hits",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"weakspot_hits",
			"critical_hits",
		},
		group = "offense",
		setting = "plugin_special_hits",
	},
	{name = "weakspot_hits",
		text = "row_weakspot_hits",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		parent = "special_hits",
		setting = "plugin_special_hits",
	},
	{name = "critical_hits",
		text = "row_critical_hits",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		parent = "special_hits",
		setting = "plugin_special_hits",
	},
	-- Lesser enemies
	{name = "lesser_enemies",
		text = "row_lesser_enemies",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"chaos_newly_infected",
			"chaos_poxwalker",
			"cultist_assault",
			"cultist_melee",
			"renegade_assault",
			"renegade_melee",
			"renegade_rifleman",
		},
		group = "offense",
		setting = "plugin_lesser_enemies",
	},
	{name = "chaos_newly_infected",
		text = "chaos_newly_infected",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "chaos_poxwalker",
		text = "chaos_poxwalker",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "cultist_assault",
		text = "cultist_assault",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "cultist_melee",
		text = "cultist_melee",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "renegade_assault",
		text = "renegade_assault",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "renegade_melee",
		text = "renegade_melee",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	{name = "renegade_rifleman",
		text = "renegade_rifleman",
		validation = "ASC",
		iteration = "ADD",
		group = "offense",
		setting = "plugin_lesser_enemies",
		visible = false,
	},
	-- Melee threats
	{name = "melee_ranged_threats",
		text = "row_melee_ranged_threats",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"cultist_berzerker",
			"renegade_berzerker",
			"renegade_executor",
			"chaos_ogryn_bulwark",
			"chaos_ogryn_executor",
			"cultist_gunner",
			"renegade_gunner",
			"cultist_shocktrooper",
			"renegade_shocktrooper",
			"chaos_ogryn_gunner",
		},
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	-- Melee Threats
	{name = "melee_threats",
		text = "row_melee_threats",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"cultist_berzerker",
			"renegade_berzerker",
			"renegade_executor",
			"chaos_ogryn_bulwark",
			"chaos_ogryn_executor",
		},
		group = "offense",
		parent = "melee_ranged_threats",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "cultist_berzerker",
		text = "Dreg Rager",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "renegade_berzerker",
		text = "Scab Rager",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "renegade_executor",
		text = "Scab Mauler",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "chaos_ogryn_bulwark",
		text = "Bulwark",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "chaos_ogryn_executor",
		text = "Crusher",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	-- Ranged Threats
	{name = "ranged_threats",
		text = "row_ranged_threats",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"cultist_gunner",
			"renegade_gunner",
			"cultist_shocktrooper",
			"renegade_shocktrooper",
			"chaos_ogryn_gunner",
		},
		group = "offense",
		parent = "melee_ranged_threats",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "cultist_gunner",
		text = "Dreg Gunner",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "renegade_gunner",
		text = "Scab Gunner",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "cultist_shocktrooper",
		text = "Dreg Shotgunner",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "renegade_shocktrooper",
		text = "Scab Shotgunner",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	{name = "chaos_ogryn_gunner",
		text = "Reaper",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_melee_ranged_threats",
	},
	-- Disablers
	{name = "disabler_threats",
		text = "row_disabler_threats",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"chaos_hound",
			"cultist_mutant",
			"renegade_netgunner",
		},
		group = "offense",
		setting = "plugin_disabler_threats",
	},
	{name = "chaos_hound",
		text = "Pox Hound",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_disabler_threats",
	},
	{name = "cultist_mutant",
		text = "Mutant",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_disabler_threats",
	},
	{name = "renegade_netgunner",
		text = "Scab Trapper",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_disabler_threats",
	},
	-- Special
	{name = "special_threats",
		text = "row_special_threats",
		validation = "ASC",
		iteration = "ADD",
		summary = {
			"chaos_poxwalker_bomber",
			"renegade_grenadier",
			"cultist_grenadier",
			"renegade_sniper",
			"renegade_flamer",
			"cultist_flamer",
		},
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "chaos_poxwalker_bomber",
		text = "Pox Burster",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "renegade_grenadier",
		text = "Scab Bomber",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "cultist_grenadier",
		text = "Dreg Bomber",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "renegade_sniper",
		text = "Scab Sniper",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "renegade_flamer",
		text = "Scab Flamer",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	{name = "cultist_flamer",
		text = "Dreg Tox Flamer",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_special_threats",
	},
	-- Bosses
	{name = "boss_threats",
		text = "row_boss_threats",
		validation = "ASC",
		iteration = "ADD",
		score_summary = {
			"chaos_beast_of_nurgle",
			"chaos_daemonhost",
			"chaos_plague_ogryn",
			"chaos_plague_ogryn_sprayer",
			"renegade_captain",
			"chaos_spawn",
			"renegade_twin_captain",
			"renegade_twin_captain_two",
		},
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "chaos_beast_of_nurgle",
		text = "Beast of Nurgle",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "chaos_daemonhost",
		text = "Daemonhost",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "chaos_plague_ogryn",
		text = "Plague Ogryn",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "chaos_plague_ogryn_sprayer",
		text = "Plague Ogryn Sprayer",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "renegade_captain",
		text = "Captain",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "chaos_spawn",
		text = "Chaos Spawn",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "renegade_twin_captain",
		text = "Rodin Karnak",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	{name = "renegade_twin_captain_two",
		text = "Rinda Karnak",
		validation = "ASC",
		iteration = "ADD",
		visible = false,
		group = "offense",
		setting = "plugin_boss_threats",
	},
	-- -- Score
	-- {name = "score",
	-- 	text = "row_score",
	-- 	group = "bottom",
	-- 	big = true,
	-- }
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
-- ##### ┬┌┐┌┬┌┬┐┬┌─┐┬  ┬┌─┐┌─┐ #######################################################################################
-- ##### │││││ │ │├─┤│  │┌─┘├┤  #######################################################################################
-- ##### ┴┘└┘┴ ┴ ┴┴ ┴┴─┘┴└─┘└─┘ #######################################################################################

mod.collect_scoreboard_rows = function(self, loaded_rows)
	if not loaded_rows then
		self.registered_scoreboard_rows = {}
		local DMF = get_mod("DMF")
		-- Scoreboards own rows
		for _, template in pairs(mod.scoreboard_rows) do
			local entry = self:register_scoreboard_row(mod, template)
			local index = #self.registered_scoreboard_rows + 1
			table_insert(self.registered_scoreboard_rows, index, entry)
		end
		-- Add rows from other mods
		for _, this_mod in pairs(DMF.mods) do
			if type(this_mod) == "table" and this_mod.scoreboard_rows and this_mod.name ~= "scoreboard" then
				for _, template in pairs(this_mod.scoreboard_rows) do
					local entry = self:register_scoreboard_row(this_mod, template)
					local index = #self.registered_scoreboard_rows + 1
					table_insert(self.registered_scoreboard_rows, index, entry)
				end
			end
		end
	else
		local entries = {}
		for _, template in pairs(loaded_rows) do
			local entry = self:register_scoreboard_row(self, template)
			entries[#entries+1] = entry
		end
		return entries
	end
end

mod.register_scoreboard_row = function(self, this_mod, template)
	if DEBUG then mod:echo("Registering row '"..template.name.."'") end

	local iteration_type = template.iteration
	local iteration = ScoreboardDefinitions.iteration_types.ADD
	if type(iteration_type) == "string" then
		iteration = ScoreboardDefinitions.iteration_types[iteration_type]
	end

	local validation_type = template.validation
	local validation = ScoreboardDefinitions.validation_types.ASC
	if type(validation_type) == "string" then
		validation = ScoreboardDefinitions.validation_types[validation_type]
	end

	return {
		mod = this_mod,
		name = template.name,
		text = template.text,
		iteration = iteration,
		iteration_type = iteration_type,
		validation = validation,
		validation_type = validation_type,
		parent = template.parent,
		group = template.group,
		summary = template.summary,
		setting = template.setting,
		is_time = template.is_time,
		is_text = template.is_text,
		update = template.update,
		visible = template.visible,
		normalize = template.normalize,
		big = template.big,
		icon = template.icon,
		icon_package = template.icon_package,
		icon_width = template.icon_width,
		data = template.data,
	}
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

mod.update_scoreboard_rows = function(self, dt)
	for _, row in pairs(self.registered_scoreboard_rows) do
		if row.mod and row.update then
			row.update(row.mod, dt)
		end
	end
end

mod.update_row_value = function(self, row_name, account_id, value)
	if self:is_numeric(value) then
		-- Normalize value
		local value = value and math_max(0, value) or 0
		-- Get row
		local row = self:get_scoreboard_row(row_name)
		if row then
			row.data = row.data or {}
			local character_data = row.data[account_id]
			-- Iteration
			local iteration = row.iteration
			local old_value = character_data and character_data.value or 0
			local new_value, add_score = iteration.value(value, old_value)
			-- New score
			local old_score = character_data and character_data.score or 0
			local new_score = old_score + add_score
			-- Update row
			local validation = row.validation
			-- local char_data = row.data[account_id] or {}
			row.data[account_id] = row.data[account_id] or {}
			row.data[account_id].value = value
			row.data[account_id].score = new_score
			row.data[account_id].text = nil
			-- row.data[account_id] = {
			-- 	value = value,
			-- 	score = new_score,
			-- }
		end
	else
		local row = self:get_scoreboard_row(row_name)
		-- mod:echo("search row "..row_name)
		if row then
			row.data = row.data or {}
			row.data[account_id] = row.data[account_id] or {}
			-- mod:echo("text = "..value)
			row.data[account_id].text = value
			row.data[account_id].value = 0
			row.data[account_id].score = 0
		else
			-- mod:echo("not found")
		end
	end
end

-- ##### ┬ ┬┌─┐┬  ┌─┐ #################################################################################################
-- ##### ├─┤├┤ │  ├─┘ #################################################################################################
-- ##### ┴ ┴└─┘┴─┘┴   #################################################################################################

mod.get_scoreboard_row = function(self, row_name)
	-- Iterate rows
	for _, row in pairs(self.registered_scoreboard_rows) do
		-- Compare name
		if row.name == row_name then
			return row
		end
	end
	return nil
end
