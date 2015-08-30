local plugin = {}

plugin.Name = "Admin Commands"
plugin.Desc = "Admins commands, by Adam James"
--[[
function freeze(ply, text)
	local text = string.lower(text)
		if(string.sub(text, 0, 4)== "/bans") then
			local text = string.Explode(' ', text)
	local id = text[2]
	if(!id) then
		rev.addChat(ply, Color(0, 255, 255, 255), "[Server] ", Color(255, 255, 255, 255), "You must enter a steamid! (/bans steamid)")
		return
	end
	
	return ''
	end
end
hook.Add("PlayerSay", "Admin_Freeze", freeze)]]--