#include "dry.h"
#include "ui_dry.h"
#include <QTimer>
#include <QDateTime>

Dry::Dry(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dry)
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

    for (int i = 0; i < 10; i++)
    {
        QPushButton* panelButton = new QPushButton();
        panelButton->acceptDrops();
        panelButton->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
        ui->gridLayout->addWidget(panelButton,0,i);
    }

}

Dry::~Dry()
{
    delete ui;
}

void Dry::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh:mm");
    ui->timerlabel->setText(time_text);
}

void Dry::on_pushButton_clicked()
{
    emit buttonPressed();
}

void Dry::on_horizontalScrollBar_valueChanged(int value)
{
    ui->gridLayout->setHorizontalSpacing(value);
}
