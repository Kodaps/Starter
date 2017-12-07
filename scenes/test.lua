
local composer = require( "composer" )
local physics = require("physics")

local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
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


    function sprite:enterFrame(event)

        --print("---------------")
        --for k,v in pairs(event) do 
        --  print(k..":"..tostring(v))
        --end 

        --if (event.phase == "loop") then 
        --  event.target:pause()
        --end 
        if (math.abs(self.fx or 0) > 0) or (math.abs(self.fy or 0) > 0) then  
            self:applyForce(self.fx, self,fy, self.x, self.y)
        end 

    end 

    --sprite.jumpCount = 0 
    
    function sprite:jump()
        --sprite.jumpCount = sprite.jumpCount + 1 
        --self.isJumping = true 
        --if (sprite.jumpCount > 2) then 
        --  return 
        --end 
        self:setSequence("jump")
        self:play()
        self:applyLinearImpulse(0, -2.5, self.x,self.y)
    end 

    function sprite:run(right, on)
        --sprite.jumpCount = sprite.jumpCount + 1 
        --self.isJumping = true 
        --if (sprite.jumpCount > 2) then 
        --  return 
        --end 
        local mult = 1
        if (not right) then 
            mult = -1 
        end 

        if (on == false) then 
            mult = 0 
        end 

        self.fy = 0 
        self.fx = mult


        
        self.xScale = mult*math.abs(self.xScale) 


        
        self:setSequence("run")
        self:play()

    end 

    function sprite:key(event)

        print("---------------")
        for k,v in pairs(event) do 
            print(k..":"..tostring(v))
        end 
        
        if (event.keyName == "space") and (event.phase == "up") then 
            self:jump()
        end 

        if (event.keyName == "left") then 
            self:run(false, (event.phase == "down"))
        end 

        if (event.keyName == "right") and (event.phase == "down") then 
            self:run(true, (event.phase == "down"))
        end 
        
    end 
    

    Runtime:addEventListener("enterFrame", sprite)
    Runtime:addEventListener("key", sprite)
    sprite:setSequence("idle")
    sprite:play()   
    return sprite
    
end 
 
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        print("in test")
        physics.start(false) -- true  : disables sleep mode which allows to change gravity dynamically 
        physics.setDrawMode("hybrid")

        physics.setGravity(0, 9.8)

        local height = 20
        local floor = display.newRect(halfW, screenH - height, screenW, height )
        floor:setFillColor(1)


        physics.addBody(floor, "static") -- "dynamic", "kinematic"


        local function createCrate()
            local img = display.newImage("assets/physics/crate.png", screenW*0.25 + math.random(halfW), 100)
            physics.addBody(img)
        end 

        local function createBall(event)
            local img = display.newImage("assets/physics/coconut.png", event.x, event.y)
            physics.addBody(img, "dynamic", {radius = img.width/2})
        end 

        Runtime:addEventListener("tap", createBall)

        local char = makeChar()
        physics.addBody(char, "dynamic", {box = {
            halfWidth = char.contentWidth/2, 
            halfHeight = char.contentHeight/2, 
            x=0, 
            y=0
        }})

        char.isFixedRotation = true

        -- char.isAwake 
        -- char.isSleepingAllowed 
        -- char.gravityScale 
        -- angularVelocity 

        -- char.angularDamping = 10
        -- char.linearDamping = 10 

        -- char.angularVelocity = 10

        -- vx,vy = char:getLinearVelocity()
        -- char:setLinearVelocity(vx,vy)

        -- char:applyTorque(t)
        -- char:applyAngularImpulse(t)


        -- char:resetMassData()



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