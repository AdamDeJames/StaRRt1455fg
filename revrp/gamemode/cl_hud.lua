hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	local ply = LocalPlayer()
	if ply:Alive() then
	draw.RoundedBox( 5, 5, ScrH()-150, 300, 150, Color(5, 5, 5, 150)  ) // frame
	--[[Steam Name]]--
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material('icon16/user.png'))
	surface.DrawTexturedRect(10, ScrH()-135, 16, 16)
	draw.SimpleText('Steam Name: '..LocalPlayer():Nick(), 'ChatFont', 30, ScrH()-135, Color(255, 255, 255, 255))
	--[[RP Name]]--
	draw.SimpleText('RP Name: '..tostring(LocalPlayer():GetNWInt('name')), 'ChatFont', 30, ScrH()-115, Color(255, 255, 255, 255))
	surface.SetMaterial(Material('icon16/user_add.png'))
	surface.DrawTexturedRect(10, ScrH()-115,  16, 16)
	surface.SetDrawColor(255, 255, 255, 255)
	--[[job]]--
	draw.SimpleText('Job: '..tostring(team.GetName(LocalPlayer():Team())), 'ChatFont', 30, ScrH()-95, Color(255, 255, 255, 255))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material('icon16/group.png'))
	surface.DrawTexturedRect(10, ScrH()-95, 16, 16)
	--[[Rank]]--
	draw.SimpleText('Rank: '..tostring(LocalPlayer():GetNWString('rank')), 'ChatFont', 30, ScrH()-75, Color(255, 255, 255, 255))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material('icon16/star.png'))
	surface.DrawTexturedRect(10, ScrH()-75, 16, 16)
	--[[Money]]--
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material('icon16/money.png'))
	surface.DrawTexturedRect(10, ScrH()-50, 16, 16)
	draw.SimpleText("Money: "..tostring(LocalPlayer():GetNWInt('money')), "ChatFont", 30, ScrH()-50, Color(255, 255, 255, 255))

--ammo
	--[[local wep = ply:GetActiveWeapon():Clip1()
	local wep2 = ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType())
	if(wep)== -1 then
		wep = 0
	end
	if ply:GetActiveWeapon() == nil then
		return false
	end
	if !wep or !wep2 then
		return
	end
	draw.RoundedBox(3, 325, ScrH()-75, 121, 25, Color(5, 5, 5, 200)) // ammo frame
	draw.RoundedBox(5, 326, ScrH()-74, 120, 24, Color(100, 50, 255, 255))
	draw.SimpleText('Ammo: '..tostring(wep)..'/'..tostring(wep2), 'ChatFont', 330, ScrH()-75, Color(255, 0, 0, 255))
	end]]
	end
end )
	//draw.SimpleText(tostring(LocalPlayer():GetNWInt('money')), "Trebuchet24", 300, 300, Color(255,0,0, 255))

-- Hide Original Hud --
 function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)