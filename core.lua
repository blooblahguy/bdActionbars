local a, c, v = select(2, ...):unpack()

--=======================================
-- Primary Configuration callback
--=======================================
function a:ConfigCallback()
	v.font:SetFont(bdCore.media.font, c.font_size)

	-- loop through bar callbacks
	for k, v in pairs(v.callbacks) do
		v()
	end
end
local function HideKeybinds(frame)
	local hide = frame.hidehotkeys and not IsMouseOverFrame(frame)

	for i, button in pairs(buttonList) do
		local hotkey = _G[button:GetName().."HotKey"]
		if (hotkey) then
			if (hide) then
				hotkey:Hide()
			else
				hotkey:Show()
			end
		end
	end
end

--=======================================
-- Create Bars main function
--=======================================
function a:CreateBar(buttonList, cfg)
	local frame = CreateFrame("Frame", cfg.frameName, UIParent, "SecureHandlerStateTemplate")
	frame:SetPoint(unpack(cfg.frameSpawn))
	frame.__blizzardBar = cfg.blizzardBar
	frame.buttonList = buttonList

	-- hide hotkeys based on mousing over full bar
	frame:HookScript("OnEnter", HideKeybinds)
	frame:HookScript("OnLeave", HideKeybinds)

	-- Layout the buttons using the config options
	a:LayoutBar(frame, buttonList, cfg)

	-- hook into configuration changes
	table.insert(v.callbacks, function() a:LayoutBar(frame, buttonList, cfg) end)
	if (cfg.callback) then
		table.insert(v.callbacks, cfg.callback)
	end

	--reparent the Blizzard bar
	if cfg.blizzardBar then
		cfg.blizzardBar:SetParent(frame)
		cfg.blizzardBar:EnableMouse(false)
	end

	-- visibility driver
	if cfg.frameVisibility then
		frame.frameVisibility = cfg.frameVisibility
		frame.frameVisibilityFunc = cfg.frameVisibilityFunc
		RegisterStateDriver(frame, cfg.frameVisibilityFunc or "visibility", cfg.frameVisibility)
	end

	-- Moveable
	bdCore:makeMovable(frame)

	-- Fader
	if (c[cfg.cfg.."_mouseover"]) then
		bdMoveLib:CreateFader(frame, buttonList, alpha)
	end

	return frame
end

--=======================================
-- Button Layout
--=======================================
function a:LayoutBar(frame, buttonList, cfg)
	-- config
	frame.limit = c[cfg.cfg.."_buttons"] or 12
	frame.scale = c[cfg.cfg.."_scale"] or 1
	frame.spacing = (c[cfg.cfg.."_spacing"] or cfg.spacing or 0) + c.border
	frame.width = (c[cfg.cfg.."_size"] * frame.scale) * cfg.widthScale or 1
	frame.height = c[cfg.cfg.."_size"] * frame.scale
	frame.rows = c[cfg.cfg.."_rows"] or 1
	frame.alpha = c[cfg.cfg.."_alpha"] or 1
	frame.enableFader = c[cfg.cfg.."_mouseover"] or false
	frame.hidehotkeys = c[cfg.cfg.."_hidehotkeys"] or false

	frame.num = #buttonList
	frame.cols = math.min(frame.limit, math.floor(frame.num / frame.rows))

	-- sizing
	local frameWidth = frame.cols * frame.width + (frame.cols-1) * frame.spacing
	local frameHeight = frame.rows * frame.height + (frame.rows-1) * frame.spacing
	frame:SetSize(frameWidth, frameHeight)
	frame:SetAlpha(frame.alpha)

	-- button positioning
	local lastRow = nil
	local index = 1
	local showgrid = tonumber(GetCVar("alwaysShowActionBars"))	
	for i, button in pairs(buttonList) do
		if not frame.__blizzardBar then
			button:SetParent(frame)
		else
			frame.__blizzardBar.size = frame.size
			frame.__blizzardBar.alpha = frame.alpha
			frame.__blizzardBar.spacing = frame.spacing
		end
		button:SetSize(frame.width, frame.height)

		-- custom skinning callback
		if (cfg.buttonSkin) then
			cfg.buttonSkin(button)
		else
			a:SkinButton(button)
		end

		button:ClearAllPoints()
		if (i > frame.limit) then
			button:SetPoint("CENTER", v.hidden, "CENTER", 0, 0)
			button:Hide()
			button:SetAlpha(0)
		else
			button:SetAlpha(1)
			button:Show()
			button:SetAttribute("showgrid", showgrid)
			if (i == 1) then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				lastRow = button
			elseif (index > cols) then
				button:SetPoint("TOPLEFT", lastRow, "BOTTOMLEFT", 0, -frame.spacing)
				lastRow = button
				index = 1
			else
				button:SetPoint("LEFT", buttonList[i - 1], "RIGHT", frame.spacing, 0)
			end
		end
		index = index + 1
	end
