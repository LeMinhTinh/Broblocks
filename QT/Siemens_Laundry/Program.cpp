#include "Program.h"

std::string Program::name() const
{
    return _name;
}

void Program::setName(const std::string &name)
{
    _name = name;
}

std::string Program::desc() const
{
    return _desc;
}

void Program::setDesc(const std::string &desc)
{
    _desc = desc;
}

std::string Program::imageUrl() const
{
    return _imageUrl;
}

void Program::setImageUrl(const std::string &imageUrl)
{
    _imageUrl = imageUrl;
}

ProgramSetting Program::setting() const
{
    return _setting;
}

void Program::setSetting(const ProgramSetting &setting)
{
    _setting = setting;
}

Program::Program()
{

}

Program::Program(string name, string desc, string imageurl)
{
    _name = name;
    _desc = desc;
    _imageUrl = imageurl;
}
