# Qt QML 自绘GPS方位校北仪控件
 校北仪用于显示不同设备与参照方位之间的误差夹角，如果仅仅使用柱状图显示多个不同设备误差的数值，数据不够直观表示，因此自己画一个，效果如图：</br>
![](https://img-blog.csdnimg.cn/89a639ed26f04fe4886ba466c9371036.gif)</br>
　　该控件使用QQuickPaintedItem进行绘制后在QML中进行使用，相关部分参数已提供设置接口供QML中调用，如果该控件需要在QWidget中使用，将QQuickPaintedItem修改为QWidget即可。在Demo中演示了如何添加不同方位夹角，不同颜色的指针，并根据指针名称动态修改数据。控件提供的相关接口如下，如果有其他接口需求，可下方留言提供建议，本人不断完善。
### 属性
> title:设置表盘中文字内容
> 
> titlePoint：设置表盘中文字大小
> 
> beginAngle：设置表盘刻度起始方位角，默认为（330）
> 
> spanAngle：设置表盘刻度拓展角度，默认为（240）

### 方法
> void appendPointer(const qreal angle, const QColor color, const QString name):往控件中添加新的数据指针【angle:方位夹角（取值范围：-3~3）；color:指针颜色；name:指针名称】
> 
> void changePointerData(const QString name,const qreal angle)：根据指针名修改指针数值
> 
> void clear()：清除表盘中所有数据指针
> 