local a, c, v = select(2, ...):unpack()
local cfg = {}
local defaultPadding = 20

--===============================================================
-- Actionbar 1
--===============================================================
	a:HideMainMenuBar()
	cfg = {}
	cfg.blizzardBar = nil
	cfg.cfg = "bar1"
	cfg.frameName = ""
	cfg.frameVisibility = "[petbattle] hide; [combat][mod][@target,exists,nodead][@vehicle,exists][overridebar][shapeshift][vehicleui][possessbar] show; hide"
	cfg.frameSpawn = {"BOTTOM", UIParent, "BOTTOM", 0, defaultPadding}
	cfg.actionPage = "[bar:6]6;[bar:5]5;[bar:4]4;[bar:3]3;[bar:2]2;[overridebar]14;[shapeshift]13;[vehicleui]12;[possessbar]12;[bonusbar:5]11;[bonusbar:4]10;[bonusbar:3]9;[bonusbar:2]8;[bonusbar:1]7;1"

	local buttonName = "ActionButton"
	local numButtons = NUM_ACTIONBAR_BUTTONS
	local buttonList = a:GetButtonList(buttonName, numButtons)
	local bar1 = a:CreateBar(buttonList, config)
		
	--_onstate-page state driver
	for i, button in next, buttonList do
		bar1:SetFrameRef(buttonName..i, button)
	end

	bar1:Execute(([[
		buttons = table.new()
		for i=1, %d do
			table.insert(buttons, self:GetFrameRef("%s"..i))
		end
	]]):format(numButtons, buttonName))
	bar1:SetAttribute("_onstate-page", [[
		--print("_onstate-page","index",newstate)
		for i, button in next, buttons do
			button:SetAttribute("actionpage", newstate)
		end
	]])
	RegisterStateDriver(bar1, "page", cfg.actionPage)

--===============================================================
-- Actionbar 2
--===============================================================
	cfg = {}
	cfg.blizzardBar = MultiBarBottomLeft
	cfg.cfg = "bar2"
	cfg.frameName = "bdActionbars_2"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; [combat][mod][@target,exists,nodead] show; hide"
	cfg.frameSpawn = {"RIGHT", bar1, "LEFT", -defaultPadding, 0}

	local buttonList = a:GetButtonList("MultiBarBottomLeftButton", NUM_ACTIONBAR_BUTTONS)
	local bar2 = a:CreateBar(buttonList, cfg)

--===============================================================
-- Actionbar 3
--===============================================================
	cfg = {}
	cfg.blizzardBar = MultiBarBottomRight
	cfg.frameName = "bdActionbars_3"
	cfg.cfg = "bar3"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; show"
	cfg.frameSpawn = {"LEFT", bar1, "RIGHT", defaultPadding, 0}

	local buttonList = a:GetButtonList("MultiBarBottomRightButton", NUM_ACTIONBAR_BUTTONS)
	local bar3 = a:CreateBar(buttonList, cfg)

--===============================================================
-- Actionbar 4
--===============================================================
	cfg = {}
	cfg.blizzardBar = MultiBarRight
	cfg.frameName = "bdActionbars_4"
	cfg.cfg = "bar4"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; show"
	cfg.frameSpawn = {"RIGHT", UIParent, "RIGHT", -defaultPadding, 0}

	local buttonList = a:GetButtonList("MultiBarRightButton", NUM_ACTIONBAR_BUTTONS)
	local bar4 = a:CreateBar(buttonList, cfg)

--===============================================================
-- Actionbar 5
--===============================================================
	cfg = {}
	cfg.blizzardBar = MultiBarLeft
	cfg.frameName = "bdActionbars_5"
	cfg.cfg = "bar5"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; show"
	cfg.frameSpawn = {"RIGHT", bar4, "LEFT", -defaultPadding, 0}

	local buttonList = a:GetButtonList("MultiBarLeftButton", NUM_ACTIONBAR_BUTTONS)
	local bar5 = a:CreateBar(buttonList, cfg)

--===============================================================
-- Pet Bar
--===============================================================
	cfg = {}
	cfg.cfg = "petbar"
	cfg.blizzardBar = PetActionBarFrame
	cfg.frameName = "bdActionbars_PetBar"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; [pet,mod] show; hide"
	cfg.frameSpawn = {"BOTTOMRIGHT", bar, "TOPRIGHT", 0, defaultPadding}

	local buttonList = a:GetButtonList("PetActionButton", NUM_PET_ACTION_SLOTS)
	local petbar = a:CreateBar(buttonList, cfg)

