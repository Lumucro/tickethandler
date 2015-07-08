local THMenu = {}

function TicketMenuFillTickets()

	if THMenu.TicketsListView == nil then return end
	THMenu.TicketsListView:Clear()

	for k,v in pairs( TicketHandler.Tickets ) do

		local status = "Awaiting Response"
		if v.status == 1 then status = "Being Reviewed" elseif v.status == 2 then status = "Closed" end

		THMenu.TicketsListView:AddLine( v.time, v.number, v.category, v.user .. " (" .. v.steamid .. ")", status )

	end

end

function TicketMenuOpenTicket( ticket )

	if THMenu.OpenTicketTab == nil then return end

	if ticket.admin == nil then
		THMenu.TicketAdminLabel:SetText( "waiting for admin" )
	else
		THMenu.TicketAdminLabel:SetText( ticket.admin )		
	end

	THMenu.TicketDescription:SetText( ticket.message )

	THMenu.OpenTicketTab:Show()

end

local function TicketHandlerMenu()

	THMenu.Main = vgui.Create( "THPanel" )

	-- Header

		--Header buttons
		THMenu.HeaderButtons = vgui.Create( "DPanel", THMenu.Main )
		THMenu.HeaderButtons:SetSize( THMenu.Main:GetWide()-8, 24 )
		THMenu.HeaderButtons:SetPos( 4, 4 )
		THMenu.HeaderButtons:SetBackgroundColor( Color( 0, 0, 0, 0 ) )

			--Close menu
			THMenu.CloseButton = vgui.Create( "THCloseButton", THMenu.HeaderButtons )
			THMenu.CloseButton:Dock( RIGHT ) 
			THMenu.CloseButton:DockMargin( 4, 0, 0, 0 )
			THMenu.CloseButton:SetText( "" )
			THMenu.CloseButton.DoClick = function()
				THMenu.Main:Hide()
			end

			--Create new ticket
			THMenu.CreateTicketButton = vgui.Create( "THHeaderButton", THMenu.HeaderButtons )
			THMenu.CreateTicketButton:SetText( "Create Ticket" )
			THMenu.CreateTicketButton:SizeToContentsX()
			THMenu.CreateTicketButton:Dock( LEFT )
			THMenu.CreateTicketButton:DockMargin( 4, 0, 0, 0 ) 

			--View tickets (my tickets for users or all tickets for admins)
			THMenu.ViewTicketsButton = vgui.Create( "THHeaderButton", THMenu.HeaderButtons )
			THMenu.ViewTicketsButton:SetText( "View Tickets" )
			THMenu.ViewTicketsButton:Dock( LEFT ) 
			THMenu.ViewTicketsButton:DockMargin( 24, 0, 24, 0 )
			THMenu.ViewTicketsButton:SizeToContentsX()

			--View admins (for owner or superadmins)
			THMenu.ViewAdminsButton = vgui.Create( "THHeaderButton", THMenu.HeaderButtons )
			THMenu.ViewAdminsButton:SetText( "Admin Overview" )
			THMenu.ViewAdminsButton:SizeToContentsX()
			THMenu.ViewAdminsButton:Dock( LEFT )

	-- Tabs

		--Create ticket
		THMenu.CreateTicketTab = vgui.Create( "THTab", THMenu.Main )
		THMenu.CreateTicketTab:Dock( FILL )
		THMenu.CreateTicketTab:DockMargin( 4, 36, 4, 4 )

			--Upper panel
			THMenu.CTUpperPanel = vgui.Create( "DPanel", THMenu.CreateTicketTab )
			THMenu.CTUpperPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )
			THMenu.CTUpperPanel:Dock( TOP )
			THMenu.CTUpperPanel:DockMargin( 4, 4, 4, 0 )

				THMenu.SelectCategory = vgui.Create( "DComboBox", THMenu.CTUpperPanel )

				for k,v in pairs( TicketHandlerCategories ) do
					THMenu.SelectCategory:AddChoice( v )
				end

				THMenu.SelectCategory:Dock( LEFT )
				THMenu.SelectCategory:SetSize( THMenu.Main:GetWide() / 2, 30 )
				THMenu.SelectCategory:SetValue( "Select a ticket category" )
					
				THMenu.ReportPlayerSelect = vgui.Create( "DComboBox", THMenu.CTUpperPanel )
				THMenu.ReportPlayerSelect:SetColor( Color( 0, 0, 0, 255 ) )

				for k,v in pairs( player.GetAll() ) do
					THMenu.ReportPlayerSelect:AddChoice( v:Nick() .. " (" .. v:SteamID() .. ")" )
				end

				THMenu.ReportPlayerSelect:SetSize( THMenu.Main:GetWide() / 4, 30 )
				THMenu.ReportPlayerSelect:Dock( RIGHT )
				THMenu.ReportPlayerSelect:DockMargin( 32, 0, 0, 0 )
				THMenu.ReportPlayerSelect:Hide()

			--Bottom panel
			THMenu.CTBottomPanel = vgui.Create( "DPanel", THMenu.CreateTicketTab )
			THMenu.CTBottomPanel:SetSize( 100, 30 )
			THMenu.CTBottomPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) ) 
			THMenu.CTBottomPanel:Dock( BOTTOM )
			THMenu.CTBottomPanel:DockMargin( 4, 4, 4, 4 )

				THMenu.SubmitTicketButton = vgui.Create( "DButton", THMenu.CTBottomPanel )
				THMenu.SubmitTicketButton:SetSize( 100, 24 )
				THMenu.SubmitTicketButton:SetText( "Create Ticket" )
				THMenu.SubmitTicketButton:Dock( RIGHT )
				THMenu.SubmitTicketButton:DockMargin( 0, 3, 0, 3 )
				
				THMenu.IncludeChatLogs = vgui.Create( "DCheckBoxLabel", THMenu.CTBottomPanel )
				THMenu.IncludeChatLogs:SetText( "Include chat logs" )
				THMenu.IncludeChatLogs:SetSize( 140, 30 )
				THMenu.IncludeChatLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				THMenu.IncludeChatLogs:Dock( LEFT )
				THMenu.IncludeChatLogs:DockMargin( 0, 8, 0, 0 )

				THMenu.IncludeDeathLogs = vgui.Create( "DCheckBoxLabel", THMenu.CTBottomPanel )
				THMenu.IncludeDeathLogs:SetText( "Include death logs" )
				THMenu.IncludeDeathLogs:SetSize( 140, 30 )
				THMenu.IncludeDeathLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				THMenu.IncludeDeathLogs:Dock( LEFT )
				THMenu.IncludeDeathLogs:DockMargin( 0, 8, 0, 0 )

				THMenu.IncludeDamageLogs = vgui.Create( "DCheckBoxLabel", THMenu.CTBottomPanel )
				THMenu.IncludeDamageLogs:SetText( "Include damage logs" )
				THMenu.IncludeDamageLogs:SetSize( 140, 30 )
				THMenu.IncludeDamageLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				THMenu.IncludeDamageLogs:Dock( LEFT )
				THMenu.IncludeDamageLogs:DockMargin( 0, 8, 0, 0 )

				THMenu.IncludeConnectionLogs = vgui.Create( "DCheckBoxLabel", THMenu.CTBottomPanel )
				THMenu.IncludeConnectionLogs:SetText( "Include connection logs" )
				THMenu.IncludeConnectionLogs:SetSize( 140, 30 )
				THMenu.IncludeConnectionLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				THMenu.IncludeConnectionLogs:Dock( LEFT )
				THMenu.IncludeConnectionLogs:DockMargin( 0, 8, 0, 0 )

			--Top panel
			THMenu.CTTopPanel = vgui.Create( "DPanel", THMenu.CreateTicketTab )
			THMenu.CTTopPanel:SetSize( THMenu.CreateTicketTab:GetWide() - 8, 100 )
			THMenu.CTTopPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )
			THMenu.CTTopPanel:Dock( LEFT )
			THMenu.CTTopPanel:DockMargin( 4, 4, 4, 0 )

				THMenu.InfoLabel = vgui.Create( "DLabel", THMenu.CTTopPanel )
				THMenu.InfoLabel:SetText( "Please describe the issue as well as you can" )
				THMenu.InfoLabel:SetColor( Color( 0, 0, 0, 255 ) )
				THMenu.InfoLabel:Dock( TOP )

				THMenu.TicketMessage = vgui.Create( "DTextEntry", THMenu.CTTopPanel )

				THMenu.SelectCategory.OnSelect = function( panel, index, value )
					if value == "Report Player" then
						THMenu.ReportPlayerSelect:Dock( TOP )
						THMenu.ReportPlayerSelect:Show()
					else
						THMenu.ReportPlayerSelect:Dock( NODOCK )
						THMenu.ReportPlayerSelect:Hide()
						THMenu.TicketMessage:Dock( NODOCK )
						THMenu.TicketMessage:Dock( FILL )
					end
				end

				THMenu.TicketMessage:Dock( FILL )
				THMenu.TicketMessage:SetMultiline( true )

			THMenu.CTBottomPanel:SizeToContents()
			THMenu.CTTopPanel:SizeToContents()

		--View tickets
		THMenu.ViewTicketsTab = vgui.Create( "THTab", THMenu.Main )
		THMenu.ViewTicketsTab:Dock( FILL )
		THMenu.ViewTicketsTab:DockMargin( 4, 36, 4, 4 )

			THMenu.TicketsListView = vgui.Create( "DListView", THMenu.ViewTicketsTab )
			THMenu.TicketsListView:Dock( FILL )
			THMenu.TicketsListView:DockMargin( 4, 4, 4, 4 )
			THMenu.TicketsListView:AddColumn( "Date" )
			THMenu.TicketsListView:AddColumn( "Ticketnumber" )
			THMenu.TicketsListView:AddColumn( "Category" )
			THMenu.TicketsListView:AddColumn( "User" )
			THMenu.TicketsListView:AddColumn( "Status" )
			TicketMenuFillTickets()

		THMenu.ViewTicketsTab:Hide()

		--View specific ticket
		THMenu.OpenTicketTab = vgui.Create( "THTab", THMenu.Main )
		THMenu.OpenTicketTab:Dock( FILL )
		THMenu.OpenTicketTab:DockMargin( 4, 36, 4, 4 )

			--Top panel
			THMenu.OTTopPanel = vgui.Create( "DPanel", THMenu.OpenTicketTab )
			THMenu.OTTopPanel:Dock( TOP )
			THMenu.OTTopPanel:DockMargin( 4, 4, 4, 4 )
			THMenu.OTTopPanel:SetBackgroundColor( Color( 255, 0, 0, 255 ) )

				--Ticket information
				THMenu.TicketInfoLabel1 = vgui.Create( "DLabel", THMenu.OTTopPanel )
				THMenu.TicketInfoLabel1:Dock( LEFT )
				THMenu.TicketInfoLabel1:SetSize( 200, 20 )
				THMenu.TicketInfoLabel1:SetFont( "TicketFontLarge" )
				THMenu.TicketInfoLabel1:SetText( "TICKET INFORMATION" )
				THMenu.TicketInfoLabel1:SetTextColor( Color( 0, 0, 0, 255 ) )

				THMenu.TicketAdminLabel = vgui.Create( "DLabel", THMenu.OTTopPanel ) 
				THMenu.TicketAdminLabel:Dock( RIGHT )
				THMenu.TicketAdminLabel:SetSize( 200, 20 )
				THMenu.TicketAdminLabel:SetFont( "TicketFontLarge" )
				THMenu.TicketAdminLabel:SetText( "none" )
				THMenu.TicketAdminLabel:SetTextColor( Color( 0, 0, 0, 255 ) )

			--Bottom Panel
			THMenu.OTBottomPanel = vgui.Create( "DPanel", THMenu.OpenTicketTab )
			THMenu.OTBottomPanel:Dock( BOTTOM )
			THMenu.OTBottomPanel:DockMargin( 4, 4, 4, 4 )
			THMenu.OTBottomPanel:SetBackgroundColor( Color( 255, 0, 0, 255 ) )

				THMenu.MarkTicketClosed = vgui.Create( "DButton", THMenu.OTBottomPanel )
				THMenu.MarkTicketClosed:Dock( RIGHT )
				THMenu.MarkTicketClosed:SetSize( 100, 24 )
				THMenu.MarkTicketClosed:SetText( "Close Ticket" )

			--Right Panel
			THMenu.OTRightPanel = vgui.Create( "DPanel", THMenu.OpenTicketTab )
			THMenu.OTRightPanel:Dock( RIGHT )
			THMenu.OTRightPanel:DockMargin( 4, 0, 4, 0 )
			THMenu.OTRightPanel:SetBackgroundColor( Color( 255, 0, 0, 255 ) )

				THMenu.ViewChatLogs = vgui.Create( "DButton", THMenu.OTRightPanel )
				THMenu.ViewChatLogs:SetText( "View chat logs" )
				THMenu.ViewChatLogs:Dock( TOP )
				THMenu.ViewChatLogs:DockMargin( 4, 4, 4, 4 )

				THMenu.ViewDeathLogs = vgui.Create( "DButton", THMenu.OTRightPanel )
				THMenu.ViewDeathLogs:SetText( "View chat logs" )
				THMenu.ViewDeathLogs:Dock( TOP )
				THMenu.ViewDeathLogs:DockMargin( 4, 4, 4, 4 )

				THMenu.ViewDamageLogs = vgui.Create( "DButton", THMenu.OTRightPanel )
				THMenu.ViewDamageLogs:SetText( "View chat logs" )
				THMenu.ViewDamageLogs:Dock( TOP )
				THMenu.ViewDamageLogs:DockMargin( 4, 4, 4, 4 )

				THMenu.ViewConnectionLogs = vgui.Create( "DButton", THMenu.OTRightPanel )
				THMenu.ViewConnectionLogs:SetText( "View chat logs" )
				THMenu.ViewConnectionLogs:Dock( TOP )
				THMenu.ViewConnectionLogs:DockMargin( 4, 4, 4, 4 )

			--Left Panel
			THMenu.OTLeftPanel = vgui.Create( "DPanel", THMenu.OpenTicketTab )
			THMenu.OTLeftPanel:Dock( FILL )
			THMenu.OTLeftPanel:DockMargin( 4, 0, 0, 0 )
			THMenu.OTLeftPanel:SetBackgroundColor( Color( 255, 0, 0, 255 ) )

				THMenu.TicketDescription = vgui.Create( "DLabel", THMenu.OTLeftPanel )
				THMenu.TicketDescription:SetFont( "TicketFontSmall" )
				THMenu.TicketDescription:SetText( "No ticket description" )
				THMenu.TicketDescription:SetTextColor( Color( 0, 0, 0, 255 ) )
				THMenu.TicketDescription:Dock( FILL )
				THMenu.TicketDescription:SetWrap( true )

		THMenu.OpenTicketTab:Hide()

	--

	THMenu.CreateTicketButton.DoClick = function() 
		THMenu.ViewTicketsTab:Hide()
		THMenu.OpenTicketTab:Hide()
		THMenu.CreateTicketTab:Show()
	end

	THMenu.ViewTicketsButton.DoClick = function()
		THMenu.CreateTicketTab:Hide()
		THMenu.OpenTicketTab:Hide()
		THMenu.ViewTicketsTab:Show()
	end

	THMenu.SubmitTicketButton.DoClick = function()

		local newticket = {}
		newticket.category = THMenu.SelectCategory:GetValue()

		if newticket.category == "Report Player" then
			newticket.rply = THMenu.ReportPlayerSelect:GetSelected()
		end

		newticket.message = THMenu.TicketMessage:GetText()
		newticket.chat = THMenu.IncludeChatLogs:GetChecked()
		newticket.deaths = THMenu.IncludeDeathLogs:GetChecked()
		newticket.connection = THMenu.IncludeConnectionLogs:GetChecked()
		newticket.damage = THMenu.IncludeDamageLogs:GetChecked()

		TicketHandlerCreateTicket( newticket )

	end

	THMenu.TicketsListView.DoDoubleClick = function( lineID, line )

		local selectedticketnumber = THMenu.TicketsListView:GetLine( line ):GetValue( 2 )
		TicketHandlerRequestFullTicket( selectedticketnumber )

	end

	THMenu.Main:MakePopup()

end

concommand.Add( "TicketHandler_Menu", TicketHandlerMenu )