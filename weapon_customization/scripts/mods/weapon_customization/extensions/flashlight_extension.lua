local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local PerlinNoise = mod:original_require("scripts/utilities/perlin_noise")
local FlashlightTemplates = mod:original_require("scripts/settings/equipment/flashlight_templates")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Local functions
    local Unit = Unit
    local math = math
    local type = type
    local World = World
    local table = table
    local light = Light
    local pairs = pairs
    local CLASS = CLASS
    local ipairs = ipairs
    local string = string
    local vector3 = Vector3
    local math_max = math.max
    local tostring = tostring
    local managers = Managers
    local Matrix4x4 = Matrix4x4
    local unit_alive = Unit.alive
    local unit_light = Unit.light
    local WwiseWorld = WwiseWorld
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local script_unit = ScriptUnit
    local string_find = string.find
    local table_clone = table.clone
    local math_random = math.random
    local vector3_zero = vector3.zero
    local vector3_lerp = vector3.lerp
    local unit_get_data = Unit.get_data
    local quaternion_box = QuaternionBox
    local table_contains = table.contains
    local vector3_unbox = vector3_box.unbox
    local quaternion_lerp = Quaternion.lerp
    local math_easeInCubic = math.easeInCubic
    local math_random_seed = math.random_seed
    local light_set_enabled = light.set_enabled
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local quaternion_unbox = quaternion_box.unbox
    local matrix4x4_transform = Matrix4x4.transform
    local quaternion_identity = Quaternion.identity
    local quaternion_multiply = Quaternion.multiply
    local unit_local_rotation = Unit.local_rotation
    local unit_local_position = Unit.local_position
    local light_set_intensity = light.set_intensity
    local quaternion_matrix4x4 = Quaternion.matrix4x4
    local math_ease_out_elastic = math.ease_out_elastic
    local light_set_ies_profile = light.set_ies_profile
    local light_set_falloff_end = light.set_falloff_end
    local light_set_color_filter = light.set_color_filter
    local quaternion_from_vector = Quaternion.from_vector
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_local_position = Unit.set_local_position
    local light_set_casts_shadows = light.set_casts_shadows
    local light_set_falloff_start = light.set_falloff_start
    local light_set_spot_angle_end = light.set_spot_angle_end
    local light_set_spot_reflector = light.set_spot_reflector
    local script_unit_add_extension = script_unit.add_extension
    local light_color_with_intensity = light.color_with_intensity
    local light_set_spot_angle_start = light.set_spot_angle_start
    local wwise_world_make_auto_source = WwiseWorld.make_auto_source
    local world_update_unit_and_children = World.update_unit_and_children
    local unit_set_vector3_for_materials = Unit.set_vector3_for_materials
    local light_set_volumetric_intensity = light.set_volumetric_intensity
    local wwise_world_trigger_resource_event = WwiseWorld.trigger_resource_event
    local light_set_correlated_color_temperature = light.set_correlated_color_temperature
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local SLOT_SECONDARY = "slot_secondary"

mod.flashlight_templates = {
	flashlight_01 = table.combine(
        table_clone(FlashlightTemplates.autogun_p1), {battery = {max = 10, interval = .1, drain = .002, charge = .004}}
    ),
	flashlight_02 = table.combine(
        table_clone(FlashlightTemplates.lasgun_p3), {battery = {max = 10, interval = .1, drain = .001, charge = .004}}
    ),
	flashlight_03 = table.combine(
        table_clone(FlashlightTemplates.autopistol_p1), {battery = {max = 10, interval = .1, drain = .004, charge = .004}}
    ),
	flashlight_04 = table.combine(
        table_clone(FlashlightTemplates.lasgun_p1), {battery = {max = 10, interval = .1, drain = .003, charge = .004}}
    ),
	laser_pointer = {
		light = {
			first_person = {
				intensity = 12,
				cast_shadows = true,
				spot_reflector = false,
				color_temperature = 8000,
				color_filter = vector3_box(1, 0, 0),
				volumetric_intensity = 0.1,
				ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
				spot_angle = {max = 1.1, min = 0},
				falloff = {far = 70, near = 0},
			},
			third_person = {
				intensity = 12,
				cast_shadows = true,
				spot_reflector = false,
				color_temperature = 8000,
				color_filter = vector3_box(1, 0, 0),
				volumetric_intensity = 0.6,
				ies_profile = "content/environment/ies_profiles/narrow/flashlight_custom_02",
				spot_angle = {max = 0.8, min = 0},
				falloff = {far = 30, near = 0},
			}
		},
		battery = {max = 10, interval = .1, drain = .002, charge = .004},
		flicker = FlashlightTemplates.autogun_p1.flicker,
	},
}
mod.flashlight_templates.flashlight_01.light.first_person.intensity = 10
mod.flashlight_templates.flashlight_01.light.first_person.intensity = 10
mod.flashlight_templates.flashlight_02.light.first_person.intensity = 6
mod.flashlight_templates.flashlight_02.light.third_person.intensity = 6
mod.flashlight_templates.flashlight_03.light.third_person.falloff.far = 70
mod.flashlight_templates.flashlight_03.light.third_person.falloff.far = 30
mod.flashlight_templates.flashlight_04.light.third_person.falloff.far = 120
mod.flashlight_templates.flashlight_04.light.third_person.falloff.far = 50

