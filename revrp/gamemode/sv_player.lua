Player = FindMetaTable("Player")
require('mysqloo')
include('sv_sql.lua')
include('shared.lua')

function Player:LoadProfile()
	local id = self:SteamID()
	local q2 = "SELECT * FROM player WHERE steamid = '"..id.."'"
	function SetData(str)
		if str == nil then
			self:CreateProfile()
		else
			self:SetNWInt('money', str[1].money)
			self:SetNWInt('playtime', str[1].playtime)
			self:SetNWString('name', str[1].name)
			self:SetNWString('rank', str[1].rank)
		end

	end
	GetDataQuery(q2, SetData)
end

function Player:SetRank(rank)
	if !rank == "owner" or "sadmin" or "admin" or "moderator" or "user" then
		MsgC(red, "Invalid Rank, "..rank)
		return false
	end
	self:SetNWString('rank', rank)
	self:SaveRank(rank)
end

function Player:GetRank()
	local id = self:SteamID()
	local q2 = "SELECT * FROM amod WHERE steamid = '"..id.."'"
	function SetData(str)
		if str == nil then
			self:SetRank('user')
		else
			self:SetNWString('rank', str[1].rank)
		end
	end
	GetDataQuery(q2, SetData)
end

function Player:SaveRank(rank)
	local id = self:SteamID()
	local q2 = "INSERT INTO amod ( steamid, name, rank ) VALUES ('"..id.."', '"..self:Nick().."', '"..rank.."')"
	Query(q2)
end

function Player:IsStaff()
	if self:GetNWString('rank')== "owner" or "sadmin" or "admin" or "moderator" then
		return true
	else
		return false
	end
end

function Player:IsSuperStaff()
	if self:GetNWString('rank')== "owner" or "sadmin" then
		return true
	else
		return false
	end
end

function Player:BanForReal(duration, reason)
	self:Ban(duration)
	self:Kick(reason)
end

function Player:CreateProfile()
	local id, nick = self:SteamID(), self:Nick()
	local q = "INSERT INTO player ( steamid, steamname, name, money, rank, playtime ) VALUES ( '"..id.."', '"..nick.."', 'Charles', '15000', '0', '0' )"
	Query(q)
end

function Player:SaveProfile()
	local id, money = self:SteamID(), self:GetNWInt('money')
	local playtime = self:GetPlayTime() + self:GetNWInt('playtime')
	local q = "UPDATE player SET money = '"..money.."', playtime = '"..playtime.."' WHERE steamid = '"..id.."'"
	Query(q)
end

util.AddNetworkString("notification")

function Player:Notify(msg)
	net.Start("notification")
		net.WriteString( msg )
	net.Send( self )
end

function Player:GetPlayTime()
	return CurTime() - self:GetNWInt('jointime')
end

function Player:SetMoney(amount)
	self:SetNWInt( 'money', amount)
end

function Player:GetMoney()
	return self:GetNWInt( 'money' )
end

function Player:AddMoney(amount)
	self:SetNWInt( 'money', self:GetMoney() + amount)
end

function Player:RemoveMoney(amount)
	self:SetNWInt( 'money', self:GetMoney() - amount)
end

function Player:SetRPName(name)
	self:SetNWString('rpname', name)
	local id = self:SteamID()
	local q = "UPDATE player SET rpname = '"..self:GetNWString('rpname').."' WHERE steamid = '"..id.."'"
end

function Player:Taxes()
	return self:GetNWInt('taxes')
end



