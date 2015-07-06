/*
	DATA HANDLING
*/

function TicketHandlerCreateLogFile()

	file.Write( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt" )
	print("TicketHandler generated a new log file.")

end

/*
	CREATE FOLDERS
*/

if file.Exists( TicketHandler.Config.Path, "DATA" ) then

	if file.Exists( TicketHandler.Config.Path .. "/logs", "DATA" ) then
		
		if !file.Exists( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. ".txt", "DATA" ) then
			TicketHandlerCreateLogFile()
		end

	else
	    
	    file.CreateDir( TicketHandler.Config.Path .. "/logs", "DATA" )

	end

	if !file.Exists( TicketHandler.Config.Path .. "/tickets", "DATA" ) then		
		file.CreateDir( TicketHandler.Config.Path .. "/tickets", "DATA" )
	end

	if !file.Exists( TicketHandler.Config.Path .. "/admins", "DATA" ) then
		file.CreateDir( TicketHandler.Config.Path .. "/admins", "DATA" )
	end

	file.Write( TicketHandler.Config.Path .. "/config.txt", util.TableToJSON( TicketHandler.Config ) ) 

else
    
    file.CreateDir( TicketHandler.Config.Path )
    file.CreateDir( TicketHandler.Config.Path .. "/logs" )
    file.CreateDir( TicketHandler.Config.Path .. "/tickets" )
    file.CreateDir( TicketHandler.Config.Path .. "/admins" )

end

/*
	PLAYERDATA ON CONNECT
*/

-- In order to prevent ticket spamming, players will only be able to submit a maximum of tickets per session
-- See the config if you want to change this, default is 3

hook.Add( "PlayerInitialSpawn", "TicketHandlerNewTicketSession", function( ply ) 

	if IsValid( ply ) and ply:IsPlayer() then
		ply.sessiontickets = 0
	end

end )