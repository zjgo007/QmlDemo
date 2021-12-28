import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3

Window {
    id: window
    visible: true
    width: 600
    height: 600
    title: qsTr("PercentChart")

    Percent {
        id: main
        anchors.bottomMargin: 40
        anchors.fill: parent
        percent: 75
        animation: true
        borderColor:"#d2691e"
        backgroundColor: "#00ffff"
        foregroundColor: "#ff69b4"

    }


    Slider {
        id: slider
        stepSize: 1
        to: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        value: main.percent
        onValueChanged: {
            main.percent = slider.value
        }
    }
}
