include("shared.lua")
include("cl_hud.lua")
include('sh_config.lua')

net.Receive( "notification", function()
	notification.AddLegacy(net.ReadString(), NOTIFY_GENERIC, 5)
	surface.PlaySound('ui/hint.wav')
end)

hook.Add( "HUDShouldDraw", "hide hud", function( name )
	 if ( name == "CHudHealth" or name == "CHudBattery" ) then
		 return false
	 end
end )