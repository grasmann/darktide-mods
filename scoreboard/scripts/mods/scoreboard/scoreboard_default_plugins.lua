local mod = get_mod("scoreboard")
mod.debug_ = false
mod.text = "scoreboard"

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################

local InteractionSettings = Mods.original_require("scripts/settings/interaction/interaction_settings")
local interaction_results = InteractionSettings.results
local DamageProfileTemplates = Mods.original_require("scripts/settings/damage/damage_profile_templates")

local ScoreboardDefinitions = Mods.file.exec_with_return("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")
local TextUtilities = Mods.original_require("scripts/utilities/ui/text")
local Breed = Mods.original_require("scripts/utilities/breed")
local WalletSettings = Mods.original_require("scripts/settings/wallet_settings")
-- local AnimationEvents = Mods.AnimationEvents
-- local Options = Mods.Options

mod.pickups = {
	loc_pickup_pocketable_medical_crate_01 = "med_crate_pocketable",
	loc_pickup_pocketable_ammo_crate_01 = "ammo_cache_pocketable",
	loc_pickup_side_mission_pocketable_01 = "grimoire_pocketable",
	loc_pickup_side_mission_pocketable_02 = "scripture_pocketable",
}
mod.pickups_text = {
	med_crate_pocketable = "loc_pickup_pocketable_medical_crate_01",
	ammo_cache_pocketable = "loc_pickup_pocketable_ammo_crate_01",
	grimoire_pocketable = "loc_pickup_side_mission_pocketable_01",
	scripture_pocketable = "loc_pickup_side_mission_pocketable_02",
}

mod.crates_equiped = {}

mod.carrying = {}

mod.forge_material = {
	loc_pickup_small_metal = "small_metal",
	loc_pickup_large_metal = "large_metal",
	loc_pickup_small_platinum = "small_platinum",
	loc_pickup_large_platinum = "large_platinum",
}
mod.forge_material_count = {
	small_metal = 10,
	large_metal = 25,
	small_platinum = 10,
	large_platinum = 25,
}

mod.ammunition = {
	loc_pickup_consumable_small_clip_01 = "small_clip",
	loc_pickup_consumable_large_clip_01 = "large_clip",
	loc_pickup_deployable_ammo_crate_01 = "crate",
}
mod.ammunition_percentage = {
	small_clip = 0.15,
	large_clip = 0.5,
}
mod.current_ammo = {}

mod.interaction_units = {}

mod.bosses = {
	"chaos_beast_of_nurgle",
	"chaos_daemonhost",
	"chaos_plague_ogryn",
	"chaos_plague_ogryn_sprayer",
	"renegade_captain",
}

mod.current_health = {}

mod.last_enemy_interaction = {}

mod.coherency_timer = 10

mod.micro_row = {height = 5, font = 5}
mod.small_row = {height = 14, font = 11}
mod.medium_row = {height = 16, font = 12}
mod.big_row = {height = 28, font = 22}
mod.base_indentation = 0

