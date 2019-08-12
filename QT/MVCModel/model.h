#ifndef MODEL_H
#define MODEL_H

class Model
{
public:
  Model();
  ~Model();
  double ConvertRuppesIntoDollor(double rs);
  double GetDollorValue()const;
  double GetRuppeValue() const;
  void clear();
private:
  double r;
  double d;
};
#endif // MODEL_H
