#include "qmlsqlquerymodel.h"

QmlSqlQueryModel::QmlSqlQueryModel(QObject *parent):QSqlQueryModel (parent)
{

}

QVariant QmlSqlQueryModel::data(const QModelIndex &index, int role) const
{
    QVariant value;

    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

QVariantList QmlSqlQueryModel::getHeaderList()
{
    QVariantList list;
    for(int i=0;i<this->record().count();i++){
        QString key = this->record().fieldName(i);
        list.append(key);
    }
    return list;
}


QHash<int, QByteArray> QmlSqlQueryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < this->record().count(); i ++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

bool QmlSqlQueryModel::isSqlModel()
{
    return true;
}
