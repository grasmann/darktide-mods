local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "cultist_gunner",
    slot_ranged_weapon = {
        {
            name = "content/items/weapons/minions/ranged/chaos_cultist_heavy_stubber_02_custom",
            slot_name = "slot_ranged_weapon",
            fx_source_name = "muzzle",
            template = "content/items/weapons/minions/ranged/chaos_cultist_heavy_stubber_02",
            attachment = "content/items/weapons/minions/ranged/chaos_ogryn_heavy_stubber",
            size = Vector3Box(.5, .5, .5),
            position = Vector3Box(0, .05, .05),
        },
    },
}
