
require("constants")
require("utils")

local pprint = require('utils.pprint')

table.print = pprint 

-- programme hello world basique
local options =
{
	text = "Coucou !",
	x = halfW,
	y = halfH,
	fontSize = 50
}

local textobject = display.newText(options)

local colors = table.loadJson("assets/ui/colors.json", system.ResourceDirectory)

for k,v in pairs(colors) do 
	print(k..":"..tostring(v))
end

table.print(colors)

