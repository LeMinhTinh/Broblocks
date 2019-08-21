#ifndef CONFIGURATIONPROPERTIES_H
#define CONFIGURATIONPROPERTIES_H


class ConfigurationProperties
{
    unsigned int _screenWidth;
    unsigned int _screenHeigh;

public:
    ConfigurationProperties();
    unsigned int screenWidth() const;
    void setScreenWidth(unsigned int screenWidth);
    unsigned int screenHeigh() const;
    void setScreenHeigh(unsigned int screenHeigh);
};

#endif // CONFIGURATIONPROPERTIES_H
