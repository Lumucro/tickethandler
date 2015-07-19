/*
	TICKETS SYSTEM
*/

function CreateTicket( ply, cat, rply, msg, chatlog, dmglog, deathlog, connectlog )

	if rply == nil && cat == "Report Player" then return end
	if ply.sessiontickets >= TicketHandler.Config.MaxTickets then return end

	local tickettime = os.time()

	while file.Exists( TicketHandler.Config.Path .. "/tickets/" .. tickettime .. ".txt", "DATA" ) do
		tickettime = tickettime + 1
	end

	local ticketinfo = {

		number = tickettime,
		user = ply:Nick(),
		usersteamid = ply:SteamID(),
		message = msg,
		date = util.DateStamp(),
		category = cat,
		status = 0,
		admin = nil,
		reply = nil

	}

	if rply != nil && cat == "Report Player" then

		ticketinfo.reported = rply:Nick()
		ticketinfo.reportedsteamid = rply:SteamID()

	end

	if !IsValid( ply.thtempticket ) then
		ply.thtempticket = { chat, deaths, damage, connection } --Prevent errors
	end

	if chatlog then
		if istable( ply.thtempticket.chat ) then
			ticketinfo.chatlog = ply.thtempticket.chat
		else
			ticketinfo.chatlog = TicketHandler.ChatLogs
		end
	end

	if dmglog then
		if istable( ply.thtempticket.damage ) then
			ticketinfo.dmglog = ply.thtempticket.damage
		else
			ticketinfo.dmglog = TicketHandler.DamageLogs
		end
	end

	if deathlog then
		if istable( ply.thtempticket.deaths ) then
			ticketinfo.deathlog = ply.thtempticket.deaths
		else
			ticketinfo.deathlog = TicketHandler.DeathLogs
		end
	end

	if connectlog then
		if istable( ply.thtempticket.connection ) then
			ticketinfo.connectlog = ply.thtempticket.connection
		else
			ticketinfo.connectlog = TicketHandler.ConnectionLogs
		end
	end

	table.insert( TicketHandler.Tickets, { number = tickettime, time = ticketinfo.date, category = cat, user = ply:Nick(), status = 0, steamid = ply:SteamID() } )
	file.Write( TicketHandler.Config.Path .. "/tickets/" .. tickettime .. ".txt", util.TableToJSON( ticketinfo ) )

	ply.sessiontickets = ply.sessiontickets + 1
	TicketHandlerSendNewTicket( { number = tickettime, time = ticketinfo.date, category = cat, user = ply:Nick(), status = 0, steamid = ply:SteamID() } )

end

/*
	READ EXISTING TICKETS
*/

local f, d = file.Find( TicketHandler.Config.Path .. "/tickets/*", "DATA" ) 

for k,v in pairs( f ) do

	local readticket = util.JSONToTable( file.Read( TicketHandler.Config.Path .. "/tickets/" .. v, "DATA" ) )

	if readticket == nil then return end
	table.insert( TicketHandler.Tickets, { number = readticket.number, time = readticket.date, category = readticket.category, user = readticket.user, status = readticket.status, steamid = readticket.usersteamid } )

end

concommand.Add("ticket", function(ply)

	CreateTicket( ply, "Report Player", ply, "this is a test ticket", true, true, true, true )

end)