#ifndef PROGRAMSETTING_H
#define PROGRAMSETTING_H

struct Stains{
    bool grass;
    bool coffee;
    bool ink;
};

struct ProgramOption{
    bool prewash;
    bool iDos;
    bool eco;
    bool speed;
    bool rinsePlus;
    Stains stains;
};

class ProgramSetting
{
    int _temperature;
    int _spinSpeed;
    ProgramOption _option;
    int _time;
public:
    ProgramSetting();
    int temperature() const;
    void setTemperature(int temperature);
    int spinSpeed() const;
    ProgramOption option() const;
    void setOption(const ProgramOption &option);
    int time() const;
    void setTime(int time);
};

#endif // PROGRAMSETTING_H
