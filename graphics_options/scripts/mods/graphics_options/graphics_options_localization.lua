local mod = get_mod("graphics_options")
-- Global localizations for settings menu widgets
mod:add_global_localize_strings({
	gm_framerate_cap_144 = {
		en = "144",
	},
	gm_sun_shadow = {
		en = "Sun Shadows"
	},
	gm_sun_shadow_mo = {
		en = "Switching off sun shadows can improve performance.",
	},
	gm_local_lights_shadow = {
		en = "Local Light Shadows",
	},
	gm_local_lights_shadow_mo = {
		en = "Switching off local light shadows can improve performance.",
	},
	gm_sun_shadow_map = {
		en = "Sun Shadows Map",
	},
	gm_sun_shadow_map_mo = {
		en = "Lowering sun shadow map size can improve performance.",
	},
	gm_sun_shadow_map_256 = {
		en = "256",
	},
	gm_sun_shadow_map_512 = {
		en = "512",
	},
	gm_sun_shadow_map_1024 = {
		en = "1024",
	},
	gm_sun_shadow_map_2048 = {
		en = "2048",
	},
	gm_sun_shadow_map_4096 = {
		en = "4096",
	},
	gm_local_light_shadow_map = {
		en = "Local Light Shadows Map",
	},
	gm_local_light_shadow_map_mo = {
		en = "Lowering local light shadow map size can improve performance.",
	},
	gm_local_light_shadow_map_256 = {
		en = "256",
	},
	gm_local_light_shadow_map_512 = {
		en = "512",
	},
	gm_local_light_shadow_map_1024 = {
		en = "1024",
	},
	gm_local_light_shadow_map_2048 = {
		en = "2048",
	},
	gm_local_light_shadow_map_4096 = {
		en = "4096",
	},
	gm_fog_quality = {
		en = "Quality",
	},
	gm_fog_quality_mo = {
		en = "Volumetric fog quality.",
	},
	gm_fog_local_light = {
		en = "Local Lights",
	},
	gm_fog_local_light_mo = {
		en = "Volumetric fog is affected by local lights.",
	},
	gm_fog_light_shafts = {
		en = "Light Shafts",
	},
	gm_fog_light_shafts_mo = {
		en = "Volumetric fog is projecting light shafts.",
	},
	gm_fog_high_quality = {
		en = "High Quality",
	},
	gm_fog_high_quality_mo = {
		en = "Volumetric fog is rendered in high quality.",
	},
	gm_fog_volumetric_shadows = {
		en = "Volumetric Shadows",
	},
	gm_fog_volumetric_shadows_mo = {
		en = "Volumetric fog has volumetric shadows.",
	},
})
-- Local localizations
return {
	mod_title = {
		en = "Graphics Options",
		de = "Grafikeinstellungen",
	},
	mod_description = {
		en = "Additional options in the video settings.",
		de = "Zusätzliche Optionen in den Grafikeinstellungen."
	},
}