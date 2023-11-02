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

-- ##### ┬┌┐┌ ┬┌─┐┌─┐┌┬┐ ##############################################################################################
-- ##### ││││ │├┤ │   │  ##############################################################################################
-- ##### ┴┘└┘└┘└─┘└─┘ ┴  ##############################################################################################

function mod.on_all_mods_loaded()
    local wc = get_mod("weapon_customization")
    if wc then -- Check if it is installed
        mod:echo("Injecting stuff")
        -- ##### Inject attachment definitions ########################################################################
        -- id   = name of model entry below
        -- name = text shown when attachment name generation not working / active
        wc.attachment.ogryn_heavystubber_p1_m1.barrel = table.icombine(
            wc.attachment.ogryn_heavystubber_p1_m1.barrel,
            {
                {id = "barrel_04", name = "Barrel 4"},
            }
        )
        -- Debug output
        -- mod:dtf(wc.attachment.ogryn_heavystubber_p1_m1.barrel, "attachment_barrels", 5)

        -- ##### Inject attachment models #############################################################################
        -- parent           = parent attachment in the weapon; if game already has correct parent 'nil' can be used
        -- angle            = angle for camera movement in customization view
        -- move             = offset for camera movement in customization view
        -- remove           = movement of the attachment in build animation
        -- automatic_equip  = automatically equip other attachments when this one is equipped;
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty", rail = "rail_default"}
            -- example: automatic_equip = {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"} <- only equip when not already equipped
            -- example: automatic_equip = {trinket_hook = "trinket_hook_empty|trinket_01"} <- only equip when first equipped
        -- no_support       = define attachments that are not supported; either specific attachment name or attachment slot
            -- example: no_support = {"barrel_01"} <- no support for specific attachment
            -- example: no_support = {"trinket_hook"} <- no support for trinket hooks
        -- mesh_move        = move meshes instead of unit or both
            -- values: true ( move only meshes ), false ( default ), "both" ( move both )
        -- hide_mesh        = hide meshes in specific attachments
            -- example: hide_mesh = {{"barrel", 8}}
            -- example: hide_mesh = {{"barrel", 1, 2}, {"rail", 5}} <- multiple attachments; multiple meshes;
        wc.attachment_models.ogryn_heavystubber_p1_m1 = table.combine(
            wc.attachment_models.ogryn_heavystubber_p1_m1,
            {
                barrel_04 = {model = _item_ranged.."/barrels/shotgun_rifle_barrel_04", type = "barrel", parent = "receiver", angle = 0,
                    move = vector3_box(0, 0, 0), remove = vector3_box(0, .2, 0), automatic_equip = nil, no_support = nil, mesh_move = true, hide_mesh = nil},
            }
        )
        -- Debug output
        -- mod:dtf(wc.attachment_models.ogryn_heavystubber_p1_m1, "attachment_models_barrels", 5)

        -- Inject copies for other weapon variants
        wc.attachment_models.ogryn_heavystubber_p1_m2 = wc.attachment_models.ogryn_heavystubber_p1_m1
        wc.attachment_models.ogryn_heavystubber_p1_m3 = wc.attachment_models.ogryn_heavystubber_p1_m1
    else
        mod:echo("weapon_customization not found")
        -- weapon_customization is not installed
    end
end
