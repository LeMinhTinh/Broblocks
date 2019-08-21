#include "LaundryModel.h"
#include "ModeList.h"

LaundryModel::LaundryModel(QObject *parent)
    : QAbstractListModel(parent)
    , _pList(nullptr)
{
}

int LaundryModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !_pList)
        return 0;

    // FIXME: Implement me! --> need to remember
    return _pList->items().size();
}

QVariant LaundryModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !_pList)
        return QVariant();

    const ModeItem item = _pList->items().at(index.row());
    switch (role)
    {
    case DoneRole:
        return QVariant(item.done);
    case DescriptionRole:
        return QVariant(item.description);
    }

    // FIXME: Implement me!
    return QVariant();
}

bool LaundryModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags LaundryModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> LaundryModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[DoneRole] = "done";
    names[DescriptionRole] = "description";
    return names;
}

ModeList *LaundryModel::list() const
{
    return _pList;
}

void LaundryModel::setList(ModeList *list)
{
    beginResetModel();

    if (_pList)
    {
        _pList->disconnect(this);
    }
    _pList = list;

    endResetModel();
}
