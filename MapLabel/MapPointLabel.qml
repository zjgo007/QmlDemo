import QtQuick 2.9
import QtPositioning 5.9
import QtLocation 5.9


Item{
    id:mainItem
    anchors.fill: parent
    property string name: ""
    property var anchorCoordinate: QtPositioning.coordinate(0,0)
    property color backgroundColor: "#b3115777"
    property color borderColor: "#e6115777"
    property color lineColor: "floralwhite"

    QtObject{
        id:object
        property point anchorPoint: "0,0"
    }

    Rectangle {
        id:mapPointLabel
        width: 60
        height: 100
        border.color: mainItem.borderColor
        color: mainItem.backgroundColor

        property int offsetX: -mapPointLabel.width/2
        property int offsetY: -mapPointLabel.height/2
        readonly property point center: Qt.point(x+mapPointLabel.width/2,y+mapPointLabel.height/2)
        property bool draged: false


        onXChanged: {
            if(!mapPointLabel.draged)
                return
            offsetX = x-object.anchorPoint.x
            myCanvas.requestPaint()
        }

        onYChanged: {
            if(!mapPointLabel.draged)
                return
            offsetY = y-object.anchorPoint.y
            myCanvas.requestPaint()
        }

        MouseArea{
            anchors.fill: parent
            drag.target: mapPointLabel
            drag.axis: Drag.XAndYAxis
            preventStealing: true
            onPressed: {
                mapPointLabel.draged = true
                mapPointLabel.border.color = "crimson"
            }
            onReleased: {
                mapPointLabel.draged = false
                mapPointLabel.border.color = mainItem.borderColor
            }
        }

    }


    Canvas{
        id:myCanvas
        anchors.fill: parent
        z:-1
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0,0,myCanvas.width,myCanvas.height)
            ctx.strokeStyle = mainItem.lineColor
            ctx.lineWidth = 2;
            ctx.setLineDash([5,3])
            ctx.beginPath()
            ctx.moveTo(mapPointLabel.center.x,mapPointLabel.center.y)
            ctx.lineTo(object.anchorPoint.x,object.anchorPoint.y)
            ctx.stroke()
            ctx.clearRect(mapPointLabel.x,mapPointLabel.y,mapPointLabel.width,mapPointLabel.height)
        }
    }

    Connections{
        target: mainItem.parent
        function onZoomLevelChanged(){
            update()
        }
        function onVisibleRegionChanged(){
            update()
        }
    }

    function update(){
        object.anchorPoint = parent.fromCoordinate(anchorCoordinate,false)
        mapPointLabel.x = object.anchorPoint.x + mapPointLabel.offsetX
        mapPointLabel.y = object.anchorPoint.y + mapPointLabel.offsetY
        myCanvas.requestPaint()
    }

    function pointsChanged(coordinate){
        anchorCoordinate = coordinate
        update()
    }
}

