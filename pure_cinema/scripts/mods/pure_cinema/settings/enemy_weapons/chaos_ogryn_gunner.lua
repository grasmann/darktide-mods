local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "chaos_ogryn_gunner",
    slot_ranged_weapon = {
        {
            name = "content/items/weapons/minions/ranged/chaos_ogryn_heavy_stubber_custom",
            slot_name = "slot_ranged_weapon",
            fx_source_name = "muzzle",
            template = "content/items/weapons/minions/ranged/chaos_ogryn_heavy_stubber",
            attachment = "content/items/weapons/minions/ranged/chaos_cultist_heavy_stubber_02",
            size = Vector3Box(2, 2, 2),
            -- position = Vector3Box(0, .05, .05),
        },
    },
}
