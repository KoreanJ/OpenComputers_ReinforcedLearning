-- Import modules
component = require("component")
event = require("event")
robot = require("robot")
modem = component.modem

-- Custom modules
constants = require("constants")
F = require("functions")

-- Open modem port to send/receive messages
modem.open(constants.PORT)

-- Establish connection with computer
setup_complete = true
while not setup_complete do
    modem.send(constants.ADDR, constants.PORT, "Houston do you copy?")
    local _, _, from, port, _, message = event.pull(5, "modem_message")
    if port == constants.PORT and tostring(message) == "Loud and clear" 
    then
        print("Done. Connection successfully established!")
        setup_complete = true
    end
end

-- Variables to find/update
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
explored_blocks = {
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

-- Explore all blocks and their possible moves
for i=1,5
do
    found_new = false
    curr_block = F.get_current_block(constants.INDECES)

    -- For each move, estimate probability (if not already estimated)
    for i,m in pairs(constants.MOVES)
    do
        key = curr_block .. '_' .. m
        if not explored_blocks[key]
        then
            found_new = true
            print('Finding prob for: ' .. tostring(key))
            explored_blocks[key] = true
            probs = F.estimate_probability(curr_block, m)
        end

        -- Using estimated probabilities, update the current probabilities
        for i,v in pairs(probs)
        do
            est_probs[curr_block][m][i] = v
        end
    end

    -- Make random move to next block
    F.random_move()
end

print(est_probs['acacia']['up']['up'])
print(est_probs['acacia']['up']['down'])
print(est_probs['acacia']['up']['left'])
print(est_probs['acacia']['up']['right'])

-- -- Print out estimated probs
-- for block,_ in pairs(est_probs)
-- do
--     --print(block)
--     for m,_ in pairs(est_probs[block])
--     do
--         --print("\t" .. m)
--         for m2,p in pairs(est_probs[block][m])
--         do
--             print("\t\t" .. m2 .. "->" .. tostring(p))
--         end
--     end
-- end
