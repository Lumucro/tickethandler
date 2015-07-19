/*
	LOG DAMAGE
*/

hook.Add( "EntityTakeDamage", "TicketHandlerLogDamage", function( target, dmginfo )

	if GAMEMODE_NAME == "terrortown" && ( GAMEMODE.round_state == ROUND_WAIT || GAMEMODE.round_state == ROUND_PREP ) then return end
	if dmginfo:GetDamage() == 0 then return end

	if target:IsPlayer() && IsValid(target) then

		local logmsg = {

			victim = target:Nick(),
			victimsteamid = target:SteamID(),
			inflictor = dmginfo:GetInflictor():GetClass(),
			damage = math.Round( dmginfo:GetDamage(), 0 )

		}

		if dmginfo:GetAttacker():IsPlayer() && IsValid then
			
			logmsg.attacker = dmginfo:GetAttacker():Nick()
			logmsg.attackersteamid = dmginfo:GetAttacker():SteamID()

		else
		    
			logmsg.attacker = dmginfo:GetAttacker():GetClass()
			logmsg.attackersteamid = "NON-PLAYER"

		end


		if #TicketHandler.DamageLogs >= TicketHandler.Config.MaxLoggedDamage then
			
			table.remove( TicketHandler.DamageLogs, 1 )

		end

		table.insert( TicketHandler.DamageLogs, logmsg )

		if TicketHandler.Config.LogDamageToFile then
		
			local filelog

			if dmginfo:GetAttacker():IsPlayer() then
				filelog = dmginfo:GetAttacker():Nick() .. " (" .. dmginfo:GetAttacker():SteamID() .. ") hurt " .. target:Nick() .. " (" .. target:SteamID() .. ") for " .. math.Round( dmginfo:GetDamage(), 0 ) .. " dmg"
			else
				filelog = dmginfo:GetAttacker():GetClass() .. " hurt " .. target:Nick() .. " (" .. target:SteamID() .. ") for " .. math.Round( dmginfo:GetDamage(), 0 ) .. " dmg"
			end

			filelog = filelog .. ";"

			file.Append( TicketHandler.Config.Path .. "/logs/log_" .. TicketHandler.TimeStamp .. "_" .. TicketHandler.LogHour .. ".txt", filelog )

		end

	end

end )