end

--=======================================
-- Skinning
--=======================================
function a:SkinButton(button)
	if button.skinned then return end
	if (not button.SetNormalTexture) then return end

	local name = button:GetName()
	local icon = _G[name.."Icon"]
	local count = _G[name.."Count"]
	local macro = _G[name.."Name"]
	local cooldown = _G[name.."Cooldown"]
	local flash = _G[name.."Flash"]
	local checked = _G[name.."Checked"]
	local shine = _G[name.."Shine"]
	local hotkey = _G[name.."HotKey"]
	local border = _G[name.."Border"]
	local normal = _G[name.."NormalTexture"]
	local normal2 = _G[name.."NormalTexture2"]
	local btnBG = _G[name.."FloatingBG"]
	local autocastable = _G[name.."AutoCastable"]

	button:SetNormalTexture("")

	if ( not flash ) then return end

	flash:SetTexture("")
	icon:SetTexCoord(.1, .9, .1, .9)
	icon:SetDrawLayer("ARTWORK")

	-- Text Overrides
	hotkey:SetFontObject(v.font)
	hotkey:SetJustifyH("Right")
	hotkey:SetVertexColor(1, 1, 1)
	hotkey:SetTextColor(1, 1, 1)
	hotkey.SetTextColor = a.noop
	hotkey.SetVertexColor = a.noop
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0,-3)

	count:SetFontObject(v.font)
	count:SetTextColor(0.7,0.7,0.7)
	count:SetJustifyH("Center")
	count:SetTextColor(1,1,1)
	count:ClearAllPoints()
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0,0)
	
	if (not macro) then return end
	macro:SetFontObject(v.font)
	macro:SetTextColor(0.7,0.7,0.7)
	macro:SetJustifyH("RIGHT")
	macro:SetTextColor(1,1,1)
	macro:ClearAllPoints()
	macro:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0,1)

	-- Fix cooldown Spiral Positioning
	cooldown:GetRegions():SetFontObject(v.font)
	cooldown:GetRegions():SetJustifyH("Center")
	cooldown:GetRegions():ClearAllPoints()
	cooldown:GetRegions():SetAllPoints(cooldown)
	cooldown:SetParent(button)
	cooldown:ClearAllPoints()
	cooldown:SetAllPoints(button)

	-- Button Overwrite Textures
	button.hover = button:CreateTexture()
	button.hover:SetTexture(bdCore.media.flat)
	button.hover:SetVertexColor(1, 1, 1, 0.1)
	button.hover:SetAllPoints(button)
	button:SetHighlightTexture(button.hover)

	button.pushed = button:CreateTexture()
	button.pushed:SetTexture(bdCore.media.flat)
	button.pushed:SetVertexColor(1, 1, 1, 0.2)
	button.pushed:SetAllPoints(button)
	button:SetPushedTexture(button.pushed)

	button.checked = button:CreateTexture()
	button.checked:SetTexture(bdCore.media.flat)
	button.checked:SetVertexColor(0.2,1,0.2)
	button.checked:SetAlpha(0.3)
	button.checked.SetAlpha = a.noop
	button.checked:SetAllPoints(button)
	button:SetCheckedTexture(button.checked)	

	-- Position these things onto the button
	if shine then
		shine:SetAlpha(0)
		shine:Hide()
		shine:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 0, 0)
		shine:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, 0)
	end
	if checked then
		checked:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 0, 0)
		checked:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, 0)
	end

	-- Force hide elements we don't want
	a:ForceHide(autocastable)
	a:ForceHide(normal2)
	a:ForceHide(border)
	a:ForceHide(btnBG)

	bdCore:setBackdrop(button)

	button.skinned = true
end


-- Flyout skinning
function styleFlyout(self)
	if (not self.FlyoutArrow or InCombatLockdown()) then return end

	local parent = self:GetParent():GetParent():GetParent()
	local size = parent.width or c.bar1_size
	local alpha = parent.alpha or 1
	local spacing = parent.spacing or 2

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local button = _G["SpellFlyoutButton"..i]
		if not button then break end

		a:skinButton(button)
		button:ClearAllPoints()
		button:SetSize(size, size)
		if (i == 1) then
			button:SetPoint("BOTTOM", SpellFlyout, "BOTTOM", 0, spacing)
		else
			button:SetPoint("BOTTOM", _G["SpellFlyoutButton"..i-1], "TOP", 0, spacing)
		end
	end
end
hooksecurefunc("ActionButton_UpdateFlyout", styleFlyout)
hooksecurefunc("SpellButton_OnClick", styleFlyout)