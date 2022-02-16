surface.CreateFont( "Deathmatch_SB", {
	font = "HudNumbers", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 24,
	weight = 500,
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

Rounds = 0


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
    surface.SetDrawColor(0, 0, 0, 120)
    surface.DrawRect(0, 0, w, h)
    draw.SimpleText("Scoreboard" .. "       time elapsed: " .. math.Truncate(RealTime() - (Rounds * 900), 0) .. " out of" .. 900 , "Deathmatch_SB", w / 2, h * .015, Color( 255, 220, 50, 255 ), TEXT_ALIGN_CENTER)
end
local ypos = DeathmatchScoreBoard:GetTall() * .06
for k, v in pairs(player.GetAll()) do
local playerpanel = vgui.Create("DPanel", DeathmatchScoreBoard)
playerpanel:SetPos(0, ypos)
playerpanel:SetSize(DeathmatchScoreBoard:GetWide(), DeathmatchScoreBoard:GetTall() * .05)
local name = v:Name()
if IsValid(v) then
playerpanel.Paint = function(self, w, h)
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(0, 0, w, h)
    draw.SimpleText(name .. " - " .. v:GetNWInt("PlayerKills"), Deathmatch_SB, w / 2, h / 2, Color( 255, 220, 50, 255 ), TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
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

net.Receive("updaterounds", function()
	Rounds = ReadDouble()
	end)
