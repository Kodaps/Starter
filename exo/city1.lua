

local height = screenH*.75
local sky = display.newRect(halfW, height/2, screenW, height)

sky.fill =  {
    type = "gradient",
    color1 = { 0,0,1 },
    color2 = { 1,1,1 },
    direction = "down"
}

local bg = display.newGroup()

local game = display.newGroup()

local fore = display.newGroup()


local start = y
local h1 = screenH*0.05
local h2 = screenH*0.75

local x = 0
while (bg.width < screenW*2 - 200) do
  local w = 200 --math.random(100,150)
  local h =  150 -- math.random(100,150)
  local shadow = display.newRect(bg, 0,0,w, h)
  shadow:setFillColor(0.3)
  shadow.alpha = 0.1

  local sq = display.newRect(bg, 0,0,w, h)
  sq.x = x + sq.width/2 + math.random(20,30)
  sq.y = screenH*.25+math.random(50)

  shadow.x = sq.x + 25
  shadow.y = sq.y + 25

  x = sq.x + sq.width/2
  sq:setFillColor(1)
  sq:setStrokeColor(0.3,0.3,0.3,0.3)
  sq.strokeWidth = 3

end

x = 0
while (game.width < screenW*2 - 200) do

  local sq = display.newRect(game, 0,0, screenW*.1, screenH*0.3)
  sq:setFillColor(0.2)
  sq.x = x + sq.width/2 + 10
  sq.y = screenH *0.8 - sq.height*.5
  x = sq.x + sq.width/2
end
--[[

floor = display.newRect(game, halfW,screenH*0.90, screenW*2, screenH*0.2)
floor:setFillColor(0.7)

--while(fore.width < screenW*2) do
--
--end
]]
