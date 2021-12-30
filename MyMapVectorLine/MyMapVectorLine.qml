import QtQuick 2.9
import QtLocation 5.9
import QtQml 2.9
import QtGraphicalEffects 1.0

MapItemGroup{
    id:vectorLine
    property color color: "green"
    property int lineWidth: 2
    property int markWidth: 24
    property int markHeight: 24
    property string markSource: ""
    MapPolyline{
        id:line
        line.width: lineWidth
        line.color: color
    }
    MapQuickItem {
        id:mark
        width: markWidth
        height: markHeight
        anchorPoint.x: markWidth/2
        anchorPoint.y: markHeight/2
        visible: false


        sourceItem: Image {
            id:image
            source: markSource
            sourceSize.width: markWidth
            sourceSize.height: markHeight
            ColorOverlay {
                anchors.fill: image
                source: image
                color: vectorLine.color
            }
        }
    }

    function appendPoint(coordinate){
        line.addCoordinate(coordinate)
        updateMarkRotation()
    }

    function removePoint(){
        var index = line.pathLength()-1
        line.removeCoordinate(index)
        updateMarkRotation()
    }

    function clear(){
        line.path = []
        updateMarkRotation()
    }

    function updateMarkRotation(){
        var size = line.pathLength()
        if(size<2){
            mark.visible = false
            return
        }
        var cCoordinate = line.coordinateAt(size-1)
        var lCoordinate = line.coordinateAt(size-2)
        mark.visible = true
        mark.coordinate = cCoordinate
        var rotation = lCoordinate.azimuthTo(cCoordinate)
        mark.rotation = rotation
    }

}
