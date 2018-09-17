local addon, ab = ...

ab.bar1 = CreateFrame("frame", "bdActionbar 1", UIParent, "SecureHandlerStateTemplate")
ab.bar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 30)

ab.bar2 = CreateFrame("frame", "bdActionbar 2", UIParent, "SecureHandlerStateTemplate")
ab.bar2:SetPoint("BOTTOM", UIParent, "BOTTOM", -220, 30)

ab.bar3 = CreateFrame("frame", "bdActionbar 3", UIParent, "SecureHandlerStateTemplate")
ab.bar3:SetPoint("BOTTOM", UIParent, "BOTTOM", 220, 30)

ab.bar4 = CreateFrame("frame", "bdActionbar 4", UIParent, "SecureHandlerStateTemplate")
ab.bar4:SetPoint("RIGHT", UIParent, "RIGHT", -20, 0)

ab.bar5 = CreateFrame("frame", "bdActionbar 5", UIParent, "SecureHandlerStateTemplate")
ab.bar5:SetPoint("RIGHT", UIParent, "RIGHT", -70, 0)

ab.petbar = CreateFrame("frame", "bdPetActionbar", UIParent, "SecureHandlerStateTemplate")
ab.petbar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 120)

ab.stancebar = CreateFrame("frame", "bdStancebar", UIParent, "SecureHandlerStateTemplate")
ab.stancebar:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -220)

ab.extra = CreateFrame("frame", "bdExtraActionButton", UIParent)
ab.extra:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 220)

ab.ranged = CreateFrame("frame", nil, UIParent)
ab.ranged:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 220)

local config = bdCore.config.profile["Actionbars"]

function ab:UpdateAll()
	ab.bar1:Update()
	ab.bar2:Update()
	ab.bar3:Update()
	ab.bar4:Update()
	ab.bar5:Update()
	if (ab.stancebar.Update) then
		ab.stancebar:Update() 
	end
	if (ab.petbar.Update) then
		ab.petbar:Update()
	end
end

bdCore:hookEvent("bd_reconfig",function() ab:UpdateAll() end)

function ab:UpdateHotkeys()
	config = bdCore.config.profile["Actionbars"]
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

function ab:styleFlyout()
	config = bdCore.config.profile["Actionbars"]
	if (self.FlyoutArrow and not InCombatLockdown()) then	
		
		local FlyoutButtons = 0
		
		if (SpellFlyout) then
			--SpellFlyout:SetWidth(config.buttonsize)
		end
		
		if self.FlyoutBorder then
			self.FlyoutBorder:SetAlpha(0)
			self.FlyoutBorderShadow:SetAlpha(0)
		end
		
		SpellFlyoutHorizontalBackground:SetAlpha(0)
		SpellFlyoutVerticalBackground:SetAlpha(0)
		SpellFlyoutBackgroundEnd:SetAlpha(0)
		
		for i = 1, GetNumFlyouts() do
			local ID = GetFlyoutID(i)
			local spell, tooltip, NumSlots, IsKnown = GetFlyoutInfo(ID)
			if IsKnown then
				FlyoutButtons = NumSlots
				break
			end
		end
		
		local lastbutton = nil
		for i = 1, FlyoutButtons do
			local button = _G["SpellFlyoutButton"..i]
			if (button) then
				ab:skinButton(button)
				button:ClearAllPoints()
				button:SetSize(config.buttonsize, config.buttonsize)
				if (not lastbutton) then
					button:SetPoint("BOTTOM",SpellFlyout, "BOTTOM", 0,2)
				else
					button:SetPoint("BOTTOM",lastbutton,"TOP", 0, 2)
				end
				lastbutton = button
			end
		end
	end
end
hooksecurefunc("ActionButton_UpdateFlyout", ab.styleFlyout)
hooksecurefunc("SpellButton_OnClick", ab.styleFlyout)
hooksecurefunc("ActionButton_UpdateHotkeys", ab.UpdateHotkeys)
hooksecurefunc("PetActionButton_SetHotkeys", ab.UpdateHotkeys)

