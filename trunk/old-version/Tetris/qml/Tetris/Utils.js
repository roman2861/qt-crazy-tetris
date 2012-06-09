/***********************************


**********************************/

function getX(point, type, orientaion){
    switch(type)
    {
    case Constant.SQUARE_FIGURE:
        return SQUARE.orients[orientaion][point].x;
    case Constant.LINE_FIGURE:
        return LINE.orients[orientaion][point].x;
    case Constant.CELL_FIGURE:
        return CELL.orients[orientaion][point].x;
    case Constant.TRIANGLE_FIGURE:
        return TRIANGLE.orients[orientaion][point].x;
    case Constant.S_FIGURE:
        return S_FIGURE.orients[orientaion][point].x;
    case Constant.Z_FIGURE:
        return Z_FIGURE.orients[orientaion][point].x;
    case Constant.RIGHT_ANGLE_FIGURE:
        return RIGHT_ANGLE.orients[orientaion][point].x;
    case Constant.LEFT_ANGLE_FIGURE:
        return LEFT_ANGLE.orients[orientaion][point].x;
    case Constant.PLUS_FIGURE:
        return PLUS_FIGURE.orients[orientaion][point].x;
    default:
        return SQUARE.orients[orientaion][point].x;
    }
}

function getY(point, type, orientaion){
    switch(type)
    {
    case Constant.SQUARE_FIGURE:
        return SQUARE.orients[orientaion][point].y;
    case Constant.LINE_FIGURE:
        return LINE.orients[orientaion][point].y;
    case Constant.CELL_FIGURE:
        return CELL.orients[orientaion][point].y;
    case Constant.TRIANGLE_FIGURE:
        return TRIANGLE.orients[orientaion][point].y;
    case Constant.S_FIGURE:
        return S_FIGURE.orients[orientaion][point].y;
    case Constant.Z_FIGURE:
        return Z_FIGURE.orients[orientaion][point].y;
    case Constant.RIGHT_ANGLE_FIGURE:
        return RIGHT_ANGLE.orients[orientaion][point].y;
    case Constant.LEFT_ANGLE_FIGURE:
        return LEFT_ANGLE.orients[orientaion][point].y;
    case Constant.PLUS_FIGURE:
        return PLUS_FIGURE.orients[orientaion][point].y;
    default:
        return SQUARE.orients[orientaion][point].y;
    }
}

/***********************************
**********************************/
function getMaxCellFromType(type){
    if(type < Constant.MAX_FIGURE && type >= 0){
        return Constant.arrMaxCell[type];
    } else {
        return 4;
    }
}

function getMaxOrientationFromType(type){
    if(type < Constant.MAX_FIGURE && type >= 0){
        return Constant.arrMaxOrientation[type];
    } else {
        return 1;
    }
}

//Index function used instead of a 2D array
function index(column, row) {
    return column + (row * Tetris.maxColumn);
}

function availablePosition(column, row){
    if(column < 0 || column >= Tetris.maxColumn || row < 0 || row >= Tetris.maxRow){
        return false;
    }
    if (Tetris.board[Utils.index(column, row )] != null &&
            Tetris.board[Utils.index(column, row)].type == Constant.CLOCKING_CELL){
        return false;
    }

    return true;
}

function removeFullRow(rowNum){
    for( var i=0; i< Tetris.maxColumn; i++){
        Tetris.board[Utils.index(i, rowNum)].destroy();
        Tetris.board[Utils.index(i, rowNum)] = null;
    }
}

function moveDownAllRow(rowNum, delta){
    for(var i=0; i<Tetris.maxColumn; i++){
        if(Tetris.board[Utils.index(i, rowNum)] != null){
            Utils.createBlock(i, rowNum + delta, Constant.CELL_FIGURE, 0)
            Utils.changeStateOfCells(i, rowNum + delta, Constant.CELL_FIGURE, 0)
            Tetris.board[Utils.index(i, rowNum)].destroy();
            Tetris.board[Utils.index(i, rowNum)] = null;
        }
    }
}

function changeStateOfCells(column, row, type, orientation){
    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
    //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);

        if(Tetris.board[Utils.index(column + x, row + y)] != null){
            Tetris.board[Utils.index(column + x, row + y)].type = Constant.CLOCKING_CELL;
            Tetris.board[Utils.index(column + x, row + y)].cellColor = "red";
        }
    }
    return true;
}

function deleteBlock(column, row, type, orientation){
    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
    //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);
        if(Tetris.board[Utils.index(column + x, row + y)] != null){
            Tetris.board[Utils.index(column + x, row + y)].destroy();
            Tetris.board[Utils.index(column + x, row + y)] = null;
        }
    }
    return true;
}

function createBlock(column, row, type, orientation)
{
    Tetris.originX = column;
    Tetris.originY = row;
    Tetris.typeBlock = type;
    Tetris.orientationBlock = orientation;
    var cell = Qt.createComponent("Cell.qml");
    if(cell.status == Component.Ready){
        var maxCell = Utils.getMaxCellFromType(type);
        for (var point = 0; point < maxCell; point++) {
            var dynamicObject = cell.createObject(gameCanvas);
            if (dynamicObject == null) {
                console.log("error creating block");
                console.log(cell.errorString());
                return false;
            }
            var x = Utils.getX(point, type, orientation);
            var y = Utils.getY(point, type, orientation);
            if(availablePosition(column + x, row + y)){
                dynamicObject.x = (column + x) * Tetris.blockSize;
                dynamicObject.y = (row + y) * Tetris.blockSize;
                dynamicObject.width = Tetris.blockSize;
                dynamicObject.height = Tetris.blockSize;
                dynamicObject.cellColor = Tetris.color;
                dynamicObject.type = Constant.RUNNING_CELL;
                Tetris.board[Utils.index(column + x, row + y)] = dynamicObject;
            }
            console.debug("point: "+ point + " -- (x,y) = ("+ x + " , " + y +
                          " ) -- col = "+column + " -- row = "+row );
        }
    } else {
        console.log("error loading block component");
        console.log(cell.errorString());
        return false;
    }
    return true;
}

function getColorOfCell(){
    return Constant.color[Math.floor(Math.random()*3)];
}

function setIntervalTimer(newTimer){
    screen.intervalTimer = newTimer;
    if(newTimer < 10){
        screen.intervalTimer = 10;
    }
}

