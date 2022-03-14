import QtQuick 2.0

Rectangle {
    id:rect
    color: "#00000000"
    border.width: 1
    property bool dragEnabled: true
    property bool resizeEnabled: true
    property int minimumWidth: 50
    property int minimumHeight: 50
    property int mouseRegion: 5
    MouseArea{
        anchors.fill: parent
        drag.target: rect
        enabled: dragEnabled
    }

    MouseArea {
        id:leftX
        width: mouseRegion
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeHorCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int xPosition: 0
        onPressed: {
            xPosition = mouse.x
        }

        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            if(rect.x+xOffset>0 && rect.width-xOffset>minimumWidth){
                rect.x = rect.x+xOffset
                rect.width = rect.width-xOffset
            }
        }
    }

    MouseArea{
        id:rightX
        width: mouseRegion
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeHorCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int xPosition: 0
        onPressed: {
            xPosition = mouse.x
        }

        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            var xWidth = rect.width+xOffset
            if(xWidth+rect.x<rect.parent.width && xWidth>minimumWidth){
                rect.width = xWidth
            }
        }
    }

    MouseArea{
        id:topY
        height: mouseRegion
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeVerCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int yPosition: 0
        onPressed: {
            yPosition = mouse.y
        }

        onPositionChanged: {
            var yOffset = mouse.y-yPosition
            if(rect.y+yOffset>0 && rect.height-yOffset>minimumHeight){
                rect.y = rect.y+yOffset
                rect.height = rect.height-yOffset
            }
        }
    }

    MouseArea{
        id:bottomY
        height: mouseRegion
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeVerCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int yPosition: 0
        onPressed: {
            yPosition = mouse.y
        }

        onPositionChanged: {
            var yOffset = mouse.y-yPosition
            var yHeight = rect.height+yOffset
            if(yHeight+rect.y<rect.parent.height && yHeight>minimumHeight){
                rect.height = yHeight
            }
        }
    }

    MouseArea{
        width: mouseRegion
        height: mouseRegion
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeFDiagCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int xPosition: 0
        property int yPosition: 0
        onPressed: {
            xPosition = mouse.x
            yPosition = mouse.y
        }

        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            if(rect.x+xOffset>0 && rect.width-xOffset>minimumWidth){
                rect.x = rect.x+xOffset
                rect.width = rect.width-xOffset
            }
            var yOffset = mouse.y-yPosition
            if(rect.y+yOffset>0 && rect.height-yOffset>minimumHeight){
                rect.y = rect.y+yOffset
                rect.height = rect.height-yOffset
            }
        }
    }

    MouseArea{
        width: mouseRegion
        height: mouseRegion
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeBDiagCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int xPosition: 0
        property int yPosition: 0
        onPressed: {
            xPosition = mouse.x
            yPosition = mouse.y
        }

        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            var xWidth = rect.width+xOffset
            if(xWidth+rect.x<rect.parent.width && xWidth>minimumWidth){
                rect.width = xWidth
            }
            var yOffset = mouse.y-yPosition
            if(rect.y+yOffset>0 && rect.height-yOffset>minimumHeight){
                rect.y = rect.y+yOffset
                rect.height = rect.height-yOffset
            }
        }
    }

    MouseArea{
        width: mouseRegion
        height: mouseRegion
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeBDiagCursor
        enabled: resizeEnabled
        property int xPosition: 0
        property int yPosition: 0
        onPressed: {
            xPosition = mouse.x
            yPosition = mouse.y
        }
        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            if(rect.x+xOffset>0 && rect.width-xOffset>minimumWidth){
                rect.x = rect.x+xOffset
                rect.width = rect.width-xOffset
            }
            var yOffset = mouse.y-yPosition
            var yHeight = rect.height+yOffset
            if(yHeight+rect.y<rect.parent.height && yHeight>minimumHeight){
                rect.height = yHeight
            }
        }
    }


    MouseArea{
        width: mouseRegion
        height: mouseRegion
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        cursorShape: resizeEnabled ? Qt.SizeFDiagCursor:Qt.ArrowCursor
        enabled: resizeEnabled
        property int xPosition: 0
        property int yPosition: 0
        onPressed: {
            xPosition = mouse.x
            yPosition = mouse.y
        }
        onPositionChanged: {
            var xOffset = mouse.x-xPosition
            var xWidth = rect.width+xOffset
            if(xWidth+rect.x<rect.parent.width && xWidth>minimumWidth){
                rect.width = xWidth
            }
            var yOffset = mouse.y-yPosition
            var yHeight = rect.height+yOffset
            if(yHeight+rect.y<rect.parent.height && yHeight>minimumHeight){
                rect.height = yHeight
            }
        }
    }
}
