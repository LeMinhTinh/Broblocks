#ifndef PROGRAMLIST_H
#define PROGRAMLIST_H

#include <string>
#include "ProgramSetting.h"

using namespace std;

class Program
{
    std::string _name;
    std::string _desc;
    std::string _imageUrl;
    ProgramSetting _setting;
public:
    Program();
    Program(std::string name, std::string desc, std::string imageurl);
    std::string name() const;
    void setName(const std::string &name);
    std::string desc() const;
    void setDesc(const std::string &desc);
    std::string imageUrl() const;
    void setImageUrl(const std::string &imageUrl);
    ProgramSetting setting() const;
    void setSetting(const ProgramSetting &setting);
};

#endif // PROGRAMLIST_H
