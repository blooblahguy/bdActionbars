local addon, bdAB = ...
local config = bdCore.config.profile["Actionbars"]

local microButtons = {
	"CharacterMicroButton"
	, "SpellbookMicroButton"
	, "TalentMicroButton"
	, "AchievementMicroButton"
	, "QuestLogMicroButton"
	, "GuildMicroButton"
	, "LFDMicroButton"
	, "CollectionsMicroButton"
	, "EJMicroButton"
	, "StoreMicroButton"
	, "MainMenuMicroButton"
}


---------------------------------------------------------
-- Create Micro Menu container
---------------------------------------------------------
local microMenu = CreateFrame("frame", "bdMicroMenu", UIParent)
microMenu:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)

function microMenu:configCallback()
	self:SetSize(((config.microSize * 0.777) + 2) * #microButtons, config.microSize)

	for i = 1, #microButtons do
		local frame = _G[microButtons[i]]
		frame:SetSize(config.microSize * 0.777, config.microSize)
	end

	self:Show()
	if (config.microMenuEnable == false) then
		self:Hide()
	end
end

microMenu:configCallback()
bdCore:makeMovable(microMenu)

---------------------------------------------------------
-- Skin micro buttons
---------------------------------------------------------
local lastButton = nil
for i = 1, #microButtons do
	local frame = _G[microButtons[i]]
	frame:ClearAllPoints()
	frame:SetParent(microMenu)
	frame:SetSize(config.microSize * 0.777, config.microSize)
	frame:SetScale(1)
	local children = {frame:GetChildren()}
	for k, v in pairs(children) do

	end

	local regions = {frame:GetRegions()}
	for k, v in pairs(regions) do
		v:SetTexCoord(.17, .80, .22, .82)
		v:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6)
		v:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 6)
		-- print(v:GetTexture())
	end
	-- frame:DisableDrawLayer("HIGHLIGHT")
	-- frame:DisableDrawLayer("OVERLAY")

	bdCore:setBackdrop(frame)

	if (lastButton) then
		frame:SetPoint("LEFT", lastButton, "RIGHT", 2, 0)
	else
		frame:SetPoint("LEFT", microMenu, "LEFT")
	end

	lastButton = frame
end

bdAB.MicroMenu = microMenu

-- MicroButtonAndBagsBar
-- Hide this?

