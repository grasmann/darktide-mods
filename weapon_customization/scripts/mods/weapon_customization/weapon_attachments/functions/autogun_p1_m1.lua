local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local _item = "content/items/weapons/player"
	local _item_ranged = _item.."/ranged"
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table = table
	local table_combine = table.combine
	local table_icombine = table.icombine
	local table_model_table = table.model_table
	local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local functions = {
	-- ##### ┬┌┐┌┌─┐┌─┐┌┐┌┌┬┐┬─┐┬ ┬  ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ││││├┤ ├─┤│││ │ ├┬┘└┬┘  ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### ┴┘└┘└  ┴ ┴┘└┘ ┴ ┴└─ ┴   └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	infantry_barrel_attachments = function(default)
		local attachments = {
			{id = "barrel_01", name = "Infantry Autogun (01)"},
			{id = "barrel_02", name = "Infantry Autogun (02)"},
			{id = "barrel_03", name = "Infantry Autogun (03)"},
			{id = "barrel_04", name = "Infantry Autogun (04)"},
			{id = "barrel_05", name = "Infantry Autogun (05)"},
			{id = "barrel_06", name = "Infantry Autogun (06)"},
			{id = "barrel_21", name = "Infantry Autogun (21)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "barrel_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	infantry_barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "barrel_default",	model = ""},
			{name = "barrel_01", 		model = _item_ranged.."/barrels/autogun_rifle_barrel_01"},
			{name = "barrel_02",		model = _item_ranged.."/barrels/autogun_rifle_barrel_02"},
			{name = "barrel_03",		model = _item_ranged.."/barrels/autogun_rifle_barrel_03"},
			{name = "barrel_04",		model = _item_ranged.."/barrels/autogun_rifle_barrel_04"},
			{name = "barrel_05",		model = _item_ranged.."/barrels/autogun_rifle_barrel_05"},
			{name = "barrel_06",		model = _item_ranged.."/barrels/autogun_rifle_barrel_06"},
			{name = "barrel_21",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ml01"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┬─┐┌─┐┌─┐┌─┐┌┬┐  ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├┴┐├┬┘├─┤│  ├┤  ││  ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### └─┘┴└─┴ ┴└─┘└─┘─┴┘  └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	braced_barrel_attachments = function(default)
		local attachments = {
			{id = "barrel_07", name = "Braced Autogun (07)"},
			{id = "barrel_08", name = "Braced Autogun (08)"},
			{id = "barrel_09", name = "Braced Autogun (09)"},
			{id = "barrel_10", name = "Braced Autogun (10)"},
			{id = "barrel_13", name = "Braced Autogun (13)"},
			{id = "barrel_14", name = "Braced Autogun (14)"},
			{id = "barrel_18", name = "Braced Autogun (18)"},
			{id = "barrel_19", name = "Braced Autogun (19)"},
			{id = "barrel_20", name = "Braced Autogun (20)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "barrel_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	braced_barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "barrel_default",	model = ""},
			{name = "barrel_07",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_01"},
			{name = "barrel_08",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_02"},
			{name = "barrel_09",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_03"},
			{name = "barrel_10",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_04"},
			{name = "barrel_13",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_05"},
			{name = "barrel_14",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_06"},
			{name = "barrel_18",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_07"},
			{name = "barrel_19",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_08"},
			{name = "barrel_20",		model = _item_ranged.."/barrels/autogun_rifle_barrel_ak_ml01"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬ ┬┌─┐┌─┐┌┬┐┬ ┬┬ ┬┌┐┌┌┬┐┌─┐┬─┐  ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├─┤├┤ ├─┤ ││├─┤│ ││││ │ ├┤ ├┬┘  ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### ┴ ┴└─┘┴ ┴─┴┘┴ ┴└─┘┘└┘ ┴ └─┘┴└─  └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	headhunter_barrel_attachments = function(default)
		local attachments = {
			{id = "barrel_11", name = "Headhunter Autogun (11)"},
			{id = "barrel_12", name = "Headhunter Autogun (12)"},
			{id = "barrel_15", name = "Headhunter Autogun (15)"},
			{id = "barrel_16", name = "Headhunter Autogun (16)"},
			{id = "barrel_22", name = "Headhunter Autogun (22)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "barrel_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	headhunter_barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "barrel_default",	model = ""},
			{name = "barrel_11",		model = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_01"},
			{name = "barrel_12",		model = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_03"},
			{name = "barrel_15",		model = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_04"},
			{name = "barrel_16",		model = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_05"},
			{name = "barrel_22",		model = _item_ranged.."/barrels/autogun_rifle_barrel_killshot_ml01"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬┌┐┌┌─┐┌─┐┌┐┌┌┬┐┬─┐┬ ┬  ┌┬┐┬ ┬┌─┐┌─┐┬  ┌─┐┌─┐
	-- ##### ││││├┤ ├─┤│││ │ ├┬┘└┬┘  ││││ │┌─┘┌─┘│  ├┤ └─┐
	-- ##### ┴┘└┘└  ┴ ┴┘└┘ ┴ ┴└─ ┴   ┴ ┴└─┘└─┘└─┘┴─┘└─┘└─┘
	infantry_muzzle_attachments = function(default)
		local attachments = {
			{id = "muzzle_01", name = "Infantry Autogun (01)"},
			{id = "muzzle_02", name = "Infantry Autogun (02)"},
			{id = "muzzle_03", name = "Infantry Autogun (03)"},
			{id = "muzzle_04", name = "Infantry Autogun (04)"},
			{id = "muzzle_05", name = "Infantry Autogun (05)"},
			{id = "muzzle_17", name = "Infantry Autogun (17)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "muzzle_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	infantry_muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "muzzle_default",	model = ""},
			{name = "muzzle_01",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_01"},
			{name = "muzzle_02",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_02"},
			{name = "muzzle_03",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_03"},
			{name = "muzzle_04",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_04"},
			{name = "muzzle_05",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_05"},
			{name = "muzzle_17",		model = _item_ranged.."/muzzles/autogun_rifle_muzzle_ml01"},
		}, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┬─┐┌─┐┌─┐┌─┐┌┬┐  ┌┬┐┬ ┬┌─┐┌─┐┬  ┌─┐┌─┐
	-- ##### ├┴┐├┬┘├─┤│  ├┤  ││  ││││ │┌─┘┌─┘│  ├┤ └─┐
	-- ##### └─┘┴└─┴ ┴└─┘└─┘─┴┘  ┴ ┴└─┘└─┘└─┘┴─┘└─┘└─┘
	braced_muzzle_attachments = function(default)
		local attachments = {
			{id = "muzzle_06", name = "Braced Autogun (06)"},
			{id = "muzzle_07", name = "Braced Autogun (07)"},
			{id = "muzzle_08", name = "Braced Autogun (08)"},
			{id = "muzzle_11", name = "Braced Autogun (11)"},
			{id = "muzzle_12", name = "Braced Autogun (12)"},
			{id = "muzzle_15", name = "Braced Autogun (15)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "muzzle_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	braced_muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "muzzle_default",	model = ""},
			{name = "muzzle_06",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_01"},
			{name = "muzzle_07",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_02"},
			{name = "muzzle_08",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_03"},
			{name = "muzzle_11",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_04"},
			{name = "muzzle_12",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_05"},
			{name = "muzzle_15",		model = _item_ranged.."/muzzles/autogun_rifle_ak_muzzle_ml01"},
		}, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬ ┬┌─┐┌─┐┌┬┐┬ ┬┬ ┬┌┐┌┌┬┐┌─┐┬─┐  ┌┬┐┬ ┬┌─┐┌─┐┬  ┌─┐┌─┐
	-- ##### ├─┤├┤ ├─┤ ││├─┤│ ││││ │ ├┤ ├┬┘  ││││ │┌─┘┌─┘│  ├┤ └─┐
	-- ##### ┴ ┴└─┘┴ ┴─┴┘┴ ┴└─┘┘└┘ ┴ └─┘┴└─  ┴ ┴└─┘└─┘└─┘┴─┘└─┘└─┘
	headhunter_muzzle_attachments = function(default)
		local attachments = {
			{id = "muzzle_09", name = "Headhunter Autogun (09)"},
			{id = "muzzle_10", name = "Headhunter Autogun (10)"},
			{id = "muzzle_13", name = "Headhunter Autogun (13)"},
			{id = "muzzle_14", name = "Headhunter Autogun (14)"},
			{id = "muzzle_16", name = "Headhunter Autogun (16)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "muzzle_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	headhunter_muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "muzzle_default",	model = ""},
			{name = "muzzle_09",		model = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_01"},
			{name = "muzzle_10",		model = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_03"},
			{name = "muzzle_13",		model = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_04"},
			{name = "muzzle_14",		model = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_05"},
			{name = "muzzle_16",		model = _item_ranged.."/muzzles/autogun_rifle_killshot_muzzle_ml01"},
		}, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┌─┐┌─┐┌─┐┌─┐┬┌┐┌┌─┐┌─┐
	-- ##### │││├─┤│ ┬├─┤┌─┘││││├┤ └─┐
	-- ##### ┴ ┴┴ ┴└─┘┴ ┴└─┘┴┘└┘└─┘└─┘
	magazine_attachments = function(default)
		local attachments = {
			{id = "magazine_01", name = "Autogun (01)"},
			{id = "magazine_02", name = "Autogun (02)"},
			{id = "magazine_03", name = "Autogun (03)"},
			{id = "magazine_04", name = "Braced Autogun (04)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "magazine_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "magazine_default", model = ""},
			{name = "magazine_01",		model = _item_ranged.."/magazines/autogun_rifle_magazine_01"},
			{name = "magazine_02",		model = _item_ranged.."/magazines/autogun_rifle_magazine_02"},
			{name = "magazine_03",		model = _item_ranged.."/magazines/autogun_rifle_magazine_03"},
			{name = "magazine_04",		model = _item_ranged.."/magazines/autogun_rifle_ak_magazine_01"},
		}, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬┌┐┌┌─┐┌─┐┌┐┌┌┬┐┬─┐┬ ┬  ┬─┐┌─┐┌─┐┌─┐┬┬  ┬┌─┐┬─┐
	-- ##### ││││├┤ ├─┤│││ │ ├┬┘└┬┘  ├┬┘├┤ │  ├┤ │└┐┌┘├┤ ├┬┘
	-- ##### ┴┘└┘└  ┴ ┴┘└┘ ┴ ┴└─ ┴   ┴└─└─┘└─┘└─┘┴ └┘ └─┘┴└─
	infantry_receiver_attachments = function(default)
		local attachments = {
			{id = "receiver_01", name = "Infantry Autogun (01)"},
			{id = "receiver_10", name = "Infantry Autogun (10)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "receiver_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	infantry_receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "receiver_default", model = ""},
			{name = "receiver_01",		model = _item_ranged.."/recievers/autogun_rifle_receiver_01"},
			{name = "receiver_10",		model = _item_ranged.."/recievers/autogun_rifle_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┬─┐┌─┐┌─┐┌─┐┌┬┐  ┬─┐┌─┐┌─┐┌─┐┬┬  ┬┌─┐┬─┐
	-- ##### ├┴┐├┬┘├─┤│  ├┤  ││  ├┬┘├┤ │  ├┤ │└┐┌┘├┤ ├┬┘
	-- ##### └─┘┴└─┴ ┴└─┘└─┘─┴┘  ┴└─└─┘└─┘└─┘┴ └┘ └─┘┴└─
	braced_receiver_attachments = function(default)
		local attachments = {
			{id = "receiver_03", name = "Braced Autogun (03)"},
			{id = "receiver_06", name = "Braced Autogun (06)"},
			{id = "receiver_07", name = "Braced Autogun (07)"},
			{id = "receiver_08", name = "Braced Autogun (08)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "receiver_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	braced_receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "receiver_default", model = ""},
			{name = "receiver_03",		model = _item_ranged.."/recievers/autogun_rifle_ak_receiver_01"},
			{name = "receiver_06",		model = _item_ranged.."/recievers/autogun_rifle_ak_receiver_02"},
			{name = "receiver_07",		model = _item_ranged.."/recievers/autogun_rifle_ak_receiver_03"},
			{name = "receiver_08",		model = _item_ranged.."/recievers/autogun_rifle_ak_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬ ┬┌─┐┌─┐┌┬┐┬ ┬┬ ┬┌┐┌┌┬┐┌─┐┬─┐  ┬─┐┌─┐┌─┐┌─┐┬┬  ┬┌─┐┬─┐
	-- ##### ├─┤├┤ ├─┤ ││├─┤│ ││││ │ ├┤ ├┬┘  ├┬┘├┤ │  ├┤ │└┐┌┘├┤ ├┬┘
	-- ##### ┴ ┴└─┘┴ ┴─┴┘┴ ┴└─┘┘└┘ ┴ └─┘┴└─  ┴└─└─┘└─┘└─┘┴ └┘ └─┘┴└─
	headhunter_receiver_attachments = function(default)
		local attachments = {
			{id = "receiver_02", name = "Headhunter Autogun (02)"},
			{id = "receiver_04", name = "Headhunter Autogun (04)"},
			{id = "receiver_05", name = "Headhunter Autogun (05)"},
			{id = "receiver_09", name = "Headhunter Autogun (09)"},
			{id = "receiver_11", name = "Headhunter Autogun (11)"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "receiver_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	headhunter_receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "receiver_default", model = ""},
			{name = "receiver_02",		model = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_01"},
			{name = "receiver_04",		model = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_02"},
			{name = "receiver_05",		model = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_03"},
			{name = "receiver_11",		model = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_04"},
			{name = "receiver_09",		model = _item_ranged.."/recievers/autogun_rifle_killshot_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}

return table_merge_recursive(functions, {
	-- ##### ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	barrel_attachments = function(default)
		return table_icombine(
			functions.infantry_barrel_attachments(default),
			functions.braced_barrel_attachments(false),
			functions.headhunter_barrel_attachments(false)
		)
	end,
	barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    return table_combine(
	        functions.infantry_barrel_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.braced_barrel_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.headhunter_barrel_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    )
	end,
	-- ##### ┌┬┐┬ ┬┌─┐┌─┐┬  ┌─┐┌─┐
	-- ##### ││││ │┌─┘┌─┘│  ├┤ └─┐
	-- ##### ┴ ┴└─┘└─┘└─┘┴─┘└─┘└─┘
	muzzle_attachments = function(default)
		return table_icombine(
			functions.infantry_muzzle_attachments(default),
			functions.braced_muzzle_attachments(false),
			functions.headhunter_muzzle_attachments(false)
		)
	end,
	muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    return table_combine(
	        functions.infantry_muzzle_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.braced_muzzle_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.headhunter_muzzle_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    )
	end,
	-- ##### ┬─┐┌─┐┌─┐┌─┐┬┬  ┬┌─┐┬─┐
	-- ##### ├┬┘├┤ │  ├┤ │└┐┌┘├┤ ├┬┘
	-- ##### ┴└─└─┘└─┘└─┘┴ └┘ └─┘┴└─
	receiver_attachments = function(default)
		return table_icombine(
			functions.infantry_receiver_attachments(default),
			functions.braced_receiver_attachments(false),
			functions.headhunter_receiver_attachments(false)
		)
	end,
	receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    return table_combine(
	        functions.infantry_receiver_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.braced_receiver_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve),
	        functions.headhunter_receiver_models(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	    )
	end,
})