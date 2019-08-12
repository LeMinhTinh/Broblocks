#ifndef HEADERSETTING_H
#define HEADERSETTING_H
#include <QMainWindow>
#include <QPixmap>

class HeaderSetting : public QMainWindow
{
     Q_OBJECT

public:

    enum IconHeader
    {
        HEADER_SETTING_ICON,
        HEADER_WIFI_ICON,
        HEADER_KEY_ICON,
        HEADER_BLUETOOTH_ICON,
        HEADER_CHARGING_ICON
    };

    explicit HeaderSetting(QWidget *parent = nullptr);
    ~HeaderSetting();
    QPixmap showHeaderSettingIcon();
    QPixmap showHeaderWifiIcon();
    QPixmap showHeaderKeyIcon();
    QPixmap showHeaderBluetoothIcon();
    QPixmap showHeaderChargingIcon();
    QPixmap showHeaderSetting(IconHeader icon);

private slots:

private:

};


#endif // HEADERSETTING_H
