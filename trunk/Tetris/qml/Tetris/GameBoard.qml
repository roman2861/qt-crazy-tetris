import QtQuick 1.1
import "Utils.js" as Utils
import "Tetris.js" as Tetris
import "Constant.js" as Constant
import "SQUARE.js" as SQUARE
import "LINE.js" as LINE
import "CELL.js" as CELL
import "TRIANGLE.js" as TRIANGLE
import "S_FIGURE.js" as S_FIGURE
import "Z_FIGURE.js" as Z_FIGURE
import "RIGHT_ANGLE.js" as RIGHT_ANGLE
import "LEFT_ANGLE.js" as LEFT_ANGLE
import "PLUS_FIGURE.js" as PLUS_FIGURE

Rectangle {
    id: screen
    focus: true    // important when set onKey
    width: 490; height: 720
    property int intervalTimer: 200

    SystemPalette { id: activePalette }

    Item {
        width: parent.width
        anchors { top: parent.top; bottom: toolBar.top }

        Image {
            id: background
            anchors.fill: parent
            source: "pics/background.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        Item {
            id: gameCanvas
            property int score: 0
            property int blockSize: 40
            property int level: 1

            anchors.centerIn: parent
            width: parent.width - (parent.width % blockSize);
            height: parent.height - (parent.height % blockSize);
        }
    }

    Dialog {
        id: nameInputDialog
        anchors.centerIn: parent
        z: 100

        onClosed: {
            if (nameInputDialog.inputText != "")
                SameGame.saveHighScore(nameInputDialog.inputText);
        }
    }

    Rectangle {
        id: toolBar
        width: parent.width; height: 45
        color: activePalette.window
        anchors.bottom: screen.bottom

        Button {
            id: btnStartGame
            width: 100;
            anchors { left: parent.left; verticalCenter: parent.verticalCenter; top: parent.top;}
            text: "New"
            onClicked: {Tetris.startNewGame();
                nameInputDialog.hide();
            }
        }

        Text {
            id: score
            anchors { right: parent.right; verticalCenter: parent.verticalCenter;  top: parent.top }
            text: "| Level: " + gameCanvas.level + " | Score: " + gameCanvas.score
            color: "black"
        }


    }

    Timer {
        id: timer1
        interval: intervalTimer
        onTriggered: Tetris.timer1Handler()
    }


    Timer {
        id: timer2
        interval: intervalTimer
        onTriggered: Tetris.timer2Handler()
    }

    Keys.onLeftPressed: {
        Tetris.onKeyHandler(Constant.KEY_LEFT)
        console.debug("on key_left");
    }

    Keys.onRightPressed: {
        Tetris.onKeyHandler(Constant.KEY_RIGHT)
        console.debug("on key_right");
    }
    Keys.onUpPressed: {
        Tetris.onKeyHandler(Constant.KEY_UP)
    }
    Keys.onDownPressed: {
        Tetris.onKeyHandler(Constant.KEY_DOWN)
    }

    states: [
        State {
            name: "LEVEL_1"
            when: gameCanvas.score < 500
            StateChangeScript { script: Utils.setIntervalTimer(200)}
        },

        State {
            name: "LEVEL_2"
            when: gameCanvas.score >= 500 && gameCanvas.score < 1200
            PropertyChanges { target: gameCanvas; level: 2 }
            StateChangeScript { script: Utils.setIntervalTimer(150)}
        },

        State {
            name: "LEVEL_3"
            when: gameCanvas.score >= 1200 && gameCanvas.score < 2000
            PropertyChanges { target: gameCanvas; level: 3 }
            StateChangeScript { script: Utils.setIntervalTimer(100)}
        },

        State {
            name: "LEVEL_4"
            when: gameCanvas.score >= 2000 && gameCanvas.score < 2500
            PropertyChanges { target: gameCanvas; level: 4 }
            StateChangeScript { script: Utils.setIntervalTimer(50)}
        },

        State {
            name: "LEVEL_5"
            when: gameCanvas.score >= 2500 && gameCanvas.score < 2800
            PropertyChanges { target: gameCanvas; level: 5 }
            StateChangeScript { script: Utils.setIntervalTimer(30)}
        },

        State {
            name: "HIGHEST_LEVEL"
            when: gameCanvas.score >= 2800
            PropertyChanges { target: gameCanvas; level: 6 }
            StateChangeScript { script: Utils.setIntervalTimer(20)}
        }
    ]
}
