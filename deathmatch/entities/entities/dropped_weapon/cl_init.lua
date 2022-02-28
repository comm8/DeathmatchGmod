include("shared.lua")
--util.AddNetworkString("addweaponhalo")
droppedweapontable = {}
function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end


function ENT:Initialize()
local weaponstats = {self, self:GetReserveAmmo()/self:GetReserveClipSize()}
table.insert(droppedweapontable, weaponstats)
print(weaponstats[2])
end


hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

    if GetConVar("cr_showhalos"):GetInt() == 1 then
        for i=1, #droppedweapontable do
            local temptable = {droppedweapontable[i][1]}
	            local gunhighlight = Color(255, (droppedweapontable[i][2]) * 60, 0)
			    halo.Add(temptable, gunhighlight, 2, 2 , 3, true)
        end
    end
end)

--[[function updatedroppedguns(tableofguns)

tableofguns
end]]

