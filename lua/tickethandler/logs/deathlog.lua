/*
	LOG DEATHS
*/

hook.Add( "DoPlayerDeath", "TicketHandlerLogDeaths", function( ply, attacker, dmginfo )

	if IsValid(ply) then
		
		local logmsg = {
			victim = ply:Nick(),
			victimsteamid = ply:SteamID(),
			inflictor = dmginfo:GetInflictor():GetClass()
		}

		if attacker:IsPlayer() then

			logmsg.attacker = attacker:Nick()
			logmsg.attackersteamid = attacker:SteamID()

		else

			logmsg.attacker = attacker:GetClass()

		end

		if #TicketHandler.KillLogs >= TicketHandler.Config.MaxLoggedKills then
			
			table.remove( TicketHandler.KillLogs, 1 )

		end

		table.insert( TicketHandler.KillLogs, logmsg )

		if TicketHandler.Config.LogDeathsToFile then
			
			local filelog

			if attacker:IsPlayer() then
				filelog = attacker:Nick() .. " (" .. attacker:SteamID() .. ") killed " .. ply:Nick() .. " (" .. ply:SteamID() .. ") with " .. dmginfo:GetInflictor():GetClass()
			else
				filelog = attacker:GetClass() .. " killed " .. ply:Nick() .. " (" .. ply:SteamID() .. ") with " .. dmginfo:GetInflictor():GetClass()
			end

			filelog = filelog .. ";"

			file.Append( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt", filelog )

		end

	end

	PrintTable( TicketHandler.KillLogs )

end )