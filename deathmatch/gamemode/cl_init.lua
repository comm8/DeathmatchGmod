include ("shared.lua")
include ("deathmatchhud.lua")
--include ("weapon_data.lua")
local tab = {
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
function GM:SpawnMenuOpen()
    return false
end

function GM:ContextMenuOpen()
    return false
end

hook.Add( "RenderScreenspaceEffects", "BloomEffect", function()

	DrawBloom( 0.5, 0.7, 9, 9, 5, 2, 0.41, 0.3, 0 )
	DrawColorModify( tab )
end )

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