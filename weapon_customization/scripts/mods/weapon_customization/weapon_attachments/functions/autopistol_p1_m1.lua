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
			{id = "receiver_01",        name = "Receiver 1"},
			{id = "receiver_02",        name = "Receiver 2"},
			{id = "receiver_03",        name = "Receiver 3"},
			{id = "receiver_04",        name = "Receiver 4"},
			{id = "receiver_05",        name = "Receiver 2"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "receiver_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "receiver_default", model = ""},
			{name = "receiver_01",      model = _item_ranged.."/recievers/autogun_pistol_receiver_01"},
			{name = "receiver_05",      model = _item_ranged.."/recievers/autogun_pistol_receiver_05"},
			{name = "receiver_02",      model = _item_ranged.."/recievers/autogun_pistol_receiver_02"},
			{name = "receiver_03",      model = _item_ranged.."/recievers/autogun_pistol_receiver_03"},
			{name = "receiver_04",      model = _item_ranged.."/recievers/autogun_pistol_receiver_04"},
			{name = "receiver_06",      model = _item_ranged.."/recievers/autogun_pistol_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	barrel_attachments = function(default)
		local attachments = {
			{id = "barrel_01",      name = "Barrel 1"},
			{id = "barrel_02",      name = "Barrel 2"},
			{id = "barrel_03",      name = "Barrel 3"},
			{id = "barrel_04",      name = "Barrel 4"},
			{id = "barrel_05",      name = "Barrel 5"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "barrel_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "barrel_default", model = ""},
			{name = "barrel_01",      model = _item_ranged.."/barrels/autogun_pistol_barrel_01"},
			{name = "barrel_02",      model = _item_ranged.."/barrels/autogun_pistol_barrel_02"},
			{name = "barrel_03",      model = _item_ranged.."/barrels/autogun_pistol_barrel_03"},
			{name = "barrel_04",      model = _item_ranged.."/barrels/autogun_pistol_barrel_04"},
			{name = "barrel_05",      model = _item_ranged.."/barrels/autogun_pistol_barrel_05"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┌─┐┌─┐┌─┐┌─┐┬┌┐┌┌─┐┌─┐
	-- ##### │││├─┤│ ┬├─┤┌─┘││││├┤ └─┐
	-- ##### ┴ ┴┴ ┴└─┘┴ ┴└─┘┴┘└┘└─┘└─┘
	magazine_attachments = function(default)
		local attachments = {
			{id = "auto_pistol_magazine_01",        name = "Magazine 1"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "magazine_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "magazine_default",        model = ""},
			{name = "auto_pistol_magazine_01", model = _item_ranged.."/magazines/autogun_pistol_magazine_01"},
		}, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┬ ┬┌─┐┌─┐┬  ┌─┐┌─┐
	-- ##### ││││ │┌─┘┌─┘│  ├┤ └─┐
	-- ##### ┴ ┴└─┘└─┘└─┘┴─┘└─┘└─┘
	muzzle_attachments = function(default)
		local attachments = {
			{id = "muzzle_01",      name = "Autopistol 1"},
			{id = "muzzle_02",      name = "Autopistol 2"},
			{id = "muzzle_03",      name = "Autopistol 3"},
			{id = "muzzle_04",      name = "Autopistol 4"},
			{id = "muzzle_05",      name = "Autopistol 5"},
			{id = "muzzle_06",      name = "Autopistol 6"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "muzzle_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	muzzle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "muzzle_default", model = ""},
			{name = "muzzle_01",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_01"},
			{name = "muzzle_02",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_02"},
			{name = "muzzle_03",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_03"},
			{name = "muzzle_04",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_04"},
			{name = "muzzle_05",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_05"},
			{name = "muzzle_06",      model = _item_ranged.."/muzzles/autogun_pistol_muzzle_ml01"},
		}, parent, angle, move, remove, type or "muzzle", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐
	-- ##### └─┐││ ┬├─┤ │ └─┐
	-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘
	sight_attachments = function(default)
		local attachments = {
			{id = "sight_01",       name = "Sight 1"},
		}
		if default == nil then default = true end
		if default then return table_icombine({{id = "sight_default", name = mod:localize("mod_attachment_default")}}, attachments)
		else return attachments end
	end,
	sight_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table_model_table({
			{name = "sight_default", model = ""},
			{name = "sight_01",      model = _item_ranged.."/sights/autogun_pistol_sight_01"},
		}, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}