local DSS = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local indexDataStore = DSS:GetDataStore("DataStoreIndex")

local Assets = {
	DrawAPILogo = "rbxassetid://116610611359442",


	ValueCommandAddUnselected = "rbxassetid://133648189590649",
	ValueCommandAddSelected = "rbxassetid://128982638657506",

	ValueCommandSubUnselected = "rbxassetid://98649822489765",
	ValueCommandSubSelected = "rbxassetid://125792032941847",

	ValueCommandSetUnselected = "rbxassetid://86263468350555",
	ValueCommandSetSelected = "rbxassetid://94948230183321"
}

local UIColors = {
	Main = Color3.fromRGB(53, 53, 53),
	Secondary = Color3.fromRGB(29,29,29),
	ButtonMain = Color3.fromRGB(0, 161, 250),
	ButtonText = Color3.fromRGB(206, 250, 255),
	Detail = Color3.fromRGB(206, 250, 255)
}

local UIFonts = {
	Zekton = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	BoldZekton = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
}

local UIPositions = {
	OutputFrame = UDim2.new(0,0,.5,0)
}

local UICorners = {
	ButtonCorner = UDim.new(.2,0),
	FrameCorner = UDim.new(.05,0)
}

local UISizes = {
	FullSize = UDim2.new(1,0,1,0),
	NintyPercent = UDim2.new(.9,0,.9,0),
	FrameWidget = UDim2.new(1,0,.8,0),
	FrameWidgetTop = UDim2.new(1,0,.15,0),
	FrameWidgetMiddle = UDim2.new(1,0,.70,0),
	FrameWidgetBottom = UDim2.new(1,0,.15,0),
	FrameWidgetTitle = UDim2.new(.3,0,1,0),
	FrameWidgetSmallButton = UDim2.new(.1,0,1,0),
	MainButtons = UDim2.new(0.95, 0, 0.2, 0),
	OutputFrame = UDim2.new(1,0,.2,0),
	OutputTextBox = UDim2.new(1,0,.1,0),
	OutputScrollingFrame = UDim2.new(1,0,.8,0)
}

local UITextSizeConstraints = {
	MaxMainButtons = 20
}

local UIPadding = {
	Default = UDim.new(.05,0),
	Quarter = UDim.new(.25,0),
	MainPadding = UDim.new(.03,0),
}

local toolbar = plugin:CreateToolbar("DRAW API")
local openButton = toolbar:CreateButton("DRAW API", "Open DRAW API", Assets.DrawAPILogo)
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	true,  -- initialEnabled
	true,  -- initialEnabled should be overridden
	300,   -- default width
	200,   -- default height
	300,   -- min width
	200    -- min height
)

local widget = plugin:CreateDockWidgetPluginGui("DRAWAPI_Window", widgetInfo)
widget.Title = "DRAW API"

