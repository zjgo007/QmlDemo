import QtQuick 2.0
import QtQml 2.1
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: main
    width: 700
    height: 100
    color: backgroundColor
    signal play()
    signal run(var currentTime,var step)
    signal pause()
    signal stop()
    property color backgroundColor: "#b3434343"
    property string title: "播放状态栏"
    property var startDate:new Date()
    property var endDate:new Date()
    property var currentTime:new Date()
    readonly property bool running: timer.running
    property int speed: 1


    Item{
        y:0
        width: parent.width
        height: parent.height/2
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                icon.source: "qrc:/Img/speeddown.png"
                ToolTip.visible: hovered
                ToolTip.text: qsTr("后退30秒")
                onClicked: {
                    var timeCache = currentTime.getTime()-30000
                    slider.value = timeCache
                }
            }
            Button{
                icon.source: "qrc:/Img/stop.png"
                ToolTip.visible: hovered
                ToolTip.text: qsTr("停止")
                onClicked: {
                    timer.stop()
                    slider.value = startDate.getTime()
                    stop()
                }
            }
            Button{
                icon.source: running?"qrc:/Img/pause.png":"qrc:/Img/play.png"
                ToolTip.visible: hovered
                ToolTip.text: running?"暂停":"开始"
                onClicked: {
                    if(!running){
                        timer.start()
                        play()
                    }else{
                        timer.stop()
                        pause()
                    }

                }
            }
            Button{
                icon.source: "qrc:/Img/speedup.png"
                ToolTip.visible: hovered
                ToolTip.text: qsTr("前进30秒")
                onClicked: {
                    var timeCache = currentTime.getTime()+30000
                    slider.value = timeCache
                }
            }
            Button{
                text:"x1"
                font.pointSize: 9
                ToolTip.visible: hovered
                ToolTip.text: qsTr("回放速度")
                font.family: "微软雅黑"
                font.bold: true
                onClicked: {
                    if(speed == 1){
                        speed = 2
                        text = "x2"
                    }
                    else if(speed == 2){
                        speed = 4
                        text = "x4"
                    }
                    else if(speed == 4){
                        speed = 8
                        text = "x8"
                    }
                    else if(speed == 8){
                        speed = 1
                        text = "x1"
                    }
                }
            }
        }

        Label {
            text: title
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            font.pointSize: 16
            font.family: "微软雅黑"
            font.bold: true
        }

        Label {
            id:label_currentTime
            text: Qt.formatTime(currentTime,"hh:mm:ss")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            anchors.rightMargin: 10
            font.family: "微软雅黑"
            font.bold: true
        }
    }


    RowLayout{
        y:parent.height/2
        height: parent.height/2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.leftMargin: 15

        Label {
            text: Qt.formatTime(startDate,"hh:mm:ss")
            font.pointSize: 11
            font.family: "微软雅黑"
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            from:startDate.getTime()
            to:endDate.getTime()
            onValueChanged: {
                var step = value - currentTime.getTime()
                currentTime.setTime(value)
                if(currentTime<startDate){
                    currentTime = startDate
                }
                if(currentTime>=endDate){
                    timer.stop()
                    slider.value = startDate.getTime()
                    stop()
                }

                label_currentTime.text = Qt.formatTime(currentTime,"hh:mm:ss")
                run(currentTime,step)
            }
            onPressedChanged: {
                if(running){
                    if(pressed){
                        timer.stop()
                        pause()
                    }
                }
            }
        }

        Label {
            text: Qt.formatTime(endDate,"hh:mm:ss")
            font.pointSize: 11
            font.family: "微软雅黑"
        }
    }

    Timer {
        id:timer
        interval: 1000/speed
        repeat: true
        onTriggered:{
            var timeCache = currentTime.getTime()+1000
            slider.value = timeCache
        }
    }

    function setDateRange(start,end,current){
        startDate = start
        endDate = end
        currentTime = current
        slider.value = currentTime.getTime()
    }

}
