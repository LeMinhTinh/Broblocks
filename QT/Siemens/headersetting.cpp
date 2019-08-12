#include "mainwindow.h"
#include "headersetting.h"
#include <QTimer>
#include <QDateTime>

HeaderSetting::HeaderSetting(QWidget *parent) :
    QMainWindow(parent)
{

}

HeaderSetting::~HeaderSetting()
{

}


QPixmap HeaderSetting::showHeaderSettingIcon()
{
  QPixmap pixSetting(":/Img/Image/settingicon.png");
  return pixSetting;
}

QPixmap HeaderSetting::showHeaderWifiIcon()
{
  QPixmap pixWifi(":/Img/Image/wifiicon.png");
  return pixWifi;
}

QPixmap HeaderSetting::showHeaderKeyIcon()
{
  QPixmap pixKey(":/Img/Image/keyicon.png");
  return pixKey;
}

QPixmap HeaderSetting::showHeaderBluetoothIcon()
{
  QPixmap pixBluetooth(":/Img/Image/bluetooth.png");
  return pixBluetooth;
}

QPixmap HeaderSetting::showHeaderChargingIcon()
{
  QPixmap pixCharging(":/Img/Image/charging.png");
  return pixCharging;
}

