include("shared.lua")
--util.AddNetworkString("addweaponhalo")
droppedweapontable = {}
local tab = {
	[ "$pp_colour_addr" ] = 0.11,
	[ "$pp_colour_addg" ] = 0.1,
	[ "$pp_colour_addb" ] = 0.09,
	[ "$pp_colour_brightness" ] = -0.15,
	[ "$pp_colour_contrast" ] = 1.31,
	[ "$pp_colour_colour" ] = 0.88,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}
function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end

--[[function updatedroppedguns(tableofguns)

tableofguns
end]]
hook.Add( "RenderScreenspaceEffects", "BloomEffect", function()

	DrawBloom(0.16, 0.8, 9, 9, 5, 1.59, 0.41, 0.2, 0)
    DrawColorModify( tab )

end )



-- CLIENT
hook.Add( "InitPostEntity", "Ready", function()
RunConsoleCommand("boredhud_enable", "1")
RunConsoleCommand("boredhud_scale", "1.18")


RunConsoleCommand("boredhud_main_r", "255")
RunConsoleCommand("boredhud_main_g", "199")
RunConsoleCommand("boredhud_main_b", "33")

RunConsoleCommand("boredhud_shadow_r", "116")
RunConsoleCommand("boredhud_shadow_g", "0")
RunConsoleCommand("boredhud_shadow_b", "0")

RunConsoleCommand("cl_tfa_hud_crosshair_color_r", "365")
RunConsoleCommand("cl_tfa_hud_crosshair_color_g ", "204")
RunConsoleCommand("cl_tfa_hud_crosshair_color_b", "0")


end )

net.Receive("addweaponhalo",function()
local ent = net.ReadEntity()
if ent.IsValid then
table.insert(droppedweapontable, ent)
end
end)

net.Receive("removeweaponhalo",function()
    local ent = net.ReadEntity()
    table.RemoveByValue(droppedweapontable, ent)
    end)

hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

    for i=1, #droppedweapontable do
    local temptable = {droppedweapontable[i]}
    if droppedweapontable[i]:GetReserveAmmo() != nil and droppedweapontable[i]:GetReserveClipSize() != nil then
	local gunhighlight = Color(255, (droppedweapontable[i]:GetReserveAmmo()/droppedweapontable[i]:GetReserveClipSize() + 0) * 60, 0)
			halo.Add(temptable, gunhighlight, 1, 1, 5, true)
    end
    end
end)
