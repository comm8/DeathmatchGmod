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
--add a bunch of network calls to let clients know whats going on


hook.Add("Initialize", "cahjec", function()
--this is called when the server starts

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

--Running some commands to get all the gun values right
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


shieldtick = 1
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


gunlist = {
{
["name"] = "tfa_mwr_ak47", -- weapon class 
--AK 47 
--A medium damage medium range weapon useful in most situations

["dmgp"] = 110, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_ak74u", -- weapon class 
--AK 74u
--The close range variant of the AK 47
--useful because of its high magazine count
--lower damage from afar

["dmgp"] = 80, --damage % compared to original
["clp"] = 4, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_bos14", -- weapon class 
["dmgp"] = 110, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_d25s", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_drag", -- weapon class 
["dmgp"] = 70, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_fang45", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_g3", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 4, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_g36c", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_kam12", -- weapon class 
["dmgp"] = 90, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_lynx", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m1014", -- weapon class 
["dmgp"] = 60, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m14", -- weapon class 
["dmgp"] = 90, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m16a4", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m21", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m4a1", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_mac10", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 3,--amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_uzi", -- weapon class 
["dmgp"] = 95, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 20, --spread % compared to original
},


{
["name"] = "tfa_mwr_mk8", -- weapon class 
["dmgp"] = 70, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_ranger", -- weapon class 
["dmgp"] = 110, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_vz61", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 5, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_mp44", -- weapon class 
["dmgp"] = 90, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_w1200", -- weapon class 
["dmgp"] = 50, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_xmlar", -- weapon class 
["dmgp"] = 90, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_m9", -- weapon class 
["dmgp"] = 150, --damage % compared to original
["clp"] = 3, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_mwr_rpd", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 1, --amount of extra clips
["sprp"] = 200, --spread % compared to original
},


{
["name"] = "tfa_mwr_prokolot", -- weapon class 
["dmgp"] = 110, --damage % compared to original
["clp"] = 4, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},



--everything below here is not from the MW weapons addons


{
["name"] = "tfa_ins2_minimi", -- weapon class 
["dmgp"] = 50, --damage % compared to original
["clp"] = 1, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_ins2_warface_orsis_t5000", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_iiopn_9mm_dual", -- weapon class 
["dmgp"] = 110, --damage % compared to original
["clp"] = 1, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_ins2_s&w_500", -- weapon class 
["dmgp"] = 75, --damage % compared to original
["clp"] = 1, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},


{
["name"] = "tfa_ins2_rpg", -- weapon class 
["dmgp"] = 100, --damage % compared to original
["clp"] = 2, --amount of extra clips
["sprp"] = 100, --spread % compared to original
},

}

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
temporaryweapon.Primary.DefaultClip = temporaryweapon.Primary.ClipSize * temporaryweaponvalues["clp"]
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
    player:AllowFlashlight(true)
    local rand = math.random(#randmodel)
    player:SetModel(randmodel[rand])

    net.Start("updaterounds", false)
    net.WriteDouble(runmapvote)
    net.Send(player)
    end





function GM:PlayerSpawn(ply)
    ply:SetupHands()
    local randgun
    local randomnum
    randomnum = math.random(#gunlist)
    randguntemp = gunlist[randomnum]
    randgun = randguntemp["name"]
    

    ply:SetGravity(.80)
    ply:SetMaxHealth(100)
    ply:SetArmor(100)
    ply:SetRunSpeed(320)
    ply:SetWalkSpeed(200)
    ply:SetCrouchedWalkSpeed(100)

    ply:Give(randgun, false )
    ply:SetNWString("primaryweaponname", randgun)
    PrintMessage(HUD_PRINTTALK, randgun)
    ply:Give(secondaryweapon)
    local secondary = ply:GetWeapon(secondaryweapon)
    if(GetConVar("fi_grenades"):GetBool() == true) then
    ply:Give("weapon_frag")
end

end

-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end




--[[function Applyweaponstats(weapon, weaponid)

local temporaryweaponvalues = gunlist[weaponid]

if temporaryweaponvalues["dmgp"] != nil then
weapon.Primary_TFA.Damage = weapon.Primary_TFA.Damage * (temporaryweaponvalues["dmgp"] / 100)
weapon:ClearStatCache("Primary.Damage")
end

if temporaryweaponvalues["clp"] != nil then
weapon.Primary_TFA.DefaultClip = weapon.Primary_TFA.ClipSize * temporaryweaponvalues["clp"]
weapon:ClearStatCache("Primary.ClipSize")
end

if temporaryweaponvalues["sprp"] != nil then
weapon.Primary_TFA.SpreadMultiplierMax = temporaryweaponvalues["sprp"] * weapon.Primary_TFA.SpreadMultiplierMax
weapon:ClearStatCache("Primary.SpreadMultiplierMax")

end


end]]


--doing map cleanup to remove unwanted map items
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

PrintMessage(HUD_PRINTTALK, victim:GetNWString("primaryweaponname"))
    local newdroppedweapon = ents.Create("dropped_weapon")

--gets the weapon with accompanying name on dead player
    local droppedweapon = victim:GetWeapon(victim:GetNWString("primaryweaponname"))


    droppedammotype = droppedweapon:GetPrimaryAmmoType()


    if victim:GetAmmoCount(droppedammotype) != nil && victim:GetAmmoCount(droppedammotype) + droppedweapon:Clip1() > 0 then

    newdroppedweapon:SetReserveAmmo( victim:GetAmmoCount(droppedammotype) + droppedweapon:Clip1() )
    newdroppedweapon:SetReserveAmmoType(droppedammotype)
    newdroppedweapon:SetGunName(droppedweapon:GetClass())
    newdroppedweapon:SetPos((victim:GetPos() + (victim:GetUp() * 30)))
    newdroppedweapon:Spawn()
    newdroppedweapon:Activate()
    newdroppedweapon:GetPhysicsObject():SetVelocity(victim:GetVelocity() * 1.5)
    net.Start("addweaponhalo", false)
    net.WriteEntity(newdroppedweapon)
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



hook.Add("EntityTakeDamage", "afergrth", function(entity, dmg)
if entity:IsPlayer() == true then
    entity:SetNWInt("damagetime", CurTime())
    shieldcooldownplayer[#shieldcooldownplayer + 1] = entity
end

end)



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
        if shieldplayer == nil then
        return
    end

        if shieldregenplayer != nil && shieldplayer:Armor() < shieldplayer:GetMaxArmor() && shieldplayer:GetNWInt("healthtick") < CurTime() then
            shieldplayer:SetArmor(shieldplayer:Armor() + 1)
            shieldplayer:SetNWInt("healthtick", CurTime() + shieldtick)
        elseif shieldplayer:Armor() >= shieldplayer:GetMaxArmor() then
            table.remove(shieldregenplayer, i)
        end

        if shieldplayer == nil then
            table.remove( shieldregenplayer, i )
        return
        end
    end

        if CurTime() > 900 * runmapvote then
        MapVote.Start(15, true, 5, "dm")
        runmapvote = runmapvote + 1
        net.Start("updaterounds", false)
        net.WriteDouble(runmapvote)
        local rf = RecipientFilter()
        rf:AddAllPlayers()
        net.send(rf)
    end
 
end