local function CreateUIElements()
	local masterFrame = Instance.new("Frame")
	masterFrame.Name = "masterFrame"
	masterFrame.Parent = widget
	masterFrame.Size = UISizes.FullSize
	masterFrame.BackgroundColor3 = UIColors.Main
	masterFrame.BorderSizePixel = 0
	local masterFramePadding = Instance.new("UIPadding")
	masterFramePadding.Parent = masterFrame
	masterFramePadding.PaddingBottom = UIPadding.MainPadding
	masterFramePadding.PaddingTop = UIPadding.MainPadding
	masterFramePadding.PaddingLeft = UIPadding.MainPadding
	masterFramePadding.PaddingRight = UIPadding.MainPadding
	local masterFrameList = Instance.new("UIListLayout")
	masterFrameList.Parent = masterFrame
	masterFrameList.Padding = UDim.new(-.18,0)
	masterFrameList.SortOrder = Enum.SortOrder.LayoutOrder

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "mainFrame"
	mainFrame.Size = UISizes.FullSize
	mainFrame.Parent = masterFrame
	mainFrame.BackgroundColor3 = UIColors.Main
	mainFrame.BorderSizePixel = 0
	local mainFramePageLayout = Instance.new("UIPageLayout")
	mainFramePageLayout.Name = "mainFramePageLayout"
	mainFramePageLayout.Parent = mainFrame
	mainFramePageLayout.TweenTime = .6
	mainFramePageLayout.EasingStyle = Enum.EasingStyle.Quad
	mainFramePageLayout.EasingDirection = Enum.EasingDirection.Out
	mainFramePageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	mainFramePageLayout.Padding = UIPadding.Quarter
	mainFramePageLayout.FillDirection = Enum.FillDirection.Vertical

	local outputFrame = Instance.new("Frame")
	outputFrame.Name = "outputFrame"
	outputFrame.Parent = masterFrame
	outputFrame.Position = UIPositions.OutputFrame
	outputFrame.Size = UISizes.OutputFrame
	outputFrame.BackgroundColor3 = UIColors.Secondary
	local outputFramePadding = Instance.new("UIPadding")
	outputFramePadding.Parent = outputFrame
	outputFramePadding.PaddingBottom = UIPadding.Default
	outputFramePadding.PaddingTop = UIPadding.Default
	outputFramePadding.PaddingLeft = UIPadding.Default
	outputFramePadding.PaddingRight = UIPadding.Default
	local outputFrameList = Instance.new("UIListLayout")
	outputFrameList.Parent = outputFrame
	outputFrameList.Padding = UIPadding.Default
	outputFrameList.SortOrder = Enum.SortOrder.LayoutOrder

	local outputTextBox = Instance.new("TextLabel")
	outputTextBox.Name = "outputTextBox"
	outputTextBox.Parent = outputFrame
	outputTextBox.Size = UISizes.OutputTextBox
	outputTextBox.LayoutOrder = 0
	outputTextBox.BackgroundColor3 = UIColors.Secondary
	outputTextBox.BorderSizePixel = 0
	outputTextBox.TextColor3 = UIColors.ButtonText
	outputTextBox.Text = "Output:"
	outputTextBox.TextScaled = true
	outputTextBox.TextWrapped = true
	outputTextBox.FontFace = UIFonts.BoldZekton
	outputTextBox.TextXAlignment = Enum.TextXAlignment.Left

	local outputScrollingFrame = Instance.new("ScrollingFrame")
	outputScrollingFrame.Name = "outputScrollingFrame"
	outputScrollingFrame.Parent = outputFrame
	outputScrollingFrame.Size = UISizes.OutputScrollingFrame
	outputScrollingFrame.LayoutOrder = 1
	outputScrollingFrame.BackgroundColor3 = UIColors.Secondary
	outputScrollingFrame.BorderSizePixel = 0
	outputScrollingFrame.ScrollBarImageColor3 = UIColors.ButtonText
	outputScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	outputScrollingFrame.ScrollBarThickness = 10
	outputScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	outputScrollingFrame.Active = true
	local outputScrollingFrameList = Instance.new("UIListLayout")
	outputScrollingFrameList.Parent = outputScrollingFrame
	outputScrollingFrameList.Padding = UIPadding.Default

	local buttonFrame = Instance.new("Frame")
	buttonFrame.Name = "buttonFrame"
	buttonFrame.Parent = mainFrame
	buttonFrame.Size = UISizes.FrameWidget
	buttonFrame.LayoutOrder = 1
	buttonFrame.Position = UDim2.new(.05, 0, 0.05, 0)
	buttonFrame.BackgroundColor3 = UIColors.Secondary
	local buttonFrameUICorner = Instance.new("UICorner")
	buttonFrameUICorner.CornerRadius = UICorners.FrameCorner
	buttonFrameUICorner.Parent = buttonFrame
	local buttonFramePadding = Instance.new("UIPadding")
	buttonFramePadding.Parent = buttonFrame
	buttonFramePadding.PaddingBottom = UIPadding.Default
	buttonFramePadding.PaddingTop = UIPadding.Default
	buttonFramePadding.PaddingLeft = UIPadding.Default
	buttonFramePadding.PaddingRight = UIPadding.Default

	local indexFrame = Instance.new("Frame")
	indexFrame.Name = "indexFrame"
	indexFrame.Size = UISizes.FrameWidget
	indexFrame.Parent = mainFrame
	indexFrame.LayoutOrder = 2
	indexFrame.BackgroundColor3 = UIColors.Secondary
	indexFrame.BorderSizePixel = 0
	local indexPadding = Instance.new("UIPadding")
	indexPadding.Parent = indexFrame
	indexPadding.PaddingBottom = UIPadding.MainPadding
	indexPadding.PaddingTop = UIPadding.MainPadding
	indexPadding.PaddingLeft = UIPadding.MainPadding
	indexPadding.PaddingRight = UIPadding.MainPadding
	
	local indexFrameListLayout = Instance.new("UIListLayout")
	indexFrameListLayout.Name = "indexFrameListLayout"
	indexFrameListLayout.Parent = indexFrame
	indexFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	local indexFrameTopFrame = Instance.new("Frame")
	indexFrameTopFrame.Name = "indexFrameTopFrame"
	indexFrameTopFrame.Parent = indexFrame
	indexFrameTopFrame.Size = UISizes.FrameWidgetTop
	indexFrameTopFrame.BackgroundTransparency = 1
	indexFrameTopFrame.LayoutOrder = 0
	local indexFrameTopFrameUICorner = Instance.new("UICorner")
	indexFrameTopFrameUICorner.CornerRadius = UICorners.ButtonCorner
	indexFrameTopFrameUICorner.Parent = indexFrameTopFrame
	local indexFrameTopFrameListLayout = Instance.new("UIListLayout")
	indexFrameTopFrameListLayout.Parent = indexFrameTopFrame
	indexFrameTopFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	indexFrameTopFrameListLayout.FillDirection = Enum.FillDirection.Horizontal
	indexFrameTopFrameListLayout.Padding = UIPadding.Default
	
	local indexFrameMenuButton = Instance.new("TextButton")
	indexFrameMenuButton.Name = "indexFrameMenuButton"
	indexFrameMenuButton.Parent = indexFrameTopFrame
	indexFrameMenuButton.Size = UISizes.FrameWidgetSmallButton
	indexFrameMenuButton.BackgroundColor3 = UIColors.ButtonMain
	indexFrameMenuButton.TextColor3 = UIColors.ButtonText
	indexFrameMenuButton.Text = "M"
	indexFrameMenuButton.FontFace = UIFonts.BoldZekton
	indexFrameMenuButton.TextScaled = true
	local indexFrameMenuButtonUICorner = Instance.new("UICorner")
	indexFrameMenuButtonUICorner.CornerRadius = UICorners.ButtonCorner
	indexFrameMenuButtonUICorner.Parent = indexFrameMenuButton
	local indexFrameMenuButtonUITextContraint = Instance.new("UITextSizeConstraint")
	indexFrameMenuButtonUITextContraint.Parent = indexFrameMenuButton
	indexFrameMenuButtonUITextContraint.MaxTextSize = UITextSizeConstraints.MaxMainButtons
	
	local indexFrameTitle = Instance.new("TextLabel")
	indexFrameTitle.Parent = indexFrameTopFrame
	indexFrameTitle.Size = UISizes.FrameWidgetTitle
	indexFrameTitle.BackgroundColor3 = UIColors.Secondary
	indexFrameTitle.BorderSizePixel = 0
	indexFrameTitle.LayoutOrder = 1
	indexFrameTitle.Text = "Index Datastore"
	indexFrameTitle.TextColor3 = UIColors.ButtonText
	indexFrameTitle.FontFace = UIFonts.BoldZekton
	indexFrameTitle.TextScaled = true
	indexFrameTitle.TextWrapped = true
	
	local indexFrameMiddleFrame = Instance.new("Frame")
	indexFrameMiddleFrame.Name = "indexFrameMiddleFrame"
	indexFrameMiddleFrame.Parent = indexFrame
	indexFrameMiddleFrame.Size = UISizes.FrameWidgetMiddle
	indexFrameMiddleFrame.BackgroundTransparency = 0
	indexFrameMiddleFrame.LayoutOrder = 1
	local indexFrameMiddleFrameUICorner = Instance.new("UICorner")
	indexFrameMiddleFrameUICorner.CornerRadius = UICorners.ButtonCorner
	indexFrameMiddleFrameUICorner.Parent = indexFrameMiddleFrame
	
	local indexFrameBottomFrame = Instance.new("Frame")
	indexFrameBottomFrame.Name = "indexFrameBottomFrame"
	indexFrameBottomFrame.Parent = indexFrame
	indexFrameBottomFrame.Size = UISizes.FrameWidgetBottom
	indexFrameBottomFrame.BackgroundTransparency = 0
	indexFrameBottomFrame.LayoutOrder = 2
	local indexFrameBottomFrameUICorner = Instance.new("UICorner")
	indexFrameBottomFrameUICorner.CornerRadius = UICorners.ButtonCorner
	indexFrameBottomFrameUICorner.Parent = indexFrameBottomFrame

	local readFrame = Instance.new("Frame")
	readFrame.Name = "readFrame"
	readFrame.Size = UISizes.FullSize
	readFrame.Parent = mainFrame
	readFrame.LayoutOrder = 3
	readFrame.BackgroundColor3 = UIColors.Main
	local readPadding = Instance.new("UIPadding")
	readPadding.Parent = readFrame
	readPadding.PaddingBottom = UIPadding.MainPadding
	readPadding.PaddingTop = UIPadding.MainPadding
	readPadding.PaddingLeft = UIPadding.MainPadding
	readPadding.PaddingRight = UIPadding.MainPadding

	local writeFrame = Instance.new("Frame")
	writeFrame.Name = "writeFrame"
	writeFrame.Size = UISizes.FullSize
	writeFrame.Parent = mainFrame
	writeFrame.LayoutOrder = 4
	writeFrame.BackgroundColor3 = UIColors.Main
	local writePadding = Instance.new("UIPadding")
	writePadding.Parent = writeFrame
	writePadding.PaddingBottom = UIPadding.MainPadding
	writePadding.PaddingTop = UIPadding.MainPadding
	writePadding.PaddingLeft = UIPadding.MainPadding
	writePadding.PaddingRight = UIPadding.MainPadding

	local createFrame = Instance.new("Frame")
	createFrame.Name = "createFrame"
	createFrame.Size = UISizes.FullSize
	createFrame.Parent = mainFrame
	createFrame.LayoutOrder = 5
	createFrame.BackgroundColor3 = UIColors.Main
	local createPadding = Instance.new("UIPadding")
	createPadding.Parent = createFrame
	createPadding.PaddingBottom = UIPadding.MainPadding
	createPadding.PaddingTop = UIPadding.MainPadding
	createPadding.PaddingLeft = UIPadding.MainPadding
	createPadding.PaddingRight = UIPadding.MainPadding

	local layout = Instance.new("UIListLayout")
	layout.Name = "layout"
	layout.Parent = buttonFrame
	layout.Padding = UDim.new(.05,0)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	local indexDatastoreButton = Instance.new("TextButton")
	indexDatastoreButton.Name = "indexDatastoreButton"
	indexDatastoreButton.Parent = buttonFrame
	indexDatastoreButton.Size = UISizes.MainButtons
	indexDatastoreButton.BackgroundColor3 = UIColors.ButtonMain
	indexDatastoreButton.TextColor3 = UIColors.ButtonText
	indexDatastoreButton.Text = "INDEX DATASTORE"
	indexDatastoreButton.FontFace = UIFonts.BoldZekton
	indexDatastoreButton.TextScaled = true
	local indexDatastoreButtonUICorner = Instance.new("UICorner")
	indexDatastoreButtonUICorner.CornerRadius = UICorners.ButtonCorner
	indexDatastoreButtonUICorner.Parent = indexDatastoreButton
	local indexDatastoreButtonUITextContraint = Instance.new("UITextSizeConstraint")
	indexDatastoreButtonUITextContraint.Parent = indexDatastoreButton
	indexDatastoreButtonUITextContraint.MaxTextSize = UITextSizeConstraints.MaxMainButtons

	local readButton = Instance.new("TextButton")
	readButton.Name = "readButton"
	readButton.Parent = buttonFrame
	readButton.Size = UISizes.MainButtons
	readButton.BackgroundColor3 = UIColors.ButtonMain
	readButton.TextColor3 = UIColors.ButtonText
	readButton.Text = "READ DATASTORE"
	readButton.FontFace = UIFonts.BoldZekton
	readButton.TextScaled = true
	local readButtonUICorner = Instance.new("UICorner")
	readButtonUICorner.CornerRadius = UICorners.ButtonCorner
	readButtonUICorner.Parent = readButton
	local indexDatastoreButtonUITextContraint = Instance.new("UITextSizeConstraint")
	indexDatastoreButtonUITextContraint.Parent = readButton
	indexDatastoreButtonUITextContraint.MaxTextSize = UITextSizeConstraints.MaxMainButtons

	local writeButton = Instance.new("TextButton")
	writeButton.Name = "writeButton"
	writeButton.Parent = buttonFrame
	writeButton.Size = UISizes.MainButtons
	writeButton.BackgroundColor3 = UIColors.ButtonMain
	writeButton.TextColor3 = UIColors.ButtonText
	writeButton.Text = "WRITE DATASTORE"
	writeButton.FontFace = UIFonts.BoldZekton
	writeButton.TextScaled = true
	local writeButtonUICorner = Instance.new("UICorner")
	writeButtonUICorner.CornerRadius = UICorners.ButtonCorner
	writeButtonUICorner.Parent = writeButton
	local indexDatastoreButtonUITextContraint = Instance.new("UITextSizeConstraint")
	indexDatastoreButtonUITextContraint.Parent = writeButton
	indexDatastoreButtonUITextContraint.MaxTextSize = UITextSizeConstraints.MaxMainButtons

	local createButton = Instance.new("TextButton")
	createButton.Name = "createButton"
	createButton.Parent = buttonFrame
	createButton.Size = UISizes.MainButtons
	createButton.BackgroundColor3 = UIColors.ButtonMain
	createButton.TextColor3 = UIColors.ButtonText
	createButton.Text = "CREATE DATASTORE"
	createButton.FontFace = UIFonts.BoldZekton
	createButton.TextScaled = true
	local createButtonUICorner = Instance.new("UICorner")
	createButtonUICorner.CornerRadius = UICorners.ButtonCorner
	createButtonUICorner.Parent = createButton
	local indexDatastoreButtonUITextContraint = Instance.new("UITextSizeConstraint")
	indexDatastoreButtonUITextContraint.Parent = createButton
	indexDatastoreButtonUITextContraint.MaxTextSize = UITextSizeConstraints.MaxMainButtons




