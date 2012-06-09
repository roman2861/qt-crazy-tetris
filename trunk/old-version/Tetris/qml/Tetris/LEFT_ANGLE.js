.pragma library

var maxOrientation = 4
var maxCell = 4
var orients = new Array(maxOrientation)
orients[0] = [
            {
                "x": 0,
                "y":  0
            },
            {
                "x": 0,
                "y": 1
            },
            {
                "x":  1,
                "y":  0
            },
            {
                "x": 2,
                "y": 0
            },
        ];
orients[1] = [
            {
                "x": 0,
                "y":  0
            },
            {
                "x": -1,
                "y": 0
            },
            {
                "x":  0,
                "y":  1
            },
            {
                "x": 0,
                "y": 2
            },
        ];
orients[2] = [
            {
                "x": 0,
                "y":  0
            },
            {
                "x": 0,
                "y": 1
            },
            {
                "x":  -2,
                "y":  1
            },
            {
                "x": -1,
                "y": 1
            },
        ];
orients[3] = [
            {
                "x":  0,
                "y":  0
            },
            {
                "x": 0,
                "y": 1
            },
            {
                "x": 0,
                "y":  2
            },
            {
                "x": 1,
                "y": 2
            },
        ];

