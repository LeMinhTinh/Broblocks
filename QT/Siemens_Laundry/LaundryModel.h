#ifndef LAUNDRYMODEL_H
#define LAUNDRYMODEL_H

#include <QAbstractListModel>


class ModeList;

class LaundryModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(ModeList *list READ list WRITE setList)

public:
    explicit LaundryModel(QObject *parent = nullptr);

    enum {
        DoneRole = Qt::UserRole,
        DescriptionRole
    };


    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    ModeList *list() const;
    void setList(ModeList *list);

private:
    ModeList *_pList;
};

#endif // LAUNDRYMODEL_H
