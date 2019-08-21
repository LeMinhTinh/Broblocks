#include "ProgramSetting.h"

int ProgramSetting::temperature() const
{
    return _temperature;
}

void ProgramSetting::setTemperature(int temperature)
{
    _temperature = temperature;
}

int ProgramSetting::spinSpeed() const
{
    return _spinSpeed;
}

ProgramOption ProgramSetting::option() const
{
    return _option;
}

void ProgramSetting::setOption(const ProgramOption &option)
{
    _option = option;
}

void ProgramSetting::setTime(int time)
{
    _time = time;
}

ProgramSetting::ProgramSetting()
{

}
