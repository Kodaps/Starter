

local composer = require("composer")
local ui = require("scripts.ui")

local scene = composer.newScene()

local loc = require("scripts.loc")


function gotoScene(scene)
	composer.gotoScene(scene, {
		time=2000, 
		effect ="fade"
	})
end 

local w = screenW*0.4
local h = screenH*0.1




local buttons = {
	{ width = w, height = h, radius = 10, text="play", scene="scenes.game"},
	{ width = w, height = h, radius = 10, colors = {0.4,0.7, 0.9}, text="settings", scene="scenes.settings"},
	{ width = w, height = h, radius = 10, colors = {0.4,0.7, 0.9}, text="test", scene="scenes.test"},
	{ width = w, height = h, radius = 10, colors = {0.4,0.7, 0.9}, text="about", scene="scenes.about"}
}


function done(obj)
	if (obij) then 
		print("obj.x = "..obj.x)
	end 
end 



function Test()	
	print("in test")
	composer.gotoScene("scenes.settings", {time=2000, effect ="fade"})
end 

function scene:show(event)
	if (event.phase == "will") then 
		for k, btnData in pairs (buttons) do 
			self.btns[k]:setText(loc(btnData.text))
		end 
	end 
end 

function scene:create(event)

	
	self.btns = {}

	
	local grp = display.newGroup()
	self.view:insert(grp)
	grp.anchorChildren = true 
	
	local y = 0

	for k, btnData in ipairs(buttons) do 
	
		local btn = ui:makeTextButton(btnData)
		grp:insert(btn)
		btn.x = 0 
		btn.y = y + btn.height + 10  
		table.insert(self.btns, btn)
		y = btn.y 
	end 
	
	grp.x = halfW 
	grp.y = halfH 

	loc.test = 42
	print("loc.test = "..tostring(loc.test))
	
end 


function scene:hide(event)
	if (event.phase == "did") then 
	end 
end 

function scene:destroy(event)
	self.btns = {}
end 

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene 