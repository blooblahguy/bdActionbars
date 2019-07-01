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
-- since most of the bars share identical conf, let's just use a function to save space and time
local function addBarConf(title, key, rows, mouseover)
	rows = rows or 1
	mouseover = mouseover or false

	if (title) then
		tinsert(defaults, { tab = {
			type = "tab",
			value = title
		}})
	end

	tinsert(defaults, { [key.."_mouseover"] = {
		type = "checkbox",
		value = mouseover,
		label = "Hide Until Mouseover",
	}})
	tinsert(defaults, { [key.."_size"] = {
		type = "slider",
		min = 4,
		max = 100,
		step = 2,
		value = size_md,
		label = "Button Size"
	}})
	tinsert(defaults, { [key.."_spacing"] = {
		type = "slider",
		min = 0,
		max = 20,
		step = 1,
		value = 0,
		label = "Button Spacing"
	}})
	tinsert(defaults, { [key.."_scale"] = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Scale"
	}})
	tinsert(defaults, { [key.."_alpha"] = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 1,
		label = "Bar Alpha"
	}})
	tinsert(defaults, { [key.."_buttons"] = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = 12,
		label = "Number of Buttons"
	}})
	tinsert(defaults, { [key.."_rows"] = {
		type = "slider",
		min = 1,
		max = 12,
		step = 1,
		value = rows,
		label = "Number of Rows"
	}})

	tinsert(defaults, { [key.."_hidehotkeys"] = {
		type = "checkbox",
		value = false,
		label = "Hide Bar Hotkeys until Mouseover"
	}})

	
end
--=========================================
-- General
--=========================================
	-- tinsert(defaults, { bindingmode = {
	-- 	type = "button",
	-- 	value = "Toggle Binding Mode",
	-- 	callback = function() a:ToggleBindings() end
	-- }})
	-- tinsert(defaults, { bindaccount = {
	-- 	type = "checkbox",
	-- 	value = true,
	-- 	label = "Save bindings by account"
	-- }})
	tinsert(defaults, { font_size = {
		type = "slider",
		min = 1,
		max = 30,
		step = 1,
		value = 12,
		label = "Main Font Size"
	}})
	tinsert(defaults, { font_size = {
		type = "slider",
		min = 0,
		max = 1,
		step = 0.1,
		value = 0.2,
		label = "Bar Fade Duration"
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
		value = size_md,
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
	addBarConf("Main Bar", "bar1")

--=========================================
-- Bar 2
--=========================================
	addBarConf("Bar 2", "bar2")

--=========================================
-- Bar 3
--=========================================
	addBarConf("Bar 3", "bar3")

--=========================================
-- Bar 4
--=========================================
	addBarConf("Bar 4", "bar4", 12, true)

--=========================================
-- Bar 5
--=========================================
	addBarConf("Bar 5", "bar5", 12, true)

--=========================================
-- Stance & Pet
--=========================================
	tinsert(defaults, { tab = {
		type = "tab",
		value = "Stance & Pet"
	}})
	-- STANCE
	tinsert(defaults, { text = {
		type = "text",
		value = "Stance Bar"
	}})
	addBarConf(false, "stancebar")

	-- PET
	tinsert(defaults, { text = {
		type = "text",
		value = "Pet Bar"
	}})
	addBarConf(false, "petbar")

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