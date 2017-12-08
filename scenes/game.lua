local composer = require("composer")

local scene = composer.newScene()
local physics = require("physics")

local groups = {}

local function makeCar(id)
	
    id = id or 1
    local names = {"truck","orc", "girl"}
    name = names[id] or "truck"

    local sheetOptions = require("assets.gameassets.cars.cars")
    local sheet = graphics.newImageSheet("assets/gameassets/cars/cars.png", sheetOptions:getSheet())


	local scale = 0.3

	local car = {}

	car.body = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Body"), 0, 0)

	print(car.body)

	car.head = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Head"), 0, 0  )
	car.wheel1 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel"), 0,0 )
	car.wheel2 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel2"), 0,0  )

	car.body.xScale = scale 
	car.body.yScale = scale 
	car.head.xScale = scale 
	car.head.yScale = scale 
	car.wheel1.xScale = scale 
	car.wheel1.yScale = scale 
	car.wheel2.xScale = scale 
	car.wheel2.yScale = scale 

	car.wheel1.alpha = 0.7
	car.wheel2.alpha = 0.7 

	car.body.x = halfW 
	car.body.y = halfH


	car.head.x, car.head.y = car.body.x, car.body.y - car.body.contentHeight*.5
	car.wheel1.x, car.wheel1.y = car.body.x -car.body.contentWidth*.4, car.body.y + car.body.contentHeight*.4 
	car.wheel2.x, car.wheel2.y = car.body.x + car.body.contentWidth*.4, car.body.y + car.body.contentHeight*.4 


	--[[
	car.head = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Head"), 0, -car.body.contentHeight/2  )
	car.wheel1 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel"), -car.body.contentWidth/2, car.body.contentHeight/2  )
	car.wheel2 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel2"), car.body.contentWidth/2, car.body.contentHeight/2  )

	]]


	return car 


end 

local function makeChar ()

	local sheetOptions = require("assets.chars.templerun")

	local sequenceData = {

		{name="dead", start =1, count= 10, time=1000, loopCount=1},
		{name="idle", start =11, count= 10, time=1000, loopCount=0},
		{name="jump", start =21, count= 10, time=1000, loopCount=1},
		{name="run", start =31, count= 10, time=1000, loopCount=0}
	}


	local sheet = graphics.newImageSheet("assets/chars/templerun.png", sheetOptions:getSheet()) 

	-- print(sheet)

	local sprite = display.newSprite(sheet, sequenceData)

	sprite.x = halfW 
	sprite.y = halfH
	sprite.xScale = 0.35 
	sprite.yScale = 0.35 
	
	sprite.startY = sprite.y 
	sprite.startX = sprite.x

	sprite:setSequence("idle")


	local function listener(event)
		--print("---------------")
		--for k,v in pairs(event) do 
		--	print(k..":"..tostring(v))
		--end 

		--if (event.phase == "loop") then 
		--	event.target:pause()
		--end 
		
	end 

	--sprite.jumpCount = 0 
	
	function sprite:jump()
	    --sprite.jumpCount = sprite.jumpCount + 1 
		--self.isJumping = true 
		--if (sprite.jumpCount > 2) then 
		--	return 
		--end 
		self:setSequence("jump")
		self:play()
		self:applyLinearImpulse(0, -1.5, 0,0)
	end 

	function sprite:run(right)
	    --sprite.jumpCount = sprite.jumpCount + 1 
		--self.isJumping = true 
		--if (sprite.jumpCount > 2) then 
		--	return 
		--end 
		local mult = 1
		if (not right) then 
			mult = -1 
		end 
		
		self:setSequence("run")
		self:play()
		self:applyLinearImpulse(mult*0.1, 0, 0,0)
	end 

	function sprite:key(event)

		print("---------------")
		for k,v in pairs(event) do 
			print(k..":"..tostring(v))
		end 
		
		if (event.keyName == "space") and (event.phase == "up") then 
			self:jump()
		end 

		if (event.keyName == "left") and (event.phase == "down") then 
			self:run(false)
		end 
		if (event.keyName == "right") and (event.phase == "down") then 
			self:run(true)
		end 
		
	end 
	
	Runtime:addEventListener("key", sprite)
	sprite:setSequence("idle")
	sprite:play()	
	return sprite
	
end 





function scene:create(event)

	physics.start()
	
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
		
		
		if (i == 1 ) then 
			local f = display.newRect(img.x, screenH*0.9, screenW, screenH*0.22)
			f.alpha = 0 
			physics.addBody(f, "static", {bounce = 0})
		end 

	end 
	
	--local platform = display.newRect(halfW, halfH, screenW*0.3, 40)
	--physics.addBody(platform, "static")
	
	local car = makeCar()
	
	--local char = makeChar()
	--physics.addBody(char, "dynamic", {bounce = 0, box = {halfWidth = .35*char.contentWidth, halfHeight = .5*char.contentHeight}})
	--char.isFixedRotation = true 
end 

--[[
local function loadJson(path, directory)

	directory = directory or system.DocumentsDirectory
	print(directory)
	print(path)
	local realPath = system.pathForFile(path, directory)
	if not realPath then 
		error("no such file : "..path)
	end 
	
	local file, err = io.open(realPath, "r") -- "w"
	
	if not file then 
		error(err)
	else 
		local data = file:read("*a")

		if (data) then 
			return json.decode(data)
		end 
	end 


end
]]


	
function scene:show(event)
	if (event.phase == "will") then 
	
		--[[
		local data = table.load("assets/particles/spark.json", system.ResourceDirectory)
		if (data) then 
			for k,v in pairs(data) do 
				print(" data."..k..":"..v)
		end 
			local emitter = display.newEmitter(data, system.ResourceDirectory) 
			emitter.x = halfW 
			emitter.y = halfH 
			emitter.alpha = 0.2
			transition.to(emitter, {delay= 1000, time=1000, y = 100})
		else 
			error("no data returned")
		end 
		]]
	
	
	
	
	end 

end 

	
scene:addEventListener("create", scene )

scene:addEventListener("show", scene )
scene:addEventListener("hide", scene )


return scene 
 






	