#ifndef MAPHEATIMAGE_H
#define MAPHEATIMAGE_H

#include <QQuickPaintedItem>
#include <QObject>
#include <QPainter>
#include <QImage>

class MapHeatImage : public QQuickPaintedItem
{
    Q_OBJECT
public:
    MapHeatImage(QQuickItem *parent = nullptr);
    ~MapHeatImage();
    virtual void paint(QPainter* painter) override;
    Q_PROPERTY(bool legendVisible READ legendVisible WRITE setLegendVisible NOTIFY legendVisibleChanged)
    Q_PROPERTY(bool hideZeroPoint READ hideZeroPoint WRITE setHideZeroPoint NOTIFY hideZeroPointChanged)
    Q_PROPERTY(int diffraction READ diffraction WRITE setDiffraction NOTIFY diffractionChanged)


public slots:
    void appendListPos(QPointF pos);
    void paintHeat();
    void clear();

signals:
    void legendVisibleChanged(bool visible);
    void hideZeroPointChanged(bool hide);
    void diffractionChanged(int diffraction);

private:
    QList<QPoint> mPosList;
    int mMaxCount;
    int mAlpha;
    int mDiffraction = 15;
    bool mLegendVisible;
    bool mHideZeroPoint;

    bool legendVisible() const;
    void setLegendVisible(const bool visible);

    bool hideZeroPoint() const;
    void setHideZeroPoint(const bool hide);

    int diffraction() const;
    void setDiffraction(const int diffraction);

    void setPaintHeat(const bool paintHeat);
    void drawColorImage();
    void transAlphaToColor();
    QImage alphaImage;
    QImage mColorImage;
    QImage mHeatImage;

    QList<QRgb> colorList;
};

#endif // MAPHEATIMAGE_H
