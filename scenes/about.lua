
local composer = require( "composer" )
 
local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
 local grp 
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
	
 
    if ( phase == "will" ) then
	
	
		grp = display.newGroup()
		
		sceneGroup:insert(grp)
		
		for i = 1,20 do 
			local app = display.newRect(halfW, (i-1) * (10 + screenW*.2), screenW, screenW*.2)
			app.anchorY = 0
			grp:insert(app)
			app:setFillColor(i/20, 0 , 1 - i/20)
		end 
	
		function grp:limit()
		
			if (self.y > 0) then 
				self.y = 0 
				self.speed = -1*self.speed
			end 
			
			if (self.y < screenH - self.height) then 
				self.y = screenH - self.height
				self.speed = -1*self.speed
			end 
			

		end 
	
		function grp:touch(event)
			--for k,v in pairs(event) do 
			--	print(k..":"..tostring(v))
			--end 
		
			if (event.phase == "began") then 
				self.touchActive = true 
				self.yStart = self.y 
				self.lastTime = event.time 
			end 

			if (event.phase == "moved") then 
				self.y = self.yStart + (event.y - event.yStart)
				
				self.speed = (event.y - event.yStart)*1000/(event.time - self.lastTime)
				--self.lastTime = event.time 
				self:limit()
				
				
			end 		
			
			if (event.phase == "ended") or (event.phase == "cancelled")  then 
				self.lastTime = event.time 
				self.touchActive = false  
			end 
			
		end 


		grp:addEventListener("touch", grp)
			
		function grp:enterFrame(event)
			print("in enter")
			self.lastTime = self.lastTime or event.time 
			self.speed = self.speed or 0 
			if (self.touchActive == false) then 
				local diff = (event.time - self.lastTime)/1000	
				self.y = self.y + self.speed * diff 
				self.speed = self.speed * 0.7
				self:limit()
			end 
		end 
		
		Runtime:addEventListener("enterFrame", grp )
	
	
    elseif ( phase == "did" ) then
		

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    
    local phase = event.phase
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
	elements = nil  
end
 
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene