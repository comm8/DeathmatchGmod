AddCSLuaFile("perlin.lua")
include ("shared.lua")
include ("deathmatchhud.lua")

CreateClientConVar("cr_maxhalos", "10", true, false, "Turns off the weapon highlights to improve performance!", 0)
CreateClientConVar("cr_playermodel", "models/player/police_fem.mdl", true, true)


--[[local fullhealth = {
	[ "$pp_colour_addr" ] = 0.23,
	[ "$pp_colour_addg" ] = 0.16,
	[ "$pp_colour_addb" ] = 0.09,
	[ "$pp_colour_brightness" ] = -0.2,
	[ "$pp_colour_contrast" ] = 1.31,
	[ "$pp_colour_colour" ] = 0.88,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}]]


local fullhealth = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

--[[local lowhealth2 = {
	[ "$pp_colour_addr" ] = 0.1,
	[ "$pp_colour_addg" ] = 0.3,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = -0.25,
	[ "$pp_colour_contrast" ] = 1.5,
	[ "$pp_colour_colour" ] = 0.1,
	[ "$pp_colour_mulr" ] = 3,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}]]

local lowhealth = {
	[ "$pp_colour_addr" ] = 0.2,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = -0.1,
	[ "$pp_colour_contrast" ] = 0.1,
	[ "$pp_colour_colour" ] = -0.7,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = -0.2,
	[ "$pp_colour_mulb" ] = -0.2
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
	DrawBloom( 0.7, 3, 10, 10, 5, 1, 0.41, 0.3, 0.1 )

	localdelta = LerpInverseLog((ply:Health()/ply:GetMaxHealth()))
	for k,v in pairs(finalhealth) do 
	finalhealth[k] = fullhealth[k] + (lowhealth[k] * localdelta)
	end
	DrawColorModify( finalhealth )
	
end)

net.Receive("updatehealth", function()





end)




-- CLIENT
hook.Add( "InitPostEntity", "Ready", function()

end )

net.Receive("killsound", function(len)

surface.PlaySound( "weapons/357/357_fire2.wav")
surface.PlaySound("npc/roller/blade_out.wav")
end)

net.Receive("MapChange", function(lebt)
RunConsoleCommand("map",randmap)
end)