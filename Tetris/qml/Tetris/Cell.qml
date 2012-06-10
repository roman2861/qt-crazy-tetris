import QtQuick 1.0
import Qt.labs.particles 1.0
 Item {
     id: block
     property int type
     property string cellColor: "red"
     property bool dying: false
     property bool spawned: false
     Image {
         id: img
         anchors.fill: parent
         source: "pics/" + cellColor +"Stone.png"
         opacity: 0.5
     }
     Particles {
         id: particles

         width: 1; height: 1
         anchors.centerIn: parent

         emissionRate: 0
         lifeSpan: 1000; lifeSpanDeviation: 600
         angle: 0; angleDeviation: 360;
         velocity: 100; velocityDeviation: 30
         source: "pics/redStar.png";

     }

     states: [
         State {
             name: "AliveState"; when: spawned == true && dying == false
             PropertyChanges { target: img; opacity: 1 }
         },

         State {
             name: "DeathState"; when: dying == true
             StateChangeScript { script: particles.burst(50); }
             PropertyChanges { target: img; opacity: 0 }
             StateChangeScript { script: block.destroy(1000); }
         }
     ]
 }

//Rectangle {
//    id: block
//    property int type
//    color: "gray"
//    border.width: 1
//}