-- ##### ┌─┐┬  ┌─┐┌─┐┬ ┬┬  ┬┌─┐┬ ┬┌┬┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ #####################################################
-- ##### ├┤ │  ├─┤└─┐├─┤│  ││ ┬├─┤ │   ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ #####################################################
-- ##### └  ┴─┘┴ ┴└─┘┴ ┴┴─┘┴└─┘┴ ┴ ┴   └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ #####################################################

local FlashlightExtension = class("FlashlightExtension", "WeaponCustomizationExtension")

-- ##### ┌─┐┌─┐┌┬┐┬ ┬┌─┐ ##############################################################################################
-- ##### └─┐├┤  │ │ │├─┘ ##############################################################################################
-- ##### └─┘└─┘ ┴ └─┘┴   ##############################################################################################

FlashlightExtension.init = function(self, extension_init_context, unit, extension_init_data)
    FlashlightExtension.super.init(self, extension_init_context, unit, extension_init_data)

    self.extension_init_context = extension_init_context
    self.extension_init_data = extension_init_data
    -- Get flashlight units 1p / 3p
	self.flashlight_unit_1p = extension_init_data.flashlight_unit_1p
	self.flashlight_unit_3p = extension_init_data.flashlight_unit_3p
    self.animation_move = vector3_box(vector3_zero())
    self.animation_spin = quaternion_box(quaternion_identity())
    -- Get lights 1p / 3p
    self.light_1p = unit_light(self.flashlight_unit_1p, 1)
    self.light_3p = unit_light(self.flashlight_unit_3p, 1)
    -- Get item
    self.item = extension_init_data.item or self.visual_loadout_extension and self.visual_loadout_extension:item_from_slot(SLOT_SECONDARY)
    self.gear_id = self.item and mod.gear_settings:item_to_gear_id(self.item)
    -- Set attachment
    self:set_flashlight_attachment()
    -- Properties
    self.on = extension_init_data.on or self.is_local_unit and mod:flashlight_active() or false
    self.start_flicker_now = false
    local wielded_slot = extension_init_data.wielded_slot
    self.wielded = wielded_slot and wielded_slot.name == SLOT_SECONDARY
    self.spectated = false
    self.has_flashlight = self.flashlight_attachment ~= nil
    self.flashlight_template = self.flashlight_attachment and mod.flashlight_templates[self.flashlight_attachment]
    local flashlight = mod.gear_settings:get(self.item, "flashlight", true)
    local default = mod.gear_settings:default_attachment(self.item, "flashlight") or "default"
    -- self._is_modded = flashlight ~= nil and string_find(default, "default")
    self._is_modded = flashlight ~= nil and mod:cached_find(default, "default")
    -- Set light values 1p / 3p
    if self.has_flashlight and self.flashlight_template then
        self:set_light_values(self.flashlight_unit_1p, self.flashlight_template.light.first_person)
        self:set_light_values(self.flashlight_unit_3p, self.flashlight_template.light.third_person)
    end
    -- Create battery extension
    if self.has_flashlight and self.flashlight_template and self.flashlight_template.battery and self:is_modded() then
        self:add_extension(self.player_unit, "battery_system", extension_init_context, {
            player_unit = self.player_unit,
            battery_template = self.flashlight_template.battery,
            consumer = self,
            wielded_slot = extension_init_data.wielded_slot,
            on = self.on,
        })
    end
    -- if self:is_laser_pointer() and self.user_laser_pointer_system then
    --     self:add_extension(self.player_unit, "laser_pointer_system", extension_init_context, extension_init_data)
    -- end
    -- Register events
    -- self:register_event("weapon_customization_cutscene", "set_cutscene")
    -- self:register_event("weapon_customization_settings_changed", "on_settings_changed")
    managers.event:register(self, "weapon_customization_cutscene", "set_cutscene")
    managers.event:register(self, "weapon_customization_settings_changed", "on_settings_changed")
    -- Register synchronized calls
    self:register_synchronized_call("set_enabled")
    self:register_synchronized_call("set_spectated")
    self:register_synchronized_call("set_cutscene")
    self:register_synchronized_call("on_settings_changed")
    self:register_synchronized_call("on_wield_slot")
    self:register_synchronized_call("on_unwield_slot")
    -- Create laser pointer extension
    self:set_laser_pointer_system()
    -- Get settings
    self:on_settings_changed()
    -- Set initialized
    self.initialized = true
