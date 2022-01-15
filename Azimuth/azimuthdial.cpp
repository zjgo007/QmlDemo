#include "azimuthdial.h"

AzimuthDial::AzimuthDial(QQuickItem *parent):QQuickPaintedItem(parent)
{
    mBgLightColor = "ghostwhite";
    mBgColor = "#00192e";
    mCenterColor = "#00fa9a";
    mStartAngle = 330;
    mSpanAngle = 240;
    mDialRuleColor = "ghostwhite";
    mDialTextColor = "ghostwhite";
    mDialTextPoint = 16;
    mDialPointerColor = "#00ffff";
    mTitle = "电子校北仪\nGPS(°)";
    mTitleTextPoint = 18;
}

AzimuthDial::~AzimuthDial()
{

}

void AzimuthDial::paint(QPainter *painter)
{
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);
    painter->setRenderHint(QPainter::SmoothPixmapTransform);
    painter->translate(this->width()/2,this->height()/2);
    radius = qMin(this->width(),this->height())/2;
    drawBgLightColor(painter);
    drawScaleBgColor(painter);
    drawSlideBarColor(painter);
    drawDialCenterCross(painter);
    drawDialRule(painter);
    drawDialText(painter);
    drawPointer(painter);
    drawDialCenterColor(painter);
}

void AzimuthDial::appendPointer(const qreal angle, const QColor color,const QString name)
{
    PointerData data = {name,color,angle};
    mVector.append(data);
    update();
}

void AzimuthDial::clear()
{
    mVector.clear();
    update();
}

void AzimuthDial::changePointerData(const QString name, const qreal angle)
{
    for(int i=0;i<mVector.size();i++){
        PointerData &pointer = mVector[i];
        if(pointer.name == name){
            pointer.angle = angle;
            update();
        }
    }
}

int AzimuthDial::startAngle() const
{
    return mStartAngle;
}

void AzimuthDial::setStartAngle(const int angle)
{
    mStartAngle = angle;
    emit startAngleChanged(mStartAngle);
}

int AzimuthDial::spanAngle() const
{
    return mSpanAngle;
}

void AzimuthDial::setSpanAngle(const int angle)
{
    mSpanAngle = angle;
    emit spanAngleChanged(mSpanAngle);
}

QString AzimuthDial::title() const
{
    return mTitle;
}

void AzimuthDial::setTitle(const QString title)
{
    mTitle = title;
    emit titleChanged();
}

int AzimuthDial::titlePoint() const
{
    return mTitleTextPoint;
}

void AzimuthDial::setTitlePoint(const int point)
{
    mTitleTextPoint = point;
    emit titlePointChanged();
}

void AzimuthDial::drawBgLightColor(QPainter *painter)
{
    QConicalGradient conicalBrush(0,0,90);
    conicalBrush.setColorAt(0,mBgLightColor);
    conicalBrush.setColorAt(0.5,mBgLightColor);
    conicalBrush.setColorAt(0.12,mBgLightColor);
    conicalBrush.setColorAt(0.88,mBgLightColor.darker(40));
    conicalBrush.setColorAt(0.4,mBgLightColor.darker(30));
    conicalBrush.setColorAt(0.6,mBgLightColor.darker(30));
    conicalBrush.setColorAt(0.25,mBgLightColor.darker(160));
    conicalBrush.setColorAt(0.75,mBgLightColor.darker(160));
    conicalBrush.setColorAt(0.1,mBgLightColor);
    painter->setBrush(conicalBrush);
    painter->drawEllipse(QPointF(0,0),radius*0.95,radius*0.96);
}

void AzimuthDial::drawScaleBgColor(QPainter *painter)
{
     painter->setBrush(mBgColor);
     painter->drawEllipse(QPointF(0,0),radius*0.90,radius*0.90);
}

