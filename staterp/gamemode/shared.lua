GM.Name = "StateRP" // Put Gamemode info here
GM.Author = "Adam James, Slime"
GM.Email = "N/A"
GM.Website = "hazardous-gaming.net"
DeriveGamemode('sandbox')
Player = FindMetaTable('Player')

red = Color(255, 0, 0, 255)
blue = Color(0, 0, 255, 255)
green = Color(0, 255, 0, 255)
white = Color(255, 255, 255, 255)
black = Color(0, 0, 0, 255)

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

job_db = {}

function GM:LoadJob(tbl)
	job_db[tbl.ID] = tbl
	MsgC(red, '[STATE RP] ', white, "Loaded job "..tbl.Name)
	team.SetUp(tbl.ID, tbl.Name, tbl.Color)
end

function Player:Salary()
	return job_db[self:Team()].Salary
end

config = {}

function GM:LoadConfig()
	MsgC(red, "[STATE RP] ", white, "Loaded Config"  )
end