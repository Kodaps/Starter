_corona = false

require("constants")
require("utils")
require("setup")

display.setDefault("background",0.3,0.3,0.3)

print(" Max texture size on this device : ", system.getInfo( "maxTextureSize" ))

--t = require("displayobjects")
--t:showPage()

-- require("exo.timer")


display.newText("hello", halfW, halfH)


print(halfW, halfH, screenW, screenH)

rect = display.newRect(halfW, halfH, halfW*0.3, halfW*0.3)

rect.x = rect.width/2
rect.y = rect.height/2 


rect:setFillColor(1,1,1, 0.2)
rect:setStrokeColor(1,0,0)
rect.strokeWidth = 5 
rect.anchorX = 0
rect.anchorY = 1




--image = display.newImage("assets/gameassets/jelly/jelly1.png", halfW, halfH)
--image:setFillColor(1,0,0,0.4)


circle = display.newCircle(halfW, halfH, halfW*0.2)


sheetOptions = require("assets.gameassets.cars.cars")
sheet = graphics.newImageSheet("assets/gameassets/cars/cars.png", sheetOptions:getSheet())

local grp = display.newGroup()
grp.anchorChildren = true 


local body = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckBody"), 0, 0  )
local head = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckHead"), 0, -body.height/2  )
local wheel1 = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckWheel"), -body.width/2, body.height/2  )
local wheel2 = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckWheel2"), body.width/2, body.height/2  )

grp.x = halfW
grp.y = halfH


local circle = display.newCircle(grp, 0,0, 15)

local circle2 = display.newCircle( halfW,halfH, 60)
circle2:setFillColor(1,1,1, 0.2)


local scale = screenH*0.25/grp.height 

grp.xScale = scale 
grp.yScale = scale 

grp.wheel1 = wheel1
grp.wheel2 = wheel2


local done = 0

local lastTime

function grp:enterFrame(event)

	if (done % 100 == 0) then 
	    for k,v in pairs(event) do 
	     print(" event."..k.." = "..tostring(v)) 
		end 
	    done = done + 1 
	end 
	
	lastTime = lastTime or event.time 
	
	local diff = (event.time - lastTime)/1000
	lastTime = event.time 
	
	
  self.wheel1.rotation = self.wheel1.rotation + 500*diff
  self.wheel2.rotation = self.wheel2.rotation + 500*diff
  
end 

-- groups : don' over use !!

function rotate()
 -- rect.rotation = rect.rotation + 1
end 


-- print(rect.width)

Runtime:addEventListener("enterFrame", grp)



