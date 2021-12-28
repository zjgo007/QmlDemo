import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.2

Window {
    visible: true
    width: 640
    height: 480

    PolarChartView {
        id:polarChartView
        title: "自定义Legend"
        anchors.fill: parent
        antialiasing: true

        MyLegend{
            id:myLegend
            width: 120
            height: 30
            labelColor: "darkgrey"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

        }

        ValueAxis {
            id: axisAngular
            min: 0
            max: 20
            tickCount: 9
        }

        ValueAxis {
            id: axisRadial
            min: -0.5
            max: 1.5
        }

        SplineSeries {
            id: series1
            name:"线状图"
            axisAngular: axisAngular
            axisRadial: axisRadial
            pointsVisible: true
        }

        ScatterSeries {
            id: series2
            name:"点状图"
            axisAngular: axisAngular
            axisRadial: axisRadial
            markerSize: 10
        }
    }

    Component.onCompleted: {
        polarChartView.legend.visible = false
        myLegend.addSeries(series1,series1.name,series1.color)
        myLegend.addSeries(series2,series2.name,series2.color)

        for (var i = 0; i <= 20; i++) {
            series1.append(i, Math.random());
            series2.append(i, Math.random());
        }
    }

    Connections{
        target: myLegend
        onSelected:{
            series.visible = !series.visible
        }
    }
}
