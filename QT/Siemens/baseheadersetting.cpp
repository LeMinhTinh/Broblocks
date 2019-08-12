#include "baseheadersetting.h"
#include "ui_baseheadersetting.h"

BaseHeaderSetting::BaseHeaderSetting()
{
    ui->settinglabel->setPixmap(showHeaderSettingIcon());
    ui->wifilabel->setPixmap(showHeaderWifiIcon());
    ui->keylabel->setPixmap(showHeaderKeyIcon());
    ui->charginglabel->setPixmap(showHeaderChargingIcon());
    ui->bluetoothlabel->setPixmap(showHeaderBluetoothIcon());
}

BaseHeaderSetting::~BaseHeaderSetting()
{
    delete ui;
}

QPixmap BaseHeaderSetting::showHeaderSettingIcon()
{
  QPixmap pixSetting(":/Img/Image/settingicon.png");
  return pixSetting;
}

QPixmap BaseHeaderSetting::showHeaderWifiIcon()
{
  QPixmap pixWifi(":/Img/Image/wifiicon.png");
  return pixWifi;
}

QPixmap BaseHeaderSetting::showHeaderKeyIcon()
{
  QPixmap pixKey(":/Img/Image/keyicon.png");
  return pixKey;
}

QPixmap BaseHeaderSetting::showHeaderBluetoothIcon()
{
  QPixmap pixBluetooth(":/Img/Image/bluetooth.png");
  return pixBluetooth;
}

QPixmap BaseHeaderSetting::showHeaderChargingIcon()
{
  QPixmap pixCharging(":/Img/Image/charging.png");
  return pixCharging;
}
