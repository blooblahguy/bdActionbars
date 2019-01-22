local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

bdCore:makeMovable(ab.bar3)

MultiBarBottomRight:SetParent(ab.bar3)
MultiBarBottomRight:SetScript("OnHide", function() ab.bar3:Hide() end)
MultiBarBottomRight:SetScript("OnShow", function() ab.bar3:Show() end)


function ab.bar3:Update()
	config = bdCore.config.profile['Actionbars']
	local rows = math.floor(NUM_ACTIONBAR_BUTTONS/config.bar3rows)
	local index = 1
	local lastrow = MultiBarBottomRightButton1
	local lastbutton = nil
	ab:Size(ab.bar3,'bar3rows',NUM_ACTIONBAR_BUTTONS)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		ab:skinButton(Button,"bar3",ab.bar3)

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
		
		ab.bar3["Button"..i] = Button
	end
end
--bdCore:hookEvent("bd_reconfig",function() ab.bar3:Update() end)

for i = 7, 12 do
	local Button = _G["MultiBarBottomRightButton"..i]
	local Button1 = _G["MultiBarBottomRightButton1"]
	
	Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
end

ab.bar3:Update()

RegisterStateDriver(ab.bar3, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
