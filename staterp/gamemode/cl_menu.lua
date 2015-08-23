--[[RPNAME menu
	By Adam James
]]--

function RPNameMenu()
	local ply = LocalPlayer()
	
	local frame = vgui.Create('DFrame')
		frame:SetSize(350, 350)
		frame:IsDraggable(false)
		frame:ShowCloseButton(true)
		frame:Center()
		frame:MakePopup()
	local rpname = vgui.Create('DTextEntry')
		rpname:SetSize(45, 25)
		rpname:SetPos(15, 50)
		rpname:SetParent(frame)
		rpname:SetText('Enter name here...')
	local sub = vgui.Create('DButton')
		sub:SetSize(45, 25)
		sub:SetPos(35, 50)
		
end
usermessage.Hook('rpnamemenu', RPNameMenu)
