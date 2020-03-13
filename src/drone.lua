local component = require("component")
local event = require("event")
local m = component.modem

-- Open port for listening
m.open(123)
print("Modem is open: " .. tostring(m.isOpen(123)))

-- Send message
m.broadcast(321, "Houston, do you copy")