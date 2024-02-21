local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local _item = "content/items/weapons/player"
	local _item_ranged = _item.."/ranged"
	local _item_melee = _item.."/melee"
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
	-- ##### ┌─┐┬─┐┬┌─┐┌─┐
	-- ##### │ ┬├┬┘│├─┘└─┐
	-- ##### └─┘┴└─┴┴  └─┘
	grip_attachments = function(default)
		local attachments = {
			{id = "chain_axe_grip_01", name = "Grip 1"},
			{id = "chain_axe_grip_02", name = "Grip 2"},
			{id = "chain_axe_grip_03", name = "Grip 3"},
			{id = "chain_axe_grip_04", name = "Grip 4"},
			{id = "chain_axe_grip_05", name = "Grip 5"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "chain_axe_grip_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "chain_axe_grip_default",	model = ""},
			{name = "chain_axe_grip_01",		model = _item_melee.."/grips/chain_axe_grip_01"},
			{name = "chain_axe_grip_02",		model = _item_melee.."/grips/chain_axe_grip_02"},
			{name = "chain_axe_grip_03",		model = _item_melee.."/grips/chain_axe_grip_03"},
			{name = "chain_axe_grip_04",		model = _item_melee.."/grips/chain_axe_grip_04"},
			{name = "chain_axe_grip_05",		model = _item_melee.."/grips/chain_axe_grip_05"},
		}, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌─┐┬ ┬┌─┐┌─┐┌┬┐┌─┐
	-- ##### └─┐├─┤├─┤├┤  │ └─┐
	-- ##### └─┘┴ ┴┴ ┴└   ┴ └─┘
	shaft_attachments = function(default)
		local attachments = {
			{id = "chain_axe_shaft_01", name = "Shaft 1"},
			{id = "chain_axe_shaft_02", name = "Shaft 2"},
			{id = "chain_axe_shaft_03", name = "Shaft 3"},
			{id = "chain_axe_shaft_04", name = "Shaft 4"},
			{id = "chain_axe_shaft_05", name = "Shaft 5"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "chain_axe_shaft_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "chain_axe_shaft_default",	model = ""},
			{name = "chain_axe_shaft_01",		model = _item_ranged.."/shafts/chain_axe_shaft_01"},
			{name = "chain_axe_shaft_02",		model = _item_ranged.."/shafts/chain_axe_shaft_02"},
			{name = "chain_axe_shaft_03",		model = _item_ranged.."/shafts/chain_axe_shaft_03"},
			{name = "chain_axe_shaft_04",		model = _item_ranged.."/shafts/chain_axe_shaft_04"},
			{name = "chain_axe_shaft_05",		model = _item_ranged.."/shafts/chain_axe_shaft_05"},
		}, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┬  ┌─┐┌┬┐┌─┐┌─┐
	-- ##### ├┴┐│  ├─┤ ││├┤ └─┐
	-- ##### └─┘┴─┘┴ ┴─┴┘└─┘└─┘
	blade_attachments = function(default)
		local attachments = {
			{id = "chain_axe_blade_01", name = "Blade 1"},
			{id = "chain_axe_blade_02", name = "Blade 2"},
			{id = "chain_axe_blade_03", name = "Blade 3"},
			{id = "chain_axe_blade_04", name = "Blade 4"},
			{id = "chain_axe_blade_05", name = "Blade 5"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "chain_axe_blade_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "chain_axe_blade_default",	model = ""},
			{name = "chain_axe_blade_01",		model = _item_melee.."/blades/chain_axe_blade_01"},
			{name = "chain_axe_blade_02",		model = _item_melee.."/blades/chain_axe_blade_02"},
			{name = "chain_axe_blade_03",		model = _item_melee.."/blades/chain_axe_blade_03"},
			{name = "chain_axe_blade_04",		model = _item_melee.."/blades/chain_axe_blade_04"},
			{name = "chain_axe_blade_05",		model = _item_melee.."/blades/chain_axe_blade_05"},
		}, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┬┐┌─┐┌─┐┌┬┐┬ ┬
	-- #####  │ ├┤ ├┤  │ ├─┤
	-- #####  ┴ └─┘└─┘ ┴ ┴ ┴
	teeth_attachments = function(default)
		local attachments = {
			{id = "chain_axe_teeth_01", name = "Chain 1"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "chain_axe_teeth_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	teeth_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "chain_axe_teeth_default",	model = ""},
			{name = "chain_axe_teeth_01",		model = _item_melee.."/chains/chain_axe_chain_01"},
		}, parent, angle, move, remove, type or "teeth", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}