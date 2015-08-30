GM.Name = "StateRP" // Put Gamemode info here
GM.Author = "Adam James, Slime"
GM.Email = "N/A"
GM.Website = "hazardous-gaming.net"
DeriveGamemode('sandbox')
Player = FindMetaTable('Player')
if !rev then rev = {} end
red = Color(255, 0, 0, 255)
blue = Color(0, 0, 255, 255)
green = Color(0, 255, 0, 255)
white = Color(255, 255, 255, 255)
black = Color(0, 0, 0, 255)

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

job_db = {}
local GM = GM or GAMEMODE
function GM:LoadJob(tbl)
	job_db[tbl.ID] = tbl
	MsgC(red, '[STATE RP] ', white, "Loaded job "..tbl.Name.."\n")
	team.SetUp(tbl.ID, tbl.Name, tbl.Color)
	util.PrecacheModel(tostring(tbl.Model))
end

function Player:Salary()
	return job_db[self:Team()].Salary
end

config = {}

function GM:LoadConfig(tbl)
	MsgC(red, "[STATE RP] ", white, "Loaded Config\n"  )
end

function rev.addChat(ply, ...)
	if CLIENT then
		chat.AddText(...)
	elseif SERVER then
		if ply == "All" then
			net.Start('revChat_Add')
				net.WriteTable({ ... })
			net.Broadcast()
		elseif ply == "Admins" then
			for k, v in pairs(player.GetAll()) do
				if v:IsAdmin() then
					net.Start('revChat_Add')
						net.WriteTable({ ... })
					net.Send(v)
				end
			end
		else
			--if(IsValid(ply)) then
				net.Start('revChat_Add')
					net.WriteTable({ ... })
				net.Send(ply)
			--end
		end
	end
end

if CLIENT then
	net.Receive('revChat_Add', function()
		chat.AddText(unpack(net.ReadTable()))
	end)
end

function rev.GetPlayer(name, ply)
	local players = {}
	for k, v in pairs(player.GetAll()) do
		if(v:GetName():lower():match(name:lower())) then
			
				table.insert(players, v)
			
			end
		
		end
		
		if(table.Count(players) == 0) then
		
			MsgN('[ADMIN] No players found!');
			return false
			
		end
		if(table.Count(players) > 1) then
		
			MsgN('[ADMIN] There are multiable players!');
			return false
		end
		
		return players[1]
		
	end