end

CreateUIElements()

local frames = {
	mainFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"),
	buttonFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"):FindFirstChild("buttonFrame"),
	indexFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"):FindFirstChild("indexFrame"),
	readFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"):FindFirstChild("readFrame"),
	writeFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"):FindFirstChild("writeFrame"),
	createFrame = widget:FindFirstChild("masterFrame"):FindFirstChild("mainFrame"):FindFirstChild("createFrame")
}

local buttons = {
	indexButton = frames.buttonFrame:FindFirstChild("indexDatastoreButton"),
	indexFrameMenuButton = frames.indexFrame:FindFirstChild("indexFrameTopFrame"):FindFirstChild("indexFrameMenuButton"),
	readButton = frames.buttonFrame:FindFirstChild("readButton"),
	writeButton = frames.buttonFrame:FindFirstChild("writeButton"),
	createButton = frames.buttonFrame:FindFirstChild("createButton")
}

local elements = {
	mainPageLayout = frames.mainFrame:FindFirstChildWhichIsA("UIPageLayout")
}













--[[--
	GUI BRAIN
--]]--

openButton.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

buttons.indexButton.Activated:Connect(function()
	elements.mainPageLayout:JumpTo(frames.indexFrame)
end)

buttons.readButton.Activated:Connect(function()
	elements.mainPageLayout:JumpTo(frames.readFrame)
end)

