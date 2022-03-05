
hook.Add( "CalcView", "Comm8Cameraviewbob", function(ply, origin, angles, fov)

--getting our player's eye values n stuff
local playerviewstats = {
    ["ply"] = ply,
    ["origin"] = origin,
    ["angles"] = angles,
    ["fov"] = fov,
}

playerviewstats.angles.r = 350




end)