#include "mapheatimage.h"

MapHeatImage::MapHeatImage(QQuickItem *parent):QQuickPaintedItem(parent),mMaxCount(1),mLegendVisible(true),mHideZeroPoint(true)
{
    drawColorImage();
}

MapHeatImage::~MapHeatImage()
{

}

void MapHeatImage::paint(QPainter *painter)
{
    painter->drawImage(QPoint(0,0),mHeatImage);
    if(mLegendVisible){
        painter->drawImage(QPoint(10,10),mColorImage);
    }
}

void MapHeatImage::appendListPos(QPointF pos)
{
    QPoint p = pos.toPoint();
    int count = mPosList.count(p);
    if(count>mMaxCount){
        mMaxCount = count;
    }
    mPosList.append(p);
}

void MapHeatImage::paintHeat()
{
    if(mPosList.isEmpty()){
        return;
    }
    QPen pen;
    pen.setWidth(0);
    pen.setColor("#00000000");
    alphaImage = QImage(this->width(),this->height(),QImage::Format_Alpha8);//只存有透明度
    alphaImage.fill(Qt::transparent);
    QPainter dataPainter;
    dataPainter.begin(&alphaImage);
    dataPainter.setPen(pen);

    mAlpha = 255/mMaxCount;
    for(QPoint point : mPosList){
        QRadialGradient gradient(point,mDiffraction);
        gradient.setColorAt(0,QColor(255,0,0,mAlpha));
        gradient.setColorAt(1,QColor(0,0,0,0));

        dataPainter.setBrush(gradient);
        dataPainter.drawEllipse(point,mDiffraction,mDiffraction);
    }
    transAlphaToColor();
}

void MapHeatImage::transAlphaToColor()
{
    mHeatImage = QImage(this->width(),this->height(),QImage::Format_ARGB32);
    mHeatImage.fill(Qt::transparent);
    QPainter heatPainter(&mHeatImage);
    for(int r=0;r<alphaImage.height();r++){
        const uchar *line_data = alphaImage.scanLine(r);
        QRgb* line_heat = reinterpret_cast<QRgb*>(mHeatImage.scanLine(r));
        for(int c=0;c<alphaImage.width();c++){
            if(mHideZeroPoint){
                if(line_data[c]>0)
                    line_heat[c] = colorList[line_data[c]];
            }else{
                line_heat[c] = colorList[line_data[c]];
            }
        }
    }
    update();
}


void MapHeatImage::clear()
{
    mPosList.clear();
    mMaxCount = 1;

}

bool MapHeatImage::legendVisible() const
{
    return mLegendVisible;
}

void MapHeatImage::setLegendVisible(const bool visible)
{
    mLegendVisible = visible;
    emit legendVisibleChanged(visible);
    update();
}

bool MapHeatImage::hideZeroPoint() const
{
    return mHideZeroPoint;
}

void MapHeatImage::setHideZeroPoint(const bool hide)
{
    mHideZeroPoint = hide;
    emit hideZeroPointChanged(hide);
    transAlphaToColor();
}

int MapHeatImage::diffraction() const
{
    return mDiffraction;
}

void MapHeatImage::setDiffraction(const int diffraction)
{
    mDiffraction = diffraction;
    emit diffractionChanged(diffraction);
    paintHeat();
}

void MapHeatImage::drawColorImage()
{
    QLinearGradient colorGradient = QLinearGradient(QPoint(0,255),QPoint(0,0));
    colorGradient.setColorAt(0,Qt::blue);
    colorGradient.setColorAt(0.2,Qt::cyan);
    colorGradient.setColorAt(0.4,Qt::green);
    colorGradient.setColorAt(0.6,Qt::yellow);
    colorGradient.setColorAt(0.8,Qt::magenta);
    colorGradient.setColorAt(0.95,Qt::red);
    mColorImage = QImage(20,256,QImage::Format_ARGB32);
    QPainter painter(&mColorImage);
    painter.fillRect(mColorImage.rect(),colorGradient);
    for(int i=255;i>-1;i--){
        colorList.append(mColorImage.pixel(0,i));
    }

}