end

FlashlightExtension.set_laser_pointer_system = function(self)
    -- Create laser pointer extension
    if self:is_laser_pointer() and self.user_laser_pointer_system then
        self:add_extension(self.player_unit, "laser_pointer_system", self.extension_init_context, self.extension_init_data)
        self:execute_extension(self.player_unit, "laser_pointer_system", "respawn_all")
    else
        self:execute_extension(self.player_unit, "laser_pointer_system", "despawn_all")
        self:remove_extension(self.player_unit, "laser_pointer_system")
    end
end

FlashlightExtension.delete = function(self)
    -- Unregister events
    managers.event:unregister(self, "weapon_customization_cutscene")
    managers.event:unregister(self, "weapon_customization_settings_changed")

    self:execute_extension(self.player_unit, "laser_pointer_system", "despawn_all")
    -- Deactivate
    self.initialized = false
    self.on = false
    -- Unset
    self:set_light(false, false)
    
    FlashlightExtension.super.delete(self)
end

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

FlashlightExtension.flashlight_unit = function(self, optional_other_one)
    -- Get first person
    local first_person = self:get_first_person()
    -- Optional other one
    if optional_other_one then first_person = not first_person end
    -- Return unit
    if first_person then return self.flashlight_unit_1p end
    return self.flashlight_unit_3p
end

FlashlightExtension.light_template = function(self, optional_other_one)
    -- Check flashlight template
    if self.flashlight_template then
        -- Get first person
        local first_person = self:get_first_person()
        -- Optional other one
        if optional_other_one then first_person = not first_person end
        -- Return light template
        if first_person then return self.flashlight_template.light.first_person end
        return self.flashlight_template.light.third_person
    end
end

FlashlightExtension.light = function(self, optional_other_one)
    -- Get first person
    local first_person = self:get_first_person()
    -- Optional other one
    if optional_other_one then first_person = not first_person end
    -- Return light
    if first_person then return self.flashlight_unit_1p and unit_alive(self.flashlight_unit_1p) and self.light_1p end
    return self.flashlight_unit_3p and unit_alive(self.flashlight_unit_3p) and self.light_3p
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### │ ┬├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

FlashlightExtension.is_wielded = function(self)
    return self.wielded
end

FlashlightExtension.is_laser_pointer = function(self)
    return self.flashlight_attachment == "laser_pointer"
end

FlashlightExtension.is_aiming = function(self)
	return self.alternate_fire_component and self.alternate_fire_component.is_active
end

FlashlightExtension.is_modded = function(self)
    -- local flashlight = mod.gear_settings:get(self.item, "flashlight", true)
    -- local default = mod.gear_settings:default_attachment(self.item, "flashlight") or "default"
    -- return flashlight ~= nil and not string.find(default, "default")
    return self._is_modded
end

