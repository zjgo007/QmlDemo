# MyMapVectorLine

![](https://img-blog.csdnimg.cn/609682e0c80c40f8b852345bcd2d1690.gif)

### MyMapVectorLine属性：
> color:路径和标志颜色
> 
> lineWidth:路径线宽度
> 
> markWidth:标志的宽
> 
> markHeight:设置标志的高
> 
> markSource:设置标志的图片源

### MyMapVectorLine方法：
> appendPoint(coordinate c):往矢量路径中添加经纬度数据，数据添加后组件会根据最新数据方位设置标志朝向
> 
> removePoint():从矢量路径中移除最后一个数据，该数据移除后组件会根据最新数据方位设置标志朝向
> 
> clear():清空矢量路径中的所有数据