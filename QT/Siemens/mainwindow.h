#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "washscreen.h"
#include "headersetting.h"
#include "washanddry.h"
#include "dry.h"
#include "baseheadersetting.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
      void backToMainWindow();
      void backToMainWindowfromWashandDry();
      void backToMainWindowfromDry();

private slots:
    void on_washButton_clicked();
    void showTime();

    void on_washandDryButton_clicked();

    void on_dryButton_clicked();

private:
    Ui::MainWindow *ui;
    washscreen *washsceen;
    HeaderSetting *header;
    WashAndDry *washndry;
    Dry *dry;

};

#endif // MAINWINDOW_H
