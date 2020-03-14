-- Import modules
component = require("component")
event = require("event")
robot = require("robot")
modem = component.modem

-- Custom modules
constants = require("constants")
F = require("functions")
B = require("bellman")

-- Open modem port to send/receive messages
modem.open(constants.PORT)

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

-- Estimated transition probabilities empirically
pos = {['r'] = 0, ['c'] = 0, ['state'] = 1}
tran_probs = constants.TRAN_PROBS
for i=1,constants.NUM_STATES
do
    -- Get the current block underneath
    curr_block = F.get_current_block(constants.INDECES)
    s = constants.POS_STATES[pos['r']][pos['c']]

    -- DEBUG
    print('Pos = {' .. tostring(pos['r']) .. ',' .. tostring(pos['c']) .. '}' .. ' | State = ' .. tostring(s))
    
    -- For each move, estimate probability (if not already estimated)
    for i,m in pairs(constants.MOVES)
    do
        key = curr_block .. '_' .. m

        -- Get estimated probability for this move
        --print('Finding prob for: ' .. tostring(key))
        probs = F.estimate_probability(curr_block, m)
        
        -- Update transition probabilities based on estimated probabilities
        for mv,p in pairs(probs)
        do
            if mv == 'up'
            then           
                -- If move is even possible, record it in tran prob
                if (pos['c'] % 2 == 0) and (pos['r']+1) < constants.ROWS
                then
                    s_prime = constants.POS_STATES[pos['r']+1][pos['c']]
                    tran_probs[m][s][s_prime] = probs['up']
                elseif (pos['c'] % 2) ~= 0 and (pos['r']-1) >= 0
                then
                    s_prime = constants.POS_STATES[pos['r']-1][pos['c']]
                    tran_probs[m][s][s_prime] = probs['up']
                end
            elseif mv == 'down'
            then
                -- If move is even possible, record it in tran prob
                if (pos['c'] % 2 == 0) and ((pos['r']-1) >= 0)
                then
                    s_prime = constants.POS_STATES[pos['r']-1][pos['c']]
                    tran_probs[m][s][s_prime] = probs['down']
                elseif (pos['c'] % 2 ~= 0) and (pos['r']+1) < constants.ROWS
                then
                    s_prime = constants.POS_STATES[pos['r']+1][pos['c']]
                    tran_probs[m][s][s_prime] = probs['down']
                end
            elseif mv == 'left'
            then
                -- If move is even possible, record it in tran prob
                if (pos['c'] % 2 == 0) and (pos['c']+1) < constants.COLS
                then
                    s_prime = constants.POS_STATES[pos['r']][pos['c']+1]
                    tran_probs[m][s][s_prime] = probs['left']
                elseif (pos['c'] % 2 ~= 0) and ((pos['c']-1) >= 0)
                then
                    s_prime = constants.POS_STATES[pos['r']][pos['c']-1]
                    tran_probs[m][s][s_prime] = probs['left']
                end
            elseif mv == 'right'
            then
                -- If move is even possible, record it in tran prob
                if (pos['c'] % 2 == 0) and (pos['c']-1) >= 0
                then
                    s_prime = constants.POS_STATES[pos['r']][pos['c']-1]
                    tran_probs[m][s][s_prime] = probs['right']
                elseif (pos['c'] % 2 ~= 0) and (pos['c']+1) < constants.COLS
                then
                    s_prime = constants.POS_STATES[pos['r']][pos['c']+1]
                    tran_probs[m][s][s_prime] = probs['right']
                end
            else
                print('Error in updating transition probabilities')
            end
        end
    end

    -- Move to next state and update position
    blocked = robot.detect()
    if blocked and ((pos['r']+1) >= constants.ROWS)
    then
        robot.turnLeft()
        robot.forward()
        robot.turnLeft()
        pos['c'] = pos['c'] + 1
        pos['state'] = constants.POS_STATES[pos['r']][pos['c']]
    elseif blocked and ((pos['r']-1) < 0)
    then
        robot.turnRight()
        robot.forward()
        robot.turnRight()
        pos['c'] = pos['c'] + 1
        pos['state'] = constants.POS_STATES[pos['r']][pos['c']]
    else
        robot.forward()
        if pos['c'] % 2 == 0
        then
            pos['r'] = pos['r'] + 1
        elseif pos['c'] % 2 ~= 0
        then
            pos['r'] = pos['r'] - 1
        end
        pos['state'] = constants.POS_STATES[pos['r']][pos['c']]
    end

end

-- Run value iteration to compute best policy
os.sleep(2)
best_moves = B.value_iteration()

-- Print best computed states
print('\n=== Final Results ===')
for state,mv in pairs(best_moves)
do
    print('[' .. tostring(state) .. '] = ' .. mv)
    os.sleep(1)
end

print('<END OF PROGRAM>')
