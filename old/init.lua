local addon, ab = ...

local defaults = {}
-- god this is a mess, think of ways to make it nice
-- main config
defaults[#defaults+1] = {stanceswitch = {
	type = "checkbox",
	value = false,
	label = "Switch Bars on Stance Change",
	tooltip = "For classes like Rogue, Warrior, and Demo lock. Change to a new bar when you change stances.",
	callback = function() ab.bar1.UpdateBar1() end
}}
defaults[#defaults+1] = {microSize = {
	type = "slider",
	value = 50,
	label = "Micro Menu Size",
	step = 2,
	min = 20,
	max = 100,
	callback = function() ab.MicroMenu:configCallback() end
}}
defaults[#defaults+1] = {microMenuEnable = {
	type = "checkbox",
	value = true,
	label = "Enable display of Micro Menu.",
	callback = function() ab.MicroMenu:configCallback() end
}}
defaults[#defaults+1] = {buttonsize = {
	type = "slider",
	value = 30,
	label = "Button Size",
	step = 2,
	min = 10,
	max = 50,
	callback = function() ab:UpdateAll() end
}}
defaults[#defaults+1] = {buttonspacing = {
	type = "slider",
	value = 0,
	label = "Button Spacing",
	step = 1,
	min = 0,
	max = 10,
	callback = function() ab:UpdateAll() end
}}
defaults[#defaults+1] = {hidehotkeys = {
	type = "checkbox",
	value = true,
	label = "Hide Hotkeys",
	tooltip = "Hide hotkeys on all bar until you mouse over each button"
}}

-- bar1
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Bar1",
}}
defaults[#defaults+1] = {bar1rows= {
	type = "slider",
	value = 2,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar1:Update() end
}}
defaults[#defaults+1] = {bar1buttons= {
	type = "slider",
	value = 12,
	label = "Num Buttons",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar1:Update() end
}}
defaults[#defaults+1] = {bar1alpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.bar1:Update() end
}}
defaults[#defaults+1] = {bar1hidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.bar1:Update() end
}}

-- bar2
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Bar2",
}}
defaults[#defaults+1] = {bar2rows = {
	type = "slider",
	value = 2,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar2:Update() end
}}
defaults[#defaults+1] = {bar2buttons= {
	type = "slider",
	value = 12,
	label = "Num Buttons",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar2:Update() end
}}
defaults[#defaults+1] = {bar2alpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.bar2:Update() end
}}
defaults[#defaults+1] = {bar2hidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.bar2:Update() end
}}

-- bar3
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Bar3",
}}
defaults[#defaults+1] = {bar3rows = {
	type = "slider",
	value = 2,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar3:Update() end
}}
defaults[#defaults+1] = {bar3buttons= {
	type = "slider",
	value = 12,
	label = "Num Buttons",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar3:Update() end
}}
defaults[#defaults+1] = {bar3alpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.bar3:Update() end
}}
defaults[#defaults+1] = {bar3hidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.bar3:Update() end
}}

-- bar4
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Bar4",
}}
defaults[#defaults+1] = {bar4rows = {
	type = "slider",
	value = 12,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar4:Update() end
}}
defaults[#defaults+1] = {bar4buttons= {
	type = "slider",
	value = 12,
	label = "Num Buttons",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar4:Update() end
}}
defaults[#defaults+1] = {bar4alpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.bar4:Update() end
}}
defaults[#defaults+1] = {bar4hidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.bar4:Update() end
}}

--bar5
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Bar5",
}}
defaults[#defaults+1] = {bar5rows = {
	type = "slider",
	value = 12,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar5:Update() end
}}
defaults[#defaults+1] = {bar5buttons= {
	type = "slider",
	value = 12,
	label = "Num Buttons",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.bar5:Update() end
}}
defaults[#defaults+1] = {bar5alpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.bar5:Update() end
}}
defaults[#defaults+1] = {bar5hidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.bar5:Update() end
}}

--stancebar
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Stance",
}}
defaults[#defaults+1] = {stancebarrows = {
	type = "slider",
	value = 1,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.stancebar:Update() end
}}
defaults[#defaults+1] = {stancebaralpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.stancebar:Update() end
}}
defaults[#defaults+1] = {stancebarhidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.stancebar:Update() end
}}

--petbar
defaults[#defaults+1] = {tab = {
	type = "tab",
	value = "Pet",
}}
defaults[#defaults+1] = {petbarrows = {
	type = "slider",
	value = 1,
	label = "Num Rows",
	step = 1,
	min = 1,
	max = 12,
	callback = function() ab.petbar:Update() end
}}
defaults[#defaults+1] = {petbaralpha = {
	type = "slider",
	value = 1,
	label = "Alpha",
	step = 0.1,
	min = 0,
	max = 1,
	callback = function() ab.petbar:Update() end
}}

defaults[#defaults+1] = {petbarhidemo = {
	type = "checkbox",
	value = false,
	label = "Hide Until Mouseover",
	tooltip = "Hide the bar until mouseover.",
	callback = function() ab.petbar:Update() end
}}

bdCore:addModule("Actionbars", defaults)