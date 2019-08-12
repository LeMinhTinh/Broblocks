#ifndef WASHANDDRY_H
#define WASHANDDRY_H

#include <QDialog>
#include "headersetting.h"

namespace Ui {
class WashAndDry;
}

class WashAndDry : public QDialog
{
    Q_OBJECT

public:
    explicit WashAndDry(QWidget *parent = nullptr);
    ~WashAndDry();

private slots:
    void on_pushButton_clicked();
    void showTime();

signals:
    void buttonPressed();

private:
    Ui::WashAndDry *ui;
    HeaderSetting *header;
};

#endif // WASHANDDRY_H
