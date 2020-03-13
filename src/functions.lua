-- Import modules
robot = require("robot")
constants = require("constants")

-- Module reference to be returned
local M = {}

-- Set the robot's index to select a new item
function M.set_index(idx)
    print("Set inventory to index " .. tostring(idx))
    robot.select(idx)
end

-- Figure out what block robot is currently on
function M.get_current_block(indeces)
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
function M.get_state(x, y)
    return (y*constants.COLS)+(constants.ROWS+1)

-- Based on the current block, estimate the probabilities


-- Make a random movement
function M.random_move()
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