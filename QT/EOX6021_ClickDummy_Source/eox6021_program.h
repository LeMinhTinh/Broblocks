#ifndef EOX6021_PROGRAM_H
#define EOX6021_PROGRAM_H

#include <QObject>

#include "eox6021_program_definition.h"

namespace BSH
{

class EOX6021Program : public QObject
{
    Q_OBJECT

    Q_PROPERTY(EOX6021ProgramDefinition* definition READ getDefinition WRITE setDefinition NOTIFY definitionChanged)
    Q_PROPERTY(ProgramStatus status READ getStatus WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(int startTime READ getStartTime WRITE setStartTime NOTIFY startTimeChanged)
    Q_PROPERTY(int remainingTime READ getRemainingTime WRITE setRemainingTime NOTIFY remainingTimeChanged)
    Q_PROPERTY(int waitingTime READ getWaitingTime WRITE setWaitingTime NOTIFY waitingTimeChanged)
    Q_PROPERTY(int initialWaitingTime READ getInitialWaitingTime MEMBER m_initialWaitingTime NOTIFY initialWaitingTimeChanged)

public:
    enum class ProgramStatus
    {
        INITIALIZED,
        WAITING,
        PREHEATING,
        HEATING,
        DONE,
        TERMINATED
    };
    Q_ENUM(ProgramStatus)

    explicit EOX6021Program(QObject *parent = nullptr) :
        EOX6021Program(new EOX6021ProgramDefinition(this), parent)
    {}

    explicit EOX6021Program(EOX6021ProgramDefinition* programDefinition, QObject *parent):
        QObject(parent)
    {
        setDefinition(programDefinition);
    }

    EOX6021ProgramDefinition* getDefinition()
    {
        return m_definition;
    }

    void setDefinition(EOX6021ProgramDefinition* value)
    {
        m_definition = value;

        if (m_definition) {
            connect(m_definition->getDuration(), &ProgramOption::isEnabledChanged, this, &EOX6021Program::handleDurationStatus, Qt::DirectConnection);
            handleDurationStatus();
        }

        emit definitionChanged();
    }

    ProgramStatus getStatus()
    {
        return m_status;
    }

    void setStatus(ProgramStatus value)
    {
        if(value != m_status) {
            m_status = value;
            emit statusChanged();
        }
    }

    int getStartTime()
    {
        return m_startTime;
    }

    Q_INVOKABLE void setStartTime(int value)
    {
        if(value != m_startTime) {
            m_startTime = value;
            emit startTimeChanged();
        }
    }

    int getRemainingTime()
    {
        return m_remainingTime;
    }

    Q_INVOKABLE void setRemainingTime(int value)
    {
        if(value != m_remainingTime) {
            m_remainingTime = value;
            emit remainingTimeChanged();
        }
    }

    int getInitialWaitingTime() {
        return m_initialWaitingTime;
    }

    int getWaitingTime() {
        return m_waitingTime;
    }

    Q_INVOKABLE void setWaitingTime(int value) {
        if(value != m_waitingTime) {
            m_waitingTime = value;
            emit waitingTimeChanged();
        }
    }

    Q_INVOKABLE bool isProgramRunning() {
        return m_status != ProgramStatus::INITIALIZED && m_status != ProgramStatus::DONE && m_status != ProgramStatus::TERMINATED;
    }

    void handleDurationStatus() {
        if (!m_definition->getDuration() || !m_definition->getDuration()->isEnabled()) {
            m_waitingTime = 0;
            emit waitingTimeChanged();
        }
    }

    bool isHeating() {
        return m_status == ProgramStatus::PREHEATING || m_status == ProgramStatus::HEATING;
    }

    ~EOX6021Program()
    {}

signals:
    void definitionChanged();
    void statusChanged();
    void startTimeChanged();
    void remainingTimeChanged();
    void waitingTimeChanged();
    void initialWaitingTimeChanged();
    void start();
    void resume();
    void terminate();

private:
    EOX6021ProgramDefinition* m_definition {};
    int m_startTime {0};
    int m_remainingTime {-1};
    int m_waitingTime {0};
    int m_initialWaitingTime {0};
    ProgramStatus m_status {ProgramStatus::INITIALIZED};
};

}

#endif // EOX6021_PROGRAM_H