-- ##### ┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐ ###########################################################################################
-- ##### │ │├─┘ ││├─┤ │ ├┤  ###########################################################################################
-- ##### └─┘┴  ─┴┘┴ ┴ ┴ └─┘ ###########################################################################################

FlashlightExtension.update_husk = function(self, dt, t)
    -- Check hub
    local is_in_hub = mod:is_in_hub() or mod:is_in_prologue_hub()
    -- Husk with flashlight?
    local husk = self.has_flashlight and not self.is_local_unit
    if husk and not self.on and not is_in_hub then
        self:set_enabled(true, false)
    end
end

FlashlightExtension.update = function(self, dt, t)
    local first_person = self:get_first_person()
    if self.initialized then
        self:update_husk(dt, t)
        self:update_flicker(dt, t)
        -- self:set_enabled(self.on, false)
        -- Update laser pointer
        if self.user_laser_pointer_system then mod:execute_extension(self.player_unit, "laser_pointer_system", "update", dt, t) end
        -- Check first person change
        if self.last_first_person ~= first_person then
            -- Set lights for current view 1p / 3p
            self:set_light(false, false, true)
            self:set_light(false)
        end
        -- Intensity
        self:update_intensity()
        self:update_animation(dt, t)
        -- Save last first person
        self.last_first_person = first_person
    end
    -- Relay to sub extensions
    FlashlightExtension.super.update(self, dt, t)
end

FlashlightExtension.update_flicker = function(self, dt, t)
    if self.initialized and self.has_flashlight and self.on then
        local light_unit = self:flashlight_unit()
        if light_unit and unit_alive(light_unit) and self.flashlight_template and self.flashlight_template.flicker then
            local settings = self.flashlight_template.flicker
            self.next_check_at_t = self.next_check_at_t or 0

            if not self.flickering and self.next_check_at_t and ((self.next_check_at_t <= t) or self.start_flicker_now) then
                local chance = settings.chance
                local roll = math_random()

                if roll <= chance or self.start_flicker_now then
                    self.start_flicker_now = nil
                    self.flickering = true
                    self.flicker_start_t = t
                    if self.fx_extension then
                        self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_flicker",
                            false, light_unit, 1)
                    end
                    local duration = settings.duration
                    local min = duration.min
                    local max = duration.max
                    self.flicker_duration = math_random() * (max - min) + min
                    self.seed = math_random_seed()
                else
                    local interval = settings.interval
                    local min = interval.min
                    local max = interval.max
                    self.next_check_at_t = t + math_random(min, max)
                    return
                end
            end

            if self.flickering and self.flicker_start_t and self.flicker_duration and self.seed then
                local flicker_duration = self.flicker_duration
                local current_flicker_time = t - self.flicker_start_t
                local flicker_end_time = self.flicker_start_t + self.flicker_duration
                local progress = current_flicker_time / flicker_duration
                local intensity_scale = nil

                if progress >= 1 then
                    self.flickering = nil
                    local interval = settings.interval
                    local min = interval.min
                    local max = interval.max
                    self.next_check_at_t = t + math_random(min, max)
                    intensity_scale = 1
                else
                    local fade_out = settings.fade_out
                    local min_octave_percentage = settings.min_octave_percentage
                    local fade_progress = fade_out and math_max(1 - progress, min_octave_percentage) or 1
                    local frequence_multiplier = settings.frequence_multiplier
                    local persistance = settings.persistance
                    local octaves = settings.octaves
                    intensity_scale = 1 - PerlinNoise.calculate_perlin_value((flicker_end_time - t) * frequence_multiplier, persistance, octaves * fade_progress, self.seed)
                end

                local light = unit_light(light_unit, 1)
                if light then
                    local light_template = self:light_template()
                    local intensity = light_template.intensity * intensity_scale
                    light_set_intensity(light, intensity)
                    local color = light_color_with_intensity(light)
                    unit_set_vector3_for_materials(light_unit, "light_color", color * intensity_scale * intensity_scale * intensity_scale)
                end
            end
        end
    end
end

