/*
	NETWORKING TICKETS CLIENTSIDE4
*/

local function TicketHandlerUpdateTicket( ticket )

	if ticket.status == 0 then
		TicketHandlerChangeTicketStatus( { number = ticket.number, status = 1 } )
	end

	TicketMenuFillTickets()
	TicketMenuOpenTicket( ticket )

end

function TicketHandlerRequestFullTicket( ticketnumber )

	net.Start( "TicketHandlerRequestTicket" )
		net.WriteString( ticketnumber )
	net.SendToServer()

end

net.Receive( "TicketHandlerSendFullTicket", function( len )

	fullticket = net.ReadTable()
	TicketHandlerUpdateTicket( fullticket )

end )

function TicketHandlerCreateTempTicket() 

	net.Start( "TicketHandlerCreateTempTicket" )
	net.SendToServer()

end

function TicketHandlerCreateTicket( ticketinfo )

	net.Start( "TicketHandlerCreateTicket" )
		net.WriteTable( ticketinfo )
	net.SendToServer()

end

function TicketHandlerChangeTicketStatus( ticketinfo )

	net.Start( "TicketHandlerChangeTicketStatus" )
		net.WriteTable( ticketinfo )
	net.SendToServer()

	for k,v in pairs( TicketHandler.Tickets ) do
		if v.number == ticketinfo.number then
			v.status = ticketinfo.status
		end
	end

end

net.Receive( "TicketHandlerSendTickets", function ( len )

	local newtickets = net.ReadTable()
	table.Add( TicketHandler.Tickets, newtickets )

	TicketMenuFillTickets()

end )