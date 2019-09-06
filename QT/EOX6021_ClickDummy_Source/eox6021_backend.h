//------------------------------------------
// Dummy backend for the click dummy.

#ifndef EOX6021_BACKEND_H
#define EOX6021_BACKEND_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QTime>
#include <QThread>
#include <array>
#include <vector>

#include "generic_list_model.h"
#include "program_option_types.h"
#include "eox6021_program_definition.h"
#include "eox6021_program.h"
#include "eox6021_oven_simulation.h"

namespace BSH
{

class EOX6021BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(GenericListModel* ovenPrograms MEMBER m_ovenPrograms NOTIFY ovenProgramsChanged)
    Q_PROPERTY(GenericListModel* breadPrograms MEMBER m_breadPrograms NOTIFY breadProgramsChanged)
    Q_PROPERTY(EOX6021ProgramDefinition* microwaveProgram MEMBER m_microwaveProgram NOTIFY microwaveProgramChanged)
    Q_PROPERTY(GenericListModel* favorites MEMBER m_favorites NOTIFY favoritesChanged)
    Q_PROPERTY(GenericListModel* cleaningPrograms MEMBER m_cleaningPrograms NOTIFY cleaningProgramsChanged)
    Q_PROPERTY(EOX6021Program* currentProgram READ getCurrentProgram WRITE setCurrentProgram NOTIFY currentProgramChanged)
    Q_PROPERTY(int wallClock READ getWallClock WRITE setWallClock NOTIFY wallClockChanged)
    Q_PROPERTY(qreal currentTemperature READ getCurrentTemperature WRITE setCurrentTemperature NOTIFY currentTemperatureChanged)
    Q_PROPERTY(qreal microwavePower READ getMicrowavePower WRITE setMicrowavePower NOTIFY microwavePowerChanged)
    Q_PROPERTY(qreal microwaveBoostThreshold READ getMicrowaveBoostThreshold NOTIFY microwaveBoostThresholdChanged)
    Q_PROPERTY(QString currentDate READ getCurrentDate WRITE setCurrentDate NOTIFY currentDateChanged)
    Q_PROPERTY(bool alarmClockRunning MEMBER m_alarm_clock_running NOTIFY alarmClockRunningChanged)
    Q_PROPERTY(int alarmTime MEMBER m_alarmTime NOTIFY alarmTimeChanged)
    Q_PROPERTY(int alarmIndex MEMBER m_alarmIndex NOTIFY alarmIndexChanged)
    Q_PROPERTY(int alarmResetTime MEMBER m_alarmResetTime NOTIFY alarmResetTimeChanged)
    Q_PROPERTY(ProgramBooleanOption* testOption MEMBER m_testOption NOTIFY testOptionChanged)
    Q_PROPERTY(ProgramStringOption* displayBrightness MEMBER m_displayBrightness NOTIFY displayBrightnessChanged)
    Q_PROPERTY(ProgramStringOption* standbyClockMode MEMBER m_standbyClockMode NOTIFY standbyClockModeChanged)

    struct MicrowaveDegradationStep {
        int secondsTillDegradation;
        qreal degradedPower;
    };

public:
    explicit EOX6021BackEnd(QObject *parent = nullptr);
    ~EOX6021BackEnd();
    Q_INVOKABLE EOX6021ProgramDefinition* getProgramDefinitionCopy(EOX6021ProgramDefinition* programDefinition);
    Q_INVOKABLE void setCurrentProgramFromDefinition(EOX6021ProgramDefinition* programDefinition);
    Q_INVOKABLE void turnOff();
    Q_INVOKABLE void setAlarm(int duration);
    Q_INVOKABLE void setAlarmIndex(int value);
    Q_INVOKABLE void setAlarmResetTime(int value);

    EOX6021Program* getCurrentProgram()
    {
        return m_currentProgram;
    }

    void setCurrentProgram(EOX6021Program* value)
    {
        m_currentProgram = value;
        emit currentProgramChanged();
    }

    int getWallClock()
    {
        return m_wallClock;
    }

    void setWallClock(int value)
    {
        m_wallClock = value;
        emit wallClockChanged();

        if(m_alarm_clock_running && m_alarmTime <= m_wallClock) {
            m_alarm_clock_running = false;
            alarmClockRunningChanged();
        }
    }

    qreal getMicrowavePower()
    {
        return m_microwavePower;
    }

    void setMicrowavePower(qreal value)
    {
        if(m_microwavePower != value) {
            m_microwavePower = value;
            m_microwave_last_change_time = m_wallClock;
            emit microwavePowerChanged();
        }
    }

    qreal getMicrowaveBoostThreshold()
    {
        return m_microwaveBoostThreshold;
    }

    qreal getCurrentTemperature()
    {
        return m_currentTemperature;
    }

    void setCurrentTemperature(qreal value)
    {
        if(m_currentTemperature != value) {
            m_currentTemperature = value;
            emit currentTemperatureChanged();
        }
    }

    std::vector<MicrowaveDegradationStep> getMicrowaveBoostSteps() {
        return m_microwave_boost_degredation_steps;
    }

    QString getCurrentDate()
    {
        return m_currentDate;
    }

    void setCurrentDate(QString date)
    {
        m_currentDate = date;
        emit currentDateChanged();
    }

    void triggerMealFlipMessage() {
        emit showMealFlipMessage();
    }

    void triggerTemperatureReachedMessage() {
        emit showPreheatingDoneMessage();
    }

    int getMicrowaveLastChangeTime() {
        return m_microwave_last_change_time;
    }

    Q_INVOKABLE int getAlarmIndex();

    Q_INVOKABLE int getAlarmResetTime();


signals:
    void ovenProgramsChanged();
    void breadProgramsChanged();
    void favoritesChanged();
    void cleaningProgramsChanged();
    void currentProgramChanged();
    void wallClockChanged();
    void currentTemperatureChanged();
    void fastForward();
    void currentDateChanged();
    void alarmClockRunningChanged();
    void alarmTimeChanged();
    void alarmIndexChanged();
    void alarmResetTimeChanged();
    void microwavePowerChanged();
    void microwaveBoostThresholdChanged();
    void microwaveProgramChanged();
    void showMealFlipMessage();
    void showPreheatingDoneMessage();

    void testOptionChanged();
    void displayBrightnessChanged();
    void standbyClockModeChanged();

private:
    GenericListModel* m_ovenPrograms {};
    GenericListModel* m_breadPrograms {};
    GenericListModel* m_cleaningPrograms {};
    EOX6021ProgramDefinition* m_microwaveProgram {};
    GenericListModel* m_favorites {};
    EOX6021Program* m_currentProgram {};
    OvenSimulation *ovenSimulation;
    QThread simulationThread;

    QString m_currentDate;
    int m_wallClock;
    qreal m_currentTemperature{21.0};
    qreal m_microwavePower{0};

    bool m_alarm_clock_active{false};
    bool m_alarm_clock_running{false};
    int m_alarmTime{-1};
    int m_alarmIndex;
    int m_alarmResetTime;

    std::vector<MicrowaveDegradationStep> m_microwave_boost_degredation_steps;
    int m_microwave_last_change_time{0};

    const qreal m_microwaveBoostThreshold {700.0};

    ProgramBooleanOption* m_testOption{};
    ProgramStringOption* m_displayBrightness{};
    ProgramStringOption* m_standbyClockMode{};
};

}

#endif // EOX6021_BACKEND_H
