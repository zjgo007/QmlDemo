# QML 地图可拖拽位置标签组件
在地图上显示位置信息时，有时候需要同时显示该位置的详细信息。该组件可在地图上显示一个连接到地图地理位置的标签框，该标签框可点击进行拖拽。在地理位置改变、地图缩放、地图平移时，该标签框的相对位置保持不变。（注意：该组件父类必须为Map）如图：效果如图：</br>
![](https://img-blog.csdnimg.cn/cb29a6b54e974bb3852cfb974db7cf1a.gif)</br>
　　
### 属性
> name：组件名，用于查找组件
> 
> anchorCoordinate：标签点指向的经纬度
> 
> backgroundColor：背景颜色
> 
> borderColor：边框颜色
> 
> lineColor：连接线颜色

### 方法
> update():绘制标签
> 
> pointsChanged(coordinate)：更新标签位置
