/*
	INITIALIZE GLOBALS
*/

TicketHandler = TicketHandler || {}
TicketHandler.Config = TicketHandler.Config || {}

TicketHandler.Tickets = TicketHandler.Tickets || {}

TicketHandler.TimeStamp = os.date( "%Y%m%d" )
TicketHandler.LogHour = TicketHandler.LogHour || 1
TicketHandler.ChatLogs = TicketHandler.ChatLogs || {}
TicketHandler.KillLogs = TicketHandler.KillLogs || {}
TicketHandler.DamageLogs = TicketHandler.DamageLogs || {}
TicketHandler.ConnectionLogs = TicketHandler.ConnectionLogs || {}

/*
	INCLUDES
*/

include( "tickethandler/config.lua" )
include( "tickethandler/data.lua" )
include( "tickethandler/logs/chatlog.lua" )
include( "tickethandler/logs/damagelog.lua" )
include( "tickethandler/logs/deathlog.lua" )
include( "tickethandler/logs/connectionlog.lua" )
include( "tickethandler/tickets.lua" )
include( "tickethandler/net.lua" )

/*
	ADDCSLUAFILE
*/

AddCSLuaFile( "tickethandler/client/fonts.lua" )
AddCSLuaFile( "tickethandler/client/vgui.lua" )
AddCSLuaFile( "tickethandler/client/cl_net.lua" )
AddCSLuaFile( "tickethandler/client/ticketmenu.lua" )

/*
	NETWORK INITIALIZING
*/

util.AddNetworkString( "TicketHandlerSendTickets" )
util.AddNetworkString( "TicketHandlerRequestTicket" )
util.AddNetworkString( "TicketHandlerSendFullTicket" )
util.AddNetworkString( "TicketHandlerCreateTempTicket" )
util.AddNetworkString( "TicketHandlerCreateTicket" )
util.AddNetworkString( "TicketHandlerChangeTicketStatus" )
/*
	TIMER
*/

local logrefreshdelay = TicketHandler.Config.LogInterval || 3600

timer.Create( "TicketHandlerUpdateLogTimer", logrefreshdelay, 0, function()

	if !( TicketHandler.TimeStamp == os.date( "%Y%m%d" ) ) then

		TicketHandler.TimeStamp = os.date( "%Y%m%d" )
		TicketHandler.LogHour = 1

	else

		TicketHandler.LogHour = TicketHandler.LogHour + 1	

	end

	TicketHandlerCreateLogFile()

end )

timer.Create( "TicketHandlerCheckLogDates", 3600, 0,  function()
	
	if !( TicketHandler.TimeStamp == os.date( "%Y%m%d" ) ) then

		TicketHandler.TimeStamp = os.date( "%Y%m%d" )
		TicketHandler.LogHour = 1	

	end

end )

/*
	CHAT COMMANDS
*/

hook.Add( "PlayerSay", "TicketHandlerChatCommands", function( ply, text, teamsay ) 

	text = string.lower( text )

	for k,v in pairs( TicketHandler.Config.ChatCommands ) do
		
		if text == v then
			ply:ConCommand( "TicketHandler_Menu" )
			return false
		end

	end

	return true

end )
