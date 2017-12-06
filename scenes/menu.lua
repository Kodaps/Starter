

local composer = require("composer")

local scene = composer.newScene()


function gotoScene(scene)
	composer.gotoScene(scene, {
		time=2000, 
		effect ="fade"
	})
end 



local function makeTextButton(options)

	options = options or {} 
	
	local width = options.width or 300 
	local height = options.height or 30 
	local radius = options.radius or 10 
	local colors = options.colors or {0.5, 0.5, 0.5}

	local grp = display.newGroup()

	grp.params = options.params 
	grp.callback = options.onClick or function() print("no on click") end 

	local rect = display.newRoundedRect(grp, 0,0, width, height, radius )
	
	rect:setStrokeColor(1)
	rect.strokeWidth = 3
	
	local opt = {
		parent = grp,
		x = 0, 
		y = 0, 
		text = options.text or "NO TEXT ??",
		width = width,		
		align = "center", 
		fontSize = 35, 
		font = native.systemFont  
	}
	
	rect:setFillColor(unpack( colors  ))

	local txt = display.newText( opt)
	txt:setFillColor(0)
	
	function grp:tap(event)

		print("params", self.params)
	
		if (self.callback) then 
			self.callback(self.params)
		end 
	
	end 
	
	grp:addEventListener("tap", grp)
	
	return grp 
	
	-- width 
	-- height 
	-- text 
	-- onClick 
end 


local options = {
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="Play",
	onClick=play, 
	params = {score = 53}
}


function done(obj)
	if (obij) then 
		print("obj.x = "..obj.x)
	end 
end 



function Test()
	
	print("in test")
	composer.gotoScene("scenes.settings", {time=2000, effect ="fade"})
	transition.to(ball, {time = 6000, y = -5, onComplete = done})
	print(ball.x)
end 


function scene:create(event)

	local function gotoGame()	
		composer.gotoScene("scenes.game")
	end 
	
	options.onClick = gotoGame
	
	local btn = makeTextButton(options)
	scene.view:insert(btn)
	btn.x = halfW 
	btn.y = halfH 
		
	options.text = "Settings"
	
	local btn2 = makeTextButton(options)
	scene.view:insert(btn2)
	btn2.x = btn.x 
	btn2.y = btn.y + btn.height/2 + 30 + btn2.height/2 	

	options.text = "About"
	options.onClick = gotoScene 

	local btn3 = makeTextButton(options)
	scene.view:insert(btn3)
	btn3.x = btn.x 
	btn3.y = btn2.y + btn2.height/2 + 30 + btn3.height/2 	


	
end 


function scene:hide(event)
	if (event.phase == "did") then 
		ball:removeSelf()
	end 
end 


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )

return scene 