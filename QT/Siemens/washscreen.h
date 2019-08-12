#ifndef WASHSCREEN_H
#define WASHSCREEN_H

#include <QDialog>
#include "headersetting.h"

namespace Ui {
class washscreen;
}

class washscreen : public QDialog
{
    Q_OBJECT

public:
    explicit washscreen(QWidget *parent = nullptr);
    ~washscreen();

private slots:
   void on_pushButton_clicked();
   void showTime();

signals:
    void buttonPressed();

private:
    Ui::washscreen *ui;
    HeaderSetting *header;
};

#endif // WASHSCREEN_H
