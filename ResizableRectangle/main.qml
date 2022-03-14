import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 2.1

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Resizable Widget")
    color: "bisque"

    Rectangle {
        id: rectangle
        x: 10
        y: 10
        width: 100
        height: 100
        color: "yellow"

        Button {
            text: qsTr("Button")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                text = "Yellow Clicked!"
            }
        }

        ResizableRectangle{
            resizeTarget: rectangle
        }
    }

    Image {
        id: image
        x: 515
        y: 358
        width: 100
        height: 100
        source: "qrc:/qt-logo.jpg"
        MouseArea{
            anchors.fill: parent
            drag.target: image
        }

        ResizableRectangle{
            resizeTarget: image
        }
    }

}
