-- Set the robot's index to select a new item
function set_index(idx)
    print("Inside set index function")
    robot.select(idx)
end

-- Figure out what block robot is currently on
function get_current_block(indeces)
    print("Inside get current block function")
    for key,value in pairs(indeces)
    do
        set_index(value)
        if robot.compareDown()
        then
            block = key
            return block
        end
    end

    return 'No block found'
end

-- Find the current state on the game board
function get_state(x, y)
    return (y*COLS)+(ROWS+1)

-- Based on the current block, estimate the probabilities


-- Make a random movement
function random_move()
    did_move = false
    while not did_move
    do
        i = math.random(1,4)
        if i == 1   -- up
        then
            if not robot.detect()
            then
                print('No block in front. Moving forward.')
                robot.forward()
                did_move = true
            end
        elseif i == 2   -- down
        then
            robot.turnAround()
            if not robot.detect()
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnAround()
                did_move = true
            end
        elseif i == 3   -- left
        then
            robot.turnLeft()
            if not robot.detect()
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnRight()
                did_move = true
            end
        elseif i == 4   -- right
        then
            robot.turnRight()
            if not robot.detect()
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnLeft()
                did_move = true
            end
        end


------------------------------------------------------------------------

component = require("component")
event = require("event")
robot = require("robot")
modem = component.modem
methods = require("methods")

-- Constants
ADDR = "aae550e7-28b1-4e87-8c63-79b36110b4f2"
PORT = 1000
COLS = 5
ROWS = 4
N = 20
POS = {0, 3}    -- Starting position

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
-- block_type > move to make > probability of alternate move
-- example: acacia block > move up > probability that move is right instead 
-- of up is 0.15
indeces = {["nether"] = 1, ["acacia"] = 2, ["ice"] = 3, ["diamond"] = 4}
moves = {'up', 'down', 'left', 'right'}
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
    },
    ["nether"] = {
        ['up'] = {
            ['up'] = 0.95,
            ['down'] = 0.05,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 1.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 1.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.1,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.9
        }
    },
    ["ice"] = {
        ['up'] = {
            ['up'] = 0.5,
            ['down'] = 0.0,
            ['left'] = 0.25,
            ['right'] = 0.25
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.98,
            ['left'] = 0.02,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.8,
            ['down'] = 0.0,
            ['left'] = 0.2,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.9,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.1
        }
    },
    ["diamond"] = {
        ['up'] = {
            ['up'] = 1.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 1.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 1.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 1.0
        }
    }
}
est_probs = {
    ["acacia"] = {
        ['up'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        }
    },
    ["nether"] = {
        ['up'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        }
    },
    ["ice"] = {
        ['up'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        }
    },
    ["diamond"] = {
        ['up'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['down'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['left'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        ['right'] = {
            ['up'] = 0.0,
            ['down'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0
        }
    }
}
explored = {
    ['nether_up'] = false,
    ['nether_down'] = false,
    ['nether_left'] = false,
    ['nether_right'] = false,
    ['acacia_up'] = false,
    ['acacia_down'] = false,
    ['acacia_left'] = false,
    ['acacia_right'] = false,
    ['ice_up'] = false,
    ['ice_down'] = false,
    ['ice_left'] = false,
    ['ice_right'] = false,
    ['diamond_up'] = false,
    ['diamond_down'] = false,
    ['diamond_left'] = false,
    ['diamond_right'] = false
}
-- While not explored all types of blocks, keep exploring

for i=1,5
do
    found_new = false
    curr_block = methods.get_current_block(indeces)

    -- For each move, estimate probability (if not already estimated)
    for m in moves
    do
        key = curr_block .. '_' .. m
        if not explored[key]
        then
            found_new = true
            print('Estimate new probability: ' .. tostring(key))
            --estimate_probs(key, est_probs, N)
        end
    end

    -- Make random move to next block
    methods.random_move()
end


-- Loop through possible moves
-- For each move, calculate whether proper move is made
-- Record total correct

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