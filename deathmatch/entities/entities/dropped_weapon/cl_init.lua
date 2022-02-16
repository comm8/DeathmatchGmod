include("shared.lua")
droppedweapontable = {}
function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end

--[[function updatedroppedguns(tableofguns)

tableofguns
end]]

function updatedroppedguns(ent)
table.insert(droppedweapontable, ent)
end

hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

	local gunhighlight = Color(255, 0, 0)
    --local gunbacklight = Color(255, 50, 50)
	--local gunlist = {}
    --gunlist = ents.FindByClass("dropped_weapon")
			halo.Add(droppedweapontable, gunhighlight, 1, 1, 5, true)
            --halo.Add(gunlist, gunbacklight, 10, 10, 2, true)

end)
