local a, c, v = select(2, ...):unpack()

--=======================================
-- Hiding Helpers
--=======================================
function a:noop() return end

function a:ForceHide(frame)
	if (not frame) then return end
	frame:Hide()
	frame.Show = a.noop
end

--=======================================
-- Get buttons from global
--=======================================
function a:GetButtonList(buttonName,numButtons)
	local buttonList = {}
	for i=1, numButtons do
		local button = _G[buttonName..i]
		if not button then break end
		table.insert(buttonList, button)
	end
	return buttonList
end

--=======================================
-- Hide & Fix Blizzard
-- again, mega credit to Zork
--=======================================
local scripts = { "OnShow", "OnHide", "OnEvent", "OnEnter", "OnLeave", "OnUpdate", "OnValueChanged", "OnClick", "OnMouseDown", "OnMouseUp"}
local framesToHide = { MainMenuBar, OverrideActionBar }
local framesToDisable = { MainMenuBar, MicroButtonAndBagsBar, MainMenuBarArtFrame, StatusTrackingBarManager, ActionBarDownButton, ActionBarUpButton, MainMenuBarVehicleLeaveButton, OverrideActionBar,
  OverrideActionBarExpBar, OverrideActionBarHealthBar, OverrideActionBarPowerBar, OverrideActionBarPitchFrame }

-- loops through and kills hooked scripts
local function StripScripts(frame)
	for i, script in next, scripts do
		if frame:HasScript(script) then
			frame:SetScript(script,nil)
		end
	end
end

-- hide mainmenu bar
function a:HideMainMenuBar()
	--bring back the currency
	local function OnEvent(self,event)
		TokenFrame_LoadUI()
		TokenFrame_Update()
		BackpackTokenFrame_Update()
	end
	v.hidden:SetScript("OnEvent", OnEvent)
	v.hidden:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	for i, frame in next, framesToHide do
		frame:SetParent(v.hidden)
	end
	for i, frame in next, framesToDisable do
		frame:UnregisterAllEvents()
		StripScripts(frame)
	end
end

--fix blizzard cooldown flash
local function FixCooldownFlash(self)
	if not self then return end
	if self:GetEffectiveAlpha() > 0 then
		self:Show()
	else
		self:Hide()
	end
end
hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, "SetCooldown", FixCooldownFlash)

-- fix the button grid for actionbar1
local function ToggleButtonGrid()
	if InCombatLockdown() then return end
	local showgrid = tonumber(GetCVar("alwaysShowActionBars"))
	for i, button in next, buttonList do
		button:SetAttribute("showgrid", showgrid)
		ActionButton_ShowGrid(button)
	end
end
hooksecurefunc("MultiActionBar_UpdateGridVisibility", ToggleButtonGrid)

-- Hide extra textures
StanceBarLeft:SetTexture(nil)
StanceBarMiddle:SetTexture(nil)
StanceBarRight:SetTexture(nil)

SlidingActionBarTexture0:SetTexture(nil)
SlidingActionBarTexture1:SetTexture(nil)

PossessBackground1:SetTexture(nil)
PossessBackground2:SetTexture(nil)

ExtraActionBarFrame.ignoreFramePositionManager = true

PetBattleFrame.BottomFrame.MicroButtonFrame:SetScript("OnShow", nil)
OverrideActionBar:SetScript("OnShow", nil)
MainMenuBar:SetScript("OnShow", nil)