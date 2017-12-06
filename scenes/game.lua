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
	
	
	
	
	
	end 

end 

	
scene:addEventListener("create", scene )

scene:addEventListener("show", scene )
scene:addEventListener("hide", scene )


return scene 
 






	