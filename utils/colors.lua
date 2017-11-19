-- colors.lua
local colors = table.load('assets/ui/colors.json', system.ResourceDirectory)

local memo = {}
print(colors)
colors.base = "blue"

function colors.get(name, key)

  name = name or colors.base or "blue"
  key = key or "500"

  if memo[name..":"..key] then
    return unpack(memo[name..":"..key])
  end

  local coltable = colors[name] or {}
  local col = coltable[key] or "#FF0000"

  r = tonumber(col:sub(2,3),16)/255
  g = tonumber(col:sub(4,5),16)/255
  b = tonumber(col:sub(6,7),16)/255

  memo[name..":"..key] = {r,g,b}

  return unpack({r,g,b})

end


return colors
