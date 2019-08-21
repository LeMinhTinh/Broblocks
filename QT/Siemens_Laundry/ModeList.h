#ifndef MODESELECTIONMODEL_H
#define MODESELECTIONMODEL_H

#include <QObject>
#include <QString>
#include <QVector>
#include "Program.h"

using namespace std;

struct ModeItem{
    bool done;
    QString description;
    //QVector<Program> programModel;
};

class ModeList : public QObject
{
    Q_OBJECT

public:
    explicit ModeList(QObject *parent = nullptr);

    QVector<ModeItem> items() const;

signals:

public slots:

private:
    QVector<ModeItem> _modeItem;
};

#endif // MODESELECTIONMODEL_H
