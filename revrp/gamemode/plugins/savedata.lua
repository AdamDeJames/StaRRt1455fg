local plugin = {}

plugin.Name = "Admin Commands"
plugin.Desc = "Admins commands, by Adam James"

function saved(ply, text, reason)
	local text = string.lower(text)
		if(string.sub(text, 0, 9)== "/savedata") then
			local text = string.Explode(' ', text)
	if ply:IsSuperStaff() then
		for k, v in pairs(player.GetAll()) do
			local rank = v:GetNWString('rank')
			v:SaveProfile()
			v:SaveRank(rank)
			rev.addChat('Admins', red "[Admin Chat] ", white, ply:Nick().." Saved database data!")
		end
	else
		rev.addChat(ply, red, "[Server Alert] ", white, "You do not have the correct permissions to preform this command!")
	end
	return ''
	end
end
hook.Add("PlayerSay", "Admin_UnFreeze", saved)