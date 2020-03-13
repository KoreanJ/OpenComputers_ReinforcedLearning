local component = require("component")
local event = require("event")
local robot = component.robot
local modem = component.modem

-- Constants
ADDR = "aae550e7-28b1-4e87-8c63-79b36110b4f2"
PORT = 1000

-- Open modem port to send/receive messages
modem.open(PORT)

-- Establish connection with computer
setup_complete = false
print('Establishing connection with computer...')
while not setup_complete do
    modem.send(ADDR, PORT, "Houston do you copy?")
    os.sleep(2)
    local _, _, from, port, _, message = event.pull("modem_message")
    if port == PORT and tostring(message) == "Loud and clear" then
        print("Done. Connection successfully established!")
        setup_complete = true
    end
end

-- Run robot until TERMINATE command is passed
done = false
while not done 
do
    local _, _, from, port, _, message = event.pull(1, "modem_message")
    if port == PORT 
    then

        -- Terminate program if command is sent
        if message == "TERMINATE" 
        then
            done = true
        end

        -- If not, then process the sent command
        msg = split(tostring(message), " ")
        if msg[0] == "back" 
        then
            for i=1,msg[1] 
            do
                robot.move(2)
            end
        end
    end
    os.sleep(1)
end

print("[Program Terminated]")