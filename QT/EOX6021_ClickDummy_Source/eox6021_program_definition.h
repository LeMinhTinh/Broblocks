#ifndef EOX6021_PROGRAM_DEFINITION_H
#define EOX6021_PROGRAM_DEFINITION_H

#include <QObject>
#include <QString>

#include "program_definition.h"
#include "program_option_types.h"

namespace BSH
{

class EOX6021ProgramDefinition : public ProgramDefinition
{
    Q_OBJECT

    Q_PROPERTY(ProgramIntegerIntervalOption* temperature READ getTemperature MEMBER m_temperature NOTIFY temperatureChanged)
    Q_PROPERTY(ProgramBooleanOption* quickHeat READ getQuickHeat WRITE setQuickHeat NOTIFY quickHeatChanged)
    Q_PROPERTY(ProgramStringOption* steam READ getSteam WRITE setSteam NOTIFY steamChanged)
    Q_PROPERTY(ProgramStringOption* cleaningLevel READ getCleaningLevel WRITE setCleaningLevel NOTIFY cleaningLevelChanged)
    Q_PROPERTY(ProgramIntegerOption* microwave READ getMicrowave WRITE setMicrowave NOTIFY microwaveChanged)
    Q_PROPERTY(ProgramIntegerIntervalOption* duration READ getDuration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(ProgramIntegerIntervalOption* thermometer READ getThermometer MEMBER m_thermometer NOTIFY thermometerChanged)
    Q_PROPERTY(ProgramIntegerMappingOption* weightToDuration READ getWeightToDuration WRITE setWeightToDuration NOTIFY weightToDurationChanged)


public:
    explicit EOX6021ProgramDefinition(QObject *parent = nullptr) :
        ProgramDefinition(parent)
    {}

    ProgramIntegerIntervalOption* getTemperature() {
        return m_temperature;
    }

    ProgramBooleanOption* getQuickHeat() {
        return m_quickHeat;
    }

    ProgramStringOption* getSteam() {
        return m_steam;
    }

    ProgramStringOption* getCleaningLevel() {
        return m_cleaning_level;
    }

    ProgramIntegerOption* getMicrowave() {
        return m_microwave;
    }

    ProgramIntegerIntervalOption* getDuration() {
        return m_duration;
    }

    ProgramIntegerIntervalOption* getThermometer() {
        return m_thermometer;
    }

    ProgramIntegerMappingOption* getWeightToDuration() {
        return m_weight_to_duration;
    }

    void setQuickHeat(ProgramBooleanOption* option) {
        m_quickHeat = option;
        if(m_quickHeat) {
            connect(m_quickHeat, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleQuickHeat, Qt::DirectConnection);
            connect(m_quickHeat, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleQuickHeat, Qt::DirectConnection);
            handleQuickHeat();
        }
        emit quickHeatChanged();
    }

    void handleQuickHeat() {
        if (m_quickHeat->isInAlternativeMode()|| m_quickHeat->isEnabled()) {
            deactivateOption(m_microwave);
            tryReactivateQuickheat();
        } else {
            tryReactivateMicrowave();
        }
    }

    void setSteam(ProgramStringOption* option) {
        m_steam = option;
        if(m_steam) {
            connect(m_steam, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleSteamStatus, Qt::DirectConnection);
            connect(m_steam, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleSteamStatus, Qt::DirectConnection);
            handleSteamStatus();
        }
        emit steamChanged();
    }

    void setCleaningLevel(ProgramStringOption* option) {
        m_cleaning_level = option;
        emit cleaningLevelChanged();
    }

    void setWeightToDuration(ProgramIntegerMappingOption* option) {
        m_weight_to_duration = option;
        emit weightToDurationChanged();
    }

    void handleSteamStatus() {
        if (m_steam->isInAlternativeMode() || m_steam->isEnabled()) {
            deactivateOption(m_microwave);
            tryReactivateSteam();
        } else {
            tryReactivateMicrowave();
        }
    }

    void setMicrowave(ProgramIntegerOption* option) {
        m_microwave = option;
        if(m_microwave) {
            connect(m_microwave, &ProgramOption::isEnabledChanged, this, &EOX6021ProgramDefinition::handleMicrowaveStatus, Qt::DirectConnection);
            connect(m_microwave, &ProgramOption::isInAlternativeModeChanged, this, &EOX6021ProgramDefinition::handleMicrowaveStatus, Qt::DirectConnection);
            handleMicrowaveStatus();
        }
        emit microwaveChanged();
    }

    void handleMicrowaveStatus() {
        if (m_microwave->isInAlternativeMode()|| m_microwave->isEnabled()) {
            deactivateOption(m_quickHeat);
            deactivateOption(m_steam);
            tryReactivateMicrowave();
        } else {
            tryReactivateQuickheat();
            tryReactivateSteam();
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
    bool isOptionUsed(ProgramOption* option) {
        return option && (option->isInAlternativeMode()|| option->isEnabled());
    }

    void tryReactivateSteam() {
        if (m_steam && !isOptionUsed(m_microwave) ) m_steam->setDeactivated(false);
    }

    void tryReactivateMicrowave() {
        if (m_microwave && !isOptionUsed(m_steam) && !isOptionUsed(m_quickHeat) ) m_microwave->setDeactivated(false);
    }

    void tryReactivateQuickheat() {
        if (m_quickHeat && !isOptionUsed(m_microwave) ) m_quickHeat->setDeactivated(false);
    }

    Q_INVOKABLE virtual void fetchDefinition(EOX6021ProgramDefinition* definition)
    {
        fetchBaseDefinition(definition);
        fetchPointerData("temperature", definition->m_temperature);
        fetchPointerData("quickHeat", definition->m_quickHeat);
        fetchPointerData("steam", definition->m_steam);
        fetchPointerData("microwave", definition->m_microwave);
        fetchPointerData("duration", definition->m_duration);
        fetchPointerData("thermometer", definition->m_thermometer);
        fetchPointerData("weightToDuration", definition->m_weight_to_duration);
        fetchPointerData("cleaningLevel", definition->m_cleaning_level);
    }

signals:
    void temperatureChanged();
    void steamChanged();
    void cleaningLevelChanged();
    void microwaveChanged();
    void quickHeatChanged();
    void durationChanged();
    void thermometerChanged();
    void weightToDurationChanged();

private:
    ProgramIntegerIntervalOption* m_temperature {};
    ProgramIntegerOption* m_microwave {};
    ProgramStringOption* m_steam {};
    ProgramStringOption* m_cleaning_level {};
    ProgramBooleanOption* m_quickHeat {};
    ProgramIntegerIntervalOption* m_duration {};
    ProgramIntegerIntervalOption* m_thermometer {};
    ProgramIntegerMappingOption* m_weight_to_duration {};
};

}

#endif // EOX6021_PROGRAM_DEFINITION_H
