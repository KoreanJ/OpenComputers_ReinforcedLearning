-- functions.lua
-- All of the custom functions used in this project

-- Import modules
robot = require("robot")

-- Custom modules
constants = require("constants")

-- MODULE FUNCTIONS --
local M = {}

-- Figure out what block robot is currently on
function M.get_current_block(indeces)
    for key,value in pairs(indeces)
    do
        -- Select inventory item and compare to block below
        robot.select(value)
        if robot.compareDown()
        then
            block = key
            return block
        end
    end

    return 'No block found'
end

-- Find the current state on the game board
function M.get_state(x, y)
    return (y*constants.COLS)+(constants.ROWS+1)
end

-- Make a random movement
function M.random_move()
    did_move = false
    while not did_move
    do
        i = math.random(1,4)
        blocked = robot.detect()
        if i == 1   -- up
        then
            if not blocked
            then
                print('No block in front. Moving forward.')
                robot.forward()
                did_move = true
            end
        elseif i == 2   -- down
        then
            robot.turnAround()
            if not blocked
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnAround()
                did_move = true
            end
        elseif i == 3   -- left
        then
            robot.turnLeft()
            if not blocked
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnRight()
                did_move = true
            end
        elseif i == 4   -- right
        then
            robot.turnRight()
            if not blocked
            then
                print('No block in front. Moving forward')
                robot.forward()
                robot.turnLeft()
                did_move = true
            end
        end
    end
end

-- Given known probabilities, compute the actual move (isn't always necessarily the correct move)
local function get_move(block, move)
    r = math.random(1,100)
    probs = constants.MASTER_PROBS[block][move]
    if r <= (100*probs['up'])
    then
        return 'up'
    elseif r > (100*probs['up']) and r <= (100*(probs['up'] + probs['down']))
    then
        return 'down'
    elseif r > (100*(probs['up'] + probs['down'])) and r <= (100*(probs['up'] + probs['down'] + probs['left']))
    then
        return 'left'
    else
        return 'right'
    end
    return 'Error'
end


-- Make movements and emperically gather whether move correctly occurred
function M.estimate_probability(block, move)

    -- Keep track of counts
    cnts = {
        ['up'] = 0,
        ['down'] = 0,
        ['left'] = 0,
        ['right'] = 0
    }
    for i=1,constants.NUM_ITERATIONS
    do
        actual_move = get_move(block, move)
        cnts[actual_move] = cnts[actual_move] + 1
    end

    -- Convert to probabilities
    for i,v in pairs(cnts)
    do
        cnts[i] = v / constants.NUM_ITERATIONS
    end
    
    return cnts

return M