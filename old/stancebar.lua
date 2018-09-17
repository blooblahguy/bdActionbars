local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

if (bdCore.isLegion) then return end

bdCore:makeMovable(ab.stancebar)

StanceBarFrame:SetParent(ab.stancebar)
StanceBarFrame:SetScript("OnHide", function() ab.stancebar:Hide() end)
StanceBarFrame:SetScript("OnShow", function() ab.stancebar:Show() end)
StanceBarFrame:SetPoint("TOPLEFT", ab.stancebar, "TOPLEFT", -7, 0)
StanceBarFrame:EnableMouse(false)
StanceBarLeft:Hide()
StanceBarLeft.Show = nil
StanceBarRight:Hide()
StanceBarRight.Show = nil

function ab.stancebar:Update()
	config = bdCore.config.profile['Actionbars']
	local num = GetNumShapeshiftForms()
	local rows = math.floor(num/config.stancebarrows)
	local index = 1
	local lastrow = StanceButton1
	local lastbutton = nil
	ab:Size(ab.stancebar,'stancebarrows',num)
	
	for i = 1, NUM_STANCE_SLOTS do
		local Button = _G["StanceButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		ab:skinButton(Button,"stancebar",ab.stancebar)
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
		
		ab.stancebar["Button"..i] = Button
	end
end
--dCore:hookEvent("bd_reconfig",function() ab.stancebar:Update() end)

ab.stancebar:RegisterEvent("PLAYER_ENTERING_WORLD")
ab.stancebar:RegisterEvent("PLAYER_TALENT_UPDATE")
ab.stancebar:RegisterEvent("SPELLS_CHANGED")
ab.stancebar:SetScript("OnEvent", function(self, event, ...)
	ab.stancebar:Update()
end)

ab.stancebar:Update()

RegisterStateDriver(ab.stancebar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
