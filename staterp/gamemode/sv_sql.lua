local host = "db1.eu.serenityservers.net"
local user = "db2443"
local database = "db2443"
local pass = "k08511NthB"
require('mysqloo')

db = mysqloo.connect(host, user, pass, database)
db:connect()

function db:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:n/", err )
 
end

function Query( str )
	local d = db:query(str)
	d:start()
end

function GetDataQuery( str, callback )
	local d = db:query(str)
	d:start()
	function d:onSuccess(data)
		callback(data)
	end
end