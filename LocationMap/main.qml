import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0

Window {
    id: window
    visible: true
    width: 820
    height: 560
    color: "#ffffff"
    title: qsTr("覆盖规划")

    Settings{
        id:settings
        property var jd : 102.6394
        property var wd : 24.9394
    }

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
    }

    Item {
        id: itemMenu
        width: 180
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        property var itemList: []

        Row {
            id: row
            y: 10
            height: 40
            spacing: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10

            Label {
                id: label
                width: 50
                height: 40
                text: qsTr("经度：")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 13
            }

            Rectangle {
                id: rectangle
                width: 100
                height: 40
                color: "#ffffff"
                border.color: "#b0b8b4"
                border.width: 2

                TextInput {
                    id: textInput_JD
                    height: 20
                    text: settings.jd
                    clip: true
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.left: parent.left
                    font.pointSize: 12
                }
            }
        }

        Row {
            id: row1
            x: 7
            y: 60
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: label1
                width: 50
                height: 40
                text: qsTr("纬度：")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 13
            }

            Rectangle {
                id: rectangle1
                width: 100
                height: 40
                color: "#ffffff"
                border.color: "#b0b8b4"
                TextInput {
                    id: textInput_WD
                    height: 20
                    text: settings.wd
                    cursorVisible: true
                    clip: true
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.pointSize: 12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                }
                border.width: 2
            }
            anchors.right: parent.right
            spacing: 10
            anchors.rightMargin: 10
        }

        Row {
            id: row2
            y: 110
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: label2
                width: 50
                height: 40
                text: qsTr("半径：")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 13
            }

            Rectangle {
                id: rectangle2
                width: 100
                height: 40
                color: "#ffffff"
                border.color: "#b0b8b4"
                TextInput {
                    id: textInput_Distance
                    height: 20
                    text: qsTr("")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.pointSize: 12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                }
                border.width: 2
            }
            anchors.right: parent.right
            spacing: 10
            anchors.rightMargin: 10
        }

        Row {
            id: row3
            x: -9
            y: 160
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 8
            Label {
                id: label3
                width: 50
                height: 40
                text: qsTr("颜色：")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 13
            }

            Rectangle {
                id: rectangle_color
                width: 100
                height: 40
                color: "#cc72f462"
                border.color: "#b0b8b4"
                border.width: 0
                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: colorDialog.open()
                }
            }
            anchors.right: parent.right
            spacing: 10
            anchors.rightMargin: 12
        }

        Button {
            id: button1
            x: 40
            y: 215
            width: 100
            text: qsTr("添加覆盖圈")
            onClicked: {
                var component = Qt.createComponent("MyCircle.qml")
                if(component.status === Component.Ready){
                    var circle = component.createObject(myMap)
                    var jd = textInput_JD.text
                    var wd = textInput_WD.text
                    circle.myCoordinate = QtPositioning.coordinate(wd, jd)
                    circle.myColor = rectangle_color.color
                    circle.distance = textInput_Distance.text
                    myMap.addMapItemGroup(circle)
                    itemMenu.itemList.push(circle)
                }
            }
        }

        Button {
            id: button2
            x: 40
            y: 265
            width: 100
            text: qsTr("删除")
            onClicked: {
                var obj = itemMenu.itemList[itemMenu.itemList.length-1]
                myMap.removeMapItemGroup(obj)
                itemMenu.itemList.pop()
                delete obj
            }
        }

        Button {
            id: button3
            x: 40
            y: 315
            width: 100
            text: qsTr("清除测距")
            onClicked: {
                lineObj.path = []
                distanceLabel.text = ''
            }
        }

        Text {
            id: text1
            x: 18
            y: 427
            text: qsTr("双击左键获取图上位置坐标")
            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 18
            y: 453
            text: qsTr("点击鼠标右键进行地图测距")
            font.pixelSize: 12
        }

        Button {
            id: button4
            x: 40
            y: 369
            width: 100
            text: qsTr("保存中心")
            onClicked: {
                settings.jd = textInput_JD.text
                settings.wd = textInput_WD.text
                text_info.text = "地图中心位置已保存"
            }
        }

        Text {
            id: text_info
            x: 74
            y: 482
            width: 32
            height: 12
            color: "#f66060"
            text: qsTr("")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }

    Map {
        id:myMap
        anchors.leftMargin: 180
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(settings.wd, settings.jd) // Oslo
        zoomLevel: 11
        property bool measure: false

        MouseArea {
            id: mouseArea_measure
            anchors.fill: parent
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            hoverEnabled: true
            onClicked: {
                if(mouse.button === Qt.RightButton){
                    if(!lineObj.start){
                        myMap.measure = true
                        lineObj.path = []
                        var c = myMap.toCoordinate(Qt.point(mouse.x, mouse.y))
                        lineObj.addCoordinate(c)
                        lineObj.start = true
                    }else{
                        myMap.measure = false
                        var c = myMap.toCoordinate(Qt.point(mouse.x, mouse.y))
                        lineObj.addCoordinate(c)
                        lineObj.start = false
                    }
                }
            }

            onPositionChanged:{
                    if(myMap.measure){
                        var c = myMap.toCoordinate(Qt.point(mouse.x, mouse.y))
                        var path = lineObj.path;
                        path[1] = c;
                        lineObj.path = path;
                        distanceLabel.coordinate = c
                        var dis = c.distanceTo(path[0])
                        distanceLabel.text ="   距离："+Math.round(dis)/1000+"千米"
                }
            }
            onDoubleClicked: {
                if(mouse.button === Qt.LeftButton){
                   var c = myMap.toCoordinate(Qt.point(mouse.x, mouse.y))
                   textInput_JD.text = c.longitude.toFixed(6)
                   textInput_WD.text = c.latitude.toFixed(6)
                }
            }
        }

        MapPolyline {
            id:lineObj
            line.width: 3
            line.color: 'green'
            path: []

            property bool start: false
        }

        MapQuickItem{
            id:distanceLabel
            property string text: ''
            sourceItem:Label{
                color: "darkturquoise"
                font.bold: true
                font.pointSize: 15
                font.family: "微软雅黑"
                text: distanceLabel.text
            }
        }
    }

    ColorDialog {
        id: colorDialog
        options:ColorDialog.ShowAlphaChannel
        onAccepted: {
            rectangle_color.color = colorDialog.currentColor
        }
    }
}
