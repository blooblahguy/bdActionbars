local a, c, v = select(2, ...):unpack()

--===================================================
-- Range Display
--===================================================
local total = 0
local throttle = 0.1
local function RangedOnUpdate(elapsed)
	total = total + elapsed
	if (total >= throttle) then
		RangedUpdate(self)
	end
end

local function RangedUpdate(frame)
	if (not self and frame) then self = frame end
	local Name = self:GetName()
	local Icon = _G[Name.."Icon"]
	local NormalTexture = _G[Name.."NormalTexture"]
	local ID = self.action
	local IsUsable, NotEnoughMana = IsUsableAction(ID)
	local HasRange = ActionHasRange(ID)
	local InRange = IsActionInRange(ID)
	
	 if IsUsable then -- Usable
		if (HasRange and InRange == false) then -- Out of range
			Icon:SetVertexColor(0.8, 0.1, 0.1)
			NormalTexture:SetVertexColor(0.8, 0.1, 0.1)
		elseif (NotEnoughMana) then
			Icon:SetVertexColor(0.3, 0.3, 0.8)
			NormalTexture:SetVertexColor(0.3, 0.3, 0.8)
		else -- In range
			Icon:SetVertexColor(1.0, 1.0, 1.0)
			NormalTexture:SetVertexColor(1.0, 1.0, 1.0)
		end
	else
		Icon:SetVertexColor(0.3, 0.3, 0.3)
		NormalTexture:SetVertexColor(0.3, 0.3, 0.3)
	end
end

hooksecurefunc("ActionButton_OnUpdate", RangedOnUpdate)
hooksecurefunc("ActionButton_Update", RangedUpdate)
hooksecurefunc("ActionButton_UpdateUsable", RangedUpdate)

--===================================================
-- Hotkey Improvements
--===================================================
function a:UpdateHotkeys(frame)
	if (not self and frame) then self = frame end

	local hotkey = _G[self:GetName() .. "HotKey"]
	local text = hotkey:GetText()
	if (not text) then return end
	
	text = string.gsub(text, "(s%-)", "S-")
	text = string.gsub(text, "(a%-)", "A-")
	text = string.gsub(text, "(c%-)", "C-")
	text = string.gsub(text, KEY_MOUSEWHEELDOWN , "MDn")
    text = string.gsub(text, KEY_MOUSEWHEELUP , "MUp")
	text = string.gsub(text, KEY_BUTTON3, "M3")
	text = string.gsub(text, KEY_BUTTON4, "M4")
	text = string.gsub(text, KEY_BUTTON5, "M5")
	text = string.gsub(text, KEY_MOUSEWHEELUP, "MU")
	text = string.gsub(text, KEY_MOUSEWHEELDOWN, "MD")
	text = string.gsub(text, KEY_NUMPAD0, "N0")
    text = string.gsub(text, KEY_NUMPAD1, "N1")
    text = string.gsub(text, KEY_NUMPAD2, "N2")
    text = string.gsub(text, KEY_NUMPAD3, "N3")
    text = string.gsub(text, KEY_NUMPAD4, "N4")
    text = string.gsub(text, KEY_NUMPAD5, "N5")
    text = string.gsub(text, KEY_NUMPAD6, "N6")
    text = string.gsub(text, KEY_NUMPAD7, "N7")
    text = string.gsub(text, KEY_NUMPAD8, "N8")
    text = string.gsub(text, KEY_NUMPAD9, "N9")
    text = string.gsub(text, KEY_NUMPADDECIMAL, "N.")
    text = string.gsub(text, KEY_NUMPADDIVIDE, "N/")
    text = string.gsub(text, KEY_NUMPADMINUS, "N-")
    text = string.gsub(text, KEY_NUMPADMULTIPLY, "N*")
    text = string.gsub(text, KEY_NUMPADPLUS, "N+")
	text = string.gsub(text, KEY_PAGEUP, "PU")
	text = string.gsub(text, KEY_PAGEDOWN, "PD")
	text = string.gsub(text, KEY_SPACE, "Spc")
	text = string.gsub(text, KEY_INSERT, "Ins")
	text = string.gsub(text, KEY_HOME, "Hm")
	text = string.gsub(text, KEY_DELETE, "Del")
	text = string.gsub(text, KEY_INSERT_MAC, "Hlp") -- mac

	hotkey:SetText(text)
end

hooksecurefunc("ActionButton_UpdateHotkeys", ab.UpdateHotkeys)
hooksecurefunc("PetActionButton_SetHotkeys", ab.UpdateHotkeys)