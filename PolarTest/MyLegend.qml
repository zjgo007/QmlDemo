import QtQuick 2.0
//import QtCharts 2.0
import QtQuick.Layouts 1.3
//import QtQuick.Controls 2.4

Rectangle {
    id: legend
    color: "#00000000"
    z:15
    property int seriesCount: 0
    property var seriesNames: []
    property var seriesColors: []
    property var labelNames: []
    property color labelColor: "white"
    signal selected(var series)

    function addSeries(seriesName,labelName, color) {
        seriesNames.push(seriesName)
        labelNames.push(labelName)
        seriesColors.push(color)
        seriesCount++;
    }

    function removeSeries(seriesName){
        var s = seriesNames.indexOf(seriesName)
        seriesNames.splice(s,1)
        unitNames.splice(s,1)
        seriesColors.splice(s,1)
        seriesCount--;
    }

    //![2]
    Component {
        id: legendDelegate
        Rectangle {
            id: rect
            property var currentSeries: seriesNames[index]
            property var currentName: labelNames[index]
            property color markerColor: seriesColors[index]
            color: "#00000000"
            radius: 4
            implicitWidth: parent.width
            implicitHeight: label.implicitHeight + marker.implicitHeight + 10

            Row {
                id: row
                spacing: 10
                anchors.fill: parent

                Rectangle {
                    id: marker
                    anchors.verticalCenter: parent.verticalCenter
                    color: markerColor
                    width: 15
                    height: 15
                }
                Text {
                    id: label
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 0
                    text: currentName
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: labelColor
                    font.family: "微软雅黑"
                    font.pointSize: 15
                    font.bold: true
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    emit: legend.selected(currentSeries);
                }
            }
        }
    }

    ColumnLayout {
        id: legendRow
        anchors.fill: parent

        Repeater {
            id: legendRepeater
            model: seriesCount
            delegate: legendDelegate
        }

    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
