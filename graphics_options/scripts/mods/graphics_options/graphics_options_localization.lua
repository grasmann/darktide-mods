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
		["zh-cn"] = "动态日光阴影",
	},
	gm_sun_shadow_mo = {
		en = "Switching off dynamic sun shadows can improve performance",
		de = "Die dynamischen Sonnenschatten auszuschalten kann Performance verbessern",
		["zh-cn"] = "关闭动态日光阴影会提升性能",
	},
	gm_local_lights_shadow = {
		en = "Local Light Shadows",
		de = "Lokale Lichtschatten",
		["zh-cn"] = "局部光照阴影",
	},
	gm_local_lights_shadow_mo = {
		en = "Switching off local light shadows can improve performance",
		de = "Die lokalen Lichtschatten auszuschalten kann Performance verbessern",
		["zh-cn"] = "关闭局部光照阴影会提升性能",
	},
	gm_sun_shadow_map = {
		en = "Sun Shadows Map",
		de = "Sonnenschatten Größe",
		["zh-cn"] = "日光阴影映射",
	},
	gm_sun_shadow_map_mo = {
		en = "Lowering sun shadow map size can improve performance",
		de = "Die Sonnenschatten Größe zu verringern kann Performance verbessern",
		["zh-cn"] = "降低日光阴影映射大小会提升性能",
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
		["zh-cn"] = "局部光照阴影映射",
	},
	gm_local_light_shadow_map_mo = {
		en = "Lowering local light shadow map size can improve performance",
		de = "Die lokale Lichtschatten Größe zu verringern kann Performance verbessern",
		["zh-cn"] = "降低局部光照阴影映射大小会提升性能",
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
		["zh-cn"] = "质量",
	},
	gm_fog_quality_mo = {
		en = "Volumetric fog quality",
		de = "Volumetrischer Nebel Qualität",
		["zh-cn"] = "体积雾质量",
	},
	gm_fog_local_light = {
		en = "Local Lights",
		de = "Lokales Licht",
		["zh-cn"] = "局部光照",
	},
	gm_fog_local_light_mo = {
		en = "Volumetric fog is affected by local lights",
		de = "Volumetrischer Nebel wird von lokalen Lichtern beinflusst",
		["zh-cn"] = "体积雾受局部光照影响",
	},
	gm_fog_light_shafts = {
		en = "Light Shafts",
		de = "Lichtstrahlen",
		["zh-cn"] = "光轴渲染",
	},
	gm_fog_light_shafts_mo = {
		en = "Volumetric fog is projecting light shafts",
		de = "Volumetrischer Nebel projeziert Lichtstrahlen",
		["zh-cn"] = "体积雾为投射光轴",
	},
	gm_fog_high_quality = {
		en = "High Quality",
		de = "Hohe Qualität",
		["zh-cn"] = "高质量",
	},
	gm_fog_high_quality_mo = {
		en = "Volumetric fog is rendered in high quality",
		de = "Volumetrischer Nebel wird in hoher Qualität berechnet",
		["zh-cn"] = "体积雾以高质量渲染",
	},
	gm_fog_volumetric_shadows = {
		en = "Volumetric Shadows",
		de = "Volumetrische Schatten",
		["zh-cn"] = "体积阴影",
	},
	gm_fog_volumetric_shadows_mo = {
		en = "Volumetric fog projects shadows",
		de = "Volumetrischer Nebel wirft Schatten",
		["zh-cn"] = "体积雾投射阴影",
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
		["zh-cn"] = "更多图像选项",
	},
	mod_description = {
		en = "Additional options in the video settings.",
		de = "Zusätzliche Optionen in den Grafikeinstellungen.",
		["zh-cn"] = "在视频选项中提供额外的选项。",
	},
}