buttons.writeButton.Activated:Connect(function()
	elements.mainPageLayout:JumpTo(frames.writeFrame)
end)

buttons.createButton.Activated:Connect(function()
	elements.mainPageLayout:JumpTo(frames.createFrame)
end)

buttons.indexFrameMenuButton.Activated:Connect(function()
	elements.mainPageLayout:JumpTo(frames.buttonFrame)
end)















local function addDataStoreToIndex(dataStoreName)
	local success, error = pcall(function()
		local list = indexDataStore:GetAsync("DataStoreList") or {}
		table.insert(list, dataStoreName)
		indexDataStore:SetAsync("DataStoreList", list)
	end)

	if not success then
		warn("Failed to update index:", error)
	end
end

-- Function to get all DataStore names in the index
local function getAllDataStoreNames()
	local success, dataStoreList = pcall(function()
		return indexDataStore:GetAsync("DataStoreList")
	end)

	if success then
		return dataStoreList or {}
	else
		warn("Failed to retrieve DataStore names from index.")
		return {}
	end
end





















local function getUserId(username)
	local success, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(username)
	end)

	if success then
		return userId
	else
		warn("Failed to fetch UserID for username:", username)
		return nil
	end
end














-- TESTING DATASTORE
local dataStore = DSS:GetDataStore("SampleDataStore")


