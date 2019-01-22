local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

bdCore:makeMovable(ab.bar2)

MultiBarBottomLeft:SetParent(ab.bar2)
MultiBarBottomLeft:SetScript("OnHide", function() ab.bar2:Hide() end)
MultiBarBottomLeft:SetScript("OnShow", function() ab.bar2:Show() end)

function ab.bar2:Update()
	config = bdCore.config.profile['Actionbars']
	local rows = math.floor(NUM_ACTIONBAR_BUTTONS/config.bar2rows)
	local index = 1
	local lastrow = MultiBarBottomLeftButton1
	local lastbutton = nil
	ab:Size(ab.bar2,'bar2rows',NUM_ACTIONBAR_BUTTONS)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		ab:skinButton(Button,"bar2",ab.bar2)

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
		
		ab.bar2["Button"..i] = Button
	end
end
--bdCore:hookEvent("bd_reconfig",function() ab.bar2:Update() end)

for i = 7, 12 do
	local Button = _G["MultiBarBottomLeftButton"..i]
	local Button1 = _G["MultiBarBottomLeftButton1"]
	
	Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
end

ab.bar2:Update()

RegisterStateDriver(ab.bar2, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
