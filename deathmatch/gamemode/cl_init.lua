include ("shared.lua")
include ("deathmatchhud.lua")


local fullhealth = {
	[ "$pp_colour_addr" ] = 0.23,
	[ "$pp_colour_addg" ] = 0.16,
	[ "$pp_colour_addb" ] = 0.09,
	[ "$pp_colour_brightness" ] = -0.2,
	[ "$pp_colour_contrast" ] = 1.31,
	[ "$pp_colour_colour" ] = 0.88,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

--[[purely to see original for development
local lowhealth = {
	[ "$pp_colour_addr" ] = 0.25,
	[ "$pp_colour_addg" ] = 0.16,
	[ "$pp_colour_addb" ] = 0.09,
	[ "$pp_colour_brightness" ] = -0.4,
	[ "$pp_colour_contrast" ] = 1.6,
	[ "$pp_colour_colour" ] = 0.5,
	[ "$pp_colour_mulr" ] = 0.7,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}
]]


local lowhealth = {
	[ "$pp_colour_addr" ] = 0.04,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = -0.2,
	[ "$pp_colour_contrast" ] = 0.5,
	[ "$pp_colour_colour" ] = 0,
	[ "$pp_colour_mulr" ] = 1,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

local finalhealth = {
	[ "$pp_colour_addr" ] = 0.23,
	[ "$pp_colour_addg" ] = 0.16,
	[ "$pp_colour_addb" ] = 0.09,
	[ "$pp_colour_brightness" ] = -0.2,
	[ "$pp_colour_contrast" ] = 1.31,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 1,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

function GM:SpawnMenuOpen()
    return false
end

function GM:ContextMenuOpen()
    return false
end


hook.Add( "RenderScreenspaceEffects", "BloomEffect", function()

ply = LocalPlayer()
localdelta = ((1 - ply:Health()/ply:GetMaxHealth()))
	DrawBloom( 0.5, 0.7, 9, 9, 5, 2, 0.41, 0.3, 0 )

	--DrawBloom( 0.2, 0.4, 9, 9, 5, 2, 0.2, 0.6, 1 )

	for k,v in pairs(finalhealth) do 
	finalhealth[k] = fullhealth[k] + lowhealth[k] * localdelta
	end
	DrawColorModify( finalhealth )
	
end)

net.Receive("updatehealth", function()





end)

net.Receive("addweaponhalo",function()
--[[local ent = net.ReadEntity()
if ent.IsValid then
table.insert(droppedweapontable, ent)
PrintMessage(HUD_PRINTTALK, ent:GetReserveAmmo() .. "is the ammo count this weapon should have")
end]]
end)

net.Receive("removeweaponhalo",function()
   --[[local ent = net.ReadEntity()
    table.RemoveByValue(droppedweapontable, ent)]]
    end)

--[[hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

    for i=1, #droppedweapontable do
    local temptable = {droppedweapontable[i]}
    if droppedweapontable[i]:GetReserveAmmo() != nil and droppedweapontable[i]:GetReserveClipSize() != nil then
	local gunhighlight = Color(255, (droppedweapontable[i]:GetReserveAmmo()/droppedweapontable[i]:GetReserveClipSize() + 0) * 60, 0)
			halo.Add(temptable, gunhighlight, 1, 1, 5, true)
    end
    end
end)]]








-- CLIENT
hook.Add( "InitPostEntity", "Ready", function()

RunConsoleCommand("boredhud_main_r", "255")
RunConsoleCommand("boredhud_main_g", "200")
RunConsoleCommand("boredhud_main_b", "33")

RunConsoleCommand("boredhud_shadow_r", "116")
RunConsoleCommand("boredhud_shadow_g", "0")
RunConsoleCommand("boredhud_shadow_b", "0")

RunConsoleCommand("cl_tfa_hud_crosshair_color_r", "255")
RunConsoleCommand("cl_tfa_hud_crosshair_color_g", "200")
RunConsoleCommand("cl_tfa_hud_crosshair_color_b", "33")
end )

net.Receive("killsound", function(len)

surface.PlaySound( "weapons/357/357_fire2.wav")
surface.PlaySound("npc/roller/blade_out.wav")
end)

net.Receive("MapChange", function(lebt)
RunConsoleCommand("map",randmap)
end)