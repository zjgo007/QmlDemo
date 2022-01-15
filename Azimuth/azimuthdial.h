#ifndef AZIMUTHDIAL_H
#define AZIMUTHDIAL_H

#include <QQuickPaintedItem>
#include <QObject>
#include <QPainter>
#include <QtMath>
#include <QVector>
#pragma execution_character_set("utf-8")
class AzimuthDial : public QQuickPaintedItem
{
    Q_OBJECT
public:
    AzimuthDial(QQuickItem *parent = nullptr);
    ~AzimuthDial();
    virtual void paint(QPainter* painter) override;
    struct PointerData//存储校北指针数据
    {
        QString name;
        QColor color;
        qreal angle;
    };
    Q_PROPERTY(int beginAngle READ startAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(int spanAngle READ spanAngle WRITE setSpanAngle NOTIFY spanAngleChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int titlePoint READ titlePoint WRITE setTitlePoint NOTIFY titlePointChanged)

    Q_INVOKABLE void appendPointer(const qreal angle, const QColor color, const QString name);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void changePointerData(const QString name,const qreal angle);

private:
    int radius;
    int mStartAngle,mSpanAngle;
    QColor mBgLightColor,mBgColor,mCenterColor,mDialRuleColor,mDialTextColor,mDialPointerColor;
    int mDialTextPoint,mTitleTextPoint;
    QString mTitle;
    QVector<PointerData>mVector;

    int startAngle() const;
    void setStartAngle(const int angle);
    int spanAngle() const;
    void setSpanAngle(const int angle);
    QString title() const;
    void setTitle(const QString title);
    int titlePoint() const;
    void setTitlePoint(const int point);

    void drawBgLightColor(QPainter* painter);
    void drawScaleBgColor(QPainter* painter);
    void drawSlideBarColor(QPainter* painter);
    void drawDialRule(QPainter* painter);
    void drawDialText(QPainter* painter);
    void drawPointer(QPainter* painter);
    void drawDialCenterColor(QPainter* painter);
    void drawDialCenterCross(QPainter* painter);

signals:
    void startAngleChanged(int angle);
    void spanAngleChanged(int angle);
    void titleChanged();
    void titlePointChanged();
};

#endif // AZIMUTHDIAL_H
