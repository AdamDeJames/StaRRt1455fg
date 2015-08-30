local plugin = {}

plugin.Name = "Admin Commands"
plugin.Desc = "Admins commands, by Adam James"

function setrank(ply, text, reason)
	local text = string.lower(text)
		if(string.sub(text, 0, 8)== "/setrank") then
			local text = string.Explode(' ', text)
	local victim = rev.GetPlayer(text[2])
	local rank = text[3]
	if(!victim) then
		rev.addChat(ply, Color(0, 255, 255), "[Server] ", Color(255, 255, 255, 255), "You must enter a valid person to rank!")
		return false
	end
	if !ply:IsStaff() then
		rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), ply:Nick().." Attempted to use a admin command while they are not staff!")
		rev.addChat(ply, Color(255, 0, 0, 255), "[Server Alert]", Color(255, 255 ,255, 255), "You cannot use this command! Logged and reported attempt useage.")
		return false
	end
	if ply:IsSuperStaff() then
		victim:SetRank(rank)
		local id = victim:SteamID()
		local q = "INSERT INTO amod ( steamid, name, rank ) VALUES ( '"..id.."', '"..victim:Nick().."', '"..rank.."' )"
		Query(q)
		rev.addChat("All", Color(0, 255, 255, 255), "[Server Admin] ", Color(255, 255, 255, 255), ply:Nick().." Has promoted "..victim:Nick().." to "..rank)
	end
	return ''
	end
end
hook.Add("PlayerSay", "Admin_SetRank", setrank)