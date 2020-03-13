-- Set the robot's index to select a new item
function set_index(idx)
    robot.select(idx)
end


------------------------------------------------------------------------

component = require("component")
event = require("event")
robot = require("robot")
modem = component.modem

-- Constants
ADDR = "aae550e7-28b1-4e87-8c63-79b36110b4f2"
PORT = 1000

-- Open modem port to send/receive messages
modem.open(PORT)

-- Establish connection with computer
setup_complete = false
while not setup_complete do
    modem.send(ADDR, PORT, "Houston do you copy?")
    local _, _, from, port, _, message = event.pull(5, "modem_message")
    if port == PORT and tostring(message) == "Loud and clear" then
        print("Done. Connection successfully established!")
        setup_complete = true
    end
end

-- === Run program to find best probs === --

-- Constants used by robot
indeces = {["nether"] = 1, ["acacia"] = 2, ["ice"] = 3, ["diamond"] = 4}
master_probs = {
    ["acacia"] = {
        ['up'] = {
            ['up'] = 0.8,
            ['down'] = 0.05,
            ['left'] = 0.0,
            ['right'] = 0.15
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.95,
            ['left'] = 0.05,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.5,
            ['down'] = 0.0,
            ['left'] = 0.5,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.05,
            ['down'] = 0.75,
            ['left'] = 0.2,
            ['right'] = 0.0
        }
    }
}

for i=1






out = robot.detectDown()
print("Block: " .. tostring(out[0]) .. ", Details: " .. out[1])

-- -- Run robot until TERMINATE command is passed
-- done = false
-- while not done 
-- do
--     local _, _, from, port, _, message = event.pull(1, "modem_message")
--     if port == PORT 
--     then

--         -- Terminate program if command is sent
--         if message == "TERMINATE" 
--         then
--             done = true
--         end

--         -- If not, then process the sent command
--         msg = split(tostring(message), " ")
--         if msg[0] == "back" 
--         then
--             for i=1,msg[1] 
--             do
--                 robot.move(2)
--             end
--         end
--     end
--     os.sleep(1)
-- end

-- print("[Program Terminated]")