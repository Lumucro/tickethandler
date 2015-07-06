/*
	TICKETS NETWORKING SERVERSIDE
*/

local function IsTicketHandlerAdmin( ply ) 

	for k,v in pairs( TicketHandler.Config.AdminGroups ) do

		if ply:IsUserGroup( v ) then
			return true
		end

	end

	return false

end

function TicketHandlerSendNewTicket( ticketinfo )

	ticketinfo = { ticketinfo }

	for k,v in pairs( player.GetAll() ) do
		if ticketinfo[1].steamid == v:SteamID() || IsTicketHandlerAdmin( v ) then
			
			net.Start( "TicketHandlerSendTickets" )
				net.WriteTable( ticketinfo )
			net.Send( v )

		end
	end

end

function TicketHandlerSendTickets( ply ) 

	if !ply:GetPData( "TicketHandlerAllowed", true ) then return end

	local sendingtickets = {}

	for k,v in pairs( TicketHandler.Tickets ) do
		if v.steamid == ply:SteamID() || IsTicketHandlerAdmin( ply ) then
			table.insert( sendingtickets, v )
		end
	end

	net.Start( "TicketHandlerSendTickets" )
		net.WriteTable( sendingtickets )
	net.Send( ply )
	
end

local function TicketHandlerSendFullTicket( ply, ticketnumber )

	local fullticket = nil

	if file.Exists( TicketHandler.Config.Path .. "/tickets/" .. ticketnumber .. ".txt", "DATA" ) then
		fullticket = util.JSONToTable( file.Read( TicketHandler.Config.Path .. "/tickets/" .. ticketnumber .. ".txt", "DATA" ) )
	else
		return
	end

	if !( fullticket.usersteamid == ply:SteamID() || IsTicketHandlerAdmin( ply ) ) then return end

	net.Start( "TicketHandlerSendFullTicket" )
		net.WriteTable( fullticket )
	net.Send( ply )

end

net.Receive( "TicketHandlerRequestTicket", function( length, ply )

	if !ply:GetPData( "TicketHandlerAllowed", true ) then return end	
	TicketHandlerSendFullTicket( ply, net.ReadString() )

end )

net.Receive( "TicketHandlerCreateTempTicket", function( length, ply )

	if !ply:GetPData( "TicketHandlerAllowed", true ) then return end

	ply.thtempticket = {}
	ply.thtempticket.chat = TicketHandler.ChatLogs
	ply.thtempticket.damage = TicketHandler.DamageLogs
	ply.thtempticket.deaths = TicketHandler.KillLogs
	ply.thtempticket.connection = TicketHandler.ConnectionLogs

end )

net.Receive( "TicketHandlerCreateTicket", function( length, ply )

	if !ply:GetPData( "TicketHandlerAllowed", true ) then return end
	
	local ticketdata = net.ReadTable()
	CreateTicket( ply, ticketdata.category, ticketdata.rply, ticketdata.message, ticketdata.chat, ticketdata.damage, ticketdata.deaths, ticketdata.connection )

	ply.thtempticket = nil

end )


/*
	HOOKS
*/

hook.Add( "PlayerInitialSpawn", "TicketHandlerSendTickets", function( ply ) 

	TicketHandlerSendTickets( ply )

end )