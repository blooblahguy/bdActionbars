local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

bdCore:makeMovable(ab.bar4)

MultiBarRight:SetParent(ab.bar4)
MultiBarRight:SetScript("OnHide", function() ab.bar4:Hide() end)
MultiBarRight:SetScript("OnShow", function() ab.bar4:Show() end)

function ab.bar4:Update()
	config = bdCore.config.profile['Actionbars']
	local rows = math.floor(NUM_ACTIONBAR_BUTTONS/config.bar4rows)
	local index = 1
	local lastrow = MultiBarRightButton1
	local lastbutton = nil
	ab:Size(ab.bar4,'bar4rows',NUM_ACTIONBAR_BUTTONS)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		Button:SetAttribute("flyoutDirection","UP")
		ab:skinButton(Button,"bar4",ab.bar4)

		if (not lastbutton) then
			Button:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
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
		
		ab.bar4["Button"..i] = Button
	end
end
--bdCore:hookEvent("bd_reconfig",function() ab.bar4:Update() end)

for i = 7, 12 do
	local Button = _G["MultiBarRightButton"..i]
	local Button1 = _G["MultiBarRightButton1"]
	
	Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
end

ab.bar4:Update()

RegisterStateDriver(ab.bar4, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