-- ##### ┌─┐┌─┐┌┬┐  ┬  ┬┌─┐┬  ┬ ┬┌─┐┌─┐ ###############################################################################
-- ##### └─┐├┤  │   └┐┌┘├─┤│  │ │├┤ └─┐ ###############################################################################
-- ##### └─┘└─┘ ┴    └┘ ┴ ┴┴─┘└─┘└─┘└─┘ ###############################################################################

FlashlightExtension.set_spectated = function(self, spectated)
    if self.initialized then
        self.spectated = spectated
        -- Relay to sub extensions
        FlashlightExtension.super.set_spectated(self, self.spectated)
    end
end

FlashlightExtension.set_cutscene = function(self, is_cutscene)
    if self.initialized then
        self.cut_scene = is_cutscene
        -- Relay to sub extensions
        FlashlightExtension.super.set_cutscene(self, self.cut_scene)
    end
end

FlashlightExtension.set_flashlight_attachment = function(self)
    if self.flashlight_attachment ~= nil then return self.flashlight_attachment end
    local attachments = self.item.attachments
    if attachments then
        self.flashlight_attachment = unit_get_data(self.flashlight_unit_1p, "attachment_name")
    end
end

FlashlightExtension.update_intensity = function(self)
    local charge_fraction = math.clamp(mod:execute_extension(self.player_unit, "battery_system", "fraction") or 1, .3, 1)
    local light = self:light()
    local template = self:light_template()
    if light and template then
        light_set_enabled(light, self.on)
        light_set_intensity(light, template.intensity * charge_fraction)
        light_set_spot_angle_start(light, template.spot_angle.min * charge_fraction)
        light_set_spot_angle_end(light, template.spot_angle.max * charge_fraction)
        light_set_falloff_start(light, template.falloff.near * charge_fraction)
        light_set_falloff_end(light, template.falloff.far * charge_fraction)
        light_set_volumetric_intensity(light, template.volumetric_intensity * charge_fraction)
    end
end

FlashlightExtension.set_light_values = function(self)
    -- Current
    local flashlight_unit = self:flashlight_unit()
    local template = self:light_template()
    if flashlight_unit and template then
        mod:set_light_values(flashlight_unit, template)
    end
    -- Other one
    flashlight_unit = self:flashlight_unit(true)
    template = self:light_template(true)
    if flashlight_unit and template then
        mod:set_light_values(flashlight_unit, template)
    end
end

-- FlashlightExtension.sync  = function(self)
--     local is_in_hub = mod:is_in_hub() or mod:is_in_prologue_hub()
--     if self.initialized and not is_in_hub then

--         light_set_enabled(light, on)
--         self.on = not self.on
--         if self.is_local_unit then
--             mod:set_flashlight_active(self.on)
--         end
--         self:set_light(play_sound, self.on)
--     end
--     -- Relay to sub extensions
--     FlashlightExtension.super.set_enabled(self, self.on)
-- end

FlashlightExtension.set_enabled  = function(self, optional_value, optional_play_sound)
    local play_sound = optional_play_sound or self.is_local_unit or self.spectated
    local is_in_hub = mod:is_in_hub() or mod:is_in_prologue_hub()
    if self.initialized and not is_in_hub then
        self.on = not self.on
        if optional_value ~= nil then self.on = optional_value end
        if self.is_local_unit then
            mod:set_flashlight_active(self.on)
        end
        self:set_light(play_sound, self.on)
        self:play_animation()
    end
    -- Relay to sub extensions
    FlashlightExtension.super.set_enabled(self, self.on)
end

FlashlightExtension.set_light = function(self, play_sound, optional_value, optional_other_one)
    if self.initialized then
        local on = optional_value or self.on
        local flashlight_unit = self:flashlight_unit(optional_other_one)
        local light = self:light(optional_other_one)
        if flashlight_unit and unit_alive(flashlight_unit) and light then
            self:set_light_values(flashlight_unit)
            light_set_enabled(light, on)
            light_set_casts_shadows(light, self.flashlight_shadows)
            local color = on and light_color_with_intensity(light) or vector3_zero()
            unit_set_vector3_for_materials(flashlight_unit, "light_color", color)
        end
        if self.is_local_unit or self.spectated then
            if self.fx_extension and play_sound ~= false and self.on then
                -- Switch on
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_on", false, self.player_unit, 1)
            elseif self.fx_extension and play_sound ~= false then
                -- Switch off
                self.fx_extension:trigger_wwise_event("wwise/events/player/play_foley_gear_flashlight_off", false, self.player_unit, 1)
            end
        end
    end
