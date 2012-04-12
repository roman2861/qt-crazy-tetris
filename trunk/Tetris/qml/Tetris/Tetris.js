var blockSize = Constant.BLOCK_SIZE_DEFAULT;
var maxColumn = Constant.MAX_COLUMN_DEFAULT;
var maxRow = Constant.MAX_ROW_DEFAULT;
var maxIndex = maxColumn * maxRow;
var board = new Array(maxIndex);
var originX = Constant.ORIGIN_X_DEFAULT;
var originY = Constant.ORIGIN_Y_DEFAULT;
var typeBlock = Constant.TYPE_FIGURE_DEFAULT;
var orientationBlock = Constant.ORIENTATION_DEFAULT;
var gameState = Constant.GAMEOVER_STATE;
var color = "red"

function startNewGame() {
    //Delete blocks from previous game
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] != null)
            board[i].destroy();
    }
    gameState = Constant.PLAYING_STATE;
    //Calculate board size
    maxColumn = Math.floor(gameCanvas.width / blockSize);
    if(maxColumn > 12){
        maxColumn = 12;
    }
    maxRow = Math.floor(gameCanvas.height / blockSize);
    if(maxRow > 19){
        maxRow = 19;
    }
    maxIndex = maxRow * maxColumn;
    gameCanvas.score = 0;
    nameInputDialog.hide();
//    console.debug("gameBoard width= "+ gameCanvas.width + " -- " + (gameCanvas.width / blockSize) + " -- "+ maxColumn)
//    console.debug("gameBoard height= "+ gameCanvas.height + " -- " + (gameCanvas.height / blockSize) + " -- "+ maxRow)
    //Initialize Board
    board = new Array(maxIndex);
    var newType = Math.floor(Math.random()*Constant.MAX_FIGURE);
    Utils.createBlock( Constant.ORIGIN_X_DEFAULT, Constant.ORIGIN_Y_DEFAULT,
                      newType, Constant.ORIENTATION_DEFAULT);
    timer1.start();
}


/*************************************
            HANDLER
 ***********************************/
function timer1Handler()
{
    if(gameState != Constant.GAMEOVER_STATE){
        console.debug("timer start");
        controllerGame(originX, originY + 1, typeBlock, orientationBlock);
        timer2.start()
    }
}

function timer2Handler(){
    timer1.start();
}

function onKeyHandler(key){
    if(gameState != Constant.GAMEOVER_STATE){
        console.debug("call onKeyHandler");
        var newXOnKeyHandle = originX;
        var newYOnKeyHandle = originY;
        var newOrientOnKeyHandle = orientationBlock;
        switch(key){
        case Constant.KEY_LEFT:
            newXOnKeyHandle = originX - 1;
            break;
        case Constant.KEY_RIGHT:
            newXOnKeyHandle = originX + 1;
            break;
        case Constant.KEY_UP:
            newOrientOnKeyHandle = getClockwise(typeBlock, orientationBlock)
            break;
        case Constant.KEY_DOWN:
            newYOnKeyHandle = originY + 1;
            break;
        default:
            break;
        }
        controllerGame(newXOnKeyHandle, newYOnKeyHandle, typeBlock, newOrientOnKeyHandle);
        return true;
   }

}
/*************************************
          END   HANDLER
 ***********************************/

function controllerGame(column, row, type, orientation){
    if(gameState != Constant.GAMEOVER_STATE){
        if(canMoveTo(column, row, type, orientation)){
            Utils.deleteBlock(originX, originY, typeBlock, orientationBlock);
            Utils.createBlock(column, row, type, orientation);
        } else if(!canGoDown(originX, originY + 1)){
            timer1.stop();
            timer2.stop();
            Utils.changeStateOfCells(originX, originY, typeBlock, orientationBlock);
            if(isGameOver()){
                gameState = Constant.GAMEOVER_STATEz
                nameInputDialog.show("GAME OVER");
            } else {
                gameCanvas.score += 10;
                checkFullRow();
                var newType = Math.floor(Math.random()*Constant.MAX_FIGURE);
                Tetris.color = Utils.getColorOfCell();
                if(canMoveTo(Constant.ORIGIN_X_DEFAULT, Constant.ORIGIN_Y_DEFAULT, newType, Constant.ORIENTATION_DEFAULT)){
                    Utils.createBlock(Constant.ORIGIN_X_DEFAULT, Constant.ORIGIN_Y_DEFAULT, newType, Constant.ORIENTATION_DEFAULT);
                } else {
//                    gameState = Constant.GAMEOVER_STATE
//                    nameInputDialog.show("GAME OVER");
                    Utils.createBlock(Constant.ORIGIN_X_DEFAULT, Constant.ORIGIN_Y_DEFAULT,
                                      Constant.CELL_FIGURE, Constant.ORIENTATION_DEFAULT);
                }
                timer1.start();
            }

        }
    }
}

function canGoDown(column, row){
    var maxCell = Utils.getMaxCellFromType(typeBlock);
    for (var point = 0; point < maxCell; point++) {
        var x = Utils.getX(point, typeBlock, orientationBlock);
        var y = Utils.getY(point, typeBlock, orientationBlock);
        if ((row + y) >= maxRow){
            return false;
        }

        if(board[Utils.index(column + x, row + y)] != null &&
                board[Utils.index(column + x, row + y)].type == Constant.CLOCKING_CELL){
            return false;
        }
    }
    return true;
}

function canMoveTo(column, row, type, orientation){

    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
        console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);
        if(!Utils.availablePosition(column + x, row + y)){
            return false;
        }
    }
    return true;
}

function getClockwise(type, orientation){
    var maxOrient = Utils.getMaxOrientationFromType(type)
    if(orientation + 1>= maxOrient){
        return 0;
    } else {
        return orientation + 1;
    }
}

function isGameOver(){
    for(var i=0; i< maxColumn; i++){
        if(board[Utils.index(i,0)] != null){
            return true;
        }
    }
    return false;
}

function checkFullRow(){
    var hasRowFull = true;
    var delta = 0;
    for (var i=maxRow -1; i > 0; i--){
        for(var j=0; j<maxColumn; j++){
            hasRowFull = true
            console.debug("(col, row) = ("+ j + " , "+ i + " )" + " -- hasfullrow= "+ hasRowFull);
            if(board[Utils.index(j,i)] == null){
                hasRowFull = false;
                console.debug("Call here -------------------------------hasFull= "+ hasRowFull)
                break;
            }
        }
        if(hasRowFull){
            console.debug("row full = " +i)
            Utils.removeFullRow(i);
            delta++;
        } else if(delta > 0){
            console.debug("row not full = " +i)
            Utils.moveDownAllRow(i, delta);
        }
    }
    gameCanvas.score += (delta*10);
}
