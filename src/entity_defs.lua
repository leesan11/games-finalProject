--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.155,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['idle-left'] = {
                frames = {13},
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {5},
                texture = 'character-walk'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'character-walk'
            },
            ['idle-up'] = {
                frames = {9},
                texture = 'character-walk'
            },
            ['sword-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-up'] = {
                frames = {5, 6, 7, 8},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['pot-pick-up'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                looping = false,
                texture = 'pot-pick'
            },
            ['pot-pick-down'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                looping = false,
                texture = 'pot-pick'
            },
            ['pot-pick-left'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                looping = false,
                texture = 'pot-pick'
            },
            ['pot-pick-right'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                looping = false,
                texture = 'pot-pick'
            },
            ['pot-idle-down'] = {
                frames = {1},
                texture = 'pot-walk'
            },
            ['pot-idle-up'] = {
                frames = {9},
                texture = 'pot-walk'
            },
            ['pot-idle-left'] = {
                frames = {13},
                texture = 'pot-walk'
            },
            ['pot-idle-right'] = {
                frames = {5},
                texture = 'pot-walk'
            },
            ['pot-walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.155,
                texture = 'pot-walk'
            },
            ['pot-walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                texture = 'pot-walk'
            },
            ['pot-walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'pot-walk'
            },
            ['pot-walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                texture = 'pot-walk'
            }
        }
    },
    ['skeleton'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {22, 23, 24, 23},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {34, 35, 36, 35},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {10, 11, 12, 11},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {46, 47, 48, 47},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {23}
            },
            ['idle-right'] = {
                frames = {35}
            },
            ['idle-down'] = {
                frames = {11}
            },
            ['idle-up'] = {
                frames = {47}
            }
        }
    },
    ['slime'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {61, 62, 63, 62},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {73, 74, 75, 74},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {49, 50, 51, 50},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {86, 86, 87, 86},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {62}
            },
            ['idle-right'] = {
                frames = {74}
            },
            ['idle-down'] = {
                frames = {50}
            },
            ['idle-up'] = {
                frames = {86}
            }
        }
    },
    ['bat'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {64, 65, 66, 65},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {76, 77, 78, 77},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {52, 53, 54, 53},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {88, 89, 90, 89},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {64, 65, 66, 65},
                interval = 0.2
            },
            ['idle-right'] = {
                frames = {76, 77, 78, 77},
                interval = 0.2
            },
            ['idle-down'] = {
                frames = {52, 53, 54, 53},
                interval = 0.2
            },
            ['idle-up'] = {
                frames = {88, 89, 90, 89},
                interval = 0.2
            }
        }
    },
    ['ghost'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {67, 68, 69, 68},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {79, 80, 81, 80},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {55, 56, 57, 56},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {91, 92, 93, 92},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {68}
            },
            ['idle-right'] = {
                frames = {80}
            },
            ['idle-down'] = {
                frames = {56}
            },
            ['idle-up'] = {
                frames = {92}
            }
        }
    },
    ['spider'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {70, 71, 72, 71},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {82, 83, 84, 83},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {58, 59, 60, 59},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {94, 95, 96, 95},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {71}
            },
            ['idle-right'] = {
                frames = {83}
            },
            ['idle-down'] = {
                frames = {59}
            },
            ['idle-up'] = {
                frames = {95}
            }
        }
    },
    ['boss'] = {
        texture = 'boss',
        walkSpeed = 50,
        animations = {
            ['walk-left'] = {
                frames = {5, 6, 7, 8},
                interval = 0.2,
                texture = 'boss'
            },
            ['walk-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                texture = 'boss'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'boss'
            },
            ['walk-up'] = {
                frames = {13, 14, 15, 16},
                interval = 0.2,
                texture = 'boss'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'boss'
            },
            ['idle-right'] = {
                frames = {9},
                texture = 'boss'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'boss'
            },
            ['idle-up'] = {
                frames = {13},
                texture = 'boss'
            }
        }
    },
    ['boss2'] = {
        texture = 'boss2',
        walkSpeed = 50,
        animations = {
            ['walk-left'] = {
                frames = {5, 6, 7, 8},
                interval = 0.2,
                texture = 'boss2'
            },
            ['walk-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                texture = 'boss2'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'boss2'
            },
            ['walk-up'] = {
                frames = {13, 14, 15, 16},
                interval = 0.2,
                texture = 'boss2'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'boss2'
            },
            ['idle-right'] = {
                frames = {9},
                texture = 'boss2'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'boss2'
            },
            ['idle-up'] = {
                frames = {13},
                texture = 'boss2'
            }
        }
    },
    ['boss3'] = {
        texture = 'boss3',
        walkSpeed = 50,
        animations = {
            ['walk-left'] = {
                frames = {5, 6, 7, 8},
                interval = 0.2,
                texture = 'boss3'
            },
            ['walk-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                texture = 'boss3'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'boss3'
            },
            ['walk-up'] = {
                frames = {13, 14, 15, 16},
                interval = 0.2,
                texture = 'boss3'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'boss3'
            },
            ['idle-right'] = {
                frames = {9},
                texture = 'boss3'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'boss3'
            },
            ['idle-up'] = {
                frames = {13},
                texture = 'boss3'
            }
        }
    },
    ['boss4'] = {
        texture = 'boss4',
        walkSpeed = 50,
        animations = {
            ['walk-left'] = {
                frames = {5, 6, 7, 8},
                interval = 0.2,
                texture = 'boss4'
            },
            ['walk-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                texture = 'boss4'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'boss4'
            },
            ['walk-up'] = {
                frames = {13, 14, 15, 16},
                interval = 0.2,
                texture = 'boss4'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'boss4'
            },
            ['idle-right'] = {
                frames = {9},
                texture = 'boss4'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'boss4'
            },
            ['idle-up'] = {
                frames = {13},
                texture = 'boss4'
            }
        }
    }
}