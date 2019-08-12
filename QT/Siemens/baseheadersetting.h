#ifndef BASEHEADERSETTING_H
#define BASEHEADERSETTING_H

#include <QDialog>

namespace Ui {
class BaseHeaderSetting;
}

class BaseHeaderSetting : public QDialog
{
    Q_OBJECT

public:
    BaseHeaderSetting();
    ~BaseHeaderSetting();
    QPixmap showHeaderSettingIcon();
    QPixmap showHeaderWifiIcon();
    QPixmap showHeaderKeyIcon();
    QPixmap showHeaderBluetoothIcon();
    QPixmap showHeaderChargingIcon();

private:
    Ui::BaseHeaderSetting *ui;
};

#endif // BASEHEADERSETTING_H
