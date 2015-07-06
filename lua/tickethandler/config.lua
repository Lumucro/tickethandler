/*
	CONFIG
*/

TicketHandler.Config.Path = TicketHandler.Config.Path || "tickethandler" --tickethandler folder in DATA

TicketHandler.Config.LogInterval = 3600 -- How many seconds should log files be apart? (prevent large files to go through, eg hourly = 3600)

TicketHandler.Config.LogChatToFile = true -- Also save chatlogs to file
TicketHandler.Config.LogChatSteamID = false -- include steamID in logs
TicketHandler.Config.LogChatIP = false -- include IP in logs

TicketHandler.Config.LogDeathsToFile = true -- Also save kill logs to file

TicketHandler.Config.LogDamageToFile = true -- Save damage to the same file (as kills)

TicketHandler.Config.LogConnectionsToFile = true -- Save connection logs (connect / disconnect) to file
TicketHandler.Config.LogConnectionsIP = true -- include IP in logs

TicketHandler.Config.MaxLoggedChat = 25 -- Amount of chatmessages to keep track of (eg last 20)
TicketHandler.Config.MaxLoggedDamage = 30 -- Amount of damage events to log
TicketHandler.Config.MaxLoggedKills = 10 -- Amount of kills to log 
TicketHandler.Config.MaxLoggedConnections = 5 -- Amount of connects/disconnects to log

TicketHandler.Config.MaxTickets = 3 -- Maximum amount of open tickets per player per session

TicketHandler.Config.ChatCommands = {
	
	"!help",
	"!support",
	"!report",
	"!tickets",
	"!ticket",
	"!contact",
	"!admin"

}

TicketHandler.Config.AdminGroups = {
	
	'owner',
	'superadmin',
	'admin',
	'moderator'

} -- Groups that are allowed to review tickets

TicketHandler.Config.SupervisorGroups = {
	
	'owner',
	'superadmin'

} -- Groups that can keep track of admin activity and ratings