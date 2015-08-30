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

local fol = GM.FolderName.."/gamemode/plugins/"
local files, folders = file.Find(fol .. "*", "LUA")
for k, v in pairs(files) do
	if string.GetExtensionFromFilename(v) ~= "lua" then continue end
	include(fol .. v)
end

--[[Network Vars]]--
util.AddNetworkString('rpname', 'betty white')
util.AddNetworkString('taxamt', 10)
util.AddNetworkString('revChat_Add')


function GM:PlayerConnect( name, ip )
	rev.addChat("All", Color(0, 255, 255, 255), "[Server] ", Color(255, 255, 255, 255), name.." has joined the game! ")
	rev.addChat("Admins", Color(255, 0, 0, 255), "[Admin Chat] ", Color(255, 255, 255, 255), name.." Joind the server under IP: "..ip)
end

function GM:PlayerInitialSpawn( ply )
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			MsgC(Color(255, 0, 0, 255), ply:Nick()..' Has spawned for the first time! ('..ply:SteamID()..')\n')
		end
	end
	ply:LoadProfile()
	ply:SetTeam(1)
	ply:GetRank()
	ply:SetModel(tostring(job_db[ply:Team()].Model))
end

function GM:PlayerSpawn(ply)
	ply:SetModel(tostring(job_db[ply:Team()].Model))
end
--[[Timers]]--
timer.Create('SavePlayerData', 15, 0, function()
	if(staterp_config.debug == true) then
		for k, v in pairs(player.GetAll()) do
			if !IsValid(v) then
				return false
			else
				v:SaveProfile()
				MsgC(red, "[1700s RP - DEBUG] ", white, " Data saved to database.\n")
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
	if !args or args[1] == nil or args[2] then
		ply:Notify('You must enter a team!')
		return false
	end
	if !IsValid(ply) then
		print('Error... '..ply:Nick()..' Is not a valid player! (Dataload error?)')
	end
	if args and IsValid(ply) then
		ply:SetTeam(tonumber(args[1]))
	end
end
concommand.Add('ChangeJob', ChangeTeam)

function SetRank(ply, args)
	if !args[1] then
		return
	end
	if !args[2] then
		return
	end
	if !ply:IsValid() then
		local victim = rev.GetPlayer(args[1])
		victim:SetRank(args[2])
		victim:Kick("You have been promoted to "..args[2]..' please rejoin the server to fully finish this process.')
	else
		ply:ChatPrint('Only Console can do this command!')
		return
	end
end
concommand.Add('Console_Set_Rank_3306', SetRank)
