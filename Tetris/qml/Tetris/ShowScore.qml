// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import  "Utils.js" as Utils
Page {
    width: 100
    height: 62

    onStatusChanged: {
        if(status == 2){
            Utils.showHighScore(1)
        }
    }

    DialogS7 {
        id: dialog
    }
}
