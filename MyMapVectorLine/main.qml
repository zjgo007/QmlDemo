import QtQml 2.9
import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.9
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.3

Window {
    id: window
    width: 680
    height: 480
    visible: true
    title: qsTr("MyMapVectorLine Demo")
    property int index: 0

    ColorDialog{
        id:colorDialog
        color: "#ff5500"
        title:'选择颜色'
        onAccepted: {
            rectangleColor.color = colorDialog.color
            vectorLine.color = colorDialog.color
        }
    }

    Timer {
        id:timer
        interval: 1000
        repeat: true
        onTriggered:{
            if(window.index<10){
                vectorLine.appendPoint(QtPositioning.coordinate(latitudes[window.index],longitudes[window.index]))
                window.index++
            }
            else{
                window.index = 0
                vectorLine.clear()
            }
        }
    }
    Map{
        id:myMap
        plugin: mapPlugin
        zoomLevel: 13
        color: "#00000000"
        anchors.fill: parent
        anchors.rightMargin: 140
        center: QtPositioning.coordinate(25.0411,102.7129)
        copyrightsVisible: false
        activeMapType: myMap.supportedMapTypes[2]

        MyMapVectorLine{
            id:vectorLine
            markSource: "qrc:/Image/gps.png"
            color: colorDialog.color
            lineWidth: 5
            markWidth: 30
            markHeight: 30
        }
    }

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Rectangle {
        width: window.width-myMap.width
        height: window.height
        border.color: "#a6a6a6"
        border.width: 2
        anchors.right: parent.right
        anchors.rightMargin: 0
        Column{
            id: column
            anchors.fill: parent
            anchors.topMargin: 10
            spacing: 10
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/bike.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        vectorLine.markSource = icon.source
                    }
                }
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/car.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        vectorLine.markSource = icon.source
                    }
                }
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/gps.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        vectorLine.markSource = icon.source
                    }
                }
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/plane.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        vectorLine.markSource = icon.source
                    }
                }
            }

            Row{
                id: row
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                Label{
                    text:"路径颜色："
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    font.family: "微软雅黑"
                }
                Rectangle{
                    id:rectangleColor
                    color: "#ff5500"
                    anchors.verticalCenter: parent.verticalCenter
                    width: 25
                    height: 25
                    ToolTip.text: qsTr("设置颜色")
                    ToolTip.visible: mouse.containsMouse
                    ToolTip.delay: 200

                    MouseArea{
                        id:mouse
                        visible: true
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked:{
                            colorDialog.color = rectangleColor.color
                            colorDialog.open()
                        }
                    }
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/replay.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {

                    }
                }
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/play.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        timer.start()
                    }
                }
                Button{
                    width: 25
                    height: 25
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon.source: "qrc:/Image/pause.png"
                    icon.width: 25
                    icon.height: 25
                    onClicked: {
                        timer.stop()
                    }
                }
            }
        }
    }


    property var latitudes: [25.0259,25.0366,25.0489,25.0587,25.0466,25.0432,25.0119,25.0120,25.0141,25.0201]

    property var longitudes: [102.6874,102.6787,102.6783,102.6884,102.7056,102.7432,102.7166,102.7344,102.7401,102.7465]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
