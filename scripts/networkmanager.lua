--network manager 

local networkManager = {}


function networkManager.get(url, callback, error_callback) 

	local function listener(event) 

		table.print(event)

		if (event.phase == "ended") then 

			if (event.status < 300 ) then 
				print("in networkmanager ", event.response)
				
				if (callback) then 
					callback(event.reponse)
				end 

			else
				print("There was an error")
				-- error_callback()
			end 
		end 

	end 


	network.request(url, "GET", listener)

end 


return networkManager