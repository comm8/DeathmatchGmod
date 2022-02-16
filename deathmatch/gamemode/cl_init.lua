include ("shared.lua")
include ("deathmatchhud.lua")
include ("weapon_data.lua")

function GM:SpawnMenuOpen()
    return false
end

function GM:ContextMenuOpen()
    return false
end

net.Receive("killsound", function(len)

surface.PlaySound( "weapons/357/357_fire2.wav")
surface.PlaySound("npc/roller/blade_out.wav")
end)

net.Receive("MapChange", function(lebt)
RunConsoleCommand("map",randmap)
end)