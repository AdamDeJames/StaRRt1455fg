AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile('cl_hud.lua')
AddCSLuaFile('sh_config.lua')

include('sv_sql.lua')
include("shared.lua")
include("sv_player.lua")
include('sh_config.lua')

local fol = GM.FolderName.."/gamemode/jobs/"
local files, folders = file.Find(fol .. "*", "LUA")
for k,v in pairs(files) do
	if string.GetExtensionFromFilename(v) ~= "lua" then continue end
	include(fol .. v)
end

--[[Network Vars]]--
util.AddNetworkString('rpname', 'betty white')
util.AddNetworkString('taxamt', 10)


function GM:PlayerConnect( name, ip )
	BroadcastLua(chat.AddText(Color(255, 0, 255), "[Server] ", Color(255, 255, 255).." has joined the game!"))
end

function GM:PlayerInitialSpawn( ply )
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			MsgC(Color(255, 0, 0, 255), ply:Nick()..' Has spawned for the first time! ('..ply:SteamID()..')')
		end
	end
	ply:LoadProfile()
	ply:SetTeam(staterp_config.DefaultTeam)
end
--[[Timers]]--
timer.Create('SavePlayerData', 15, 0, function()
	if(staterp_config.debug == true) then
		for k, v in pairs(player.GetAll()) do
			if !IsValid(v) then
				return false
			else
				v:SaveProfile()
				MsgC(red, "[STATE RP - DEBUG] ", white, " Data saved to database.")
			end
		end
	else
		for k, v in pairs(player.GetAll()) do
			if !IsValid(v) then
				return false
			else
				v:SaveProfile()
			end
		end
	end
end)

timer.Create('payday', 300, 0, function()
	for k, v in pairs(player.GetAll()) do
		if !IsValid(v) then
			return false
		else
			v:AddMoney(v:Salary())
			v:RemoveMoney(v:Taxes())
			v:Notify(v:Salary()..'  added to account from Pay Check. '..v:Taxes()..' removed for taxes!')
		end
	end
end)
--[[Console Commands]]--
function ChangeTeam(ply, args, cmd)
	if !args then
		ply:Notify('You must enter a team!')
		return false
	end
	if !IsValid(ply) then
		print('Error... '..ply:Nick()..' Is not a valid player! (Dataload error?)')
	end
	if args and IsValid(ply) then
		ply:SetTeam(args[1])
	end
end
concommand.Add('ChangeJob', ChangeTeam)
