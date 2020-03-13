-- constants.lua
-- All of the constants used in this project

-- Module to be returned
local M = {}
M.ADDR = "aae550e7-28b1-4e87-8c63-79b36110b4f2"
M.PORT = 1000
M.COLS = 5
M.ROWS = 4
M.NUM_ITERATIONS = 20
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

return M