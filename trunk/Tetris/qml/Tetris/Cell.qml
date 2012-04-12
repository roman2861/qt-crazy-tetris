import QtQuick 1.0

 Item {
     id: block
     property int type
     property string cellColor: "red"
     Image {
         id: img
         anchors.fill: parent
         source: "pics/" + cellColor +"Stone.png"
         opacity: 0.5
     }
 }

//Rectangle {
//    id: block
//    property int type
//    color: "gray"
//    border.width: 1
//}
