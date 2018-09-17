local addon, ab = ...
local config = bdCore.config.profile['Actionbars']

function ab.ranged:OnUpdate(elapsed)
	if (not self.rangeTimer) then
		return
	end

	if ( self.rangeTimer == TOOLTIP_UPDATE_TIME ) then
		ab.ranged:Update(self)
	end
end


function ab.ranged:Update()
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
		else -- In range
			Icon:SetVertexColor(1.0, 1.0, 1.0)
			NormalTexture:SetVertexColor(1.0, 1.0, 1.0)
		end
	else
		Icon:SetVertexColor(0.3, 0.3, 0.3)
		NormalTexture:SetVertexColor(0.3, 0.3, 0.3)
	end
end

hooksecurefunc("ActionButton_OnUpdate", ab.ranged.Update)
hooksecurefunc("ActionButton_Update", ab.ranged.Update)
hooksecurefunc("ActionButton_UpdateUsable", ab.ranged.Update)
