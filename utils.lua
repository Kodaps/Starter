

function _log(message, emittor)
  emittor = emittor or "NONE"
  print("["..emittor.."]"..tostring(message))
end 
