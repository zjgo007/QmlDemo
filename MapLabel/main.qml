import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.9
import QtQuick.Controls 2.15

Window {
    id: window
    width: 860
    height: 680
    visible: true
    title: qsTr("Map Point Label")

    property var pathList: [
        QtPositioning.coordinate(26.0624,99.2808),
        QtPositioning.coordinate(25.1522,99.1428),
        QtPositioning.coordinate(25.4639,100.8514),
        QtPositioning.coordinate(24.8606,102.8510),
        QtPositioning.coordinate(25.0620,103.5866),
        QtPositioning.coordinate(25.6367,104.2684),
        QtPositioning.coordinate(26.0504,103.9926),
        QtPositioning.coordinate(26.1398,104.9810),
        QtPositioning.coordinate(26.1467,105.6935),
        QtPositioning.coordinate(25.7541,106.1838),
    ]

    property int pathIndex: 0

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
    }

    Map {
        id:myMap
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(25.0018,102.9409) // 机关
        zoomLevel: 6
        color: "#00000000"
        copyrightsVisible: false
        activeMapType:supportedMapTypes[1]

        MapPolyline{
            id:mapPolyline
            line.color: "red"
            line.width: 4
        }

        MapPointLabel{
            id:mapPointLabel
            anchors.fill: parent
            name:"test"
            backgroundColor: "#cc115777"
            lineColor:"magenta"
            anchorCoordinate: QtPositioning.coordinate(25.0018,102.9409)
            visible : pathIndex
        }
    }

    Timer{
        id:timer
        interval: 1800
        repeat: true
        running: true
        onTriggered: {
            if(pathIndex<9){
                mapPolyline.addCoordinate(pathList[pathIndex])
                mapPointLabel.pointsChanged(pathList[pathIndex])
                pathIndex++
            }else{
                mapPolyline.path = []
                pathIndex = 0
            }
        }
    }

}
