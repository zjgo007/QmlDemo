# QmlDemo
配合博客的一些示例程序，博客地址https://blog.csdn.net/zjgo007

# MyTimePieChart
　　嵌套甜甜圈图，每个小圈内的切片具有相同角度，每个切片采用不同颜色（热力值）代表该切片处数值的大小，该图表适用于展示具有相同周期的重复数据的密度，应用于例如连续多日的24小时各时段数据密度等场景，Demo效果图：</br>
　　![热力甜甜圈图](https://img-blog.csdnimg.cn/3ab837a34e1441da88414ff766e1686e.gif#pic_center)
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
