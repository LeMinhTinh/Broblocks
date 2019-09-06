#ifndef NAVIGATION_MENU_ITEM_H
#define NAVIGATION_MENU_ITEM_H

#include <QObject>
#include <QString>
#include "generic_list_model.h"

namespace BSH
{

class NaviagtionMenuItem : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name MEMBER m_name NOTIFY nameChanged)
    Q_PROPERTY(QString tileImage MEMBER m_tileImage NOTIFY tileImageChanged)
    Q_PROPERTY(QString firstIcon MEMBER m_firstIcon NOTIFY firstIconChanged)
    Q_PROPERTY(QString secondIcon MEMBER m_secondIcon NOTIFY secondIconChanged)
    Q_PROPERTY(QString bgImage MEMBER m_bgImage NOTIFY bgImageChanged)
    Q_PROPERTY(QString target MEMBER m_target NOTIFY targetChanged)
    Q_PROPERTY(QObject* referencedItem MEMBER m_referencedItem NOTIFY referencedItemChanged)
    Q_PROPERTY(GenericListModel* targetModel MEMBER m_target_model NOTIFY targetModelChanged)

public:
    explicit NaviagtionMenuItem(QObject *parent = nullptr) :
        QObject(parent)
    {}

signals:
    void nameChanged();
    void tileImageChanged();
    void firstIconChanged();
    void secondIconChanged();
    void bgImageChanged();
    void targetChanged();
    void targetModelChanged();
    void referencedItemChanged();

private:
    QString m_name {};
    QString m_tileImage {};
    QString m_firstIcon {};
    QString m_secondIcon {};
    QString m_bgImage {};
    QString m_target {};
    QObject* m_referencedItem {};
    GenericListModel* m_target_model {};
};

}

#endif // NAVIGATION_MENU_ITEM_H
