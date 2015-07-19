/*
	FONTS
*/

surface.CreateFont( "TicketFontSmall", {
	font = "Trebuchet MS",
	size = 16,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "TicketFontLarge", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	bold = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "TicketFontHeader", {
	font = "Trebuchet MS",
	size = 26,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	bold = true,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

/*
	VGUI TICKET MENU
*/

local ScreenW = ScrW()
local ScreenH = ScrH()

local primarycolor = Color( 147, 112, 219, 255 ) -- For easier editing later on, the main body
local primarycolor2 = Color( 216, 191, 216, 255 ) -- Lighter primary color
local secondarycolor = Color( 255, 255, 50, 255 ) -- For easier editing later on, header and highlighted areas
local secondarycolor2 = Color( 240, 240, 30, 255 ) -- Darker for effects

TicketHandlerPanel = {}

function TicketHandlerPanel:Init()

	self:SetSize( ScreenW / 3 * 2, ScreenH / 3 * 2 )
	self:Center()

end

function TicketHandlerPanel:Paint( w, h )

	draw.RoundedBox( 0, 0, 32, w, h, primarycolor )
	draw.RoundedBox( 0, 0, 0, w, 16, secondarycolor )
	draw.RoundedBox( 0, 0, 16, w, 16, secondarycolor2 )

end

TicketHandlerTab = {}

function TicketHandlerTab:Init()

	self:SetSize( ScreenW / 3 * 2 - 8, ScreenH / 3 * 2 - 8 )
	self:Center()

end

function TicketHandlerTab:Paint( w, h )

	draw.RoundedBox( 0, 0, 0, w, h, primarycolor2 )

end

TicketHandlerHeaderButton = {}

function TicketHandlerHeaderButton:Init()

	self:SetHeight( 24 )
	self:Center()
	self:SetFont( "TicketFontHeader" )

end

function TicketHandlerHeaderButton:Paint( w, h )

	draw.RoundedBox( 0, 0, w, w/2, h, secondarycolor )
	draw.RoundedBox( 0, 0, w/2, w/2, h, secondarycolor2 )

end

TicketHandlerCloseButton = {}

function TicketHandlerCloseButton:Init()

	self:SetSize( 24, 24 )
	self:Center()

end

function TicketHandlerCloseButton:Paint( w, h )

	draw.RoundedBox( 0, 0, 0, w, h/2, Color( 200, 0, 0, 255 ) )
	draw.RoundedBox( 0, 0, h/2, w, h/2, Color( 175, 0, 0, 255 ) )

end

vgui.Register( "THPanel", TicketHandlerPanel, "EditablePanel" )
vgui.Register( "THTab", TicketHandlerTab, "Panel" )
vgui.Register( "THHeaderButton", TicketHandlerHeaderButton, "DButton" )
vgui.Register( "THCloseButton", TicketHandlerCloseButton, "DButton" )