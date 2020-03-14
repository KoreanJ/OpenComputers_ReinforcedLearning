-- bellman.lua
-- Main program for running value iteration using estimated transition probabilities computed in Minecraft

constants = require("constants")
robot = require("robot")
F = require("functions")

local M = {}

local function get_s_prime(pos, state, mv)
    if mv == 'up'
    then           
        if (pos['c'] % 2 == 0) and (pos['r']+1) < constants.ROWS
        then
            s_prime = constants.POS_STATES[pos['r']+1][pos['c']]
        elseif (pos['c'] % 2) ~= 0 and (pos['r']-1) >= 0
        then
            s_prime = constants.POS_STATES[pos['r']-1][pos['c']]
        end
    elseif mv == 'down'
    then
        if (pos['c'] % 2 == 0) and ((pos['r']-1) >= 0)
        then
            s_prime = constants.POS_STATES[pos['r']-1][pos['c']]
        elseif (pos['c'] % 2 ~= 0) and (pos['r']+1) < constants.ROWS
        then
            s_prime = constants.POS_STATES[pos['r']+1][pos['c']]
        end
    elseif mv == 'left'
    then
        if (pos['c'] % 2 == 0) and (pos['c']+1) < constants.COLS
        then
            s_prime = constants.POS_STATES[pos['r']][pos['c']+1]
        elseif (pos['c'] % 2 ~= 0) and ((pos['c']-1) >= 0)
        then
            s_prime = constants.POS_STATES[pos['r']][pos['c']-1]
        end
    elseif mv == 'right'
    then
        if (pos['c'] % 2 == 0) and (pos['c']-1) >= 0
        then
            s_prime = constants.POS_STATES[pos['r']][pos['c']-1]
        elseif (pos['c'] % 2 ~= 0) and (pos['c']+1) < constants.COLS
        then
            s_prime = constants.POS_STATES[pos['r']][pos['c']+1]
        end
    else
        print('Error in computing s_prime')
    end

    return s_prime
end 

local function go_home()
    robot.turnLeft()
    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()
    robot.turnLeft()
    robot.back()
    robot.back()
    robot.back()
end

function M.value_iteration()
    go_home()

    -- Variables
    pos = {['r'] = 0, ['c'] = 0, ['state'] = 1}
    best_moves = {}
    values = constants.VALUES
    rewards = constants.REWARDS
    tran_probs = constants.TRAN_PROBS

    for state=1,constants.NUM_STATES
    do
        -- get possible actions
        valid_moves = F.get_moves()
        max_move = ''
        max_value = -9999

        -- Loop through each intended move
        for i,mv in pairs(valid_moves)
        do
            print('Intended Move: ' .. mv)

            -- Get expected value
            exp_val = 0
            for i1,mv1 in pairs(valid_moves)
            do
                s_p = get_s_prime(pos, state, mv1)
                print('s = ' .. tostring(state))
                print('s_prime = ' .. tostring(s_p))
                print(tran_probs[mv][state][s_p])
                exp_val = exp_val + (values[s_p]*tran_probs[mv][state][s_p])
            end

            -- Compute value for this intended move
            value = rewards[state] + (constants.GAMMA*exp_val)

            -- See if this intended move maximizes the total value
            if value > max_value
            then
                max_value = value
                max_move = mv
            end
        end

        -- Using maximum value/move, update current state
        values[state] = max_value
        best_moves[state] = max_move

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

    return best_moves
end

-- Send robot back to starting position
go_home()

return M