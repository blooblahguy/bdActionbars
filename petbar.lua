local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

bdCore:makeMovable(ab.petbar)

PetActionBarFrame:SetParent(ab.petbar)
PetActionBarFrame:SetScript("OnHide", function() ab.petbar:Hide() end)
PetActionBarFrame:SetScript("OnShow", function() ab.petbar:Show() end)
PetActionBarFrame:ClearAllPoints()
PetActionBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 34)
PetActionBarFrame:EnableMouse(false)

function ab.petbar:Update()
	config = bdCore.config.profile['Actionbars']
	local rows = math.floor(NUM_PET_ACTION_SLOTS/config.stancebarrows)
	local index = 1
	local lastrow = PetActionButton1
	local lastbutton = nil
	ab:Size(ab.petbar,'petbarrows',NUM_PET_ACTION_SLOTS)
	
	for i = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G["PetActionButton"..i]
		local border = bdCore.config.persistent['General'].border
		Button:SetSize(config.buttonsize,config.buttonsize)
		Button:ClearAllPoints()
		Button:SetParent(ab.petbar)
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		ab:skinButton(Button,"petbar",ab.petbar)
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
		
		ab.petbar:SetAttribute("addchild", Button)
		ab.petbar["Button"..i] = Button
	end
end
--bdCore:hookEvent("bd_reconfig",function() ab.perbar:Update() end)

ab.petbar:Update()

RegisterStateDriver(ab.petbar, "visibility", "[pet,nopetbattle,novehicleui,nooverridebar,nobonusbar:5] show; hide")
