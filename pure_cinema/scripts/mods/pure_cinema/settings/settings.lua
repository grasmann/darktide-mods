local mod = get_mod("pure_cinema")

return {
    discharge_templates = mod:io_dofile("pure_cinema/scripts/mods/pure_cinema/settings/discharge_templates"),
    effect_templates = mod:io_dofile("pure_cinema/scripts/mods/pure_cinema/settings/effect_templates"),
    enemy_weapons = mod:io_dofile("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons"),
}