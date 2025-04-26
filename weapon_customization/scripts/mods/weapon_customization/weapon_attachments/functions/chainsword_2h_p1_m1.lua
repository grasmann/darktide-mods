local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local _item = "content/items/weapons/player"
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
			{id = "2h_chain_sword_grip_01", name = "2H Chain Sword 1"},
			{id = "2h_chain_sword_grip_02", name = "2H Chain Sword 2"},
			{id = "2h_chain_sword_grip_03", name = "2H Chain Sword 3"},
			{id = "2h_chain_sword_grip_04", name = "2H Chain Sword 4"},
			{id = "2h_chain_sword_grip_ml01", name = "2H Chain Sword 5"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "grip_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "grip_default",			  model = ""},
			{name = "2h_chain_sword_grip_01", model = _item_melee.."/grips/2h_chain_sword_grip_01"},
			{name = "2h_chain_sword_grip_02", model = _item_melee.."/grips/2h_chain_sword_grip_02"},
			{name = "2h_chain_sword_grip_03", model = _item_melee.."/grips/2h_chain_sword_grip_03"},
			{name = "2h_chain_sword_grip_04", model = _item_melee.."/grips/2h_chain_sword_grip_04"},
			{name = "2h_chain_sword_grip_ml01", model = _item_melee.."/grips/2h_chain_sword_grip_ml01"},
		}, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌┐ ┌─┐┌┬┐┬┌─┐┌─┐
	-- ##### ├┴┐│ │ │││├┤ └─┐
	-- ##### └─┘└─┘─┴┘┴└─┘└─┘
	body_attachments = function(default)
		local attachments = {
			{id = "2h_chain_sword_body_01", name = "2H Chain Sword 1"},
			{id = "2h_chain_sword_body_02", name = "2H Chain Sword 2"},
			{id = "2h_chain_sword_body_03", name = "2H Chain Sword 3"},
			{id = "2h_chain_sword_body_04", name = "2H Chain Sword 4"},
			{id = "2h_chain_sword_body_06", name = "2H Chain Sword 6"},
			{id = "2h_chain_sword_body_07", name = "2H Chain Sword 7"},
			{id = "2h_chain_sword_body_ml01", name = "2H Chain Sword 8"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "body_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	body_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "body_default",			  model = ""},
			{name = "2h_chain_sword_body_01", model = _item_melee.."/full/2h_chain_sword_body_01"},
			{name = "2h_chain_sword_body_02", model = _item_melee.."/full/2h_chain_sword_body_02"},
			{name = "2h_chain_sword_body_03", model = _item_melee.."/full/2h_chain_sword_body_03"},
			{name = "2h_chain_sword_body_04", model = _item_melee.."/full/2h_chain_sword_body_04"},
			{name = "2h_chain_sword_body_06", model = _item_melee.."/full/2h_chain_sword_body_06"},
			{name = "2h_chain_sword_body_07", model = _item_melee.."/full/2h_chain_sword_body_07"},
			{name = "2h_chain_sword_body_ml01", model = _item_melee.."/full/2h_chain_sword_body_ml01"},
		}, parent, angle, move, remove, type or "body", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
	-- ##### ┌─┐┬ ┬┌─┐┬┌┐┌┌─┐
	-- ##### │  ├─┤├─┤││││└─┐
	-- ##### └─┘┴ ┴┴ ┴┴┘└┘└─┘
	chain_attachments = function(default)
		local attachments = {
			{id = "2h_chain_sword_chain_01", name = "2H Chain Sword 1"},
			{id = "2h_chain_sword_chain_02", name = "2H Chain Sword 2"},
		}
		if default == nil then default = true end
		if default then return table.icombine(
			{{id = "chain_default", name = mod:localize("mod_attachment_default")}},
			attachments)
		else return attachments end
	end,
	chain_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
		if mesh_move == nil then mesh_move = false end
		return table.model_table({
			{name = "chain_default",		   model = ""},
			{name = "2h_chain_sword_chain_01", model = _item_melee.."/chains/2h_chain_sword_chain_01"},
			{name = "2h_chain_sword_chain_02", model = _item_melee.."/chains/2h_chain_sword_chain_01_gold_01"},
		}, parent, angle, move, remove, type or "chain", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	end,
}