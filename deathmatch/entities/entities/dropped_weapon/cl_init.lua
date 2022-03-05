include("shared.lua")
--util.AddNetworkString("addweaponhalo")
droppedweapontable = {}
maxhalos = 10


function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end


function ENT:Initialize()
    local weaponstats = {self, self:GetReserveAmmo()/self:GetReserveClipSize(), self:GetPos()}
    table.insert(droppedweapontable, weaponstats)
end

function ENT:OnRemove()
    local weaponstats = {self, self:GetReserveAmmo()/self:GetReserveClipSize()}
    table.RemoveByValue(droppedweapontable, weaponstats)
end

hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

playerpos = LocalPlayer():GetPos()
    table.sort( droppedweapontable, function(a, b) return playerpos:DistToSqr(a[3]) < playerpos:DistToSqr(b[3]) end )


    if GetConVar("cr_maxhalos"):GetInt() > 0 then
        for i=1, math.min(#droppedweapontable, GetConVar("cr_maxhalos"):GetInt()) do
                local temptable = {droppedweapontable[i][1]}
	            local gunhighlight = Color(255, (droppedweapontable[i][2]) * 60, 0)
			    halo.Add(temptable, gunhighlight, 2, 2 , 5, true)            
        end
    end
end)

--[[function updatedroppedguns(tableofguns)

tableofguns
end]]

