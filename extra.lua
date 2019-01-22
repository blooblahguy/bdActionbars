local addon, ab = ...
local config = bdCore.config["Actionbars"]

ab.extra:SetPoint("LEFT", UIParent, "LEFT", 20, 0)
ab.extra:SetSize(180, 100)
bdCore:makeMovable(ab.extra)

ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", ab.extra, "CENTER", 0, 0)
ExtraActionBarFrame.ignoreFramePositionManager = true

ZoneAbilityFrame:SetParent(UIParent)
ZoneAbilityFrame:ClearAllPoints()
ZoneAbilityFrame:SetPoint("CENTER", ab.extra, "CENTER", 0, 0)
ZoneAbilityFrame.ignoreFramePositionManager = true

-- hook the texture, idea by roth via WoWInterface forums
local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
	-- looks like sometime the texture path is set to capital letter instead of lower-case
	if string.sub(texture,1,9) == "Interface" or string.sub(texture,1,9) == "INTERFACE" then
		style:SetTexture("")
	end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)

local GetTime = GetTime
local BOOKTYPE_SPELL = BOOKTYPE_SPELL
local GetSpellCooldown = GetSpellCooldown
local gcd = CreateFrame("StatusBar","bdActionbars GCD",UIParent)
gcd:SetSize(192,2)
gcd:SetPoint("CENTER", UIParent, 0, -220)
gcd:SetMinMaxValues(0,100)
gcd:SetValue(0)
gcd:SetStatusBarTexture(bdCore.media.flat)
gcd:SetStatusBarColor(1,1,1)
gcd:SetAlpha(0.6)
bdCore:setBackdrop(gcd)
bdCore:makeMovable(gcd)
gcd:Hide()
local referenceSpells = {
	['MAGE'] = 190336,		-- Conjure Refreshment
	['WARRIOR'] = 0,
	['PALADIN'] = 183998,  -- Light of the Martyr
	['WARLOCK'] = 0,
	['DEATHKNIGHT'] = 0,
	['ROGUE'] = 0,
	['DRUID'] = 0,
	['SHAMAN'] = 0,
	['MONK'] = 0,
	['DEMONHUNTER'] = 0,
	['HUNTER'] = 0,
	['PRIEST'] = 0,
}

gcd:RegisterEvent('SPELL_UPDATE_COOLDOWN')
gcd:SetScript("OnEvent",function(self, event, ...)
	local class = select(2, UnitClass("player"))
	local spellID = referenceSpells[class]
	local start, duration, enable = GetSpellCooldown(spellID)
	local endtime = start+duration
	
	gcd:SetMinMaxValues(0,duration)
	gcd:SetValue(0)
	
	if (start > 0) then
		gcd:Show()
		gcd:SetScript("OnUpdate", function()
			local t = GetTime()
			if (t < endtime) then
				gcd:SetValue(endtime - GetTime())
			else
				gcd:SetScript("OnUpdate", function() return end)
				gcd:Hide()
			end
		end)
	else
		gcd:SetScript("OnUpdate", function() return end)
		gcd:Hide()
	end
end)

local function onUpdate(self, elapsed)
	
end

local total = 0
