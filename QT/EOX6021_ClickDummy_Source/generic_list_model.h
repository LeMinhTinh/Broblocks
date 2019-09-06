#ifndef GENERIC_LIST_MODEL_H
#define GENERIC_LIST_MODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QQmlListProperty>
#include <QDebug>

namespace BSH
{

class GenericListModel : public QAbstractListModel {
    Q_OBJECT
    QList<QObject*> m_data;

    Q_PROPERTY(int size READ size NOTIFY sizeChanged)
    Q_PROPERTY(QQmlListProperty<QObject> content READ content NOTIFY contentChanged)
    Q_PROPERTY(QObject* parent READ parent WRITE setParent)
    Q_CLASSINFO("DefaultProperty", "content")

public:
    GenericListModel(QObject *parent = nullptr) : QAbstractListModel(parent)
    {}

    int rowCount(const QModelIndex &p) const
    {
        Q_UNUSED(p)
        return m_data.size();
    }

    QVariant data(const QModelIndex &index, int role) const
    {
        Q_UNUSED(role)
        return QVariant::fromValue(m_data[index.row()]);
    }

    QHash<int, QByteArray> roleNames() const
    {
        static QHash<int, QByteArray> * pHash;
        if (!pHash) {
            pHash = new QHash<int, QByteArray>;
            (*pHash)[Qt::UserRole + 1] = "object";
        }
        return *pHash;
    }

    int size() const
    {
        return m_data.size();
    }

    QQmlListProperty<QObject> content()
    {
        return QQmlListProperty<QObject>(this, m_data);
    }

public slots:
    void append(QObject *o)
    {
        int i {m_data.size()};
        beginInsertRows(QModelIndex(), i, i);
        m_data.append(o);
        o->setParent(this);
        sizeChanged();
        endInsertRows();
    }

    void insert(QObject *o, int i)
    {
        beginInsertRows(QModelIndex(), i, i);
        m_data.insert(i, o);
        o->setParent(this);
        sizeChanged();
        endInsertRows();
    }

    QObject* take(int i)
    {
        if ((i >= 0) && (i < m_data.size())) {
            beginRemoveRows(QModelIndex(), i, i);
            QObject* o = m_data.takeAt(i);
            o->setParent(nullptr);
            sizeChanged();
            endRemoveRows();
            return o;
        }
        qDebug() << "ERROR: take(" << i << ") invalid on model [size: " << m_data.size() << "]";
        return nullptr;
    }

    void remove(int i)
    {
        if ((i >= 0) && (i < m_data.size())) {
            beginRemoveRows(QModelIndex(), i, i);
            m_data.removeAt(i);
            sizeChanged();
            endRemoveRows();
            return;
        }
        qDebug() << "ERROR: remove(" << i << ") invalid on model [size: " << m_data.size() << "]";
    }

    void remove(QObject* object)
    {
        int index {m_data.indexOf(object)};
        if (index >= 0) remove(index);
        else qDebug() << "ERROR: remove could not find target object";
    }

    QObject* get(int i)
    {
        if ((i >= 0) && (i < m_data.size())) return m_data[i];
        qDebug() << "ERROR: get(" << i << ") invalid on model [size: " << m_data.size() << "]";
        return nullptr;
    }

    void move(int from, int to)
    {
        if ((from >= 0) && (from < m_data.size()) && (to >= 0) && (to < m_data.size())) {
            if (from != to) {
                beginMoveRows(QModelIndex(), from, from, QModelIndex(), to + ((to > from) ? 1 : 0));
                m_data.move(from, to);
                endMoveRows();
            }
            return;
        }
        qDebug() << "ERROR: move(" << from << ", " << to << ") invalid on model [size: " << m_data.size() << "]";
    }

signals:
    void sizeChanged();
    void contentChanged();
};

}

#endif // GENERIC_LIST_MODEL_H
