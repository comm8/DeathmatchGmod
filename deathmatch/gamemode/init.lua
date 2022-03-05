AddCSLuaFile ("cl_init.lua")
AddCSLuaFile ("shared.lua")
AddCSLuaFile ("deathmatchhud.lua")
--include("perlin/perlin.lua")
--include("camerafx/camerafx.lua")
include ("shared.lua")
--include a bunch of files

util.AddNetworkString("killsound")
util.AddNetworkString("MapChange")
util.AddNetworkString("addweaponhalo")
util.AddNetworkString("removeweaponhalo")
util.AddNetworkString("updaterounds")
util.AddNetworkString("updatehealth")
--add a bunch of network calls to let clients know whats going on

--function SWEP:Attach(slot, att)
--function SWEP:GetCurrentAttachment(slot)
--function SWEP:GetCustomizationIndex(name)


hook.Add("Initialize", "cahjec", function()
--this is called when the server starts

concommand.Add("cr_createdroppedweapon", function(ply, cmd, args, str)
    
    for i=1, args[1] do
    
    
    local ent = ents.Create("dropped_weapon")
    local droppedweapon = ply:GetWeapon(ply:GetNWString("primaryweaponname"))
    droppedammotype = droppedweapon:GetPrimaryAmmoType()
    if ply:GetAmmoCount(droppedammotype) != nil && ply:GetAmmoCount(droppedammotype) + droppedweapon:Clip1() > 0 then
    ent:SetModel(droppedweapon:GetWeaponWorldModel())
    ent:SetReserveAmmo(ply:GetAmmoCount(droppedammotype) + droppedweapon:Clip1())
    ent:SetReserveAmmoType(droppedammotype)
    ent:SetGunName(droppedweapon:GetClass())
    ent:SetGunNum(ply:GetNWInt("GunTableNum"))
    ent:SetPos(ply:GetPos() + (ply:GetUp() * 30) + ((Vector(i, i, 0) * 10)))
    ent:Spawn()
    ent:Activate()
    ent:GetPhysicsObject():SetVelocity(ply:GetVelocity() * 1.2)
    ent:SetReserveClipSize(droppedweapon:GetMaxClip1())
    net.Start("addweaponhalo", false)
    net.WriteEntity(ent)
    local rf = RecipientFilter()
    rf:AddAllPlayers()
    net.Send(rf)
    end

end

end)


concommand.Add("cr_perlin", function(ply, cmd, args, str)
    PerlinLoad()
    perlinvector = {0,0,0}
    for i=1, #args do
    perlinvector[i] = args[i]
    end
    print(PerlinNoise(perlinvector[1],perlinvector[2],perlinvector[3]))
    
    end)



concommand.Add("cr_reset", function(ply, cmd, ags, str)

    CRResetMatch()
        
    
    end)


concommand.Add("cr_saveweapdata", function(ply, cmd, ags, str)

SaveWeaponDataToJSON()


end)


concommand.Add( "cr_weapon", function( ply, cmd, args, str )
--were creating a console command that we can use to replace weapons

    for k,v in pairs(gunlist) do
 local curweaponstat = gunlist[k]

 if curweaponstat["name"] == args[1] then
ply:StripWeapon(ply:GetNWString("primaryweaponname"))
ply:SetNWString("primaryweaponname", curweaponstat["name"])
ply:Give(curweaponstat["name"], false)
 else 

    PrintMessage(HUD_PRINTTALK, "Weapon " .. args[1] .. " was not found when compared with " .. curweaponstat["name"])

 end
end  
end )


concommand.Add("cr_getmwbaseattachments", function(ply, cmd, ags, str)

ply:GetActiveWeapon():GetCustomizationIndex(name)
    
    
    end)

--Running some commands to get all the gun values right
RunConsoleCommand("mgbase_sv_pvedamage", "0.2")
RunConsoleCommand("mgbase_sv_recoil", "4")


RunConsoleCommand("sv_tfa_damage_multiplier", "0.3")
RunConsoleCommand("sv_tfa_recoil_mul_y", "0.5")
RunConsoleCommand("sv_tfa_recoil_mul_p", "0.5")
RunConsoleCommand("sv_tfa_spread_multiplier", "3")
RunConsoleCommand("sv_tfa_cmenu", "0")

secondaryweapon = "tfa_mwr_harpoon"
--the second "lesser" weapon everyone always spawns with


runmapvote = 1
--how many map votes we've ran +1

shielddowntime = 5
--how long armor is down for after taking damage before it starts going back up


shieldtick = 0.5
--how much time in seconds inbetween armor going up by 1

    shieldcooldownplayer = {}
    shieldregenplayer = {}


    --these entities will be removed from the map on start
    banneditems = {
        "item_item_crate",
        "weapon_357",
        "weapon_pistol",
        "weapon_crossbow", 
        "weapon_crowbar",
        "weapon_frag",
        "weapon_physcannon",
        "weapon_ar2",
        "weapon_rpg",
        "weapon_slam",
        "weapon_shotgun",
        "weapon_smg1",
        "weapon_stunstick",
        "weapon_physgun",
        "item_ammo_smg1",
        "item_ammo_357",
        "item_ammo_357_large",
        "item_ammo_357_large",
        "item_ammo_ar2",
        "item_ammo_ar2_large",
        "item_ammo_ar2_altfire",
        "item_ammo_crossbow",
        "item_ammo_pistol",
        "item_ammo_pistol_large",
        "item_rpg_round",
        "item_box_buckshot",
        "item_ammo_smg1_large",
        "item_ammo_smg1_grenade",
        "npc_grenade_frag"
    }

    --when you join you get given a random PM from this list
    randmodel = {
        "models/player/police.mdl",
        "models/player/police_fem.mdl"
    }


    --flavortext to replace "killed" for when you kill
    killlist = {
        "vanquished",
        "ended",
        "sodomized",
        "broke",
        "destroyed",
        "eliminated",
        "terminated",
        "slaughtered",
        "deleted",
        "erased",
        "wiped out",

    }

    maplist = {
    "dm_anal",
    "dm_basebunker",
    "dm_dizzy",
    "dm_drift",
    "dm_overwatch_cm",
    "dm_powerhouse",
    "dm_underpass",
    "gm_quarantine"
                    }

PrintMessage(HUD_PRINTTALK, GetConVar("cr_weaplist"):GetString() .. ".json")
gunliststring = file.Read(GetConVar("cr_weaplist"):GetString() .. ".json")
gunlist = util.JSONToTable(gunliststring)

--were going to change the core weapon values for the server now so the weapons are correctly balanced
   for k,v in pairs(gunlist) do
local temporaryweaponvalues = gunlist[k]
local temporaryweapon = weapons.GetStored(temporaryweaponvalues["name"])
--WE ARE WORKING UNDER THE ASSUMPTION THESE ARE TFA WEAPONS!!

if temporaryweapon != nil then


if temporaryweaponvalues["dmgp"] != nil then
temporaryweapon.Primary.Damage = temporaryweapon.Primary.Damage * (temporaryweaponvalues["dmgp"] / 100)
end

if temporaryweaponvalues["clp"] != nil then
    if temporaryweapon.Base != "mg_base" then
    temporaryweapon.Primary.DefaultClip = temporaryweapon.Primary.ClipSize * temporaryweaponvalues["clp"]
    end
end

if temporaryweaponvalues["sprp"] != nil then
--temporaryweapon.Primary.Spread  = .08
--temporaryweapon.Primary.IronAccuracy = 0.1
--temporaryweapon.Primary.SpreadMultiplierMax = 1
--temporaryweapon.Primary.SpreadIncrement = .5
--temporaryweapon.Primary_TFA.Spread = 12.3
--temporaryweapon:ClearStatCache("Primary.Spread")
end
--temporaryweapon.Primary.Automatic = true


else 

    PrintMessage(HUD_PRINTTALK, "Weapon " .. temporaryweaponvalues["name"] .. " was not found!")

end
end


end)

