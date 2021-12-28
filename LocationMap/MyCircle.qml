import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapItemGroup {
    id: groupPolyCircle
    property var myCoordinate: QtPositioning.coordinate(24.9394, 102.6394)
    property var distance:15000
    property color myColor: '#72f462'
    MapCircle {
    //    opacity: 0.5
        border.width: 0
        center: groupPolyCircle.myCoordinate
        radius: groupPolyCircle.distance
        color: groupPolyCircle.myColor

    }
    MapQuickItem {
          id: marker
          anchorPoint.x: image.width/2
          anchorPoint.y: image.height
          coordinate:myCoordinate
          sourceItem: Image {
              id: image
              sourceSize.height: 25
              sourceSize.width: 20
              source: "qrc:/location.png"
          }
      }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