void AzimuthDial::drawSlideBarColor(QPainter *painter)
{
    QConicalGradient barTintColor(0,0,90);
    barTintColor.setColorAt(0,"#4d00fa9a");
    barTintColor.setColorAt(0.125,"#4d00ffff");
    barTintColor.setColorAt(0.25,"#4dffd700");
    barTintColor.setColorAt(0.375,"#4dff4500");
    barTintColor.setColorAt(0.5,"#4d00fa9a");
    barTintColor.setColorAt(0.625,"#4dff4500");
    barTintColor.setColorAt(0.75,"#4dffd700");
    barTintColor.setColorAt(0.875,"#4d00ffff");
    barTintColor.setColorAt(1,"#4d00fa9a");

    QRectF rectT(-0.9*radius,-0.9*radius,radius*1.8,radius*1.8);
    qreal subRadiusT = (radius*0.79);
    painter->setBrush(barTintColor);
    QPainterPath piePathT;
    piePathT.arcMoveTo(rectT,mStartAngle);
    piePathT.arcTo(rectT,mStartAngle,mSpanAngle);
    piePathT.lineTo(0,0);
    QPainterPath subPathT;
    subPathT.addEllipse(QPointF(0,0),subRadiusT,subRadiusT);
    piePathT = piePathT-subPathT;
    painter->drawPath(piePathT);

    QConicalGradient barColor(0,0,90);
    barColor.setColorAt(0,"#00fa9a");
    barColor.setColorAt(0.125,"#00ffff");
    barColor.setColorAt(0.25,"#ffd700");
    barColor.setColorAt(0.375,"#ff4500");
    barColor.setColorAt(0.5,"#00fa9a");
    barColor.setColorAt(0.625,"#ff4500");
    barColor.setColorAt(0.75,"#ffd700");
    barColor.setColorAt(0.875,"#00ffff");
    barColor.setColorAt(1,"#00fa9a");

    QRectF rect(-0.86*radius,-0.86*radius,radius*1.72,radius*1.72);
    qreal subRadius = (radius*0.83);
    painter->setBrush(barColor);
    QPainterPath piePath;
    piePath.arcMoveTo(rect,mStartAngle);
    piePath.arcTo(rect,mStartAngle,mSpanAngle);
    piePath.lineTo(0,0);
    QPainterPath subPath;
    subPath.addEllipse(QPointF(0,0),subRadius,subRadius);
    piePath = piePath-subPath;
    painter->drawPath(piePath);
}

void AzimuthDial::drawDialRule(QPainter *painter)
{
    QPen pen;
    pen.setColor(mDialRuleColor);
    pen.setWidth(2);
    painter->setBrush(mDialRuleColor);
    QPainterPath dialRulePath;

    qreal intervalAngle = mSpanAngle/30;
    qreal pointAngle = mSpanAngle/6;
    qreal dialRadius = radius*0.9;
    qreal subDiaRadius = radius*0.83;
    qreal pointDiaRadius = radius*0.79;

    //绘制标尺刻度线
    for(int a=0;a<=mSpanAngle;a+=intervalAngle){
        qreal currentAngle = a+mStartAngle;
        qreal r = qDegreesToRadians(currentAngle);
        const qreal x1 = dialRadius*cos(r);
        const qreal y1 = -dialRadius*sin(r);
        const qreal x2 = subDiaRadius*cos(r);
        const qreal y2 = -subDiaRadius*sin(r);
        dialRulePath.moveTo(x1,y1);
        dialRulePath.lineTo(x2,y2);
    }
    painter->setPen(pen);
    painter->drawPath(dialRulePath);

    //绘制整角度时标尺刻度线样式（三角形）旋转坐标轴绘制
    qreal pointStartAngle = mStartAngle>180 ? (mStartAngle-360):mStartAngle;
    const QPointF pointDial[4]={
        QPointF(pointDiaRadius,0),
        QPointF(pointDiaRadius,-0),
        QPointF(dialRadius,-1),
        QPointF(dialRadius,1)
    };

    for(int i=0;i<=6;i++){
        qreal rotateAngle = pointStartAngle+i*pointAngle;
        painter->rotate(-rotateAngle);
        painter->drawConvexPolygon(pointDial,4);
        painter->rotate(rotateAngle);
    }
}

