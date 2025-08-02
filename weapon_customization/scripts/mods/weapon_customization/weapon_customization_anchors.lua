local mod = get_mod("weapon_customization")

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"
local REFERENCE = "weapon_customization"

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table_size = table.size
	local ipairs = ipairs
	local pairs = pairs
	local type = type
	local string = string
	local string_find = string.find
	local vector3_box = Vector3Box
	local table_merge_recursive = table.merge_recursive
--#endregion

-- ##### ┌─┐┬ ┬┌─┐┌┬┐┌─┐┌┬┐  ┌┬┐┌─┐┌┐ ┬  ┌─┐  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ###############################################
-- ##### │  │ │└─┐ │ │ ││││   │ ├─┤├┴┐│  ├┤   ├┤ │ │││││   │ ││ ││││└─┐ ###############################################
-- ##### └─┘└─┘└─┘ ┴ └─┘┴ ┴   ┴ ┴ ┴└─┘┴─┘└─┘  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ###############################################

local index = 1
table.combine = function(...)
	local arg = {...}
	local combined = {}
	for _, t in ipairs(arg) do
		for name, value in pairs(t) do
			combined[name] = value
		end
	end
	return combined
end
table.icombine = function(...)
	local arg = {...}
	local combined = {}
	for _, t in ipairs(arg) do
		for _, value in pairs(t) do
			combined[#combined+1] = value
		end
	end
	return combined
end
table.tv = function(t, i)
	local res = nil
	if type(t) == "table" then
		if #t >= i then
			res = t[i]
		elseif #t >= 1 then
			res = t[1]
		else
			return nil
		end
	else
		res = t
	end
	if res == "" then
		return nil
	end
	return res
end
table.model_table = function(content, parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
	local angle = angle or 0
	local move = move or vector3_box(0, 0, 0)
	local remove = remove or vector3_box(0, 0, 0)
	local type = type or "none"
	local no_support = no_support or {}
	local automatic_equip = automatic_equip or {}
	local hide_mesh = hide_mesh or {}
	if mesh_move == nil then mesh_move = true end
	-- Build table
	local _table = {}
	local i = 1
	-- local this_index = start_index or index
	local table_tv = table.tv
	for _, content_line in pairs(content) do
		_table[content_line.name] = {
			model = content_line.model,
			data = content_line.data,
			type = table_tv(type, i),
			parent = table_tv(parent, i),
			angle = table_tv(angle, i),
			move = table_tv(move, i),
			remove = table_tv(remove, i),
			mesh_move = table_tv(mesh_move, i),
			no_support = table_tv(no_support, i),
			automatic_equip = table_tv(automatic_equip, i),
			hide_mesh = table_tv(hide_mesh, i),
			special_resolve = table_tv(special_resolve, i),
			original_mod = true,
			index = index,
			slot_index = i,
		}
		i = i + 1
		index = index + 1
		-- this_index = this_index + 1
	end
	return _table
end

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
	local table = table
--#endregion

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Load files
	local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
	local _ogryn_heavystubber_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_heavystubber_p1_m1")
	local _ogryn_heavystubber_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_heavystubber_p2_m1")
	local _ogryn_rippergun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_rippergun_p1_m1")
	local _ogryn_thumper_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_thumper_p1_m1")
	local _ogryn_gauntlet_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_gauntlet_p1_m1")
	local _ogryn_club_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_club_p1_m1")
	local _ogryn_combatblade_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_combatblade_p1_m1")
	local _ogryn_powermaul_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_powermaul_p1_m1")
	local _ogryn_powermaul_slabshield_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_powermaul_slabshield_p1_m1")
	local _ogryn_pickaxe_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_pickaxe_2h_p1_m1")
	local _ogryn_club_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_club_p2_m1")
	local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")
	local _lasgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p1_m1")
	local _lasgun_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p2_m1")
	local _lasgun_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_p3_m1")
	local _autogun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autogun_p1_m1")
	local _autopistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/autopistol_p1_m1")
	local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p1_m1")
	local _shotgun_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p2_m1")
	local _shotgun_p4_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p4_m1")
	local _bolter_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/bolter_p1_m1")
	local _boltpistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/boltpistol_p1_m1")
	local _stubrevolver_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/stubrevolver_p1_m1")
	local _plasmagun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/plasmagun_p1_m1")
	local _laspistol_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/laspistol_p1_m1")
	local _flamer_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/flamer_p1_m1")
	local _forcestaff_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/forcestaff_p1_m1")
	local _combataxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combataxe_p1_m1")
	local _combataxe_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combataxe_p2_m1")
	local _combatknife_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combatknife_p1_m1")
	local _powersword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powersword_p1_m1")
	local _powersword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powersword_2h_p1_m1")
	local _chainaxe_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/chainaxe_p1_m1")
	local _chainsword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/chainsword_p1_m1")
	local _combataxe_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combataxe_p3_m1")
	local _combatsword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combatsword_p1_m1")
	local _thunderhammer_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/thunderhammer_2h_p1_m1")
	local _powermaul_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powermaul_2h_p1_m1")
	local _powermaul_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powermaul_p1_m1")
	local _powermaul_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powermaul_p2_m1")
	local _powermaul_shield_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/powermaul_shield_p1_m1")
	local _chainsword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/chainsword_2h_p1_m1")
	local _combatsword_p2_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combatsword_p2_m1")
	local _forcesword_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/forcesword_p1_m1")
	local _forcesword_2h_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/forcesword_2h_p1_m1")
	local _combatsword_p3_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/combatsword_p3_m1")
--#endregion

--#region Anchors
	mod.anchors = {
		--#region Ogryn Guns
			ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.anchors,
			ogryn_heavystubber_p2_m1 = _ogryn_heavystubber_p2_m1.anchors,
			ogryn_rippergun_p1_m1    = _ogryn_rippergun_p1_m1.anchors,
			ogryn_thumper_p1_m1      = _ogryn_thumper_p1_m1.anchors,
			ogryn_gauntlet_p1_m1     = _ogryn_gauntlet_p1_m1.anchors,
		--#endregion
		--#region Ogryn Melee
			ogryn_club_p1_m1                 = _ogryn_club_p1_m1.anchors,
			ogryn_combatblade_p1_m1          = _ogryn_combatblade_p1_m1.anchors,
			ogryn_powermaul_p1_m1            = _ogryn_powermaul_p1_m1.anchors,
			ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.anchors,
			ogryn_pickaxe_2h_p1_m1           = _ogryn_pickaxe_2h_p1_m1.anchors,
			ogryn_club_p2_m1                 = _ogryn_club_p2_m1.anchors,
		--#endregion
		--#region Guns
			autopistol_p1_m1   = _autopistol_p1_m1.anchors,
			shotgun_p1_m1      = _shotgun_p1_m1.anchors,
			shotgun_p2_m1      = _shotgun_p2_m1.anchors,
			shotgun_p4_m1      = _shotgun_p4_m1.anchors,
			bolter_p1_m1       = _bolter_p1_m1.anchors,
			boltpistol_p1_m1   = _boltpistol_p1_m1.anchors,
			stubrevolver_p1_m1 = _stubrevolver_p1_m1.anchors,
			plasmagun_p1_m1    = _plasmagun_p1_m1.anchors,
			laspistol_p1_m1    = _laspistol_p1_m1.anchors,
			autogun_p1_m1      = _autogun_p1_m1.anchors,
			lasgun_p1_m1       = _lasgun_p1_m1.anchors,
			lasgun_p2_m1       = _lasgun_p2_m1.anchors,
			lasgun_p3_m1       = _lasgun_p3_m1.anchors,
			flamer_p1_m1       = _flamer_p1_m1.anchors,
			forcestaff_p1_m1   = _forcestaff_p1_m1.anchors,
		--#endregion
		--#region Melee
			combataxe_p1_m1        = _combataxe_p1_m1.anchors,
			combataxe_p2_m1        = _combataxe_p2_m1.anchors,
			combatknife_p1_m1      = _combatknife_p1_m1.anchors,
			powersword_p1_m1       = _powersword_p1_m1.anchors,
			powersword_2h_p1_m1    = _powersword_2h_p1_m1.anchors,
			chainaxe_p1_m1         = _chainaxe_p1_m1.anchors,
			chainsword_p1_m1       = _chainsword_p1_m1.anchors,
			combataxe_p3_m1        = _combataxe_p3_m1.anchors,
			combatsword_p1_m1      = _combatsword_p1_m1.anchors,
			thunderhammer_2h_p1_m1 = _thunderhammer_2h_p1_m1.anchors,
			powermaul_2h_p1_m1     = _powermaul_2h_p1_m1.anchors,
			powermaul_p1_m1        = _powermaul_p1_m1.anchors,
			powermaul_p2_m1        = _powermaul_p2_m1.anchors,
			powermaul_shield_p1_m1 = _powermaul_shield_p1_m1.anchors,
			chainsword_2h_p1_m1    = _chainsword_2h_p1_m1.anchors,
			combatsword_p2_m1      = _combatsword_p2_m1.anchors,
			forcesword_p1_m1       = _forcesword_p1_m1.anchors,
			forcesword_2h_p1_m1    = _forcesword_2h_p1_m1.anchors,
			combatsword_p3_m1      = _combatsword_p3_m1.anchors,
		--#endregion
	}
	--#region Copies
		--#region Ogryn Guns
			mod.anchors.ogryn_heavystubber_p1_m2 = mod.anchors.ogryn_heavystubber_p1_m1
			mod.anchors.ogryn_heavystubber_p1_m3 = mod.anchors.ogryn_heavystubber_p1_m1
			mod.anchors.ogryn_heavystubber_p2_m2 = mod.anchors.ogryn_heavystubber_p2_m1
			mod.anchors.ogryn_heavystubber_p2_m3 = mod.anchors.ogryn_heavystubber_p2_m1
			mod.anchors.ogryn_rippergun_p1_m2    = mod.anchors.ogryn_rippergun_p1_m1
			mod.anchors.ogryn_rippergun_p1_m3    = mod.anchors.ogryn_rippergun_p1_m1
				-- mod.anchors.ogryn_rippergun_npc_01 = mod.anchors.ogryn_rippergun_p1_m1
			mod.anchors.ogryn_thumper_p1_m2      = mod.anchors.ogryn_thumper_p1_m1
				-- mod.anchors.ogryn_thumper_npc_01 = mod.anchors.ogryn_thumper_p1_m1
				-- mod.anchors.ogryn_gauntlet_npc_01 = mod.anchors.ogryn_gauntlet_p1_m1
		--#endregion
		--#region Ogryn Melee
			mod.anchors.ogryn_club_p1_m2        = mod.anchors.ogryn_club_p1_m1
			mod.anchors.ogryn_club_p1_m3        = mod.anchors.ogryn_club_p1_m1
			mod.anchors.ogryn_combatblade_p1_m2 = mod.anchors.ogryn_combatblade_p1_m1
			mod.anchors.ogryn_combatblade_p1_m3 = mod.anchors.ogryn_combatblade_p1_m1
				-- mod.anchors.ogryn_combatblade_npc_01 = mod.anchors.ogryn_combatblade_p1_m1
				-- mod.anchors.ogryn_powermaul_slabshield_npc_01 = mod.anchors.ogryn_powermaul_slabshield_p1_m1
				mod.anchors.ogryn_powermaul_slabshield_p1_04 = mod.anchors.ogryn_powermaul_slabshield_p1_m1
			mod.anchors.ogryn_pickaxe_2h_p1_m2   = mod.anchors.ogryn_pickaxe_2h_p1_m1
			mod.anchors.ogryn_pickaxe_2h_p1_m3   = mod.anchors.ogryn_pickaxe_2h_p1_m1
			mod.anchors.ogryn_powermaul_p1_m2   = mod.anchors.ogryn_powermaul_p1_m1
			mod.anchors.ogryn_powermaul_p1_m3   = mod.anchors.ogryn_powermaul_p1_m1
			mod.anchors.ogryn_club_p2_m2        = mod.anchors.ogryn_club_p2_m1
			mod.anchors.ogryn_club_p2_m3        = mod.anchors.ogryn_club_p2_m1
		--#endregion
		--#region Guns
			mod.anchors.stubrevolver_p1_m2 = mod.anchors.stubrevolver_p1_m1
			mod.anchors.shotgun_p1_m2      = mod.anchors.shotgun_p1_m1
			mod.anchors.shotgun_p1_m3      = mod.anchors.shotgun_p1_m1
			mod.anchors.shotgun_p4_m2      = mod.anchors.shotgun_p4_m1
			mod.anchors.shotgun_p4_m3      = mod.anchors.shotgun_p4_m1
			mod.anchors.bolter_p1_m2       = mod.anchors.bolter_p1_m1
			mod.anchors.bolter_p1_m3       = mod.anchors.bolter_p1_m1
			mod.anchors.laspistol_p1_m2    = mod.anchors.laspistol_p1_m1
			mod.anchors.laspistol_p1_m3    = mod.anchors.laspistol_p1_m1
				-- mod.anchors.laspistol_npc_01 = mod.anchors.laspistol_p1_m1
			mod.anchors.autogun_p1_m2      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p1_m3      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p2_m1      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p2_m2      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p2_m3      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p3_m1      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p3_m2      = mod.anchors.autogun_p1_m1
			mod.anchors.autogun_p3_m3      = mod.anchors.autogun_p1_m1
				-- mod.anchors.autogun_npc_01 = mod.anchors.autogun_p1_m1
				-- mod.anchors.autogun_npc_02 = mod.anchors.autogun_p1_m1
				-- mod.anchors.autogun_npc_03 = mod.anchors.autogun_p1_m1
				-- mod.anchors.autogun_npc_04 = mod.anchors.autogun_p1_m1
				-- mod.anchors.autogun_npc_05 = mod.anchors.autogun_p1_m1
			mod.anchors.lasgun_p1_m2       = mod.anchors.lasgun_p1_m1
			mod.anchors.lasgun_p1_m3       = mod.anchors.lasgun_p1_m1
			mod.anchors.lasgun_p2_m2       = mod.anchors.lasgun_p2_m1
			mod.anchors.lasgun_p2_m3       = mod.anchors.lasgun_p2_m1
			mod.anchors.lasgun_p3_m2       = mod.anchors.lasgun_p3_m1
			mod.anchors.lasgun_p3_m3       = mod.anchors.lasgun_p3_m1
				-- mod.anchors.lasgun_npc_01 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.lasgun_npc_02 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.lasgun_npc_03 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.lasgun_npc_04 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.lasgun_npc_05 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.flamer_npc_01 = mod.anchors.flamer_p1_m1
				-- mod.anchors.renegade_lasgun_cinematic_01 = mod.anchors.lasgun_p1_m1
				-- mod.anchors.renegade_lasgun_cinematic_02 = mod.anchors.lasgun_p2_m1
				-- mod.anchors.renegade_lasgun_cinematic_03 = mod.anchors.lasgun_p3_m1
		--#endregion
		--#region Melee
			mod.anchors.combataxe_p1_m2        = mod.anchors.combataxe_p1_m1
			mod.anchors.combataxe_p1_m3        = mod.anchors.combataxe_p1_m1
			mod.anchors.combataxe_p2_m2        = mod.anchors.combataxe_p2_m1
			mod.anchors.combataxe_p2_m3        = mod.anchors.combataxe_p2_m1
			mod.anchors.combatknife_p1_m2      = mod.anchors.combatknife_p1_m1
			mod.anchors.combataxe_p3_m2        = mod.anchors.combataxe_p3_m1
			mod.anchors.combataxe_p3_m3        = mod.anchors.combataxe_p3_m1
			mod.anchors.chainaxe_p1_m2         = mod.anchors.chainaxe_p1_m1
			mod.anchors.chainsword_p1_m2       = mod.anchors.chainsword_p1_m1
				-- mod.anchors.chainsword_npc_01  = mod.anchors.chainsword_p1_m1
			mod.anchors.chainsword_2h_p1_m2    = mod.anchors.chainsword_2h_p1_m1
			mod.anchors.powersword_p1_m2       = mod.anchors.powersword_p1_m1
			mod.anchors.powersword_p1_m3       = mod.anchors.powersword_p1_m1
				-- mod.anchors.powersword_npc_01    = mod.anchors.powersword_p1_m1
				-- mod.anchors.powersword_2h_npc_01 = mod.anchors.powersword_p1_m1
			mod.anchors.powersword_2h_p1_m2    = mod.anchors.powersword_2h_p1_m1
			mod.anchors.combatsword_p1_m2      = mod.anchors.combatsword_p1_m1
			mod.anchors.combatsword_p1_m3      = mod.anchors.combatsword_p1_m1
			mod.anchors.thunderhammer_2h_p1_m2 = mod.anchors.thunderhammer_2h_p1_m1
			mod.anchors.combatsword_p2_m2      = mod.anchors.combatsword_p2_m1
			mod.anchors.combatsword_p2_m3      = mod.anchors.combatsword_p2_m1
			mod.anchors.forcesword_p1_m2       = mod.anchors.forcesword_p1_m1
			mod.anchors.forcesword_p1_m3       = mod.anchors.forcesword_p1_m1
				-- mod.anchors.forcesword_npc_01  = mod.anchors.forcesword_p1_m1
			mod.anchors.forcesword_2h_p1_m2    = mod.anchors.forcesword_2h_p1_m1
			mod.anchors.combatsword_p3_m2      = mod.anchors.combatsword_p3_m1
			mod.anchors.combatsword_p3_m3      = mod.anchors.combatsword_p3_m1
			mod.anchors.powermaul_p1_m2        = mod.anchors.powermaul_p1_m1
			mod.anchors.powermaul_shield_p1_m2 = mod.anchors.powermaul_shield_p1_m1
			-- mod.anchors.powermaul_p2_m2        = mod.anchors.powermaul_p2_m1
		--#endregion
	--#endregion
--#endregion

--#region Attachments
	mod.attachment = {
		--#region Ogryn Guns
			ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.attachments,
			ogryn_heavystubber_p2_m1 = _ogryn_heavystubber_p2_m1.attachments,
			ogryn_rippergun_p1_m1    = _ogryn_rippergun_p1_m1.attachments,
			ogryn_thumper_p1_m1      = _ogryn_thumper_p1_m1.attachments,
			ogryn_gauntlet_p1_m1     = _ogryn_gauntlet_p1_m1.attachments,
		--#endregion
		--#region Ogryn Melee
			ogryn_club_p1_m1                 = _ogryn_club_p1_m1.attachments,
			ogryn_combatblade_p1_m1          = _ogryn_combatblade_p1_m1.attachments,
			ogryn_powermaul_p1_m1            = _ogryn_powermaul_p1_m1.attachments,
			ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.attachments,
			ogryn_pickaxe_2h_p1_m1           = _ogryn_pickaxe_2h_p1_m1.attachments,
			ogryn_club_p2_m1                 = _ogryn_club_p2_m1.attachments,
		--#endregion
		--#region Guns
			autopistol_p1_m1   = _autopistol_p1_m1.attachments,
			shotgun_p1_m1      = _shotgun_p1_m1.attachments,
			shotgun_p2_m1      = _shotgun_p2_m1.attachments,
			shotgun_p4_m1      = _shotgun_p4_m1.attachments,
			bolter_p1_m1       = _bolter_p1_m1.attachments,
			boltpistol_p1_m1   = _boltpistol_p1_m1.attachments,
			stubrevolver_p1_m1 = _stubrevolver_p1_m1.attachments,
			plasmagun_p1_m1    = _plasmagun_p1_m1.attachments,
			laspistol_p1_m1    = _laspistol_p1_m1.attachments,
			autogun_p1_m1      = _autogun_p1_m1.attachments,
			lasgun_p1_m1       = _lasgun_p1_m1.attachments,
			lasgun_p2_m1       = _lasgun_p2_m1.attachments,
			lasgun_p3_m1       = _lasgun_p3_m1.attachments,
			flamer_p1_m1       = _flamer_p1_m1.attachments,
			forcestaff_p1_m1   = _forcestaff_p1_m1.attachments,
		--#endregion
		--#region Melee
			combataxe_p1_m1        = _combataxe_p1_m1.attachments,
			combataxe_p2_m1        = _combataxe_p2_m1.attachments,
			combatknife_p1_m1      = _combatknife_p1_m1.attachments,
			powersword_p1_m1       = _powersword_p1_m1.attachments,
			powersword_2h_p1_m1    = _powersword_2h_p1_m1.attachments,
			chainaxe_p1_m1         = _chainaxe_p1_m1.attachments,
			chainsword_p1_m1       = _chainsword_p1_m1.attachments,
			combataxe_p3_m1        = _combataxe_p3_m1.attachments,
			combatsword_p1_m1      = _combatsword_p1_m1.attachments,
			thunderhammer_2h_p1_m1 = _thunderhammer_2h_p1_m1.attachments,
			powermaul_2h_p1_m1     = _powermaul_2h_p1_m1.attachments,
			powermaul_p1_m1        = _powermaul_p1_m1.attachments,
			powermaul_p2_m1        = _powermaul_p2_m1.attachments,
			powermaul_shield_p1_m1 = _powermaul_shield_p1_m1.attachments,
			chainsword_2h_p1_m1    = _chainsword_2h_p1_m1.attachments,
			combatsword_p2_m1      = _combatsword_p2_m1.attachments,
			forcesword_p1_m1       = _forcesword_p1_m1.attachments,
			forcesword_2h_p1_m1    = _forcesword_2h_p1_m1.attachments,
			combatsword_p3_m1      = _combatsword_p3_m1.attachments,
		--#endregion
	}
	--#region Copies
		--#region Ogryn Guns
			mod.attachment.ogryn_heavystubber_p1_m2 = mod.attachment.ogryn_heavystubber_p1_m1
			mod.attachment.ogryn_heavystubber_p1_m3 = mod.attachment.ogryn_heavystubber_p1_m1
			mod.attachment.ogryn_heavystubber_p2_m2 = mod.attachment.ogryn_heavystubber_p2_m1
			mod.attachment.ogryn_heavystubber_p2_m3 = mod.attachment.ogryn_heavystubber_p2_m1
			mod.attachment.ogryn_rippergun_p1_m2 = mod.attachment.ogryn_rippergun_p1_m1
			mod.attachment.ogryn_rippergun_p1_m3 = mod.attachment.ogryn_rippergun_p1_m1
				-- mod.attachment.ogryn_rippergun_npc_01 = mod.attachment.ogryn_rippergun_p1_m1
			mod.attachment.ogryn_thumper_p1_m2 = mod.attachment.ogryn_thumper_p1_m1
				-- mod.attachment.ogryn_thumper_npc_01 = mod.attachment.ogryn_thumper_p1_m1
				-- mod.attachment.ogryn_gauntlet_npc_01 = mod.attachment.ogryn_gauntlet_p1_m1
		--#endregion
		--#region Ogryn Melee
			mod.attachment.ogryn_club_p1_m2        = mod.attachment.ogryn_club_p1_m1
			mod.attachment.ogryn_club_p1_m3        = mod.attachment.ogryn_club_p1_m1
			mod.attachment.ogryn_combatblade_p1_m2 = mod.attachment.ogryn_combatblade_p1_m1
			mod.attachment.ogryn_combatblade_p1_m3 = mod.attachment.ogryn_combatblade_p1_m1
				-- mod.attachment.ogryn_combatblade_npc_01 = mod.attachment.ogryn_combatblade_p1_m1
				-- mod.attachment.ogryn_powermaul_slabshield_npc_01 = mod.attachment.ogryn_powermaul_slabshield_p1_m1
				mod.attachment.ogryn_powermaul_slabshield_p1_04 = mod.attachment.ogryn_powermaul_slabshield_p1_m1
			mod.attachment.ogryn_pickaxe_2h_p1_m2   = mod.attachment.ogryn_pickaxe_2h_p1_m1
			mod.attachment.ogryn_pickaxe_2h_p1_m3   = mod.attachment.ogryn_pickaxe_2h_p1_m1
			mod.attachment.ogryn_powermaul_p1_m2   = mod.attachment.ogryn_powermaul_p1_m1
			mod.attachment.ogryn_powermaul_p1_m3   = mod.attachment.ogryn_powermaul_p1_m1
			mod.attachment.ogryn_club_p2_m2        = mod.attachment.ogryn_club_p2_m1
			mod.attachment.ogryn_club_p2_m3        = mod.attachment.ogryn_club_p2_m1
		--#endregion
		--#region Guns
			mod.attachment.shotgun_p1_m2      = mod.attachment.shotgun_p1_m1
			mod.attachment.shotgun_p1_m3      = mod.attachment.shotgun_p1_m1
			mod.attachment.shotgun_p4_m2      = mod.attachment.shotgun_p4_m1
			mod.attachment.shotgun_p4_m3      = mod.attachment.shotgun_p4_m1
			mod.attachment.bolter_p1_m2       = mod.attachment.bolter_p1_m1
			mod.attachment.bolter_p1_m3       = mod.attachment.bolter_p1_m1
			mod.attachment.stubrevolver_p1_m2 = mod.attachment.stubrevolver_p1_m1
			mod.attachment.stubrevolver_p1_m3 = mod.attachment.stubrevolver_p1_m1
			mod.attachment.laspistol_p1_m2    = mod.attachment.laspistol_p1_m1
			mod.attachment.laspistol_p1_m3    = mod.attachment.laspistol_p1_m1
				-- mod.attachment.laspistol_npc_01 = mod.attachment.laspistol_p1_m1
			mod.attachment.autogun_p1_m2      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p1_m3      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p2_m1      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p2_m2      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p2_m3      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p3_m1      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p3_m2      = mod.attachment.autogun_p1_m1
			mod.attachment.autogun_p3_m3      = mod.attachment.autogun_p1_m1
				-- mod.attachment.autogun_npc_01 = mod.attachment.autogun_p1_m1
				-- mod.attachment.autogun_npc_02 = mod.attachment.autogun_p1_m1
				-- mod.attachment.autogun_npc_03 = mod.attachment.autogun_p1_m1
				-- mod.attachment.autogun_npc_04 = mod.attachment.autogun_p1_m1
				-- mod.attachment.autogun_npc_05 = mod.attachment.autogun_p1_m1
			mod.attachment.lasgun_p1_m2       = mod.attachment.lasgun_p1_m1
			mod.attachment.lasgun_p1_m3       = mod.attachment.lasgun_p1_m1
			mod.attachment.lasgun_p2_m2       = mod.attachment.lasgun_p2_m1
			mod.attachment.lasgun_p2_m3       = mod.attachment.lasgun_p2_m1
			mod.attachment.lasgun_p3_m2       = mod.attachment.lasgun_p3_m1
			mod.attachment.lasgun_p3_m3       = mod.attachment.lasgun_p3_m1
				-- mod.attachment.lasgun_npc_01 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.lasgun_npc_02 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.lasgun_npc_03 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.lasgun_npc_04 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.lasgun_npc_05 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.renegade_lasgun_cinematic_01 = mod.attachment.lasgun_p1_m1
				-- mod.attachment.renegade_lasgun_cinematic_02 = mod.attachment.lasgun_p2_m1
				-- mod.attachment.renegade_lasgun_cinematic_03 = mod.attachment.lasgun_p3_m1
				-- mod.attachment.flamer_npc_01 = mod.attachment.flamer_p1_m1
			mod.attachment.forcestaff_p2_m1   = mod.attachment.forcestaff_p1_m1
			mod.attachment.forcestaff_p3_m1   = mod.attachment.forcestaff_p1_m1
			mod.attachment.forcestaff_p4_m1   = mod.attachment.forcestaff_p1_m1
		--#endregion
		--#region Melee
			mod.attachment.combataxe_p1_m2        = mod.attachment.combataxe_p1_m1
			mod.attachment.combataxe_p1_m3        = mod.attachment.combataxe_p1_m1
			mod.attachment.combataxe_p2_m2        = mod.attachment.combataxe_p2_m1
			mod.attachment.combatknife_p1_m2      = mod.attachment.combatknife_p1_m1
			mod.attachment.combataxe_p2_m3        = mod.attachment.combataxe_p2_m1
			mod.attachment.combataxe_p3_m2        = mod.attachment.combataxe_p3_m1
			mod.attachment.combataxe_p3_m3        = mod.attachment.combataxe_p3_m1
			mod.attachment.powersword_p1_m2       = mod.attachment.powersword_p1_m1
			mod.attachment.powersword_p1_m3       = mod.attachment.powersword_p1_m1
				-- mod.attachment.powersword_npc_01    = mod.attachment.powersword_p1_m1
				-- mod.attachment.powersword_2h_npc_01 = mod.attachment.powersword_p1_m1
			mod.attachment.powersword_2h_p1_m2    = mod.attachment.powersword_2h_p1_m1
			mod.attachment.chainaxe_p1_m2         = mod.attachment.chainaxe_p1_m1
			mod.attachment.chainsword_p1_m2       = mod.attachment.chainsword_p1_m1
				-- mod.attachment.chainsword_npc_01  = mod.attachment.chainsword_p1_m1
			mod.attachment.chainsword_2h_p1_m2    = mod.attachment.chainsword_2h_p1_m1
			mod.attachment.combatsword_p1_m2      = mod.attachment.combatsword_p1_m1
			mod.attachment.combatsword_p1_m3      = mod.attachment.combatsword_p1_m1
			mod.attachment.thunderhammer_2h_p1_m2 = mod.attachment.thunderhammer_2h_p1_m1
			mod.attachment.combatsword_p2_m2      = mod.attachment.combatsword_p2_m1
			mod.attachment.combatsword_p2_m3      = mod.attachment.combatsword_p2_m1
			mod.attachment.forcesword_p1_m2       = mod.attachment.forcesword_p1_m1
			mod.attachment.forcesword_p1_m3       = mod.attachment.forcesword_p1_m1
				-- mod.attachment.forcesword_npc_01  = mod.attachment.forcesword_p1_m1
			mod.attachment.forcesword_2h_p1_m2    = mod.attachment.forcesword_2h_p1_m1
			mod.attachment.combatsword_p3_m2      = mod.attachment.combatsword_p3_m1
			mod.attachment.combatsword_p3_m3      = mod.attachment.combatsword_p3_m1
			mod.attachment.powermaul_p1_m2        = mod.attachment.powermaul_p1_m1
			mod.attachment.powermaul_shield_p1_m2 = mod.attachment.powermaul_shield_p1_m1
			-- mod.attachment.powermaul_p2_m2        = mod.attachment.powermaul_p2_m1
		--#endregion
	--#endregion
--#endregion

for item_name, attachments in pairs(mod.attachment) do
	for attachment_slot, slot_attachments in pairs(attachments) do
		for _, attachment_data in pairs(slot_attachments) do
			attachment_data.original_mod = true
		end
	end
end

--#region Data
	mod.special_types = {
		"special_bullet",
		"melee",
		"knife",
		"melee_hand",
	}
	mod.add_custom_attachments = {
		flashlight = "flashlights",
		laser_pointer = "laser_pointers",
		bayonet = "bayonets",
		stock = "stocks",
		stock_2 = "stocks",
		stock_3 = "shotgun_stocks",
		rail = "rails",
		emblem_left = "emblems_left",
		emblem_right = "emblems_right",
		sight = "sights",
		sight_2 = "reflex_sights",
		help_sight = "help_sights",
		muzzle = "muzzles",
		muzzle_2 = "muzzles",
		trinket_hook = "trinket_hooks",
		slot_trinket_1 = "slot_trinket_1",
		slot_trinket_2 = "slot_trinket_2",
		decal_right = "decals_right",
		decal_left = "decals_left",
		hilt = "hilts",
		shaft = "shafts",
		head = "heads",
		connector = "connectors",
		lens = "lenses",
		lens_2 = "lenses",
		pommel = "pommels",
		scabbard = "scabbards",
		weapon_sling = "weapon_slings",
	}
	mod.weapon_slings = {
		"weapon_sling_01",
	}
	mod.shafts = {
		"small_shaft_01",
		"small_shaft_02",
		"small_shaft_03",
		"small_shaft_04",
		"small_shaft_05",
		"small_shaft_06",
	}
	mod.heads = {
		"small_head_01",
		"small_head_02",
		"small_head_03",
		"small_head_04",
		"small_head_05",
		"small_head_06",
	}
	mod.connectors = {
		"small_connector_01",
		"small_connector_02",
		"small_connector_03",
		"small_connector_04",
		"small_connector_05",
		"small_connector_06",
	}
	mod.scabbards = {
		"scabbard_01",
		"scabbard_02",
		"scabbard_03",
	}
	mod.hilts = {
		"power_sword_hilt_01",
		"power_sword_2h_hilt_01",
		"power_sword_2h_hilt_02",
		"power_sword_2h_hilt_03",
		"force_sword_hilt_01",
		"force_sword_hilt_02",
		"force_sword_hilt_03",
		"force_sword_hilt_04",
		"force_sword_hilt_05",
		"force_sword_hilt_06",
		"force_sword_hilt_07",
	}
	mod.decals_right = {
		"decal_right_01",
		"decal_right_02",
		"decal_right_03",
	}
	mod.decals_left = {
		"decal_left_01",
		"decal_left_02",
		"decal_left_03",
	}
	mod.slot_trinket_1 = {
		"slot_trinket_1",
	}
	mod.slot_trinket_2 = {
		"slot_trinket_2",
	}
	mod.special_actions = {
		"weapon_extra_pressed",
	}
	mod.trinket_hooks = {
		"trinket_hook_default",
		"trinket_hook_empty",
		"trinket_hook_01",
		"trinket_hook_01_v",
		"trinket_hook_02",
		"trinket_hook_02_45",
		"trinket_hook_02_90",
		"trinket_hook_03",
		"trinket_hook_03_v",
		"trinket_hook_04_steel",
		"trinket_hook_04_steel_v",
		"trinket_hook_04_coated",
		"trinket_hook_04_coated_v",
		"trinket_hook_04_carbon",
		"trinket_hook_04_carbon_v",
		"trinket_hook_04_gold",
		"trinket_hook_04_gold_v",
		"trinket_hook_05_steel",
		"trinket_hook_05_steel_v",
		"trinket_hook_05_coated",
		"trinket_hook_05_coated_v",
		"trinket_hook_05_carbon",
		"trinket_hook_05_carbon_v",
		"trinket_hook_05_gold",
		"trinket_hook_05_gold_v",
	}
	mod.text_overwrite = {
		plasmagun_p1_m1 = {
			loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
		},
		laspistol_p1_m1 = {
			loc_weapon_cosmetics_customization_stock = "loc_weapon_cosmetics_customization_ventilation",
		},
	}
	mod.help_sights = {
		-- "sight_default",
		"bolter_sight_01",
	}
	mod.automatic_slots = {
		"rail",
		"help_sight",
		"lens",
		"lens_2",
		"slot_trinket_1",
		"slot_trinket_2",
		"zzz_shared_material_overrides",
	}
	mod.reflex_sights = {
		"reflex_sight_01",
		"reflex_sight_02",
		"reflex_sight_03",
		"scope_sight_default",
		"scope_sight_01",
		"scope_sight_02",
		"scope_sight_03",
	}
	mod.sights = {
		"lasgun_rifle_elysian_sight_01",
		"lasgun_rifle_elysian_sight_02",
		"lasgun_rifle_elysian_sight_03",
		"autogun_rifle_ak_sight_01",
		"autogun_rifle_sight_01",
		"autogun_rifle_killshot_sight_01",
		"lasgun_rifle_sight_01",
		"sight_01",
		"shotgun_double_barrel_sight_01",
		"buggy_sight",
		"scope_01",
		"scope_02",
		"scope_03",
		"reflex_sight_01",
		"reflex_sight_02",
		"reflex_sight_03",
	}
	mod.scopes = {
		"lasgun_rifle_krieg_muzzle_02",
		"lasgun_rifle_krieg_muzzle_04",
		"lasgun_rifle_krieg_muzzle_05",
	}
	mod.all_sights = table.combine(
		mod.reflex_sights,
		mod.sights
	)
	mod.rails = {
		"rail_default",
		"rail_01"
	}
	mod.muzzles = {
		"muzzle_01",
		"muzzle_02",
		"muzzle_03",
		"muzzle_04",
		"muzzle_05",
		"muzzle_06",
		"muzzle_07",
		"muzzle_08",
		"muzzle_09",
		"muzzle_10",
		"muzzle_11",
		"muzzle_12",
		"muzzle_13",
		"muzzle_14",
		"barrel_01",
		"barrel_02",
		"barrel_03",
		"barrel_04",
		"barrel_05",
		"barrel_06",
	}
	mod.emblems_right = {
		"emblem_right_01",
		"emblem_right_02",
		"emblem_right_03",
		"emblem_right_04",
		"emblem_right_05",
		"emblem_right_06",
		"emblem_right_07",
		"emblem_right_08",
		"emblem_right_09",
		"emblem_right_10",
		"emblem_right_11",
		"emblem_right_12",
		"emblem_right_13",
		"emblem_right_14",
		"emblem_right_15",
		"emblem_right_16",
		"emblem_right_17",
		"emblem_right_18",
		"emblem_right_19",
		"emblem_right_20",
		"emblem_right_21",
	}
	mod.emblems_left = {
		"emblem_left_01",
		"emblem_left_02",
		"emblem_left_03",
		"emblem_left_04",
		"emblem_left_05",
		"emblem_left_06",
		"emblem_left_07",
		"emblem_left_08",
		"emblem_left_09",
		"emblem_left_10",
		"emblem_left_11",
		"emblem_left_12",
	}
	mod.lenses = {
		"scope_lens_01",
		"scope_lens_2_01",
		"scope_lens_02",
		"scope_lens_2_02",
	}
	mod.sniper_zoom_levels = {
		lasgun_rifle_krieg_muzzle_05 = 25,
		lasgun_rifle_krieg_muzzle_02 = 15,
		lasgun_rifle_krieg_muzzle_04 = 9,
	}
	mod.sniper_back_offset = {
		lasgun_rifle_krieg_muzzle_05 = .75,
		lasgun_rifle_krieg_muzzle_02 = 1.2,
		lasgun_rifle_krieg_muzzle_04 = 2,
	}
	mod.sniper_recoil_level = {
		lasgun_rifle_krieg_muzzle_05 = .5,
		lasgun_rifle_krieg_muzzle_02 = .75,
		lasgun_rifle_krieg_muzzle_04 = .5,
	}
	mod.flashlights = {
		"flashlight_01",
		"flashlight_02",
		"flashlight_03",
		"flashlight_04",
		"flashlight_ogryn_01",
		"flashlight_ogryn_long_01",
		"laser_pointer",
	}
	mod.laser_pointers = {
		"flashlight_04",
	}
	mod.bayonets = {
		"bayonet_blade_01",
		"autogun_bayonet_01",
		"autogun_bayonet_02",
		"autogun_bayonet_03",
		"bayonet_01",
		"bayonet_02",
		"bayonet_03",
		"bayonet_04",
	}
	mod.stocks = {
		"autogun_rifle_stock_01",
		"autogun_rifle_stock_02",
		"autogun_rifle_stock_03",
		"autogun_rifle_stock_04",
		"autogun_rifle_stock_05",
		"autogun_rifle_stock_06",
		"autogun_rifle_stock_07",
		"autogun_rifle_stock_08",
		"autogun_rifle_stock_09",
		"stock_01",
		"stock_02",
		"stock_03",
		"stock_04",
		"stock_05",
		"lasgun_stock_01",
		"lasgun_stock_02",
		"lasgun_stock_03",
	}
	mod.shotgun_stocks = {
		"shotgun_rifle_stock_01",
		"shotgun_rifle_stock_02",
		"shotgun_rifle_stock_03",
		"shotgun_rifle_stock_04",
		"shotgun_rifle_stock_07",
		"shotgun_rifle_stock_08",
		"shotgun_rifle_stock_09",
		"shotgun_rifle_stock_10",
		"shotgun_rifle_stock_11",
		"shotgun_rifle_stock_12",
	}
	-- mod.attachment_units = {
	-- 	["#ID[c54f4d16d170cfdb]"] = "flashlight_01",
	-- 	["#ID[28ae77de0a24aba6]"] = "flashlight_02",
	-- 	["#ID[93567d1eb8abad0b]"] = "flashlight_03",
	-- 	["#ID[1db94ec130a99e51]"] = "flashlight_04",
	-- 	["#ID[9ed2469305ba9eb7]"] = "bayonet_blade_01",
	-- 	["#ID[fb7d93784a24faa0]"] = "bayonet_01",
	-- 	["#ID[a1a6d59dcc2d6f56]"] = "bayonet_02",
	-- 	["#ID[c42336380c6bc902]"] = "bayonet_03",
	-- 	["#ID[3a32b0205efe4d98]"] = "autogun_rifle_stock_01",
	-- 	["#ID[93d6f1e2cc3f6623]"] = "autogun_rifle_stock_02",
	-- 	["#ID[dd28bd8305193b80]"] = "autogun_rifle_stock_03",
	-- 	["#ID[7467bc5f53a97942]"] = "autogun_rifle_stock_04",
	-- 	["#ID[6e29c4a9efbd1449]"] = "autogun_bayonet_01",
	-- 	["#ID[81347ad48c2a24e1]"] = "autogun_bayonet_02",
	-- 	["#ID[282093393ef1b500]"] = "autogun_bayonet_03",
	-- 	["#ID[900f45d6ed020f0c]"] = "stock_01",
	-- 	["#ID[67654e3011a5e407]"] = "stock_02",
	-- 	["#ID[55a01ebb60937e94]"] = "stock_03",
	-- 	["#ID[d607b405027432d9]"] = "stock_04",
	-- 	["#ID[891692deb6c77ef1]"] = "stock_05",
	-- 	-- ["#ID[bc25db1df0670d2a]"] = "bulwark_shield_01",
	-- }
	mod.attachment_slots_always_sheathed = {
		"scabbard",
	}
	mod.attachment_slots_always_unsheathed = {
	}
	mod.attachment_slots = {
		"flashlight",
		"handle",
		"bayonet",
		"muzzle",
		"barrel",
		"underbarrel",
		"receiver",
		"magazine",
		"magazine2",
		"speedloader",
		"bullet",
		"ammo",
		"ammo_used",
		"rail",
		"sight",
		"sight_2",
		"help_sight",
		"grip",
		"stock",
		"stock_2",
		"stock_3",
		"body",
		"pommel",
		"hilt",
		"head",
		"blade",
		"teeth",
		"chain",
		"connector",
		"shaft",
		"left",
		"emblem_right",
		"emblem_left",
		"decal_right",
		"decal_left",
		"shaft_lower",
		"shaft_upper",
		"trinket_hook",
		"slot_trinket_1",
		"slot_trinket_2",
		"bullet_01",
		"bullet_02",
		"bullet_03",
		"bullet_04",
		"bullet_05",
		"casing_01",
		"casing_02",
		"casing_03",
		"casing_04",
		"casing_05",
		"scabbard",
		"weapon_sling",
	}
--#endregion

--#region Models
	mod.attachment_models = {
		--#region Ogryn Guns
			ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.models,
			ogryn_heavystubber_p2_m1 = _ogryn_heavystubber_p2_m1.models,
			ogryn_rippergun_p1_m1    = _ogryn_rippergun_p1_m1.models,
			ogryn_thumper_p1_m1      = _ogryn_thumper_p1_m1.models,
			ogryn_gauntlet_p1_m1     = _ogryn_gauntlet_p1_m1.models,
		--#endregion
		--#region Ogryn Melee
			ogryn_club_p1_m1                 = _ogryn_club_p1_m1.models,
			ogryn_combatblade_p1_m1          = _ogryn_combatblade_p1_m1.models,
			ogryn_powermaul_p1_m1            = _ogryn_powermaul_p1_m1.models,
			ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.models,
			ogryn_pickaxe_2h_p1_m1           = _ogryn_pickaxe_2h_p1_m1.models,
			ogryn_club_p2_m1                 = _ogryn_club_p2_m1.models,
		--#endregion
		--#region Guns
			autopistol_p1_m1   = _autopistol_p1_m1.models,
			shotgun_p1_m1      = _shotgun_p1_m1.models,
			shotgun_p2_m1      = _shotgun_p2_m1.models,
			shotgun_p4_m1      = _shotgun_p4_m1.models,
			bolter_p1_m1       = _bolter_p1_m1.models,
			boltpistol_p1_m1   = _boltpistol_p1_m1.models,
			stubrevolver_p1_m1 = _stubrevolver_p1_m1.models,
			plasmagun_p1_m1    = _plasmagun_p1_m1.models,
			laspistol_p1_m1    = _laspistol_p1_m1.models,
			autogun_p1_m1      = _autogun_p1_m1.models,
			lasgun_p1_m1       = _lasgun_p1_m1.models,
			lasgun_p2_m1       = _lasgun_p2_m1.models,
			lasgun_p3_m1       = _lasgun_p3_m1.models,
			flamer_p1_m1       = _flamer_p1_m1.models,
			forcestaff_p1_m1   = _forcestaff_p1_m1.models,
		--#endregion
		--#region Melee
			combataxe_p1_m1        = _combataxe_p1_m1.models,
			combataxe_p2_m1        = _combataxe_p2_m1.models,
			combatknife_p1_m1      = _combatknife_p1_m1.models,
			powersword_p1_m1       = _powersword_p1_m1.models,
			powersword_2h_p1_m1    = _powersword_2h_p1_m1.models,
			chainaxe_p1_m1         = _chainaxe_p1_m1.models,
			chainsword_p1_m1       = _chainsword_p1_m1.models,
			combataxe_p3_m1        = _combataxe_p3_m1.models,
			combatsword_p1_m1      = _combatsword_p1_m1.models,
			thunderhammer_2h_p1_m1 = _thunderhammer_2h_p1_m1.models,
			powermaul_2h_p1_m1     = _powermaul_2h_p1_m1.models,
			powermaul_p1_m1        = _powermaul_p1_m1.models,
			powermaul_p2_m1        = _powermaul_p2_m1.models,
			powermaul_shield_p1_m1 = _powermaul_shield_p1_m1.models,
			chainsword_2h_p1_m1    = _chainsword_2h_p1_m1.models,
			combatsword_p2_m1      = _combatsword_p2_m1.models,
			forcesword_p1_m1       = _forcesword_p1_m1.models,
			forcesword_2h_p1_m1    = _forcesword_2h_p1_m1.models,
			combatsword_p3_m1      = _combatsword_p3_m1.models,
		--#endregion
	}
	--#region Copies
		--#region Ogryn Guns
			mod.attachment_models.ogryn_heavystubber_p1_m2 = mod.attachment_models.ogryn_heavystubber_p1_m1
			mod.attachment_models.ogryn_heavystubber_p1_m3 = mod.attachment_models.ogryn_heavystubber_p1_m1
			mod.attachment_models.ogryn_heavystubber_p2_m2 = mod.attachment_models.ogryn_heavystubber_p2_m1
			mod.attachment_models.ogryn_heavystubber_p2_m3 = mod.attachment_models.ogryn_heavystubber_p2_m1
			mod.attachment_models.ogryn_rippergun_p1_m2    = mod.attachment_models.ogryn_rippergun_p1_m1
			mod.attachment_models.ogryn_rippergun_p1_m3    = mod.attachment_models.ogryn_rippergun_p1_m1
				-- mod.attachment_models.ogryn_rippergun_npc_01 = mod.attachment_models.ogryn_rippergun_p1_m1
			mod.attachment_models.ogryn_thumper_p1_m2      = mod.attachment_models.ogryn_thumper_p1_m1
				-- mod.attachment_models.ogryn_thumper_npc_01 = mod.attachment_models.ogryn_thumper_p1_m1
				-- mod.attachment_models.ogryn_gauntlet_npc_01 = mod.attachment_models.ogryn_gauntlet_p1_m1
		--#endregion
		--#region Ogryn Melee
			mod.attachment_models.ogryn_club_p1_m2        = mod.attachment_models.ogryn_club_p1_m1
			mod.attachment_models.ogryn_club_p1_m3        = mod.attachment_models.ogryn_club_p1_m1
			mod.attachment_models.ogryn_combatblade_p1_m2 = mod.attachment_models.ogryn_combatblade_p1_m1
			mod.attachment_models.ogryn_combatblade_p1_m3 = mod.attachment_models.ogryn_combatblade_p1_m1
				-- mod.attachment_models.ogryn_combatblade_npc_01 = mod.attachment_models.ogryn_combatblade_p1_m1
				-- mod.attachment_models.ogryn_powermaul_slabshield_npc_01 = mod.attachment_models.ogryn_powermaul_slabshield_p1_m1
				mod.attachment_models.ogryn_powermaul_slabshield_p1_04 = mod.attachment_models.ogryn_powermaul_slabshield_p1_m1
			mod.attachment_models.ogryn_pickaxe_2h_p1_m2   = mod.attachment_models.ogryn_pickaxe_2h_p1_m1
			mod.attachment_models.ogryn_pickaxe_2h_p1_m3   = mod.attachment_models.ogryn_pickaxe_2h_p1_m1
			mod.attachment_models.ogryn_powermaul_p1_m2   = mod.attachment_models.ogryn_powermaul_p1_m1
			mod.attachment_models.ogryn_powermaul_p1_m3   = mod.attachment_models.ogryn_powermaul_p1_m1
			mod.attachment_models.ogryn_club_p2_m2        = mod.attachment_models.ogryn_club_p2_m1
			mod.attachment_models.ogryn_club_p2_m3        = mod.attachment_models.ogryn_club_p2_m1
		--#endregion
		--region Guns
			mod.attachment_models.shotgun_p1_m2      = mod.attachment_models.shotgun_p1_m1
			mod.attachment_models.shotgun_p1_m3      = mod.attachment_models.shotgun_p1_m1
			mod.attachment_models.shotgun_p4_m2      = mod.attachment_models.shotgun_p4_m1
			mod.attachment_models.shotgun_p4_m3      = mod.attachment_models.shotgun_p4_m1
			mod.attachment_models.bolter_p1_m2       = mod.attachment_models.bolter_p1_m1
			mod.attachment_models.bolter_p1_m3       = mod.attachment_models.bolter_p1_m1
			mod.attachment_models.stubrevolver_p1_m2 = mod.attachment_models.stubrevolver_p1_m1
			mod.attachment_models.stubrevolver_p1_m3 = mod.attachment_models.stubrevolver_p1_m1
			mod.attachment_models.laspistol_p1_m2    = mod.attachment_models.laspistol_p1_m1
			mod.attachment_models.laspistol_p1_m3    = mod.attachment_models.laspistol_p1_m1
				-- mod.attachment_models.laspistol_npc_01 = mod.attachment_models.laspistol_p1_m1
			mod.attachment_models.autogun_p1_m2      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p1_m3      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p2_m1      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p2_m2      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p2_m3      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p3_m1      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p3_m2      = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.autogun_p3_m3      = mod.attachment_models.autogun_p1_m1
				-- mod.attachment_models.autogun_npc_01 = mod.attachment_models.autogun_p1_m1
				-- mod.attachment_models.autogun_npc_02 = mod.attachment_models.autogun_p1_m1
				-- mod.attachment_models.autogun_npc_03 = mod.attachment_models.autogun_p1_m1
				-- mod.attachment_models.autogun_npc_04 = mod.attachment_models.autogun_p1_m1
				-- mod.attachment_models.autogun_npc_05 = mod.attachment_models.autogun_p1_m1
			mod.attachment_models.lasgun_p1_m2       = mod.attachment_models.lasgun_p1_m1
			mod.attachment_models.lasgun_p1_m3       = mod.attachment_models.lasgun_p1_m1
			mod.attachment_models.lasgun_p2_m2       = mod.attachment_models.lasgun_p2_m1
			mod.attachment_models.lasgun_p2_m3       = mod.attachment_models.lasgun_p2_m1
			mod.attachment_models.lasgun_p3_m2       = mod.attachment_models.lasgun_p3_m1
			mod.attachment_models.lasgun_p3_m3       = mod.attachment_models.lasgun_p3_m1
				-- mod.attachment_models.lasgun_npc_01 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.lasgun_npc_02 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.lasgun_npc_03 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.lasgun_npc_04 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.lasgun_npc_05 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.renegade_lasgun_cinematic_01 = mod.attachment_models.lasgun_p1_m1
				-- mod.attachment_models.renegade_lasgun_cinematic_02 = mod.attachment_models.lasgun_p2_m1
				-- mod.attachment_models.renegade_lasgun_cinematic_03 = mod.attachment_models.lasgun_p3_m1
				-- mod.attachment_models.flamer_npc_01 = mod.attachment_models.flamer_p1_m1
			mod.attachment_models.forcestaff_p2_m1   = mod.attachment_models.forcestaff_p1_m1
			mod.attachment_models.forcestaff_p3_m1   = mod.attachment_models.forcestaff_p1_m1
			mod.attachment_models.forcestaff_p4_m1   = mod.attachment_models.forcestaff_p1_m1
		--#endregion
		--region Melee
			mod.attachment_models.combataxe_p1_m2        = mod.attachment_models.combataxe_p1_m1
			mod.attachment_models.combataxe_p1_m3        = mod.attachment_models.combataxe_p1_m1
			mod.attachment_models.combataxe_p2_m2        = mod.attachment_models.combataxe_p1_m1
			mod.attachment_models.combataxe_p2_m3        = mod.attachment_models.combataxe_p1_m1
			mod.attachment_models.combatknife_p1_m2      = mod.attachment_models.combatknife_p1_m1
			mod.attachment_models.combataxe_p3_m2        = mod.attachment_models.combataxe_p3_m1
			mod.attachment_models.combataxe_p3_m3        = mod.attachment_models.combataxe_p3_m1
			mod.attachment_models.chainaxe_p1_m2         = mod.attachment_models.chainaxe_p1_m1
			mod.attachment_models.chainsword_p1_m2       = mod.attachment_models.chainsword_p1_m1
				-- mod.attachment_models.chainsword_npc_01 = mod.attachment_models.chainsword_p1_m1
			mod.attachment_models.chainsword_2h_p1_m2    = mod.attachment_models.chainsword_2h_p1_m1
			mod.attachment_models.powersword_p1_m2       = mod.attachment_models.powersword_p1_m1
			mod.attachment_models.powersword_p1_m3       = mod.attachment_models.powersword_p1_m1
				-- mod.attachment_models.powersword_npc_01 = mod.attachment_models.powersword_p1_m1
				-- mod.attachment_models.powersword_2h_npc_01 = mod.attachment_models.powersword_p1_m1
			mod.attachment_models.powersword_2h_p1_m2    = mod.attachment_models.powersword_2h_p1_m1
			mod.attachment_models.combatsword_p1_m2      = mod.attachment_models.combatsword_p1_m1
			mod.attachment_models.combatsword_p1_m3      = mod.attachment_models.combatsword_p1_m1
			mod.attachment_models.thunderhammer_2h_p1_m2 = mod.attachment_models.thunderhammer_2h_p1_m1
			mod.attachment_models.combatsword_p2_m2      = mod.attachment_models.combatsword_p2_m1
			mod.attachment_models.combatsword_p2_m3      = mod.attachment_models.combatsword_p2_m1
			mod.attachment_models.forcesword_p1_m2       = mod.attachment_models.forcesword_p1_m1
			mod.attachment_models.forcesword_p1_m3       = mod.attachment_models.forcesword_p1_m1
				-- mod.attachment_models.forcesword_npc_01 = mod.attachment_models.forcesword_p1_m1
			mod.attachment_models.forcesword_2h_p1_m2    = mod.attachment_models.forcesword_2h_p1_m1
			mod.attachment_models.combatsword_p3_m2      = mod.attachment_models.combatsword_p3_m1
			mod.attachment_models.combatsword_p3_m3      = mod.attachment_models.combatsword_p3_m1
			mod.attachment_models.powermaul_p1_m2        = mod.attachment_models.powermaul_p1_m1
			mod.attachment_models.powermaul_shield_p1_m2 = mod.attachment_models.powermaul_shield_p1_m1
			-- mod.attachment_models.powermaul_p2_m2        = mod.attachment_models.powermaul_p2_m1
		--#endregion
	--#endregion
--#endregion

mod.default_attachment_models = {}
for weapon_name, weapon_data in pairs(mod.attachment_models) do
	mod.default_attachment_models[weapon_name] = {}
	for attachment_name, attachment_data in pairs(weapon_data) do
		attachment_data.original_mod = true
		if attachment_data.index then
			mod.default_attachment_models[weapon_name][#mod.default_attachment_models[weapon_name]+1] = attachment_name
		end
	end
end

--#region Sounds
	mod.attachment_sounds = {
		--#region Ogryn Guns
			ogryn_heavystubber_p1_m1 = _ogryn_heavystubber_p1_m1.sounds,
			ogryn_heavystubber_p2_m1 = _ogryn_heavystubber_p2_m1.sounds,
			ogryn_rippergun_p1_m1 	 = _ogryn_rippergun_p1_m1.sounds,
			ogryn_thumper_p1_m1      = _ogryn_thumper_p1_m1.sounds,
			ogryn_gauntlet_p1_m1     = _ogryn_gauntlet_p1_m1.sounds,
		--#endregion
		--#region Ogryn Melee
			ogryn_club_p1_m1                 = _ogryn_club_p1_m1.sounds,
			ogryn_combatblade_p1_m1          = _ogryn_combatblade_p1_m1.sounds,
			ogryn_powermaul_p1_m1            = _ogryn_powermaul_p1_m1.sounds,
			ogryn_powermaul_slabshield_p1_m1 = _ogryn_powermaul_slabshield_p1_m1.sounds,
			ogryn_pickaxe_2h_p1_m1           = _ogryn_pickaxe_2h_p1_m1.sounds,
			ogryn_club_p2_m1                 = _ogryn_club_p2_m1.sounds,
		--#endregion
		--#region Guns
			autopistol_p1_m1   = _autopistol_p1_m1.sounds,
			shotgun_p1_m1      = _shotgun_p1_m1.sounds,
			shotgun_p2_m1      = _shotgun_p2_m1.sounds,
			shotgun_p4_m1      = _shotgun_p4_m1.sounds,
			bolter_p1_m1       = _bolter_p1_m1.sounds,
			boltpistol_p1_m1   = _boltpistol_p1_m1.sounds,
			stubrevolver_p1_m1 = _stubrevolver_p1_m1.sounds,
			plasmagun_p1_m1    = _plasmagun_p1_m1.sounds,
			laspistol_p1_m1    = _laspistol_p1_m1.sounds,
			autogun_p1_m1      = _autogun_p1_m1.sounds,
			lasgun_p1_m1       = _lasgun_p1_m1.sounds,
			lasgun_p2_m1       = _lasgun_p2_m1.sounds,
			lasgun_p3_m1       = _lasgun_p3_m1.sounds,
			flamer_p1_m1       = _flamer_p1_m1.sounds,
			forcestaff_p1_m1   = _forcestaff_p1_m1.sounds,
		--#endregion
		--#region Melee
			combataxe_p1_m1        = _combataxe_p1_m1.sounds,
			combataxe_p2_m1        = _combataxe_p2_m1.sounds,
			combatknife_p1_m1      = _combatknife_p1_m1.sounds,
			powersword_p1_m1       = _powersword_p1_m1.sounds,
			powersword_2h_p1_m1    = _powersword_2h_p1_m1.sounds,
			chainaxe_p1_m1         = _chainaxe_p1_m1.sounds,
			chainsword_p1_m1       = _chainsword_p1_m1.sounds,
			combataxe_p3_m1        = _combataxe_p3_m1.sounds,
			combatsword_p1_m1      = _combatsword_p1_m1.sounds,
			thunderhammer_2h_p1_m1 = _thunderhammer_2h_p1_m1.sounds,
			powermaul_2h_p1_m1     = _powermaul_2h_p1_m1.sounds,
			powermaul_p1_m1        = _powermaul_p1_m1.sounds,
			powermaul_p2_m1        = _powermaul_p2_m1.sounds,
			powermaul_shield_p1_m1 = _powermaul_shield_p1_m1.sounds,
			chainsword_2h_p1_m1    = _chainsword_2h_p1_m1.sounds,
			combatsword_p2_m1      = _combatsword_p2_m1.sounds,
			forcesword_p1_m1       = _forcesword_p1_m1.sounds,
			forcesword_2h_p1_m1    = _forcesword_2h_p1_m1.sounds,
			combatsword_p3_m1      = _combatsword_p3_m1.sounds,
		--#endregion
	}
	--#region Copies
		--#region Ogryn Guns
			mod.attachment_sounds.ogryn_heavystubber_p1_m2 = mod.attachment_sounds.ogryn_heavystubber_p1_m1
			mod.attachment_sounds.ogryn_heavystubber_p1_m3 = mod.attachment_sounds.ogryn_heavystubber_p1_m1
			mod.attachment_sounds.ogryn_heavystubber_p2_m2 = mod.attachment_sounds.ogryn_heavystubber_p2_m1
			mod.attachment_sounds.ogryn_heavystubber_p2_m3 = mod.attachment_sounds.ogryn_heavystubber_p2_m1
			mod.attachment_sounds.ogryn_rippergun_p1_m2 = mod.attachment_sounds.ogryn_rippergun_p1_m1
			mod.attachment_sounds.ogryn_rippergun_p1_m3 = mod.attachment_sounds.ogryn_rippergun_p1_m1
				-- mod.attachment_models.ogryn_rippergun_npc_01 = mod.attachment_models.ogryn_rippergun_p1_m1
			mod.attachment_sounds.ogryn_thumper_p1_m2 = mod.attachment_sounds.ogryn_thumper_p1_m1
				-- mod.attachment_models.ogryn_thumper_npc_01 = mod.attachment_models.ogryn_thumper_p1_m1
				-- mod.attachment_models.ogryn_gauntlet_npc_01 = mod.attachment_models.ogryn_gauntlet_p1_m1
		--#endregion
		--#region Ogryn Melee
			mod.attachment_sounds.ogryn_club_p1_m2        = mod.attachment_sounds.ogryn_club_p1_m1
			mod.attachment_sounds.ogryn_club_p1_m3        = mod.attachment_sounds.ogryn_club_p1_m1
			mod.attachment_sounds.ogryn_combatblade_p1_m2 = mod.attachment_sounds.ogryn_combatblade_p1_m1
			mod.attachment_sounds.ogryn_combatblade_p1_m3 = mod.attachment_sounds.ogryn_combatblade_p1_m1
				-- mod.attachment_sounds.ogryn_combatblade_npc_01 = mod.attachment_sounds.ogryn_combatblade_p1_m1
				-- mod.attachment_sounds.ogryn_powermaul_slabshield_npc_01 = mod.attachment_sounds.ogryn_powermaul_slabshield_p1_m1
				mod.attachment_sounds.ogryn_powermaul_slabshield_p1_04 = mod.attachment_sounds.ogryn_powermaul_slabshield_p1_m1
			mod.attachment_sounds.ogryn_powermaul_p1_m2   = mod.attachment_sounds.ogryn_powermaul_p1_m1
			mod.attachment_sounds.ogryn_powermaul_p1_m3   = mod.attachment_sounds.ogryn_powermaul_p1_m1
			mod.attachment_sounds.ogryn_pickaxe_2h_p1_m2  = mod.attachment_sounds.ogryn_pickaxe_2h_p1_m1
			mod.attachment_sounds.ogryn_pickaxe_2h_p1_m3  = mod.attachment_sounds.ogryn_pickaxe_2h_p1_m1
			mod.attachment_sounds.ogryn_club_p2_m2        = mod.attachment_sounds.ogryn_club_p2_m1
			mod.attachment_sounds.ogryn_club_p2_m3        = mod.attachment_sounds.ogryn_club_p2_m1
		--#endregion
		--#region Guns
			mod.attachment_sounds.shotgun_p1_m2      = mod.attachment_sounds.shotgun_p1_m1
			mod.attachment_sounds.shotgun_p1_m3      = mod.attachment_sounds.shotgun_p1_m1
			mod.attachment_sounds.shotgun_p4_m2      = mod.attachment_sounds.shotgun_p4_m1
			mod.attachment_sounds.shotgun_p4_m3      = mod.attachment_sounds.shotgun_p4_m1
			mod.attachment_sounds.bolter_p1_m2       = mod.attachment_sounds.bolter_p1_m1
			mod.attachment_sounds.bolter_p1_m3       = mod.attachment_sounds.bolter_p1_m1
			mod.attachment_sounds.stubrevolver_p1_m2 = mod.attachment_sounds.stubrevolver_p1_m1
			mod.attachment_sounds.stubrevolver_p1_m3 = mod.attachment_sounds.stubrevolver_p1_m1
			mod.attachment_sounds.laspistol_p1_m2    = mod.attachment_sounds.laspistol_p1_m1
			mod.attachment_sounds.laspistol_p1_m3    = mod.attachment_sounds.laspistol_p1_m1
				-- mod.attachment_sounds.laspistol_npc_01 = mod.attachment_sounds.laspistol_p1_m1
			mod.attachment_sounds.autogun_p1_m2      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p1_m3      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p2_m1      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p2_m2      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p2_m3      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p3_m1      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p3_m2      = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.autogun_p3_m3      = mod.attachment_sounds.autogun_p1_m1
				-- mod.attachment_sounds.autogun_npc_01 = mod.attachment_sounds.autogun_p1_m1
				-- mod.attachment_sounds.autogun_npc_02 = mod.attachment_sounds.autogun_p1_m1
				-- mod.attachment_sounds.autogun_npc_03 = mod.attachment_sounds.autogun_p1_m1
				-- mod.attachment_sounds.autogun_npc_04 = mod.attachment_sounds.autogun_p1_m1
				-- mod.attachment_sounds.autogun_npc_05 = mod.attachment_sounds.autogun_p1_m1
			mod.attachment_sounds.lasgun_p1_m2       = mod.attachment_sounds.lasgun_p1_m1
			mod.attachment_sounds.lasgun_p1_m3       = mod.attachment_sounds.lasgun_p1_m1
			mod.attachment_sounds.lasgun_p2_m2       = mod.attachment_sounds.lasgun_p2_m1
			mod.attachment_sounds.lasgun_p2_m3       = mod.attachment_sounds.lasgun_p2_m1
			mod.attachment_sounds.lasgun_p3_m2       = mod.attachment_sounds.lasgun_p3_m1
			mod.attachment_sounds.lasgun_p3_m3       = mod.attachment_sounds.lasgun_p3_m1
				-- mod.attachment_sounds.lasgun_npc_01 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.lasgun_npc_02 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.lasgun_npc_03 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.lasgun_npc_04 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.lasgun_npc_05 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.renegade_lasgun_cinematic_01 = mod.attachment_sounds.lasgun_p1_m1
				-- mod.attachment_sounds.renegade_lasgun_cinematic_02 = mod.attachment_sounds.lasgun_p2_m1
				-- mod.attachment_sounds.renegade_lasgun_cinematic_03 = mod.attachment_sounds.lasgun_p3_m1
				-- mod.attachment_sounds.flamer_npc_01 = mod.attachment_sounds.flamer_p1_m1
			mod.attachment_sounds.forcestaff_p2_m1   = mod.attachment_sounds.forcestaff_p1_m1
			mod.attachment_sounds.forcestaff_p3_m1   = mod.attachment_sounds.forcestaff_p1_m1
			mod.attachment_sounds.forcestaff_p4_m1   = mod.attachment_sounds.forcestaff_p1_m1
		--#endregion
		--#region Melee
			mod.attachment_sounds.combataxe_p1_m2        = mod.attachment_sounds.combataxe_p1_m1
			mod.attachment_sounds.combataxe_p1_m3        = mod.attachment_sounds.combataxe_p1_m1
			mod.attachment_sounds.combataxe_p2_m2        = mod.attachment_sounds.combataxe_p2_m1
			mod.attachment_sounds.combatknife_p1_m2      = mod.attachment_sounds.combatknife_p1_m1
			mod.attachment_sounds.combataxe_p2_m3        = mod.attachment_sounds.combataxe_p2_m1
			mod.attachment_sounds.combataxe_p3_m2        = mod.attachment_sounds.combataxe_p3_m1
			mod.attachment_sounds.combataxe_p3_m3        = mod.attachment_sounds.combataxe_p3_m1
			mod.attachment_sounds.powersword_p1_m2       = mod.attachment_sounds.powersword_p1_m1
			mod.attachment_sounds.powersword_p1_m3       = mod.attachment_sounds.powersword_p1_m1
				-- mod.attachment_sounds.powersword_npc_01    = mod.attachment_sounds.powersword_p1_m1
				-- mod.attachment_sounds.powersword_2h_npc_01 = mod.attachment_sounds.powersword_p1_m1
			mod.attachment_sounds.powersword_2h_p1_m2       = mod.attachment_sounds.powersword_2h_p1_m1
			mod.attachment_sounds.chainaxe_p1_m2         = mod.attachment_sounds.chainaxe_p1_m1
			mod.attachment_sounds.chainsword_p1_m2       = mod.attachment_sounds.chainsword_p1_m1
				-- mod.attachment_sounds.chainsword_npc_01  = mod.attachment_sounds.chainsword_p1_m1
			mod.attachment_sounds.chainsword_2h_p1_m2    = mod.attachment_sounds.chainsword_2h_p1_m1
			mod.attachment_sounds.combatsword_p1_m2      = mod.attachment_sounds.combatsword_p1_m1
			mod.attachment_sounds.combatsword_p1_m3      = mod.attachment_sounds.combatsword_p1_m1
			mod.attachment_sounds.thunderhammer_2h_p1_m2 = mod.attachment_sounds.thunderhammer_2h_p1_m1
			mod.attachment_sounds.combatsword_p2_m2      = mod.attachment_sounds.combatsword_p2_m1
			mod.attachment_sounds.combatsword_p2_m3      = mod.attachment_sounds.combatsword_p2_m1
			mod.attachment_sounds.forcesword_p1_m2       = mod.attachment_sounds.forcesword_p1_m1
			mod.attachment_sounds.forcesword_p1_m3       = mod.attachment_sounds.forcesword_p1_m1
				-- mod.attachment_sounds.forcesword_npc_01  = mod.attachment_sounds.forcesword_p1_m1
			mod.attachment_sounds.forcesword_2h_p1_m2    = mod.attachment_sounds.forcesword_2h_p1_m1
			mod.attachment_sounds.combatsword_p3_m2      = mod.attachment_sounds.combatsword_p3_m1
			mod.attachment_sounds.combatsword_p3_m3      = mod.attachment_sounds.combatsword_p3_m1
			mod.attachment_sounds.powermaul_p1_m2        = mod.attachment_sounds.powermaul_p1_m1
			mod.attachment_sounds.powermaul_shield_p1_m2 = mod.attachment_sounds.powermaul_shield_p1_m1
			-- mod.attachment_sounds.powermaul_p2_m2        = mod.attachment_sounds.powermaul_p2_m1
		--#endregion
	--#endregion
--#endregion