import QtQuick 1.1
import com.nokia.symbian 1.1

//import "Utils.js" as Utils
//import "SoundUtils.js" as Sound
import "Tetris.js" as Tetris
import "Constant.js" as Constant
import "Configurations.js" as Config
//import "Figure.js" as FIGURE

PageStackWindow {
    id: window
    initialPage: menu
    MainMenu {
        id: menu
        onBtnStartClick: {
            window.pageStack.replace(mainPage);
        }
        onBtnQuitClick: {
            Qt.quit();
        }
        onBtnShowScoreClick: {
            window.pageStack.replace(showScore);
        }
        onBtnOptionsClick: {
            window.pageStack.replace(option);
        }

    }

    GameBoard {
        id: mainPage
        onBtnBackClick: {
            window.pageStack.replace(menu);
        }
    }
    ShowScore {
        id: showScore
    }
    Options {
        id: option
    }

    Test {
        id: test

    }
}
