local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "chaos_ogryn_executor",
    slot_melee_weapon = {
        {
            name = "content/items/weapons/minions/melee/chaos_ogryn_executor_2h_chainsword",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/chaos_ogryn_executor_2h_club",
            attachment = "content/items/weapons/player/melee/chainsword_2h_p1_m1",
            size = Vector3Box(2, 2, 2),
            position = Vector3Box(0, 0, .1),
        },
        {
            name = "content/items/weapons/minions/melee/chaos_ogryn_executor_2h_chainaxe",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/chaos_ogryn_executor_2h_club",
            attachment = "content/items/weapons/minions/melee/renegade_executor_weapon",
            size = Vector3Box(2, 2, 2),
            position = Vector3Box(0, 0, .1),
        },
    },
}
