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
	local table_icombine = table.icombine
	local table_model_table = table.model_table
--#endregion

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

return {
	-- ##### ┬─┐┌─┐┌─┐┌─┐┬┬  ┬┌─┐┬─┐┌─┐
	-- ##### ├┬┘├┤ │  ├┤ │└┐┌┘├┤ ├┬┘└─┐
	-- ##### ┴└─└─┘└─┘└─┘┴ └┘ └─┘┴└─└─┘
	receiver_attachments = function(default)
		local attachments = {
			{id = "receiver_01", name = "Bolter 1"},
			{id = "receiver_02", name = "Bolter 2"},
			{id = "receiver_03", name = "Bolter 3"},
			{id = "receiver_04", name = "Bolter 4"},
			{id = "receiver_05", name = "Bolter 5"},
			{id = "receiver_06", name = "Bolter 6"},
			{id = "receiver_07", name = "Bolter 7"},
			{id = "receiver_08", name = "Bolter 8"},
			{id = "receiver_09", name = "Bolter 9"},
			{id = "receiver_10", name = "Bolter 10"},
		}
		if default == nil then default = true end
		if default then return table_icombine(
			{{id = "receiver_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "receiver_default", model = ""},
			{name = "receiver_01",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_01"},
			{name = "receiver_02",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_02"},
			{name = "receiver_03",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_03"},
			{name = "receiver_04",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_04"},
			{name = "receiver_05",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_05"},
			{name = "receiver_06",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_06"},
			{name = "receiver_07",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_07"},
			{name = "receiver_08",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_08"},
			{name = "receiver_09",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_09"},
			{name = "receiver_10",		model = _item_ranged.."/recievers/boltgun_rifle_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┌─┐┌─┐┌─┐┌─┐┬┌┐┌┌─┐┌─┐
	-- ##### │││├─┤│ ┬├─┤┌─┘││││├┤ └─┐
	-- ##### ┴ ┴┴ ┴└─┘┴ ┴└─┘┴┘└┘└─┘└─┘
	magazine_attachments = function(default)
		local attachments = {
			{id = "bolter_magazine_01", name = "Bolter 1"},
			{id = "bolter_magazine_02", name = "Bolter 2"},
		}
		if default == nil then default = true end
		if default then return table_icombine(
			{{id = "magazine_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "magazine_default", 	model = ""},
			{name = "bolter_magazine_01",	model = _item_ranged.."/magazines/boltgun_rifle_magazine_01"},
			{name = "bolter_magazine_02",	model = _item_ranged.."/magazines/boltgun_rifle_magazine_02"},
		}, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	barrel_attachments = function(default)
		local attachments = {
			{id = "bolter_barrel_01", name = "Bolter 1"},
			{id = "bolter_barrel_02", name = "Bolter 2"},
			{id = "bolter_barrel_03", name = "Bolter 3"},
			{id = "bolter_barrel_04", name = "Bolter 4"},
		}
		if default == nil then default = true end
		if default then return table_icombine(
			{{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "barrel_default",	model = ""},
			{name = "bolter_barrel_01",	model = _item_ranged.."/barrels/boltgun_rifle_barrel_01"},
			{name = "bolter_barrel_02",	model = _item_ranged.."/barrels/boltgun_rifle_barrel_02"},
			{name = "bolter_barrel_03",	model = _item_ranged.."/barrels/boltgun_rifle_barrel_03"},
			{name = "bolter_barrel_04",	model = _item_ranged.."/barrels/boltgun_rifle_barrel_04"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┬ ┬┌┐┌┌┬┐┌─┐┬─┐┌┐ ┌─┐┬─┐┬─┐┌─┐┬  
	-- ##### │ ││││ ││├┤ ├┬┘├┴┐├─┤├┬┘├┬┘├┤ │  
	-- ##### └─┘┘└┘─┴┘└─┘┴└─└─┘┴ ┴┴└─┴└─└─┘┴─┘
	underbarrel_attachments = function(default)
		local attachments = {
			{id = "underbarrel_01", name = "Bolter 1"},
			{id = "underbarrel_02", name = "Bolter 2"},
			{id = "underbarrel_03", name = "Bolter 3"},
			{id = "underbarrel_04", name = "Bolter 4"},
			{id = "underbarrel_05", name = "Bolter 5"},
			{id = "underbarrel_06", name = "Bolter 6"},
			{id = "underbarrel_07", name = "Bolter 7"},
		}
		if default == nil then default = true end
		if default then return table_icombine(
			{{id = "underbarrel_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	underbarrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "underbarrel_default",	model = ""},
			{name = "underbarrel_01",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_01"},
			{name = "underbarrel_02",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_02"},
			{name = "underbarrel_03",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_03"},
			{name = "underbarrel_04",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_04"},
			{name = "underbarrel_05",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_05"},
			{name = "underbarrel_06",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_06"},
			{name = "underbarrel_07",		model = _item_ranged.."/underbarrels/boltgun_rifle_underbarrel_ml01"},
			{name = "no_underbarrel",		model = ""},
		}, parent, angle, move, remove, type or "underbarrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐
	-- ##### └─┐││ ┬├─┤ │ └─┐
	-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘
	sight_attachments = function(default)
		local attachments = {
			{id = "bolter_sight_01", name = "Bolter 1"},
			{id = "bolter_sight_02", name = "Bolter 2"},
		}
		if default == nil then default = true end
		if default then return table_icombine(
			{{id = "sight_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "sight_default",	model = ""},
			{name = "bolter_sight_01",	model = _item_ranged.."/sights/boltgun_rifle_sight_01"},
			{name = "bolter_sight_02",	model = _item_ranged.."/sights/boltgun_rifle_sight_02"},
		}, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}