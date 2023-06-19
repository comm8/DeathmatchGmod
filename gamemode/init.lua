AddCSLuaFile ("cl_init.lua")
AddCSLuaFile ("shared.lua")
AddCSLuaFile ("deathmatchhud.lua")
include ("shared.lua")
--include a bunch of files

util.AddNetworkString("killsound")
util.AddNetworkString("MapChange")
util.AddNetworkString("addweaponhalo")
util.AddNetworkString("removeweaponhalo")
util.AddNetworkString("updaterounds")
util.AddNetworkString("updatehealth")
--add a bunch of network calls to let clients know whats going on



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




secondaryweapon = "arc9_go_knife_flip"
--the second "lesser" weapon everyone always spawns with


runmapvote = 1
--how many map votes we've ran +1

shielddowntime = 0.5
--how long armor is down for after taking damage before it starts going back up


shieldtick = 0.2
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
if temporaryweapon != nil then


else 

    print("Weapon " .. temporaryweaponvalues["name"] .. " was not found!")

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
        RandomWeapon = gunlist[randomnum]
        RandomWeaponName = RandomWeapon["name"]

        ply:AllowFlashlight(true)
        ply:SetGravity(1)
        ply:SetJumpPower(250)
        ply:SetMaxHealth(100)
        ply:SetHealth(100)
        ply:SetArmor(50)
        ply:SetMaxArmor(50)
        ply:SetRunSpeed(325)
        ply:SetWalkSpeed(250)
        ply:SetCrouchedWalkSpeed(100)
        ply:Give(RandomWeaponName, true)
    end

    activegun = ply:GetActiveWeapon()

    if activegun == nil then
    PrintMessage(HUD_PRINTTALK, RandomWeaponName .. " was not found!")
    end

    if RandomWeapon["dmgp"] != nil then

    end

    if RandomWeapon["clp"] != nil then
        activegun:SetClip1(activegun:GetProcessedValue("ClipSize"))
        ply:SetAmmo(activegun:GetProcessedValue("ClipSize") * (RandomWeapon["clp"]-1), activegun:GetPrimaryAmmoType())
    end

    if RandomWeapon["sprp"] != nil then

    end

    ply:SetNWString("primaryweaponname", RandomWeaponName)
    ply:SetNWInt("GunTableNum", randomnum)
    ply:Give(secondaryweapon)
    ply:Give("weapon_frag")
    ply:GiveAmmo(2, "Grenade")
      
    
    
    local rand = math.random(#randmodel)
    ply:SetModel(randmodel[rand])
    ply:SetupHands()
end


mapselect = {

}

hook.Add("EntityTakeDamage", "afergrth", function(entity, dmg)
if entity:IsPlayer() == true then
    

    PrintMessage(HUD_PRINTTALK, "Player took damage at " .. CurTime())
    entity:SetNWInt("damagetime", CurTime() + shielddowntime)
    shieldcooldownplayer[#shieldcooldownplayer + 1] = entity
end
end)



function GM:Think()


for i=1, #shieldcooldownplayer do
    local player = shieldcooldownplayer[i]

    if CurTime() > player:GetNWInt("damagetime") then
    local player = shieldcooldownplayer[i]
    player:SetNWInt("healthtick", CurTime() + shieldtick)
    table.remove(shieldcooldownplayer, i)
    shieldregenplayer[#shieldregenplayer + 1] = player
    PrintMessage(HUD_PRINTTALK, "moved a player to regen group")
    return
    end

end


for i=1, #shieldregenplayer do
    local shieldplayer = shieldregenplayer[i]
    if !IsValid(shieldplayer) or shieldplayer:Health() >= shieldplayer:GetMaxHealth() then
    table.remove(shieldregenplayer, i)
    return
    end

    if shieldplayer:GetNWInt("healthtick") < CurTime() then
    shieldplayer:SetHealth(shieldplayer:Health() + 1)
    shieldplayer:SetNWInt("healthtick", CurTime() + shieldtick)
    end
end

if GetConVar("cr_roundtime"):GetInt() > 0 then
if CurTime() > GetConVar("cr_roundtime"):GetInt() * runmapvote then
MapVote.Start(15, true, 5, "dm")
runmapvote = runmapvote + 1
end
end
end




function SaveWeaponDataToJSON()
    secondarygunlist = {
        {
        ["name"] = "arc9_gekolt_css_flare", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                {
        ["name"] = "arc9_gekolt_fas2_m79", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                {
        ["name"] = "arc9_gekolt_css_m4", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                {
        ["name"] = "arc9_gekolt_css_ak47", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                {
        ["name"] = "arc9_gekolt_dods_mauser", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                        {
        ["name"] = "arc9_gekolt_dods_garand", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                                {
        ["name"] = "arc9_gekolt_moah_m18", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        },
                                {
        ["name"] = "arc9_gekolt_css_m9", -- weapon class 
        ["dmgp"] = 100, --damage % compared to original
        ["clp"] = 2, --amount of extra clips
        ["sprp"] = 100, --spread % compared to original
        }

    }
local converted = util.TableToJSON(secondarygunlist)
PrintTable(secondarygunlist)
file.Write("cr_" .. "arc9weaplist" .. ".json", util.TableToJSON(secondarygunlist))
end
