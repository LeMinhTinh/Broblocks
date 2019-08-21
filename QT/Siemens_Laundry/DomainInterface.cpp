#include "DomainInterface.h"

QTime DomainInterface::systemTime() const
{
    return _systemTime;
}

int DomainInterface::wifiStatus() const
{
    return _wifiStatus;
}

int DomainInterface::bluetoothStatus() const
{
    return _bluetoothStatus;
}

int DomainInterface::chargingStatus() const
{
    return _chargingStatus;
}

DomainInterface::DomainInterface(QObject *parent) : QObject(parent)
{

}

