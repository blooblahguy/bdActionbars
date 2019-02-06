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

--=======================================
-- Create Bars main function
--=======================================
function a:CreateBar(buttonList, cfg)
	local frame = CreateFrame("Frame", cfg.name, UIParent, "SecureHandlerStateTemplate")
	frame:SetPoint(unpack(cfg.frameSpawn))
	frame.__blizzardBar = cfg.blizzardBar

	-- Layout the buttons using the config options
	a:LayoutBar(frame, buttonList, cfg)

	-- hook into configuration changes
	table.insert(callbacks, function() a:LayoutBar(frame, buttonList, cfg) end)
	if (cfg.callback) then
		table.insert(callbacks, cfg.callback)
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

	return frame
end

--=======================================
-- Button Layout
--=======================================
function a:LayoutBar(frame, buttonList, cfg)
	-- config
	local scale = c[cfg.cfg.."_scale"] or 1
	local spacing = (c[cfg.cfg.."_spacing"] + c.border) * scale
	local width = c[cfg.cfg.."_size"] * scale
	local height = c[cfg.cfg.."_size"] * scale
	if (cfg.widthScale) then
		width = width * cfg.widthScale
	end
	local rows = c[cfg.cfg.."_rows"] or 1
	local alpha = c[cfg.cfg.."_alpha"] or 1
	local limit = c[cfg.cfg.."_buttons"] or 12
	local mouseover = c[cfg.cfg.."_mouseover"] or false

	local num = #buttonList
	local cols = math.floor(num / rows)

	-- sizing
	local frameWidth = cols * width + (cols-1) * spacing
	local frameHeight = rows * height + (rows-1) * spacing
	frame:SetSize(frameWidth, frameHeight)
	frame:SetAlpha(alpha)
	frame.__alpha = alpha

	-- button positioning
	for i, button in pairs(buttonList) do
		if not frame.__blizzardBar then
			button:SetParent(frame)
		end
		button:SetSize(width, height)

		if (cfg.buttonSkin) then
			cfg.buttonSkin(button)
		else
			a:SkinButton(button)
		end

		button:ClearAllPoints()
		if (i > limit) then
			button:SetPoint("CENTER", v.hidden)
		else
			if (i == 1) then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
			elseif (i > cols) then
				button:SetPoint("TOPLEFT", buttonList[cols], "BOTTOMLEFT", 0, -spacing)
			else
				button:SetPoint("LEFT", buttonList[i - 1], "RIGHT", spacing, 0)
			end
		end
	end
end

--=======================================
-- Skinning
--=======================================
function a:SkinButton(button)
	if button.skinned then return end

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