#ifndef EOX6021_PROGRAM_DEFINITION_H
#define EOX6021_PROGRAM_DEFINITION_H

#include <QObject>
#include <QString>
#include <QTime>

#include "program_definition.h"
#include "eox6021_program_options.h"

namespace BSH
{

class EOX6021ProgramDefinition : public ProgramDefinition
{
    Q_OBJECT

    Q_PROPERTY(ProgramIntegerIntervalOption* temperature READ getTemperature MEMBER m_temperature NOTIFY temperatureChanged)
    Q_PROPERTY(ProgramIntegerIntervalOption* spinspeed READ getSpinSpeed MEMBER m_spinspeed NOTIFY spinspeedChanged)
    Q_PROPERTY(ProgramBooleanOption* quickHeat READ getQuickHeat WRITE setQuickHeat NOTIFY quickHeatChanged)
    Q_PROPERTY(ProgramStringOption* steam READ getSteam WRITE setSteam NOTIFY steamChanged)
    Q_PROPERTY(ProgramIntegerOption* microwave READ getMicrowave WRITE setMicrowave NOTIFY microwaveChanged)
    Q_PROPERTY(ProgramIntegerIntervalOption* duration READ getDuration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(ProgramBooleanOption* thermometer READ getThermometer WRITE setThermometer NOTIFY thermometerChanged)

public:
    explicit EOX6021ProgramDefinition(QObject *parent = nullptr) :
        ProgramDefinition(parent)
    {}

    ProgramIntegerIntervalOption* getTemperature() {
        return m_temperature;
    }
    ProgramIntegerIntervalOption* getSpinSpeed() {
        return m_spinspeed;
    }
    ProgramBooleanOption* getQuickHeat() {
        return m_quickHeat;
    }

    ProgramStringOption* getSteam() {
        return m_steam;
    }

    ProgramIntegerOption* getMicrowave() {
        return m_microwave;
    }

    ProgramIntegerIntervalOption* getDuration() {
        return m_duration;
    }

    ProgramBooleanOption* getThermometer() {
        return m_thermometer;
    }

    void setQuickHeat(ProgramBooleanOption* option) {
        m_quickHeat = option;
        connect(m_quickHeat, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleQuickHeat, Qt::DirectConnection);
        connect(m_quickHeat, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleQuickHeat, Qt::DirectConnection);
        handleQuickHeat();
        emit quickHeatChanged();
    }

    void handleQuickHeat() {
        if (m_quickHeat->isInAlternativeMode()|| m_quickHeat->isEnabled()) {
            reactivateOption(m_quickHeat);
            deactivateOption(m_microwave);
        } else {
            reactivateOption(m_microwave);
        }
    }

    void setSteam(ProgramStringOption* option) {
        m_steam = option;
        connect(m_steam, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleSteamStatus, Qt::DirectConnection);
        connect(m_steam, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleSteamStatus, Qt::DirectConnection);
        handleSteamStatus();
        emit steamChanged();
    }

    void handleSteamStatus() {
        if (m_steam->isInAlternativeMode()|| m_steam->isEnabled()) {
            reactivateOption(m_steam);
            deactivateOption(m_microwave);
            deactivateOption(m_thermometer);
        } else {
            reactivateOption(m_microwave);
            reactivateOption(m_thermometer);
        }
    }

    void setMicrowave(ProgramIntegerOption* option) {
        m_microwave = option;
        connect(m_microwave, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleMicrowaveStatus, Qt::DirectConnection);
        connect(m_microwave, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleMicrowaveStatus, Qt::DirectConnection);
        handleMicrowaveStatus();
        emit microwaveChanged();
    }

    void handleMicrowaveStatus() {
        if (m_microwave->isInAlternativeMode()|| m_microwave->isEnabled()) {
            reactivateOption(m_microwave);
            deactivateOption(m_quickHeat);
            deactivateOption(m_steam);
            deactivateOption(m_thermometer);
        } else {
            reactivateOption(m_quickHeat);
            reactivateOption(m_steam);
            reactivateOption(m_thermometer);
        }
    }

    void setThermometer(ProgramBooleanOption* option) {
        m_thermometer = option;
        connect(m_thermometer, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleThermometerStatus, Qt::DirectConnection);
        connect(m_thermometer, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleThermometerStatus, Qt::DirectConnection);
        handleThermometerStatus();
        emit thermometerChanged();
    }

    void handleThermometerStatus() {
        if (m_thermometer->isInAlternativeMode()|| m_thermometer->isEnabled()) {
            reactivateOption(m_thermometer);
            deactivateOption(m_steam);
            deactivateOption(m_microwave);
        } else {
            reactivateOption(m_steam);
            reactivateOption(m_microwave);
        }
    }

    void setDuration(ProgramIntegerIntervalOption* option) {
        m_duration = option;
        emit durationChanged();
    }

    // Deactivate before disable so the ui can detect wether an option gets deactivated while previously enabled
    void deactivateOption(ProgramOption* option) {
        if (option) option->setDeactivated(true);
    }

    void reactivateOption(ProgramOption* option) {
        if (option) option->setDeactivated(false);
    }

    Q_INVOKABLE virtual void fetchDefinition(EOX6021ProgramDefinition* definition)
    {
        fetchBaseDefinition(definition);
        fetchPointerData("temperature", definition->m_temperature);
        fetchPointerData("spinspeed", definition->m_spinspeed);
        fetchPointerData("quickHeat", definition->m_quickHeat);
        fetchPointerData("steam", definition->m_steam);
        fetchPointerData("microwave", definition->m_microwave);
        fetchPointerData("duration", definition->m_duration);
        fetchPointerData("thermometer", definition->m_thermometer);
    }

signals:
    void temperatureChanged();
    void spinspeedChanged();
    void steamChanged();
    void microwaveChanged();
    void quickHeatChanged();
    void durationChanged();
    void thermometerChanged();

private:
    ProgramIntegerIntervalOption* m_temperature {};
    ProgramIntegerIntervalOption* m_spinspeed {};
    ProgramIntegerOption* m_microwave {};
    ProgramStringOption* m_steam {};
    ProgramBooleanOption* m_quickHeat {};
    ProgramBooleanOption* m_thermometer {};
    ProgramIntegerIntervalOption* m_duration {};
};

}

#endif // EOX6021_PROGRAM_DEFINITION_H
