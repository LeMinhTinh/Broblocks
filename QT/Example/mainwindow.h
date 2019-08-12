#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPushButton>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void showTime();
    void on_washButton_clicked();
    void on_wasndryButton_clicked();
    void on_dryButton_clicked();

private:
    void showMainLayoutScren();
    void hideMainLayoutScreen();

    Ui::MainWindow *ui;
    enum { NumButtons = 3 };
    QPushButton* washButton;
    QPushButton* wasndryButton;
    QPushButton* dryButton;
};

#endif // MAINWINDOW_H