--===============================================================
-- StanceBar
--===============================================================
	cfg = {}
	cfg.cfg = "stancebar"
	cfg.blizzardBar = StanceBarFrame
	cfg.frameName = "bdActionbars_StanceBar"
	cfg.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift][nomod] hide; show"
	cfg.frameSpawn = {"BOTTOMLEFT", bar, "TOPLEFT", 0, defaultPadding}

	local buttonList = a:GetButtonList("StanceButton", NUM_STANCE_SLOTS)
	local stancebar = a:CreateBar(buttonList, cfg)

--===============================================================
-- MicroMenu
--===============================================================
	cfg = {}
	cfg.cfg = "micromenu"
	cfg.frameName = "bdActionbars_MicroMenuBar"
	cfg.frameVisibility = "[petbattle] hide; show"
	cfg.frameSpawn = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -defaultPadding, defaultPadding}
	cfg.widthScale = 0.777
	cfg.buttonSkin = function(button)
		local regions = {button:GetRegions()}
		for k, v in pairs(regions) do
			v:SetTexCoord(.17, .80, .22, .82)
			v:SetPoint("TOPLEFT", button, "TOPLEFT", 4, -6)
			v:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -4, 6)
		end
	end
	local buttonList = {}
	for idx, buttonName in next, MICRO_BUTTONS do
		local button = _G[buttonName]
		if button and button:IsShown() then
			table.insert(buttonList, button)
		end
	end
	local micromenu = a:CreateBar(buttonList, cfg)
	
--===============================================================
-- BagBar
--===============================================================
	cfg = {}
	cfg.cfg = "bagbar"
	cfg.frameName = "bdActionbars_BagBar"
	cfg.frameVisibility = "[petbattle] hide; show"
	cfg.frameSpawn = { "BOTTOMRIGHT", micromenu, "TOPRIGHT", 0, defaultPadding }
	local buttonList = { MainMenuBarBackpackButton, CharacterBag0Slot, CharacterBag1Slot, CharacterBag2Slot, CharacterBag3Slot }
	local bagbar = a:CreateBar(buttonList, cfg)

--===============================================================
-- Vehicle Exit
--===============================================================
	cfg = {}
	cfg.cfg = "vehiclebar"
	cfg.frameName = "bdActionbars_VehicleExitBar"
	cfg.frameVisibility = "[canexitvehicle]c;[mounted]m;n"
	cfg.frameVisibilityFunc = "exit"
	cfg.frameSpawn = { "BOTTOMRIGHT", bar1, "TOPLEFT", -defaultPadding, defaultPadding }
	--create vehicle exit button
	local button = CreateFrame("CHECKBUTTON", "bdActionbars_VehicleExitButton", nil, "ActionButtonTemplate, SecureHandlerClickTemplate")
	button.icon:SetTexture("TEXTURES\\VEHICLES\\UI-Vehicles-Button-Exit-Up")
	button:SetScript("OnEnter", function() 
		ShowUIPanel(GameTooltip)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		
		if (UnitOnTaxi("player")) then
			GameTooltip:AddLine("Request Stop")
		else
			GameTooltip:AddLine("Leave Vehicle")
		end
		
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function() 
		GameTooltip:Hide()
	end)
	button:RegisterForClicks("AnyUp")
	local function OnClick(self)
		if UnitOnTaxi("player") then TaxiRequestEarlyLanding() else VehicleExit() end self:SetChecked(false)
	end
	button:SetScript("OnClick", OnClick)
	
	local buttonList = { button }
	local vehicle = a:CreateBar(buttonList, cfg)

	--[canexitvehicle] is not triggered on taxi, exit workaround
	frame:SetAttribute("_onstate-exit", [[ if CanExitVehicle() then self:Show() else self:Hide() end ]])
	if not CanExitVehicle() then frame:Hide() end

--===============================================================
-- Possess Exit
--===============================================================
	cfg = {}
	cfg.cfg = "possessbar"
	cfg.blizzardBar = PossessBarFrame
	cfg.frameName = "bdActionbars_PossessExitBar"
	cfg.frameVisibility = "[possessbar] show; hide"
	cfg.frameSpawn = { "BOTTOMLEFT", bar1, "TOPRIGHT", defaultPadding, defaultPadding }

	local buttonList = L:GetButtonList("PossessButton", NUM_POSSESS_SLOTS)
	local possess = a:CreateBar(buttonList, cfg)

--===============================================================
-- Extra Action Button
--===============================================================
	cfg = {}
	cfg.cfg = "extrabar"
	cfg.blizzardBar = ExtraActionBarFrame
	cfg.frameName = "bdActionbars_ExtraBar"
	cfg.frameVisibility = "[extrabar] show; hide"
	cfg.frameSpawn = { "LEFT", UIParent, "LEFT", defaultPadding }

	local buttonList = L:GetButtonList("ExtraActionButton", NUM_ACTIONBAR_BUTTONS)
	local extra = a:CreateBar(buttonList, cfg)