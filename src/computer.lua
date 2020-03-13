-- Main program for sending commands
function send_msg(msg)
    modem.send(ADDR, PORT, msg)
end

--------------------------------------------------------------------

computer = require("computer")
component = require("component")
event = require("event")
modem = component.modem

ADDR = "aaba1e7a-8072-4348-86bd-57c406c55268"
PORT = 1000

modem.open(PORT)
received = false


-- Establish connection with computer
setup_complete = false
print('Establishing connection with robot...')
while not setup_complete do
    local _, _, from, port, _, message = event.pull("modem_message")
    if port == PORT and tostring(message) == "Houston do you copy?" 
    then
        print("Message received")
        send_msg("Loud and clear")
        print("Done. Connection successfully established!")
        setup_complete = true
    end
end

-- -- Make robot move back 2 blocks
-- send_msg("back 2")

-- -- Terminate robot at end of program
-- os.sleep(5)
-- send_msg("TERMINATE")


