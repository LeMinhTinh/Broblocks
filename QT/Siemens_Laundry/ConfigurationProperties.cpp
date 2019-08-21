#include "ConfigurationProperties.h"

unsigned int ConfigurationProperties::screenWidth() const
{
    return _screenWidth;
}

void ConfigurationProperties::setScreenWidth(unsigned int screenWidth)
{
    _screenWidth = screenWidth;
}

unsigned int ConfigurationProperties::screenHeigh() const
{
    return _screenHeigh;
}

void ConfigurationProperties::setScreenHeigh(unsigned int screenHeigh)
{
    _screenHeigh = screenHeigh;
}

ConfigurationProperties::ConfigurationProperties()
{

}