function ab:skinButton(frame,bar,parent)
	config = bdCore.config.profile["Actionbars"]

	local name = frame:GetName()
	local button = frame
	local icon = _G[name.."Icon"]
	local count = _G[name.."Count"]
	local macro = _G[name.."Name"]
	local cooldown = _G[name.."Cooldown"]
	local flash	 = _G[name.."Flash"]
	local hotkey = _G[name.."HotKey"]
	local border  = _G[name.."Border"]
	local btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]
	local normal2  = _G[name.."NormalTexture2"]
	local btnBG = _G[name.."FloatingBG"]
	
	flash:SetTexture("")
	frame:SetNormalTexture("")
	icon:SetTexCoord(.1, .9, .1, .9)
	icon:SetDrawLayer("ARTWORK")

	if (bar and config[bar..'alpha']) then
		frame:SetAlpha(config[bar..'alpha'])
	end
	
	if frame.skinned then return end
	
	hotkey:ClearAllPoints()
	hotkey:SetFont(bdCore.media.font, 12, "OUTLINE")
	hotkey:SetJustifyH("Right")
	hotkey:SetDrawLayer("OVERLAY", 7)
	hotkey:SetShadowOffset(0, 0)
	hotkey:SetShadowColor(0,0,0,0)
	hotkey:SetVertexColor(1,1,1)
	hotkey:SetTextColor(1,1,1)
	hotkey.SetTextColor = function() return end
	hotkey.SetVertexColor = function() return end
	hotkey:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,-3)
	--hotkey.bdShow = hotkey.Show
	--hotkey.Show = function() return end
	
	ab.UpdateHotkeys(frame)
	
	button.over = false
	
	if (not frame.hotkeyhooked) then
		hooksecurefunc(hotkey,'Show',function()
			if (not button.over and config.hidehotkeys) then hotkey:Hide() end
		end)
		hooksecurefunc(hotkey,'Hide',function()
			if (button.over and config.hidehotkeys) then hotkey:Show() end
		end)
		frame:HookScript("OnEnter", function() 
			button.over = true
			if (config.hidehotkeys) then hotkey:Show() end 
		end)
		frame:HookScript("OnLeave", function() 
			button.over = false
			if (config.hidehotkeys) then hotkey:Hide() end 
		end)
		frame.hotkeyhooked = true
	end
	if (config.hidehotkeys) then hotkey:Hide() else hotkey:Show() end
	
	count:SetFont(bdCore.media.font, 12, "OUTLINE")
	count:SetDrawLayer("OVERLAY", 7)
	count:SetTextColor(0.7,0.7,0.7)
	count:SetJustifyH("Center")
	count:ClearAllPoints()
	count:SetShadowOffset(0,0)
	count:SetShadowColor(0,0,0,0)
	count:SetTextColor(1,1,1)
	count:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,0)
	
	macro:SetFont(bdCore.media.font, 12, "THINOUTLINE")
	macro:SetDrawLayer("OVERLAY", 7)
	macro:SetTextColor(0.7,0.7,0.7)
	macro:SetJustifyH("RIGHT")
	macro:SetShadowOffset(0,0)
	macro:SetShadowColor(0,0,0,0)
	macro:SetTextColor(1,1,1)
	macro:ClearAllPoints()
	macro:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,1)

	cooldown:GetRegions():SetFont(bdCore.media.font, 12, "OUTLINE")
	cooldown:GetRegions():SetJustifyH("Center")
	cooldown:GetRegions():ClearAllPoints()
	cooldown:GetRegions():SetAllPoints(cooldown)
	cooldown:SetParent(frame)
	cooldown:ClearAllPoints()
	cooldown:SetAllPoints(frame)

	-- button textures
	local hover = frame:CreateTexture()
	hover:SetTexture(bdCore.media.flat)
	hover:SetVertexColor(1, 1, 1, 0.1)
	hover:SetAllPoints(frame)
	frame.hover = hover
	frame:SetHighlightTexture(hover)

	local pushed = frame:CreateTexture()
	pushed:SetTexture(bdCore.media.flat)
	pushed:SetVertexColor(1, 1, 1, 0.2)
	pushed:SetAllPoints(frame)
	frame.pushed = pushed
	frame:SetPushedTexture(pushed)

	local checked = frame:CreateTexture()
	checked:SetTexture(bdCore.media.flat)
	checked:SetVertexColor(0.2,1,0.2)
	checked:SetAlpha(0.3)
	checked.SetAlpha = function() return end -- stop it, game
	checked:SetAllPoints(frame)
	frame.checked = checked
	frame:SetCheckedTexture(checked)
	
	bdCore:setBackdrop(frame)
	
	if (bar and parent) then
		if (not parent.hooked) then
			parent.total = 0
			parent:HookScript("OnUpdate",function(self,elapsed)
				parent.total = parent.total + elapsed
				if (parent.total > 0.1 and config[bar..'hidemo']) then
					parent.total = 0
					if (MouseIsOver(self) or bdCore.moving) then
						self:SetAlpha(1)
					else
						self:SetAlpha(0)
						if (SpellFlyout:IsShown()) then
							local bdparent = SpellFlyout:GetParent():GetParent():GetParent():GetName()
							if (bdparent == self:GetName() and not MouseIsOver(SpellFlyout)) then
								SpellFlyout:Hide()
							end
						end
					end
					
					
					if (SpellFlyout:IsShown() and MouseIsOver(SpellFlyout)) then
						local bdparent = SpellFlyout:GetParent():GetParent():GetParent():GetName()
						if bdparent == self:GetName() then
							self:SetAlpha(1)
						end
					end
				elseif (not config[bar.."hidemo"]) then
					self:SetAlpha(1)
				end
			end)
			
			parent.hooked = true
		end
		if (not frame.hooked) then
			frame:HookScript("OnLeave",function()
				if(not MouseIsOver(parent) and not MouseIsOver(SpellFlyout) and config[bar..'hidemo'])then 
					parent:SetAlpha(0)
				end 
			end)
			frame:HookScript("OnEnter",function()
				parent:SetAlpha(1)
			end)
			cooldown:HookScript("OnShow",function(self)
				if(parent:GetAlpha()==0)then self:Hide()end 
			end)
			frame.hooked = true
		end
		if (config[bar..'hidemo']) then
			parent:SetAlpha(0)
		else
			parent:SetAlpha(1)
		end
	end
	
	

	if _G[name.."Shine"] then
		_G[name.."Shine"]:SetAlpha(0)
		_G[name.."Shine"]:Hide()
		_G[name.."Shine"]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		_G[name.."Shine"]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end
	if _G[name.."Checked"] then
		_G[name.."Checked"]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		_G[name.."Checked"]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end
	if _G[name.."NormalTexture2"] then
		_G[name.."NormalTexture2"]:Hide()
	end
	if _G[name.."AutoCastable"] then
		_G[name.."AutoCastable"]:Hide()
	end
	if border then
		border:Hide()
		border.Show = function() return nil end
	end
	if btnBG then
		btnBG:Hide()
		btnBG.Hide = function() return nil end
	end
	frame.skinned = true
end

function ab:Size(frame, group, num)
	if (InCombatLockdown()) then return end
	local border = bdCore.config.persistent['General'].border
	local rows = math.floor(num/config[group])

	local height = (config.buttonsize+border+config.buttonspacing)*(num/rows)-config.buttonspacing-border
	local width = (config.buttonsize+border+config.buttonspacing)*(rows)-config.buttonspacing-border
	frame:SetSize(width, height)
	--frame.moveContainer:Size(width+4, height+4)
end
