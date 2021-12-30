# MyTimePieChart
　　嵌套甜甜圈图，每个小圈内的切片具有相同角度，每个切片采用不同颜色（热力值）代表该切片处数值的大小，该图表适用于展示具有相同周期的重复数据的密度，应用于例如连续多日的24小时各时段数据密度等场景，Demo效果图：
　　![热力甜甜圈图](https://img-blog.csdnimg.cn/3ab837a34e1441da88414ff766e1686e.gif#pic_center)

## 属性
 - [readonly]**donutSeries**:嵌套的每一圈的对象列表
 - **donutCount**:嵌套的圈数
 - **maxValue**：所有数据中最大的值（用于热力计算，如不设置热力计算值有偏差）
 - **minSize**:最内圈尺寸（0~1）
 - **maxSize**:最外圈尺寸（0~1）
 - **backgroundColor**:控件的背景色
 - **defaultColor**:无数据值时切片颜色（默认为"#000000"）
 - **labelVisible**：切片外标签是否显示
 - **sliceCount**：每个小圈的切片数，默认：24
 - **heatLegend**：热力颜色标识是否显示
 - **donutAnimation**：鼠标悬浮于切片时，切片旋转动画是否显示，默认：true
 - **explodeDistanceFactor**：鼠标悬浮于切片时，切片向外拓展的距离

## 信号
 - **hoved(var slice,var order,var position,var value,var state)**:鼠标悬浮切片时发出该信号，返回当前切片的对象，所处的嵌套圈序列，在该圈中切片的位置，切片值，悬浮状态

## 函数
 - **setDonutValue(int order,int positon,int value,string name)**:设置每个切片的数值，**注意：使用该函数前，请先设置donutCount**
 
### MyTimePieChart完整代码：
```javascript
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

```