void AzimuthDial::drawDialText(QPainter *painter)
{
    QPen pen;
    pen.setColor(mDialTextColor);
    pen.setWidth(2);
    painter->setFont(QFont("Euphemia",mDialTextPoint,QFont::DemiBold));
    qreal textDiaRadius = radius*0.71;
    qreal textAngle = mSpanAngle/6;
    qreal textStartAngle = mStartAngle>180 ? (mStartAngle-360):mStartAngle;
    const QStringList labels = {"3","2","1","0","1","2","3"};
    for(int i=0;i<=6;i++){
        qreal currentAngle = textStartAngle+i*textAngle;
        qreal r = qDegreesToRadians(currentAngle);
        const qreal x = textDiaRadius*cos(r);
        const qreal y = -textDiaRadius*sin(r);
        painter->drawText(QRectF(x-15,y-10,30,20),Qt::AlignHCenter|Qt::AlignVCenter,labels.at(i));
    }
}

void AzimuthDial::drawPointer(QPainter *painter)
{
    painter->setPen(Qt::NoPen);
    painter->setBrush(mDialPointerColor);
    qreal pointDiaRadius = radius*0.6;
    qreal pointBottomRadius = radius*0.1;
    const QPointF pointDial[4]={
        QPointF(-pointBottomRadius,3),
        QPointF(-pointBottomRadius,-3),
        QPointF(pointDiaRadius,-1),
        QPointF(pointDiaRadius,1),
        };

    for(auto data : mVector){
        qreal angle = data.angle;
        QColor color = data.color;
        QString name = data.name;
        qreal r = 90 - angle*(mSpanAngle/6);
        painter->rotate(-r);
        painter->setBrush(color);
        painter->drawConvexPolygon(pointDial,4);
        painter->rotate(r);
    }
}

void AzimuthDial::drawDialCenterColor(QPainter *painter)
{

    qreal centerRadius = radius*0.08;
    QRadialGradient radial(0,0,centerRadius,0,0);
    radial.setColorAt(1,mCenterColor.lighter(170));
    radial.setColorAt(0.90,mCenterColor.lighter(150));
    radial.setColorAt(0.82,mCenterColor.lighter(130));
    radial.setColorAt(0.7,mCenterColor);
    painter->setBrush(radial);
    painter->drawEllipse(QPointF(0,0),centerRadius,centerRadius);
    //绘制标签
    QPen pen;
    pen.setColor(mDialTextColor);
    pen.setWidth(2);
    painter->setPen(pen);
    painter->setFont(QFont("微软雅黑",mTitleTextPoint,QFont::DemiBold));
    painter->drawText(QRectF(-100,centerRadius*2,200,60),Qt::AlignHCenter|Qt::AlignVCenter,mTitle);

    QImage pixmapGPS(":/gps.png");
    painter->drawImage(QRectF(-centerRadius,-centerRadius,centerRadius*2,centerRadius*2),pixmapGPS,QRectF(0,0,79,79));
    QImage pixmapLogo(":/logo.png");
    painter->drawImage(QRectF(-centerRadius*3.2,centerRadius*2+70,centerRadius*6.4,centerRadius*3),pixmapLogo,QRectF(0,0,300,128));
}

void AzimuthDial::drawDialCenterCross(QPainter *painter)
{
    qreal crossRadiusBrush = radius*0.65;

    painter->setPen(Qt::NoPen);
    QLinearGradient gradientH(0,-10,0,10);
    QLinearGradient gradientV(-10,0,10,0);
    gradientH.setColorAt(0,"#3300fa9a");
    gradientH.setColorAt(0.5,"#00fa9a");
    gradientH.setColorAt(1,"#3300fa9a");
    gradientV.setColorAt(0,"#3300fa9a");
    gradientV.setColorAt(0.5,"#00fa9a");
    gradientV.setColorAt(1,"#3300fa9a");
    painter->setBrush(gradientH);
    painter->drawRect(-crossRadiusBrush,-10,crossRadiusBrush*2,20);
    painter->setBrush(gradientV);
    painter->drawRect(-10,-crossRadiusBrush,20,crossRadiusBrush);

}
