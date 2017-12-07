local ui = {}


function ui:makeCursor(options)

	local width = options.width or 300 
	local height = options.height or 30

	local pct = options.pct  

	local grp = display.newGroup()

	local cursor = display.newRect(grp, 0,0, 30, height)
	local line = display.newLine(grp, 0,0,width,0)
	line.strokeWidth = 3

	cursor.onUpdate = options.onUpdate 

	cursor.xStart = cursor.x 
	
	function cursor:touch(event)
	
		--for k,v in pairs(event) do 
		--	print(k..":"..tostring(v))
		--end 
	
		if (event.phase == "began") then 
			self.xStart = self.x 
		end 

		if (event.phase == "moved") then 
			self.x = self.xStart + event.x - event.xStart
			
			if (self.x < 0) then 
				self.x = 0 
			end 
			
			if (self.x > width) then 
				self.x = width
			end 
			
			self.onUpdate( self.x / self.width )
		
		end 
	
	end 
	
	cursor:addEventListener("touch", touch)
	
	return grp

end 




function ui:makeTextButton(options)

	options = options or {} 
	
	local width = options.width or 300 
	local height = options.height or 30 
	local radius = options.radius or 10 
	local colors = options.colors or {0.5, 0.5, 0.5}
	
	local sound = options.sound --"asset/click.wav"
	
	local handle 
	local channel 
		
	local grp = display.newGroup()
	grp.data = options

	if (sound) then 
		grp.handle = audio.loadSound(sound) -- audio.loadStream("AllumezleFeu.mp3")	
	end 

	
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
		font = customFont  
	}
	
	rect:setFillColor(unpack(colors))
	local txt = display.newText(opt)

	grp.textField = txt 
	
	function grp:tap(event)

		if (self.handle) then 
			audio.play(self.handle)
		end 
	
		if (self.data.callback) then 			
			self.data.callback(self.data.params)
		end 
		
		if (self.data.scene) then
			local composer = require("composer")
			composer.gotoScene(self.data.scene)		
		end 
	end 
	
	grp:addEventListener("tap", grp)

	function grp:setText(txt)
		self.textField.text = txt 
	end 
	
	
	return grp 
	
	-- width 
	-- height 
	-- text 
	-- onClick 
end 


return ui 