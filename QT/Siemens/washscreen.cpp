#include "washscreen.h"
#include "ui_washscreen.h"
#include <QTimer>
#include <QDateTime>

washscreen::washscreen(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::washscreen)
{
    ui->setupUi(this);

    QTimer *timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(showTime()));
    timer->start();

    ui->settinglabel->setPixmap(header->showHeaderSettingIcon());
    ui->wifilabel->setPixmap(header->showHeaderWifiIcon());
    ui->keylabel->setPixmap(header->showHeaderKeyIcon());
    ui->charginglabel->setPixmap(header->showHeaderChargingIcon());
    ui->bluetoothlabel->setPixmap(header->showHeaderBluetoothIcon());
}

void washscreen::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh:mm");
    ui->timerlabel->setText(time_text);
}
washscreen::~washscreen()
{
    delete ui;
}

void washscreen::on_pushButton_clicked()
{
    emit buttonPressed();
}