function GM:PlayerInitialSpawn(player, transition)
    
    local rand = math.random(#randmodel)
    player:SetModel(randmodel[rand])
end




function CRResetMatch()
   local allplayers = player.GetAll()
   for i=1,#allplayers do
    allplayers[i]:Kill()
   end  

game.CleanUpMap(false)

for i=1, #banneditems do
    local currentgroup = ents.FindByClass(banneditems[i])
    for y=1, #currentgroup do
    local current = currentgroup[y]
    current:Remove()
    end
    --RunConsoleCommand("ent_remove_all", banneditems[i])
    end





end

function GM:InitPostEntity()
    for i=1, #banneditems do
    local currentgroup = ents.FindByClass(banneditems[i])
    for y=1, #currentgroup do
    local current = currentgroup[y]
    current:Remove()
    end
    --RunConsoleCommand("ent_remove_all", banneditems[i])
    end
end

function Playerdying(victim, attacker)
    local ent = ents.Create("dropped_weapon")
    local droppedweapon = victim:GetWeapon(victim:GetNWString("primaryweaponname"))
    droppedammotype = droppedweapon:GetPrimaryAmmoType()
    if victim:GetAmmoCount(droppedammotype) != nil && victim:GetAmmoCount(droppedammotype) + droppedweapon:Clip1() > 0 then
    ent:SetModel(droppedweapon:GetWeaponWorldModel())
    ent:SetReserveAmmo(victim:GetAmmoCount(droppedammotype) + droppedweapon:Clip1())
    ent:SetReserveAmmoType(droppedammotype)
    ent:SetGunName(droppedweapon:GetClass())
    ent:SetGunNum(victim:GetNWInt("GunTableNum"))
    ent:SetPos((victim:GetPos() + (victim:GetUp() * 30)))
    ent:Spawn()
    ent:Activate()
    ent:GetPhysicsObject():SetVelocity(victim:GetVelocity() * 1.2)
    ent:SetReserveClipSize(droppedweapon:GetMaxClip1())
    net.Start("addweaponhalo", false)
    net.WriteEntity(ent)
    local rf = RecipientFilter()
    rf:AddAllPlayers()
    net.Send(rf)

    end

    if attacker != victim && attacker:IsPlayer() == true then
    net.Start("killsound")
    net.Send(attacker)
    attacker:SetNWInt("PlayerKills", attacker:GetNWInt("PlayerKills") + 1)
    print(attacker:GetNWInt("PlayerKills"))
    local selectedkill = math.random(#killlist)
    PrintMessage(HUD_PRINTTALK, victim:Nick() .. " was " .. killlist[selectedkill] .. " by ".. attacker:Nick() .. " with the " .. attacker:GetActiveWeapon():GetPrintName())

    local wep = attacker:GetWeapon(attacker:GetNWString("primaryweaponname"))
    local ammotype = wep:GetPrimaryAmmoType()
    local clipsize = wep:GetMaxClip1()
    attacker:GiveAmmo(clipsize,ammotype,true)
    --inflictor:SetArmor (inflictor:Armor() + 1)
else

    PrintMessage(HUD_PRINTTALK, victim:Nick() .. " took the easy way out")
end

end

hook.Add("DoPlayerDeath", "theplayerfuccingdied", Playerdying)


function GM:PlayerSpawn(ply)
if GetConVar("cr_sauceify"):GetInt() == 0 then
    randomnum = math.random(#gunlist)
    randguntemp = gunlist[randomnum]
    randgun = randguntemp["name"]

ply:AllowFlashlight(true)
ply:SetGravity(1)
ply:SetJumpPower(250)
ply:SetMaxHealth(100)
ply:SetHealth(100)
ply:SetArmor(0)
ply:SetMaxArmor(50)
ply:SetRunSpeed(350)
ply:SetWalkSpeed(220)
ply:SetCrouchedWalkSpeed(100)
ply:Give(randgun, false )

elseif GetConVar("cr_sauceify"):GetInt() == 1  then
    
    ply:AllowFlashlight(true)
    ply:SetGravity(1)
    ply:SetJumpPower(250)
    ply:SetMaxHealth(100)
    ply:SetHealth(100)
    ply:SetArmor(0)
    ply:SetMaxArmor(50)
    ply:SetRunSpeed(350)
    ply:SetWalkSpeed(220)
    ply:SetCrouchedWalkSpeed(100)
    randgun = "weapon_ar2"
    ply:Give(randgun)
    local activegun = ply:GetActiveWeapon()
    ply:GiveAmmo(1000, activegun:GetPrimaryAmmoType())

end
activegun = ply:GetActiveWeapon()

if activegun == nil then
PrintMessage(HUD_PRINTTALK, randgun .. " was not found!")
end

if activegun.Base == "mg_base" then
ply:GiveAmmo(activegun:Clip1() * randguntemp["clp"], activegun:GetPrimaryAmmoType())
end
activegun.Attachments = randguntemp[4]
ply:SetNWString("primaryweaponname", randgun)
    --PrintMessage(HUD_PRINTTALK, randgun)
ply:SetNWInt("GunTableNum", randomnum)
ply:Give(secondaryweapon)
ply:Give("weapon_frag")
ply:GiveAmmo(2, "Grenade")
    --PrintMessage(HUD_PRINTTALK, util.TableToJSON(activegun.Attachments))
    --PrintMessage(HUD_PRINTTALK, ply:GetNWInt("GunTableNum"))
      
    
    
    local rand = math.random(#randmodel)
    ply:SetModel(randmodel[rand])
    ply:SetupHands()
end


mapselect = {

}

hook.Add("EntityTakeDamage", "afergrth", function(entity, dmg)
if entity:IsPlayer() == true then
    
  --  net.Start("updatehealth", false)
  --  net.Write(healthremaining)
  -- net.Send(entity)

    entity:SetNWInt("damagetime", CurTime())
    shieldcooldownplayer[#shieldcooldownplayer + 1] = entity
for i=1, #shieldregenplayer do 
if !IsValid(shieldregenplayer[i]) then
table.remove(shieldregenplayer, i)
end
end
end
end)

function setattachments(ply)

local gunstats = gunlist[ply:GetNWInt("GunTableNum")]
--ply:GetActiveWeapon().Attachments = gunstats[4]

--[[local currentweapon = ply:GetActiveWeapon()
local currentweaponclass = currentweapon:GetClass()

	for k, v in pairs(currentweapon.Attachments) do
		timer.Simple(0.1, function()
			if currentweapon.Attachments[k] then
				currentweapon:Attach()
			end
		end)
	end

    ply:GetActiveWeapon():Attach("cod_scope_acog")

    PrintMessage(HUD_PRINTTALK, util.TableToJSON(ply:GetActiveWeapon().Attachments))]]
end

function GM:Think()
for i=1, #shieldcooldownplayer do
if CurTime() > shieldcooldownplayer[i]:GetNWInt("damagetime") + shielddowntime then
local player = shieldcooldownplayer[i]
player:SetNWInt("healthtick", CurTime() + shieldtick)
table.remove(shieldcooldownplayer, i)
shieldregenplayer[#shieldregenplayer + 1] = player

return
end
end
for i=1, #shieldregenplayer do
local shieldplayer = shieldregenplayer[i]
if IsValid(shieldplayer) then
    table.RemoveByValue( shieldregenplayer, shieldplayer )
    return
end
if shieldplayer:Health() < shieldplayer:GetMaxHealth() && shieldplayer:GetNWInt("healthtick") < CurTime() then
shieldplayer:SetHealth(shieldplayer:Health() + 1)
shieldplayer:SetNWInt("healthtick", CurTime() + shieldtick)
elseif shieldplayer:Health() >= shieldplayer:GetMaxHealth() then
table.remove(shieldregenplayer, i)
end
end

if GetConVar("cr_roundtime"):GetInt() > 0 then
if CurTime() > GetConVar("cr_roundtime"):GetInt() * runmapvote then
MapVote.Start(15, true, 5, "dm")
runmapvote = runmapvote + 1
end
end
end









--[[function SaveWeaponDataToJSON()
    local TempJSONTableContainer = {}
for k,v in pairs(gunlist) do

TempJSONTableContainer[k+1] = converted
local converted = util.TableToJSON(gunlist[k+1])
end
PrintTable(TempJSONTableContainer)
file.Write("weapondata.json", util.TableToJSON(TempJSONTableContainer))
end
]]

function SaveWeaponDataToJSON()
    secondarygunlist = {
        {
        ["name"] = "mg_357", -- weapon class 
        --AK 47 
        --A medium damage medium range weapon useful in most situations
        
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_charlie725", -- weapon class 
        --AK 74u
        --The close range variant of the AK 47
        --useful because of its high magazine count
        --lower damage from afar
        
        ["dmgp"] = 200, --damage % compared to original
        ["clp"] = 4, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_akilo47", -- weapon class 
        ["dmgp"] = 80, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_anovember94", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_valpha", -- weapon class 
        ["dmgp"] = 110, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_galima", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_falima", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_scharlie", -- weapon class 
        ["dmgp"] = 120, --damage % compared to original
        ["clp"] = 1, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_falpha", -- weapon class 
        ["dmgp"] = 10, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_sierra552", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_aalpha12", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_kilo433", -- weapon class 
        ["dmgp"] = 900, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_mcharlie", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_p320", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 5, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_m1911", -- weapon class 
        ["dmgp"] = 120, --damage % compared to original
        ["clp"] = 3,--amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_mike4", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 20, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_makarov", -- weapon class 
        ["dmgp"] = 110, --damage % compared to original
        ["clp"] = 4, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_romeo870", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_asierra12", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_oscar12", -- weapon class 
        ["dmgp"] = 130, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_dpapa12", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_tango21", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_m9", -- weapon class 
        ["dmgp"] = 110, --damage % compared to original
        ["clp"] = 3, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_mike26", -- weapon class 
        ["dmgp"] = 180, --damage % compared to original
        ["clp"] = 1, --amount of extra clips
        ["sprp"] = 200, --spread % compared to original
        },
        
        
        {
        ["name"] = "mg_glock", -- weapon class 
        ["dmgp"] = 110, --damage % compared to original
        ["clp"] = 4, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
        
        
        }
local converted = util.TableToJSON(secondarygunlist)
PrintTable(secondarygunlist)
file.Write("cr_" .. "MWweaponlist" .. ".json", util.TableToJSON(secondarygunlist))
end
