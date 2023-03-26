local mod = get_mod("scoreboard")
local DMF = get_mod("DMF")

local ScoreboardDefinitions = mod:io_dofile("scoreboard/scripts/mods/scoreboard/scoreboard_definitions")
local WalletSettings = mod:original_require("scripts/settings/wallet_settings")

local DEBUG = false

mod.registered_scoreboard_rows = {}
mod.scoreboard_rows = {
    -- Materials
    -- {
	-- 	name = "forge_material",
    --     text = "Materials Collected",
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	-- row_height = mod.big_row.height,
    --     -- font_size = mod.big_row.font,
	-- 	-- score_multiplier = true,
	-- 	score_summary = {
	-- 		"metal",
	-- 		"platinum",
	-- 	},
	-- 	-- empty = true,
	-- },
    -- {
	-- 	name = "small_metal",
    --     text = "small_metal",
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	visible = false,
	-- },
	-- {
	-- 	name = "large_metal",
    --     text = "large_metal",
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	visible = false,
	-- },
    -- {
	-- 	name = "metal",
    --     text = "metal",
	-- 	icon = WalletSettings.plasteel.icon_texture_big,
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	-- row_height = mod.big_row.height,
    --     -- font_size = mod.big_row.font,
	-- 	-- offset = {-30, -mod.big_row.height},
	-- 	summary = {
	-- 		"small_metal",
	-- 		"large_metal",
	-- 	},
    --     parent = "forge_material",
	-- },
    -- {
	-- 	name = "small_platinum",
    --     text = "small_platinum",
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	visible = false,
	-- },
	-- {
	-- 	name = "large_platinum",
    --     text = "large_platinum",
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	visible = false,
	-- },
    -- {
	-- 	name = "platinum",
    --     text = "platinum",
	-- 	icon = WalletSettings.diamantine.icon_texture_big,
	-- 	validation = ScoreboardDefinitions.validation_types.ASC,
	-- 	iteration = ScoreboardDefinitions.iteration_types.ADD,
	-- 	-- row_height = mod.big_row.height,
    --     -- font_size = mod.big_row.font,
	-- 	-- offset = {40, -mod.big_row.height},
	-- 	score_summary = {
	-- 		"small_platinum",
	-- 		"large_platinum",
	-- 	},
    --     parent = "forge_material",
	-- },
    

    {
		name = "coherency_efficiency",
        text = "Coherency Efficiency",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
        example = {80, 100},
        group = "defense",
        normalize = true,
        update = mod.update_coherency,

		-- row_height = mod.medium_row.height,
        -- font_size = mod.medium_row.font,
		-- indentation = 15 + mod.base_indentation,
		-- score_multiplier = true,
		-- score_row = true,
	},
    {
        name = "carrying",
        text = "Carried Scripture / Grimoire / Other",
        value = "/          /",
        validation = ScoreboardDefinitions.validation_types.ASC,
        iteration = ScoreboardDefinitions.iteration_types.ADD,
        example = {80, 100},
        group = "team",
        normalize = true,
        update = mod.update_coherency,
        -- row_height = mod.medium_row.height,
        -- font_size = mod.medium_row.font,
        -- indentation = 15 + mod.base_indentation,
        -- score_multiplier = true,
        score_summary = {
            "carrying_tomes",
            "carrying_grims",
            "carrying_other",
        },
        empty = true,
    },
    {
		name = "carrying_tomes",
        text = "Scripture",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		-- offset = {-40, -mod.medium_row.height, 3},
		-- indentation = 98 + mod.base_indentation,
		-- divider = 5,
		-- decimals = 1,
		-- score_addition = "s",
        parent = "carrying",
		is_time = true,
	},
	{
		name = "carrying_grims",
        text = "Grimoire",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		-- offset = {0, -mod.medium_row.height, 3},
		-- indentation = 118 + mod.base_indentation,
		-- divider = 5,
		-- decimals = 1,
		-- score_addition = "s",
        parent = "carrying",
		is_time = true,
	},
	{
		name = "carrying_other",
        text = "Other",
		validation = ScoreboardDefinitions.validation_types.ASC,
		iteration = ScoreboardDefinitions.iteration_types.ADD,
		-- row_height = mod.medium_row.height, font_size = mod.medium_row.font,
		-- offset = {40, -mod.medium_row.height, 3},
		-- indentation = 135 + mod.base_indentation,
		-- divider = 5,
		-- decimals = 1,
		-- score_addition = "s",
        parent = "carrying",
		is_time = true,
	},
}
mod.scoreboard_data = {}

mod.collect_scoreboard_rows = function(self)
    self.registered_scoreboard_rows = {{
        name = "header",
        text = "header",
    }}
    if DEBUG then mod:echo("Clearing registered rows") end

	for _, this_mod in pairs(DMF.mods) do
		if type(this_mod) == "table" and this_mod.scoreboard_rows then
			for _, template in pairs(this_mod.scoreboard_rows) do
				mod:register_scoreboard_row(this_mod, template)
			end
		end
	end
end

mod.register_scoreboard_row = function(self, mod, template)
	local index = #self.registered_scoreboard_rows + 1
    if DEBUG then mod:echo("Registering row '"..template.name.."'") end
	table.insert(self.registered_scoreboard_rows, index, {
        mod = mod,
		name = template.name,
		text = template.text,
		iteration = template.iteration,
		validation = template.validation,
        parent = template.parent,
		-- height = template.row_height,
		-- font_size = template.font_size,
		-- score_summary = template.score_summary,
		-- score_multiplier = template.score_multiplier,
		-- multiplier = template.multiplier,
		-- divider = template.divider,
		-- decimals = template.decimals,
		-- score_addition = template.score_addition,
		is_time = template.is_time,
        update = template.update,
		-- score_row = template.score_row,
		-- offset = template.offset,
		-- icon = template.icon,
		-- empty = template.empty,
		visible = template.visible,
		-- indentation = template.indentation,
		-- value = template.value,
		-- data = {},
	})
end

mod.update_scoreboard_rows = function(self, dt)
    for _, row in pairs(self.registered_scoreboard_rows) do
        if row.mod and row.update then
            row.update(row.mod, dt)
        end
    end
end