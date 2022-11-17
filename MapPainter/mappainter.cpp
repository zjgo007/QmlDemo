#include "mappainter.h"

MapPainter::MapPainter(QQuickItem *parent):QQuickPaintedItem(parent),pathDirty(false)
{
    testPath = new QPainterPath();
    connect(this,&QQuickPaintedItem::widthChanged,this,&MapPainter::mapRegionChanged);
    connect(this,&QQuickPaintedItem::heightChanged,this,&MapPainter::mapRegionChanged);
}

MapPainter::~MapPainter()
{
    delete testPath;
}

void MapPainter::paint(QPainter *painter)
{
    if(pathDirty)
        updatePainterPath();

    painter->setPen(QPen(QColor("red"), 2, Qt::SolidLine,
                         Qt::RoundCap, Qt::RoundJoin));

    painter->drawPath(*testPath);
}

void MapPainter::setQmlObject(QObject *object)
{
    qmlObject = object;
}

void MapPainter::addPathPoint(qreal x, qreal y, QGeoCoordinate coordinate)
{
    if(testPath->elementCount()==0){
        testPath->moveTo(x,y);
        mGeoPainterPath.addGeoPath(GeoPainterPath::MoveTo,coordinate);
    }else{
        testPath->lineTo(x,y);
        mGeoPainterPath.addGeoPath(GeoPainterPath::LineTo,coordinate);
    }
    update();
}

void MapPainter::updatePainterPath()
{
    if(qmlObject){
        testPath->clear();
        int size = mGeoPainterPath.size();
        for(int i=0;i<size;i++){
            QGeoCoordinate coordinate = mGeoPainterPath.coordinate(i);
            QVariant mapPointVar;
            QMetaObject::invokeMethod(qmlObject,"transGeoToPoint",Qt::DirectConnection,
                                      Q_RETURN_ARG(QVariant,mapPointVar),
                                      Q_ARG(QVariant,QVariant::fromValue(coordinate))
                                      );
            GeoPainterPath::PainterType painterType = mGeoPainterPath.painterType(i);
            QPointF mapPoint = mapPointVar.toPointF();
            switch (painterType) {
            case GeoPainterPath::MoveTo:
                testPath->moveTo(mapPoint);
                break;
            case GeoPainterPath::LineTo:
                testPath->lineTo(mapPoint);
                break;
            default:
                break;
            }
        }
        pathDirty = false;
    }
}

void MapPainter::mapRegionChanged()
{
    pathDirty = true;
    update();
}

QGeoCoordinate MapPainter::mapPathData(qreal percent)
{
    QPointF pointf = testPath->pointAtPercent(percent);
    QVariant coordinateVar;
    QMetaObject::invokeMethod(qmlObject,"transPointToGeo",Qt::DirectConnection,
                              Q_RETURN_ARG(QVariant,coordinateVar),
                              Q_ARG(QVariant,QVariant::fromValue(pointf)));
    return coordinateVar.value<QGeoCoordinate>();
}

void GeoPainterPath::addGeoPath(PainterType type, QGeoCoordinate coordinate)
{
    typeList.append(type);
    geoList.append(coordinate);
}

GeoPainterPath::PainterType GeoPainterPath::painterType(int index)
{
    if(index>=typeList.size()){
        return PainterType::None;
    }
    return typeList.at(index);
}

QGeoCoordinate GeoPainterPath::coordinate(int index)
{
    if(index>=geoList.size()){
        return QGeoCoordinate();
    }
    return geoList.at(index);
}

int GeoPainterPath::size()
{
    return geoList.size();
}

void GeoPainterPath::clear()
{
    typeList.clear();
    geoList.clear();
}
