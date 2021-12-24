import QtQuick 2.7
import QtQml 2.7
import QtQuick.Controls 2.4

ApplicationWindow {
    id: applicationWindow
    width: 680
    height: 640
    visible: true
    title: qsTr("My Time Pie Chart")
    background: Rectangle{
        color: "#031824"
    }

    MyTimePieChart{
        id:myTimePieChart
        anchors.fill: parent
        onHoved: {
            if(state)
                tips.text = "第"+Number(order+1)+"组数据，第"+position+"个数据，数据值："+value
            else
                tips.text = ""
        }
    }

    Text {
        id: tips
        color: "#e8e8e8"
        text: qsTr("Text")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.pointSize: 12
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
    }

    Component.onCompleted: {
        var list1 = [0,0,3,0,5,0,0,0,0,0,0,0,7,6,8,7,5,0,0,0,0,0,0,0]
        var list2 = [0,0,1,2,3,4,0,0,0,0,0,0,5,4,3,2,4,0,0,0,0,7,0,0]
        var list3 = [0,0,3,2,5,2,0,0,0,4,0,0,9,8,5,2,1,0,0,0,0,0,0,0]
        var list4 = [0,0,0,0,1,1,0,0,0,0,0,0,6,5,7,4,0,6,0,0,5,0,0,0]
        var list5 = [0,0,3,2,3,2,0,0,0,0,0,0,4,5,4,7,0,0,0,8,7,0,0,0]

        myTimePieChart.donutCount = 5
        myTimePieChart.maxValue = 10

        for(var i in list1){
            var value1 =  list1[i]
            if(value1>0){
                myTimePieChart.setDonutValue(0,i,value1,"data1")
            }
        }
        for(var j in list2){
            var value2 =  list2[j]
            if(value2>0){
                myTimePieChart.setDonutValue(1,j,value2,"data2")
            }
        }
        for(var k in list3){
            var value3 =  list3[k]
            if(value3>0){
                myTimePieChart.setDonutValue(2,k,value3,"data3")
            }
        }
        for(var m in list4){
            var value4 =  list4[m]
            if(value4>0){
                myTimePieChart.setDonutValue(3,m,value4,"data4")
            }
        }
        for(var n in list5){
            var value5 =  list5[i]
            if(value5>0){
                myTimePieChart.setDonutValue(4,n,value5,"data5")
            }
        }
    }
}
