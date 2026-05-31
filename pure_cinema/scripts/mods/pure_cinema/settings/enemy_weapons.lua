local mod = get_mod("pure_cinema")

local enemy_weapons = {}

local function _create_enemy_weapon_entry(path)
	local breed_template = mod:io_dofile(path)

    local breed_name = breed_template.breed_name
    enemy_weapons[breed_name] = enemy_weapons[breed_name] or {}
    local breed_weapons = enemy_weapons[breed_name]

    for slot_name, slot_templates in pairs(breed_template) do

        if type(slot_templates) == "table" then

            breed_weapons[slot_name] = breed_weapons[slot_name] or {}
            local slot_weapons = breed_weapons[slot_name]

            for _, weapon_template in pairs(slot_templates) do

                slot_weapons[#slot_weapons + 1] = weapon_template

            end

        end

    end

end

_create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/cultist_gunner")
_create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/cultist_berzerker")
_create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/renegade_executor")
-- _create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/chaos_ogryn_gunner")
_create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/chaos_ogryn_bulwark")
_create_enemy_weapon_entry("pure_cinema/scripts/mods/pure_cinema/settings/enemy_weapons/chaos_ogryn_executor")

return settings("PureCinemaEnemyWeapons", enemy_weapons)