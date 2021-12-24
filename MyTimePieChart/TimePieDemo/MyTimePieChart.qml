import QtQuick 2.11
import QtQml 2.11
import QtCharts 2.2

ChartView {
      id: chart
      antialiasing: true
      backgroundColor: "transparent"
      title: "甜甜圈图"
      titleFont.family: "微软雅黑"
      titleFont.bold: true
      titleFont.pointSize: 15
      titleColor: "#38d3dc"
      animationOptions: ChartView.SeriesAnimations

      readonly property var donutSeries: []
      property int donutCount: 0
      property double minSize : 0.08
      property double maxSize: 0.9
      property color defaultColor: "#000000"
      property int maxValue: 2
      property bool labelVisible: true
      property int sliceCount: 24
      property bool heatLegend: true
      property bool donutAnimation: true
      property double explodeDistanceFactor: 0.15

      signal hoved(var slice,var order,var position,var value,var state)

      Rectangle{
          width: 20
          height: parent.height*3/5
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.rightMargin: 0
          visible: heatLegend
          gradient: Gradient {
              GradientStop {
                  position: 0
                  color: "red"
              }

              GradientStop {
                  position: 0.2
                  color: "magenta"
              }
              GradientStop {
                  position: 0.4
                  color: "yellow"
              }
              GradientStop {
                  position: 0.6
                  color: "green"
              }
              GradientStop {
                  position: 0.8
                  color: "cyan"
              }
              GradientStop {
                  position: 1
                  color: "blue"
              }

          }

      }

      onDonutCountChanged: {
          for(var i=0;i<donutCount;i++){
              var pie = chart.createSeries(ChartView.SeriesTypePie,String(i))
              pie.onHovered.connect(explodeSlice)
              donutSeries.push(pie)
              for(var j=0;j<sliceCount;j++){
                  var sliceLabel = String(j)+ "~" + String(j+1)
                  var slice = pie.append(sliceLabel,1)
                  slice.color = "#00000000"
                  slice.borderColor = "#38d3dc"
                  slice.explodeDistanceFactor=0.05
                  slice.seriesIndex = i
                  slice.sliceIndex = j
                  slice.heat = 0
                  if(i==donutCount-1){
                      slice.labelVisible = chart.labelVisible
                      slice.labelArmLengthFactor = 0
                      slice.labelColor = "ghostwhite"
                  }
              }
              pie.holeSize = minSize + i * (maxSize - minSize) / donutCount
              pie.size = minSize + (i + 1) * (maxSize - minSize) / donutCount
          }
      }

      function setDonutValue(order,positon,value,name){
          if(order>=donutSeries.length || positon>=sliceCount)
              return
          var pie = donutSeries[order]
          var slice = pie.at(positon)
          slice.order = order
          slice.name = name
          if(value>maxValue){
              maxValue = value
          }
          var colorIndex = Math.ceil(value*100/maxValue)
          slice.color = heatList[colorIndex]
          slice.heat = value

      }

      function explodeSlice(slice,exploded){
          if(donutAnimation){
              if(exploded){
                  var sliceStartAngle = slice.startAngle
                  var sliceEndAngle = slice.startAngle+slice.angleSpan
                  for(var i=slice.seriesIndex+1;i<donutSeries.length;i++){
                      donutSeries[i].startAngle = sliceEndAngle
                      donutSeries[i].endAngle = 360 + sliceStartAngle
                  }
              }else{
                  for(var j=slice.seriesIndex+1;j<donutSeries.length;j++){
                      donutSeries[j].startAngle = 0
                      donutSeries[j].endAngle = 360
                  }
              }
          }
          slice.explodeDistanceFactor = explodeDistanceFactor
          slice.exploded = exploded
          hoved(slice,slice.seriesIndex,slice.sliceIndex,slice.heat,exploded)
      }


      margins{
          left:0;right:20;top:0;bottom: 0
      }

      legend{
          visible: false
      }

      readonly property var heatList: [defaultColor, defaultColor, "#001cff", "#0026ff", "#0035ff", "#003fff", "#004eff", "#0058ff", "#0067ff", "#0071ff", "#007fff", "#008eff", "#0098ff", "#00a7ff", "#00b1ff", "#00c0ff", "#00caff", "#00daff", "#00e4ff", "#00f3ff", "#00fdff", "#00fff2", "#00ffe3", "#00ffd9", "#00ffca", "#00ffc0", "#00ffb1", "#00ffa7", "#00ff98", "#00ff8e", "#00ff7f", "#00ff71", "#00ff67", "#00ff58", "#00ff4e", "#00ff3f", "#00ff35", "#00ff26", "#00ff1c", "#00ff0d", "#00ff03", "#0cff00", "#1bff00", "#25ff00", "#34ff00", "#3eff00", "#4dff00", "#57ff00", "#66ff00", "#70ff00", "#80ff00", "#8fff00", "#99ff00", "#a8ff00", "#b2ff00", "#c1ff00", "#cbff00", "#daff00", "#e4ff00", "#f3ff00", "#fdff00", "#fff20d", "#ffe31c", "#ffd926", "#ffca35", "#ffc03f", "#ffb14e", "#ffa758", "#ff9867", "#ff8e71", "#ff7f7f", "#ff718e", "#ff6798", "#ff58a7", "#ff4eb1", "#ff3fc0", "#ff35ca", "#ff26d9", "#ff1ce3", "#ff0df2", "#ff03fc", "#ff00f0", "#ff00dc", "#ff00ce", "#ff00b9", "#ff00ab", "#ff0097", "#ff008a", "#ff0077", "#ff006a", "#ff0056", "#ff0042", "#ff0034", "#ff0020", "#ff0013", "#ff0000", "#ff0000", "#ff0000", "#ff0000", "#ff0000", "#ff0000"]
  }

