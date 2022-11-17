import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.9
import QtQuick.Controls 2.9

import MapPainter 1.0

Window {
    id:window
    width: 640
    height: 480
    visible: true
    title: qsTr("Map Painter Path")

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...

        PluginParameter{//自定义地图瓦片路径
            name:"osm.mapping.offline.directory"
            value: "G:/Map/"
        }

        PluginParameter{
            name:"osm.mapping.offline.maptiledir"
            value:true
        }

    }

    Map {
        id: myMap
        center: QtPositioning.coordinate(24,104)
        anchors.fill: parent
        plugin: mapPlugin

        zoomLevel: 8
        color: "#00000000"
        copyrightsVisible: false
        activeMapType: supportedMapTypes[2]

//        onVisibleRegionChanged: {//Qt 5.15以上使用
//            mapPainter.mapRegionChanged()
//        }

        onCenterChanged: {//Qt 5.15以下使用
            mapPainter.mapRegionChanged()
        }

        onZoomLevelChanged: {//Qt 5.15以下使用
            mapPainter.mapRegionChanged()
        }

        MapPainter{
            id:mapPainter
            anchors.fill: parent
        }

        MapQuickItem{
            id: anchorMarker
            width: 50
            height: 36
            anchorPoint.x: image.width/2
            anchorPoint.y: image.height
            coordinate: myMap.center

            sourceItem: Item{
                Image {
                    id:image
                    source: "qrc:/anchor.png"
                    sourceSize.height: 36
                    sourceSize.width: 50
                }
                Text {
                    id: label
                    y:-15
                    color: "#00ffff"
                    text: qsTr("")
                    font.bold: true
                    font.pointSize: 11
                    font.family: "微软雅黑"
                }
            }
        }
        MouseArea {
            id: mouseArea_measure
            anchors.fill: parent
            onClicked: {
                var coordinate = myMap.toCoordinate(Qt.point(mouse.x, mouse.y))
                mapPainter.addPathPoint(mouse.x, mouse.y,coordinate)
                anchorMarker.coordinate = coordinate
            }
        }
    }

    Slider {
        id: slider
        x: 430
        y: 10
        stepSize: 0.01
        value: 1
        onValueChanged: {
            var coordinate = mapPainter.mapPathData(value)
            anchorMarker.coordinate = coordinate
            label.text = "("+coordinate.latitude.toFixed(4)+","+coordinate.longitude.toFixed(4)+")"
        }
    }
    Component.onCompleted: {
        mapPainter.setQmlObject(window)
    }

    function transGeoToPoint(coordinate){
        return myMap.fromCoordinate(coordinate,false)
    }

    function transPointToGeo(pointf){
        return myMap.toCoordinate(pointf,false)
    }
}
