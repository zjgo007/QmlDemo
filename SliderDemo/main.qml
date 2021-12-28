import QtQuick 2.1
import QtQml 2.1
import QtQuick.Window 2.2

Window {
    id: window
    width: 700
    height: 400
    visible: true
    title: qsTr("SliderDemo")
    color: "black"

    Row {
        id: row
        x:0
        y:0
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        Text {
            text: qsTr("播放时间：")
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 11
            color: "white"
        }

        Text {
            id:text_time
            text: "xxxxxxxxxx"
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 11
            color: "white"
        }

        Text {
            text: qsTr("播放状态：")
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 11
            color: "white"
        }

        Text {
            id:text_state
            text: "xxxxxxxxxx"
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 11
            color: "white"
        }
    }

    DataSlider{
        x:0
        y:200
        width:parent.width
        height: 100
        Component.onCompleted: {
            var start = new Date('2021-01-17T03:24:00')
            var endDate = new Date('2021-01-17T04:32:00')
            var currentTime = new Date('2021-01-17T03:24:00')
            setDateRange(start,endDate,currentTime)
        }
        onPlay: {
            text_state.text = "开始播放"
        }
        onPause: {
            text_state.text = "暂停播放"
        }
        onStop: {
            text_state.text = "停止播放"
        }
        onRun: {
            text_time.text = Qt.formatTime(currentTime,"hh:mm:ss")
        }
    }
}
