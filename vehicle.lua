addon, ab = ...

local vehicle = CreateFrame("Button", "Vehicle Button", UIParent)

function vehicle:VehicleOnEvent(event)
    if CanExitVehicle() then
        self:Show()
    else
        self:Hide()
    end
end

function vehicle:VehicleOnClick()
    if (UnitOnTaxi("player")) then
        TaxiRequestEarlyLanding()
		print("Requested early landing from flightpath.")
    else
        VehicleExit()
		print("Exiting vehicle.")
    end
	
	self:Hide()
end


vehicle:SetPoint("BOTTOM", ab.bar1, "TOP", 0, 10)
vehicle:SetSize(30, 30)
vehicle:SetFrameStrata("TOOLTIP")
bdCore:setBackdrop(vehicle)
vehicle:SetFrameStrata("MEDIUM")
vehicle:SetFrameLevel(10)
vehicle:EnableMouse(true)
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", vehicle.VehicleOnClick)
vehicle:RegisterEvent("PLAYER_ENTERING_WORLD")
vehicle:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
vehicle:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
vehicle:RegisterEvent("UNIT_ENTERED_VEHICLE")
vehicle:RegisterEvent("UNIT_EXITED_VEHICLE")
vehicle:RegisterEvent("VEHICLE_UPDATE")
vehicle:Hide()
vehicle:SetScript("OnEvent", vehicle.VehicleOnEvent)
vehicle:SetScript("OnEnter", function() 
	ShowUIPanel(GameTooltip)
	GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
	
	if (UnitOnTaxi("player")) then
		GameTooltip:AddLine("Request Stop")
	else
		GameTooltip:AddLine("Leave Vehicle")
	end
	
	GameTooltip:Show()
end)
vehicle:SetScript("OnLeave", function() 
	GameTooltip:Hide()
end)

vehicle.text = vehicle:CreateFontString(nil, "OVERLAY")
vehicle.text:SetFont(bdCore.media.font, 12)
vehicle.text:SetText("x")
vehicle.text:SetPoint("TOPLEFT", vehicle, "TOPLEFT", 1, 0)
vehicle.text:SetPoint("BOTTOMRIGHT", vehicle, "BOTTOMRIGHT", 0, 0)
vehicle.text:SetJustifyH("CENTER")


