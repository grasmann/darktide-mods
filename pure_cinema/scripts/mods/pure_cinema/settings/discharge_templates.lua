local mod = get_mod("pure_cinema")

return {
    {
        name = "single",
        trigger = "death",
        time = 0.3,
    },
    {
        name = "burst",
        trigger = "death",
        time = 0.5,
    },
    {
        name = "automatic",
        trigger = "death",
        time = 1,
    },
    {
        name = "drop_single",
        trigger = "drop",
        time = 0.3,
    },
    {
        name = "drop_burst",
        trigger = "drop",
        time = 0.5,
    },
    {
        name = "drop_automatic",
        trigger = "drop",
        time = 1,
    },
    {
        name = "land_single",
        trigger = "land",
        time = 0.3,
    },
    {
        name = "land_burst",
        trigger = "land",
        time = 0.5,
    },
    {
        name = "land_automatic",
        trigger = "land",
        time = 1,
    },
}