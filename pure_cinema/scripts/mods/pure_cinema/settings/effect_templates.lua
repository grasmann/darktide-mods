local mod = get_mod("pure_cinema")

local effect_templates = {}

local function _create_effect_template_entry(path)
	local effect_template = mod:io_dofile(path)
	local effect_template_name = effect_template.name

	effect_templates[effect_template_name] = effect_template
end

_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/sniper")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/plasma")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/gunner")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/shotgun")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/chainaxe")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/laser_gunner")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/heavy_stubber")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/cultist_flamer")
_create_effect_template_entry("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates/renegade_flamer")

return settings("PureCinemaEffectTemplates", effect_templates)