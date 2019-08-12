#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "QPushButton"
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    createMainLayoutScren();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::createMainLayoutScren()
{
    for (int i = 0; i < NumButtons; i++)
    {
        QPushButton* panelButton = new QPushButton();
        panelButton->acceptDrops();
        panelButton->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
        ui->gridLayout->addWidget(panelButton,0,i);
    }
}

