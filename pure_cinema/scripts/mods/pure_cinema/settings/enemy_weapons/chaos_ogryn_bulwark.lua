local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "chaos_ogryn_bulwark",
    slot_melee_weapon = {
        {
            name = "content/items/weapons/minions/melee/chaos_ogryn_melee_weapon_chainsword",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/chaos_ogryn_melee_weapon",
            attachment = "content/items/weapons/player/melee/chainsword_p1_m1",
            size = Vector3Box(2, 2, 2),
            position = Vector3Box(0, 0, -.05),
            rotation = Vector3Box(0, 0, 180),
        },
    },
    slot_shield = {
        {
            name = "content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01_assault",
            slot_name = "slot_melee_weapon",
            fx_source_name = "fx_node",
            template = "content/items/weapons/minions/shields/chaos_ogryn_bulwark_shield_01",
            attachment = "content/items/weapons/player/melee/assault_shield_p1_m1",
            size = Vector3Box(2, 2, 2),
            position = Vector3Box(0, 0, -.05),
        },
    },
}
