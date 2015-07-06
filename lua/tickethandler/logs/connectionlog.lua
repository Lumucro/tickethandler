/*
	LOG CONNECTION ACTIVITY
*/

hook.Add( "PlayerInitialSpawn", "TicketHandlerLogConnect", function( ply ) 

	local logmsg = {

		name = ply:Nick(),
		steamid = ply:SteamID(),
		type = 'connect'

	}

	if #TicketHandler.ConnectionLogs >= TicketHandler.Config.MaxLoggedConnections then
		table.remove( TicketHandler.ConnectionLogs, 1 )
	end

	table.insert( TicketHandler.ConnectionLogs, logmsg )

	if TicketHandler.Config.LogConnectionsToFile then
		
		local filemsg = ply:Nick() .. " (" .. ply:SteamID()
		if TicketHandler.Config.LogConnectionsIP then filemsg = filemsg .. " - " .. ply:IPAddress() end
		filemsg = filemsg .. ") connected;"

		file.Append( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt", filemsg )

	end

end )

hook.Add( "PlayerDisconnected", "TicketHandlerLogDisconnect", function( ply ) 

	local logmsg = {

		name = ply:Nick(),
		steamid = ply:SteamID(),
		type = 'disconnect'

	}

	if #TicketHandler.ConnectionLogs >= TicketHandler.Config.MaxLoggedConnections then
		table.remove( TicketHandler.ConnectionLogs, 1 )
	end

	table.insert( TicketHandler.ConnectionLogs, logmsg )

	if TicketHandler.Config.LogConnectionsToFile then
		
		local filemsg = ply:Nick() .. " (" .. ply:SteamID()
		if TicketHandler.Config.LogConnectionsIP then filemsg = filemsg .. " - " .. ply:IPAddress() end
		filemsg = filemsg .. ") disconnected;"

		file.Append( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt", filemsg )

	end

end )