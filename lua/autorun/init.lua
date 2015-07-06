/*
	LOAD TICKETHANDLER
*/

if SERVER then

	include( "tickethandler/init.lua" )
	AddCSLuaFile( "tickethandler/cl_init.lua" )

else
    
	include( "tickethandler/cl_init.lua" )

end

/*
	SHARED
*/

TicketHandlerCategories = {
	'Help',
	'Report Bug',
	'Report Player'
}