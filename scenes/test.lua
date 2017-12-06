
local composer = require( "composer" )
 
local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
local count = 0 
local _shown = false  
local _loaded = false 


local function checkGo()

	if (not _loaded) or (not _shown) then 
		return 
	end 
	-- local currentName = "img"..count..".jpg"
	print("go go go")
end 


local function newGame(event)
	_loaded = true 
	checkGo()
	event.target.alpha = 0.2
end 

local function prepare()
	count = count + 1
	local url = "https://picsum.photos/800/600" -- https://loremflickr.com/800/600	
	local name = "img"..count..".jpg"
	display.loadRemoteImage( url, "GET", newGame, name, system.DocumentsDirectory)
end 
 
function scene:show( event )
 
    local sceneGroup = self.view
	
    local phase = event.phase
 
    if ( phase == "will" ) then
		prepare()
	elseif ( phase == "did" ) then
		_shown = true
		checkGo()
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