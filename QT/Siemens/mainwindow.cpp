#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QTimer>
#include <QDateTime>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
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

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh:mm");
    ui->timerlabel->setText(time_text);
}

void MainWindow::backToMainWindow()
{
    delete washsceen;
    this->show();
}

void MainWindow::backToMainWindowfromWashandDry()
{
    delete washndry;
    this->show();
}

void MainWindow::backToMainWindowfromDry()
{
    delete dry;
    this->show();
}

void MainWindow::on_washButton_clicked()
{
    this->hide();
    washsceen = new washscreen();
    connect(washsceen, SIGNAL(buttonPressed()), this, SLOT(backToMainWindow()));
    washsceen->show();
}

void MainWindow::on_washandDryButton_clicked()
{
    this->hide();
    washndry = new WashAndDry();
    connect(washndry, SIGNAL(buttonPressed()), this, SLOT(backToMainWindowfromWashandDry()));
    washndry->show();
}

void MainWindow::on_dryButton_clicked()
{
    this->hide();
    dry = new Dry();
    connect(dry, SIGNAL(buttonPressed()), this, SLOT(backToMainWindowfromDry()));
    dry->show();
}
