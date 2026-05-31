local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "cultist_berzerker",
    slot_melee_weapon = {
        {
            name = "content/items/weapons/minions/melee/cultist_berzerker_mainhand_weapon_01_chainsword",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/cultist_berzerker_mainhand_weapon_01",
            attachment = "content/items/weapons/player/melee/chainsword_p1_m1",
            wielded_attach_node ="j_rightweaponattach",
            effect_template = "chainaxe",
        },
    },
    slot_melee_weapon_offhand  = {
        {
            name = "content/items/weapons/minions/melee/cultist_berzerker_offhand_weapon_01_chainsword",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/cultist_berzerker_offhand_weapon_01",
            attachment = "content/items/weapons/player/melee/chainsword_p1_m1",
            wielded_attach_node ="j_leftweaponattach",
            effect_template = "chainaxe",
        },
    },
}
