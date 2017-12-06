

local composer = require("composer")

local scene = composer.newScene()

local groups = {}

function scene:create(event)

	-- scene.view 
	for i = 8,1, -1 do 

		local grp = display.newGroup()
		--container:insert(grp)
		local img = display.newImage(grp, "assets/bg/2/"..i..".png")
		local img2 = display.newImage(grp, "assets/bg/2/"..i..".png")
		local img3 = display.newImage(grp, "assets/bg/2/"..i..".png")
		
		local scale = screenH/img.height 
		
		img.xScale = scale 
		img.yScale = scale 

		img2.xScale = scale 
		img2.yScale = scale 
		img3.xScale = scale 
		img3.yScale = scale 

		img.x = halfW 
		img.y = screenH - scale*img.height/2

		img2.y = img.y 
		img3.y = img.y

		img2.x = img.x - img.width*scale 
		img3.x = img.x + img.width*scale
			
		groups[i] = grp 
	end 
	
	
end 

	
	
scene:addEventListener("create", scene )



return scene 
 






