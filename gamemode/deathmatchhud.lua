surface.CreateFont( "Deathmatch_SB", {
	font = "CAGeheimagent-Bold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 54,
	weight = 1000,
	blursize = 0,
	scanlines = 2,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
surface.CreateFont( "Deathmatch_HUD", {
	font = "CAGeheimagent-Bold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 150,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )



surface.CreateFont( "Deathmatch_PLY", {
	font = "CAGeheimagent-Bold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 34,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
surface.CreateFont( "Deathmatch_PLY_DEAD", {
	font = "CAGeheimagent-Bold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 34,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = true,
	strikeout = true,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


TextColor = Color(255, 187, 50)
DeadColor = Color(179,62,62)
HudColor = Color(227, 164, 36)
-- Disable default HUD
hook.Add( "HUDShouldDraw", "hide hud", function( name )
	if ( name == "CHudHealth" or name == "CHudBattery" ) then
	return false
	end
end ) 



hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
local hScale = ScrH()*.09
local wScale = ScrW()*.1

local hPos = ScrH()*.93 - (hScale/2)
local wPos = ScrW()*.12 - (wScale/2)


	draw.RoundedBox(10, wPos, hPos, wScale, hScale, Color(0, 0, 0, 241))
	draw.SimpleText(LocalPlayer():Health(), "Deathmatch_HUD", wPos*1.2 , hPos*.99, LerpColor(HudColor, DeadColor,LerpInverseLog(LocalPlayer():Health()/LocalPlayer():GetMaxHealth())), TEXT_ALIGN_LEFT)
	
end )
	


local function togglescoreboard(toggle)
if toggle then
local scX, scY = ScrW(), ScrH()
DeathmatchScoreBoard = vgui.Create("DFrame")
DeathmatchScoreBoard:SetTitle("")
DeathmatchScoreBoard:SetSize(scX * 0.8, scY * 0.8)
DeathmatchScoreBoard:Center()
--DeathmatchScoreBoard:MakePopup()
DeathmatchScoreBoard:ShowCloseButton(false)
DeathmatchScoreBoard:SetDraggable(false)
DeathmatchScoreBoard.Paint = function (self,w,h)
	draw.RoundedBox(20, 0, 0, w, h, Color(0, 0, 0, 170))

end
local toppanel = vgui.Create("DPanel", DeathmatchScoreBoard)
toppanel:SetPos(0,1)
toppanel:SetSize(DeathmatchScoreBoard:GetWide(), DeathmatchScoreBoard:GetTall() * .06)
toppanel.Paint = function(self, w, h)
draw.RoundedBoxEx(20, 0, 0, w, h, Color(0, 0, 0, 241), true, true, false, false)
draw.SimpleText("SCOREBOARD", "Deathmatch_SB", w * 0.02, h* 0.05 , TextColor, TEXT_ALIGN_LEFT)

draw.SimpleText("TIME ELAPSED: " .. math.Truncate(RealTime(), 0) % GetConVar("cr_roundtime"):GetInt() .. " OUT OF " .. GetConVar("cr_roundtime"):GetInt()  , "Deathmatch_SB", w * 0.5, h* 0.05 , TextColor, TEXT_ALIGN_CENTER)
draw.SimpleText(game.GetMap(), "Deathmatch_SB", w * 0.98, h* 0.05 , TextColor, TEXT_ALIGN_RIGHT)
end

local ypos = DeathmatchScoreBoard:GetTall() * .06
for k, v in pairs(player.GetAll()) do
	local playerpanel = vgui.Create("DPanel", DeathmatchScoreBoard)
	playerpanel:SetPos(0, ypos)
	playerpanel:SetSize(DeathmatchScoreBoard:GetWide(), DeathmatchScoreBoard:GetTall() * .07)
	if IsValid(v) then

		local name = v:Name()
		playerpanel.Paint = function(self, w, h)
    	surface.SetDrawColor(0, 0, 0, 200)
    	surface.DrawRect(0, 0, w, h)
		if(v:Alive()) then
		draw.DrawText(name .. " - " .. v:GetNWInt("PlayerKills"), "Deathmatch_PLY", w * .5, h * .35, TextColor, TEXT_ALIGN_CENTER )
		else
			draw.DrawText(name .. " - " .. v:GetNWInt("PlayerKills"), "Deathmatch_PLY_DEAD", w * .5, h * .35, DeadColor, TEXT_ALIGN_CENTER )	
		end
	end
end
    ypos = ypos + playerpanel:GetTall() * 1.1
end
else
        if IsValid(DeathmatchScoreBoard) then 
        DeathmatchScoreBoard:Remove()
        end
    end
end


hook.Add("ScoreboardShow","deathmatchscoreboardopen", function()
togglescoreboard(true)
return false
end)

hook.Add("ScoreboardHide","deathmatchscoreboardclose", function()
    togglescoreboard(false)
end)

function LerpColor(ColorA, ColorB, Delta)	
local r = Lerp(Delta, ColorA.r, ColorB.r)
local g = Lerp(Delta, ColorA.g, ColorB.g)
local b = Lerp(Delta, ColorA.b, ColorB.b)

	return Color(r,g,b) 
end

function LerpInverseLog(Xin)
	return  math.log10((-10*Xin)*0.9+10)
end