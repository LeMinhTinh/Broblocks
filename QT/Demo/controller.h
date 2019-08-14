#ifndef CONTROLLER_H
#define CONTROLLER_H

class Model;
class View;

class Controller
{
public:
  Controller(Model* m);
  virtual ~Controller();
  void OnSelectSlider1Clicked(View *v);
  void OnSelectSlider2Clicked(View *v);
  void OnSelectSlider3Clicked(View *v);

private:
  Model* model;
};

#endif // CONTROLLER_H
