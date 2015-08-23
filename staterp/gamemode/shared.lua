GM.Name = "StateRP" // Put Gamemode info here
GM.Author = "Adam James, Slime"
GM.Email = "N/A"
GM.Website = "hazardous-gaming.net"
DeriveGamemode('sandbox')
Player = FindMetaTable('Player')

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

job_db = {}

function GM:LoadJob(tbl)
	job_db[tbl.ID] = tbl
	MsgC(Color(255, 0, 0, 255), '[STATE RP] ', Color(255, 255, 255), "Loaded job "..tbl.Name)
	team.SetUp(tbl.ID, tbl.Name, tbl.Color)
end

function Player:Salary()
	return job_db[self:Team()].Salary
end