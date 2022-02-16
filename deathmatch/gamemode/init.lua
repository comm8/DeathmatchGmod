AddCSLuaFile ("cl_init.lua")
AddCSLuaFile ("shared.lua")
AddCSLuaFile ("deathmatchhud.lua")
include ("weapon_data.lua")
include ("shared.lua")

util.AddNetworkString("killsound")
util.AddNetworkString("MapChange")
util.AddNetworkString("addweaponhalo")
util.AddNetworkString("removeweaponhalo")
util.AddNetworkString("updaterounds")

hook.Add("Initialize", "cahjec", function()
--RunConsoleCommand("sv_tfa_cmenu" , "0")
RunConsoleCommand("cl_cbob_intensity" , "0.5")
RunConsoleCommand("cl_cbob_compensation", "1")
RunConsoleCommand("sv_tfa_recoil_mul_y", "0.5")
RunConsoleCommand("sv_tfa_recoil_mul_p", "0.5")
RunConsoleCommand("viewbob_multiplier", "0.3")
secondaryweapon = "tfa_mwr_harpoon"
--secondaryweaponstats.Primary.Attacks["len"] = 200
--secondaryweaponstats.Primary.ClipSize = 20
runmapvote = 1
shielddowntime = 5
shieldtick = 1
    shieldcooldownplayer = {}
    shieldregenplayer = {}
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

    randmodel = {
        "models/player/police.mdl",
        "models/player/police_fem.mdl"
    }

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
"tfa_mwr_ak47", -- weapon class 
110, --damage % compared to original
2, --firing speed % compared to original
},

--[[{
"cw_ak47", -- weapon class 
110, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_ak74u", -- weapon class 
120, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_bullfrog", -- weapon class 
70, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_diamatti", -- weapon class 
120, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_dmr14", -- weapon class 
110, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_ffar", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_gallo", -- weapon class 
90, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_groza", -- weapon class 
110, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_hauer77", -- weapon class 
110, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_krig6", -- weapon class 
110, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_lc10", -- weapon class 
110, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_m16", -- weapon class 
90, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_mac10", -- weapon class 
120, --damage % compared to original
1, --firing speed % compared to original
},

{
"cw_milano", -- weapon class 
110, --damage % compared to original
2, --firing speed % compared to original
},

{
"cw_mp5", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
},]]
{
"tfa_mwr_ak74u", -- weapon class 
80, --damage % compared to original
4, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_bos14", -- weapon class 
110, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_d25s", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_drag", -- weapon class 
70, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_fang45", -- weapon class 
100, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_g3", -- weapon class 
100, --damage % compared to original
4, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_g36c", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_kam12", -- weapon class 
90, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_lynx", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m1014", -- weapon class 
60, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m14", -- weapon class 
90, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m16a4", -- weapon class 
100, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m21", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m4a1", -- weapon class 
100, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_mac10", -- weapon class 
100, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_uzi", -- weapon class 
100, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_mk8", -- weapon class 
70, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_ranger", -- weapon class 
110, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_vz61", -- weapon class 
100, --damage % compared to original
5, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_mp44", -- weapon class 
90, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_w1200", -- weapon class 
50, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_xmlar", -- weapon class 
90, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_ins2_minimi", -- weapon class 
50, --damage % compared to original
1, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_ins2_warface_orsis_t5000", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_m9", -- weapon class 
150, --damage % compared to original
3, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_ins2_rpg", -- weapon class 
100, --damage % compared to original
2, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_ins2_s&w_500", -- weapon class 
75, --damage % compared to original
1, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_rpd", -- weapon class 
100, --damage % compared to original
1, --firing speed % compared to original
100, --spread % compared to original
},

{
"tfa_mwr_prokolot", -- weapon class 
110, --damage % compared to original
4, --firing speed % compared to original
100, --spread % compared to original
},

}

    for i=1, #gunlist do
local temporaryweaponvalues = gunlist[i]
local temporaryweapon = weapons.GetStored(temporaryweaponvalues[1])
temporaryweapon.Primary.Damage = temporaryweapon.Primary.Damage * (temporaryweaponvalues[2] / 100)
temporaryweapon.Primary.DefaultClip = temporaryweapon.Primary.ClipSize * temporaryweaponvalues[3]
if temporaryweaponvalues[4] == nil then
table.insert(temporaryweaponvalues, 4, temporaryweapon.Attachments)
end
end

end )

function GM:PlayerInitialSpawn(player, transition)
    local rand = math.random(#randmodel)
    player:SetModel(randmodel[rand])

    net.Start("updaterounds", false)
    net.WriteDouble(runmapvote)
    net.send(player)
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
    ent:GetPhysicsObject():SetVelocity(victim:GetVelocity() * 1.5)
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
    ply:SetupHands()
    local randgun
    local randomnum
    randomnum = math.random(#gunlist)
    randguntemp = gunlist[randomnum]
    randgun = randguntemp[1]
    --[[if randgun == ply:GetNWString("primaryweaponname") then
        return
    end]]


ply:SetGravity(.80)
ply:SetMaxHealth(100)
ply:SetArmor(100)
ply:SetRunSpeed(320)
ply:SetWalkSpeed(200)
ply:SetCrouchedWalkSpeed(100)
ply:Give(randgun, false )
activegun = ply:GetActiveWeapon()
activegun.Attachments = randguntemp[4]
ply:SetNWString("primaryweaponname", randgun)
    --PrintMessage(HUD_PRINTTALK, randgun)
ply:SetNWInt("GunTableNum", randomnum)
ply:Give(secondaryweapon)
ply:Give("weapon_frag")
    --PrintMessage(HUD_PRINTTALK, util.TableToJSON(activegun.Attachments))
    --PrintMessage(HUD_PRINTTALK, ply:GetNWInt("GunTableNum"))
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

mapselect = {

}

hook.Add("EntityTakeDamage", "afergrth", function(entity, dmg)
if entity:IsPlayer() == true then
    entity:SetNWInt("damagetime", CurTime())
    shieldcooldownplayer[#shieldcooldownplayer + 1] = entity
for i=1, #shieldregenplayer do 
if IsValid(shieldregenplayer[i]) then
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
--playerlist = player.GetAll()
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
end

if CurTime() > 900 * runmapvote then
MapVote.Start(15, true, 5, "dm")
runmapvote = runmapvote + 1
net.Start("updaterounds", false)
net.WriteDouble(runmapvote)
local rf = RecipientFilter()
rf:AddAllPlayers()
net.send(rf)

--[[local scoreboard = {}
local playerlists = player.GetAll()
for i=1, #rf do
table.insert(scoreboard,playerlists[i]:GetNWInt("PlayerKills"))
end
table.sort(scoreboard, function(a, b) return a[2] > b[2] end)
end]]
--local randnum = math.random(#maplist)
 --randmap = maplist[randnum]
--net.Start("MapChange")
--net.Send(player.GetAll())
--RunConsoleCommand("map",randmap)
--timer.Simple(15, game.LoadNextMap)
end
 
end
