import QtQuick 2.9
import QtQuick.Window 2.2
import AzimuthDial 1.0
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2

Window {
    width: 620
    height: 620
    visible: true
    color: "#000000"
    title: qsTr("电子校北仪")
    ColorDialog {
        id: colorDialog
        color: "#ffff00"
        title: '选择添加颜色'
        showAlphaChannel: true
        onAccepted: {
            rectangleColor.color = colorDialog.color
        }
    }
    AzimuthDial{
        id:azimuthDial
        anchors.fill: parent
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 40
    }
    Rectangle{
        id: rectangle
        width: parent.width
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Row{
            id: row
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Label{
                height: 40
                text: "名称"
                verticalAlignment: Text.AlignVCenter
                font.family: "微软雅黑"
            }


            TextField {
                id: textField
                width: 60
                height: 35
                text: qsTr("p1")
                anchors.verticalCenter: parent.verticalCenter
            }
            Label{
                height: 40
                text: "颜色"
                verticalAlignment: Text.AlignVCenter
                font.family: "微软雅黑"
            }
            Rectangle {
                id: rectangleColor
                color: "#40e0d0"
                anchors.verticalCenter: parent.verticalCenter
                width: 25
                height: 25
                ToolTip.text: qsTr("设置颜色")
                ToolTip.visible: mouse_a.containsMouse
                ToolTip.delay: 200

                MouseArea {
                    id: mouse_a
                    visible: true
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        colorDialog.open()
                    }
                }
            }

            Slider {
                id: slider
                stepSize: 0.01
                to: 3
                from: -3
                value: 0.5
                ToolTip.text: qsTr("偏移大小: " + value.toFixed(1))
                ToolTip.visible: hovered
                ToolTip.delay: 200
                onMoved: {
                    azimuthDial.changePointerData(textField.text,value)
                }
            }

            Button{
                width: 80
                height: 40
                text: "添加指针"
                font.family: "微软雅黑"
                onClicked: {
                    azimuthDial.appendPointer(slider.value,rectangleColor.color,textField.text)
                }
            }
            Button{
                width: 80
                height: 40
                text: "清空指针"
                font.family: "微软雅黑"
                onClicked: {
                    azimuthDial.clear()
                }
            }



        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
