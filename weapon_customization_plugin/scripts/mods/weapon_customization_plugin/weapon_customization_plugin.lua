local mod = get_mod("weapon_customization_plugin")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local table = table
    local ipairs = ipairs
    local pairs = pairs
    local vector3_box = Vector3Box
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local _item = "content/items/weapons/player"
local _item_ranged = _item.."/ranged"
local _item_melee = _item.."/melee"
local _item_minion = "content/items/weapons/minions"

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

table.prepend = function(t1, t2)
    for i, d in ipairs(t2) do
        table.insert(t1, i, d)
    end
end

-- ##### ┬┌┐┌ ┬┌─┐┌─┐┌┬┐ ##############################################################################################
-- ##### ││││ │├┤ │   │  ##############################################################################################
-- ##### ┴┘└┘└┘└─┘└─┘ ┴  ##############################################################################################

function mod.on_all_mods_loaded()
    local wc = get_mod("weapon_customization")
    if wc then

        -- ##### Inject attachment definitions ########################################################################
        -- id           = name of model entry below
        -- name         = text shown when attachment name generation not working / active
        -- no_randomize = don't use this attachment in randomize process
        table.insert(
            wc.attachment.autogun_p1_m1.sight,
            {id = "autogun_pistol_sight_01", name = "Autopistol Sight"}
        )

        -- ##### Inject attachment models #############################################################################
        -- parent           = parent attachment in the weapon; if game already has correct parent 'nil' can be used
            -- example: parent = "barrel" <- new parent is barrel and position / rotation is applied from this origin
        -- angle            = angle for camera movement in customization view
            -- example: angle = .5 
        -- move             = offset for camera movement in customization view
        -- remove           = movement of the attachment in build animation
        -- automatic_equip  = automatically equip other attachments when this one is equipped;
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty", rail = "rail_default"}
            -- example: automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"} <- only equip when not already equipped
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_01"} <- only equip when first equipped
        -- no_support       = define attachments that are not (supported; either specific attachment name or attachment slot
            -- example: no_support = {"barrel_01"} <- no support for specific attachment
            -- example: no_support = {"trinket_hook"} <- no support for trinket hooks
        -- mesh_move        = move meshes instead of unit or both
            -- values: true ( move only meshes ), false ( default ), "both" ( move both )
        -- hide_mesh        = hide meshes in specific attachments
            -- example: hide_mesh = {{"barrel", 8}}
            -- example: hide_mesh = {{"barrel", 1, 2}, {"rail", 5}} <- multiple attachments; multiple meshes;
        -- trigger_move     = trigger a move animation in a different attachment slot in customization menu
            -- example: trigger_move = {"emblem_left", "emblem_right"}
        -- special_resolve  = function callback for special complex attachment resolve methods
            -- Parameters gear_id, item, attachment
            -- example: special_resolve = function(gear_id, item, attachment)
                -- local changes = {}
                -- if string_find(attachment, "default") then
                --     if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                --     if mod:get_gear_setting(gear_id, "pommel", item) ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                -- else
                --     if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "head_01" end
                --     if mod:get_gear_setting(gear_id, "pommel", item) == "pommel_default" then changes["pommel"] = "pommel_01" end
                -- end
                -- return changes <- important return table of changes
            -- end
        table.merge_recursive(
            wc.attachment_models.autogun_p1_m1,
            {autogun_pistol_sight_01 = {model = _item_ranged.."/sights/autogun_pistol_sight_01", type = "sight", parent = "rail", angle = 0,
                move = vector3_box(0, 0, 0), remove = vector3_box(0, -.2, 0), automatic_equip = {rail = "rail_01"}}}
        )

        -- ##### Inject attachment fixes ##############################################################################
        -- dependencies     = list of dependencies for which the fix applies
            -- example: dependencies = {"barrel_01"} <- applies to all combinations with barrel_01
            -- example: dependencies = {"barrel_01", "!receiver_02"} <- applies to combinations with barrel_01 and receivers other than receiver_02
            -- example: dependencies = {"barrel_01|barrel_02|barrel_03"} <- applies to combinations with barrel_01, barrel_02 or barrel_03
        -- offset = true    = attachment won't be reparented when it is loaded
        -- parent           = reparent the attachment to this attachment when it is loaded
            -- example: parent = "barrel" <- new parent is barrel and position / rotation is applied from this origin
        -- parent_node      = node in the parent used for reparenting
            -- example: parent_node = 9
        -- position         = position the attachment should have
            -- example: position = vector3_box(.2, 0, .04)
        -- mesh_position    = position meshes differently from unit itself
            -- example: mesh_position = vector3_box(.2, 0, .04)
        -- mesh_index       = specific mesh index for mesh_position
            -- example: mesh_index = 8
        -- rotation         = rotation the attachment should have
            -- example: position = vector3_box(10, 0, 90)
        -- rotation_node    = node the rotation should be applied to
            -- example: rotation_node = 2
        -- scale            = scale the attachment should have
            -- example: position = vector3_box(1, 1, 1) <- 1 is normal
        -- scale_node       = node the scale should be applied to
            -- example: scale_node = 8
        -- automatic_equip  = automatically equip other attachments when this one is equipped;
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty", rail = "rail_default"}
            -- example: automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"} <- only equip when not already equipped
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_01"} <- only equip when first equipped
        -- no_support       = define attachments that are not (supported; either specific attachment name or attachment slot
            -- example: no_support = {"barrel_01"} <- no support for specific attachment
            -- example: no_support = {"trinket_hook"} <- no support for trinket hooks
        table.prepend(
            wc.anchors.autogun_p1_m1.fixes,
            {
                -- Rail
                {dependencies = {"autogun_pistol_sight_01", "!receiver_01"},
                    rail = {scale = vector3_box(0, 0, 0)}},
                -- Sight
                {dependencies = {"autogun_pistol_sight_01"},
                    sight = {offset = true, position = vector3_box(0, .01, 0)}},
            }
        )

        -- ##### Inject sight #########################################################################################
        table.insert(
            wc.sights,
            "autogun_pistol_sight_01"
        )

    end
end
