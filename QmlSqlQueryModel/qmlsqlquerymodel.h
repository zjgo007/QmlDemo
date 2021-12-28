#ifndef QMLSQLQUERYMODEL_H
#define QMLSQLQUERYMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QObject>
#include <QDebug>
#include <QQmlPropertyMap>

class QmlSqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    QmlSqlQueryModel(QObject *parent = nullptr);
    QVariant data(const QModelIndex &index, int role) const;
    Q_INVOKABLE QVariantList getHeaderList();
    Q_INVOKABLE bool isSqlModel();

protected:
    QHash<int,QByteArray>roleNames() const;

};
#endif // QMLSQLQUERYMODEL_H
