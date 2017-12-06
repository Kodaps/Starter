
local loc = {}

loc.en = {
	appName = "Funky Game", 
	play = "play",
	settings = "settings"
}


local lang_mt = {
	__index = loc.en  
}

loc.fr = {
	appName = "Le Super Jeu", 
	play = "jouer",
}

setmetatable(loc.fr, lang_mt)

loc.language = "en"

function loc:setLanguage(loc) 
	self.language = loc 
end 


function loc:getText(_loc) 
	return self[self.language][_loc] or "&".._loc 
end 


loc.mt = {
	__call = function(table,key)
		return table:getText(key)
	end,
	
	__newindex = function(table, key, value ) 
		print(" you are writing index "..key)
		-- table[key] = value 
	end 
	
}

setmetatable(loc, loc.mt)



return loc 
