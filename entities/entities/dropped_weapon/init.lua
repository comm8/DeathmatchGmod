AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
game.AddParticles("vortigaunt_fx.pcf")
PrecacheParticleSystem("vortigaunt_glow_charge_cp1" )

function ENT:Initialize()
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)
self:GetPhysicsObject():SetMass(800)
self:GetPhysicsObject():SetDragCoefficient(60)
self:SetUseType(SIMPLE_USE)
self:SetFriction(10)
local phys = self:GetPhysicsObject()
if(IsValid(phys)) then
    phys:Wake()
end
self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

function ENT:Use(activator, caller)

    activator:SetViewPunchAngles(Angle(0,0,0))
    activator:ViewPunch(Angle(-10,0,0))

    local activeweapon = activator:GetWeapon(activator:GetNWString("primaryweaponname"))
    local playerweaponname = activeweapon:GetClass()

    local playerweaponammo = self:GetReserveAmmo()
    local playerammotype = self:GetReserveAmmoType()
    local playerclipammo = self:GetReserveClipSize()

self:SetReserveAmmoType(activeweapon:GetPrimaryAmmoType())
self:SetReserveClipSize(activeweapon:Clip1())

self:SetReserveAmmo(activator:GetAmmoCount(self:GetReserveAmmoType()))
if activator:GetAmmoCount(self:GetReserveAmmoType()) + activeweapon:Clip1() == 0 then
    net.Start("removeweaponhalo", false)
    net.WriteEntity(self)
    local rf = RecipientFilter()
    rf:AddAllPlayers()
    net.Send(rf)
    ParticleEffect( "vortigaunt_hand_glow_b", self:GetPos(), Angle( 0, 0, 0 ))
    self:Remove()

end

activator:RemoveAmmo(activator:GetAmmoCount(activeweapon:GetPrimaryAmmoType()), activeweapon:GetPrimaryAmmoType())
activator:StripWeapon(activeweapon:GetClass())
activator:GiveAmmo(playerweaponammo, playerammotype, true)
activator:Give(self:GetGunName(),true)
activator:SelectWeapon(self:GetGunName())
self:SetModel(activeweapon:GetWeaponWorldModel())
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)
active = activator:GetWeapon(self:GetGunName())
active:SetClip1(playerclipammo)
activator:SetNWString("primaryweaponname", self:GetGunName())

local gunnumber = self:GetGunNum()
self:SetGunNum(activator:GetNWInt("GunTableNum"))
activator:SetNWInt("GunTableNum", gunnumber)
--PrintMessage(HUD_PRINTTALK, activator:GetNWInt("GunTableNum"))

self:SetGunName(playerweaponname)
self:SetPos(activator:GetPos() + (activator:GetAngles():Forward() * 0) + (activator:GetAngles():Up() * 55))
self:GetPhysicsObject():SetVelocity((activator:GetAngles():Forward() * 40) + (activator:GetAngles():Up() * 25) + (activator:GetVelocity() * 1))
end