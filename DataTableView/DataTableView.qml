import QtQuick 2.11
import QtQuick.Controls 2.4

ListView {
    id: listView
    clip: true
    header: headerView
    headerPositioning: ListView.OverlayHeader
    flickableDirection: Flickable.AutoFlickDirection
    contentWidth: headerList.length*columnsWidth
    ScrollBar.horizontal: ScrollBar {}
    ScrollBar.vertical: ScrollBar { }
    property var headerList: model.isSqlModel?model.getHeaderList():Object.keys(model.get(0)).reverse()
    property int columnsWidth: 100
    property int headerHeight: 40
    property int rowsHeight: 30
    property color headerTextColor:"#1c262b"
    property color headerBackgroundColor: "turquoise"
    property int headerTextSize: 13
    property string headerFontFamily: "微软雅黑"
    property color backgroundColor: "#cc7fc7df"
    property color alternateBackgroundColor: "#cc17719b"
    property color gridColor: "#99999999"
    property int gridPoint: 1
    property color textColor: "ghostwhite"
    property int textSize: 11
    property string textFontFamily: "微软雅黑"
    boundsBehavior: Flickable.StopAtBounds

    move: Transition {
        NumberAnimation { properties: "x,y"; duration: 1000 }
    }

    Component{
        id:headerView
        Rectangle{
            width: contentWidth
            height: headerHeight
            color: headerBackgroundColor
            z:15
            property var headerRepeater: headerRepeater
            Row{
                Repeater{
                    id:headerRepeater
                    model:headerList
                    Label{
                        width: columnsWidth
                        height: headerHeight
                        color: headerTextColor
                        text:headerList[index]
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: headerFontFamily
                        font.pointSize: headerTextSize
                        background: Rectangle{
                            color: "#00000000"
                            border.color: gridColor
                            border.width: gridPoint
                        }
                    }
                }
            }
        }
    }
    Component{
        id:listDelegate
        Rectangle{
            width: contentWidth
            height: rowsHeight
            color: index%2 ==0 ? backgroundColor:alternateBackgroundColor
            property var myModel: model
            property var modelColumnsList: listView.model.isSqlModel?listView.model.getHeaderList():Object.keys(listView.model.get(0)).reverse()
            Row{
                Repeater{
                    id:delegateRepeater
                    model:headerList
                    Label{
                        width: listView.headerItem.headerRepeater.itemAt(index).width
                        height: rowsHeight
                        color: textColor
                        text:myModel[modelColumnsList[index]]
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: textFontFamily
                        font.pointSize: textSize
                        elide:Text.ElideRight
                        background: Rectangle{
                            color: "#00000000"
                            border.color: gridColor
                            border.width: gridPoint
                        }
                    }
                }
            }
        }

    }
    delegate:listDelegate


    function setColumnWidth(index,width){
        var headerItem = listView.headerItem.headerRepeater.itemAt(index)
        contentWidth = contentWidth - headerItem.width+width
        headerItem.width = width
    }

    function getColumnWidth(index){
        var headerItem = listView.headerItem.headerRepeater.itemAt(index)
        return headerItem.width
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
