#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "QPushButton"
#include <QTimer>
#include <QDateTime>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QPixmap setting(":/img/Image/settingicon.png");
    ui->settinglabel->setPixmap(setting);

    QPixmap wifi(":/img/Image/wifiicon.png");
    ui->wifilabel->setPixmap(wifi);

    QPixmap key(":/img/Image/keyicon.png");
    ui->keylabel->setPixmap(key);

    QPixmap charging(":/img/Image/charging.png");
    ui->charginglabel->setPixmap(charging);

    QPixmap bluetooth(":/img/Image/bluetooth.png");
    ui->bluetoothlabel->setPixmap(bluetooth);

    QTimer *timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(showTime()));
    timer->start();

    QString washButtonname = "Wash";
    washButton = new QPushButton(washButtonname, this);
    QString dryname = "Dry";
    wasndryButton = new QPushButton(dryname, this);
    QString washndry = "Wash and Dry";
    dryButton = new QPushButton(washndry, this);

    connect(washButton, SIGNAL(clicked(bool)), this, SLOT(on_washButton_clicked()));
    connect(wasndryButton, SIGNAL(clicked(bool)), this, SLOT(on_wasndryButton_clicked()));
    connect(dryButton, SIGNAL(clicked(bool)), this, SLOT(on_dryButton_clicked()));

    showMainLayoutScren();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::showMainLayoutScren()
{
    washButton->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    dryButton->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    wasndryButton->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    ui->gridLayout->addWidget(washButton,0,0);
    ui->gridLayout->addWidget(wasndryButton,0,1);
    ui->gridLayout->addWidget(dryButton,0,2);
}

void MainWindow::hideMainLayoutScreen()
{
    washButton->hide();
    wasndryButton->hide();
    dryButton->hide();
}

void MainWindow::showTime()
{
    QTime time = QTime::currentTime();
    QString time_text = time.toString("hh:mm");
    ui->timerlabel->setText(time_text);
}

void MainWindow::on_washButton_clicked()
{
    hideMainLayoutScreen();
}

void MainWindow::on_wasndryButton_clicked()
{
    hideMainLayoutScreen();
}

void MainWindow::on_dryButton_clicked()
{
    hideMainLayoutScreen();

}

