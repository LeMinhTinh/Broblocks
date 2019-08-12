#ifndef DRY_H
#define DRY_H

#include <QDialog>
#include "headersetting.h"

namespace Ui {
class Dry;
}

class Dry : public QDialog
{
    Q_OBJECT

public:
    explicit Dry(QWidget *parent = nullptr);
    ~Dry();

private slots:
    void on_pushButton_clicked();
    void showTime();

    void on_horizontalScrollBar_valueChanged(int value);

signals:
     void buttonPressed();

private:
    Ui::Dry *ui;
    HeaderSetting *header;
};

#endif // DRY_H
