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
			{id = "bolt_pistol_receiver_01", name = "Boltpistol 1"},
			{id = "bolt_pistol_receiver_02", name = "Boltpistol 2"},
			{id = "bolt_pistol_receiver_03", name = "Boltpistol 3"},
			{id = "bolt_pistol_receiver_04", name = "Boltpistol 4"},
			{id = "bolt_pistol_receiver_05", name = "Boltpistol 5"},
			{id = "bolt_pistol_receiver_06", name = "Boltpistol 6"},
			{id = "bolt_pistol_receiver_07", name = "Boltpistol 7"},
			{id = "bolt_pistol_receiver_08", name = "Boltpistol 8"},
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
			{name = "receiver_default",		   model = ""},
			{name = "bolt_pistol_receiver_01", model = _item_ranged.."/recievers/boltgun_pistol_receiver_01"},
			{name = "bolt_pistol_receiver_02", model = _item_ranged.."/recievers/boltgun_pistol_receiver_02"},
			{name = "bolt_pistol_receiver_03", model = _item_ranged.."/recievers/boltgun_pistol_receiver_03"},
			{name = "bolt_pistol_receiver_04", model = _item_ranged.."/recievers/boltgun_pistol_receiver_04"}, -- buggy
			{name = "bolt_pistol_receiver_05", model = _item_ranged.."/recievers/boltgun_pistol_receiver_05"},
			{name = "bolt_pistol_receiver_06", model = _item_ranged.."/recievers/boltgun_pistol_receiver_06"},
			{name = "bolt_pistol_receiver_07", model = _item_ranged.."/recievers/boltgun_pistol_receiver_07"},
			{name = "bolt_pistol_receiver_08", model = _item_ranged.."/recievers/boltgun_pistol_receiver_ml01"},
		}, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┌─┐┌─┐┌─┐┌─┐┬┌┐┌┌─┐┌─┐
	-- ##### │││├─┤│ ┬├─┤┌─┘││││├┤ └─┐
	-- ##### ┴ ┴┴ ┴└─┘┴ ┴└─┘┴┘└┘└─┘└─┘
	magazine_attachments = function(default)
		local attachments = {
			{id = "bolt_pistol_magazine_01", name = "Boltpistol 1"},
			{id = "bolt_pistol_magazine_02", name = "Boltpistol 2"},
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
			{name = "magazine_default",		   model = ""},
			{name = "bolt_pistol_magazine_01", model = _item_ranged.."/magazines/boltgun_pistol_magazine_01"},
			{name = "bolt_pistol_magazine_02", model = _item_ranged.."/magazines/boltgun_pistol_magazine_02"},
		}, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┌─┐┬─┐┬─┐┌─┐┬  ┌─┐
	-- ##### ├┴┐├─┤├┬┘├┬┘├┤ │  └─┐
	-- ##### └─┘┴ ┴┴└─┴└─└─┘┴─┘└─┘
	barrel_attachments = function(default)
		local attachments = {
			{id = "bolt_pistol_barrel_01", name = "Boltpistol 1"},
			{id = "bolt_pistol_barrel_02", name = "Boltpistol 2"},
			{id = "bolt_pistol_barrel_03", name = "Boltpistol 3"},
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
			{name = "barrel_default",		 model = ""},
			{name = "bolt_pistol_barrel_01", model = _item_ranged.."/barrels/boltgun_pistol_barrel_01"},
			{name = "bolt_pistol_barrel_02", model = _item_ranged.."/barrels/boltgun_pistol_barrel_02"},
			{name = "bolt_pistol_barrel_03", model = _item_ranged.."/barrels/boltgun_pistol_barrel_03"},
		}, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌─┐┬┌─┐┬ ┬┌┬┐┌─┐
	-- ##### └─┐││ ┬├─┤ │ └─┐
	-- ##### └─┘┴└─┘┴ ┴ ┴ └─┘
	sight_attachments = function(default)
		local attachments = {
			{id = "bolt_pistol_sight_01", name = "Boltpistol 1"},
			{id = "bolt_pistol_sight_02", name = "Boltpistol 2"},
			{id = "bolt_pistol_sight_03", name = "Boltpistol 3"},
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
			{name = "sight_default",		model = ""},
			{name = "bolt_pistol_sight_01",	model = _item_ranged.."/sights/boltgun_pistol_sight_01"},
			{name = "bolt_pistol_sight_02",	model = _item_ranged.."/sights/boltgun_pistol_sight_02"},
			{name = "bolt_pistol_sight_03",	model = _item_ranged.."/sights/boltgun_pistol_sight_03"},
		}, parent, angle, move, remove, type or "sight", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}