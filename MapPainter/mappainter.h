#ifndef MAPPAINTER_H
#define MAPPAINTER_H

#include <QQuickPaintedItem>
#include <QObject>
#include <QPainter>
#include <QPainterPath>
#include <QGeoCoordinate>

class GeoPainterPath
{
public:
    GeoPainterPath() {}
    ~GeoPainterPath(){}

    enum PainterType{
        None,
        MoveTo,
        LineTo
    };

    void addGeoPath(PainterType type,QGeoCoordinate coordinate);

    PainterType painterType(int index);

    QGeoCoordinate coordinate(int index);

    int size();

    void clear();

private:
    QList<PainterType> typeList;
    QList<QGeoCoordinate> geoList;
};

class MapPainter : public QQuickPaintedItem
{
    Q_OBJECT
public:
    MapPainter(QQuickItem *parent = nullptr);
    ~MapPainter();
    virtual void paint(QPainter *painter) Q_DECL_OVERRIDE;

    Q_INVOKABLE void setQmlObject(QObject* object);

public slots:
    void addPathPoint(qreal x,qreal y,QGeoCoordinate coordinate);
    void updatePainterPath();
    void mapRegionChanged();

    QGeoCoordinate mapPathData(qreal percent);

private:
    QPainterPath* testPath;
    bool pathDirty;
    GeoPainterPath mGeoPainterPath;
    QObject* qmlObject;
};


#endif // MAPPAINTER_H
