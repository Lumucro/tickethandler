/*
	NETWORKING TICKETS CLIENTSIDE4
*/

function TicketHandlerRequestFullTicket( ticketnumber )

	net.Start( "TicketHandlerRequestTicket" )
		net.WriteString( ticketnumber )
	net.SendToServer()

	net.Receive( "TicketHandlerSendFullTicket", function( len )

		local fullticket = net.ReadTable()
		PrintTable( fullticket )

		return fullticket

	end )

	return {}

end

function TicketHandlerCreateTempTicket() 

	net.Start( "TicketHandlerCreateTempTicket" )
	net.SendToServer()

end

function TicketHandlerCreateTicket( ticketinfo )

	net.Start( "TicketHandlerCreateTicket" )
		net.WriteTable( ticketinfo )
	net.SendToServer()

end

net.Receive( "TicketHandlerSendTickets", function ( len )

	local newtickets = net.ReadTable()
	table.Add( TicketHandler.Tickets, newtickets )

end )