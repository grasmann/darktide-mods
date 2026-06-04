local mod = get_mod("servo_friend_plugin_hat_cables")
if not mod then
    return
end

local Localize = Localize

mod.servo_friend_appearances = {
    {
        name = "psyker_cable_tech_eye_01__eye_tech_01_slim_implant",
        text = Localize("loc_psyker_cable_tech_eye_01_var_01"),
        base_appearance = "dominant",

        -- offsets: x = left/right, y = forwards, z = up/down
        decorations = {
            {
                unit =
                "content/characters/player/human/attachments_gear/headgear/psyker_cable_tech_eye_01/psyker_cable_tech_eye_01",
                offset = { 0, -0.01, -1.71 },
                rotation_z = 0,
            },
            {
                unit =
                "content/characters/player/human/attachments_gear/headgear/eye_tech_01/eye_tech_01_slim_implant",
                offset = { 0, -0.01, -1.7 },
                rotation_z = 0,
            },
        },
    },
}
