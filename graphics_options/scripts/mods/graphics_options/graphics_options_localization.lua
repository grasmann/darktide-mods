local mod = get_mod("graphics_options")

-- #####  ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗      ###########################################################
-- ##### ██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║      ###########################################################
-- ##### ██║  ███╗██║     ██║   ██║██████╔╝███████║██║      ###########################################################
-- ##### ██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║      ###########################################################
-- ##### ╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗ ###########################################################
-- #####  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###########################################################

mod:add_global_localize_strings({
	gm_framerate_cap_144 = {
		en = "144",
	},
	gm_sun_shadow = {
		en = "Dynamic Sun Shadows",
		de = "Dynamische Sonnenschatten",
	},
	gm_sun_shadow_mo = {
		en = "Switching off dynamic sun shadows can improve performance",
		de = "Die dynamischen Sonnenschatten auszuschalten kann Performance verbessern",
	},
	gm_local_lights_shadow = {
		en = "Local Light Shadows",
		de = "Lokale Lichtschatten",
	},
	gm_local_lights_shadow_mo = {
		en = "Switching off local light shadows can improve performance",
		de = "Die lokalen Lichtschatten auszuschalten kann Performance verbessern",
	},
	gm_sun_shadow_map = {
		en = "Sun Shadows Map",
		de = "Sonnenschatten Größe",
	},
	gm_sun_shadow_map_mo = {
		en = "Lowering sun shadow map size can improve performance",
		de = "Die Sonnenschatten Größe zu verringern kann Performance verbessern",
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
		de = "Lokale Lichtschatten Größe",
	},
	gm_local_light_shadow_map_mo = {
		en = "Lowering local light shadow map size can improve performance",
		de = "Die lokale Lichtschatten Größe zu verringern kann Performance verbessern",
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
		de = "Qualität",
	},
	gm_fog_quality_mo = {
		en = "Volumetric fog quality",
		de = "Volumetrischer Nebel Qualität",
	},
	gm_fog_local_light = {
		en = "Local Lights",
		de = "Lokales Licht",
	},
	gm_fog_local_light_mo = {
		en = "Volumetric fog is affected by local lights",
		de = "Volumetrischer Nebel wird von lokalen Lichtern beinflusst"
	},
	gm_fog_light_shafts = {
		en = "Light Shafts",
		de = "Lichtstrahlen",
	},
	gm_fog_light_shafts_mo = {
		en = "Volumetric fog is projecting light shafts",
		de = "Volumetrischer Nebel projeziert Lichtstrahlen",
	},
	gm_fog_high_quality = {
		en = "High Quality",
		de = "Hohe Qualität",
	},
	gm_fog_high_quality_mo = {
		en = "Volumetric fog is rendered in high quality",
		de = "Volumetrischer Nebel wird in hoher Qualität berechnet",
	},
	gm_fog_volumetric_shadows = {
		en = "Volumetric Shadows",
		de = "Volumetrische Schatten",
	},
	gm_fog_volumetric_shadows_mo = {
		en = "Volumetric fog projects shadows",
		de = "Volumetrischer Nebel wirft Schatten",
	},
})

-- ##### ██╗      ██████╗  ██████╗ █████╗ ██╗      ####################################################################
-- ##### ██║     ██╔═══██╗██╔════╝██╔══██╗██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ███████║██║      ####################################################################
-- ##### ██║     ██║   ██║██║     ██╔══██║██║      ####################################################################
-- ##### ███████╗╚██████╔╝╚██████╗██║  ██║███████╗ ####################################################################
-- ##### ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝ ####################################################################

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