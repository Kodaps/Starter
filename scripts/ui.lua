local ui = {}







function ui:makeTextButton(options)

	options = options or {} 
	
	local width = options.width or 300 
	local height = options.height or 30 
	local radius = options.radius or 10 
	local colors = options.colors or {0.5, 0.5, 0.5}
	
	local sound = options.sound --"asset/click.wav"
	
	local handle 
	local channel 
	if (sound) then 
		handle = audio.loadSound(sound) -- audio.loadStream("AllumezleFeu.mp3")
	
		audio.getDuration(handle)

		local function listener(event)
		end 
		
		local opts = {
			channel = 1, 
			fadein = 300, 
			onComplete = listener 
		}
		
		channel = audio.play(handle, opts)
		-- audio.pause(channel)
	end 
	
	
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
	
	grp.textField = txt 
	
	function grp:tap(event)

		print("params", self.params)
	
		if (self.callback) then 
			self.callback(self.params)
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