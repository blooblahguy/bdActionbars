local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

bdCore:makeMovable(ab.bar1)

local Page = {
	["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
	["PRIEST"] = "[bonusbar:1] 7;",
	["ROGUE"] = "[bonusbar:1] 7; [form:3] 7;",
	["WARLOCK"] = "[stance:1] 10; ",
	["MONK"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
	["DEFAULT"] = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [shapeshift] 13; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
}

local function getBar()
	local Condition = Page["DEFAULT"]
	local Class = select(2, UnitClass("player"))
	local Page = Page[Class]
	
	if (Page and config.stanceswitch) then
		Condition = Condition .. " " .. Page
	end
	
	Condition = Condition .. " [form] 1; 1"

	return Condition
end

local function updateDriver()
	local Button

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		Button = _G["ActionButton"..i]
		ab.bar1:SetFrameRef("ActionButton"..i, Button)
	end	

	ab.bar1:Execute([[
		Button = table.new()
		for i = 1, 12 do
			table.insert(Button, self:GetFrameRef("ActionButton"..i))
		end
	]])

	ab.bar1:SetAttribute("_onstate-page", [[ 
		if HasTempShapeshiftActionBar() then
			newstate = GetTempShapeshiftBarIndex() or newstate
		end

		for i, Button in ipairs(Button) do
			Button:SetAttribute("actionpage", tonumber(newstate))
		end
	]])

	RegisterStateDriver(ab.bar1, "page", getBar())
end

updateDriver()

function ab.bar1:Update()
	self:SetFrameStrata("MEDIUM")

	config = bdCore.config.profile['Actionbars']
	local rows = math.floor(NUM_ACTIONBAR_BUTTONS/config.bar1rows)
	local index = 1
	local lastrow = ActionButton1
	local lastbutton = nil
	ab:Size(ab.bar1,'bar1rows',NUM_ACTIONBAR_BUTTONS)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["ActionButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetParent(self)
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		ab:skinButton(Button,"bar1",ab.bar1)

		if (not lastbutton) then
			Button:SetPoint("TOPLEFT", ab.bar1, "TOPLEFT", 0, 0)
		else
			Button:SetPoint("LEFT", lastbutton, "RIGHT", config.buttonspacing+border, 0)
			if (i > rows and index >= rows) then
				Button:SetPoint("TOPLEFT", lastrow, "BOTTOMLEFT", 0, -config.buttonspacing-border)
				index = 0
				lastrow = Button
			end
		end
		index = index + 1
		lastbutton = Button
	end
end

ab.bar1:RegisterEvent("PLAYER_ENTERING_WORLD")
-- ab.bar1:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
ab.bar1:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
ab.bar1:RegisterEvent("BAG_UPDATE")
ab.bar1:SetScript("OnEvent", function(self, event, unit, ...)
	if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		print(event)
		updateDriver()
	elseif (event == "PLAYER_ENTERING_WORLD") then
		
	else
		-- MainMenuBar_OnEvent(self, event, ...)
	end
end)

for i = 1, NUM_ACTIONBAR_BUTTONS do
	local Button = _G["ActionButton"..i]
	ab.bar1["Button"..i] = Button
end


MainMenuBar:SetScale(0.001)
MainMenuBar:SetFrameStrata("BACKGROUND")
MainMenuBar.SetFrameStrata = bdCore.noop
MainMenuBar:SetAlpha(0)
MainMenuBar:EnableMouse(0)
MainMenuBarArtFrame:Hide()

ab.bar1:Update()