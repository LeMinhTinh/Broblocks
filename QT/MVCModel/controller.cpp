#include "controller.h"
#include "model.h"
#include "view.h"
#include <QString>

Controller::Controller(Model* m):model(m){}
Controller::~Controller(){}

void Controller::OnConvertButtonClicked(View* v)
{
  QString ruppes = v->getRuppes();
  model->ConvertRuppesIntoDollor(ruppes.toDouble());
  QString ds = QString::number(model->GetDollorValue());
  v->setDollor(ds);
}

void Controller::OnClearButtonClicked(View* v)
{
  v->setDollor(QString());
  v->setRuppes(QString());
  model->clear();
}