end

FlashlightExtension.play_animation = function(self)
    -- local is_aiming = mod:execute_extension(self.player_unit, "sight_system", "is_aiming")
    local multiplier = self:is_aiming() and .25 or 1

    self.animation_start = mod:game_time()
    self.animation_state = "move"
    self.animation_time = .15
    self.animation_move:store(vector3(0, -.01, -.03) * multiplier)
    self.animation_spin:store(quaternion_from_vector(vector3(1.5, 1.5, -1.5) * multiplier))
end

FlashlightExtension.update_animation = function(self, dt, t)

    if self.first_person_unit and unit_alive(self.first_person_unit) then

        local node = Unit.node(self.first_person_unit, "ap_aim")
        local rotation = unit_local_rotation(self.first_person_unit, node)
        local rotation_offset = quaternion_identity()
        local position = unit_local_position(self.first_person_unit, node)
        local position_offset = vector3_zero()

        if self.animation_state == "move" then
            if self.animation_start and t - self.animation_start < self.animation_time then
                local progress = (t - self.animation_start) / self.animation_time
                local anim_progress = math.ease_in_out_bounce(progress)
                rotation_offset = quaternion_lerp(quaternion_identity(), quaternion_unbox(self.animation_spin), anim_progress)
                position_offset = vector3_lerp(vector3_zero(), vector3_unbox(self.animation_move), anim_progress)
            else
                rotation_offset = quaternion_unbox(self.animation_spin)
                position_offset = vector3_unbox(self.animation_move)
                self.animation_state = "back"
                self.animation_start = t
            end

        elseif self.animation_state == "back" then
            if self.animation_start and t - self.animation_start < self.animation_time then
                local progress = (t - self.animation_start) / self.animation_time
                local anim_progress = math_easeInCubic(progress)
                rotation_offset = quaternion_lerp(quaternion_unbox(self.animation_spin), quaternion_identity(), anim_progress)
                position_offset = vector3_lerp(vector3_unbox(self.animation_move), vector3_zero(), anim_progress)
            else
                self.animation_state = nil
                self.animation_start = nil
            end

        end

        local new_rotation = quaternion_multiply(rotation, rotation_offset)
        unit_set_local_rotation(self.first_person_unit, node, new_rotation)
        local mat = quaternion_matrix4x4(rotation)
        local rotated_offset = matrix4x4_transform(mat, position_offset)
        
        unit_set_local_position(self.first_person_unit, node, position + rotated_offset)
        -- world_update_unit_and_children(self.world, self.first_person_unit)

    end

end

-- ##### ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐ ##########################################################################################
-- ##### ├┤ └┐┌┘├┤ │││ │ └─┐ ##########################################################################################
-- ##### └─┘ └┘ └─┘┘└┘ ┴ └─┘ ##########################################################################################

FlashlightExtension.on_settings_changed = function(self)
    self.user_laser_pointer_system = mod:get("mod_option_laser_pointer")
    self:set_laser_pointer_system()
    self.flashlight_shadows = mod:get("mod_option_flashlight_shadows")
    self:set_light()
    -- Relay to sub extensions
    FlashlightExtension.super.on_settings_changed(self)
end

FlashlightExtension.on_toggle = function(self, optional_play_sound, optional_value)
    if self:is_wielded() then
        self:set_enabled(optional_value, optional_play_sound)
    end
end

FlashlightExtension.on_wield_slot = function(self, slot)
    if self.initialized then
        self.wielded = slot.name == SLOT_SECONDARY
        self:set_light(false)
        -- Relay to sub extensions
        FlashlightExtension.super.on_wield_slot(self, slot)
    end
end

FlashlightExtension.on_unwield_slot = function(self, slot)
    if self.initialized then
        if slot.name == SLOT_SECONDARY then
            self.wielded = false
            self:set_light(false)
        end
        -- Relay to sub extensions
        FlashlightExtension.super.on_unwield_slot(self, slot)
    end
end

