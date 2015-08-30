local plugin = {}

plugin.Name = "Admin Commands"
plugin.Desc = "Admins commands, by Adam James"

function unfreeze(ply, text, reason)
	local text = string.lower(text)
		if(string.sub(text, 0, 9)== "/unfreeze") then
			local text = string.Explode(' ', text)
	local victim = rev.GetPlayer(text[2])
	local silent = text[3]
	if(!victim) then
		rev.addChat(ply, Color(0, 255, 255), "[Server] ", Color(255, 255, 255, 255), "You must enter a valid person to unfreeze!")
		return false
	end
	if !ply:IsStaff() then
		rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), ply:Nick().." Attempted to use a admin command while they are not staff!")
		rev.addChat(ply, Color(255, 0, 0, 255), "[Server Alert]", Color(255, 255 ,255, 255), "You cannot use this command! Logged and reported attempt useage.")
		return false
	end
	if silent == "true" then
			victim:Freeze(false)
			rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), ply:Nick().." has unfroze "..victim:Nick())
	elseif silent == "false" then
		victim:Freeze(false)
		rev.addChat("All", Color(0, 255, 255, 255), "[Server Admin] ", Color(255, 255, 255, 255), ply:Nick().." has unfrozen "..victim:Nick())
	else
		rev.addChat(ply, Color(0, 255, 255), "[Server] ", Color(255, 255, 255, 255), silent.." Is not valid! Use true or false!")
		return
	end
	return ''
	end
end
hook.Add("PlayerSay", "Admin_UnFreeze", unfreeze)