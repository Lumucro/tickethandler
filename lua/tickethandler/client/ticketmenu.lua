local function TicketHandlerMenu()

	THMenu = vgui.Create( "THPanel" )

	-- Header

		--Header buttons
		local HeaderButtons = vgui.Create( "DPanel", THMenu )
		HeaderButtons:SetSize( THMenu:GetWide()-8, 24 )
		HeaderButtons:SetPos( 4, 4 )
		HeaderButtons:SetBackgroundColor( Color( 0, 0, 0, 0 ) )

			--Close menu
			local CloseButton = vgui.Create( "THCloseButton", HeaderButtons )
			CloseButton:Dock( RIGHT ) 
			CloseButton:DockMargin( 4, 0, 0, 0 )
			CloseButton:SetText( "" )
			CloseButton.DoClick = function()
				THMenu:Hide()
			end

			--Create new ticket
			local CreateTicketButton = vgui.Create( "THHeaderButton", HeaderButtons )
			CreateTicketButton:SetText( "Create Ticket" )
			CreateTicketButton:SizeToContentsX()
			CreateTicketButton:Dock( LEFT )
			CreateTicketButton:DockMargin( 4, 0, 0, 0 ) 

			--View tickets (my tickets for users or all tickets for admins)
			local ViewTicketsButton = vgui.Create( "THHeaderButton", HeaderButtons )
			ViewTicketsButton:SetText( "View Tickets" )
			ViewTicketsButton:Dock( LEFT ) 
			ViewTicketsButton:DockMargin( 24, 0, 24, 0 )
			ViewTicketsButton:SizeToContentsX()

			--View admins (for owner or superadmins)
			local ViewAdminsButton = vgui.Create( "THHeaderButton", HeaderButtons )
			ViewAdminsButton:SetText( "Admin Overview" )
			ViewAdminsButton:SizeToContentsX()
			ViewAdminsButton:Dock( LEFT )

	-- Tabs

		--Create ticket
		local CreateTicketTab = vgui.Create( "THTab", THMenu )
		CreateTicketTab:Dock( FILL )
		CreateTicketTab:DockMargin( 4, 36, 4, 4 )

			--Upper panel
			local CTUpperPanel = vgui.Create( "DPanel", CreateTicketTab )
			CTUpperPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )
			CTUpperPanel:Dock( TOP )
			CTUpperPanel:DockMargin( 4, 4, 4, 0 )

				local SelectCategory = vgui.Create( "DComboBox", CTUpperPanel )

				for k,v in pairs( TicketHandlerCategories ) do
					SelectCategory:AddChoice( v )
				end

				SelectCategory:Dock( LEFT )
				SelectCategory:SetSize( THMenu:GetWide() / 2, 30 )
				SelectCategory:SetValue( "Select a ticket category" )
					
				local ReportPlayerSelect = vgui.Create( "DComboBox", CTUpperPanel )
				ReportPlayerSelect:SetColor( Color( 0, 0, 0, 255 ) )

				for k,v in pairs( player.GetAll() ) do
					ReportPlayerSelect:AddChoice( v:Nick() .. " (" .. v:SteamID() .. ")" )
				end

				ReportPlayerSelect:SetSize( THMenu:GetWide() / 4, 30 )
				ReportPlayerSelect:Dock( RIGHT )
				ReportPlayerSelect:DockMargin( 32, 0, 0, 0 )
				ReportPlayerSelect:Hide()

			--Bottom panel
			local CTBottomPanel = vgui.Create( "DPanel", CreateTicketTab )
			CTBottomPanel:SetSize( 100, 30 )
			CTBottomPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) ) 
			CTBottomPanel:Dock( BOTTOM )
			CTBottomPanel:DockMargin( 4, 4, 4, 4 )

				local SubmitTicketButton = vgui.Create( "DButton", CTBottomPanel )
				SubmitTicketButton:SetSize( 100, 24 )
				SubmitTicketButton:SetText( "Create Ticket" )
				SubmitTicketButton:Dock( RIGHT )
				SubmitTicketButton:DockMargin( 0, 3, 0, 3 )
				
				local IncludeChatLogs = vgui.Create( "DCheckBoxLabel", CTBottomPanel )
				IncludeChatLogs:SetText( "Include chat logs" )
				IncludeChatLogs:SetSize( 140, 30 )
				IncludeChatLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				IncludeChatLogs:Dock( LEFT )
				IncludeChatLogs:DockMargin( 0, 8, 0, 0 )

				local IncludeDeathLogs = vgui.Create( "DCheckBoxLabel", CTBottomPanel )
				IncludeDeathLogs:SetText( "Include death logs" )
				IncludeDeathLogs:SetSize( 140, 30 )
				IncludeDeathLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				IncludeDeathLogs:Dock( LEFT )
				IncludeDeathLogs:DockMargin( 0, 8, 0, 0 )

				local IncludeDamageLogs = vgui.Create( "DCheckBoxLabel", CTBottomPanel )
				IncludeDamageLogs:SetText( "Include damage logs" )
				IncludeDamageLogs:SetSize( 140, 30 )
				IncludeDamageLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				IncludeDamageLogs:Dock( LEFT )
				IncludeDamageLogs:DockMargin( 0, 8, 0, 0 )

				local IncludeConnectionLogs = vgui.Create( "DCheckBoxLabel", CTBottomPanel )
				IncludeConnectionLogs:SetText( "Include connection logs" )
				IncludeConnectionLogs:SetSize( 140, 30 )
				IncludeConnectionLogs:SetTextColor( Color( 0, 0, 0, 255 ) )
				IncludeConnectionLogs:Dock( LEFT )
				IncludeConnectionLogs:DockMargin( 0, 8, 0, 0 )

			--Top panel
			local CTTopPanel = vgui.Create( "DPanel", CreateTicketTab )
			CTTopPanel:SetSize( CreateTicketTab:GetWide() - 8, 100 )
			CTTopPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )
			CTTopPanel:Dock( LEFT )
			CTTopPanel:DockMargin( 4, 4, 4, 0 )

				local InfoLabel = vgui.Create( "DLabel", CTTopPanel )
				InfoLabel:SetText( "Please describe the issue as well as you can" )
				InfoLabel:SetColor( Color( 0, 0, 0, 255 ) )
				InfoLabel:Dock( TOP )

				local TicketMessage = vgui.Create( "DTextEntry", CTTopPanel )

				SelectCategory.OnSelect = function( panel, index, value )
					if value == "Report Player" then
						ReportPlayerSelect:Dock( TOP )
						ReportPlayerSelect:Show()
					else
						ReportPlayerSelect:Dock( NODOCK )
						ReportPlayerSelect:Hide()
						TicketMessage:Dock( NODOCK )
						TicketMessage:Dock( FILL )
					end
				end

				TicketMessage:Dock( FILL )
				TicketMessage:SetMultiline( true )

			CTBottomPanel:SizeToContents()
			CTTopPanel:SizeToContents()

		--View tickets
		local ViewTicketsTab = vgui.Create( "THTab", THMenu )
		ViewTicketsTab:Dock( FILL )
		ViewTicketsTab:DockMargin( 4, 36, 4, 4 )

			local TicketsListView = vgui.Create( "DListView", ViewTicketsTab )
			TicketsListView:Dock( FILL )
			TicketsListView:DockMargin( 4, 4, 4, 4 )
			TicketsListView:AddColumn( "Date" )
			TicketsListView:AddColumn( "Ticketnumber" )
			TicketsListView:AddColumn( "Category" )
			TicketsListView:AddColumn( "User" )
			TicketsListView:AddColumn( "Status" )

			for k,v in pairs( TicketHandler.Tickets ) do

				local status = "Awaiting Response"
				if v.status == 1 then status = "Being Reviewed" elseif v.status == 2 then status = "Closed" end

				TicketsListView:AddLine( v.time, v.number, v.category, v.user .. " (" .. v.steamid .. ")", status )

			end

		ViewTicketsTab:Hide()

		--View specific ticket
		local OpenTicketTab = vgui.Create( "THTab", THMenu )
		OpenTicketTab:Dock( FILL )
		OpenTicketTab:DockMargin( 4, 36, 4, 4 )

			--Top panel
			local OTTopPanel = vgui.Create( "DPanel", OpenTicketTab )
			OTTopPanel:Dock( TOP )
			OTTopPanel:DockMargin( 4, 4, 4, 0 )
			OTTopPanel:SetBackgroundColor( Color( 255, 0, 0, 255 ) )

				--Ticket information
				local TicketInfoLabel1 = vgui.Create( "DLabel", OTTopPanel )
				TicketInfoLabel1:Dock( LEFT )
				TicketInfoLabel1:SetSize( 200, 20 )
				TicketInfoLabel1:SetFont( "TicketFontLarge" )
				TicketInfoLabel1:SetText( "TICKET INFORMATION" )
				TicketInfoLabel1:SetTextColor( Color( 0, 0, 0, 255 ) )

				local TicketAdminLabel = vgui.Create( "DLabel", OTTopPanel ) 
				TicketAdminLabel:Dock( RIGHT )
				TicketAdminLabel:SetSize( 200, 20 )
				TicketAdminLabel:SetFont( "TicketFontLarge" )
				TicketAdminLabel:SetText( "none" )
				TicketAdminLabel:SetTextColor( Color( 0, 0, 0, 255 ) )

		OpenTicketTab:Hide()


	--

	CreateTicketButton.DoClick = function() 
		ViewTicketsTab:Hide()
		OpenTicketTab:Hide()
		CreateTicketTab:Show()
	end

	ViewTicketsButton.DoClick = function()
		CreateTicketTab:Hide()
		OpenTicketTab:Hide()
		ViewTicketsTab:Show()
	end

	SubmitTicketButton.DoClick = function()

		local newticket = {}
		newticket.category = SelectCategory:GetValue()

		if newticket.category == "Report Player" then
			newticket.rply = ReportPlayerSelect:GetSelected()
		end

		newticket.message = TicketMessage:GetText()
		newticket.chat = IncludeChatLogs:GetChecked()
		newticket.deaths = IncludeDeathLogs:GetChecked()
		newticket.connection = IncludeConnectionLogs:GetChecked()
		newticket.damage = IncludeDamageLogs:GetChecked()

		TicketHandlerCreateTicket( newticket )

	end

	TicketsListView.DoDoubleClick = function( lineID, line )

		local selectedticketnumber = TicketsListView:GetLine( line ):GetValue( 2 )
		local OpenTicket = {}

		if !file.Exists( "tickethandler/tickets/" .. selectedticketnumber .. ".txt", "DATA" ) then
			OpenTicket = TicketHandlerRequestFullTicket( selectedticketnumber )
		else
			OpenTicket = util.JSONToTable( file.Read( "tickethandler/tickets/" .. selectedticketnumber .. ".txt", "DATA" ) )
		end

		OpenTicketTab:Show()

	end

	THMenu:MakePopup()

end

concommand.Add( "TicketHandler_Menu", TicketHandlerMenu )