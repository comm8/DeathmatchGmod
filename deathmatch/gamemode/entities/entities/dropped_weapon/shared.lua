ENT.type = "anim"
ENT.Base = "base_gmodentity"
--ENT.Category = "bubby"
ENT.PrintName = "Ground Weapon"
ENT.Author = "Comm8"
ENT.Purpose = "a weapon dropped from a player"
ENT.Instructions = "developer testing"
--ENT.Spawnable = true
--ENT.AdminSpawnable = false

function ENT:SetupDataTables()
self:NetworkVar("Int",0,"ReserveAmmo")
self:NetworkVar("Int",1,"ReserveAmmoType")
self:NetworkVar("String",0,"GunName")   
end

