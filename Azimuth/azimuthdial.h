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
        bool visible;
    };
    enum CrossSize{
        Small,Middle,Big
    };
    Q_ENUM(CrossSize);
    Q_PROPERTY(int beginAngle READ startAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(int spanAngle READ spanAngle WRITE setSpanAngle NOTIFY spanAngleChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int titlePoint READ titlePoint WRITE setTitlePoint NOTIFY titlePointChanged)
    Q_PROPERTY(int dialTextPoint READ dialTextPoint WRITE setDialTextPoint NOTIFY dialTextPointChanged)
    Q_PROPERTY(CrossSize crossSize READ crossSize WRITE setCrossSize NOTIFY crossSizeChanged)

    Q_INVOKABLE void appendPointer(const qreal angle, const QColor color, const QString name);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void remove(const QString name);
    Q_INVOKABLE void changePointerData(const QString name,const qreal angle);
    Q_INVOKABLE void pointerVisible(const QString name, const bool visible);
    Q_INVOKABLE void showAllPointer();
    Q_INVOKABLE void hideAllPointer();



private:
    int radius;
    int mStartAngle,mSpanAngle;
    QColor mBgLightColor,mBgColor,mCenterColor,mDialRuleColor,mDialTextColor,mDialPointerColor;
    int mDialTextPoint,mTitleTextPoint,mCrossSize;
    QString mTitle;
    QVector<PointerData>mVector;
    CrossSize mCrossType;

    int startAngle() const;
    void setStartAngle(const int angle);
    int spanAngle() const;
    void setSpanAngle(const int angle);
    QString title() const;
    void setTitle(const QString title);
    int titlePoint() const;
    void setTitlePoint(const int point);
    int dialTextPoint() const;
    void setDialTextPoint(const int point);
    CrossSize crossSize() const;
    void setCrossSize(const CrossSize size);

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
    void dialTextPointChanged();
    void crossSizeChanged();
};

#endif // AZIMUTHDIAL_H
