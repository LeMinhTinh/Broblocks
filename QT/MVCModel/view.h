#ifndef VIEW_H
#define VIEW_H
#include <QWidget>
#include <QString>
// Forward Declaration
class QPushButton;
class QLineEdit;
class QHBoxLayout;
class Controller;

class View : public QWidget {
  Q_OBJECT
public:
  explicit View(QWidget *parent = NULL, QString name = "Bosch");
  virtual ~View();
  void setController(Controller* c);
  QString getDollor();
  QString getRuppes();
  void    setDollor(QString d);
  void    setRuppes(QString r);
public slots:
  void ConvertButtonClicked();
  void ClearButtonClicked();
private:
  QPushButton* press;
  QPushButton* clear;
  QLineEdit*   dollorinfo;
  QTextLine*   Cottoninfo;
  QLineEdit*   ruppesinfo;
  QHBoxLayout* hlayout;
  Controller*  controller;
  QString      appName;
  QString      dollor;
  QString      ruppes;
};
#endif // VIEW_H