-- ##### ┌─┐┬  ┌─┐┌┐ ┌─┐┬   ###########################################################################################
-- ##### │ ┬│  │ │├┴┐├─┤│   ###########################################################################################
-- ##### └─┘┴─┘└─┘└─┘┴ ┴┴─┘ ###########################################################################################

mod.is_flashlight_modded = function(self, item_or_gear_id)
    return self:execute_extension(self.player_unit, "flashlight_system", "is_modded")
end

mod.is_laser_pointer_modded = function(self, item_or_gear_id)
    return self:execute_extension(self.player_unit, "flashlight_system", "is_laser_pointer")
end

mod.is_flashlight_wielded = function(self)
    return self:execute_extension(self.player_unit, "flashlight_system", "is_wielded")
end

mod.toggle_flashlight = function(self)
    self:execute_extension(self.player_unit, "flashlight_system", "on_toggle")
end

mod.set_flashlight_active = function(self, active)
    mod:persistent_table(REFERENCE).flashlight_on = active
end

mod.flashlight_active = function(self)
    return mod:persistent_table(REFERENCE).flashlight_on
end

mod.has_flashlight = function(self, item)
    local flashlight = self.gear_settings:get(item, "flashlight")
    flashlight = self.gear_settings:correct(item, "flashlight", flashlight)
    return flashlight and flashlight ~= "laser_pointer" and flashlight ~= "" and flashlight ~= "default"
end

mod.preview_flashlight = function(self, state, world, unit, attachment_name, no_sound)
	if table_contains(self.flashlights, attachment_name) then
        local unit_good = unit and unit_alive(unit)
		local flashlight_template = self:get_flashlight_template(attachment_name)
		if flashlight_template and unit_good then
			self:set_light_values(unit, flashlight_template.light.third_person)
            local light = unit_light(unit, 1)
            if light then
                light_set_enabled(light, state)
                light_set_casts_shadows(light, self:get("mod_option_flashlight_shadows"))
                local color = state and light_color_with_intensity(light) or vector3_zero()
                unit_set_vector3_for_materials(unit, "light_color", color)
            end
            if not no_sound then
                local wwise_world = self:wwise_world(world)
                local source_id = wwise_world_make_auto_source(wwise_world, unit, 1)
                local sound = "wwise/events/player/play_foley_gear_flashlight_on"
                if not state then sound = "wwise/events/player/play_foley_gear_flashlight_off" end
                wwise_world_trigger_resource_event(wwise_world, sound, source_id)
            end
			self:set_preview_laser(state == true and attachment_name == "laser_pointer", unit, world)
		end
	end
end

mod.set_light_values = function(self, flashlight_unit, template)
    local unit_good = flashlight_unit and unit_alive(flashlight_unit)
    local light = unit_good and unit_light(flashlight_unit, 1)
    local attachment_name = unit_good and unit_get_data(flashlight_unit, "attachment_name")
    local template = template or attachment_name and self:get_flashlight_template(attachment_name)
    if template and light then
        light_set_ies_profile(light, template.ies_profile)
        light_set_correlated_color_temperature(light, template.color_temperature)
        light_set_intensity(light, template.intensity)
        light_set_volumetric_intensity(light, template.volumetric_intensity)
        light_set_casts_shadows(light, mod:get("mod_option_flashlight_shadows"))
        light_set_spot_angle_start(light, template.spot_angle.min)
        light_set_spot_angle_end(light, template.spot_angle.max)
        light_set_spot_reflector(light, template.spot_reflector)
        light_set_falloff_start(light, template.falloff.near)
        light_set_falloff_end(light, template.falloff.far)
        if template.color_filter then
            local color_filter = vector3_unbox(template.color_filter)
            light_set_color_filter(light, color_filter)
        end
    end
end

mod.get_flashlight_template = function(self, flashlight_name)
    if flashlight_name then return self.flashlight_templates[flashlight_name] end
end

mod:hook_require("scripts/settings/equipment/flashlight_templates", function(instance)
    if instance then
        for name, template in pairs(instance) do
            template.light.first_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
            template.light.third_person.cast_shadows = mod:get("mod_option_flashlight_shadows")
        end
    end
end)

return FlashlightExtension
