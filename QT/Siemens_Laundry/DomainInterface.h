#ifndef DOMAININTERFACE_H
#define DOMAININTERFACE_H

#include <QObject>
#include <QTime>
class DomainInterface : public QObject
{
    Q_OBJECT
    QTime _systemTime;
    int _wifiStatus;
    int _bluetoothStatus;
    int _chargingStatus;
public:
    explicit DomainInterface(QObject *parent = nullptr);

    QTime systemTime() const;

    int wifiStatus() const;

    int bluetoothStatus() const;

    int chargingStatus() const;

signals:
    void notifySystemTime(QTime time);
    void notifyChargingStatus(int chargingStatus);

public slots:
};

#endif // DOMAININTERFACE_H
