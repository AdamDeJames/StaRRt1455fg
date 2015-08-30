local plugin = {}

plugin.Name = "Admin Commands"
plugin.Desc = "Admins commands, by Adam James"

function ban(ply, text, reason)
	local text = string.lower(text)
		if(string.sub(text, 0, 4)== "/ban") then
			local text = string.Explode(' ', text)
	local victim = rev.GetPlayer(text[2])
	local id = victim:SteamID()
	local reason = table.concat( text, " ", 5 )
	local time = text[4]
	local silent = text[3]
	if(!victim) then
		rev.addChat(ply, Color(0, 255, 255), "[Server] ", Color(255, 255, 255, 255), "You must enter a valid person to ban!")
		return false
	end
	if(!reason) then
		rev.addChat(ply, Color(0, 255, 255), "[Server] ", Color(255, 255, 255, 255), "You must enter a reason to kick this player!")
	end
	if(!time) then
		time = 0
	end
	if !ply:IsStaff() then
		rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), ply:Nick().." Attempted to use a admin command while they are not staff!")
		rev.addChat(ply, Color(255, 0, 0, 255), "[Server Alert]", Color(255, 255 ,255, 255), "You cannot use this command! Logged and reported attempt useage.")
		return false
	end
	
		if silent == "false" then
			victim:Ban(time, false)
			victim:Kick("Banned for "..time.." minutes. '"..reason.."' ~"..ply:Nick())
				if time == 0 then
				time = "Permanently"
			end
			local q = "INSERT INTO bans ( steamid, name, time, admin, reason ) VALUES ( '"..id.."', '"..victim:Nick().."', '"..time.."', '"..ply:Nick().."', '"..reason.."' )"
			Query(q)
			rev.addChat("All", Color(0, 255, 255, 255), "[Server Admin] ", Color(255, 255, 255, 255), ply:Nick().." has banned "..victim:Nick()..". Time: "..time.." minutes! Reason:")
			rev.addChat("All", Color(0, 255, 255, 255), "[Server Admin] ", Color(255, 255, 255, 255), '"'..reason..'"')
		elseif silent == "true" then
			victim:Ban(time, false)
			if time == 0 then
				time = "Permanently"
			end
			victim:Kick("Banned for "..time.." minutes. '"..reason.."' ~"..ply:Nick())
		local q = "INSERT INTO bans ( steamid, name, time, admin, reason ) VALUES ( '"..id.."', '"..victim:Nick().."', '"..time.."', '"..ply:Nick().."', '"..reason.."' )"
		Query(q)
			rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), ply:Nick().." has banned "..victim:Nick()..". Time: "..time.." minutes! Reason: "..reason)
		else
			rev.addChat(ply, Color(0, 255, 255, 255), "[Server] ", Color(255, 255, 255, 255), silent.." Is not valid! Use true/false")
			return
		end
	return ''
	end
end
hook.Add("PlayerSay", "Admin_Ban", ban)