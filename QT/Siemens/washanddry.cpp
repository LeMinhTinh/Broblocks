#include "washanddry.h"
#include "ui_washanddry.h"
#include <QTimer>
#include <QDateTime>

WashAndDry::WashAndDry(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::WashAndDry)
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

    //ui->scrollArea->setWidget()

}

WashAndDry::~WashAndDry()
{
    delete ui;
}

void WashAndDry::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh:mm");
    ui->timerlabel->setText(time_text);
}

void WashAndDry::on_pushButton_clicked()
{
     emit buttonPressed();
}
