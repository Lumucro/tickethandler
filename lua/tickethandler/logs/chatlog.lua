/*
	LOG CHAT
*/

hook.Add( "PlayerSay", "TicketHandlerLogChat", function( ply, text, teamsay ) 

	local logmsg = {

		name = ply:Nick(),
		steamid = ply:SteamID(),
		message = text

	}

	if #TicketHandler.ChatLogs >= TicketHandler.Config.MaxLoggedChat then
			
		table.remove( TicketHandler.ChatLogs, 1 )

	end

	table.insert( TicketHandler.ChatLogs, logmsg )

	if TicketHandler.Config.LogChatToFile then

		text = string.Replace( text, ";", "" )
		
		local filelog = ply:Nick() 
		if TicketHandler.Config.LogChatSteamID then filelog = filelog .. "(" .. ply:SteamID() end
		if TicketHandler.Config.LogChatIP && TicketHandler.Config.LogChatSteamID then filelog = filelog .. " - " .. ply:IPAddress() end	
		if TicketHandler.Config.LogChatIP && !TicketHandler.Config.LogChatSteamID then filelog = filelog .. "(" .. ply:IPAddress() end		
		if TicketHandler.Config.LogChatIP || TicketHandler.Config.LogChatSteamID then filelog = filelog .. ")" end
		filelog = filelog .. " | " .. text .. ";"

		file.Append( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt", filelog )

	end

end )