mod.scoreboard = {
	-- Divider
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 1, font_size = 1,
		empty = true,
	},
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 1, font_size = 1,
		empty = true,
	},
	-- Team score
	-- Materials
	{
		name = "forge_material", text = "Materials Collected",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		score_multiplier = true,
		score_summary = {
			"metal",
			"platinum",
		},
		empty = true,
	},
	{
		name = "metal", text = "",
		icon = WalletSettings.plasteel.icon_texture_big,
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		offset = {-30, -mod.big_row.height},
		score_summary = {
			"small_metal",
			"large_metal",
		},
	},
	{
		name = "small_metal", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false, empty = true,
	},
	{
		name = "large_metal", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false, empty = true,
	},
	{
		name = "platinum", text = "",
		icon = WalletSettings.diamantine.icon_texture_big,
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		offset = {40, -mod.big_row.height},
		score_summary = {
			"small_platinum",
			"large_platinum",
		},
	},
	{
		name = "small_platinum", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false, empty = true,
	},
	{
		name = "large_platinum", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false, empty = true,
	},
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.micro_row.height, font_size = mod.micro_row.font,
		empty = true,
	},
	-- Teamplay
	{
		name = "operated", text = "Machinery / Gadget Operated", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		score_multiplier = true,
		indentation = 15 + mod.base_indentation,
		score_summary = {
			"machinery_operated",
			"gadget_operated",
			-- "servo_skull_operated",
		},
		empty = true,
	},
	{
		name = "machinery_operated", text = "Machinery",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-20, -mod.medium_row.height, 3},
		indentation = 35 + mod.base_indentation,
		-- multiplier = 50,
	},
	{
		name = "gadget_operated", text = "Gadget",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {20, -mod.medium_row.height, 3},
		indentation = 62 + mod.base_indentation,
		multiplier = 100,
	},
	{
		name = "ammo", text = "Ammo Picked Up / Wasted", value = "/",
		validation = ScoreboardDefinitions.validation_types.DESC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height,
		font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
		score_summary = {
			"ammo_picked_up",
			"ammo_wasted",
		},
		empty = true,
	},
	{
		name = "ammo_picked_up", text = "Picked Up",
		validation = ScoreboardDefinitions.validation_types.DESC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-20, -mod.medium_row.height, 3},
		indentation = 73 + mod.base_indentation,
	},
	{
		name = "ammo_wasted", text = "Wasted",
		validation = ScoreboardDefinitions.validation_types.DESC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {20, -mod.medium_row.height, 3},
		indentation = 98 + mod.base_indentation,
		multiplier = 10,
	},
	{
		name = "health_ammo_placed", text = "Medipacks / Ammocaches deployed", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
		score_summary = {
			"health_placed",
			"ammo_placed",
		},
		empty = true,
	},
	{
		name = "health_placed", text = "Medipacks",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-20, -mod.medium_row.height, 3},
		indentation = 35 + mod.base_indentation,
		multiplier = 100,
	},
	{
		name = "ammo_placed", text = "Ammocaches",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {20, -mod.medium_row.height, 3},
		indentation = 63 + mod.base_indentation,
		multiplier = 100,
	},
	{
		name = "carrying", text = "Carried Scripture / Grimoire / Other", value = "/          /",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
		score_summary = {
			"carrying_tomes",
			"carrying_grims",
			"carrying_other",
		},
		empty = true,
	},
	{
		name = "carrying_tomes", text = "Scripture",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-40, -mod.medium_row.height, 3},
		indentation = 98 + mod.base_indentation,
		divider = 5,
		decimals = 1,
		score_addition = "s",
		is_time = true,
	},
	{
		name = "carrying_grims", text = "Grimoire",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {0, -mod.medium_row.height, 3},
		indentation = 118 + mod.base_indentation,
		divider = 5,
		decimals = 1,
		score_addition = "s",
		is_time = true,
	},
	{
		name = "carrying_other", text = "Other",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {40, -mod.medium_row.height, 3},
		indentation = 135 + mod.base_indentation,
		divider = 5,
		decimals = 1,
		score_addition = "s",
		is_time = true,
	},
	{
		name = "revived_rescued", text = "Revived / Rescued Operatives", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		score_multiplier = true,
		indentation = 15 + mod.base_indentation,
		score_summary = {
			"revived_operative",
			"rescued_operative",
			-- "servo_skull_operated",
		},
		empty = true,
	},
	{
		name = "revived_operative", text = "Revived",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-20, -mod.medium_row.height, 2},
		indentation = 35 + mod.base_indentation,
		multiplier = 100,
	},
	{
		name = "rescued_operative", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {20, -mod.medium_row.height, 2},
		indentation = 74 + mod.base_indentation,
		multiplier = 100,
	},
	-- Score
	{
		name = "team_score", text = "Teamwork Score",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		score_row = true,
		score_multiplier = true,
		score_summary = {
			"machinery_operated",
			"gadget_operated",
			"ammo_picked_up",
			"ammo_wasted",
			"health_placed",
			"ammo_placed",
			"carrying_tomes",
			"carrying_grims",
			"carrying_other",
		},
	},



	-- Divider
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.small_row.height, font_size = mod.small_row.font,
		empty = true,
	},



	-- Defensive score
	{
		name = "damage_taken", text = "Damage Taken",
		validation = ScoreboardDefinitions.validation_types.DESC,
		iteration = ScoreboardDefinitions.iteration_types.DIFF,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
	},
	{
		name = "heal_station_used", text = "Health Station Used",
		validation = ScoreboardDefinitions.validation_types.DESC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
		multiplier = 100,
	},
	{
		name = "enemies_staggerd", text = "Enemies Staggered",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
	},
	{
		name = "attacks_blocked", text = "Attacks blocked",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
	},
	{
		name = "coherency_efficiency", text = "Coherency Efficiency",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
		score_row = true,
	},
	-- Score
	{
		name = "defense_score", text = "Defense Score",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.DIFF,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		score_row = true,
		score_multiplier = true,
		score_summary = {
			"damage_taken",
			"heal_station_used",
			"enemies_staggerd",
			"attacks_blocked",
			"coherency_efficiency",
		},
	},



	-- Divider
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.small_row.height, font_size = mod.small_row.font,
		empty = true,
	},



	-- Damage dealt
	{
		name = "damage_dealt", text = "Actual / Overkill Damage Dealt", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
		score_summary = {
			"actual_damage_dealt",
			"overkill_damage_dealt",
		},
		empty = true,
	},
	{
		name = "actual_damage_dealt", text = "Actual",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-30, -mod.medium_row.height, 3},
		indentation = 45 + mod.base_indentation,
	},
	{
		name = "overkill_damage_dealt", text = "Overkill",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {30, -mod.medium_row.height, 3},
		indentation = 29 + mod.base_indentation,
	},
	{
		name = "boss_damage_dealt", text = "Boss Damage Dealt",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		score_multiplier = true,
	},
	-- Special hits
	{
		name = "special_hits", text = "Weakspot / Critical Hits Dealt", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
		score_summary = {
			"weakspot_hits",
			"critical_hits",
		},
		empty = true,
	},
	{
		name = "weakspot_hits", text = "Weakspot",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {-30, -mod.medium_row.height, 3},
		indentation = 45 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "critical_hits", text = "Critical",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		offset = {30, -mod.medium_row.height, 3},
		indentation = 48 + mod.base_indentation,
		-- score_multiplier = true,
	},
	-- Lesser enemies
	{
		name = "chaos_newly_infected", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "cultist_assault", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "cultist_melee", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_assault", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_melee", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_rifleman", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	-- Lesser enemies
	{
		name = "lesser_enemies", text = "Lesser Enemies Killed",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		indentation = 15 + mod.base_indentation,
		multiplier = 10,
		score_summary = {
			"chaos_newly_infected",
			"cultist_assault",
			"cultist_melee",
			"renegade_assault",
			"renegade_melee",
			"renegade_rifleman",
		},
	},
	-- Melee threats
	{
		name = "melee_ranged_threats", text = "Melee / Ranged Elites Killed", value = "/",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		-- multiplier = 1000,
		score_summary = {
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
		indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "melee_threats", text = "Melee",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		multiplier = 1000,
		offset = {-20, -mod.medium_row.height, 3},
		score_summary = {
			"cultist_berzerker",
			"renegade_berzerker",
			"renegade_executor",
			"chaos_ogryn_bulwark",
			"chaos_ogryn_executor",
		},
		indentation = 35 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "cultist_berzerker", text = "Dreg Rager",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_berzerker", text = "Scab Rager",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_executor", text = "Scab Mauler",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_ogryn_bulwark", text = "Bulwark",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_ogryn_executor", text = "Crusher",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	-- Gunners
	{
		name = "ranged_threats", text = "Ranged",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		multiplier = 1000,
		offset = {20, -mod.medium_row.height, 3},
		score_summary = {
			"cultist_gunner",
			"renegade_gunner",
			"cultist_shocktrooper",
			"renegade_shocktrooper",
			"chaos_ogryn_gunner",
		},
		indentation = 38 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "cultist_gunner", text = "Dreg Gunner",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_gunner", text = "Scab Gunner",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "cultist_shocktrooper", text = "Dreg Shotgunner",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_shocktrooper", text = "Scab Shotgunner",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_ogryn_gunner", text = "Reaper",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	-- Disablers
	{
		name = "disabler_threats", text = "Disablers Killed",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		multiplier = 1000,
		score_summary = {
			"chaos_hound",
			"cultist_mutant",
			"renegade_netgunner",
		},
		indentation = 20 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "chaos_hound", text = "Pox Hound",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		indentation = 25 + mod.base_indentation,
		visible = false,
	},
	{
		name = "cultist_mutant", text = "Mutant",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		indentation = 25 + mod.base_indentation,
		visible = false,
	},
	{
		name = "renegade_netgunner", text = "Scab Trapper",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		indentation = 25 + mod.base_indentation,
		visible = false,
	},
	-- Special
	{
		name = "special_threats", text = "Specials Killed",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		multiplier = 1000,
		score_summary = {
			"chaos_poxwalker_bomber",
			"renegade_grenadier",
			"cultist_grenadier",
			"renegade_sniper",
			"renegade_flamer",
			"cultist_flamer",
		},
		indentation = 25 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "chaos_poxwalker_bomber", text = "Pox Burster",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		indentation = 25 + mod.base_indentation,
		visible = false,
	},
	{
		name = "renegade_grenadier", text = "Scab Bomber",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "cultist_grenadier", text = "Dreg Bomber",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_sniper", text = "Scab Sniper",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		indentation = 25 + mod.base_indentation,
		visible = false,
	},
	{
		name = "renegade_flamer", text = "Scab Flamer",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "cultist_flamer", text = "Dreg Tox Flamer",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	-- Bosses
	{
		name = "boss_threats", text = "Bosses",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		multiplier = 1000,
		score_summary = {
			"chaos_beast_of_nurgle",
			"chaos_daemonhost",
			"chaos_plague_ogryn",
			"chaos_plague_ogryn_sprayer",
			"renegade_captain",
		},
		indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
	},
	{
		name = "chaos_beast_of_nurgle", text = "Beast of Nurgle",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_daemonhost", text = "Daemonhost",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_plague_ogryn", text = "Plague Ogryn",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "chaos_plague_ogryn_sprayer", text = "Plague Ogryn Sprayer",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	{
		name = "renegade_captain", text = "Captain",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 0, font_size = 0,
		visible = false,
	},
	-- Total
	{
		name = "offensive_score", text = "Offensive Score",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.big_row.height, font_size = mod.big_row.font,
		indentation = 15,
		score_row = true,
		score_multiplier = true,
		score_summary = {
			"chaos_newly_infected",
			"cultist_assault",
			"cultist_melee",
			"renegade_assault",
			"renegade_melee",
			"renegade_rifleman",
			"damage_dealt",
			"boss_damage_dealt",
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
			"chaos_hound",
			"cultist_mutant",
			"renegade_netgunner",
			"chaos_poxwalker_bomber",
			"renegade_grenadier",
			"cultist_grenadier",
			"renegade_sniper",
			"renegade_flamer",
			"cultist_flamer",
			"chaos_beast_of_nurgle",
			"chaos_daemonhost",
			"chaos_plague_ogryn",
			"chaos_plague_ogryn_sprayer",
			"renegade_captain",
		},
	},
	-- Divider
	{
		name = "empty_row", text = "",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = mod.micro_row.height, font_size = mod.micro_row.font,
		empty = true,
	},
	-- Total score
	{
		name = "score", text = "Total Score",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		row_height = 50, font_size = 30,
		score_row = true,
		score_multiplier = true,
		indentation = 35,
		score_summary = {
			"forge_material",

			"machinery_operated",
			"gadget_operated",
			"ammo_picked_up",
			"ammo_wasted",
			"health_placed",
			"ammo_placed",
			"carrying_tomes",
			"carrying_grims",
			"carrying_other",
			
			"damage_taken",
			"heal_station_used",
			"enemies_staggerd",
			"attacks_blocked",
			"coherency_efficiency",

			"chaos_newly_infected",
			"cultist_assault",
			"cultist_melee",
			"renegade_assault",
			"renegade_melee",
			"renegade_rifleman",
			"damage_dealt",
			"boss_damage_dealt",
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
			"chaos_hound",
			"cultist_mutant",
			"renegade_netgunner",
			"chaos_poxwalker_bomber",
			"renegade_grenadier",
			"cultist_grenadier",
			"renegade_sniper",
			"renegade_flamer",
			"cultist_flamer",
			"chaos_beast_of_nurgle",
			"chaos_daemonhost",
			"chaos_plague_ogryn",
			"chaos_plague_ogryn_sprayer",
			"renegade_captain",
		},
	},
}

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################

-- mod.on_all_mods_loaded = function()
	-- Scoreboard = Mods.Scoreboard
	-- AnimationEvents = Mods.AnimationEvents
	-- UserSettings = Mods.UserSettings
	-- Options = Mods.Options
-- end

mod.update = function(main_dt)
	mod:update_coherency(main_dt)
	mod:update_carrying(main_dt)
end

-- #####  █████╗ ███╗   ██╗██╗███╗   ███╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #####################
-- ##### ██╔══██╗████╗  ██║██║████╗ ████║    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #####################
-- ##### ███████║██╔██╗ ██║██║██╔████╔██║    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #####################
-- ##### ██╔══██║██║╚██╗██║██║██║╚██╔╝██║    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #####################
-- ##### ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #####################
-- ##### ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #####################

mod.animation_events = {
	enemy_stagger = function(event_name, event_index, unit, first_person, context)
		mod:enemy_stagger(event_name, event_index, unit, first_person, context)
	end,
	enemy_stagger_heavy = function(event_name, event_index, unit, first_person, context)
		mod:enemy_heavy_stagger(event_name, event_index, unit, first_person, context)
	end,
	equip_crate = function(event_name, event_index, unit, first_person, context)
        mod:equip_crate(event_name, event_index, unit, first_person, context)
    end,
	drop = function(event_name, event_index, unit, first_person, context)
        mod:drop_crate(event_name, event_index, unit, first_person, context)
    end,
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################

-- Player from player_unit
mod.player_from_unit = function(self, unit)
	if unit then
		local player_manager = Managers.player
		for _, player in pairs(player_manager:players()) do
			if player.player_unit == unit then
				return player
			end
		end
	end
	return nil
end

-- Extract file name from path
mod.file_name = function(self, url)   
    local str = url
	local temp = ""
	local result = ""

	-- Get file name + extension until first forward slash (/) and then break
	for i = str:len(), 1, -1 do
		if str:sub(i,i) ~= "/" then
		temp = temp..str:sub(i,i)
		else
		break
		end
	end

	-- Reverse order of full file name
	for j = temp:len(), 1, -1 do
		result = result..temp:sub(j,j)
	end

	return result
end

-- ##### ┌─┐┌─┐┬ ┬┌─┐┬─┐┌─┐┌┐┌┌─┐┬ ┬ ##################################################################################
-- ##### │  │ │├─┤├┤ ├┬┘├┤ ││││  └┬┘ ##################################################################################
-- ##### └─┘└─┘┴ ┴└─┘┴└─└─┘┘└┘└─┘ ┴  ##################################################################################

mod.update_coherency = function(self, dt)
	if Managers and Managers.player then
		if mod.coherency_timer then
			if mod.coherency_timer <= 0 then
				local player_manager = Managers.player
				local players = player_manager:players()
				for _, player in pairs(players) do
					local unit = player.player_unit
					if unit then
						local coherency_extension = ScriptUnit.has_extension(unit, "coherency_system")
						if coherency_extension then
							local num_units_in_coherency = coherency_extension:num_units_in_coherency()
							local account_id = player:account_id() or player:name()
							mod:update_stat("coherency_efficiency", account_id, num_units_in_coherency)
						end
					end
				end
				mod.coherency_timer = 10
			else
				mod.coherency_timer = mod.coherency_timer - dt
			end
		end
	end
end

-- ##### ┌─┐┌─┐┬─┐┬─┐┬ ┬┬┌┐┌┌─┐  ┌─┐┌┐  ┬┌─┐┌─┐┌┬┐┌─┐ #################################################################
-- ##### │  ├─┤├┬┘├┬┘└┬┘│││││ ┬  │ │├┴┐ │├┤ │   │ └─┐ #################################################################
-- ##### └─┘┴ ┴┴└─┴└─ ┴ ┴┘└┘└─┘  └─┘└─┘└┘└─┘└─┘ ┴ └─┘ #################################################################

mod.carrying_units = function(self)
	local num = 0
	for unit, pickups in pairs(self.carrying) do
		num = num + 1
	end
	return num
end

mod.update_carrying = function(self, dt)
	if Managers and Managers.player then
		local num_carrying = self:carrying_units()
		if num_carrying > 0 then
			for unit, pickups in pairs(self.carrying) do
				for _, name in pairs(pickups) do
					local carrying = nil
					if name == "scripture_pocketable" then
						carrying = "tomes"
					elseif name == "grimoire_pocketable" then
						carrying = "grims"
					else
						carrying = "other"
					end
					if carrying then
						local player = self:player_from_unit(unit)
						if player then
							local account_id = player:account_id() or player:name()
							mod:update_stat("carrying_"..carrying, account_id, dt)
						end
					end
				end
			end
		end
	end
end

-- ##### ┌─┐┌┐┌┌─┐┌┬┐┬ ┬  ┌─┐┌┬┐┌─┐┌─┐┌─┐┌─┐┬─┐ #######################################################################
-- ##### ├┤ │││├┤ │││└┬┘  └─┐ │ ├─┤│ ┬│ ┬├┤ ├┬┘ #######################################################################
-- ##### └─┘┘└┘└─┘┴ ┴ ┴   └─┘ ┴ ┴ ┴└─┘└─┘└─┘┴└─ #######################################################################

mod.enemy_stagger = function(self, event_name, event_index, unit, first_person, context)
	if mod.last_enemy_interaction[unit] then
		local player_unit = mod.last_enemy_interaction[unit]
		local player = mod:player_from_unit(player_unit)
		if player then
			local account_id = player:account_id() or player:name()
			-- Update scoreboard
			mod:update_stat("enemies_staggerd", account_id, 1)
		end
	end
end

mod.enemy_heavy_stagger = function(self, event_name, event_index, unit, first_person, context)
	if mod.last_enemy_interaction[unit] then
		local player_unit = mod.last_enemy_interaction[unit]
		local player = mod:player_from_unit(player_unit)
		if player then
			local account_id = player:account_id() or player:name()
			-- Update scoreboard
			mod:update_stat("enemies_staggerd", account_id, 2)
		end
	end
end

-- ##### ┌─┐┌─┐ ┬ ┬┬┌─┐  ┌─┐┌┐┌┌┬┐  ┌┬┐┬─┐┌─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐ #####################################################
-- ##### ├┤ │─┼┐│ ││├─┘  ├─┤│││ ││   ││├┬┘│ │├─┘  │  ├┬┘├─┤ │ ├┤  #####################################################
-- ##### └─┘└─┘└└─┘┴┴    ┴ ┴┘└┘─┴┘  ─┴┘┴└─└─┘┴    └─┘┴└─┴ ┴ ┴ └─┘ #####################################################

mod.equip_crate = function(self, event_name, event_index, unit, first_person, context)
	local player = mod:player_from_unit(unit)
	if player and not first_person then
		local account_id = player:account_id() or player:name()
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local inventory_component = unit_data_extension:read_component("inventory")
		local held_pocketable = inventory_component.slot_pocketable
		local name = mod:file_name(held_pocketable)
		-- local crate = mod.crates[name] or name
		mod.crates_equiped[unit] = name
	end
end

mod.drop_crate = function(self, event_name, event_index, unit, first_person, context)
	local player = mod:player_from_unit(unit)
	if player and not first_person then
		local account_id = player:account_id() or player:name()
		if mod.crates_equiped[unit] then
			local crate = mod.crates_equiped[unit]
			local text = Localize(mod.pickups_text[crate])
			if crate == "med_crate_pocketable" then
				-- Message
				if mod:get("message_health_placed") then
					local color = Color.light_blue(255, true)
					local message = " deployed "..TextUtilities.apply_color_to_text(text, color)
					-- local character_name = player:name()
					-- mod:echo(character_name..message)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("health_placed", account_id, 1)

			elseif crate == "ammo_cache_pocketable" then
				-- Message
				if mod:get("message_ammo_placed") then
					local color = Color.gray(255, true)
					local message = " deployed "..TextUtilities.apply_color_to_text(text, color)
					-- local character_name = player:name()
					-- mod:echo(character_name..message)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("ammo_placed", account_id, 1)
			end
			-- Reset carrying crate
			mod.carrying[unit] = mod.carrying[unit] or {}
			mod.carrying[unit][crate] = nil
			-- Reset equiped crate
			mod.crates_equiped[unit] = nil
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################

-- ##### ┌┐ ┌─┐┌─┐┬┌─┐  ┬┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ##############################################################
-- ##### ├┴┐├─┤└─┐││    ││││ │ ├┤ ├┬┘├─┤│   │ ││ ││││└─┐ ##############################################################
-- ##### └─┘┴ ┴└─┘┴└─┘  ┴┘└┘ ┴ └─┘┴└─┴ ┴└─┘ ┴ ┴└─┘┘└┘└─┘ ##############################################################

mod:hook(CLASS.InteracteeExtension, "stopped", function (func, self, result, ...)
	-- Check if interactiong successful
	if result == interaction_results.success then
		local type = self:interaction_type() or ""
		local unit = self._interactor_unit
		local weapon_extension = ScriptUnit.extension(unit, "weapon_system")
		local player = mod:player_from_unit(unit)
		local profile = player:profile()
		if player then
			local account_id = player:account_id() or player:name()
			-- Check type
			if type == "default" or type == "moveable_platform" or type == "scripted_scenario" or type == "luggable_socket" or (type == "door_control_panel" and self._override_contexts.door_control_panel.description ~= "loc_interactable_door") then
				-- Message
				if mod:get("message_default") then
					local color = Color.light_green(255, true)
					local message = " operated "..TextUtilities.apply_color_to_text("Machinery", color)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("machinery_operated", account_id, 1)

			elseif type == "pocketable" then
				local name = self._override_contexts.pocketable.description
				local pickup = mod.pickups[name] or name
				local option = ""
				local color = nil
				-- Set carrying
				mod.carrying[unit] = mod.carrying[unit] or {}
				local num_carrying = #mod.carrying[unit]
				mod.carrying[unit][pickup] = pickup
				-- Check pickup
				if pickup == "med_crate_pocketable" then
					option = "ammo_health_pickup"
					color = Color.light_blue(255, true)
				elseif pickup == "ammo_cache_pocketable" then
					option = "ammo_health_pickup"
					color = Color.gray(255, true)
				elseif pickup == "grimoire_pocketable" then
					option = "scripture_grimoire_pickup"
					color = Color.citadel_dawnstone(255, true)
				elseif pickup == "scripture_pocketable" then
					option = "scripture_grimoire_pickup"
					color = Color.citadel_dawnstone(255, true)
				end
				-- Message
				if mod:get(option) then
					local text = Localize(name)
					-- local character_name = player:name()
					local message = " picked up "..TextUtilities.apply_color_to_text(text, color)
					-- mod:echo(character_name..message)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("machinery_operated", account_id, 1)

			elseif type == "health_station" then
				-- Message
				if mod:get("message_health_station") then
					local color = Color.light_blue(255, true)
					local message = " used "..TextUtilities.apply_color_to_text("Health Station", color)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("heal_station_used", account_id, 1)

			elseif type == "servo_skull" or type == "servo_skull_activator" then
				mod.interaction_units[self._unit] = unit
				-- Message
				if mod:get("message_decoded") then
					local color = Color.light_green(255, true)
					local message = " operated "..TextUtilities.apply_color_to_text("Servoskull", color)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat("gadget_operated", account_id, 1)

			elseif type == "decoding" or type == "setup_decoding" then
				mod.interaction_units[self._unit] = unit

			elseif type == "forge_material" then
				local material = mod.forge_material[self._override_contexts.forge_material.description]
				local count = mod.forge_material_count[material]
				-- Message
				if mod:get("message_forge_material") then
					local color = Color.orange(255, true)
					local text = Localize(self._override_contexts.forge_material.description)
					local message = " picked up "..TextUtilities.apply_color_to_text(text.." ("..count..")", color)
					Managers.event:trigger("event_combat_feed_kill", unit, message)
				end
				-- Update scoreboard
				mod:update_stat(material, account_id, count)

			elseif type == "ammunition" then
				-- Get pick up data
				local ammo = mod.ammunition[self._override_contexts.ammunition.description]
				-- Get components
				local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
				local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
				local wieldable_component = unit_data_extension:read_component("slot_secondary")
				-- Get ammo numbers
				local ammo_clip = wieldable_component.current_ammunition_clip
				local max_ammo_clip = wieldable_component.max_ammunition_clip
				local max_ammo_reserve = wieldable_component.max_ammunition_reserve
				local current_ammo_reserve = mod.current_ammo[unit]
				local max_ammo = max_ammo_reserve + max_ammo_clip
				local current_ammo = current_ammo_reserve + ammo_clip
				local max_take = max_ammo - current_ammo
				if ammo == "small_clip" or ammo == "large_clip" then
					-- Calculate ammo
					local pecentage = mod.ammunition_percentage[ammo] or 0
					local amount = max_ammo_reserve * pecentage
					local wasted = math.max(amount - max_take, 0)
					local picked = math.min(amount, max_take)
					-- Message
					if mod:get("message_ammo") then
						local color = Color.gray(255, true)
						local message = " picked up "..TextUtilities.apply_color_to_text(string.format("%.0f", picked).." ammo ", color).." wasted "..TextUtilities.apply_color_to_text(string.format("%.0f", wasted), color)
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update Scoreboard
					mod:update_stat("ammo_picked_up", account_id, picked)
					mod:update_stat("ammo_wasted", account_id, wasted)
				elseif ammo == "crate" then
					-- Calculate ammo
					local picked = max_take
					-- Message
					if mod:get("message_ammo") then
						local color = Color.gray(255, true)
						local message = " picked up "..TextUtilities.apply_color_to_text(string.format("%.0f", picked).." ammo ", color)
						Managers.event:trigger("event_combat_feed_kill", unit, message)
					end
					-- Update Scoreboard
					mod:update_stat("ammo_picked_up", account_id, picked)
				end
			else
				mod.interaction_units[self._unit] = unit
				-- mod:log_to_file(type, self)
				if mod.debug_ then mod:echo("interact end "..type) end
			end
		end
	end
	func(self, result, ...)
end)

mod:hook(CLASS.InteracteeExtension, "started", function (func, self, interactor_unit, ...)

	mod.interaction_units[self._unit] = interactor_unit

	-- Ammunition
	local unit_data_extension = ScriptUnit.extension(interactor_unit, "unit_data_system")
	local wieldable_component = unit_data_extension:read_component("slot_secondary")
	mod.current_ammo[interactor_unit] = wieldable_component.current_ammunition_reserve

	func(self, interactor_unit, ...)
end)

-- ##### ┌┐ ┬  ┌─┐┌─┐┬┌─┌─┐┌┬┐  ┌─┐┌┬┐┌┬┐┌─┐┌─┐┬┌─┌─┐ #################################################################
-- ##### ├┴┐│  │ ││  ├┴┐├┤  ││  ├─┤ │  │ ├─┤│  ├┴┐└─┐ #################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴└─┘─┴┘  ┴ ┴ ┴  ┴ ┴ ┴└─┘┴ ┴└─┘ #################################################################

mod:hook(CLASS.WeaponSystem, "rpc_player_blocked_attack", function (func, self, channel_id, unit_id, attacking_unit_id, hit_world_position, block_broken, weapon_template_id, attack_type_id, ...)
	local player_unit = Managers.state.unit_spawner:unit(unit_id)
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		-- Update Scoreboard
		mod:update_stat("attacks_blocked", account_id, 1)
	end
	func(self, channel_id, unit_id, attacking_unit_id, hit_world_position, block_broken, weapon_template_id, attack_type_id, ...)
end)

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐  ┌─┐┌┐┌┌┬┐  ┬┌─┬┬  ┬  ┌─┐ #################################################################
-- #####  ││├─┤│││├─┤│ ┬├┤   ├─┤│││ ││  ├┴┐││  │  └─┐ #################################################################
-- ##### ─┴┘┴ ┴┴ ┴┴ ┴└─┘└─┘  ┴ ┴┘└┘─┴┘  ┴ ┴┴┴─┘┴─┘└─┘ #################################################################

mod:hook(CLASS.AttackReportManager, "add_attack_result", function (func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)
	local player = mod:player_from_unit(attacking_unit)
	if player then
		local account_id = player:account_id() or player:name()
		local unit_data_extension = ScriptUnit.has_extension(attacked_unit, "unit_data_system")
		local breed_or_nil = unit_data_extension and unit_data_extension:breed()
		local target_is_minion = breed_or_nil and Breed.is_minion(breed_or_nil)
		local actual_damage = damage
		local overkill_damage = 0

		-- ##### ┌─┐┬─┐┬┌┬┐┬┌─┐┌─┐┬    ┬ ┬┬┌┬┐┌─┐ #####################################################################
		-- ##### │  ├┬┘│ │ ││  ├─┤│    ├─┤│ │ └─┐ #####################################################################
		-- ##### └─┘┴└─┴ ┴ ┴└─┘┴ ┴┴─┘  ┴ ┴┴ ┴ └─┘ #####################################################################
		local player_unit_data_extension = ScriptUnit.has_extension(attacking_unit, "unit_data_system")
		local critical_strike_component = player_unit_data_extension:read_component("critical_strike")
		local is_critical_strike = critical_strike_component.is_active
		if is_critical_strike then
			mod:update_stat("critical_hits", account_id, 1)
		end

		-- ##### ┬ ┬┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌┬┐  ┬ ┬┬┌┬┐┌─┐ #################################################################
		-- ##### │││├┤ ├─┤├┴┐└─┐├─┘│ │ │   ├─┤│ │ └─┐ #################################################################
		-- ##### └┴┘└─┘┴ ┴┴ ┴└─┘┴  └─┘ ┴   ┴ ┴┴ ┴ └─┘ #################################################################
		if hit_weakspot then
			mod:update_stat("weakspot_hits", account_id, 1)
		end

		if target_is_minion then
			-- Set last interacting player_unit
			mod.last_enemy_interaction[attacked_unit] = attacking_unit

			-- Get health extension
			local current_health = mod.current_health[attacked_unit]
			local unit_health_extension = ScriptUnit.has_extension(attacked_unit, "health_system")
			local new_health = unit_health_extension and unit_health_extension:current_health()

			-- Attack result
			if attack_result == "damaged" then
				-- Current health
				if not current_health then
					current_health = new_health + damage
				end
				-- Actual damage
				actual_damage = math.min(damage, current_health)
				-- Update health
				mod.current_health[attacked_unit] = new_health

			elseif attack_result == "died" then
				-- Current health
				if not current_health then
					current_health = damage
				end
				-- Actual damage
				actual_damage = current_health
				-- Overkill damage
				overkill_damage = damage - actual_damage
				-- Update health
				mod.current_health[attacked_unit] = nil
				-- Update scoreboard
				-- mod:echo(breed_or_nil.name)
				mod:update_stat(breed_or_nil.name, account_id, 1)
			end
			
			-- Check for boss
			if table.array_contains(mod.bosses, breed_or_nil.name) then
				-- Enemy is boss
				mod:update_stat("boss_damage_dealt", account_id, actual_damage)
				mod:update_stat("overkill_damage_dealt", account_id, overkill_damage)
			else
				-- Enemy is normal
				mod:update_stat("actual_damage_dealt", account_id, actual_damage)
				mod:update_stat("overkill_damage_dealt", account_id, overkill_damage)
			end
		end
	end
	-- Original function
	return func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, ...)
end)

mod:hook(CLASS.HuskHealthExtension, "init", function (func, self, extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id, ...)
	-- Original function
	func(self, extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id, ...)
	-- Set health
	mod.current_health[unit] = self:max_health()
end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐┌─┐┬─┐┬  ┬┌─┐┌─┐┬┌─┬ ┬┬  ┬   #############################################################
-- ##### ├─┘│  ├─┤│  ├┤   └─┐├┤ ├┬┘└┐┌┘│ │└─┐├┴┐│ ││  │   #############################################################
-- ##### ┴  ┴─┘┴ ┴└─┘└─┘  └─┘└─┘┴└─ └┘ └─┘└─┘┴ ┴└─┘┴─┘┴─┘ #############################################################

mod:hook(CLASS.DecoderDeviceSystem, "rpc_decoder_device_place_unit", function (func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			local message = " operated "..TextUtilities.apply_color_to_text("Servoskull", color)
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	end
	func(self, channel_id, unit_id, ...)
end)

-- ##### ┌┬┐┌─┐┌─┐┌─┐┌┬┐┬┌┐┌┌─┐ #######################################################################################
-- #####  ││├┤ │  │ │ │││││││ ┬ #######################################################################################
-- ##### ─┴┘└─┘└─┘└─┘─┴┘┴┘└┘└─┘ #######################################################################################
	
mod:hook(CLASS.DecoderDeviceSystem, "rpc_decoder_device_finished", function (func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			local message = " used "..TextUtilities.apply_color_to_text("Scanner", color)
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	else
		mod:echo("Someone used Scanner")
	end
	func(self, channel_id, unit_id, ...)
end)

mod:hook(CLASS.MinigameSystem, "rpc_minigame_sync_completed", function (func, self, channel_id, unit_id, is_level_unit, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local account_id = player:account_id() or player:name()
		-- Message
		if mod:get("message_decoded") then
			local color = Color.light_green(255, true)
			local message = " used "..TextUtilities.apply_color_to_text("Scanner", color)
			Managers.event:trigger("event_combat_feed_kill", player_unit, message)
		end
		-- Update scoreboard
		mod:update_stat("gadget_operated", account_id, 1)
	else
		mod:echo("Someone minigame complete")
	end
	func(self, channel_id, unit_id, is_level_unit, ...)
end)

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┌─┐┌─┐  ┌┬┐┌─┐┬┌─┌─┐┌┐┌ ##########################################################################
-- #####  ││├─┤│││├─┤│ ┬├┤    │ ├─┤├┴┐├┤ │││ ##########################################################################
-- ##### ─┴┘┴ ┴┴ ┴┴ ┴└─┘└─┘   ┴ ┴ ┴┴ ┴└─┘┘└┘ ##########################################################################

mod:hook(CLASS.PlayerHuskHealthExtension, "fixed_update", function (func, self, unit, dt, t, ...)
	if unit then
		local player = mod:player_from_unit(unit)
		if player and self._damage and self._damage > 0 then
			local account_id = player:account_id() or player:name()
			mod:update_stat("damage_taken", account_id, self._damage)
		end
	end
	func(self, unit, dt, t, ...)
end)

-- ##### ┌─┐┬ ┬┌─┐┌┬┐┌─┐┌┬┐  ┬┌─┬┬  ┬    ┌─┐┌─┐┌─┐┌┬┐ #################################################################
-- ##### │  │ │└─┐ │ │ ││││  ├┴┐││  │    ├┤ ├┤ ├┤  ││ #################################################################
-- ##### └─┘└─┘└─┘ ┴ └─┘┴ ┴  ┴ ┴┴┴─┘┴─┘  └  └─┘└─┘─┴┘ #################################################################

mod:hook(CLASS.HudElementCombatFeed, "event_combat_feed_kill", function (func, self, attacking_unit, attacked_unit, ...)
	if type(attacked_unit) == "string" then
		local message = attacked_unit
		local color_name = self:_get_unit_presentation_name(attacking_unit) or "NONE"
		self:_add_combat_feed_message(color_name..message)
		return
	end
	return func(self, attacking_unit, attacked_unit, ...)
end)

-- ##### ████████╗███████╗███████╗████████╗ ###########################################################################
-- ##### ╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝ ###########################################################################
-- #####    ██║   █████╗  ███████╗   ██║    ###########################################################################
-- #####    ██║   ██╔══╝  ╚════██║   ██║    ###########################################################################
-- #####    ██║   ███████╗███████║   ██║    ###########################################################################
-- #####    ╚═╝   ╚══════╝╚══════╝   ╚═╝    ###########################################################################
mod:hook(CLASS.ScanningEventSystem, "rpc_scanning_device_finished", function (func, self, channel_id, unit_id, ...)
	local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local character_name = player:name()
		mod:echo(character_name.." scanned")
	else
		mod:echo("Someone scanned")
	end
	func(self, channel_id, unit_id, ...)
end)
-- ScanningDeviceExtension.finished_event = function (self)
mod:hook(CLASS.ScanningDeviceExtension, "finished_event", function (func, self, ...)
	-- local unit = Managers.state.unit_spawner:unit(unit_id, true)
	local player_unit = mod.interaction_units[self._unit]
	local player = mod:player_from_unit(player_unit)
	if player then
		local character_name = player:name()
		mod:echo(character_name.." scanned")
	else
		mod:echo("Someone scanned")
	end
	func(self, ...)
end)
