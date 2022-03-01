# QmlDemo
配合博客的一些示例程序，博客地址https://blog.csdn.net/zjgo007

# MapLabel
　　在地图上显示位置信息时，有时候需要同时显示该位置的详细信息。该组件可在地图上显示一个连接到地图地理位置的标签框，该标签框可点击进行拖拽。在地理位置改变、地图缩放、地图平移时，该标签框的相对位置保持不变。</br>
![](https://img-blog.csdnimg.cn/cb29a6b54e974bb3852cfb974db7cf1a.gif)

# AzimuthDial
　　校北仪用于显示不同设备与参照方位之间的误差夹角，如果仅仅使用柱状图显示多个不同设备误差的数值，数据不够直观表示，因此自己画一个，效果如图该控件使用QQuickPaintedItem进行绘制后在QML中进行使用，相关部分参数已提供设置接口供QML中调用，如果该控件需要在QWidget中使用，将QQuickPaintedItem修改为QWidget即可。在Demo中演示了如何添加不同方位夹角，不同颜色的指针，并根据指针名称动态修改数据。</br>
![](https://img-blog.csdnimg.cn/89a639ed26f04fe4886ba466c9371036.gif)

# MyMapVectorLine
 　　Qml地图中提供了MapPolyline用于在地图上绘制路线，但是该控件无法显示目标的方位矢量，因此我在MapPolyline的基础上制作了MyMapVectorLine，该控件可自定义矢量标志图片样式,并根据存入数据自动计算标志方位朝向，组件颜色和标志可动态设置，效果如图：</br>
![](https://img-blog.csdnimg.cn/609682e0c80c40f8b852345bcd2d1690.gif)

# MyTimePieChart
　　嵌套甜甜圈图，每个小圈内的切片具有相同角度，每个切片采用不同颜色（热力值）代表该切片处数值的大小，该图表适用于展示具有相同周期的重复数据的密度，应用于例如连续多日的24小时各时段数据密度等场景，Demo效果图：</br>
![热力甜甜圈图](https://img-blog.csdnimg.cn/3ab837a34e1441da88414ff766e1686e.gif)

# SliderDemo
　　该QML播放条控件能够根据设置的起始时间，提供播放、暂停、变速播放、前进、倒退、滑动条控制，状态显示等功能，控件如图：</br>
![播放条](https://img-blog.csdnimg.cn/20210613160952733.png)

# DataTableView
　　在ListView的基础上制作了TableView，提供了类似于QTableView中只需要提供model，表头、表数据等等由控件自动绑定相应属性，且控件在保留ListView所有属性的同时，添加了自定义表头,表头默认宽度、表头颜色、字体颜色、表头高度、内容高度、单独设置各列宽度，横纵滚动条等功能。如图：</br>
![](https://img-blog.csdnimg.cn/20210113153402329.png)

# QmlSqlQueryModel
　　C++中的SQL处理的Model,QML可直接进行加载展示。

# SinPlot
　　水球状的百分比控件，因此用Canvas画了一个，原理比较简单，底层画一个正弦波，上面覆盖一个圆，然后两个图层Clip后即可得到需要的形状，代码较为简单，该控件可修改前景色、背景色、球体边框颜色；可自定义是否开启水波动画等功能（水波动画由计时器重绘而成，讲究效率的代码中不建议开启，建议在数据改变时设置数值的方式添加动态效果）</br>
![](https://img-blog.csdnimg.cn/20200803170601827.gif)

# VLC-Qt-QML
在QML中使用VLC播放网络流视频，详细介绍见博客[QML中使用VLC](https://blog.csdn.net/zjgo007/article/details/107534075?spm=1001.2014.3001.5501)，效果图：</br>
![](https://img-blog.csdnimg.cn/20200723130014344.gif)

# LocationMap
　　在线加载地图，支持输入经纬度，点击地图获取地理位置，根据位置添加覆盖图，支持地图测距，中心点保存等功能，方便布局规划，适合电商网点布局，覆盖中心规划等场景需求！由于默认的osm库的street map源地址已失效无法访问,可修改地图源地址或地图类型，效果展示：</br>
![](https://img-blog.csdnimg.cn/20200706231351292.gif)

# PolarTest
　QML ChartView中提供了默认的Legend，可对图例进行一些简单的例如颜色、字体等的设置，但是当需要图例具有个性化的功能时（如单击时隐藏或显示）时，就需要使用自定义的Legend。效果：</br>
![](https://img-blog.csdnimg.cn/20200404131934916.gif#pic_center)

