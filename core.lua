local addon, bdActionbars = ...

-- A huge amount of credit goes to Zork. His actionbar lib is one of the most solid out there, and I've borrowed heavily from it.

------------------------------------
-- Configuration Callback
------------------------------------
function bdActionbars:configCallback() 

end

------------------------------------
-- Hide Blizzard
------------------------------------
local function hideBlizzard()
	local hiddenFrame = CreateFrame("Frame")
	hiddenFrame:Hide()
	local scripts = {
		"OnShow", "OnHide", "OnEvent", "OnEnter", "OnLeave", "OnUpdate", "OnValueChanged", "OnClick", "OnMouseDown", "OnMouseUp",
	}

	local framesToHide = {
		MainMenuBar,
		OverrideActionBar,
	}

	local framesToDisable = {
		MainMenuBar,
		MicroButtonAndBagsBar, MainMenuBarArtFrame, StatusTrackingBarManager,
		ActionBarDownButton, ActionBarUpButton, MainMenuBarVehicleLeaveButton,
		OverrideActionBar,
		OverrideActionBarExpBar, OverrideActionBarHealthBar, OverrideActionBarPowerBar, OverrideActionBarPitchFrame,
	}

	--bring back the currency
	hiddenFrame:SetScript("OnEvent", function()
		TokenFrame_LoadUI()
		TokenFrame_Update()
		BackpackTokenFrame_Update()
	end)
	hiddenFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")

	-- hide these default blizzard frames
	for i, frame in next, framesToHide do
		frame:SetParent(hiddenFrame)
	end

	-- disable scripts from these frames
	for i, frame in next, framesToDisable do
		frame:UnregisterAllEvents()
		for i, script in next, scripts do
			if frame:HasScript(script) then
				frame:SetScript(script,nil)
			end
		end
	end
end

-- stop cooldown flash from displaying while the frame is hidden
local function FixCooldownFlash(self)
	if not self then return end
	if self:GetEffectiveAlpha() > 0 then
		self:Show()
	else
		self:Hide()
	end
end
hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, "SetCooldown", FixCooldownFlash)


------------------------------------
-- Skin Buttons
------------------------------------
function bdActionbars:skinButton()

end


