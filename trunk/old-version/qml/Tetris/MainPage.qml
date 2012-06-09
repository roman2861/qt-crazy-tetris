import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constant.js" as Constant
import "Game.js" as Game

Page {
    id: mainPage
    Rectangle {
        anchors.fill: parent
        color: "black"
        focus: true
        //Up Event
        Keys.onPressed: {
            if (event.key == Qt.Key_Left || event.key == Qt.Key_4)
            {
                Game.InputHandle(Constant.MoveLeft);
            }
            else if (event.key == Qt.Key_Right || event.key == Qt.Key_6)
            {
                Game.InputHandle(Constant.MoveRight);
            }
            else if (event.key == Qt.Key_Up || event.key == Qt.Key_8)
            {
                Game.InputHandle(Constant.MoveUp);
            }
            else if (event.key == Qt.Key_Down || event.key == Qt.Key_2)
            {
                Game.InputHandle(Constant.MoveDown);
            }
            else if (event.key == Qt.Key_Select || event.key == Qt.Key_5)
            {
                Game.InputHandle(Constant.Rotate);
            }
        }
    }
    Timer {
        id: timer
        interval: 1000
        running: true
        repeat:  true
        onTriggered: Game.Run();
    }

    Component.onCompleted: {
        Game.SetupGame();
    }
}