-- Function to get or create a DataStore based on input
local function GetDataStore(dataStoreName)
	if not dataStoreName or dataStoreName == "" then
		warn("DataStore name not provided.")
		return nil
	end
	return DSS:GetDataStore(dataStoreName)
end

-- Function to read from the DataStore
local function ReadFromDS(dataStoreName, userID)
	local data
	local dataStore = GetDataStore(dataStoreName)
	if not dataStore then return nil end

	local success, error = pcall(function()
		data = dataStore:GetAsync(userID)
	end)

	if success then
		return data
	else
		warn("Failed to read data:", error)
		return nil
	end
end

--readButton.MouseButton1Click:Connect(function()
--	local UserID = playerInput.Text
--	local dataStoreName = datastoreInput.Text

--	if UserID ~= "" and dataStoreName ~= "" then
--		local data = ReadFromDS("PLACEHOLDER",UserID)
--		print("Data for ", UserID, ": ", data or "No data found")
--	else
--		warn("Please fill in all fields.")
--	end
--end)

-- Function to write to the DataStore
local function WriteToDS(dataStoreName, userID, value)
	local dataStore = GetDataStore(dataStoreName)
	if not dataStore then return false end

	local success, error = pcall(function()
		dataStore:SetAsync(userID, value)
	end)

	if success then
		print("Data saved successfully for user:", userID)
		return true
	else
		warn("Failed to write data:", error)
		return false
	end
