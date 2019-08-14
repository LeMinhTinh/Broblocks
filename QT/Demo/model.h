#ifndef MODEL_H
#define MODEL_H
#include <QObject>

class Model: public QObject
{
    Q_OBJECT
   // Q_PROPERTY(int speed READ valueSlider1 NOTIFY slider1Changed)
   // Q_PROPERTY(int speed READ valueSlider2 NOTIFY slider2Changed)
   // Q_PROPERTY(int speed READ valueSlider3 NOTIFY slider3Changed)

public:
    Model();
    int valueSlider1() const;
    int valueSlider2() const;
    int valueSlider3() const;

//signals:
  //void slider1Changed(int value);
  //void slider2Changed(int value);
  //void slider3Changed(int value);
private:
    int sliderNum1;
    int sliderNum2;
    int sliderNum3;
};

#endif // MODEL_H
