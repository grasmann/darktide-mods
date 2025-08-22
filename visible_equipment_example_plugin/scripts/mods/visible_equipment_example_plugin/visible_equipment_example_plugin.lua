local mod = get_mod("visible_equipment_example_plugin")

local vector3_box = Vector3Box

mod.visible_equipment_plugin = {
    offsets = {
        combataxe_p3_m1 = {
            head = {
                right = {
                    node = "j_head",
                    position = vector3_box(0, 0, 0),
                    rotation = vector3_box(0, 0, 90),
                },
            },
        },
    },
    placements = {
        head = "head",
    },
    placement_camera = {
        head = {
            position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
            rotation = 1.5,
        },
    }
}
