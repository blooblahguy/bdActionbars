local addonName, bdActionbars = ...
bdActionbars[1] = CreateFrame("Frame", "bdActionbars Core", UIParent) -- frame
local a = bdActionbars[1]
--[[
	Significat thanks and props to Zork for rActionbars and zLip functionality that makes this all way less of a nightmare
]]
--==================================================================================
-- Initialize configuration
local defaults = {}
local size_md = 30
local size_lg = 50
local size_sm = 20
--==================================================================================

--=========================================
-- General
--=========================================
	tinsert(defaults, { font_size = {
		type = "slider",
		min = 1,
		max = 30,
		step = 1,
		value = 12,
		label = "Main Font Size"
	}})
	tinsert(defaults, { clear = { type = "clear" }})

	-- micro
	tinsert(defaults, { showMicro = {
		type = "checkbox",
		value = true,
		label = "Show Micro Menu",
	}})
	tinsert(defaults, { microbar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_sm,
		label = "Micro Menu Button Size"
	}})

	-- bagbar
	tinsert(defaults, { showBags = {
		type = "checkbox",
		value = false,
		label = "Show Bag Menu",
	}})
	tinsert(defaults, { bagbar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_sm,
		label = "Bags Bar Button Size"
	}})

	-- vehicle
	tinsert(defaults, { showVehicle = {
		type = "checkbox",
		value = true,
		label = "Show Vehicle Exit",
	}})
	tinsert(defaults, { vehiclebar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Vehicle Exit Size"
	}})

	-- possess
	tinsert(defaults, { showPossess = {
		type = "checkbox",
		value = true,
		label = "Show Possess Exit",
	}})
	tinsert(defaults, { possessbar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Possess Exit Size"
	}})

	-- extra
	tinsert(defaults, { extrabar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_lg,
		label = "Extra Button Size"
	}})

--=========================================
-- Main Bar
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Main Bar"
	}})
	tinsert(defaults, { bar1_mouseover = {
		type = "checkbox",
		value = false,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { bar1_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { bar1_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { bar1_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { bar1_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { bar1_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { bar1_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 1,
		label = "Number of Rows"
	}})

--=========================================
-- Bar 2
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Bar 2"
	}})
	tinsert(defaults, { bar2_mouseover = {
		type = "checkbox",
		value = false,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { bar2_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { bar2_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { bar2_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { bar2_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { bar2_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { bar2_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 1,
		label = "Number of Rows"
	}})

--=========================================
-- Bar 3
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Bar 3"
	}})
	tinsert(defaults, { bar3_mouseover = {
		type = "checkbox",
		value = false,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { bar3_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { bar3_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { bar3_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { bar3_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { bar3_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { bar3_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 1,
		label = "Number of Rows"
	}})

--=========================================
-- Bar 4
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Bar 4"
	}})
	tinsert(defaults, { bar4_mouseover = {
		type = "checkbox",
		value = true,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { bar4_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { bar4_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { bar4_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { bar4_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { bar4_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { bar4_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Rows"
	}})

--=========================================
-- Bar 5
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Bar 5"
	}})
	tinsert(defaults, { bar5_mouseover = {
		type = "checkbox",
		value = true,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { bar5_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { bar5_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { bar5_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { bar5_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { bar5_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { bar5_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Rows"
	}})

--=========================================
-- Stance & Pet
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Stance & Pet"
	}})
	-- STANCE
	tinsert(defaults, { clear = { type = "clear" }})
	tinsert(defaults, { text = {
		type = "text",
		value = "Stance Bar"
	}})
	tinsert(defaults, { stancebar_mouseover = {
		type = "checkbox",
		value = false,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { stancebar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_sm,
		label = "Button Size"
	}})
	tinsert(defaults, { stancebar_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { stancebar_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { stancebar_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { stancebar_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { stancebar_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 1,
		label = "Number of Rows"
	}})

	-- PET
	tinsert(defaults, { clear = { type = "clear" }})
	tinsert(defaults, { text = {
		type = "text",
		value = "Pet Bar"
	}})
	tinsert(defaults, { petbar_mouseover = {
		type = "checkbox",
		value = false,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { petbar_size = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_sm,
		label = "Button Size"
	}})
	tinsert(defaults, { petbar_spacing = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { petbar_scale = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { petbar_alpha = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { petbar_buttons = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { petbar_rows = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 1,
		label = "Number of Rows"
	}})


--=========================================
-- add to config lib
--=========================================
	bdConfigLib:RegisterModule({
		name = "Actionbars",
		callback = function() a:ConfigCallback() end
	}, defaults, "BD_persistent")

--==================================================================================
-- Core Initialization
--==================================================================================


bdActionbars[2] = bdConfigLib:GetSave("Actionbars") -- config
bdActionbars[2].border = bdConfigLib:GetSave("bdAddons").border

bdActionbars[3] = {} -- variables
bdActionbars[3].hidden = CreateFrame("Frame")
bdActionbars[3].hidden:Hide()
bdActionbars[3].callbacks = {}

bdActionbars[3].font = CreateFont("BDA_FONT")
bdActionbars[3].font:SetFont(bdCore.media.font, bdActionbars[2].font_size, "OUTLINE")
bdActionbars[3].font:SetShadowColor(0, 0, 0)
bdActionbars[3].font:SetShadowOffset(0, 0)

function bdActionbars:unpack()
	return self[1], self[2], self[3]
end