
require("constants")
require("utils")

-- programme hello world basique
local options =
{
	text = "Coucou !",
	x = halfW,
	y = halfH,
	fontSize = 50
}

local textobject = display.newText(options)