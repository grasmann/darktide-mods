local mod = get_mod("pure_cinema")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐ #####################################################################################
-- #####  │ ├┤ │││├─┘│  ├─┤ │ ├┤  #####################################################################################
-- #####  ┴ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘ #####################################################################################

return {
    breed_name = "renegade_executor",
    slot_melee_weapon = {
        {
            name = "content/items/weapons/minions/melee/renegade_executor_weapon_sword",
            slot_name = "slot_melee_weapon",
            fx_source_name = "blade",
            template = "content/items/weapons/minions/melee/renegade_executor_weapon",
            attachment = "content/items/weapons/player/melee/chainsword_2h_p1_m1",
            wielded_attach_node ="j_rightweaponattach",
            -- position = Vector3Box(0, 0, .22),
            -- state_machine = "content/characters/enemy/chaos_traitor_guard/third_person/animations/chaos_traitor_guard_captain",
            -- animation_events = {
            --     default = "to_ranged",
            --     attack = "to_2h_melee",
            -- },
        },
    },
}
