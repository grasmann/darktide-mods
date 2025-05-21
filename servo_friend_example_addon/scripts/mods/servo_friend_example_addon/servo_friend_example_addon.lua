local mod = get_mod("servo_friend_example_addon")

local managers = Managers

mod.on_all_mods_loaded = function()
    -- mod.event_manager = managers.event
end

mod.on_unload = function(exit_game)
end

mod.on_setting_changed = function(setting_id)
    managers.event:trigger("servo_friend_example_addon_settings_changed")
end

mod:io_dofile("servo_friend_example_addon/scripts/mods/servo_friend_example_addon/extensions/servo_friend_hat_extension")