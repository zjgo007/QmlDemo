import QtQuick 2.1
import QtQuick.Window 2.1

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ResizableRectangle{
        x:100
        y:100
        width: 100
        height: 100
        color: "red"
    }
}
