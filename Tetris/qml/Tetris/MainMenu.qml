// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

import "Utils.js" as Utils
import "SoundUtils.js" as Sound
import "Tetris.js" as Tetris
import "Constant.js" as Constant

import "Figure.js" as FIGURE
import "Configurations.js" as Config;

Page {
    id: menu

    signal btnStartClick();
    signal btnShowScoreClick();
    signal btnOptionsClick();
    signal btnQuitClick();
    Button {
        id: btnStart
        anchors.centerIn: parent
        text: "New Game"

        onClicked:{
            btnStartClick();
        }
    }
    Button {
        id: btnShowScore
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: btnStart.bottom
        text: "Show Scores"

        onClicked:{
            btnShowScoreClick();
        }
    }
    Button {
        id: btnConfig
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: btnShowScore.bottom
        text: "Options"

        onClicked:{
            btnOptionsClick();
        }
    }
    Button {
        id: btnQuit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: btnConfig.bottom
        text: "Quit"

        onClicked:{
            btnQuitClick();
        }
    }
}
