include("shared.lua")
--util.AddNetworkString("addweaponhalo")
droppedweapontable = {}
function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end

--[[function updatedroppedguns(tableofguns)

tableofguns
end]]

net.Receive("addweaponhalo",function()
local ent = net.ReadEntity()
table.insert(droppedweapontable, ent)
end)

net.Receive("removeweaponhalo",function()
    local ent = net.ReadEntity()
    table.RemoveByValue(droppedweapontable, ent)
    end)

hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

    for i=1, #droppedweapontable do
    local temptable = {droppedweapontable[i]}
	local gunhighlight = Color(255, (droppedweapontable[i]:GetReserveAmmo()/droppedweapontable[i]:GetReserveClipSize()) * 60, 0)
			halo.Add(temptable, gunhighlight, 1, 1, 5, true)
    end

end)
