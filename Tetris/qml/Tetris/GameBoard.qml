import QtQuick 1.1
import Qt 4.7
import QtMultimediaKit 1.1
import Qt.labs.particles 1.0
import com.nokia.symbian 1.1
import "." 1.1

import "Utils.js" as Utils
import "SoundUtils.js" as Sound
import "Tetris.js" as Tetris
import "Constant.js" as Constant

import "Figure.js" as FIGURE
import "Configurations.js" as Config;

Page {
    id: screenGame
    focus: true    // important when set onKey
    width: parent.width; height: parent.height
    property int intervalTimer: 500
    property int cellSize: parent.width < parent.height ? parent.width / Config.MAX_CELL : parent.height / Config.MAX_CELL
    signal btnBackClick();
    onStatusChanged: {
        if(status == PageStatus.Active)
            Tetris.startNewGame();
    }


    SystemPalette { id: activePalette }

    Item {
        width: parent.width
        anchors { top: toolBar.bottom; bottom: control.top }

        Image {
            id: background
            anchors.fill: parent
            source: "pics/background.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        Item {
            id: gameCanvas
            property int score: 0
            property int blockSize: parent.width / Config.MAX_CELL;
            property int level: 1

            anchors.centerIn: parent
            width: parent.width;
            height: parent.height;            

        }
    }

    Rectangle {
        id: toolBar
        width: parent.width; height: Config.TOOLBAR_HEIGHT * cellSize
        color: "white"
        anchors.top: screenGame.top

        Item {
            id: nextFigure
            anchors {top: parent.top; left: parent.left}
        }

        Text {
            id: score
            anchors { right: parent.right;  verticalCenter: parent.verticalCenter}
            text: "| Level: " + gameCanvas.level + " | Score: " + gameCanvas.score
            color: "black"

        }

    }

    Rectangle {
        id: control
        anchors.bottom: parent.bottom;
        height: Config.CONTROLLER_HEIGHT * cellSize
        width: parent.width;
        color: "red";

        Button {
            id: btnPause
            width: 2 * cellSize;
            anchors { left: parent.left; bottom: parent.bottom;}
            text: "Pause"
            onClicked: {
                if(timer.running == true){
                    timer.stop();
                    btnPause.text = "Resume";
                }
                else{
                    timer.start();
                    btnPause.text = "Pause";
                }

               // Tetris.startNewGame();
            }
        }

        Button {
            id: btnBack
            width: 2 * cellSize;
            anchors { right: parent.right; bottom: parent.bottom;}
            text: "Back"
            onClicked: {
                timer.stop();
                btnBackClick();
            }
        }

        Button {
            id: btnRotate
            width: 2 * cellSize;
            height: 1.5 * cellSize;
            anchors { left: btnLeft.right; top: parent.top}
            text: "@"

            onClicked: {
                if(timer.running)
                    Tetris.onKeyHandler(Constant.KEY_UP)
            }
        }

        Button {
            id: btnDown
            width: 2 * cellSize;
            height: 1.5 * cellSize;
            anchors { left: btnLeft.right; bottom: parent.bottom }
            text: "\/"

            onClicked: {
                if(timer.running)
                    Tetris.onKeyHandler(Constant.KEY_DOWN)
            }
        }

        Button {
            id: btnLeft
            x: 3 * cellSize
            anchors {verticalCenter: parent.verticalCenter}
            width: 2 * cellSize;
            height: 1.5 * cellSize;
            text: "<"
            onClicked: {
                if(timer.running)
                    Tetris.onKeyHandler(Constant.KEY_LEFT)
            }
        }

        Button {
            id: btnRight
            anchors { left: btnRotate.right; top: btnLeft.top }
            width: 2 * cellSize;
            height: 1.5 * cellSize;
            text: ">"
            onClicked: {
                if(timer.running)
                    Tetris.onKeyHandler(Constant.KEY_RIGHT)
            }
        }

    }



    DialogS7 {
        id: nameInputDialog
        anchors.centerIn: parent
        z: 100

//        onClosed: {
//            if (nameInputDialog.inputText != "")
//                SameGame.saveHighScore(nameInputDialog.inputText);
//        }
    }


    SoundEffect {
        id: playMovingSound
        source: "sound/moving.wav"
    }
    SoundEffect {
        id: playClearRowSound
        source: "sound/remove_row.wav"
    }
    SoundEffect {
        id: playGameOverSound
        source: "sound/game_over.wav"
    }
    SoundEffect {
        id: playOtherSound
        source: "sound/other.wav"
    }





    Timer {
        id: timer
        interval: intervalTimer
        repeat: true
        onTriggered: Tetris.timerHandler()
    }

    Keys.onLeftPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_LEFT)
            console.debug("on key_left");
    }

    Keys.onRightPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_RIGHT)
        //    console.debug("on key_right");
    }
    Keys.onUpPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_UP)
    }
    Keys.onDownPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_DOWN)
    }
    Keys.onCallPressed:  {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_PAUSE)
    }


//    states: [
//        State {
//            name: "LEVEL_1"
//            when: gameCanvas.score < 500
//            StateChangeScript { script: Utils.setIntervalTimer(1000)}
//        },

//        State {
//            name: "LEVEL_2"
//            when: gameCanvas.score >= 500 && gameCanvas.score < 1200
//            PropertyChanges { target: gameCanvas; level: 2 }
//            StateChangeScript { script: Utils.setIntervalTimer(700)}
//        },

//        State {
//            name: "LEVEL_3"
//            when: gameCanvas.score >= 1200 && gameCanvas.score < 2000
//            PropertyChanges { target: gameCanvas; level: 3 }
//            StateChangeScript { script: Utils.setIntervalTimer(500)}
//        },

//        State {
//            name: "LEVEL_4"
//            when: gameCanvas.score >= 2000 && gameCanvas.score < 2500
//            PropertyChanges { target: gameCanvas; level: 4 }
//            StateChangeScript { script: Utils.setIntervalTimer(350)}
//        },

//        State {
//            name: "LEVEL_5"
//            when: gameCanvas.score >= 2500 && gameCanvas.score < 2800
//            PropertyChanges { target: gameCanvas; level: 5 }
//            StateChangeScript { script: Utils.setIntervalTimer(180)}
//        },

//        State {
//            name: "HIGHEST_LEVEL"
//            when: gameCanvas.score >= 2800
//            PropertyChanges { target: gameCanvas; level: 6 }
//            StateChangeScript { script: Utils.setIntervalTimer(120)}
//        }
//    ]
}