end

--writeButton.MouseButton1Click:Connect(function()
--	local UserID = playerInput.Text
--	local dataStoreName = datastoreInput.Text
--	local value = valueInput.Text

--	if UserID ~= "" and dataStoreName ~= "" and value ~= "" then
--		WriteToDS(UserID, value)
--		print("Data written for", UserID)
--	else
--		warn("Please fill in all fields.")
--	end
--end)

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		local args = message:split(" ")

		if args[1] == ";drawapi" then
			local command = args[2] or ""
			local userID = args[3] or ""
			local dataStoreName = args[4] or ""
			local stat = args[5] or ""
			local valueCommand = args[6] or ""
			local value = tonumber(args[7])

			if command == "write" and userID and dataStoreName and stat and valueCommand and value then
				local currentValue = ReadFromDS(dataStoreName, userID) or 0

				if valueCommand == "Add" then
					WriteToDS(dataStoreName, userID, currentValue + value)
				elseif valueCommand == "Subtract" then
					WriteToDS(dataStoreName, userID, currentValue - value)
				elseif valueCommand == "Set" then
					WriteToDS(dataStoreName, userID, value)
				else
					player:SendNotification("Invalid command.")
				end

				player:SendNotification("Data written successfully!")
			elseif command == "read" and userID and dataStoreName then
				local data = ReadFromDS(dataStoreName, userID)
				player:SendNotification("Data: " .. tostring(data))
			else
				player:SendNotification("Invalid syntax or missing arguments.")
			end
		end
	end)
end)


