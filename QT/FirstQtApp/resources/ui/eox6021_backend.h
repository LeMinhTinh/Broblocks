//------------------------------------------
// Dummy backend for the click dummy.

#ifndef EOX6021_BACKEND_H
#define EOX6021_BACKEND_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QTime>
#include <QVariantList>

#include "generic_list_model.h"
#include "eox6021_program_definition.h"
#include "eox6021_program.h"
#include "eox6021_oven_simulation.h"

namespace BSH
{

class OvenSimulation;

class EOX6021BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(GenericListModel* ovenPrograms MEMBER m_ovenPrograms NOTIFY ovenProgramsChanged)
    Q_PROPERTY(GenericListModel* favorites MEMBER m_favorites NOTIFY favoritesChanged)
    Q_PROPERTY(EOX6021Program* currentProgram READ getCurrentProgram WRITE setCurrentProgram NOTIFY currentProgramChanged)
    Q_PROPERTY(int wallClock READ getWallClock WRITE setWallClock NOTIFY wallClockChanged)
    Q_PROPERTY(qreal currentTemperature READ getCurrentTemperature WRITE setCurrentTemperature NOTIFY currentTemperatureChanged)
    Q_PROPERTY(qreal currentSpinSpeed READ getCurrentSpinSpeed WRITE setCurrentSpinSpeed NOTIFY currentSpinSpeedChanged)

public:
    explicit EOX6021BackEnd(QObject *parent = nullptr);
    ~EOX6021BackEnd();
    Q_INVOKABLE EOX6021ProgramDefinition* getProgramDefinitionCopy(EOX6021ProgramDefinition* programDefinition);
    Q_INVOKABLE void setCurrentProgramFromDefinition(EOX6021ProgramDefinition* programDefinition);
    Q_INVOKABLE void turnOff();

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
    }

    qreal getCurrentTemperature()
    {
        return m_currentTemperature;
    }

    qreal getCurrentSpinSpeed()
    {
        return m_currentSpinSpeed;
    }

    void setCurrentTemperature(qreal value)
    {
        m_currentTemperature = value;
        emit currentTemperatureChanged();
    }

    void setCurrentSpinSpeed(qreal value)
    {
        m_currentSpinSpeed = value;
        emit currentSpinSpeedChanged();
    }

signals:
    void ovenProgramsChanged();
    void favoritesChanged();
    void currentProgramChanged();
    void wallClockChanged();
    void currentTemperatureChanged();
    void currentSpinSpeedChanged();
    void fastForward();

private:
    GenericListModel* m_ovenPrograms {};
    GenericListModel* m_favorites {};
    EOX6021Program* m_currentProgram {};
    OvenSimulation *ovenSimulation;
    QThread simulationThread;

    int m_wallClock;
    qreal m_currentTemperature;
    qreal m_currentSpinSpeed;
};

}

#endif // EOX6021_BACKEND_H
