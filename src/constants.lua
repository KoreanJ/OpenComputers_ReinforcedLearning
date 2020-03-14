-- constants.lua
-- All of the constants used in this project

-- Module to be returned
local M = {}
M.ADDR = "aae550e7-28b1-4e87-8c63-79b36110b4f2"
M.PORT = 1000
M.COLS = 5
M.ROWS = 4
M.CONV_ITERATIONS = 1
M.NUM_ITERATIONS = 100.0
M.START_POS = {0, 3}
M.INDECES = {["nether"] = 1, ["acacia"] = 2, ["ice"] = 3, ["diamond"] = 4}
M.MOVES = {'up', 'down', 'left', 'right'}
M.MASTER_PROBS = {
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
M.NUM_STATES = 20
M.POS_STATES = {
    [0] = {
        [0] = 1,
        [1] = 8,
        [2] = 9,
        [3] = 16,
        [4] = 17
    },
    [1] = {
        [0] = 2,
        [1] = 7,
        [2] = 10,
        [3] = 15,
        [4] = 18
    },
    [2] = {
        [0] = 3,
        [1] = 6,
        [2] = 11,
        [3] = 14,
        [4] = 19
    },
    [3] = {
        [0] = 4, 
        [1] = 5,
        [2] = 12,
        [3] = 13,
        [4] = 20
    }
}
M.TRAN_PROBS = {
    ['up'] = {},
    ['down'] = {},
    ['left'] = {},
    ['right'] = {}
}

-- Initialize probs as 0 for robot to estimate
for r=1,M.NUM_STATES
do
    M.TRAN_PROBS['up'][r] = {}
    M.TRAN_PROBS['down'][r] = {}
    M.TRAN_PROBS['left'][r] = {}
    M.TRAN_PROBS['right'][r] = {}

    for c=1,M.NUM_STATES
    do
        M.TRAN_PROBS['up'][r][c] = 0.0
        M.TRAN_PROBS['down'][r][c] = 0.0
        M.TRAN_PROBS['left'][r][c] = 0.0
        M.TRAN_PROBS['right'][r][c] = 0.0
    end
end
M.VALUES = {}

-- Initialize all values to 0
for i=1,M.NUM_STATES
do
    M.VALUES[i] = 0.0
end

M.REWARDS = {
    [1] = -0.05,
    [2] = -1.0,
    [3] = -0.25,
    [4] = -0.05,
    [5] = -0.05,
    [6] = -0.05,
    [7] = -0.05,
    [8] = -0.05,
    [9] = -0.25,
    [10] = -0.05,
    [11] = -1.0,
    [12] = -0.25,
    [13] = -0.05,
    [14] = -1.0,
    [15] = -0.05,
    [16] = -0.05,
    [17] = -0.05,
    [18] = 2,
    [19] = -0.05,
    [20] = -0.05
}
M.GAMMA = 0.99

return M