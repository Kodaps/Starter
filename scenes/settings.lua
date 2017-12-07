-- settings.lua 
local composer = require("composer")

local ui = require("scripts.ui")
local loc = require("scripts.loc")

local scene = composer.newScene()
--local prefs 

local defaultPref = {
	lang = "fr", 
	vibration = true 
}


local function goBack()
	composer.gotoScene("scenes.menu")
end 

local function changeLanguage(params)

	print(" in save")
	for k,v in pairs(params) do 
		print(k..":"..v)
	end 

	loc:setLanguage(params.lang) 	
	
	for k,v in pairs(params) do 
		prefs[k] = v 
	end 
	
 	table.save(prefs, "preferences.json", system.DocumentsDirectory)



end 


local buts = {


	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="English",
	onClick=changeLanguage, 
	params = {lang = "en"}
	}, 
	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="French",
	onClick=changeLanguage, 
	params = {lang = "fr"}
}, 
	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="Back",
	onClick=goBack 
}, 

}





function scene:create(event)

	prefs = table.load("preferences.json", system.DocumentsDirectory) or defaultPref

	loc:setLanguage(prefs.lang) 
	
	for k,v in pairs(defaultPref) do 
		prefs[k] = prefs[k] or v 
	end 
	
	local function onUpdate(pct )
		-- setVolume 
		print(pct)
	end 
	
	
	local slider = ui:makeCursor({width = 400, height = 50, onUpdate = onUpdate})
	
	slider.x = 200
	slider.y = 100 
	
	-- print("vibration = "..pref.vibration)
	
	local grp = display.newGroup()
	grp.anchorChildren = true 
	
	scene.view:insert(grp)

	for k,v in ipairs(buts) do 
		local btn = ui:makeTextButton(v)
		grp:insert(btn)
		btn.x = 0
		btn.y = k * (btn.height + 10)
	end 
	
	grp.x = halfW 
	grp.y = halfH 

end 

scene:addEventListener("create")


return scene 

