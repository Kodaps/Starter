


local sky = display.newRect(halfW, halfH, screenW, screenH)

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

while (bg.width < screenW*2 - 200) do
  local sq = display.newRect(0,0,math.random(100,250), math.random(h1,h2))
  sq.x = bg.width + sq.width/2
  sq.y = screenH*0.85-sq.height/2
  sq:setFillColor(0.2+math.random(10)/20)
  bg:insert(sq)
end

floor = display.newRect(game, halfW,screenH*0.90, screenW*2, screenH*0.2)
floor:setFillColor(0.7)

--while(fore.width < screenW*2) do
--
--end
