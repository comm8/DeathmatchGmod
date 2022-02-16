include("shared.lua")

function ENT:Draw()
self:DrawModel()
--print(self:GetReserveAmmo())
--self:SetReserveAmmo(self:GetReserveAmmo()+1)
end

hook.Add("PreDrawHalos", "DrawFakeWeaponHalo", function()

	local gunhighlight = Color(255, 0, 0)
    local gunbacklight = Color(255, 50, 50)
	local gunlist = {}
    gunlist = ents.FindByClass("dropped_weapon") 
			halo.Add(gunlist, gunhighlight, 1, 1, 4, true)
            halo.Add(gunlist, gunbacklight, 10, 10, 2, true)

end)
